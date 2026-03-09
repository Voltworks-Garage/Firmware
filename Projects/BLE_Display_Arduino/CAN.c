#include "can.h"


#include "driver/gpio.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "src/msg/messaging.h"


// #define LOG_LOCAL_LEVEL ESP_LOG_VERBOSE
// #define LOG_LOCAL_LEVEL ESP_LOG_INFO
// #define LOG_LOCAL_LEVEL ESP_LOG_DEBUG
// #define LOG_LOCAL_LEVEL ESP_LOG_WARN
// #define LOG_LOCAL_LEVEL ESP_LOG_ERROR
#define LOG_LOCAL_LEVEL ESP_LOG_NONE
#include "esp_log.h"
static const char* TAG = "myCAN";

#define LOG_TWAI_ERRORS 0


#define CAN_STBY GPIO_NUM_17

static TaskHandle_t RX_TaskHandle = NULL;
static QueueHandle_t q = NULL;

static CAN_message_S* RX_Mailboxes[CAN_RX_QUEUE_LEN]; // Array of POINTERS to CAN_message_S structures
static CAN_payload_S RX_Payloads[CAN_RX_QUEUE_LEN]; // Array of payloads for RX mailboxes
uint8_t CAN_messageStatuses[CAN_RX_QUEUE_LEN]; // Status flags for each mailbox
static uint8_t RX_MailboxCount = 0;

// Global timestamp tracking last received message (any ID)
static volatile uint32_t last_message_received_timestamp = 0;

// Transmission control flag
static volatile bool can_tx_enabled = true;

// Mutex for protecting shared mailbox data access
static portMUX_TYPE can_mux = portMUX_INITIALIZER_UNLOCKED;

// CAN receive task
static void CAN_RxTask(void* parameter);

void CAN_Init(void) {
  esp_log_level_set("myCAN", LOG_LOCAL_LEVEL); // This has to be here to take effect due to .c file type
  ESP_LOGI(TAG, "Initializing CAN...");
#ifdef LOG_TWAI_ERRORS
  esp_log_level_set("twai", ESP_LOG_DEBUG);
#endif
  gpio_set_direction(CAN_STBY, GPIO_MODE_OUTPUT);
  gpio_set_level(CAN_STBY, 0);

  q = xQueueCreate(10, sizeof(Message_t));

  MsgBus_Register(MODULE_CAN, q);

  // General configuration with custom queue sizes
  twai_general_config_t g_config = TWAI_GENERAL_CONFIG_DEFAULT(
    (gpio_num_t)CAN_TX_PIN,
    (gpio_num_t)CAN_RX_PIN,
    TWAI_MODE_NORMAL
  );

  // Override default queue sizes (default is 5 each)
  g_config.tx_queue_len = CAN_TX_QUEUE_LEN;
  g_config.rx_queue_len = CAN_RX_QUEUE_LEN;
  g_config.intr_flags = ESP_INTR_FLAG_LEVEL3;// | ESP_INTR_FLAG_IRAM; // put ISR in high priority
  // g_config.alerts_enabled = TWAI_ALERT_AND_LOG | TWAI_ALERT_ALL;

  // Timing configuration for 500kbit/s
  twai_timing_config_t t_config = TWAI_TIMING_CONFIG_500KBITS();

  // Filter to accept all CAN IDs (when both code and mask are 0, all frames accepted)
  twai_filter_config_t f_config = TWAI_FILTER_CONFIG_ACCEPT_ALL();

  // Install and start TWAI driver
  esp_err_t result = twai_driver_install(&g_config, &t_config, &f_config);
  if (result == ESP_OK) {
    ESP_LOGI(TAG, "TWAI driver installed");
  } else {
    ESP_LOGE(TAG, "Driver install failed: %d", result);
    return;
  }

  result = twai_start();
  if (result == ESP_OK) {
    ESP_LOGI(TAG, "TWAI started successfully");

    // Check driver status
    twai_status_info_t status;
    twai_get_status_info(&status);
    ESP_LOGI(TAG, "Driver state: %d, msgs_to_tx: %lu, msgs_to_rx: %lu, tx_err: %lu, rx_err: %lu",
             status.state, status.msgs_to_tx, status.msgs_to_rx,
             status.tx_error_counter, status.rx_error_counter);

    // Create CAN receive task
    CAN_CreateRxTask();
  } else {
    ESP_LOGE(TAG, "TWAI start failed: %d", result);
  }
}

void CAN_DeInit(){
  twai_stop();
  gpio_set_direction(CAN_STBY, GPIO_MODE_DISABLE);
  vTaskDelete(RX_TaskHandle);
  RX_TaskHandle = NULL;
}

// DBC-compatible write function (takes CAN_message_S pointer)
uint8_t CAN_write(CAN_message_S *msg) {
  // Check if transmission is enabled
  if (!can_tx_enabled) {
    return 0;  // Transmission disabled
  }

  if (msg == NULL || msg->payload == NULL) {
    return 0;  // Failure
  }

  uint8_t length = msg->dlc;
  if (length > 8) {
    length = 8;  // CAN message max length
  }

  twai_message_t message;
  message.identifier = msg->canID;
  message.data_length_code = length;
  message.flags = msg->canXID ? TWAI_MSG_FLAG_EXTD : TWAI_MSG_FLAG_NONE;

  // Copy payload data to message
  uint8_t* payload_data = (uint8_t*)msg->payload;
  for (int i = 0; i < length; i++) {
    message.data[i] = payload_data[i];
  }

  esp_err_t result = twai_transmit(&message, 0);

  // Log transmission failures for diagnostics
  if (result != ESP_OK) {
    ESP_LOGW(TAG, "TX failed ID=0x%03lX err=%d", msg->canID, result);

    // Check bus status to identify error conditions
    twai_status_info_t status;
    if (twai_get_status_info(&status) == ESP_OK) {
      ESP_LOGW(TAG, "Bus state=%d tx_err=%lu rx_err=%lu pending=%lu",
               status.state, status.tx_error_counter, status.rx_error_counter, status.msgs_to_tx);
    }
  }

  return (result == ESP_OK) ? 1 : 0;  // Return 1 for success, 0 for failure
}

// Helper function for simple CAN writes
bool CAN_write_simple(uint32_t id, uint8_t* data, uint8_t length) {
  // Check if transmission is enabled
  if (!can_tx_enabled) {
    return false;  // Transmission disabled
  }

  if (length > 8) {
    length = 8;  // CAN message max length
  }

  twai_message_t message;
  message.identifier = id;
  message.data_length_code = length;
  message.flags = TWAI_MSG_FLAG_NONE;

  for (int i = 0; i < length; i++) {
    message.data[i] = data[i];
  }

  esp_err_t result = twai_transmit(&message, 0);

  // Log transmission failures for diagnostics
  if (result != ESP_OK) {
    ESP_LOGW(TAG, "TX failed (simple) ID=0x%03lX err=%d", id, result);

    // Check bus status to identify error conditions
    twai_status_info_t status;
    if (twai_get_status_info(&status) == ESP_OK) {
      ESP_LOGW(TAG, "Bus state=%d tx_err=%lu rx_err=%lu pending=%lu",
               status.state, status.tx_error_counter, status.rx_error_counter, status.msgs_to_tx);
    }
  }

  return (result == ESP_OK);
}

bool CAN_ReceiveMessage(twai_message_t* message) {
  if (message == NULL) {
    return false;
  }

  esp_err_t result = twai_receive(message, pdMS_TO_TICKS(1));
  return (result == ESP_OK);
}

uint8_t CAN_configureMailbox(CAN_message_S * newMessage) {
  if (RX_MailboxCount < CAN_RX_QUEUE_LEN) {
    // Store pointer to the message struct (no copy!)
    RX_Mailboxes[RX_MailboxCount] = newMessage;

    // Set up payload and status pointers in the caller's struct
    newMessage->payload = &RX_Payloads[RX_MailboxCount];
    newMessage->canMessageStatus = &CAN_messageStatuses[RX_MailboxCount];

    ESP_LOGD(TAG, "Mailbox %d configured for ID=0x%03lX", RX_MailboxCount, newMessage->canID);
    RX_MailboxCount++;
    return 1; // Success
  }
  return 0; // Failure
}

void CAN_CreateRxTask(void) {
  ESP_LOGI(TAG, "Creating RX Task... Free heap: %lu bytes", esp_get_free_heap_size());

  BaseType_t result = xTaskCreate(
    CAN_RxTask,
    "CAN_RxTask",
    4096,
    NULL,
    configMAX_PRIORITIES-2,
    &RX_TaskHandle
  );

  if (result == pdPASS) {
    ESP_LOGI(TAG, "RX Task created successfully");
  } else {
    ESP_LOGE(TAG, "Failed to create RX Task! result=%d, free heap: %lu", result, esp_get_free_heap_size());
  }
}

static void CAN_RxTask(void* parameter) {
  ESP_LOGI(TAG, "RX Task started");

  // Small delay to let system stabilize
  vTaskDelay(pdMS_TO_TICKS(100));

  ESP_LOGI(TAG, "RX Task waiting for messages... Configured mailboxes: %d", RX_MailboxCount);

  twai_message_t message;
  uint32_t loop_count = 0;

  while (1) {

    // Update global timestamp for ANY message received
    uint32_t last_message_received_timestamp_temp = pdTICKS_TO_MS(xTaskGetTickCount());

    esp_err_t result = twai_receive(&message, pdMS_TO_TICKS(1));

    if (result == ESP_OK) {
      last_message_received_timestamp = last_message_received_timestamp_temp;
      // ESP_LOGI(TAG, "RX: ID=0x%03lX, DLC=%d, Data=%02X %02X %02X %02X %02X %02X %02X %02X",
      //               message.identifier, message.data_length_code,
      //               message.data[0], message.data[1], message.data[2], message.data[3],
      //               message.data[4], message.data[5], message.data[6], message.data[7]);

      // Linear search through RX mailboxes to find matching CAN ID
      bool found = false;
      for (uint8_t i = 0; i < RX_MailboxCount; i++) {
        if (RX_Mailboxes[i]->canID == message.identifier) {
          // Match found - copy data to mailbox payload
          if (RX_Mailboxes[i]->payload != NULL) {
            // Enter critical section to protect shared data
            taskENTER_CRITICAL(&can_mux);

            // Copy message data into the payload structure, must cast to uint8_t*
            uint8_t* data = (uint8_t*)RX_Mailboxes[i]->payload;
            for (uint8_t j = 0; j < message.data_length_code && j < 8; j++) {
              data[j] = message.data[j];
            }

            // Update message status and timestamp
            if (RX_Mailboxes[i]->canMessageStatus != NULL) {
              *RX_Mailboxes[i]->canMessageStatus = 1; // Mark as received
            }
            RX_Mailboxes[i]->last_received_timestamp = last_message_received_timestamp;

            // Call user callback if registered (inside critical section to protect payload)
            if (RX_Mailboxes[i]->rx_callback != NULL) {
              RX_Mailboxes[i]->rx_callback(RX_Mailboxes[i]);
            }

            taskEXIT_CRITICAL(&can_mux);

            // ESP_LOGD(TAG, "Matched mailbox %d time: %lu", i, last_message_received_timestamp);
            found = true;
          }
          break;
        }
      }

      if (!found) {
        // ESP_LOGW(TAG, "No mailbox configured for ID 0x%03lX", message.identifier);
      }
    } else if (result != ESP_ERR_TIMEOUT) {
      // Log errors other than timeout (timeout is normal when no messages)
      // ESP_LOGE(TAG, "Receive error: %d", result);
    }
  }
}

void CAN_timeStampFunc(CAN_GetTimestamp_t timestamp_func){
  // Function not used in esp32 because we use FreeRTOS ticks
  return;
}

uint8_t CAN_checkDataIsStale(CAN_message_S * data, uint32_t timeout_ms){
  if (data == NULL) {
    return 1; // Consider null data as stale
  } else {
    uint32_t current_time = pdTICKS_TO_MS(xTaskGetTickCount());
    if (current_time - data->last_received_timestamp > timeout_ms) {
      return 1; // Data is stale
    }
  }
  return 0;
}

uint32_t CAN_getTimeSinceLastReceived(CAN_message_S * data){
  if (data == NULL) {
    return 0xFFFFFFFF; // Indicate error with max value
  }
  uint32_t current_time = pdTICKS_TO_MS(xTaskGetTickCount());
  uint32_t last_time = data->last_received_timestamp;
  if (current_time >= last_time) {
    return current_time - last_time;
  } else {
    return last_time - current_time; // Handle wrap-around
  }
  return 0;
}

uint8_t CAN_checkDataIsUnread(CAN_message_S * data) {
    uint8_t ret;
    taskENTER_CRITICAL(&can_mux);
    ret = *(data->canMessageStatus);
    *(data->canMessageStatus) = 0;
    taskEXIT_CRITICAL(&can_mux);
    return ret;
}

uint32_t CAN_timeSinceLastMessageReceived(void) {
    uint32_t current_time = pdTICKS_TO_MS(xTaskGetTickCount());
    ESP_LOGI(TAG, "CAN current time: %lu", current_time);
    ESP_LOGI(TAG, "CAN last message received time: %lu", last_message_received_timestamp);

    uint32_t delta = current_time - last_message_received_timestamp;
    ESP_LOGI(TAG, "CAN time since last message received: %lu ms", delta);

    // If no messages received yet, return max value
    if (last_message_received_timestamp == 0) {
      ESP_LOGW(TAG, "No CAN messages received yet");
      return 0xFFFFFFFF;
    }

    // Unsigned subtraction naturally handles wrap-around
    return delta;
}

void CAN_setMode(CAN_Mode_t mode) {
    switch (mode) {
        case CAN_NORMAL_MODE:
            can_tx_enabled = true;
            ESP_LOGI(TAG, "CAN normal mode enabled (TX enabled)");
            break;

        case CAN_LISTEN_MODE:
            can_tx_enabled = false;
            ESP_LOGI(TAG, "CAN listen-only mode enabled (TX disabled, ACKs still sent)");
            break;

        default:
            ESP_LOGW(TAG, "Invalid CAN mode: %d", mode);
            break;
    }
}