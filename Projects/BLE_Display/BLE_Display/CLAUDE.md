# BLE_Display Project

ESP32-S3 based display module that emulates electric unicycle (EUC) Bluetooth protocols for integration with third-party apps like DarknessBot and Wheellog.

## Project Overview

This project creates an external display unit that connects to EUC monitoring apps via Bluetooth Low Energy (BLE). It receives vehicle data over CAN bus and transmits it using standard EUC BLE protocols, allowing users to use their favorite EUC apps with custom vehicles.

### Key Features
- BLE protocol emulation (Begode/Gotway, KingSong)
- LVGL-based touchscreen display with multiple screens
- CAN bus integration for vehicle data
- FreeRTOS task scheduling (1ms, 10ms, 100ms, 1000ms)
- Deep sleep with CAN wake-up
- OTA firmware updates

### Hardware
- ESP32-S3 microcontroller
- TFT LCD display with touch (TFT_eSPI library)
- CAN transceiver (GPIO 17 TX, GPIO 18 RX)

## Build Instructions

This is an Arduino IDE project. Open `BLE_Display.ino` in Arduino IDE with ESP32-S3 board support installed.

### Required Libraries
- NimBLE-Arduino (BLE stack)
- TFT_eSPI (display driver)
- LVGL (graphics library)
- ESP32 Arduino core

### TFT_eSPI Library Patch

**IMPORTANT**: The TFT_eSPI library requires a patch to prevent watchdog timeouts during large display updates.

A `taskYIELD()` call must be added at the beginning of the `pushBlock` function:

**File**: `C:\Users\zachl\OneDrive\Documents\Arduino\libraries\TFT_eSPI\Processors\TFT_eSPI_ESP32_S3.c`

**Function**: `void TFT_eSPI::pushBlock(uint16_t color, uint32_t len)`

```cpp
void TFT_eSPI::pushBlock(uint16_t color, uint32_t len){
  taskYIELD();  // <-- Add this line to allow FreeRTOS to service other tasks
  if ( (color >> 8) == (color & 0x00FF) )
  // ... rest of function
}
```

This allows FreeRTOS to service higher-priority tasks during long display fill operations.

### Board Settings
- Board: ESP32S3 Dev Module
- USB CDC On Boot: Enabled
- Partition Scheme: Custom (see partitions_ota.csv for OTA support)

## Project Structure

```
BLE_Display/
  BLE_Display.ino          # Main entry point
  ble_module.cpp/h         # BLE server and services
  lcd_module.cpp/h         # Display driver
  CAN.c/h                   # CAN bus interface
  touch.c/h                 # Touch controller
  src/
    begode_emulator.cpp/h  # Begode/Gotway protocol
    kingsong_emulator.cpp/h # KingSong protocol (not working)
    dash.cpp/h             # Dashboard logic
    cpu_monitor.c/h        # Task timing monitor
    display/
      display.cpp/h        # LVGL initialization
      display_state_machine.cpp/h  # Screen state machine
      styles.cpp/h         # LVGL styling
      screens/             # Individual screen implementations
    msg/
      messaging.c/h        # Inter-module messaging
      messaging_schema.h   # Message definitions
    ota/
      ota_module.c/h       # OTA update handling
```

---

## Bluetooth (BLE)

The BLE module implements a BLE GATT server using NimBLE that advertises as an electric unicycle to third-party apps. This allows apps designed for EUCs to connect and receive telemetry data.

### BLE Architecture

#### Services Implemented

1. **HM-10 Service (0xFFE0)** - Primary service for EUC app compatibility
   - Characteristic 0xFFE1: Read/Write/Notify - Used for data streaming
   - No encryption required (for DarknessBot compatibility)

2. **Nordic UART Service (NUS)** - For secure serial communication
   - TX: 6E400003-... (Notify, requires encryption)
   - RX: 6E400002-... (Write, requires encryption)

3. **Device Information Service (0x180A)** - Device metadata
   - Model Number, Serial Number, Firmware Version, Manufacturer Name

4. **GAP Service (0x1800)** - Standard BLE GAP
5. **GATT Service (0x1801)** - Standard BLE GATT

#### Connection Flow

1. Device advertises as "ESP32-S3(Begode)" with HM-10 service UUID
2. App connects and subscribes to 0xFFE1 notifications
3. App sends 'V' command to start streaming
4. Device responds with data frames at regular intervals (100ms)

#### Key Functions

- `BLE_Init()` - Initialize BLE server and services
- `BLE_SendHM10Data()` - Send data frame to subscribed clients
- `BLE_SetHM10Callback()` - Register callback for received commands
- `BLE_AllowNewDevices()` / `BLE_RestrictToBonded()` - Control pairing

### Begode Protocol

The Begode (formerly Gotway) protocol is **currently working** and is the primary protocol used by this project.

#### Frame Format

All Begode frames are **24 bytes** with the following structure:

```
Byte 0-1:   Header (0x55 0xAA)
Byte 2-17:  Payload (varies by frame type)
Byte 18:    Frame type identifier
Byte 19:    0x18
Byte 20-23: Footer (0x5A 0x5A 0x5A 0x5A)
```

#### Frame Types

The emulator cycles through 4 frame types in sequence:

**Frame 0x00 - Live Data** (sent every 400ms)
```
Byte 2-3:   Battery voltage (0.01V units, big-endian, /2.5 adjustment for apps)
Byte 4-5:   Speed (cm/s, signed big-endian)
Byte 6-9:   Total distance (meters, big-endian)
Byte 10-11: Phase current (0.01A units, big-endian)
Byte 12-13: Temperature (MPU6050 raw format: (temp_c - 36.53) * 340)
```

**Frame 0x04 - Totals/Settings**
```
Byte 2-5:   Total distance (meters, big-endian)
Byte 6:     Settings flags
Byte 13:    LED mode
```

**Frame 0x01 - Voltage/Limits**
```
Byte 2-3:   PWM limit (percentage)
Byte 6-7:   Battery voltage (0.1V units, /2.5 adjustment)
```

**Frame 0x07 - Power Data**
```
Byte 2-3:   Battery current (0.01A units, big-endian)
Byte 8-9:   Hardware PWM (percentage)
```

#### Commands from App

- `'V'` or `'v'`: Start streaming - responds with data frame, firmware string "GW2002001", and echo 'V'
- `'N'` or `'n'`: Name request - responds with "NAME:X-WAY\r\n"

#### Usage

```cpp
// Initialize
Begode_Init();  // Sets up HM10 callback

// Update values
Begode_SetSpeed(15.5f);           // m/s
Begode_SetBatteryVoltage(58800);  // millivolts
Begode_SetTemperature(35.0f);     // Celsius
Begode_SetBatteryCurrent(2500);   // centi-amps

// Send frame (call every 100ms)
Begode_SendFrame();  // Automatically cycles through frame types
```

### KingSong Protocol

**Status: NOT WORKING** - Implemented but not currently functional with apps.

The KingSong protocol uses **20-byte frames** with different byte ordering than Begode.

#### Frame Format

```
Byte 0-1:   Header (0xAA 0x55) - reversed from Begode!
Byte 2-15:  Payload (varies by packet type)
Byte 16:    Packet type identifier
Byte 17:    0x14
Byte 18-19: Footer (0x5A 0x5A)
```

#### Byte Ordering

KingSong uses "reversed big-endian" for most multi-byte values:
- Write big-endian, then swap every 2 bytes
- Exception: Current field uses little-endian

#### Packet Types

**0xA9 - Live Data** (most frequent)
```
Byte 2-3:   Voltage (0.01V, reversed big-endian)
Byte 4-5:   Speed (0.01 km/h, signed, reversed big-endian)
Byte 6-9:   Total distance (meters, reversed big-endian)
Byte 10-11: Current (0.01A, LITTLE ENDIAN - exception!)
Byte 12-13: Temperature (0.01C, reversed big-endian)
Byte 14:    Mode
Byte 15:    0xE0 (mode present flag)
```

**0xB9 - Distance/Time/Fan**
```
Byte 2-5:   Trip distance (meters)
Byte 8-9:   Top speed (0.01 km/h)
Byte 12:    Fan status
Byte 13:    Charging status
Byte 14-15: Secondary temperature
```

**0xBB - Name and Model**
```
Byte 2-15:  Wheel name (up to 14 chars)
```

**0xB3 - Serial Number**
**0xF5 - CPU Load**
**0xF6 - Speed Limit**
**0xA4 - Alarm Settings**

#### Commands Supported

- `0x98`: Request alarm settings
- `0x9B`: Request name data
- `0x63`: Request serial data
- `0x88`: Beep request
- `0x85`: Update alarm/speed settings
- `0x87`: Update pedals mode
- `0x40`: Power off

#### Known Issues

The KingSong emulator is commented out in the main code. Potential issues:
- Byte ordering may not match exactly what apps expect
- Service UUID or characteristics may differ from real KingSong wheels
- Some apps may require additional service discovery characteristics

---

## WiFi (Future Implementation)

WiFi functionality is planned but not yet implemented.

### Planned Features

- **OTA Updates**: WiFi-based firmware updates (OTA module infrastructure exists)
- **Web Dashboard**: Local web server for configuration and monitoring
- **Data Logging**: Upload ride data to cloud services
- **Remote Control**: API for external control and monitoring

### Implementation Notes

When implementing WiFi:

1. WiFi and BLE can coexist on ESP32-S3 but share the same radio
2. Consider power consumption impact
3. Implement connection manager for auto-reconnect
4. Store credentials in NVS (already initialized for OTA)

### Placeholder API (Future)

```cpp
void WiFi_Init(void);
void WiFi_Connect(const char* ssid, const char* password);
bool WiFi_IsConnected(void);
void WiFi_StartAP(const char* apName);  // Configuration mode
```

---

## CAN Bus Interface

The project receives vehicle data over CAN bus and provides it to the BLE emulators.

### Configuration
- TX: GPIO 17
- RX: GPIO 18
- Uses ESP32 TWAI (Two-Wire Automotive Interface) driver

### Key Functions
- `CAN_Init()` / `CAN_DeInit()` - Initialize/deinitialize CAN controller
- `CAN_setMode()` - Switch between normal and listen-only modes
- Deep sleep wake on CAN activity (GPIO 18 LOW detection)

---

## Display System

LVGL-based display with multiple screens managed by a state machine.

### Screens
- **Logo**: Startup screen
- **Home**: Main dashboard
- **Running**: Active ride display
- **Charging**: Battery charging status
- **OTA**: Firmware update progress

### State Machine
Screens transition based on vehicle state (charging, riding, idle) and user input.

---

## Task Scheduling

FreeRTOS tasks run on Core 1 with priority-based scheduling:

| Task       | Period | Priority              | Purpose                    |
|------------|--------|-----------------------|----------------------------|
| task_1ms   | 1ms    | configMAX_PRIORITIES-1 | CAN TX, touch processing   |
| task_10ms  | 10ms   | configMAX_PRIORITIES-3 | CAN TX, touch processing   |
| task_100ms | 100ms  | configMAX_PRIORITIES-4 | Begode frame transmission  |
| task_1000ms| 1000ms | configMAX_PRIORITIES-5 | CPU stats, speed ramping   |

CPU usage is monitored for each task and printed every second.

---

## Deep Sleep

The device enters deep sleep when commanded by the MCU over CAN:

1. Receives sleep command via CAN
2. Waits 1 second to confirm no CAN activity
3. Deinitializes peripherals (CAN, LCD, Touch)
4. Configures wake on CAN activity (GPIO 18 LOW)
5. Enters deep sleep

Wake-up triggers a full reset/boot cycle.

---

## Debugging

### Serial Output
- Baud rate: 921600
- ESP-IDF logging via `ESP_LOG*` macros
- Log levels configurable per module in `setup()`

### Important Log Tags
- `BLE` - BLE connection and data transfer
- `Begode` - Begode frame encoding and commands
- `Kingsong` - KingSong packet encoding
- `CAN` - CAN bus activity
- `DASH` - Dashboard state changes
- `TOUCH` - Touch events
- `OTA` - OTA update progress

### CPU Statistics
Printed every second showing:
- Average CPU usage per task
- Peak CPU usage
- Maximum period deviation
