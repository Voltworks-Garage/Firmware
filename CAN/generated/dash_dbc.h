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
#define CAN_MCU_STATUS_NUM_MUX_VALUES 5
uint8_t CAN_mcu_status_checkDataIsUnread(void);
uint8_t CAN_mcu_status_checkDataIsStale(void);
uint16_t CAN_mcu_status_multiplex_get(void);
uint16_t CAN_mcu_status_vehicleState_get(void);
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
uint16_t CAN_mcu_status_fan_fault_get(void);
uint16_t CAN_mcu_status_pump_fault_get(void);
uint16_t CAN_mcu_status_taillight_fault_get(void);
uint16_t CAN_mcu_status_brakelight_fault_get(void);
uint16_t CAN_mcu_status_lowbeam_fault_get(void);
uint16_t CAN_mcu_status_highbeam_fault_get(void);
uint16_t CAN_mcu_status_horn_fault_get(void);
uint16_t CAN_mcu_status_aux_port_fault_get(void);
uint16_t CAN_mcu_status_heated_grips_fault_get(void);
uint16_t CAN_mcu_status_heated_seat_fault_get(void);
uint16_t CAN_mcu_status_charge_controller_fault_get(void);
uint16_t CAN_mcu_status_motor_controller_fault_get(void);
uint16_t CAN_mcu_status_bms_controller_fault_get(void);
uint16_t CAN_mcu_status_spare_1_controller_fault_get(void);
uint16_t CAN_mcu_status_ic_controller_fault_get(void);
float CAN_mcu_status_fan_current_get(void);
float CAN_mcu_status_pump_current_get(void);
float CAN_mcu_status_taillight_current_get(void);
float CAN_mcu_status_brakelight_current_get(void);
float CAN_mcu_status_lowbeam_current_get(void);
float CAN_mcu_status_highbeam_current_get(void);
float CAN_mcu_status_horn_current_get(void);
float CAN_mcu_status_aux_port_current_get(void);
float CAN_mcu_status_heated_grips_current_get(void);
float CAN_mcu_status_heated_seat_current_get(void);
float CAN_mcu_status_charge_controller_current_get(void);
float CAN_mcu_status_motor_controller_current_get(void);
float CAN_mcu_status_bms_controller_current_get(void);
float CAN_mcu_status_spare_1_controller_current_get(void);

#define CAN_mcu_command_interval() 100
uint8_t CAN_mcu_command_checkDataIsUnread(void);
uint8_t CAN_mcu_command_checkDataIsStale(void);
uint16_t CAN_mcu_command_DCDC_enable_get(void);
uint16_t CAN_mcu_command_ev_charger_enable_get(void);
float CAN_mcu_command_ev_charger_current_get(void);
uint16_t CAN_mcu_command_precharge_enable_get(void);
uint16_t CAN_mcu_command_motor_controller_enable_get(void);

#define CAN_mcu_mcu_debug_interval() 10
#define CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES 4
uint8_t CAN_mcu_mcu_debug_checkDataIsUnread(void);
uint8_t CAN_mcu_mcu_debug_checkDataIsStale(void);
uint16_t CAN_mcu_mcu_debug_Multiplex_get(void);
float CAN_mcu_mcu_debug_cpu_usage_percent_get(void);
float CAN_mcu_mcu_debug_cpu_peak_percent_get(void);
uint16_t CAN_mcu_mcu_debug_debug_value_3_get(void);
uint16_t CAN_mcu_mcu_debug_debug_value_4_get(void);
uint16_t CAN_mcu_mcu_debug_debug_value_5_get(void);
uint16_t CAN_mcu_mcu_debug_debug_value_6_get(void);
uint16_t CAN_mcu_mcu_debug_debug_value_7_get(void);
uint16_t CAN_mcu_mcu_debug_debug_value_8_get(void);
uint16_t CAN_mcu_mcu_debug_debug_value_9_get(void);
uint16_t CAN_mcu_mcu_debug_debug_value_10_get(void);
uint16_t CAN_mcu_mcu_debug_debug_value_11_get(void);
uint16_t CAN_mcu_mcu_debug_debug_value_12_get(void);
uint16_t CAN_mcu_mcu_debug_debug_value_13_get(void);
uint16_t CAN_mcu_mcu_debug_debug_value_14_get(void);
uint16_t CAN_mcu_mcu_debug_debug_value_15_get(void);
uint16_t CAN_mcu_mcu_debug_debug_value_16_get(void);

/**********************************************************
 * bms NODE MESSAGES
 */
#define CAN_bms_status_interval() 10
#define CAN_BMS_STATUS_NUM_MUX_VALUES 5
uint8_t CAN_bms_status_checkDataIsUnread(void);
uint8_t CAN_bms_status_checkDataIsStale(void);
uint16_t CAN_bms_status_multiplex_get(void);
uint16_t CAN_bms_status_bms_state_get(void);
float CAN_bms_status_pack_voltage_get(void);
float CAN_bms_status_pack_current_get(void);
float CAN_bms_status_soc_percent_get(void);
float CAN_bms_status_pack_temp_min_get(void);
float CAN_bms_status_pack_temp_max_get(void);
float CAN_bms_status_stack_voltage_1_get(void);
float CAN_bms_status_stack_voltage_2_get(void);
float CAN_bms_status_pack_voltage_sum_of_stacks_get(void);
uint16_t CAN_bms_status_ltc_state_get(void);
uint16_t CAN_bms_status_ltc_error_count_get(void);
uint16_t CAN_bms_status_ltc_last_error_get(void);
float CAN_bms_status_cpu_usage_percent_get(void);
float CAN_bms_status_cpu_peak_percent_get(void);
float CAN_bms_status_vbus_voltage_get(void);
float CAN_bms_status_internal_temp_get(void);
uint16_t CAN_bms_status_max_charge_current_mA_get(void);
uint32_t CAN_bms_status_max_charge_voltage_mV_get(void);
uint16_t CAN_bms_status_contactors_closed_get(void);
uint16_t CAN_bms_status_precharge_active_get(void);
uint16_t CAN_bms_status_charge_enabled_get(void);
uint16_t CAN_bms_status_discharge_enabled_get(void);
uint16_t CAN_bms_status_fault_summary_get(void);
uint16_t CAN_bms_status_is_balancing_get(void);
uint16_t CAN_bms_status_cell_A_balancing_get(void);
uint16_t CAN_bms_status_cell_B_balancing_get(void);
uint16_t CAN_bms_status_cell_C_balancing_get(void);
uint16_t CAN_bms_status_cell_D_balancing_get(void);
uint16_t CAN_bms_status_cell_E_balancing_get(void);

#define CAN_bms_power_systems_interval() 10
uint8_t CAN_bms_power_systems_checkDataIsUnread(void);
uint8_t CAN_bms_power_systems_checkDataIsStale(void);
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
uint8_t CAN_bms_debug_checkDataIsUnread(void);
uint8_t CAN_bms_debug_checkDataIsStale(void);
uint16_t CAN_bms_debug_bool0_get(void);
uint16_t CAN_bms_debug_bool1_get(void);
float CAN_bms_debug_float1_get(void);
float CAN_bms_debug_float2_get(void);
uint16_t CAN_bms_debug_word1_get(void);
uint16_t CAN_bms_debug_byte1_get(void);

#define CAN_bms_charger_request_interval() 1000
uint8_t CAN_bms_charger_request_checkDataIsUnread(void);
uint8_t CAN_bms_charger_request_checkDataIsStale(void);
uint16_t CAN_bms_charger_request_output_voltage_high_byte_get(void);
uint16_t CAN_bms_charger_request_output_voltage_low_byte_get(void);
uint16_t CAN_bms_charger_request_output_current_high_byte_get(void);
uint16_t CAN_bms_charger_request_output_current_low_byte_get(void);
uint16_t CAN_bms_charger_request_start_charge_not_request_get(void);
uint16_t CAN_bms_charger_request_charge_mode_get(void);
uint16_t CAN_bms_charger_request_byte_7_get(void);
uint16_t CAN_bms_charger_request_byte_8_get(void);

#define CAN_bms_cell_voltages_interval() 100
#define CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES 6
uint8_t CAN_bms_cell_voltages_checkDataIsUnread(void);
uint8_t CAN_bms_cell_voltages_checkDataIsStale(void);
uint16_t CAN_bms_cell_voltages_multiplex_get(void);
uint16_t CAN_bms_cell_voltages_cell_1_voltage_get(void);
uint16_t CAN_bms_cell_voltages_cell_2_voltage_get(void);
uint16_t CAN_bms_cell_voltages_cell_3_voltage_get(void);
uint16_t CAN_bms_cell_voltages_cell_4_voltage_get(void);
uint16_t CAN_bms_cell_voltages_cell_5_voltage_get(void);
uint16_t CAN_bms_cell_voltages_cell_6_voltage_get(void);
uint16_t CAN_bms_cell_voltages_cell_7_voltage_get(void);
uint16_t CAN_bms_cell_voltages_cell_8_voltage_get(void);
uint16_t CAN_bms_cell_voltages_cell_9_voltage_get(void);
uint16_t CAN_bms_cell_voltages_cell_10_voltage_get(void);
uint16_t CAN_bms_cell_voltages_cell_11_voltage_get(void);
uint16_t CAN_bms_cell_voltages_cell_12_voltage_get(void);
uint16_t CAN_bms_cell_voltages_cell_13_voltage_get(void);
uint16_t CAN_bms_cell_voltages_cell_14_voltage_get(void);
uint16_t CAN_bms_cell_voltages_cell_15_voltage_get(void);
uint16_t CAN_bms_cell_voltages_cell_16_voltage_get(void);
uint16_t CAN_bms_cell_voltages_cell_17_voltage_get(void);
uint16_t CAN_bms_cell_voltages_cell_18_voltage_get(void);
uint16_t CAN_bms_cell_voltages_cell_19_voltage_get(void);
uint16_t CAN_bms_cell_voltages_cell_20_voltage_get(void);
uint16_t CAN_bms_cell_voltages_cell_21_voltage_get(void);
uint16_t CAN_bms_cell_voltages_cell_22_voltage_get(void);
uint16_t CAN_bms_cell_voltages_cell_23_voltage_get(void);
uint16_t CAN_bms_cell_voltages_cell_24_voltage_get(void);

#define CAN_bms_cell_temperatures_interval() 1000
#define CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES 7
uint8_t CAN_bms_cell_temperatures_checkDataIsUnread(void);
uint8_t CAN_bms_cell_temperatures_checkDataIsStale(void);
uint16_t CAN_bms_cell_temperatures_multiplex_get(void);
float CAN_bms_cell_temperatures_stack_1_LTC_internal_temp_get(void);
float CAN_bms_cell_temperatures_stack_1_balance_temp_get(void);
float CAN_bms_cell_temperatures_stack_2_LTC_internal_temp_get(void);
float CAN_bms_cell_temperatures_stack_2_balance_temp_get(void);
float CAN_bms_cell_temperatures_temp_1_get(void);
float CAN_bms_cell_temperatures_temp_2_get(void);
float CAN_bms_cell_temperatures_temp_3_get(void);
float CAN_bms_cell_temperatures_temp_4_get(void);
float CAN_bms_cell_temperatures_temp_5_get(void);
float CAN_bms_cell_temperatures_temp_6_get(void);
float CAN_bms_cell_temperatures_temp_7_get(void);
float CAN_bms_cell_temperatures_temp_8_get(void);
float CAN_bms_cell_temperatures_temp_9_get(void);
float CAN_bms_cell_temperatures_temp_10_get(void);
float CAN_bms_cell_temperatures_temp_11_get(void);
float CAN_bms_cell_temperatures_temp_12_get(void);
float CAN_bms_cell_temperatures_temp_13_get(void);
float CAN_bms_cell_temperatures_temp_14_get(void);
float CAN_bms_cell_temperatures_temp_15_get(void);
float CAN_bms_cell_temperatures_temp_16_get(void);
float CAN_bms_cell_temperatures_temp_17_get(void);
float CAN_bms_cell_temperatures_temp_18_get(void);
float CAN_bms_cell_temperatures_temp_19_get(void);
float CAN_bms_cell_temperatures_temp_20_get(void);
float CAN_bms_cell_temperatures_temp_21_get(void);
float CAN_bms_cell_temperatures_temp_22_get(void);
float CAN_bms_cell_temperatures_temp_23_get(void);
float CAN_bms_cell_temperatures_temp_24_get(void);

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
uint8_t CAN_boot_host_dash_checkDataIsUnread(void);
uint8_t CAN_boot_host_dash_checkDataIsStale(void);
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
