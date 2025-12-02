#include "kingsong_emulator.h"
#include <string.h>
#include "esp_log.h"
#include "src/peripheral/ble_module.h"

static const char* TAG = "Kingsong";

// Internal state
static KingsongVehicleState g_state;
static uint8_t g_packet_sequence = 0;  // For cycling through different packet types

// Internal packet buffer (20 bytes for KingSong)
static uint8_t g_packet_buffer[20];

// Helper function to reverse every 2 bytes (KingSong uses this for multi-byte fields)
static void reverseEvery2(uint8_t* data, uint16_t len) {
    for (uint16_t i = 0; i < len - 1; i += 2) {
        uint8_t temp = data[i];
        data[i] = data[i + 1];
        data[i + 1] = temp;
    }
}

// Helper function to write 16-bit value with KingSong byte ordering (reversed big-endian)
static void writeInt2R(uint8_t* buffer, uint16_t offset, uint16_t value) {
    buffer[offset] = (uint8_t)(value >> 8);
    buffer[offset + 1] = (uint8_t)(value & 0xFF);
    // Reverse the 2 bytes
    uint8_t temp = buffer[offset];
    buffer[offset] = buffer[offset + 1];
    buffer[offset + 1] = temp;
}

// Helper function to write 32-bit value with KingSong byte ordering (reversed big-endian)
static void writeInt4R(uint8_t* buffer, uint16_t offset, uint32_t value) {
    buffer[offset] = (uint8_t)(value >> 24);
    buffer[offset + 1] = (uint8_t)(value >> 16);
    buffer[offset + 2] = (uint8_t)(value >> 8);
    buffer[offset + 3] = (uint8_t)(value & 0xFF);
    // Reverse every 2 bytes
    reverseEvery2(&buffer[offset], 4);
}

void Kingsong_Init(void) {
    BLE_SetHM10Callback(Kingsong_ReceiveFrame);
    memset(&g_state, 0, sizeof(g_state));

    // Set identifiable test values (similar to Begode approach)
    g_state.speed_kmh = 25.5f;            // 25.5 km/h
    g_state.battery_mv = 65050;           // 65.05V (typical 84V battery at ~77%)
    g_state.temperature_c = 35.0f;        // 35°C
    g_state.current_cA = 1234;            // 12.34 A
    g_state.total_distance_m = 12345;     // 12.345 km
    g_state.mode = 1;                     // Mode 1
    g_state.wheel_distance_m = 1000;      // 1 km trip
    g_state.top_speed_kmh_x100 = 3500;    // 35.00 km/h top speed
    g_state.fan_status = 0;               // Fan off
    g_state.charging_status = 0;          // Not charging
    g_state.temperature2_c_x100 = 3200;   // 32.00°C
    g_state.cpu_load = 45;                // 45% CPU
    g_state.output = 60;                  // 60% output
    g_state.speed_limit_kmh_x100 = 3500;  // 35.00 km/h limit
    g_state.alarm1_speed = 23;            // 23 km/h first alarm
    g_state.alarm2_speed = 28;            // 28 km/h second alarm
    g_state.alarm3_speed = 32;            // 32 km/h third alarm
    g_state.max_speed = 35;               // 35 km/h max speed

    // Set default name and model
    strncpy(g_state.name, "KS-18L-0215", sizeof(g_state.name) - 1);
    strncpy(g_state.model, "KS-18L", sizeof(g_state.model) - 1);
    strncpy(g_state.version, "2.15", sizeof(g_state.version) - 1);
    strncpy(g_state.serial, "KS123456789012345", sizeof(g_state.serial) - 1);

    g_packet_sequence = 0;

    ESP_LOGI(TAG, "KingSong emulator initialized");
}

void Kingsong_UpdateState(const KingsongVehicleState* state) {
    if (state != NULL) {
        memcpy(&g_state, state, sizeof(KingsongVehicleState));
    }
}

void Kingsong_GetState(KingsongVehicleState* state) {
    if (state != NULL) {
        memcpy(state, &g_state, sizeof(KingsongVehicleState));
    }
}

void Kingsong_SetSpeed(float speed_kmh) {
    g_state.speed_kmh = speed_kmh;
}

void Kingsong_SetBatteryVoltage(uint32_t voltage_mv) {
    g_state.battery_mv = voltage_mv;
}

void Kingsong_SetCurrent(int16_t current_cA) {
    g_state.current_cA = current_cA;
}

void Kingsong_SetTemperature(float temp_c) {
    g_state.temperature_c = temp_c;
}

void Kingsong_SetDistance(uint32_t distance_m) {
    g_state.total_distance_m = distance_m;
}

void Kingsong_SetMode(uint8_t mode) {
    g_state.mode = mode;
}

void Kingsong_IncrementDistance(float distance_m) {
    g_state.total_distance_m += (uint32_t)(distance_m + 0.5f);
}

const uint8_t* Kingsong_SendLiveDataPacket(void) {
    // Clear packet buffer
    memset(g_packet_buffer, 0, 20);

    // KingSong header (reversed from Begode!)
    g_packet_buffer[0] = 0xAA;
    g_packet_buffer[1] = 0x55;

    // Voltage in 0.01V units (e.g., 6505 for 65.05V)
    uint16_t voltage_centi = (uint16_t)(g_state.battery_mv / 10);
    writeInt2R(g_packet_buffer, 2, voltage_centi);

    // Speed in 0.01 km/h units, signed (e.g., 515 for 5.15 km/h, 3420 for 34.20 km/h)
    int16_t speed_centi = (int16_t)(g_state.speed_kmh * 100.0f + 0.5f);
    writeInt2R(g_packet_buffer, 4, (uint16_t)speed_centi);

    // Total distance in meters
    writeInt4R(g_packet_buffer, 6, g_state.total_distance_m);

    // Current in 0.01A units (LITTLE ENDIAN - different from other fields!)
    // This is the only field that doesn't use reversed bytes
    g_packet_buffer[10] = (uint8_t)(g_state.current_cA & 0xFF);
    g_packet_buffer[11] = (uint8_t)(g_state.current_cA >> 8);

    // Temperature in 0.01°C units
    int16_t temp_centi = (int16_t)(g_state.temperature_c * 100.0f + 0.5f);
    writeInt2R(g_packet_buffer, 12, (uint16_t)temp_centi);

    // Mode (if byte 15 is 0xE0)
    g_packet_buffer[14] = g_state.mode;
    g_packet_buffer[15] = 0xE0;  // Flag indicating mode is present

    // Packet type
    g_packet_buffer[16] = 0xA9;  // Live data packet

    // Footer
    g_packet_buffer[17] = 0x14;
    g_packet_buffer[18] = 0x5A;
    g_packet_buffer[19] = 0x5A;

    ESP_LOGI(TAG, "Live Data Packet: Volt=%.2fV, Speed=%.2fkm/h, Curr=%.2fA, Temp=%.1f°C, Dist=%um, Mode=%u",
             voltage_centi / 100.0f, speed_centi / 100.0f, g_state.current_cA / 100.0f,
             temp_centi / 100.0f, g_state.total_distance_m, g_state.mode);

    // Debug: Print packet hex dump
    ESP_LOGI(TAG, "Packet hex: %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X",
             g_packet_buffer[0], g_packet_buffer[1], g_packet_buffer[2], g_packet_buffer[3],
             g_packet_buffer[4], g_packet_buffer[5], g_packet_buffer[6], g_packet_buffer[7],
             g_packet_buffer[8], g_packet_buffer[9], g_packet_buffer[10], g_packet_buffer[11],
             g_packet_buffer[12], g_packet_buffer[13], g_packet_buffer[14], g_packet_buffer[15],
             g_packet_buffer[16], g_packet_buffer[17], g_packet_buffer[18], g_packet_buffer[19]);

    BLE_SendHM10Data(g_packet_buffer, 20);
    return g_packet_buffer;
}

const uint8_t* Kingsong_SendDistancePacket(void) {
    // Clear packet buffer
    memset(g_packet_buffer, 0, 20);

    // Header
    g_packet_buffer[0] = 0xAA;
    g_packet_buffer[1] = 0x55;

    // Wheel distance (trip distance) in meters
    writeInt4R(g_packet_buffer, 2, g_state.wheel_distance_m);

    // Top speed in 0.01 km/h units
    writeInt2R(g_packet_buffer, 8, g_state.top_speed_kmh_x100);

    // Fan status
    g_packet_buffer[12] = g_state.fan_status;

    // Charging status
    g_packet_buffer[13] = g_state.charging_status;

    // Secondary temperature
    writeInt2R(g_packet_buffer, 14, (uint16_t)g_state.temperature2_c_x100);

    // Packet type
    g_packet_buffer[16] = 0xB9;  // Distance/Time/Fan packet

    // Footer
    g_packet_buffer[17] = 0x14;
    g_packet_buffer[18] = 0x5A;
    g_packet_buffer[19] = 0x5A;

    ESP_LOGI(TAG, "Distance Packet: Trip=%um, TopSpeed=%.2fkm/h, Fan=%u, Charging=%u, Temp2=%.2f°C",
             g_state.wheel_distance_m, g_state.top_speed_kmh_x100 / 100.0f,
             g_state.fan_status, g_state.charging_status, g_state.temperature2_c_x100 / 100.0f);

    BLE_SendHM10Data(g_packet_buffer, 20);
    return g_packet_buffer;
}

const uint8_t* Kingsong_SendNamePacket(void) {
    // Clear packet buffer
    memset(g_packet_buffer, 0, 20);

    // Header
    g_packet_buffer[0] = 0xAA;
    g_packet_buffer[1] = 0x55;

    // Name (up to 14 characters)
    uint16_t name_len = strlen(g_state.name);
    if (name_len > 14) name_len = 14;
    memcpy(&g_packet_buffer[2], g_state.name, name_len);

    // Packet type
    g_packet_buffer[16] = 0xBB;  // Name and Type packet

    // Footer
    g_packet_buffer[17] = 0x14;
    g_packet_buffer[18] = 0x5A;
    g_packet_buffer[19] = 0x5A;

    ESP_LOGI(TAG, "Name Packet: Name='%s', Model='%s', Version='%s'",
             g_state.name, g_state.model, g_state.version);

    BLE_SendHM10Data(g_packet_buffer, 20);
    return g_packet_buffer;
}

const uint8_t* Kingsong_SendSerialPacket(void) {
    // Clear packet buffer
    memset(g_packet_buffer, 0, 20);

    // Header
    g_packet_buffer[0] = 0xAA;
    g_packet_buffer[1] = 0x55;

    // Serial number is split: bytes 2-15 (14 bytes) and 17-19 (3 bytes)
    uint16_t serial_len = strlen(g_state.serial);
    if (serial_len > 17) serial_len = 17;

    // First 14 bytes of serial
    if (serial_len >= 14) {
        memcpy(&g_packet_buffer[2], g_state.serial, 14);
    } else {
        memcpy(&g_packet_buffer[2], g_state.serial, serial_len);
    }

    // Packet type
    g_packet_buffer[16] = 0xB3;  // Serial number packet

    // Last 3 bytes of serial (if available)
    if (serial_len > 14) {
        uint16_t remaining = serial_len - 14;
        if (remaining > 3) remaining = 3;
        memcpy(&g_packet_buffer[17], &g_state.serial[14], remaining);
    }

    // Note: bytes 18-19 are part of serial, not footer for this packet type

    ESP_LOGI(TAG, "Serial Packet: Serial='%s'", g_state.serial);

    BLE_SendHM10Data(g_packet_buffer, 20);
    return g_packet_buffer;
}

const uint8_t* Kingsong_SendCpuLoadPacket(void) {
    // Clear packet buffer
    memset(g_packet_buffer, 0, 20);

    // Header
    g_packet_buffer[0] = 0xAA;
    g_packet_buffer[1] = 0x55;

    // CPU load
    g_packet_buffer[14] = g_state.cpu_load;

    // Output
    g_packet_buffer[15] = g_state.output;

    // Packet type
    g_packet_buffer[16] = 0xF5;  // CPU load packet

    // Footer
    g_packet_buffer[17] = 0x14;
    g_packet_buffer[18] = 0x5A;
    g_packet_buffer[19] = 0x5A;

    ESP_LOGI(TAG, "CPU Load Packet: CPU=%u%%, Output=%u%%", g_state.cpu_load, g_state.output);

    BLE_SendHM10Data(g_packet_buffer, 20);
    return g_packet_buffer;
}

const uint8_t* Kingsong_SendSpeedLimitPacket(void) {
    // Clear packet buffer
    memset(g_packet_buffer, 0, 20);

    // Header
    g_packet_buffer[0] = 0xAA;
    g_packet_buffer[1] = 0x55;

    // Speed limit in 0.01 km/h units
    writeInt2R(g_packet_buffer, 2, g_state.speed_limit_kmh_x100);

    // Packet type
    g_packet_buffer[16] = 0xF6;  // Speed limit packet

    // Footer
    g_packet_buffer[17] = 0x14;
    g_packet_buffer[18] = 0x5A;
    g_packet_buffer[19] = 0x5A;

    ESP_LOGI(TAG, "Speed Limit Packet: Limit=%.2fkm/h", g_state.speed_limit_kmh_x100 / 100.0f);

    BLE_SendHM10Data(g_packet_buffer, 20);
    return g_packet_buffer;
}

const uint8_t* Kingsong_SendAlarmPacket(void) {
    // Clear packet buffer
    memset(g_packet_buffer, 0, 20);

    // Header
    g_packet_buffer[0] = 0xAA;
    g_packet_buffer[1] = 0x55;

    // Alarm speeds
    g_packet_buffer[4] = g_state.alarm1_speed;
    g_packet_buffer[6] = g_state.alarm2_speed;
    g_packet_buffer[8] = g_state.alarm3_speed;
    g_packet_buffer[10] = g_state.max_speed;

    // Packet type
    g_packet_buffer[16] = 0xA4;  // Alarm settings packet

    // Footer
    g_packet_buffer[17] = 0x14;
    g_packet_buffer[18] = 0x5A;
    g_packet_buffer[19] = 0x5A;

    ESP_LOGI(TAG, "Alarm Packet: Alarm1=%ukm/h, Alarm2=%ukm/h, Alarm3=%ukm/h, Max=%ukm/h",
             g_state.alarm1_speed, g_state.alarm2_speed, g_state.alarm3_speed, g_state.max_speed);

    BLE_SendHM10Data(g_packet_buffer, 20);
    return g_packet_buffer;
}

const uint8_t* Kingsong_SendNextPacket(void) {
    const uint8_t* result = NULL;

    // Cycle through different packet types to simulate real wheel
    switch (g_packet_sequence) {
        case 0:
            result = Kingsong_SendLiveDataPacket();  // Most important - send frequently
            break;
        case 1:
            result = Kingsong_SendLiveDataPacket();  // Send again (live data is sent most often)
            break;
        case 2:
            result = Kingsong_SendDistancePacket();
            break;
        case 3:
            result = Kingsong_SendLiveDataPacket();
            break;
        case 4:
            result = Kingsong_SendCpuLoadPacket();
            break;
        case 5:
            result = Kingsong_SendLiveDataPacket();
            break;
        case 6:
            result = Kingsong_SendSpeedLimitPacket();
            break;
        case 7:
            result = Kingsong_SendLiveDataPacket();
            break;
        case 8:
            result = Kingsong_SendNamePacket();      // Send name occasionally
            break;
        case 9:
            result = Kingsong_SendSerialPacket();    // Send serial occasionally
            break;
        default:
            result = Kingsong_SendLiveDataPacket();
            g_packet_sequence = 0;
            break;
    }

    g_packet_sequence++;
    if (g_packet_sequence > 9) {
        g_packet_sequence = 0;
    }

    return result;
}

void Kingsong_ReceiveFrame(const uint8_t* frame, uint16_t len) {
    if (frame == nullptr || len == 0) {
        ESP_LOGE(TAG, "Invalid frame received");
        return;
    }

    ESP_LOGI(TAG, "Received command frame, length=%u", len);

    // KingSong commands are typically 20 bytes
    if (len >= 20) {
        // Check header
        if (frame[0] != 0xAA || frame[1] != 0x55) {
            ESP_LOGW(TAG, "Invalid header: 0x%02X 0x%02X", frame[0], frame[1]);
            return;
        }

        uint8_t cmd_type = frame[16];
        ESP_LOGI(TAG, "Command type: 0x%02X", cmd_type);

        switch (cmd_type) {
            case 0x98:  // Request alarm settings and max speed
                ESP_LOGI(TAG, "Alarm settings requested");
                Kingsong_SendAlarmPacket();
                break;
            case 0x9B:  // Request name data
                ESP_LOGI(TAG, "Name data requested");
                Kingsong_SendNamePacket();
                break;
            case 0x63:  // Request serial data
                ESP_LOGI(TAG, "Serial data requested");
                Kingsong_SendSerialPacket();
                break;
            case 0x88:  // Beep request
                ESP_LOGI(TAG, "Beep requested");
                // Could trigger a beep sound here
                break;
            case 0x85:  // Update alarm and speed settings
                ESP_LOGI(TAG, "Alarm/speed update: A1=%u, A2=%u, A3=%u, Max=%u",
                         frame[2], frame[4], frame[6], frame[8]);
                g_state.alarm1_speed = frame[2];
                g_state.alarm2_speed = frame[4];
                g_state.alarm3_speed = frame[6];
                g_state.max_speed = frame[8];
                break;
            case 0x87:  // Update pedals mode
                ESP_LOGI(TAG, "Pedals mode update: %u", frame[2]);
                // Could update pedals mode here
                break;
            case 0x40:  // Power off
                ESP_LOGI(TAG, "Power off requested");
                // Could trigger power off sequence
                break;
            default:
                ESP_LOGW(TAG, "Unknown command type: 0x%02X", cmd_type);
                break;
        }
    }
}

