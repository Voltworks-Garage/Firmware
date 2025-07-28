#ifndef dash_DBC_H
#define dash_DBC_H

#include <stdint.h>
typedef enum{
    dash,
    mcu,
    bms,
    motorcontroller,
    charger,
    boot_host,
} CAN_nodes_E;

/**********************************************************
 * dash NODE MESSAGES
 */
#define CAN_dash_status_interval() 10
void CAN_dash_status_heartBeat_set(uint16_t heartBeat);
void CAN_dash_status_state_set(uint16_t state);
void CAN_dash_status_killButton_set(uint16_t killButton);
void CAN_dash_status_ignButton_set(uint16_t ignButton);
void CAN_dash_status_modeButton_set(uint16_t modeButton);
void CAN_dash_status_selectButton_set(uint16_t selectButton);
void CAN_dash_status_driveMode_set(uint16_t driveMode);
void CAN_dash_status_dlc_set(uint8_t dlc);


void CAN_dash_status_send(void);


#define CAN_dash_command_interval() 10
void CAN_dash_command_ignitionRequest_set(uint16_t ignitionRequest);
void CAN_dash_command_killRequest_set(uint16_t killRequest);
void CAN_dash_command_batteryEjectRequest_set(uint16_t batteryEjectRequest);
void CAN_dash_command_lightsRequest_set(uint16_t lightsRequest);
void CAN_dash_command_hornRequest_set(uint16_t hornRequest);
void CAN_dash_command_dlc_set(uint8_t dlc);


void CAN_dash_command_send(void);


#define CAN_dash_data1_interval() 10
void CAN_dash_data1_speed_set(uint16_t speed);
void CAN_dash_data1_odometer_set(uint16_t odometer);
void CAN_dash_data1_tripA_set(uint16_t tripA);
void CAN_dash_data1_tripB_set(uint16_t tripB);
void CAN_dash_data1_dlc_set(uint8_t dlc);


void CAN_dash_data1_send(void);


#define CAN_dash_data2_interval() 10
void CAN_dash_data2_runningTime_set(uint16_t runningTime);
void CAN_dash_data2_odometer_set(uint16_t odometer);
void CAN_dash_data2_tripA_set(uint16_t tripA);
void CAN_dash_data2_tripB_set(uint16_t tripB);
void CAN_dash_data2_dlc_set(uint8_t dlc);


void CAN_dash_data2_send(void);


/**********************************************************
 * mcu NODE MESSAGES
 */
#define CAN_mcu_status_interval() 10
uint8_t CAN_mcu_status_checkDataIsFresh(void);
uint16_t CAN_mcu_status_heartbeat_get(void);
uint16_t CAN_mcu_status_highBeam_get(void);
uint16_t CAN_mcu_status_lowBeam_get(void);
uint16_t CAN_mcu_status_brakeLight_get(void);
uint16_t CAN_mcu_status_tailLight_get(void);
uint16_t CAN_mcu_status_horn_get(void);
uint16_t CAN_mcu_status_turnSignalFR_get(void);
uint16_t CAN_mcu_status_turnSignalFL_get(void);
uint16_t CAN_mcu_status_turnSignalRR_get(void);
uint16_t CAN_mcu_status_turnSignalRL_get(void);
uint16_t CAN_mcu_status_brakeSwitchFront_get(void);
uint16_t CAN_mcu_status_brakeSwitchRear_get(void);
uint16_t CAN_mcu_status_killSwitch_get(void);
uint16_t CAN_mcu_status_ignitionSwitch_get(void);
uint16_t CAN_mcu_status_leftTurnSwitch_get(void);
uint16_t CAN_mcu_status_rightTurnSwitch_get(void);
uint16_t CAN_mcu_status_lightSwitch_get(void);
uint16_t CAN_mcu_status_assSwitch_get(void);
uint16_t CAN_mcu_status_hornSwitch_get(void);
float CAN_mcu_status_batt_voltage_get(void);
float CAN_mcu_status_batt_current_get(void);
float CAN_mcu_status_dcdc_current_get(void);
uint16_t CAN_mcu_status_batt_fault_get(void);
uint16_t CAN_mcu_status_dcdc_fault_get(void);

#define CAN_mcu_command_interval() 100
uint8_t CAN_mcu_command_checkDataIsFresh(void);
uint16_t CAN_mcu_command_DCDC_enable_get(void);
uint16_t CAN_mcu_command_ev_charger_enable_get(void);
float CAN_mcu_command_ev_charger_current_get(void);
uint16_t CAN_mcu_command_precharge_enable_get(void);
uint16_t CAN_mcu_command_motor_controller_enable_get(void);

#define CAN_mcu_mcu_debug_interval() 10
#define CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES 4
uint8_t CAN_mcu_mcu_debug_checkDataIsFresh(void);
uint16_t CAN_mcu_mcu_debug_Multiplex_get(void);
uint16_t CAN_mcu_mcu_debug_M0_debug_value_1_get(void);
uint16_t CAN_mcu_mcu_debug_M0_debug_value_2_get(void);
uint16_t CAN_mcu_mcu_debug_M0_debug_value_3_get(void);
uint16_t CAN_mcu_mcu_debug_M0_debug_value_4_get(void);
uint16_t CAN_mcu_mcu_debug_M1_debug_value_5_get(void);
uint16_t CAN_mcu_mcu_debug_M1_debug_value_6_get(void);
uint16_t CAN_mcu_mcu_debug_M1_debug_value_7_get(void);
uint16_t CAN_mcu_mcu_debug_M1_debug_value_8_get(void);
uint16_t CAN_mcu_mcu_debug_M2_debug_value_9_get(void);
uint16_t CAN_mcu_mcu_debug_M2_debug_value_10_get(void);
uint16_t CAN_mcu_mcu_debug_M2_debug_value_11_get(void);
uint16_t CAN_mcu_mcu_debug_M2_debug_value_12_get(void);
uint16_t CAN_mcu_mcu_debug_M3_debug_value_13_get(void);
uint16_t CAN_mcu_mcu_debug_M3_debug_value_14_get(void);
uint16_t CAN_mcu_mcu_debug_M3_debug_value_15_get(void);
uint16_t CAN_mcu_mcu_debug_M3_debug_value_16_get(void);

/**********************************************************
 * bms NODE MESSAGES
 */
#define CAN_bms_status_interval() 10
#define CAN_BMS_STATUS_NUM_MUX_VALUES 4
uint8_t CAN_bms_status_checkDataIsFresh(void);
uint16_t CAN_bms_status_multiplex_get(void);
uint16_t CAN_bms_status_M0_bms_state_get(void);
float CAN_bms_status_M0_pack_voltage_get(void);
float CAN_bms_status_M0_pack_current_get(void);
float CAN_bms_status_M0_soc_percent_get(void);
float CAN_bms_status_M0_pack_temp_min_get(void);
float CAN_bms_status_M0_pack_temp_max_get(void);
float CAN_bms_status_M1_stack_voltage_1_get(void);
float CAN_bms_status_M1_stack_voltage_2_get(void);
float CAN_bms_status_M1_pack_voltage_sum_of_stacks_get(void);
uint16_t CAN_bms_status_M1_debug_signal_1_get(void);
uint16_t CAN_bms_status_M2_ltc_state_get(void);
uint16_t CAN_bms_status_M2_ltc_error_count_get(void);
uint16_t CAN_bms_status_M2_ltc_last_error_get(void);
float CAN_bms_status_M2_cpu_usage_percent_get(void);
float CAN_bms_status_M2_cpu_peak_percent_get(void);
float CAN_bms_status_M2_vbus_voltage_get(void);
float CAN_bms_status_M2_internal_temp_get(void);
uint16_t CAN_bms_status_M3_max_charge_current_mA_get(void);
uint32_t CAN_bms_status_M3_max_charge_voltage_mV_get(void);
uint16_t CAN_bms_status_M3_contactors_closed_get(void);
uint16_t CAN_bms_status_M3_precharge_active_get(void);
uint16_t CAN_bms_status_M3_charge_enabled_get(void);
uint16_t CAN_bms_status_M3_discharge_enabled_get(void);
uint16_t CAN_bms_status_M3_fault_summary_get(void);

#define CAN_bms_power_systems_interval() 10
uint8_t CAN_bms_power_systems_checkDataIsFresh(void);
uint16_t CAN_bms_power_systems_DCDC_state_get(void);
uint16_t CAN_bms_power_systems_DCDC_fault_get(void);
float CAN_bms_power_systems_DCDC_voltage_get(void);
float CAN_bms_power_systems_DCDC_current_get(void);
uint16_t CAN_bms_power_systems_EV_charger_state_get(void);
uint16_t CAN_bms_power_systems_EV_charger_fault_get(void);
float CAN_bms_power_systems_EV_charger_voltage_get(void);
float CAN_bms_power_systems_EV_charger_current_get(void);
uint16_t CAN_bms_power_systems_HV_precharge_state_get(void);
float CAN_bms_power_systems_HV_isolation_voltage_get(void);
uint16_t CAN_bms_power_systems_HV_contactor_state_get(void);

#define CAN_bms_debug_interval() 10
uint8_t CAN_bms_debug_checkDataIsFresh(void);
uint16_t CAN_bms_debug_bool0_get(void);
uint16_t CAN_bms_debug_bool1_get(void);
float CAN_bms_debug_float1_get(void);
float CAN_bms_debug_float2_get(void);
float CAN_bms_debug_VBUS_Voltage_get(void);
float CAN_bms_debug_CPU_USAGE_get(void);
float CAN_bms_debug_CPU_peak_get(void);

#define CAN_bms_charger_request_interval() 1000
uint8_t CAN_bms_charger_request_checkDataIsFresh(void);
uint16_t CAN_bms_charger_request_output_voltage_high_byte_get(void);
uint16_t CAN_bms_charger_request_output_voltage_low_byte_get(void);
uint16_t CAN_bms_charger_request_output_current_high_byte_get(void);
uint16_t CAN_bms_charger_request_output_current_low_byte_get(void);
uint16_t CAN_bms_charger_request_start_charge_not_request_get(void);
uint16_t CAN_bms_charger_request_charge_mode_get(void);
uint16_t CAN_bms_charger_request_byte_7_get(void);
uint16_t CAN_bms_charger_request_byte_8_get(void);

#define CAN_bms_cell_voltages_interval() 10
#define CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES 6
uint8_t CAN_bms_cell_voltages_checkDataIsFresh(void);
uint16_t CAN_bms_cell_voltages_multiplex_get(void);
uint16_t CAN_bms_cell_voltages_M0_cell_1_voltage_get(void);
uint16_t CAN_bms_cell_voltages_M0_cell_2_voltage_get(void);
uint16_t CAN_bms_cell_voltages_M0_cell_3_voltage_get(void);
uint16_t CAN_bms_cell_voltages_M0_cell_4_voltage_get(void);
uint16_t CAN_bms_cell_voltages_M1_cell_5_voltage_get(void);
uint16_t CAN_bms_cell_voltages_M1_cell_6_voltage_get(void);
uint16_t CAN_bms_cell_voltages_M1_cell_7_voltage_get(void);
uint16_t CAN_bms_cell_voltages_M1_cell_8_voltage_get(void);
uint16_t CAN_bms_cell_voltages_M2_cell_9_voltage_get(void);
uint16_t CAN_bms_cell_voltages_M2_cell_10_voltage_get(void);
uint16_t CAN_bms_cell_voltages_M2_cell_11_voltage_get(void);
uint16_t CAN_bms_cell_voltages_M2_cell_12_voltage_get(void);
uint16_t CAN_bms_cell_voltages_M3_cell_13_voltage_get(void);
uint16_t CAN_bms_cell_voltages_M3_cell_14_voltage_get(void);
uint16_t CAN_bms_cell_voltages_M3_cell_15_voltage_get(void);
uint16_t CAN_bms_cell_voltages_M3_cell_16_voltage_get(void);
uint16_t CAN_bms_cell_voltages_M4_cell_17_voltage_get(void);
uint16_t CAN_bms_cell_voltages_M4_cell_18_voltage_get(void);
uint16_t CAN_bms_cell_voltages_M4_cell_19_voltage_get(void);
uint16_t CAN_bms_cell_voltages_M4_cell_20_voltage_get(void);
uint16_t CAN_bms_cell_voltages_M5_cell_21_voltage_get(void);
uint16_t CAN_bms_cell_voltages_M5_cell_22_voltage_get(void);
uint16_t CAN_bms_cell_voltages_M5_cell_23_voltage_get(void);
uint16_t CAN_bms_cell_voltages_M5_cell_24_voltage_get(void);

#define CAN_bms_cell_temperatures_interval() 10
#define CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES 6
uint8_t CAN_bms_cell_temperatures_checkDataIsFresh(void);
uint16_t CAN_bms_cell_temperatures_multiplex_get(void);
float CAN_bms_cell_temperatures_M0_temp_1_get(void);
float CAN_bms_cell_temperatures_M0_temp_2_get(void);
float CAN_bms_cell_temperatures_M0_temp_3_get(void);
float CAN_bms_cell_temperatures_M0_temp_4_get(void);
float CAN_bms_cell_temperatures_M1_temp_5_get(void);
float CAN_bms_cell_temperatures_M1_temp_6_get(void);
float CAN_bms_cell_temperatures_M1_temp_7_get(void);
float CAN_bms_cell_temperatures_M1_temp_8_get(void);
float CAN_bms_cell_temperatures_M2_temp_9_get(void);
float CAN_bms_cell_temperatures_M2_temp_10_get(void);
float CAN_bms_cell_temperatures_M2_temp_11_get(void);
float CAN_bms_cell_temperatures_M2_temp_12_get(void);
float CAN_bms_cell_temperatures_M3_temp_13_get(void);
float CAN_bms_cell_temperatures_M3_temp_14_get(void);
float CAN_bms_cell_temperatures_M3_temp_15_get(void);
float CAN_bms_cell_temperatures_M3_temp_16_get(void);
float CAN_bms_cell_temperatures_M4_temp_17_get(void);
float CAN_bms_cell_temperatures_M4_temp_18_get(void);
float CAN_bms_cell_temperatures_M4_temp_19_get(void);
float CAN_bms_cell_temperatures_M4_temp_20_get(void);
float CAN_bms_cell_temperatures_M5_temp_21_get(void);
float CAN_bms_cell_temperatures_M5_temp_22_get(void);
float CAN_bms_cell_temperatures_M5_temp_23_get(void);
float CAN_bms_cell_temperatures_M5_temp_24_get(void);

/**********************************************************
 * motorcontroller NODE MESSAGES
 */
/**********************************************************
 * charger NODE MESSAGES
 */
/**********************************************************
 * boot_host NODE MESSAGES
 */
#define CAN_boot_host_dash_interval() 1
uint8_t CAN_boot_host_dash_checkDataIsFresh(void);
uint16_t CAN_boot_host_dash_type_get(void);
uint16_t CAN_boot_host_dash_code_get(void);
uint16_t CAN_boot_host_dash_byte1_get(void);
uint16_t CAN_boot_host_dash_byte2_get(void);
uint16_t CAN_boot_host_dash_byte3_get(void);
uint16_t CAN_boot_host_dash_byte4_get(void);
uint16_t CAN_boot_host_dash_byte5_get(void);
uint16_t CAN_boot_host_dash_byte6_get(void);
uint16_t CAN_boot_host_dash_byte7_get(void);

void CAN_DBC_init();

void CAN_send_1ms(void);
void CAN_send_10ms(void);
void CAN_send_100ms(void);
void CAN_send_1000ms(void);


#endif /*dash_DBC_H*/
