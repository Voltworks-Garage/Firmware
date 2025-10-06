#ifndef motorcontroller_DBC_H
#define motorcontroller_DBC_H

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
uint16_t CAN_mcu_command_J1772_prox_status_get(void);
float CAN_mcu_command_J1772_pilot_current_get(void);
uint16_t CAN_mcu_command_precharge_enable_get(void);
uint16_t CAN_mcu_command_motor_controller_enable_get(void);

uint8_t CAN_mcu_motorControllerRequest_checkDataIsUnread(void);
uint16_t CAN_mcu_motorControllerRequest_Throttle_Value_get(void);
uint16_t CAN_mcu_motorControllerRequest_Forward_Switch_get(void);
uint16_t CAN_mcu_motorControllerRequest_Reverse_Switch_get(void);
uint16_t CAN_mcu_motorControllerRequest_FS1_Switch_get(void);
uint16_t CAN_mcu_motorControllerRequest_Seat_Switch_get(void);
uint16_t CAN_mcu_motorControllerRequest_Handbrake_Switch_get(void);
uint16_t CAN_mcu_motorControllerRequest_Footbrake_Value_get(void);

#define CAN_mcu_mcu_debug_interval() 10
#define CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES 4
uint8_t CAN_mcu_mcu_debug_checkDataIsUnread(void);
uint8_t CAN_mcu_mcu_debug_checkDataIsStale(void);
uint16_t CAN_mcu_mcu_debug_Multiplex_get(void);
float CAN_mcu_mcu_debug_cpu_usage_percent_get(void);
float CAN_mcu_mcu_debug_cpu_peak_percent_get(void);
uint16_t CAN_mcu_mcu_debug_debug_value_1_u16_get(void);
uint32_t CAN_mcu_mcu_debug_debug_value_1_u24_get(void);
float CAN_mcu_mcu_debug_task_1ms_cpu_percent_get(void);
float CAN_mcu_mcu_debug_task_10ms_cpu_percent_get(void);
float CAN_mcu_mcu_debug_task_100ms_cpu_percent_get(void);
float CAN_mcu_mcu_debug_task_1000ms_cpu_percent_get(void);
uint32_t CAN_mcu_mcu_debug_debug_value_1_u30_get(void);
float CAN_mcu_mcu_debug_task_1ms_peak_cpu_percent_get(void);
float CAN_mcu_mcu_debug_task_10ms_peak_cpu_percent_get(void);
float CAN_mcu_mcu_debug_task_100ms_peak_cpu_percent_get(void);
float CAN_mcu_mcu_debug_task_1000ms_peak_cpu_percent_get(void);

/**********************************************************
 * bms NODE MESSAGES
 */
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

uint8_t CAN_bms_SDO_request_checkDataIsUnread(void);
uint16_t CAN_bms_SDO_request_size_get(void);
uint16_t CAN_bms_SDO_request_expidited_xfer_get(void);
uint16_t CAN_bms_SDO_request_n_bytes_get(void);
uint16_t CAN_bms_SDO_request_reserved_get(void);
uint16_t CAN_bms_SDO_request_ccs_get(void);
uint16_t CAN_bms_SDO_request_index_get(void);
uint16_t CAN_bms_SDO_request_subindex_get(void);
uint16_t CAN_bms_SDO_request_byte_4_get(void);
uint16_t CAN_bms_SDO_request_byte_5_get(void);
uint16_t CAN_bms_SDO_request_byte_6_get(void);
uint16_t CAN_bms_SDO_request_byte_7_get(void);

/**********************************************************
 * motorcontroller NODE MESSAGES
 */
#define CAN_motorcontroller_heartbeat_interval() 30
void CAN_motorcontroller_heartbeat_Mode_set(uint16_t Mode);
void CAN_motorcontroller_heartbeat_dlc_set(uint8_t dlc);


void CAN_motorcontroller_heartbeat_send(void);


#define CAN_motorcontroller_SYNC_interval() 1
void CAN_motorcontroller_SYNC_dlc_set(uint8_t dlc);


void CAN_motorcontroller_SYNC_send(void);


void CAN_motorcontroller_SDO_response_size_set(uint16_t size);
void CAN_motorcontroller_SDO_response_expidited_xfer_set(uint16_t expidited_xfer);
void CAN_motorcontroller_SDO_response_n_bytes_set(uint16_t n_bytes);
void CAN_motorcontroller_SDO_response_reserved_set(uint16_t reserved);
void CAN_motorcontroller_SDO_response_ccs_set(uint16_t ccs);
void CAN_motorcontroller_SDO_response_index_set(uint16_t index);
void CAN_motorcontroller_SDO_response_subindex_set(uint16_t subindex);
void CAN_motorcontroller_SDO_response_byte_4_set(uint16_t byte_4);
void CAN_motorcontroller_SDO_response_byte_5_set(uint16_t byte_5);
void CAN_motorcontroller_SDO_response_byte_6_set(uint16_t byte_6);
void CAN_motorcontroller_SDO_response_byte_7_set(uint16_t byte_7);
void CAN_motorcontroller_SDO_response_dlc_set(uint8_t dlc);


void CAN_motorcontroller_SDO_response_send(void);


#define CAN_motorcontroller_Emergency_interval() 30
void CAN_motorcontroller_Emergency_EMCY_set(uint16_t EMCY);
void CAN_motorcontroller_Emergency_dlc_set(uint8_t dlc);


void CAN_motorcontroller_Emergency_send(void);


#define CAN_motorcontroller_motorStatus_PDO1_interval() 20
void CAN_motorcontroller_motorStatus_PDO1_Battery_Voltage_set(float Battery_Voltage);
void CAN_motorcontroller_motorStatus_PDO1_Battery_Current_set(float Battery_Current);
void CAN_motorcontroller_motorStatus_PDO1_Capacitor_Voltage_set(float Capacitor_Voltage);
void CAN_motorcontroller_motorStatus_PDO1_Heatsink_Temperature_set(float Heatsink_Temperature);
void CAN_motorcontroller_motorStatus_PDO1_dlc_set(uint8_t dlc);


void CAN_motorcontroller_motorStatus_PDO1_send(void);


#define CAN_motorcontroller_motorStatus_PDO2_interval() 20
void CAN_motorcontroller_motorStatus_PDO2_Throttle_Input_Voltage_set(float Throttle_Input_Voltage);
void CAN_motorcontroller_motorStatus_PDO2_Throttle_Value_set(float Throttle_Value);
void CAN_motorcontroller_motorStatus_PDO2_dlc_set(uint8_t dlc);


void CAN_motorcontroller_motorStatus_PDO2_send(void);


#define CAN_motorcontroller_motor_status_PDO4_interval() 20
void CAN_motorcontroller_motor_status_PDO4_Motor_Torque_set(uint16_t Motor_Torque);
void CAN_motorcontroller_motor_status_PDO4_Motor_Velocity_set(uint32_t Motor_Velocity);
void CAN_motorcontroller_motor_status_PDO4_Motor_AC_Current_set(float Motor_AC_Current);
void CAN_motorcontroller_motor_status_PDO4_dlc_set(uint8_t dlc);


void CAN_motorcontroller_motor_status_PDO4_send(void);


/**********************************************************
 * charger NODE MESSAGES
 */
/**********************************************************
 * boot_host NODE MESSAGES
 */
void CAN_DBC_init();

void CAN_send_1ms(void);
void CAN_send_10ms(void);
void CAN_send_100ms(void);
void CAN_send_1000ms(void);
void CAN_send_30ms(void);
void CAN_send_20ms(void);


#endif /*motorcontroller_DBC_H*/
