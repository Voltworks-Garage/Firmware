#include "begode_emulator.h"
#include <string.h>

// Internal state
static BegodeVehicleState g_state;
static uint8_t g_frame_seq = 0;  // 0, 1, 2, 3 cycle

// Internal frame buffer
static uint8_t g_frame_buffer[24];

// Response buffers for commands
static const char FIRMWARE_STRING[] = "GW2002001";
static const char NAME_STRING[] = "NAME:X-WAY\r\n";
static uint8_t g_response_buffer[24];
static uint16_t g_response_len = 0;

void Begode_Init(void) {
  memset(&g_state, 0, sizeof(g_state));

  // Set reasonable defaults
  g_state.speed_mps = 902.0f;              // 230 m/s (~828 km/h)
  g_state.battery_mv = 58800;           // 58.8V
  g_state.temperature_c = 69.4f;        // 69.4°C
  g_state.pwm_limit_percent = 80;       // 80% limit
  g_state.hardware_pwm_percent = 69;     // 69% PWM
  g_state.settings_flags = 0x00;        // All settings off
  g_state.led_mode = 0x00;              // LED mode 0
  g_state.battery_current_cA = 650;   // 6.50 A
  g_state.phase_current_cA = 500;     // 5.00 A
  g_state.total_distance_m = 420;        // 420 meters

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

const uint8_t* Begode_GetFrame(void) {
  // Clear frame
  memset(g_frame_buffer, 0, 24);

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

    uint16_t voltage_centi = (uint16_t)(g_state.battery_mv / 10.0);  // 0.01V units
    int16_t speed_raw_mps = (int16_t)(g_state.speed_mps + 0.5f);   // m/s
    uint32_t dist_total_m = g_state.total_distance_m;              // meters
    int16_t phase_cA = g_state.phase_current_cA;                   // 0.01A

    // Convert temperature to MPU6050 format: temp_raw = (temp_c - 36.53) * 340
    int16_t temp_raw = (int16_t)((g_state.temperature_c - 36.53f) * 340.0f);

    // Big-endian fields
    g_frame_buffer[2] = (uint8_t)(voltage_centi >> 8);
    g_frame_buffer[3] = (uint8_t)(voltage_centi & 0xFF);
    g_frame_buffer[4] = (uint8_t)(speed_raw_mps >> 8);
    g_frame_buffer[5] = (uint8_t)(speed_raw_mps & 0xFF);
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
    uint16_t bat_dV = (uint16_t)(g_state.battery_mv / 100);  // 0.1V units

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

  return g_frame_buffer;
}

const uint8_t* Begode_HandleCommand(uint8_t command, uint16_t* response_len) {
  if (response_len == NULL) {
    return NULL;
  }

  *response_len = 0;

  if (command == 'V' || command == 'v') {
    // Start streaming command
    // Response sequence:
    // 1. First, return a data frame (caller should send this)
    // 2. Then firmware string
    // 3. Then echo 'V'

    // For now, return firmware string + echo combined
    memcpy(g_response_buffer, FIRMWARE_STRING, strlen(FIRMWARE_STRING));
    g_response_buffer[strlen(FIRMWARE_STRING)] = 'V';
    *response_len = strlen(FIRMWARE_STRING) + 1;

    // Reset sequence for new streaming session
    Begode_ResetSequence();

    return g_response_buffer;

  } else if (command == 'N' || command == 'n') {
    // Name request
    *response_len = strlen(NAME_STRING);
    return (const uint8_t*)NAME_STRING;
  }

  return NULL;  // Unknown command
}

void Begode_ResetSequence(void) {
  g_frame_seq = 0;
}
