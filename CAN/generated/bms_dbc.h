#ifndef bms_DBC_H
#define bms_DBC_H

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
uint16_t CAN_mcu_mcu_debug_debug_value_1_get(void);
uint16_t CAN_mcu_mcu_debug_debug_value_2_get(void);
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
void CAN_bms_status_bms_state_set(uint16_t bms_state);
void CAN_bms_status_pack_voltage_set(float pack_voltage);
void CAN_bms_status_pack_current_set(float pack_current);
void CAN_bms_status_soc_percent_set(float soc_percent);
void CAN_bms_status_pack_temp_min_set(float pack_temp_min);
void CAN_bms_status_pack_temp_max_set(float pack_temp_max);
void CAN_bms_status_stack_voltage_1_set(float stack_voltage_1);
void CAN_bms_status_stack_voltage_2_set(float stack_voltage_2);
void CAN_bms_status_pack_voltage_sum_of_stacks_set(float pack_voltage_sum_of_stacks);
void CAN_bms_status_ltc_state_set(uint16_t ltc_state);
void CAN_bms_status_ltc_error_count_set(uint16_t ltc_error_count);
void CAN_bms_status_ltc_last_error_set(uint16_t ltc_last_error);
void CAN_bms_status_cpu_usage_percent_set(float cpu_usage_percent);
void CAN_bms_status_cpu_peak_percent_set(float cpu_peak_percent);
void CAN_bms_status_vbus_voltage_set(float vbus_voltage);
void CAN_bms_status_internal_temp_set(float internal_temp);
void CAN_bms_status_max_charge_current_mA_set(uint16_t max_charge_current_mA);
void CAN_bms_status_max_charge_voltage_mV_set(uint32_t max_charge_voltage_mV);
void CAN_bms_status_contactors_closed_set(uint16_t contactors_closed);
void CAN_bms_status_precharge_active_set(uint16_t precharge_active);
void CAN_bms_status_charge_enabled_set(uint16_t charge_enabled);
void CAN_bms_status_discharge_enabled_set(uint16_t discharge_enabled);
void CAN_bms_status_fault_summary_set(uint16_t fault_summary);
void CAN_bms_status_is_balancing_set(uint16_t is_balancing);
void CAN_bms_status_cell_A_balancing_set(uint16_t cell_A_balancing);
void CAN_bms_status_cell_B_balancing_set(uint16_t cell_B_balancing);
void CAN_bms_status_cell_C_balancing_set(uint16_t cell_C_balancing);
void CAN_bms_status_cell_D_balancing_set(uint16_t cell_D_balancing);
void CAN_bms_status_cell_E_balancing_set(uint16_t cell_E_balancing);
uint8_t CAN_bms_status_checkDataIsFresh(void);
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

void CAN_bms_status_dlc_set(uint8_t dlc);


void CAN_bms_status_send(void);


#define CAN_BMS_STATUS_NUM_MUX_VALUES 5
#define CAN_bms_power_systems_interval() 10
void CAN_bms_power_systems_DCDC_state_set(uint16_t DCDC_state);
void CAN_bms_power_systems_DCDC_fault_set(uint16_t DCDC_fault);
void CAN_bms_power_systems_DCDC_voltage_set(float DCDC_voltage);
void CAN_bms_power_systems_DCDC_current_set(float DCDC_current);
void CAN_bms_power_systems_EV_charger_state_set(uint16_t EV_charger_state);
void CAN_bms_power_systems_EV_charger_fault_set(uint16_t EV_charger_fault);
void CAN_bms_power_systems_EV_charger_voltage_set(float EV_charger_voltage);
void CAN_bms_power_systems_EV_charger_current_set(float EV_charger_current);
void CAN_bms_power_systems_HV_precharge_state_set(uint16_t HV_precharge_state);
void CAN_bms_power_systems_HV_isolation_voltage_set(float HV_isolation_voltage);
void CAN_bms_power_systems_HV_contactor_state_set(uint16_t HV_contactor_state);
void CAN_bms_power_systems_dlc_set(uint8_t dlc);


void CAN_bms_power_systems_send(void);


#define CAN_bms_debug_interval() 10
void CAN_bms_debug_bool0_set(uint16_t bool0);
void CAN_bms_debug_bool1_set(uint16_t bool1);
void CAN_bms_debug_float1_set(float float1);
void CAN_bms_debug_float2_set(float float2);
void CAN_bms_debug_word1_set(uint16_t word1);
void CAN_bms_debug_byte1_set(uint16_t byte1);
void CAN_bms_debug_dlc_set(uint8_t dlc);


void CAN_bms_debug_send(void);


void CAN_bms_boot_response_type_set(uint16_t type);
void CAN_bms_boot_response_code_set(uint16_t code);
void CAN_bms_boot_response_byte1_set(uint16_t byte1);
void CAN_bms_boot_response_byte2_set(uint16_t byte2);
void CAN_bms_boot_response_byte3_set(uint16_t byte3);
void CAN_bms_boot_response_byte4_set(uint16_t byte4);
void CAN_bms_boot_response_byte5_set(uint16_t byte5);
void CAN_bms_boot_response_byte6_set(uint16_t byte6);
void CAN_bms_boot_response_byte7_set(uint16_t byte7);
void CAN_bms_boot_response_dlc_set(uint8_t dlc);


void CAN_bms_boot_response_send(void);


#define CAN_bms_charger_request_interval() 1000
void CAN_bms_charger_request_output_voltage_high_byte_set(uint16_t output_voltage_high_byte);
void CAN_bms_charger_request_output_voltage_low_byte_set(uint16_t output_voltage_low_byte);
void CAN_bms_charger_request_output_current_high_byte_set(uint16_t output_current_high_byte);
void CAN_bms_charger_request_output_current_low_byte_set(uint16_t output_current_low_byte);
void CAN_bms_charger_request_start_charge_not_request_set(uint16_t start_charge_not_request);
void CAN_bms_charger_request_charge_mode_set(uint16_t charge_mode);
void CAN_bms_charger_request_byte_7_set(uint16_t byte_7);
void CAN_bms_charger_request_byte_8_set(uint16_t byte_8);
uint8_t CAN_bms_charger_request_checkDataIsFresh(void);
uint16_t CAN_bms_charger_request_output_voltage_high_byte_get(void);
uint16_t CAN_bms_charger_request_output_voltage_low_byte_get(void);
uint16_t CAN_bms_charger_request_output_current_high_byte_get(void);
uint16_t CAN_bms_charger_request_output_current_low_byte_get(void);
uint16_t CAN_bms_charger_request_start_charge_not_request_get(void);
uint16_t CAN_bms_charger_request_charge_mode_get(void);
uint16_t CAN_bms_charger_request_byte_7_get(void);
uint16_t CAN_bms_charger_request_byte_8_get(void);

void CAN_bms_charger_request_dlc_set(uint8_t dlc);


void CAN_bms_charger_request_send(void);


#define CAN_bms_cell_voltages_interval() 100
void CAN_bms_cell_voltages_cell_1_voltage_set(uint16_t cell_1_voltage);
void CAN_bms_cell_voltages_cell_2_voltage_set(uint16_t cell_2_voltage);
void CAN_bms_cell_voltages_cell_3_voltage_set(uint16_t cell_3_voltage);
void CAN_bms_cell_voltages_cell_4_voltage_set(uint16_t cell_4_voltage);
void CAN_bms_cell_voltages_cell_5_voltage_set(uint16_t cell_5_voltage);
void CAN_bms_cell_voltages_cell_6_voltage_set(uint16_t cell_6_voltage);
void CAN_bms_cell_voltages_cell_7_voltage_set(uint16_t cell_7_voltage);
void CAN_bms_cell_voltages_cell_8_voltage_set(uint16_t cell_8_voltage);
void CAN_bms_cell_voltages_cell_9_voltage_set(uint16_t cell_9_voltage);
void CAN_bms_cell_voltages_cell_10_voltage_set(uint16_t cell_10_voltage);
void CAN_bms_cell_voltages_cell_11_voltage_set(uint16_t cell_11_voltage);
void CAN_bms_cell_voltages_cell_12_voltage_set(uint16_t cell_12_voltage);
void CAN_bms_cell_voltages_cell_13_voltage_set(uint16_t cell_13_voltage);
void CAN_bms_cell_voltages_cell_14_voltage_set(uint16_t cell_14_voltage);
void CAN_bms_cell_voltages_cell_15_voltage_set(uint16_t cell_15_voltage);
void CAN_bms_cell_voltages_cell_16_voltage_set(uint16_t cell_16_voltage);
void CAN_bms_cell_voltages_cell_17_voltage_set(uint16_t cell_17_voltage);
void CAN_bms_cell_voltages_cell_18_voltage_set(uint16_t cell_18_voltage);
void CAN_bms_cell_voltages_cell_19_voltage_set(uint16_t cell_19_voltage);
void CAN_bms_cell_voltages_cell_20_voltage_set(uint16_t cell_20_voltage);
void CAN_bms_cell_voltages_cell_21_voltage_set(uint16_t cell_21_voltage);
void CAN_bms_cell_voltages_cell_22_voltage_set(uint16_t cell_22_voltage);
void CAN_bms_cell_voltages_cell_23_voltage_set(uint16_t cell_23_voltage);
void CAN_bms_cell_voltages_cell_24_voltage_set(uint16_t cell_24_voltage);
void CAN_bms_cell_voltages_dlc_set(uint8_t dlc);


void CAN_bms_cell_voltages_send(void);


#define CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES 6
#define CAN_bms_cell_temperatures_interval() 1000
void CAN_bms_cell_temperatures_stack_1_LTC_internal_temp_set(float stack_1_LTC_internal_temp);
void CAN_bms_cell_temperatures_stack_1_balance_temp_set(float stack_1_balance_temp);
void CAN_bms_cell_temperatures_stack_2_LTC_internal_temp_set(float stack_2_LTC_internal_temp);
void CAN_bms_cell_temperatures_stack_2_balance_temp_set(float stack_2_balance_temp);
void CAN_bms_cell_temperatures_temp_1_set(float temp_1);
void CAN_bms_cell_temperatures_temp_2_set(float temp_2);
void CAN_bms_cell_temperatures_temp_3_set(float temp_3);
void CAN_bms_cell_temperatures_temp_4_set(float temp_4);
void CAN_bms_cell_temperatures_temp_5_set(float temp_5);
void CAN_bms_cell_temperatures_temp_6_set(float temp_6);
void CAN_bms_cell_temperatures_temp_7_set(float temp_7);
void CAN_bms_cell_temperatures_temp_8_set(float temp_8);
void CAN_bms_cell_temperatures_temp_9_set(float temp_9);
void CAN_bms_cell_temperatures_temp_10_set(float temp_10);
void CAN_bms_cell_temperatures_temp_11_set(float temp_11);
void CAN_bms_cell_temperatures_temp_12_set(float temp_12);
void CAN_bms_cell_temperatures_temp_13_set(float temp_13);
void CAN_bms_cell_temperatures_temp_14_set(float temp_14);
void CAN_bms_cell_temperatures_temp_15_set(float temp_15);
void CAN_bms_cell_temperatures_temp_16_set(float temp_16);
void CAN_bms_cell_temperatures_temp_17_set(float temp_17);
void CAN_bms_cell_temperatures_temp_18_set(float temp_18);
void CAN_bms_cell_temperatures_temp_19_set(float temp_19);
void CAN_bms_cell_temperatures_temp_20_set(float temp_20);
void CAN_bms_cell_temperatures_temp_21_set(float temp_21);
void CAN_bms_cell_temperatures_temp_22_set(float temp_22);
void CAN_bms_cell_temperatures_temp_23_set(float temp_23);
void CAN_bms_cell_temperatures_temp_24_set(float temp_24);
void CAN_bms_cell_temperatures_dlc_set(uint8_t dlc);


void CAN_bms_cell_temperatures_send(void);


#define CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES 7
/**********************************************************
 * motorcontroller NODE MESSAGES
 */
/**********************************************************
 * charger NODE MESSAGES
 */
#define CAN_charger_status_interval() 1000
uint8_t CAN_charger_status_checkDataIsFresh(void);
uint16_t CAN_charger_status_output_voltage_high_byte_get(void);
uint16_t CAN_charger_status_output_voltage_low_byte_get(void);
uint16_t CAN_charger_status_output_current_high_byte_get(void);
uint16_t CAN_charger_status_output_current_low_byte_get(void);
uint16_t CAN_charger_status_hardware_error_get(void);
uint16_t CAN_charger_status_charger_overtemp_error_get(void);
uint16_t CAN_charger_status_input_voltage_error_get(void);
uint16_t CAN_charger_status_battery_detect_error_get(void);
uint16_t CAN_charger_status_communication_error_get(void);
uint16_t CAN_charger_status_byte7_get(void);
uint16_t CAN_charger_status_byte8_get(void);

/**********************************************************
 * boot_host NODE MESSAGES
 */
#define CAN_boot_host_bms_interval() 1
uint8_t CAN_boot_host_bms_checkDataIsFresh(void);
uint16_t CAN_boot_host_bms_type_get(void);
uint16_t CAN_boot_host_bms_code_get(void);
uint16_t CAN_boot_host_bms_byte1_get(void);
uint16_t CAN_boot_host_bms_byte2_get(void);
uint16_t CAN_boot_host_bms_byte3_get(void);
uint16_t CAN_boot_host_bms_byte4_get(void);
uint16_t CAN_boot_host_bms_byte5_get(void);
uint16_t CAN_boot_host_bms_byte6_get(void);
uint16_t CAN_boot_host_bms_byte7_get(void);

void CAN_DBC_init();

void CAN_send_1ms(void);
void CAN_send_10ms(void);
void CAN_send_100ms(void);
void CAN_send_1000ms(void);


#endif /*bms_DBC_H*/
