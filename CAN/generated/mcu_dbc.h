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
uint8_t CAN_dash_status_checkDataIsUnread(void);
uint8_t CAN_dash_status_checkDataIsStale(void);
uint16_t CAN_dash_status_heartBeat_get(void);
uint16_t CAN_dash_status_state_get(void);
uint16_t CAN_dash_status_killButton_get(void);
uint16_t CAN_dash_status_ignButton_get(void);
uint16_t CAN_dash_status_modeButton_get(void);
uint16_t CAN_dash_status_selectButton_get(void);
uint16_t CAN_dash_status_driveMode_get(void);

#define CAN_dash_command_interval() 10
uint8_t CAN_dash_command_checkDataIsUnread(void);
uint8_t CAN_dash_command_checkDataIsStale(void);
uint16_t CAN_dash_command_ignitionRequest_get(void);
uint16_t CAN_dash_command_killRequest_get(void);
uint16_t CAN_dash_command_batteryEjectRequest_get(void);
uint16_t CAN_dash_command_lightsRequest_get(void);
uint16_t CAN_dash_command_hornRequest_get(void);

/**********************************************************
 * mcu NODE MESSAGES
 */
#define CAN_mcu_status_interval() 10
void CAN_mcu_status_vehicleState_set(uint16_t vehicleState);
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
void CAN_mcu_status_fan_fault_set(uint16_t fan_fault);
void CAN_mcu_status_pump_fault_set(uint16_t pump_fault);
void CAN_mcu_status_taillight_fault_set(uint16_t taillight_fault);
void CAN_mcu_status_brakelight_fault_set(uint16_t brakelight_fault);
void CAN_mcu_status_lowbeam_fault_set(uint16_t lowbeam_fault);
void CAN_mcu_status_highbeam_fault_set(uint16_t highbeam_fault);
void CAN_mcu_status_horn_fault_set(uint16_t horn_fault);
void CAN_mcu_status_aux_port_fault_set(uint16_t aux_port_fault);
void CAN_mcu_status_heated_grips_fault_set(uint16_t heated_grips_fault);
void CAN_mcu_status_heated_seat_fault_set(uint16_t heated_seat_fault);
void CAN_mcu_status_charge_controller_fault_set(uint16_t charge_controller_fault);
void CAN_mcu_status_motor_controller_fault_set(uint16_t motor_controller_fault);
void CAN_mcu_status_bms_controller_fault_set(uint16_t bms_controller_fault);
void CAN_mcu_status_J1772_controller_fault_set(uint16_t J1772_controller_fault);
void CAN_mcu_status_ic_controller_fault_set(uint16_t ic_controller_fault);
void CAN_mcu_status_fan_current_set(uint16_t fan_current);
void CAN_mcu_status_pump_current_set(uint16_t pump_current);
void CAN_mcu_status_taillight_current_set(uint16_t taillight_current);
void CAN_mcu_status_brakelight_current_set(uint16_t brakelight_current);
void CAN_mcu_status_lowbeam_current_set(uint16_t lowbeam_current);
void CAN_mcu_status_highbeam_current_set(uint16_t highbeam_current);
void CAN_mcu_status_horn_current_set(uint16_t horn_current);
void CAN_mcu_status_aux_port_current_set(uint16_t aux_port_current);
void CAN_mcu_status_heated_grips_current_set(uint16_t heated_grips_current);
void CAN_mcu_status_heated_seat_current_set(uint16_t heated_seat_current);
void CAN_mcu_status_charge_controller_current_set(uint16_t charge_controller_current);
void CAN_mcu_status_motor_controller_current_set(uint16_t motor_controller_current);
void CAN_mcu_status_bms_controller_current_set(uint16_t bms_controller_current);
void CAN_mcu_status_J1772_controller_current_set(uint16_t J1772_controller_current);
void CAN_mcu_status_dlc_set(uint8_t dlc);


void CAN_mcu_status_send(void);


#define CAN_MCU_STATUS_NUM_MUX_VALUES 5
#define CAN_mcu_command_interval() 100
void CAN_mcu_command_DCDC_enable_set(uint16_t DCDC_enable);
void CAN_mcu_command_J1772_prox_status_set(uint16_t J1772_prox_status);
void CAN_mcu_command_J1772_pilot_current_set(float J1772_pilot_current);
void CAN_mcu_command_precharge_enable_set(uint16_t precharge_enable);
void CAN_mcu_command_motor_controller_enable_set(uint16_t motor_controller_enable);
void CAN_mcu_command_dlc_set(uint8_t dlc);


void CAN_mcu_command_send(void);


void CAN_mcu_motorControllerRequest_Throttle_Value_set(uint16_t Throttle_Value);
void CAN_mcu_motorControllerRequest_Forward_Switch_set(uint16_t Forward_Switch);
void CAN_mcu_motorControllerRequest_Reverse_Switch_set(uint16_t Reverse_Switch);
void CAN_mcu_motorControllerRequest_FS1_Switch_set(uint16_t FS1_Switch);
void CAN_mcu_motorControllerRequest_Seat_Switch_set(uint16_t Seat_Switch);
void CAN_mcu_motorControllerRequest_Handbrake_Switch_set(uint16_t Handbrake_Switch);
void CAN_mcu_motorControllerRequest_Footbrake_Value_set(uint16_t Footbrake_Value);
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
void CAN_mcu_mcu_debug_cpu_usage_percent_set(float cpu_usage_percent);
void CAN_mcu_mcu_debug_cpu_peak_percent_set(float cpu_peak_percent);
void CAN_mcu_mcu_debug_debug_value_1_u16_set(uint16_t debug_value_1_u16);
void CAN_mcu_mcu_debug_debug_value_1_u24_set(uint32_t debug_value_1_u24);
void CAN_mcu_mcu_debug_task_1ms_cpu_percent_set(float task_1ms_cpu_percent);
void CAN_mcu_mcu_debug_task_10ms_cpu_percent_set(float task_10ms_cpu_percent);
void CAN_mcu_mcu_debug_task_100ms_cpu_percent_set(float task_100ms_cpu_percent);
void CAN_mcu_mcu_debug_task_1000ms_cpu_percent_set(float task_1000ms_cpu_percent);
void CAN_mcu_mcu_debug_debug_value_1_u30_set(uint32_t debug_value_1_u30);
void CAN_mcu_mcu_debug_task_1ms_peak_cpu_percent_set(float task_1ms_peak_cpu_percent);
void CAN_mcu_mcu_debug_task_10ms_peak_cpu_percent_set(float task_10ms_peak_cpu_percent);
void CAN_mcu_mcu_debug_task_100ms_peak_cpu_percent_set(float task_100ms_peak_cpu_percent);
void CAN_mcu_mcu_debug_task_1000ms_peak_cpu_percent_set(float task_1000ms_peak_cpu_percent);
void CAN_mcu_mcu_debug_dlc_set(uint8_t dlc);


void CAN_mcu_mcu_debug_send(void);


#define CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES 4
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
uint16_t CAN_bms_status_charge_allowed_get(void);
uint16_t CAN_bms_status_discharge_allowed_get(void);
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
uint16_t CAN_bms_power_systems_J1772_ready_to_charge_get(void);
uint16_t CAN_bms_power_systems_HV_precharge_state_get(void);
float CAN_bms_power_systems_HV_isolation_voltage_get(void);
uint16_t CAN_bms_power_systems_HV_contactor_state_get(void);

#define CAN_bms_debug_interval() 10
#define CAN_BMS_DEBUG_NUM_MUX_VALUES 3
uint8_t CAN_bms_debug_checkDataIsUnread(void);
uint8_t CAN_bms_debug_checkDataIsStale(void);
uint16_t CAN_bms_debug_multiplex_get(void);
float CAN_bms_debug_task_1ms_cpu_percent_get(void);
float CAN_bms_debug_task_10ms_cpu_percent_get(void);
float CAN_bms_debug_task_100ms_cpu_percent_get(void);
float CAN_bms_debug_task_1000ms_cpu_percent_get(void);
float CAN_bms_debug_task_1ms_peak_cpu_percent_get(void);
float CAN_bms_debug_task_10ms_peak_cpu_percent_get(void);
float CAN_bms_debug_task_100ms_peak_cpu_percent_get(void);
float CAN_bms_debug_task_1000ms_peak_cpu_percent_get(void);
uint16_t CAN_bms_debug_bool0_get(void);
uint16_t CAN_bms_debug_bool1_get(void);
float CAN_bms_debug_float1_get(void);
float CAN_bms_debug_float2_get(void);
uint16_t CAN_bms_debug_word1_get(void);
uint16_t CAN_bms_debug_byte1_get(void);

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
#define CAN_motorcontroller_heartbeat_interval() 30
uint8_t CAN_motorcontroller_heartbeat_checkDataIsUnread(void);
uint8_t CAN_motorcontroller_heartbeat_checkDataIsStale(void);
uint16_t CAN_motorcontroller_heartbeat_Mode_get(void);

#define CAN_motorcontroller_SYNC_interval() 1
uint8_t CAN_motorcontroller_SYNC_checkDataIsUnread(void);
uint8_t CAN_motorcontroller_SYNC_checkDataIsStale(void);

uint8_t CAN_motorcontroller_SDO_response_checkDataIsUnread(void);
uint16_t CAN_motorcontroller_SDO_response_size_get(void);
uint16_t CAN_motorcontroller_SDO_response_expidited_xfer_get(void);
uint16_t CAN_motorcontroller_SDO_response_n_bytes_get(void);
uint16_t CAN_motorcontroller_SDO_response_reserved_get(void);
uint16_t CAN_motorcontroller_SDO_response_ccs_get(void);
uint16_t CAN_motorcontroller_SDO_response_index_get(void);
uint16_t CAN_motorcontroller_SDO_response_subindex_get(void);
uint16_t CAN_motorcontroller_SDO_response_byte_4_get(void);
uint16_t CAN_motorcontroller_SDO_response_byte_5_get(void);
uint16_t CAN_motorcontroller_SDO_response_byte_6_get(void);
uint16_t CAN_motorcontroller_SDO_response_byte_7_get(void);

#define CAN_motorcontroller_Emergency_interval() 30
uint8_t CAN_motorcontroller_Emergency_checkDataIsUnread(void);
uint8_t CAN_motorcontroller_Emergency_checkDataIsStale(void);
uint16_t CAN_motorcontroller_Emergency_EMCY_get(void);

#define CAN_motorcontroller_motorStatus_PDO1_interval() 20
uint8_t CAN_motorcontroller_motorStatus_PDO1_checkDataIsUnread(void);
uint8_t CAN_motorcontroller_motorStatus_PDO1_checkDataIsStale(void);
float CAN_motorcontroller_motorStatus_PDO1_Battery_Voltage_get(void);
float CAN_motorcontroller_motorStatus_PDO1_Battery_Current_get(void);
float CAN_motorcontroller_motorStatus_PDO1_Capacitor_Voltage_get(void);
float CAN_motorcontroller_motorStatus_PDO1_Heatsink_Temperature_get(void);

#define CAN_motorcontroller_motorStatus_PDO2_interval() 20
uint8_t CAN_motorcontroller_motorStatus_PDO2_checkDataIsUnread(void);
uint8_t CAN_motorcontroller_motorStatus_PDO2_checkDataIsStale(void);
float CAN_motorcontroller_motorStatus_PDO2_Throttle_Input_Voltage_get(void);
float CAN_motorcontroller_motorStatus_PDO2_Throttle_Value_get(void);

#define CAN_motorcontroller_motor_status_PDO4_interval() 20
uint8_t CAN_motorcontroller_motor_status_PDO4_checkDataIsUnread(void);
uint8_t CAN_motorcontroller_motor_status_PDO4_checkDataIsStale(void);
uint16_t CAN_motorcontroller_motor_status_PDO4_Motor_Torque_get(void);
uint32_t CAN_motorcontroller_motor_status_PDO4_Motor_Velocity_get(void);
float CAN_motorcontroller_motor_status_PDO4_Motor_AC_Current_get(void);

/**********************************************************
 * charger NODE MESSAGES
 */
/**********************************************************
 * boot_host NODE MESSAGES
 */
#define CAN_boot_host_mcu_interval() 1
uint8_t CAN_boot_host_mcu_checkDataIsUnread(void);
uint8_t CAN_boot_host_mcu_checkDataIsStale(void);
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
