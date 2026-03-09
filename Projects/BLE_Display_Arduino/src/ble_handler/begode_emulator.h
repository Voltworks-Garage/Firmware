#ifndef BEGODE_EMULATOR_H
#define BEGODE_EMULATOR_H

#include <stdint.h>

// Vehicle state structure - all values that can be reported via Begode protocol
typedef struct {
  // Live data (Frame 0x00)
  float speed_mps;              // Speed in meters per second
  uint32_t battery_mv;          // Battery voltage in millivolts (e.g., 58800 for 58.8V)
  uint32_t total_distance_m;    // Total distance traveled in meters
  int16_t phase_current_cA;     // Phase current in centi-amps (0.01A units)
  float temperature_c;          // Temperature in Celsius

  // Settings/Limits (Frames 0x01, 0x04)
  uint8_t pwm_limit_percent;    // PWM limit (0-100%)
  uint8_t settings_flags;       // Packed settings byte (pedals/alarms)
  uint8_t led_mode;             // LED mode setting

  // Power data (Frame 0x07)
  int16_t battery_current_cA;   // Battery current in centi-amps (0.01A units)
  uint8_t hardware_pwm_percent; // Hardware PWM (0-100%)
} BegodeVehicleState;

// Initialize the Begode emulator with default values
void Begode_Init(void);

// Update vehicle state - call this to set values before sending
void Begode_UpdateState(const BegodeVehicleState* state);

// Get current vehicle state
void Begode_GetState(BegodeVehicleState* state);

// Set individual values (convenience functions)
void Begode_SetSpeed(float speed_mps);
void Begode_SetBatteryVoltage(uint32_t voltage_mv);
void Begode_SetBatteryCurrent(int16_t current_cA);
void Begode_SetTemperature(float temp_c);
void Begode_SetPWM(uint8_t pwm_percent);
void Begode_SetDistance(uint32_t distance_m);
void Begode_IncrementDistance(float distance_m);

// Send a begode style frame over HM10, auto incrementing sequence.
// Returns pointer to internal 24-byte frame buffer (valid until next call)
// Returns NULL on error
const uint8_t* Begode_SendFrame(void);

// Process received frame (if needed)
void Begode_ReceiveFrame(const uint8_t* frame, uint16_t len);

// Reset frame sequence (useful when starting new streaming session)
void Begode_ResetSequence(void);

#endif // BEGODE_EMULATOR_H
