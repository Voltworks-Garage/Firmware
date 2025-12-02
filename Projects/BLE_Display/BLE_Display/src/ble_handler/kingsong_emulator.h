#ifndef KINGSONG_EMULATOR_H
#define KINGSONG_EMULATOR_H

#include <stdint.h>

// Vehicle state structure - all values that can be reported via KingSong protocol
typedef struct {
  // Live data (Packet type 0xA9)
  float speed_kmh;              // Speed in kilometers per hour
  uint32_t battery_mv;          // Battery voltage in millivolts (e.g., 65050 for 65.05V)
  uint32_t total_distance_m;    // Total distance traveled in meters
  int16_t current_cA;           // Current in centi-amps (0.01A units)
  float temperature_c;          // Temperature in Celsius
  uint8_t mode;                 // Riding mode (0-3 typically)

  // Distance/Time/Fan data (Packet type 0xB9)
  uint32_t wheel_distance_m;    // Trip distance in meters
  uint16_t top_speed_kmh_x100;  // Top speed in 0.01 km/h units
  uint8_t fan_status;           // Fan status (0=off, 1=on)
  uint8_t charging_status;      // Charging status (0=not charging, 1=charging)
  int16_t temperature2_c_x100;  // Secondary temperature in 0.01°C units

  // Name and model (Packet type 0xBB)
  char name[15];                // Wheel name (e.g., "KS-18L-0215")
  char model[15];               // Model (e.g., "KS-18L")
  char version[10];             // Firmware version (e.g., "2.15")

  // Serial number (Packet type 0xB3)
  char serial[18];              // Serial number

  // CPU load (Packet type 0xF5)
  uint8_t cpu_load;             // CPU load percentage
  uint8_t output;               // Output percentage

  // Speed limit (Packet type 0xF6)
  uint16_t speed_limit_kmh_x100; // Speed limit in 0.01 km/h units

  // Alarm speeds (Packet type 0xA4/0xB5)
  uint8_t alarm1_speed;         // First alarm speed (km/h)
  uint8_t alarm2_speed;         // Second alarm speed (km/h)
  uint8_t alarm3_speed;         // Third alarm speed (km/h)
  uint8_t max_speed;            // Maximum speed setting (km/h)
} KingsongVehicleState;

// Initialize the KingSong emulator with default values
void Kingsong_Init(void);

// Update vehicle state - call this to set values before sending
void Kingsong_UpdateState(const KingsongVehicleState* state);

// Get current vehicle state
void Kingsong_GetState(KingsongVehicleState* state);

// Set individual values (convenience functions)
void Kingsong_SetSpeed(float speed_kmh);
void Kingsong_SetBatteryVoltage(uint32_t voltage_mv);
void Kingsong_SetCurrent(int16_t current_cA);
void Kingsong_SetTemperature(float temp_c);
void Kingsong_SetDistance(uint32_t distance_m);
void Kingsong_SetMode(uint8_t mode);
void Kingsong_IncrementDistance(float distance_m);

// Send a specific packet type over BLE HM-10 characteristic (0xFFE0/0xFFE1)
// Returns pointer to internal 20-byte packet buffer (valid until next call)
// Returns NULL on error
const uint8_t* Kingsong_SendLiveDataPacket(void);      // Type 0xA9 - main live data
const uint8_t* Kingsong_SendDistancePacket(void);      // Type 0xB9 - distance/time/fan
const uint8_t* Kingsong_SendNamePacket(void);          // Type 0xBB - name and model
const uint8_t* Kingsong_SendSerialPacket(void);        // Type 0xB3 - serial number
const uint8_t* Kingsong_SendCpuLoadPacket(void);       // Type 0xF5 - CPU load
const uint8_t* Kingsong_SendSpeedLimitPacket(void);    // Type 0xF6 - speed limit
const uint8_t* Kingsong_SendAlarmPacket(void);         // Type 0xA4 - alarm speeds

// Process received frame (for commands from Wheellog app)
void Kingsong_ReceiveFrame(const uint8_t* frame, uint16_t len);

// Automatically cycle through different packet types (call periodically)
// This mimics real KingSong wheel behavior
const uint8_t* Kingsong_SendNextPacket(void);

#endif // KINGSONG_EMULATOR_H
