/**
 * BLE Application Message Handler
 *
 * Handles periodic transmission of CAN bus data over BLE using the
 * BLE protocol schema. Populates BLE messages with real-time CAN data.
 */

#include "app_handler.h"
#include "ble_module.h"
#include "dash_dbc.h"
#include "ble_protocol.h"

#include "esp_log.h"

static const char* TAG = "APP_HANDLER";

// Uptime counter (milliseconds)
static uint32_t uptime_ms = 0;

void app_handler_init(void) {
    ESP_LOGI(TAG, "Application handler initialized");
    uptime_ms = 0;
}

void app_handler_run_10ms(void) {
    // No longer used - all BLE messages sent at 100ms or slower
}

void app_handler_run_100ms(void) {
    uptime_ms += 100;

    // ========== Motor Data (100ms) ==========
    ble_encode_motor_data_begin();

    // Get motor controller data from CAN
    // Note: Using placeholder getters - adjust based on actual motorcontroller_dbc.h API
    ble_encode_motor_data_set_motorTemp_c(0);  // TODO: Add actual motor temp signal
    ble_encode_motor_data_set_controllerTemp_c(0);  // TODO: Add actual controller temp signal
    ble_encode_motor_data_set_motorRpm(0);  // TODO: Add actual RPM signal
    ble_encode_motor_data_set_power_w(0);  // TODO: Add actual power signal
    ble_encode_motor_data_set_torque_nm(0);  // TODO: Add actual torque signal
    ble_encode_motor_data_set_throttle_percent(0);  // TODO: Add actual throttle signal
    ble_encode_motor_data_set_regenLevel_percent(0);  // TODO: Add actual regen signal

    ble_frame_t motor_frame = ble_encode_motor_data_get_frame();
    BLE_SendUartData(motor_frame.data, motor_frame.length);

    ESP_LOGD(TAG, "Sent motor_data (%d bytes)", motor_frame.length);

    // ========== Safety Status (100ms) ==========
    ble_encode_safety_status_begin();

    // Get safety data from MCU and dash
    ble_encode_safety_status_set_faultCodes(0);  // TODO: Combine fault codes
    ble_encode_safety_status_set_warning_flags(0);  // TODO: Combine warning flags
    ble_encode_safety_status_set_charging_status(0);  // TODO: Get charging status from BMS
    ble_encode_safety_status_set_ride_mode(0); // TODO: Implement ride mode signal
    ble_encode_safety_status_set_frontBrake_engaged(CAN_mcu_status_brakeSwitchFront_get());
    ble_encode_safety_status_set_rearBrake_engaged(CAN_mcu_status_brakeSwitchRear_get());

    ble_frame_t safety_frame = ble_encode_safety_status_get_frame();
    BLE_SendUartData(safety_frame.data, safety_frame.length);

    ESP_LOGD(TAG, "Sent safety_status (%d bytes)", safety_frame.length);

    // ========== BMS Status (100ms) ==========
    ble_encode_bms_status_begin();

    // Get BMS status data from CAN
    float soc_percent = CAN_bms_status_soc_percent_get();
    ble_encode_bms_status_set_soc_percent((uint8_t)soc_percent);
    ble_encode_bms_status_set_soh_percent(100);  // TODO: Add SOH signal to DBC

    // Convert pack voltage from float volts to uint32 millivolts
    float pack_voltage_v = CAN_bms_status_pack_voltage_get();
    uint32_t pack_voltage_mv = (uint32_t)(pack_voltage_v * 1000.0f);
    ble_encode_bms_status_set_packVoltage_mv(pack_voltage_mv);

    // Convert pack current from float amps to int32 milliamps
    float pack_current_a = CAN_bms_status_pack_current_get();
    int32_t pack_current_ma = (int32_t)(pack_current_a * 1000.0f);
    ble_encode_bms_status_set_packCurrent_ma(pack_current_ma);

    ble_encode_bms_status_set_remainingRange_km(0);  // TODO: Add range calculation
    ble_encode_bms_status_set_timeToEmpty_min(0);  // TODO: Add time to empty
    ble_encode_bms_status_set_timeToFull_min(0);  // TODO: Add time to full
    ble_encode_bms_status_set_cellDelta_mv(0);  // TODO: Calculate cell delta from min/max
    ble_encode_bms_status_set_minCellVoltage_mv(0);  // TODO: Add min cell voltage signal
    ble_encode_bms_status_set_maxCellVoltage_mv(0);  // TODO: Add max cell voltage signal
    ble_encode_bms_status_set_minCellIndex(0);  // TODO: Add min cell index signal
    ble_encode_bms_status_set_maxCellIndex(0);  // TODO: Add max cell index signal

    ble_frame_t bms_status_frame = ble_encode_bms_status_get_frame();
    BLE_SendUartData(bms_status_frame.data, bms_status_frame.length);

    ESP_LOGD(TAG, "Sent bms_status (%d bytes)", bms_status_frame.length);

    // ========== BMS Cell Data (100ms) ==========
    ble_encode_bms_data_begin();

    // Get individual cell voltages from BMS (returns uint16_t in mV already)
    ble_encode_bms_data_set_cellVoltage1_mv(CAN_bms_cell_voltages_cell_1_voltage_get());
    ble_encode_bms_data_set_cellVoltage2_mv(CAN_bms_cell_voltages_cell_2_voltage_get());
    ble_encode_bms_data_set_cellVoltage3_mv(CAN_bms_cell_voltages_cell_3_voltage_get());
    ble_encode_bms_data_set_cellVoltage4_mv(CAN_bms_cell_voltages_cell_4_voltage_get());
    ble_encode_bms_data_set_cellVoltage5_mv(CAN_bms_cell_voltages_cell_5_voltage_get());
    ble_encode_bms_data_set_cellVoltage6_mv(CAN_bms_cell_voltages_cell_6_voltage_get());
    ble_encode_bms_data_set_cellVoltage7_mv(CAN_bms_cell_voltages_cell_7_voltage_get());
    ble_encode_bms_data_set_cellVoltage8_mv(CAN_bms_cell_voltages_cell_8_voltage_get());
    ble_encode_bms_data_set_cellVoltage9_mv(CAN_bms_cell_voltages_cell_9_voltage_get());
    ble_encode_bms_data_set_cellVoltage10_mv(CAN_bms_cell_voltages_cell_10_voltage_get());
    ble_encode_bms_data_set_cellVoltage11_mv(CAN_bms_cell_voltages_cell_11_voltage_get());
    ble_encode_bms_data_set_cellVoltage12_mv(CAN_bms_cell_voltages_cell_12_voltage_get());
    ble_encode_bms_data_set_cellVoltage13_mv(CAN_bms_cell_voltages_cell_13_voltage_get());
    ble_encode_bms_data_set_cellVoltage14_mv(CAN_bms_cell_voltages_cell_14_voltage_get());
    ble_encode_bms_data_set_cellVoltage15_mv(CAN_bms_cell_voltages_cell_15_voltage_get());
    ble_encode_bms_data_set_cellVoltage16_mv(CAN_bms_cell_voltages_cell_16_voltage_get());
    ble_encode_bms_data_set_cellVoltage17_mv(CAN_bms_cell_voltages_cell_17_voltage_get());
    ble_encode_bms_data_set_cellVoltage18_mv(CAN_bms_cell_voltages_cell_18_voltage_get());
    ble_encode_bms_data_set_cellVoltage19_mv(CAN_bms_cell_voltages_cell_19_voltage_get());
    ble_encode_bms_data_set_cellVoltage20_mv(CAN_bms_cell_voltages_cell_20_voltage_get());
    ble_encode_bms_data_set_cellVoltage21_mv(CAN_bms_cell_voltages_cell_21_voltage_get());
    ble_encode_bms_data_set_cellVoltage22_mv(CAN_bms_cell_voltages_cell_22_voltage_get());
    ble_encode_bms_data_set_cellVoltage23_mv(CAN_bms_cell_voltages_cell_23_voltage_get());
    ble_encode_bms_data_set_cellVoltage24_mv(CAN_bms_cell_voltages_cell_24_voltage_get());
    ble_encode_bms_data_set_packTemp_c(0);  // TODO: Add pack temperature signal

    ble_frame_t bms_data_frame = ble_encode_bms_data_get_frame();
    BLE_SendUartData(bms_data_frame.data, bms_data_frame.length);

    ESP_LOGD(TAG, "Sent bms_data (%d bytes)", bms_data_frame.length);
}

void app_handler_run_1000ms(void) {

    // ========== Heartbeat (1000ms) ==========
    ble_encode_heartbeat_begin();

    ble_encode_heartbeat_set_uptime_ms(uptime_ms);

    // Get battery voltage from MCU (convert from float to millivolts)
    float batt_voltage = CAN_mcu_status_batt_voltage_get();
    uint32_t batt_mv = (uint32_t)(batt_voltage * 1000.0f);
    ble_encode_heartbeat_set_lvBattery_mv(batt_mv);

    // Vehicle state
    ble_encode_heartbeat_set_vehicle_state(CAN_mcu_status_vehicleState_get());

    ble_frame_t heartbeat_frame = ble_encode_heartbeat_get_frame();
    BLE_SendUartData(heartbeat_frame.data, heartbeat_frame.length);

    ESP_LOGI(TAG, "Sent heartbeat (uptime: %lu ms, battery: %lu mV, flags: 0x%02X)",
             uptime_ms, batt_mv, CAN_mcu_status_vehicleState_get());

    // ========== Performance Data (1000ms) ==========
    ble_encode_performance_data_begin();

    ble_encode_performance_data_set_odometer_km(0);  // TODO: Add odometer
    ble_encode_performance_data_set_trip_km(0);  // TODO: Add trip meter
    ble_encode_performance_data_set_avgSpeed_kph(0);  // TODO: Add avg speed
    ble_encode_performance_data_set_topSpeed_kph(0);  // TODO: Add top speed
    ble_encode_performance_data_set_energy_wh_per_km(0);  // TODO: Add efficiency
    ble_encode_performance_data_set_accel_0_60_ms(0);  // TODO: Add 0-60 time

    ble_frame_t perf_frame = ble_encode_performance_data_get_frame();
    BLE_SendUartData(perf_frame.data, perf_frame.length);

    ESP_LOGD(TAG, "Sent performance_data (%d bytes)", perf_frame.length);
}
