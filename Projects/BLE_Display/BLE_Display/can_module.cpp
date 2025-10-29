#include "can_module.h"
#include "../../../CAN/generated/dash_can_decoder.h"
#include "esp_log.h"

#define CAN_STBY GPIO_NUM_17

TaskHandle_t RX_TaskHandle = NULL;

// CAN receive task
static void CAN_RxTask(void* parameter);

void CAN_Init(void) {
  Serial.println("CAN: Initializing...");
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
    Serial.println("CAN: Driver installed");
  } else {
    Serial.printf("CAN: Driver install failed: %d\n", result);
    return;
  }

  result = twai_start();
  if (result == ESP_OK) {
    Serial.println("CAN: Started successfully");
    // Create CAN receive task
    CAN_CreateRxTask();
  } else {
    Serial.printf("CAN: Start failed: %d\n", result);
  }
}

void CAN_DeInit(){
  twai_stop();
  gpio_set_direction(CAN_STBY, GPIO_MODE_DISABLE);
  vTaskDelete(RX_TaskHandle);
  RX_TaskHandle = NULL;
}

bool CAN_SendMessage(uint32_t id, uint8_t* data, uint8_t length) {
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

  esp_err_t result = twai_transmit(&message, pdMS_TO_TICKS(1));
  return (result == ESP_OK);
}

bool CAN_ReceiveMessage(twai_message_t* message) {
  if (message == nullptr) {
    return false;
  }

  esp_err_t result = twai_receive(message, pdMS_TO_TICKS(1));
  return (result == ESP_OK);
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

  // Decoded message structures (examples - add more as needed)
  mcu_status_T mcu_status;
  bms_status_T bms_status;
  bms_power_systems_T bms_power;

  while (1) {
    if (CAN_ReceiveMessage(&message)) {
      // Decode based on message ID
      switch (message.identifier) {
        case CAN_ID_MCU_STATUS:
          CAN_Decode_mcu_status(&message, &mcu_status);
          if (mcu_status.valid) {
            Serial.printf("MCU Status: Vehicle State=%d, Batt=%.2fV %.2fA\n",
                          mcu_status.vehicleState, mcu_status.batt_voltage, mcu_status.batt_current);
          }
          break;

        case CAN_ID_BMS_STATUS:
          CAN_Decode_bms_status(&message, &bms_status);
          if (bms_status.valid) {
            Serial.printf("BMS Status: State=%d, Pack=%.2fV %.2fA, SOC=%.1f%%\n",
                          bms_status.bms_state, bms_status.pack_voltage,
                          bms_status.pack_current, bms_status.soc_percent);
          }
          break;

        case CAN_ID_BMS_POWER_SYSTEMS:
          CAN_Decode_bms_power_systems(&message, &bms_power);
          if (bms_power.valid) {
            Serial.printf("BMS Power: DCDC=%.2fV %.2fA, Charger=%.2fV %.2fA\n",
                          bms_power.DCDC_voltage, bms_power.DCDC_current,
                          bms_power.EV_charger_voltage, bms_power.EV_charger_current);
          }
          break;

        default:
          // Unknown message - print raw data
          Serial.printf("CAN: Unknown ID=0x%03X, DLC=%d, Data=",
                        message.identifier, message.data_length_code);
          for (int i = 0; i < message.data_length_code; i++) {
            Serial.printf("%02X ", message.data[i]);
          }
          Serial.println();
          break;
      }
    }
  }
}
