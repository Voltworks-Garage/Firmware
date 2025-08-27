#ifndef charger_DBC_H
#define charger_DBC_H

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
float CAN_mcu_mcu_debug_task_1ms_cpu_percent_get(void);
float CAN_mcu_mcu_debug_task_10ms_cpu_percent_get(void);
float CAN_mcu_mcu_debug_task_100ms_cpu_percent_get(void);
float CAN_mcu_mcu_debug_task_1000ms_cpu_percent_get(void);
uint16_t CAN_mcu_mcu_debug_debug_value_9_get(void);
uint16_t CAN_mcu_mcu_debug_debug_value_10_get(void);
uint16_t CAN_mcu_mcu_debug_debug_value_13_get(void);
uint16_t CAN_mcu_mcu_debug_debug_value_14_get(void);
float CAN_mcu_mcu_debug_task_1ms_peak_cpu_percent_get(void);
float CAN_mcu_mcu_debug_task_10ms_peak_cpu_percent_get(void);
float CAN_mcu_mcu_debug_task_100ms_peak_cpu_percent_get(void);
float CAN_mcu_mcu_debug_task_1000ms_peak_cpu_percent_get(void);

/**********************************************************
 * bms NODE MESSAGES
 */
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

/**********************************************************
 * motorcontroller NODE MESSAGES
 */
/**********************************************************
 * charger NODE MESSAGES
 */
#define CAN_charger_status_interval() 1000
void CAN_charger_status_output_voltage_high_byte_set(uint16_t output_voltage_high_byte);
void CAN_charger_status_output_voltage_low_byte_set(uint16_t output_voltage_low_byte);
void CAN_charger_status_output_current_high_byte_set(uint16_t output_current_high_byte);
void CAN_charger_status_output_current_low_byte_set(uint16_t output_current_low_byte);
void CAN_charger_status_hardware_error_set(uint16_t hardware_error);
void CAN_charger_status_charger_overtemp_error_set(uint16_t charger_overtemp_error);
void CAN_charger_status_input_voltage_error_set(uint16_t input_voltage_error);
void CAN_charger_status_battery_detect_error_set(uint16_t battery_detect_error);
void CAN_charger_status_communication_error_set(uint16_t communication_error);
void CAN_charger_status_byte7_set(uint16_t byte7);
void CAN_charger_status_byte8_set(uint16_t byte8);
void CAN_charger_status_dlc_set(uint8_t dlc);


void CAN_charger_status_send(void);


/**********************************************************
 * boot_host NODE MESSAGES
 */
void CAN_DBC_init();

void CAN_send_1ms(void);
void CAN_send_10ms(void);
void CAN_send_100ms(void);
void CAN_send_1000ms(void);


#endif /*charger_DBC_H*/
