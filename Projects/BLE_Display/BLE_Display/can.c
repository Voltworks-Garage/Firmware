#include "can.h"
#include "esp_log.h"
#include "driver/gpio.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

static const char* TAG = "CAN";

#define CAN_STBY GPIO_NUM_17

TaskHandle_t RX_TaskHandle = NULL;

static CAN_message_S RX_Mailboxes[CAN_RX_QUEUE_LEN]; // Array of CAN_message_S structures for RX mailboxes
static CAN_payload_S RX_Payloads[CAN_RX_QUEUE_LEN]; // Array of payloads for RX mailboxes
uint8_t CAN_messageStatuses[CAN_RX_QUEUE_LEN]; // Status flags for each mailbox
static uint8_t RX_MailboxCount = 0;

// CAN receive task
static void CAN_RxTask(void* parameter);

void CAN_Init(void) {
  ESP_LOGI(TAG, "Initializing...");
  gpio_set_direction(CAN_STBY, GPIO_MODE_OUTPUT);
  gpio_set_level(CAN_STBY, 0);

  // General configuration with custom queue sizes
  twai_general_config_t g_config = TWAI_GENERAL_CONFIG_DEFAULT(
    (gpio_num_t)CAN_TX_PIN,
    (gpio_num_t)CAN_RX_PIN,
    TWAI_MODE_NORMAL
  );

  // Override default queue sizes (default is 5 each)
  g_config.tx_queue_len = CAN_TX_QUEUE_LEN;
  g_config.rx_queue_len = CAN_RX_QUEUE_LEN;

  // Timing configuration for 500kbit/s
  twai_timing_config_t t_config = TWAI_TIMING_CONFIG_500KBITS();

  // Filter to accept only ID 0x123
  twai_filter_config_t f_config = {
    .acceptance_code = 0x00000000,//(0x388 << 21),  // ID in upper 11 bits for standard
    .acceptance_mask = 0xFFFFFFFF,//~(0x7FF << 21), // Mask all 11 bits (standard ID)
    .single_filter = true
  };

  // Install and start TWAI driver
  esp_err_t result = twai_driver_install(&g_config, &t_config, &f_config);
  if (result == ESP_OK) {
    ESP_LOGI(TAG, "Driver installed");
  } else {
    ESP_LOGE(TAG, "Driver install failed: %d", result);
    return;
  }

  result = twai_start();
  if (result == ESP_OK) {
    ESP_LOGI(TAG, "Started successfully");
    // Create CAN receive task
    CAN_CreateRxTask();
  } else {
    ESP_LOGE(TAG, "Start failed: %d", result);
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
  return (result == ESP_OK) ? 1 : 0;  // Return 1 for success, 0 for failure
}

// Helper function for simple CAN writes
bool CAN_write_simple(uint32_t id, uint8_t* data, uint8_t length) {
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
    RX_Mailboxes[RX_MailboxCount] = *newMessage;
    newMessage->payload = &RX_Payloads[RX_MailboxCount];
    newMessage->canMessageStatus = &CAN_messageStatuses[RX_MailboxCount];
    RX_MailboxCount++;
    return 1; // Success
  }
  return 0; // Failure
}

void CAN_CreateRxTask(void) {
  xTaskCreate(
    CAN_RxTask,
    "CAN_RxTask",
    4096,
    NULL,
    1,
    &RX_TaskHandle
  );
}

static void CAN_RxTask(void* parameter) {
  twai_message_t message;

  while (1) {
    if (CAN_ReceiveMessage(&message)) { //Built in 1ms delay if no messages received
      // Linear search through RX mailboxes to find matching CAN ID
      bool found = false;
      for (uint8_t i = 0; i < RX_MailboxCount; i++) {
        if (RX_Mailboxes[i].canID == message.identifier) {
          // Match found - copy data to mailbox payload
          if (RX_Mailboxes[i].payload != NULL) {
            // Copy message data into the payload structure
            uint8_t* data = (uint8_t*)RX_Mailboxes[i].payload;
            for (uint8_t j = 0; j < message.data_length_code && j < 8; j++) {
              data[j] = message.data[j];
            }

            // Update message status and timestamp
            if (RX_Mailboxes[i].canMessageStatus != NULL) {
              *RX_Mailboxes[i].canMessageStatus = 1; // Mark as received
            }
            RX_Mailboxes[i].last_received_timestamp = pdTICKS_TO_MS(xTaskGetTickCount());

            ESP_LOGD(TAG, "RX ID=0x%03X matched mailbox %d", message.identifier, i);
            found = true;
          }
          break;
        }
      }

      if (!found) {
        // No matching mailbox - log unknown message
        ESP_LOGD(TAG, "Unknown ID=0x%03X, DLC=%d, Data=%02X %02X %02X %02X %02X %02X %02X %02X",
                      message.identifier, message.data_length_code,
                      message.data[0], message.data[1], message.data[2], message.data[3],
                      message.data[4], message.data[5], message.data[6], message.data[7]);
      }
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
    uint8_t ret = *(data->canMessageStatus);
    *(data->canMessageStatus) = 0;
    return ret;
}