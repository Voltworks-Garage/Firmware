#include "begode_emulator.h"
#include <string.h>
#include "esp_log.h"
#include "ble_module.h"

static const char* TAG = "Begode";

// Internal state
static BegodeVehicleState g_state;
static uint8_t g_frame_seq = 1;  // 0, 1, 2, 3 cycle
static bool g_streaming_active = false;

// Internal frame buffer
#define FRAME_BUFFER_SIZE 24
static uint8_t g_frame_buffer[FRAME_BUFFER_SIZE];
static uint8_t checksum;

// Response buffers for commands
static const char FIRMWARE_STRING[] = "GW2002001";
static const char NAME_STRING[] = "NAME:X-WAY\r\n";
static uint8_t g_response_buffer[24];
static uint16_t g_response_len = 0;

void Begode_HandleCommand(uint8_t command);

void Begode_Init(void) {

  BLE_SetHM10Callback(Begode_ReceiveFrame);
  memset(&g_state, 0, sizeof(g_state));

  // Set unique identifiable test values (so we can track where each field appears in DarknessBot)
  g_state.speed_mps = 11.11f;            // 11.11 m/s = 1111 cm/s (look for ~40 km/h or 11.11 value)
  g_state.battery_mv = 55500;            // 55.5V = 5550 cV (look for 55.5V)
  g_state.temperature_c = 33.0f;         // 33°C (look for 33°C)
  g_state.pwm_limit_percent = 77;        // 77% (look for 77)
  g_state.hardware_pwm_percent = 44;     // 44% PWM (look for 44)
  g_state.settings_flags = 0x00;         // All settings off
  g_state.led_mode = 0x00;               // LED mode 0
  g_state.battery_current_cA = 2222;     // 22.22 A (look for 22.22A)
  g_state.phase_current_cA = 3333;       // 33.33 A (look for 33.33A)
  g_state.total_distance_m = 9999;       // 9999 meters (look for 9.999km)

  g_frame_seq = 0;
}

void Begode_UpdateState(const BegodeVehicleState* state) {
  if (state != NULL) {
    memcpy(&g_state, state, sizeof(BegodeVehicleState));
  }
}

void Begode_GetState(BegodeVehicleState* state) {
  if (state != NULL) {
    memcpy(state, &g_state, sizeof(BegodeVehicleState));
  }
}

void Begode_SetSpeed(float speed_mps) {
  g_state.speed_mps = speed_mps;
}

void Begode_SetBatteryVoltage(uint32_t voltage_mv) {
  g_state.battery_mv = voltage_mv;
}

void Begode_SetBatteryCurrent(int16_t current_cA) {
  g_state.battery_current_cA = current_cA;
}

void Begode_SetTemperature(float temp_c) {
  g_state.temperature_c = temp_c;
}

void Begode_SetPWM(uint8_t pwm_percent) {
  if (pwm_percent > 100) pwm_percent = 100;
  g_state.hardware_pwm_percent = pwm_percent;
}

void Begode_SetDistance(uint32_t distance_m) {
  g_state.total_distance_m = distance_m;
}

void Begode_IncrementDistance(float distance_m) {
  g_state.total_distance_m += (uint32_t)(distance_m + 0.5f);
}

const uint8_t* Begode_SendFrame(void) {
  if(!g_streaming_active || !BLE_IsConnected()) {
    g_streaming_active = false;
    Begode_ResetSequence();
    return NULL;
  }
  // Clear frame
  memset(g_frame_buffer, 0, FRAME_BUFFER_SIZE);

  // Common header and footer
  g_frame_buffer[0] = 0x55;
  g_frame_buffer[1] = 0xAA;
  g_frame_buffer[19] = 0x18;
  g_frame_buffer[20] = 0x5A;
  g_frame_buffer[21] = 0x5A;
  g_frame_buffer[22] = 0x5A;
  g_frame_buffer[23] = 0x5A;

  uint8_t seq = g_frame_seq & 0x03;
  uint8_t frame_type = 0x00;

  if (seq == 0) {
    // Frame 0x00: Live data (voltage, speed, distance, phase current, temperature)
    frame_type = 0x00;

    // DarknessBot multiplies voltage by 2.5, so we divide by 2.5 (multiply by 0.4) when encoding
    uint16_t voltage_centi = (uint16_t)((g_state.battery_mv * 0.4) / 10.0);  // 0.01V units, adjusted for DarknessBot
    int16_t speed_raw_cms = (int16_t)(g_state.speed_mps * 100.0f + 0.5f);   // cm/s (centimeters per second!)
    uint32_t dist_total_m = g_state.total_distance_m;              // meters
    int16_t phase_cA = g_state.phase_current_cA;                   // 0.01A

    // Convert temperature to MPU6050 format: temp_raw = (temp_c - 36.53) * 340
    int16_t temp_raw = (int16_t)((g_state.temperature_c - 36.53f) * 340.0f);

    // Big-endian fields
    g_frame_buffer[2] = (uint8_t)(voltage_centi >> 8);
    g_frame_buffer[3] = (uint8_t)(voltage_centi & 0xFF);
    g_frame_buffer[4] = (uint8_t)(speed_raw_cms >> 8);
    g_frame_buffer[5] = (uint8_t)(speed_raw_cms & 0xFF);
    g_frame_buffer[6] = (uint8_t)(dist_total_m >> 24);
    g_frame_buffer[7] = (uint8_t)(dist_total_m >> 16);
    g_frame_buffer[8] = (uint8_t)(dist_total_m >> 8);
    g_frame_buffer[9] = (uint8_t)(dist_total_m & 0xFF);
    g_frame_buffer[10] = (uint8_t)(phase_cA >> 8);
    g_frame_buffer[11] = (uint8_t)(phase_cA & 0xFF);
    g_frame_buffer[12] = (uint8_t)(temp_raw >> 8);
    g_frame_buffer[13] = (uint8_t)(temp_raw & 0xFF);

    // Unknown fields (demo values from original)
    g_frame_buffer[14] = 0x00;
    g_frame_buffer[15] = 0x01;
    g_frame_buffer[16] = 0xFF;
    g_frame_buffer[17] = 0xF8;

  } else if (seq == 1) {
    // Frame 0x04: Totals/settings
    frame_type = 0x04;

    uint32_t total_m = g_state.total_distance_m;

    g_frame_buffer[2] = (uint8_t)(total_m >> 24);
    g_frame_buffer[3] = (uint8_t)(total_m >> 16);
    g_frame_buffer[4] = (uint8_t)(total_m >> 8);
    g_frame_buffer[5] = (uint8_t)(total_m & 0xFF);
    g_frame_buffer[6] = g_state.settings_flags;
    g_frame_buffer[13] = g_state.led_mode;

  } else if (seq == 2) {
    // Frame 0x01: Voltage/limits
    frame_type = 0x01;

    uint16_t pwm_limit = g_state.pwm_limit_percent;
    // DarknessBot multiplies voltage by 2.5, so we divide by 2.5 (multiply by 0.4) when encoding
    uint16_t bat_dV = (uint16_t)((g_state.battery_mv * 0.4) / 100);  // 0.1V units, adjusted for DarknessBot

    g_frame_buffer[2] = (uint8_t)(pwm_limit >> 8);
    g_frame_buffer[3] = (uint8_t)(pwm_limit & 0xFF);
    g_frame_buffer[6] = (uint8_t)(bat_dV >> 8);
    g_frame_buffer[7] = (uint8_t)(bat_dV & 0xFF);

  } else {
    // Frame 0x07: Battery current and hardware PWM
    frame_type = 0x07;

    int16_t batt_cA = g_state.battery_current_cA;
    int16_t hw_pwm = (int16_t)g_state.hardware_pwm_percent;

    g_frame_buffer[2] = (uint8_t)(batt_cA >> 8);
    g_frame_buffer[3] = (uint8_t)(batt_cA & 0xFF);
    g_frame_buffer[8] = (uint8_t)(hw_pwm >> 8);
    g_frame_buffer[9] = (uint8_t)(hw_pwm & 0xFF);
  }

  g_frame_buffer[18] = frame_type;

  // Advance sequence
  g_frame_seq = (g_frame_seq + 1) & 0x03;

  // Debug: Log what we're sending for all frame types
  if (frame_type == 0x00) {
    int16_t speed_raw_cms = (int16_t)((g_frame_buffer[4] << 8) | g_frame_buffer[5]);
    uint16_t voltage_centi = (g_frame_buffer[2] << 8) | g_frame_buffer[3];
    uint32_t dist = (g_frame_buffer[6] << 24) | (g_frame_buffer[7] << 16) | (g_frame_buffer[8] << 8) | g_frame_buffer[9];
    ESP_LOGI(TAG, "Frame 0x00: Volt=%d cV (%.2fV), Speed=%d cm/s, Dist=%u m, Bytes[2-3]=0x%02X%02X",
             voltage_centi, voltage_centi/100.0f, speed_raw_cms, dist, g_frame_buffer[2], g_frame_buffer[3]);
  } else if (frame_type == 0x01) {
    uint16_t pwm_limit = (g_frame_buffer[2] << 8) | g_frame_buffer[3];
    uint16_t bat_dV = (g_frame_buffer[6] << 8) | g_frame_buffer[7];
    ESP_LOGI(TAG, "Frame 0x01: PWM_Limit=%u%%, Volt=%u dV (%.1fV), Bytes[6-7]=0x%02X%02X",
             pwm_limit, bat_dV, bat_dV/10.0f, g_frame_buffer[6], g_frame_buffer[7]);
  } else if (frame_type == 0x04) {
    uint32_t dist = (g_frame_buffer[2] << 24) | (g_frame_buffer[3] << 16) | (g_frame_buffer[4] << 8) | g_frame_buffer[5];
    ESP_LOGI(TAG, "Frame 0x04: Dist=%u m", dist);
  } else if (frame_type == 0x07) {
    int16_t batt_cA = (int16_t)((g_frame_buffer[2] << 8) | g_frame_buffer[3]);
    int16_t hw_pwm = (int16_t)((g_frame_buffer[8] << 8) | g_frame_buffer[9]);
    ESP_LOGI(TAG, "Frame 0x07: BattCurr=%d cA, HW_PWM=%d%%", batt_cA, hw_pwm);
  }

  // Calculate checksum (simple sum of all bytes except last)
  checksum = 0;
  for (int i = 2; i < FRAME_BUFFER_SIZE - 1; i++) {
    checksum += g_frame_buffer[i];
  }
  // g_frame_buffer[FRAME_BUFFER_SIZE - 1] = checksum;

  BLE_SendHM10Data(g_frame_buffer, FRAME_BUFFER_SIZE);

  return g_frame_buffer;
}

void Begode_ReceiveFrame(const uint8_t* frame, uint16_t len) {
  if (frame == nullptr || len == 0) {
    ESP_LOGE(TAG, "Invalid frame received");
    return;
  }
  if (len == 1) {
    ESP_LOGI(TAG, "Received command frame %d", frame[0]);
    uint8_t command = frame[0];
    Begode_HandleCommand(command);

  } else {
    ESP_LOGI(TAG, "Received frame of length %d", len);
  }
}

void Begode_HandleCommand(uint8_t command) {

  if (command == 'V' || command == 'v') {
    // Start streaming command
    // Response sequence:
    // 1. First, return a data frame (caller should send this)
    // 2. Then firmware string
    // 3. Then echo 'V'
    g_streaming_active = true;

    // Reset sequence for new streaming session
    Begode_ResetSequence();

    // First, send a data frame
    BLE_SendHM10Data(g_frame_buffer, FRAME_BUFFER_SIZE);

    // Return firmware string
    const char* fw = "GW2002001";
    BLE_SendHM10Data((const uint8_t*)fw, strlen(fw));

    // Finally, echo 'V'
    BLE_SendHM10Data((const uint8_t*)"V", 1);



  } else if (command == 'N' || command == 'n') {
    // Name request
    memcpy(g_response_buffer, NAME_STRING, strlen(NAME_STRING));
    g_response_buffer[strlen(NAME_STRING)] = 'N';
  } else {
    // Unknown command - no response
    g_response_len = 0;
   }
}

void Begode_ResetSequence(void) {
  g_frame_seq = 0;
}
