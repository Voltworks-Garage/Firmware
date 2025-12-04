#include "ble_module.h"

#include "esp_log.h"
#include "nimble/nimble_port.h"
#include "nimble/nimble_port_freertos.h"
#include "host/ble_hs.h"
#include "host/ble_uuid.h"
#include "host/util/util.h"
#include "services/gap/ble_svc_gap.h"
#include "services/gatt/ble_svc_gatt.h"
#include "nvs_flash.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/queue.h"
#include "freertos/semphr.h"

static const char* TAG = "BLE";

// UART Service UUIDs (Nordic UART Service)
static const ble_uuid128_t UART_SERVICE_UUID =
    BLE_UUID128_INIT(0x9e, 0xca, 0xdc, 0x24, 0x0e, 0xe5, 0xa9, 0xe0,
                     0x93, 0xf3, 0xa3, 0xb5, 0x01, 0x00, 0x40, 0x6e);
static const ble_uuid128_t UART_RX_CHAR_UUID =
    BLE_UUID128_INIT(0x9e, 0xca, 0xdc, 0x24, 0x0e, 0xe5, 0xa9, 0xe0,
                     0x93, 0xf3, 0xa3, 0xb5, 0x02, 0x00, 0x40, 0x6e);
static const ble_uuid128_t UART_TX_CHAR_UUID =
    BLE_UUID128_INIT(0x9e, 0xca, 0xdc, 0x24, 0x0e, 0xe5, 0xa9, 0xe0,
                     0x93, 0xf3, 0xa3, 0xb5, 0x03, 0x00, 0x40, 0x6e);

// HM-10 Service UUIDs
#define HM10_SERVICE_UUID  0xFFE0
#define HM10_CHAR_UUID     0xFFE1

// UART TX Queue configuration
#define UART_TX_QUEUE_SIZE          64
#define UART_TX_MAX_MESSAGE_LEN     128

// UART TX message structure
typedef struct {
    uint8_t message[UART_TX_MAX_MESSAGE_LEN];
    const uint8_t* data_pointer;
    uint16_t length;
} uart_tx_message_t;

// Module state
static bool device_connected = false;
static uint16_t conn_handle = 0;
static uint16_t mtu_size = 23;
static uint16_t uart_tx_handle = 0;
static uint16_t hm10_char_handle = 0;
static bool whitelist_enabled = false;

// Callbacks
static void (*uart_rx_callback)(const uint8_t* data, uint16_t len) = NULL;
static void (*hm10_rx_callback)(const uint8_t* data, uint16_t len) = NULL;

// UART TX Queue
static QueueHandle_t uart_tx_queue = NULL;
static uart_tx_message_t current_tx_message;
static SemaphoreHandle_t tx_semaphore = NULL;

// Statistics
static uint32_t tx_queue_drops = 0;
static uint32_t tx_messages_sent = 0;
static uint32_t tx_bytes_sent = 0;

// Forward declarations
static void ble_send_uart_packet(void);
static int ble_gap_event(struct ble_gap_event *event, void *arg);
static int uart_rx_char_access(uint16_t conn_handle, uint16_t attr_handle,
                                struct ble_gatt_access_ctxt *ctxt, void *arg);
static int uart_tx_char_access(uint16_t conn_handle, uint16_t attr_handle,
                                struct ble_gatt_access_ctxt *ctxt, void *arg);
static int hm10_char_access(uint16_t conn_handle, uint16_t attr_handle,
                            struct ble_gatt_access_ctxt *ctxt, void *arg);

// GATT Service Definitions
static const struct ble_gatt_svc_def gatt_svcs[] = {
    // UART Service
    {
        .type = BLE_GATT_SVC_TYPE_PRIMARY,
        .uuid = &UART_SERVICE_UUID.u,
        .characteristics = (struct ble_gatt_chr_def[]) {
            {
                // UART RX Characteristic (write from client)
                .uuid = &UART_RX_CHAR_UUID.u,
                .access_cb = uart_rx_char_access,
                .flags = BLE_GATT_CHR_F_WRITE,  // Removed encryption for testing
            },
            {
                // UART TX Characteristic (notify to client)
                .uuid = &UART_TX_CHAR_UUID.u,
                .access_cb = uart_tx_char_access,
                .val_handle = &uart_tx_handle,
                .flags = BLE_GATT_CHR_F_NOTIFY | BLE_GATT_CHR_F_READ,  // Removed encryption for testing
            },
            {0}  // No more characteristics
        }
    },

    // HM-10 Service
    {
        .type = BLE_GATT_SVC_TYPE_PRIMARY,
        .uuid = BLE_UUID16_DECLARE(HM10_SERVICE_UUID),
        .characteristics = (struct ble_gatt_chr_def[]) {
            {
                .uuid = BLE_UUID16_DECLARE(HM10_CHAR_UUID),
                .access_cb = hm10_char_access,
                .val_handle = &hm10_char_handle,
                .flags = BLE_GATT_CHR_F_READ | BLE_GATT_CHR_F_WRITE |
                         BLE_GATT_CHR_F_NOTIFY | BLE_GATT_CHR_F_INDICATE,
            },
            {0}
        }
    },

    {0}  // No more services
};

// UART RX characteristic callback
static int uart_rx_char_access(uint16_t conn_handle, uint16_t attr_handle,
                                struct ble_gatt_access_ctxt *ctxt, void *arg) {
    if (ctxt->op == BLE_GATT_ACCESS_OP_WRITE_CHR) {
        uint16_t len = OS_MBUF_PKTLEN(ctxt->om);
        uint8_t data[len];

        // Copy data from mbuf chain
        ble_hs_mbuf_to_flat(ctxt->om, data, len, NULL);

        ESP_LOGI(TAG, "[UART] RX %d bytes", len);

        // Call user callback
        if (uart_rx_callback != NULL) {
            uart_rx_callback(data, len);
        }
    }
    return 0;
}

// UART TX characteristic callback
static int uart_tx_char_access(uint16_t conn_handle, uint16_t attr_handle,
                                struct ble_gatt_access_ctxt *ctxt, void *arg) {
    // Read operations return empty (notifications handle data sending)
    if (ctxt->op == BLE_GATT_ACCESS_OP_READ_CHR) {
        return 0;
    }
    return BLE_ATT_ERR_UNLIKELY;
}

// HM-10 characteristic callback
static int hm10_char_access(uint16_t conn_handle, uint16_t attr_handle,
                            struct ble_gatt_access_ctxt *ctxt, void *arg) {
    if (ctxt->op == BLE_GATT_ACCESS_OP_WRITE_CHR) {
        uint16_t len = OS_MBUF_PKTLEN(ctxt->om);
        uint8_t data[len];

        ble_hs_mbuf_to_flat(ctxt->om, data, len, NULL);

        ESP_LOGI(TAG, "[HM10] RX %d bytes", len);

        // Call user callback
        if (hm10_rx_callback != NULL) {
            hm10_rx_callback(data, len);
        }
    } else if (ctxt->op == BLE_GATT_ACCESS_OP_READ_CHR) {
        // Return empty for reads
        return 0;
    }
    return 0;
}

// GAP event handler
static int ble_gap_event(struct ble_gap_event *event, void *arg) {
    switch (event->type) {
        case BLE_GAP_EVENT_CONNECT:
            ESP_LOGI(TAG, "Connection %s; status=%d",
                     event->connect.status == 0 ? "established" : "failed",
                     event->connect.status);

            if (event->connect.status == 0) {
                device_connected = true;
                conn_handle = event->connect.conn_handle;

                // Clear TX queue on connect
                xQueueReset(uart_tx_queue);
                xSemaphoreTake(tx_semaphore, 0);
                xSemaphoreGive(tx_semaphore);

                // Get MTU
                mtu_size = ble_att_mtu(conn_handle);
                ESP_LOGI(TAG, "Current MTU: %d bytes", mtu_size);
            } else {
                // Connection failed, resume advertising
                ble_gap_adv_start(BLE_OWN_ADDR_PUBLIC, NULL, BLE_HS_FOREVER,
                                  NULL, ble_gap_event, NULL);
            }
            break;

        case BLE_GAP_EVENT_DISCONNECT:
            ESP_LOGI(TAG, "Disconnect; reason=%d", event->disconnect.reason);
            device_connected = false;
            conn_handle = 0;

            // Clear TX queue
            xQueueReset(uart_tx_queue);
            xSemaphoreGive(tx_semaphore);

            // Resume advertising
            ble_gap_adv_start(BLE_OWN_ADDR_PUBLIC, NULL, BLE_HS_FOREVER,
                              NULL, ble_gap_event, NULL);
            break;

        case BLE_GAP_EVENT_MTU:
            mtu_size = event->mtu.value;
            ESP_LOGI(TAG, "MTU updated to: %d bytes", mtu_size);
            break;

        case BLE_GAP_EVENT_ENC_CHANGE:
            ESP_LOGI(TAG, "Encryption change event; status=%d",
                     event->enc_change.status);
            break;

        case BLE_GAP_EVENT_SUBSCRIBE:
            ESP_LOGI(TAG, "Subscribe event; handle=%d", event->subscribe.attr_handle);
            break;

        case BLE_GAP_EVENT_NOTIFY_TX:
            ESP_LOGD(TAG, "Notify TX complete; status=%d", event->notify_tx.status);
            // Send next chunk
            ble_send_uart_packet();
            break;
    }

    return 0;
}

// Start advertising
static void ble_app_advertise(void) {

    // Local variable declarations
    struct ble_gap_adv_params adv_params;
    struct ble_hs_adv_fields fields;
    const char *name = "ZACH_testing_BLE";

    // Set advertising fields
    memset(&fields, 0, sizeof(fields));
    fields.flags = BLE_HS_ADV_F_DISC_GEN | BLE_HS_ADV_F_BREDR_UNSUP;
    fields.name = (uint8_t *)name;
    fields.name_len = strlen(name);
    fields.name_is_complete = 1;
    fields.uuids16 = (ble_uuid16_t[]) {
        BLE_UUID16_INIT(HM10_SERVICE_UUID)
    };
    fields.num_uuids16 = 1;
    fields.uuids16_is_complete = 1;

    // Set advertising parameters
    memset(&adv_params, 0, sizeof(adv_params));
    adv_params.conn_mode = BLE_GAP_CONN_MODE_UND;
    adv_params.disc_mode = BLE_GAP_DISC_MODE_GEN;

    int rc;

    // Set advertising fields with NimBLE API
    rc = ble_gap_adv_set_fields(&fields);
    if (rc != 0) {
        ESP_LOGE(TAG, "Error setting advertisement data; rc=%d", rc);
        return;
    }

    // Start advertising with NimBLE API
    rc = ble_gap_adv_start(BLE_OWN_ADDR_PUBLIC, NULL, BLE_HS_FOREVER,
                           &adv_params, ble_gap_event, NULL);
    if (rc != 0) {
        ESP_LOGE(TAG, "Error enabling advertisement; rc=%d", rc);
        return;
    }

    ESP_LOGI(TAG, "Device advertising. Ready to connect!");
}

// NimBLE host task
static void ble_host_task(void *param) {
    ESP_LOGI(TAG, "BLE Host Task Started");
    nimble_port_run();
    nimble_port_freertos_deinit();
}

// On sync callback
static void ble_on_sync(void) {
    ESP_LOGI(TAG, "BLE stack synchronized");

    // Start advertising
    ble_app_advertise();
}

// On reset callback
static void ble_on_reset(int reason) {
    ESP_LOGE(TAG, "Resetting state; reason=%d", reason);
}

static void ble_send_uart_packet(void) {
    if (!device_connected) {
        return;
    }

    // Check if there's data to send
    if (current_tx_message.length == 0) {
        // Try to get next message from queue
        if (xQueueReceive(uart_tx_queue, &current_tx_message, 0) == pdTRUE) {
            current_tx_message.data_pointer = current_tx_message.message;
        } else {
            // No more messages, release semaphore
            xSemaphoreGive(tx_semaphore);
            ESP_LOGD(TAG, "[UART] All messages sent");
            return;
        }
    }

    // Calculate chunk size
    uint16_t chunk_size = current_tx_message.length > (mtu_size - 3) ?
                          (mtu_size - 3) : current_tx_message.length;

    // Create mbuf for notification
    struct os_mbuf *om = ble_hs_mbuf_from_flat(current_tx_message.data_pointer, chunk_size);

    if (om == NULL) {
        ESP_LOGW(TAG, "[UART] Failed to allocate mbuf");
        xSemaphoreGive(tx_semaphore);
        return;
    }

    // Update state
    current_tx_message.data_pointer += chunk_size;
    current_tx_message.length -= chunk_size;

    // Send notification
    int rc = ble_gattc_notify_custom(conn_handle, uart_tx_handle, om);

    if (rc != 0) {
        ESP_LOGW(TAG, "[UART] Notify failed: %d", rc);
        xSemaphoreGive(tx_semaphore);
    } else {
        ESP_LOGD(TAG, "[UART] Sent %d bytes, %d remaining", chunk_size, current_tx_message.length);
    }
}

// Public API implementations
void BLE_Init(void) {
    esp_log_level_set(TAG, ESP_LOG_INFO);
    ESP_LOGI(TAG, "Initializing BLE...");

    // Initialize NVS
    esp_err_t ret = nvs_flash_init();
    if (ret == ESP_ERR_NVS_NO_FREE_PAGES || ret == ESP_ERR_NVS_NEW_VERSION_FOUND) {
        ESP_ERROR_CHECK(nvs_flash_erase());
        ret = nvs_flash_init();
    }
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "Failed to initialize NVS flash, error code: %d", ret);
        return;
    }

    // Initialize NimBLE stack
    ret = nimble_port_init();
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "Failed to initialize NimBLE stack, error code: %d", ret);
        return;
    }

    // Initialize the NimBLE host configuration
    ble_hs_cfg.sync_cb = ble_on_sync;
    ble_hs_cfg.reset_cb = ble_on_reset;

    // Set device name
    ble_svc_gap_device_name_set("ESP32-S3(Begode)");

    // Initialize GATT services
    ble_svc_gap_init();
    ble_svc_gatt_init();

    // Register custom services
    int rc = ble_gatts_count_cfg(gatt_svcs);
    if (rc != 0) {
        ESP_LOGE(TAG, "Error configuring GATT services; rc=%d", rc);
        return;
    }

    rc = ble_gatts_add_svcs(gatt_svcs);
    if (rc != 0) {
        ESP_LOGE(TAG, "Error adding GATT services; rc=%d", rc);
        return;
    }

    // Create TX queue and semaphore
    uart_tx_queue = xQueueCreate(UART_TX_QUEUE_SIZE, sizeof(uart_tx_message_t));
    tx_semaphore = xSemaphoreCreateBinary();
    xSemaphoreGive(tx_semaphore);

    // Start NimBLE host task
    nimble_port_freertos_init(ble_host_task);

    ESP_LOGI(TAG, "BLE initialization complete");
}

void BLE_SendUartData(const uint8_t* data, uint16_t length) {
    if (!device_connected) {
        return;
    }

    // Create message
    uart_tx_message_t new_message;
    uint16_t len = length;
    if (len >= UART_TX_MAX_MESSAGE_LEN) {
        len = UART_TX_MAX_MESSAGE_LEN - 1;
        ESP_LOGW(TAG, "Message truncated to %d bytes", len);
    }

    memcpy(new_message.message, data, len);
    new_message.length = len;
    new_message.data_pointer = new_message.message;

    // Enqueue
    if (xQueueSend(uart_tx_queue, &new_message, 0) != pdTRUE) {
        tx_queue_drops++;
        ESP_LOGW(TAG, "[UART] TX queue full - dropped! (total: %lu)", tx_queue_drops);
        return;
    }

    tx_messages_sent++;
    tx_bytes_sent += len;

    // Try to send immediately
    if (xSemaphoreTake(tx_semaphore, 0) == pdTRUE) {
        if (xQueueReceive(uart_tx_queue, &current_tx_message, 0)) {
            current_tx_message.data_pointer = current_tx_message.message;
            ble_send_uart_packet();
        }
    }
}

void BLE_SetUartCallback(void (*callback)(const uint8_t* data, uint16_t len)) {
    uart_rx_callback = callback;
}

void BLE_SendHM10Data(const uint8_t* data, uint16_t len) {
    if (!device_connected) {
        return;
    }

    while (len > 0) {
        uint16_t chunk_size = len > (mtu_size - 3) ? (mtu_size - 3) : len;

        struct os_mbuf *om = ble_hs_mbuf_from_flat(data, chunk_size);
        if (om == NULL) {
            ESP_LOGW(TAG, "[HM10] Failed to allocate mbuf");
            return;
        }

        int rc = ble_gattc_notify_custom(conn_handle, hm10_char_handle, om);
        if (rc != 0) {
            ESP_LOGW(TAG, "[HM10] Notify failed: %d", rc);
        } else {
            ESP_LOGD(TAG, "[HM10] Sent %d bytes", chunk_size);
        }

        data += chunk_size;
        len -= chunk_size;
    }
}

void BLE_SetHM10Callback(void (*callback)(const uint8_t* data, uint16_t len)) {
    hm10_rx_callback = callback;
}

bool BLE_IsConnected(void) {
    return device_connected;
}

int BLE_GetBondedDeviceCount(void) {
    // TODO: Implement bonding count using ble_store API
    return 0;  // Placeholder - bonding not fully implemented yet
}

void BLE_ClearAllBonds(void) {
    ESP_LOGI(TAG, "Clearing bonds - not implemented yet");
}

void BLE_PrintBondedDevices(void) {
    ESP_LOGI(TAG, "Bonded devices: not implemented yet");
}

void BLE_AllowNewDevices(void) {
    whitelist_enabled = false;
    ESP_LOGI(TAG, "Whitelist disabled");
}

void BLE_RestrictToBonded(void) {
    whitelist_enabled = true;
    ESP_LOGI(TAG, "Whitelist enabled");
}

void BLE_PopulateWhitelist(void) {
    ESP_LOGI(TAG, "Populate whitelist - not implemented yet");
}
