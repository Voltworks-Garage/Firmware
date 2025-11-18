#include "can_module.h"

#include "esp_twai_onchip.h"
#include "esp_log.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/queue.h"
// #include "../../../CAN/generated/dash_can_decoder.h"

static const char *TAG = "CAN";

// Structure to store complete frame in queue
typedef struct {
    twai_frame_t frame;     // Frame metadata and buffer pointer
    uint8_t data[8];        // Embedded data buffer
} can_rx_queue_item_t;

// CAN node handle
static twai_node_handle_t can_handle = NULL;

// RX queue
static QueueHandle_t rx_queue = NULL;
#define CAN_RX_QUEUE_LEN 10

// Function prototypes
static bool CAN_RxCallBack(twai_node_handle_t handle, const twai_rx_done_event_data_t *edata, void *user_ctx);
static void CAN_RxTask(void* parameter);

void CAN_Init(void) {
  ESP_LOGI(TAG, "Initializing...");

  // Configure the TWAI onchip node
  twai_onchip_node_config_t config = {
    .io_cfg = {
      .tx = CAN_TX_PIN,
      .rx = CAN_RX_PIN,
    },
    .bit_timing = {
      .bitrate = 500000,  // 500 kbps
    },
    .tx_queue_depth = CAN_TX_QUEUE_LEN,
  };

  // Create TWAI node
  esp_err_t result = twai_new_node_onchip(&config, &can_handle);
  if (result == ESP_OK) {
    ESP_LOGI(TAG, "TWAI node created");
  } else {
    ESP_LOGE(TAG, "Failed to create TWAI node: %s", esp_err_to_name(result));
    return;
  }

  // Configure acceptance filter (accept only ID 0x123)
  twai_mask_filter_config_t filter_config = {
    .id = 0x123,
    .mask = 0x7FF,  // Standard 11-bit ID mask
    .is_ext = false,
  };

  result = twai_node_config_mask_filter(can_handle, 0, &filter_config);
  if (result == ESP_OK) {
    ESP_LOGI(TAG, "Filter configured");
  } else {
    ESP_LOGW(TAG, "Failed to configure filter: %s", esp_err_to_name(result));
  }

  //register the recieve callback
  twai_event_callbacks_t user_cbs = {
    .on_rx_done = CAN_RxCallBack,
  };
  ESP_ERROR_CHECK(twai_node_register_event_callbacks(can_handle, &user_cbs, NULL));

    // Create RX queue
  rx_queue = xQueueCreate(CAN_RX_QUEUE_LEN, sizeof(can_rx_queue_item_t));
  if (rx_queue == NULL) {
    ESP_LOGE(TAG, "Failed to create RX queue");
    return;
  }
  ESP_LOGI(TAG, "RX queue created (depth=%d)", CAN_RX_QUEUE_LEN);

  // Create RX processing task
  xTaskCreate(
        CAN_RxTask,
        "CAN_RxTask",
        4096,           // Stack size
        NULL,           // No parameters
        5,              // Priority
        NULL            // No task handle needed
  );
  ESP_LOGI(TAG, "RX processing task created");

  // Enable the TWAI node (start)
  result = twai_node_enable(can_handle);
  if (result == ESP_OK) {
    ESP_LOGI(TAG, "TWAI node enabled successfully");
  } else {
    ESP_LOGE(TAG, "Failed to enable TWAI node: %s", esp_err_to_name(result));
  }
}

void CAN_Deinit(void) {
  if (can_handle != NULL) {
    ESP_LOGI(TAG, "Deinitializing...");
    twai_node_disable(can_handle);
    twai_node_delete(can_handle);
    can_handle = NULL;
  }

  // Delete queue
  if (rx_queue != NULL) {
    vQueueDelete(rx_queue);
    rx_queue = NULL;
    ESP_LOGI(TAG, "RX queue deleted");
  }

  ESP_LOGI(TAG, "Deinitialization complete");
}

bool CAN_write(uint32_t id, uint8_t* data, uint8_t length) {
  if (can_handle == NULL) {
    ESP_LOGE(TAG, "CAN not initialized");
    return false;
  }

  if (length > 8) {
    length = 8;  // CAN classic message max length
  }

  // Prepare TWAI frame
  twai_frame_t frame = {
    .header = {
      .id = id,
      .ide = false,  // Standard 11-bit ID
      .rtr = false,  // Data frame (not remote)
      .dlc = length,
    },
    .buffer = data,
    .buffer_len = length,
  };

  esp_err_t result = twai_node_transmit(can_handle, &frame, 0);
  if (result != ESP_OK) {
    ESP_LOGW(TAG, "Failed to transmit: %s", esp_err_to_name(result));
  }
  return (result == ESP_OK);
}

static bool CAN_RxCallBack(twai_node_handle_t handle, const twai_rx_done_event_data_t *edata, void *user_ctx)
{
    can_rx_queue_item_t queue_item;

    // Point frame buffer to embedded data array
    queue_item.frame.buffer = queue_item.data;
    queue_item.frame.buffer_len = sizeof(queue_item.data);

    if (ESP_OK == twai_node_receive_from_isr(handle, &queue_item.frame)) {
        // Frame received successfully, send to queue
        BaseType_t higher_priority_task_woken = pdFALSE;
        if (xQueueSendFromISR(rx_queue, &queue_item, &higher_priority_task_woken) != pdTRUE) {
            // Queue full - drop message (could add error counter here)
        }

        return higher_priority_task_woken == pdTRUE;
    }
    return false;
}

static void CAN_RxTask(void* parameter) {
    can_rx_queue_item_t rx_item;

    ESP_LOGI(TAG, "RX processing task started");

    while (1) {
        // Wait for frame from queue (blocking, infinite timeout)
        if (xQueueReceive(rx_queue, &rx_item, portMAX_DELAY) == pdTRUE) {
            // Log received frame
            ESP_LOGI(TAG, "RX: ID=0x%03lX, DLC=%d, Data:",
                     rx_item.frame.header.id, rx_item.frame.header.dlc);

            // Print data bytes (data is in rx_item.data[])
            for (int i = 0; i < rx_item.frame.header.dlc && i < 8; i++) {
                printf("%02X ", rx_item.data[i]);
            }
            printf("\n");

            // Future: Decode messages when decoder is integrated
            // switch (rx_item.frame.header.id) {
            //     case CAN_ID_MCU_STATUS:
            //         CAN_Decode_mcu_status(&rx_item.frame, &mcu_status);
            //         break;
            //     case CAN_ID_BMS_STATUS:
            //         CAN_Decode_bms_status(&rx_item.frame, &bms_status);
            //         break;
            //     default:
            //         // Already logged above
            //         break;
            // }
        }
    }
}

void CAN_CreateRxTask(void) {
    xTaskCreate(
        CAN_RxTask,
        "CAN_RxTask",
        4096,           // Stack size
        NULL,           // No parameters
        5,              // Priority
        NULL            // No task handle needed
    );
    ESP_LOGI(TAG, "RX processing task created");
}