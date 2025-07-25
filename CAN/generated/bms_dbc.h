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
void CAN_bms_status_M0_state_set(uint16_t state);
void CAN_bms_status_M0_SOC_set(float SOC);
void CAN_bms_status_M0_packVoltage_set(float packVoltage);
void CAN_bms_status_M0_packCurrent_set(float packCurrent);
void CAN_bms_status_M0_minTemp_set(float minTemp);
void CAN_bms_status_M0_maxTemp_set(float maxTemp);
void CAN_bms_status_M1_stackVoltage1_set(float stackVoltage1);
void CAN_bms_status_M1_stackVoltage2_set(float stackVoltage2);
void CAN_bms_status_M1_packVoltageSumOfStacks_set(float packVoltageSumOfStacks);
void CAN_bms_status_M1_mux1_signal4_set(uint16_t mux1_signal4);
void CAN_bms_status_M2_mux2_signal1_set(uint16_t mux2_signal1);
void CAN_bms_status_M2_mux2_signal2_set(uint16_t mux2_signal2);
void CAN_bms_status_M2_mux2_signal3_set(uint16_t mux2_signal3);
void CAN_bms_status_M2_mux2_signal4_set(uint16_t mux2_signal4);
void CAN_bms_status_M3_mux3_signal1_set(uint16_t mux3_signal1);
void CAN_bms_status_M3_mux3_signal2_set(uint16_t mux3_signal2);
void CAN_bms_status_M3_mux3_signal3_set(uint16_t mux3_signal3);
void CAN_bms_status_M3_mux3_signal4_set(uint16_t mux3_signal4);
void CAN_bms_status_dlc_set(uint8_t dlc);


void CAN_bms_status_send(void);


#define CAN_BMS_STATUS_NUM_MUX_VALUES 4
#define CAN_bms_status_2_interval() 10
void CAN_bms_status_2_DCDC_state_set(uint16_t DCDC_state);
void CAN_bms_status_2_DCDC_fault_set(uint16_t DCDC_fault);
void CAN_bms_status_2_DCDC_voltage_set(float DCDC_voltage);
void CAN_bms_status_2_DCDC_current_set(float DCDC_current);
void CAN_bms_status_2_EV_charger_state_set(uint16_t EV_charger_state);
void CAN_bms_status_2_EV_charger_fault_set(uint16_t EV_charger_fault);
void CAN_bms_status_2_EV_charger_voltage_set(float EV_charger_voltage);
void CAN_bms_status_2_EV_charger_current_set(float EV_charger_current);
void CAN_bms_status_2_HV_precharge_state_set(uint16_t HV_precharge_state);
void CAN_bms_status_2_HV_isolation_voltage_set(float HV_isolation_voltage);
void CAN_bms_status_2_HV_contactor_state_set(uint16_t HV_contactor_state);
void CAN_bms_status_2_dlc_set(uint8_t dlc);


void CAN_bms_status_2_send(void);


#define CAN_bms_debug_interval() 10
void CAN_bms_debug_bool0_set(uint16_t bool0);
void CAN_bms_debug_bool1_set(uint16_t bool1);
void CAN_bms_debug_float1_set(float float1);
void CAN_bms_debug_float2_set(float float2);
void CAN_bms_debug_VBUS_Voltage_set(float VBUS_Voltage);
void CAN_bms_debug_CPU_USAGE_set(float CPU_USAGE);
void CAN_bms_debug_CPU_peak_set(float CPU_peak);
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
void CAN_bms_charger_request_dlc_set(uint8_t dlc);


void CAN_bms_charger_request_send(void);


#define CAN_bms_cellVoltages_interval() 1000
void CAN_bms_cellVoltages_M0_cell_1_voltage_set(uint16_t cell_1_voltage);
void CAN_bms_cellVoltages_M0_cell_2_voltage_set(uint16_t cell_2_voltage);
void CAN_bms_cellVoltages_M0_cell_3_voltage_set(uint16_t cell_3_voltage);
void CAN_bms_cellVoltages_M0_cell_4_voltage_set(uint16_t cell_4_voltage);
void CAN_bms_cellVoltages_M1_cell_5_voltage_set(uint16_t cell_5_voltage);
void CAN_bms_cellVoltages_M1_cell_6_voltage_set(uint16_t cell_6_voltage);
void CAN_bms_cellVoltages_M1_cell_7_voltage_set(uint16_t cell_7_voltage);
void CAN_bms_cellVoltages_M1_cell_8_voltage_set(uint16_t cell_8_voltage);
void CAN_bms_cellVoltages_M2_cell_9_voltage_set(uint16_t cell_9_voltage);
void CAN_bms_cellVoltages_M2_cell_10_voltage_set(uint16_t cell_10_voltage);
void CAN_bms_cellVoltages_M2_cell_11_voltage_set(uint16_t cell_11_voltage);
void CAN_bms_cellVoltages_M2_cell_12_voltage_set(uint16_t cell_12_voltage);
void CAN_bms_cellVoltages_M3_cell_13_voltage_set(uint16_t cell_13_voltage);
void CAN_bms_cellVoltages_M3_cell_14_voltage_set(uint16_t cell_14_voltage);
void CAN_bms_cellVoltages_M3_cell_15_voltage_set(uint16_t cell_15_voltage);
void CAN_bms_cellVoltages_M3_cell_16_voltage_set(uint16_t cell_16_voltage);
void CAN_bms_cellVoltages_M4_cell_17_voltage_set(uint16_t cell_17_voltage);
void CAN_bms_cellVoltages_M4_cell_18_voltage_set(uint16_t cell_18_voltage);
void CAN_bms_cellVoltages_M4_cell_19_voltage_set(uint16_t cell_19_voltage);
void CAN_bms_cellVoltages_M4_cell_20_voltage_set(uint16_t cell_20_voltage);
void CAN_bms_cellVoltages_M5_cell_21_voltage_set(uint16_t cell_21_voltage);
void CAN_bms_cellVoltages_M5_cell_22_voltage_set(uint16_t cell_22_voltage);
void CAN_bms_cellVoltages_M5_cell_23_voltage_set(uint16_t cell_23_voltage);
void CAN_bms_cellVoltages_M5_cell_24_voltage_set(uint16_t cell_24_voltage);
void CAN_bms_cellVoltages_dlc_set(uint8_t dlc);


void CAN_bms_cellVoltages_send(void);


#define CAN_BMS_CELLVOLTAGES_NUM_MUX_VALUES 6
#define CAN_bms_ltc_debug_interval() 1
void CAN_bms_ltc_debug_M0_ltc_state_set(uint16_t ltc_state);
void CAN_bms_ltc_debug_M0_lastErrorState_set(uint16_t lastErrorState);
void CAN_bms_ltc_debug_M0_ErrorCount_set(uint16_t ErrorCount);
void CAN_bms_ltc_debug_M0_balancingActive_set(uint16_t balancingActive);
void CAN_bms_ltc_debug_M1_cell_A_balancing_set(uint16_t cell_A_balancing);
void CAN_bms_ltc_debug_M1_cell_B_balancing_set(uint16_t cell_B_balancing);
void CAN_bms_ltc_debug_M1_cell_C_balancing_set(uint16_t cell_C_balancing);
void CAN_bms_ltc_debug_M1_cell_D_balancing_set(uint16_t cell_D_balancing);
void CAN_bms_ltc_debug_M1_cell_E_balancing_set(uint16_t cell_E_balancing);
void CAN_bms_ltc_debug_M2_max_cell_delta_mV_set(uint16_t max_cell_delta_mV);
void CAN_bms_ltc_debug_M2_max_cell_mV_set(uint16_t max_cell_mV);
void CAN_bms_ltc_debug_M2_min_cell_mV_set(uint16_t min_cell_mV);
void CAN_bms_ltc_debug_M2_max_charge_current_allowed_set(uint16_t max_charge_current_allowed);
uint8_t CAN_bms_ltc_debug_checkDataIsFresh(void);
uint16_t CAN_bms_ltc_debug_Multiplex_get(void);
uint16_t CAN_bms_ltc_debug_M0_ltc_state_get(void);
uint16_t CAN_bms_ltc_debug_M0_lastErrorState_get(void);
uint16_t CAN_bms_ltc_debug_M0_ErrorCount_get(void);
uint16_t CAN_bms_ltc_debug_M0_balancingActive_get(void);
uint16_t CAN_bms_ltc_debug_M1_cell_A_balancing_get(void);
uint16_t CAN_bms_ltc_debug_M1_cell_B_balancing_get(void);
uint16_t CAN_bms_ltc_debug_M1_cell_C_balancing_get(void);
uint16_t CAN_bms_ltc_debug_M1_cell_D_balancing_get(void);
uint16_t CAN_bms_ltc_debug_M1_cell_E_balancing_get(void);
uint16_t CAN_bms_ltc_debug_M2_max_cell_delta_mV_get(void);
uint16_t CAN_bms_ltc_debug_M2_max_cell_mV_get(void);
uint16_t CAN_bms_ltc_debug_M2_min_cell_mV_get(void);
uint16_t CAN_bms_ltc_debug_M2_max_charge_current_allowed_get(void);

void CAN_bms_ltc_debug_dlc_set(uint8_t dlc);


void CAN_bms_ltc_debug_send(void);


#define CAN_BMS_LTC_DEBUG_NUM_MUX_VALUES 3
#define CAN_bms_cellTemperaturs_interval() 1000
void CAN_bms_cellTemperaturs_M0_temp_1_set(float temp_1);
void CAN_bms_cellTemperaturs_M0_temp_2_set(float temp_2);
void CAN_bms_cellTemperaturs_M0_temp_3_set(float temp_3);
void CAN_bms_cellTemperaturs_M0_temp_4_set(float temp_4);
void CAN_bms_cellTemperaturs_M1_temp_5_set(float temp_5);
void CAN_bms_cellTemperaturs_M1_temp_6_set(float temp_6);
void CAN_bms_cellTemperaturs_M1_temp_7_set(float temp_7);
void CAN_bms_cellTemperaturs_M1_temp_8_set(float temp_8);
void CAN_bms_cellTemperaturs_M2_temp_9_set(float temp_9);
void CAN_bms_cellTemperaturs_M2_temp_10_set(float temp_10);
void CAN_bms_cellTemperaturs_M2_temp_11_set(float temp_11);
void CAN_bms_cellTemperaturs_M2_temp_12_set(float temp_12);
void CAN_bms_cellTemperaturs_M3_temp_13_set(float temp_13);
void CAN_bms_cellTemperaturs_M3_temp_14_set(float temp_14);
void CAN_bms_cellTemperaturs_M3_temp_15_set(float temp_15);
void CAN_bms_cellTemperaturs_M3_temp_16_set(float temp_16);
void CAN_bms_cellTemperaturs_M4_temp_17_set(float temp_17);
void CAN_bms_cellTemperaturs_M4_temp_18_set(float temp_18);
void CAN_bms_cellTemperaturs_M4_temp_19_set(float temp_19);
void CAN_bms_cellTemperaturs_M4_temp_20_set(float temp_20);
void CAN_bms_cellTemperaturs_M5_temp_21_set(float temp_21);
void CAN_bms_cellTemperaturs_M5_temp_22_set(float temp_22);
void CAN_bms_cellTemperaturs_M5_temp_23_set(float temp_23);
void CAN_bms_cellTemperaturs_M5_temp_24_set(float temp_24);
void CAN_bms_cellTemperaturs_dlc_set(uint8_t dlc);


void CAN_bms_cellTemperaturs_send(void);


#define CAN_BMS_CELLTEMPERATURS_NUM_MUX_VALUES 6
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

void CAN_send_10ms(void);
void CAN_send_1000ms(void);
void CAN_send_1ms(void);


#endif /*bms_DBC_H*/
