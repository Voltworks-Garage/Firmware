#ifndef boot_host_DBC_H
#define boot_host_DBC_H

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

uint8_t CAN_mcu_boot_response_checkDataIsUnread(void);
uint16_t CAN_mcu_boot_response_type_get(void);
uint16_t CAN_mcu_boot_response_code_get(void);
uint16_t CAN_mcu_boot_response_byte1_get(void);
uint16_t CAN_mcu_boot_response_byte2_get(void);
uint16_t CAN_mcu_boot_response_byte3_get(void);
uint16_t CAN_mcu_boot_response_byte4_get(void);
uint16_t CAN_mcu_boot_response_byte5_get(void);
uint16_t CAN_mcu_boot_response_byte6_get(void);
uint16_t CAN_mcu_boot_response_byte7_get(void);

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

uint8_t CAN_bms_boot_response_checkDataIsUnread(void);
uint16_t CAN_bms_boot_response_type_get(void);
uint16_t CAN_bms_boot_response_code_get(void);
uint16_t CAN_bms_boot_response_byte1_get(void);
uint16_t CAN_bms_boot_response_byte2_get(void);
uint16_t CAN_bms_boot_response_byte3_get(void);
uint16_t CAN_bms_boot_response_byte4_get(void);
uint16_t CAN_bms_boot_response_byte5_get(void);
uint16_t CAN_bms_boot_response_byte6_get(void);
uint16_t CAN_bms_boot_response_byte7_get(void);

/**********************************************************
 * motorcontroller NODE MESSAGES
 */
/**********************************************************
 * charger NODE MESSAGES
 */
/**********************************************************
 * boot_host NODE MESSAGES
 */
#define CAN_boot_host_bms_interval() 1
void CAN_boot_host_bms_type_set(uint16_t type);
void CAN_boot_host_bms_code_set(uint16_t code);
void CAN_boot_host_bms_byte1_set(uint16_t byte1);
void CAN_boot_host_bms_byte2_set(uint16_t byte2);
void CAN_boot_host_bms_byte3_set(uint16_t byte3);
void CAN_boot_host_bms_byte4_set(uint16_t byte4);
void CAN_boot_host_bms_byte5_set(uint16_t byte5);
void CAN_boot_host_bms_byte6_set(uint16_t byte6);
void CAN_boot_host_bms_byte7_set(uint16_t byte7);
void CAN_boot_host_bms_dlc_set(uint8_t dlc);


void CAN_boot_host_bms_send(void);


#define CAN_boot_host_mcu_interval() 1
void CAN_boot_host_mcu_type_set(uint16_t type);
void CAN_boot_host_mcu_code_set(uint16_t code);
void CAN_boot_host_mcu_byte1_set(uint16_t byte1);
void CAN_boot_host_mcu_byte2_set(uint16_t byte2);
void CAN_boot_host_mcu_byte3_set(uint16_t byte3);
void CAN_boot_host_mcu_byte4_set(uint16_t byte4);
void CAN_boot_host_mcu_byte5_set(uint16_t byte5);
void CAN_boot_host_mcu_byte6_set(uint16_t byte6);
void CAN_boot_host_mcu_byte7_set(uint16_t byte7);
void CAN_boot_host_mcu_dlc_set(uint8_t dlc);


void CAN_boot_host_mcu_send(void);


#define CAN_boot_host_dash_interval() 1
void CAN_boot_host_dash_type_set(uint16_t type);
void CAN_boot_host_dash_code_set(uint16_t code);
void CAN_boot_host_dash_byte1_set(uint16_t byte1);
void CAN_boot_host_dash_byte2_set(uint16_t byte2);
void CAN_boot_host_dash_byte3_set(uint16_t byte3);
void CAN_boot_host_dash_byte4_set(uint16_t byte4);
void CAN_boot_host_dash_byte5_set(uint16_t byte5);
void CAN_boot_host_dash_byte6_set(uint16_t byte6);
void CAN_boot_host_dash_byte7_set(uint16_t byte7);
void CAN_boot_host_dash_dlc_set(uint8_t dlc);


void CAN_boot_host_dash_send(void);


void CAN_DBC_init();

void CAN_send_1ms(void);
void CAN_send_10ms(void);
void CAN_send_100ms(void);
void CAN_send_1000ms(void);


#endif /*boot_host_DBC_H*/
