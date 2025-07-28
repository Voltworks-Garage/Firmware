#ifndef mcu_DBC_H
#define mcu_DBC_H

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
uint8_t CAN_dash_status_checkDataIsFresh(void);
uint16_t CAN_dash_status_heartBeat_get(void);
uint16_t CAN_dash_status_state_get(void);
uint16_t CAN_dash_status_killButton_get(void);
uint16_t CAN_dash_status_ignButton_get(void);
uint16_t CAN_dash_status_modeButton_get(void);
uint16_t CAN_dash_status_selectButton_get(void);
uint16_t CAN_dash_status_driveMode_get(void);

#define CAN_dash_command_interval() 10
uint8_t CAN_dash_command_checkDataIsFresh(void);
uint16_t CAN_dash_command_ignitionRequest_get(void);
uint16_t CAN_dash_command_killRequest_get(void);
uint16_t CAN_dash_command_batteryEjectRequest_get(void);
uint16_t CAN_dash_command_lightsRequest_get(void);
uint16_t CAN_dash_command_hornRequest_get(void);

#define CAN_dash_data1_interval() 10
uint8_t CAN_dash_data1_checkDataIsFresh(void);
uint16_t CAN_dash_data1_speed_get(void);
uint16_t CAN_dash_data1_odometer_get(void);
uint16_t CAN_dash_data1_tripA_get(void);
uint16_t CAN_dash_data1_tripB_get(void);

#define CAN_dash_data2_interval() 10
uint8_t CAN_dash_data2_checkDataIsFresh(void);
uint16_t CAN_dash_data2_runningTime_get(void);
uint16_t CAN_dash_data2_odometer_get(void);
uint16_t CAN_dash_data2_tripA_get(void);
uint16_t CAN_dash_data2_tripB_get(void);

/**********************************************************
 * mcu NODE MESSAGES
 */
#define CAN_mcu_status_interval() 10
void CAN_mcu_status_heartbeat_set(uint16_t heartbeat);
void CAN_mcu_status_highBeam_set(uint16_t highBeam);
void CAN_mcu_status_lowBeam_set(uint16_t lowBeam);
void CAN_mcu_status_brakeLight_set(uint16_t brakeLight);
void CAN_mcu_status_tailLight_set(uint16_t tailLight);
void CAN_mcu_status_horn_set(uint16_t horn);
void CAN_mcu_status_turnSignalFR_set(uint16_t turnSignalFR);
void CAN_mcu_status_turnSignalFL_set(uint16_t turnSignalFL);
void CAN_mcu_status_turnSignalRR_set(uint16_t turnSignalRR);
void CAN_mcu_status_turnSignalRL_set(uint16_t turnSignalRL);
void CAN_mcu_status_brakeSwitchFront_set(uint16_t brakeSwitchFront);
void CAN_mcu_status_brakeSwitchRear_set(uint16_t brakeSwitchRear);
void CAN_mcu_status_killSwitch_set(uint16_t killSwitch);
void CAN_mcu_status_ignitionSwitch_set(uint16_t ignitionSwitch);
void CAN_mcu_status_leftTurnSwitch_set(uint16_t leftTurnSwitch);
void CAN_mcu_status_rightTurnSwitch_set(uint16_t rightTurnSwitch);
void CAN_mcu_status_lightSwitch_set(uint16_t lightSwitch);
void CAN_mcu_status_assSwitch_set(uint16_t assSwitch);
void CAN_mcu_status_hornSwitch_set(uint16_t hornSwitch);
void CAN_mcu_status_batt_voltage_set(float batt_voltage);
void CAN_mcu_status_batt_current_set(float batt_current);
void CAN_mcu_status_dcdc_current_set(float dcdc_current);
void CAN_mcu_status_batt_fault_set(uint16_t batt_fault);
void CAN_mcu_status_dcdc_fault_set(uint16_t dcdc_fault);
void CAN_mcu_status_dlc_set(uint8_t dlc);


void CAN_mcu_status_send(void);


#define CAN_mcu_command_interval() 100
void CAN_mcu_command_DCDC_enable_set(uint16_t DCDC_enable);
void CAN_mcu_command_ev_charger_enable_set(uint16_t ev_charger_enable);
void CAN_mcu_command_ev_charger_current_set(float ev_charger_current);
void CAN_mcu_command_precharge_enable_set(uint16_t precharge_enable);
void CAN_mcu_command_motor_controller_enable_set(uint16_t motor_controller_enable);
void CAN_mcu_command_dlc_set(uint8_t dlc);


void CAN_mcu_command_send(void);


#define CAN_mcu_motorControllerRequest_interval() 1
void CAN_mcu_motorControllerRequest_requestType_set(uint16_t requestType);
void CAN_mcu_motorControllerRequest_dlc_set(uint8_t dlc);


void CAN_mcu_motorControllerRequest_send(void);


void CAN_mcu_boot_response_type_set(uint16_t type);
void CAN_mcu_boot_response_code_set(uint16_t code);
void CAN_mcu_boot_response_byte1_set(uint16_t byte1);
void CAN_mcu_boot_response_byte2_set(uint16_t byte2);
void CAN_mcu_boot_response_byte3_set(uint16_t byte3);
void CAN_mcu_boot_response_byte4_set(uint16_t byte4);
void CAN_mcu_boot_response_byte5_set(uint16_t byte5);
void CAN_mcu_boot_response_byte6_set(uint16_t byte6);
void CAN_mcu_boot_response_byte7_set(uint16_t byte7);
void CAN_mcu_boot_response_dlc_set(uint8_t dlc);


void CAN_mcu_boot_response_send(void);


#define CAN_mcu_mcu_debug_interval() 10
void CAN_mcu_mcu_debug_M0_debug_value_1_set(uint16_t debug_value_1);
void CAN_mcu_mcu_debug_M0_debug_value_2_set(uint16_t debug_value_2);
void CAN_mcu_mcu_debug_M0_debug_value_3_set(uint16_t debug_value_3);
void CAN_mcu_mcu_debug_M0_debug_value_4_set(uint16_t debug_value_4);
void CAN_mcu_mcu_debug_M1_debug_value_5_set(uint16_t debug_value_5);
void CAN_mcu_mcu_debug_M1_debug_value_6_set(uint16_t debug_value_6);
void CAN_mcu_mcu_debug_M1_debug_value_7_set(uint16_t debug_value_7);
void CAN_mcu_mcu_debug_M1_debug_value_8_set(uint16_t debug_value_8);
void CAN_mcu_mcu_debug_M2_debug_value_9_set(uint16_t debug_value_9);
void CAN_mcu_mcu_debug_M2_debug_value_10_set(uint16_t debug_value_10);
void CAN_mcu_mcu_debug_M2_debug_value_11_set(uint16_t debug_value_11);
void CAN_mcu_mcu_debug_M2_debug_value_12_set(uint16_t debug_value_12);
void CAN_mcu_mcu_debug_M3_debug_value_13_set(uint16_t debug_value_13);
void CAN_mcu_mcu_debug_M3_debug_value_14_set(uint16_t debug_value_14);
void CAN_mcu_mcu_debug_M3_debug_value_15_set(uint16_t debug_value_15);
void CAN_mcu_mcu_debug_M3_debug_value_16_set(uint16_t debug_value_16);
void CAN_mcu_mcu_debug_dlc_set(uint8_t dlc);


void CAN_mcu_mcu_debug_send(void);


#define CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES 4
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
#define CAN_motorcontroller_motorStatus_interval() 10
uint8_t CAN_motorcontroller_motorStatus_checkDataIsFresh(void);
uint16_t CAN_motorcontroller_motorStatus_motorSpeed_get(void);
float CAN_motorcontroller_motorStatus_motorCurrent_get(void);
uint16_t CAN_motorcontroller_motorStatus_IphaseA_get(void);
uint16_t CAN_motorcontroller_motorStatus_IphaseB_get(void);
uint16_t CAN_motorcontroller_motorStatus_IphaseC_get(void);
uint16_t CAN_motorcontroller_motorStatus_VphaseA_get(void);
uint16_t CAN_motorcontroller_motorStatus_VphaseB_get(void);
uint16_t CAN_motorcontroller_motorStatus_VphaseC_get(void);

uint8_t CAN_motorcontroller_response_checkDataIsFresh(void);
uint16_t CAN_motorcontroller_response_byte1_get(void);
uint16_t CAN_motorcontroller_response_byte2_get(void);
uint16_t CAN_motorcontroller_response_byte3_get(void);
uint16_t CAN_motorcontroller_response_byte4_get(void);
uint16_t CAN_motorcontroller_response_byte5_get(void);
uint16_t CAN_motorcontroller_response_byte6_get(void);
uint16_t CAN_motorcontroller_response_byte7_get(void);
uint16_t CAN_motorcontroller_response_byte8_get(void);

/**********************************************************
 * charger NODE MESSAGES
 */
/**********************************************************
 * boot_host NODE MESSAGES
 */
#define CAN_boot_host_mcu_interval() 1
uint8_t CAN_boot_host_mcu_checkDataIsFresh(void);
uint16_t CAN_boot_host_mcu_type_get(void);
uint16_t CAN_boot_host_mcu_code_get(void);
uint16_t CAN_boot_host_mcu_byte1_get(void);
uint16_t CAN_boot_host_mcu_byte2_get(void);
uint16_t CAN_boot_host_mcu_byte3_get(void);
uint16_t CAN_boot_host_mcu_byte4_get(void);
uint16_t CAN_boot_host_mcu_byte5_get(void);
uint16_t CAN_boot_host_mcu_byte6_get(void);
uint16_t CAN_boot_host_mcu_byte7_get(void);

void CAN_DBC_init();

void CAN_send_1ms(void);
void CAN_send_10ms(void);
void CAN_send_100ms(void);
void CAN_send_1000ms(void);


#endif /*mcu_DBC_H*/
