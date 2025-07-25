#include "boot_host_dbc.h"
#include "CAN.h"
#include "utils.h"
/**********************************************************
 * dash NODE MESSAGES
 */
/**********************************************************
 * mcu NODE MESSAGES
 */
#define CAN_mcu_command_ID 0x712

static CAN_message_S CAN_mcu_command={
	.canID = CAN_mcu_command_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
};

#define CAN_MCU_COMMAND_DCDC_ENABLE_RANGE 1
#define CAN_MCU_COMMAND_DCDC_ENABLE_OFFSET 0
#define CAN_MCU_COMMAND_EV_CHARGER_ENABLE_RANGE 1
#define CAN_MCU_COMMAND_EV_CHARGER_ENABLE_OFFSET 1
#define CAN_MCU_COMMAND_EV_CHARGER_CURRENT_RANGE 13
#define CAN_MCU_COMMAND_EV_CHARGER_CURRENT_OFFSET 2
#define CAN_MCU_COMMAND_PRECHARGE_ENABLE_RANGE 1
#define CAN_MCU_COMMAND_PRECHARGE_ENABLE_OFFSET 15
#define CAN_MCU_COMMAND_MOTOR_CONTROLLER_ENABLE_RANGE 1
#define CAN_MCU_COMMAND_MOTOR_CONTROLLER_ENABLE_OFFSET 16

uint8_t CAN_mcu_command_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_mcu_command);
}
uint16_t CAN_mcu_command_DCDC_enable_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_command.payload, CAN_MCU_COMMAND_DCDC_ENABLE_OFFSET, CAN_MCU_COMMAND_DCDC_ENABLE_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_command_ev_charger_enable_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_command.payload, CAN_MCU_COMMAND_EV_CHARGER_ENABLE_OFFSET, CAN_MCU_COMMAND_EV_CHARGER_ENABLE_RANGE);
	return (data * 1.0) + 0;
}
float CAN_mcu_command_ev_charger_current_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_command.payload, CAN_MCU_COMMAND_EV_CHARGER_CURRENT_OFFSET, CAN_MCU_COMMAND_EV_CHARGER_CURRENT_RANGE);
	return (data * 0.1) + 0;
}
uint16_t CAN_mcu_command_precharge_enable_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_command.payload, CAN_MCU_COMMAND_PRECHARGE_ENABLE_OFFSET, CAN_MCU_COMMAND_PRECHARGE_ENABLE_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_command_motor_controller_enable_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_command.payload, CAN_MCU_COMMAND_MOTOR_CONTROLLER_ENABLE_OFFSET, CAN_MCU_COMMAND_MOTOR_CONTROLLER_ENABLE_RANGE);
	return (data * 1.0) + 0;
}

#define CAN_mcu_boot_response_ID 0xa2

static CAN_message_S CAN_mcu_boot_response={
	.canID = CAN_mcu_boot_response_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
};

#define CAN_MCU_BOOT_RESPONSE_TYPE_RANGE 4
#define CAN_MCU_BOOT_RESPONSE_TYPE_OFFSET 0
#define CAN_MCU_BOOT_RESPONSE_CODE_RANGE 4
#define CAN_MCU_BOOT_RESPONSE_CODE_OFFSET 4
#define CAN_MCU_BOOT_RESPONSE_BYTE1_RANGE 8
#define CAN_MCU_BOOT_RESPONSE_BYTE1_OFFSET 8
#define CAN_MCU_BOOT_RESPONSE_BYTE2_RANGE 8
#define CAN_MCU_BOOT_RESPONSE_BYTE2_OFFSET 16
#define CAN_MCU_BOOT_RESPONSE_BYTE3_RANGE 8
#define CAN_MCU_BOOT_RESPONSE_BYTE3_OFFSET 24
#define CAN_MCU_BOOT_RESPONSE_BYTE4_RANGE 8
#define CAN_MCU_BOOT_RESPONSE_BYTE4_OFFSET 32
#define CAN_MCU_BOOT_RESPONSE_BYTE5_RANGE 8
#define CAN_MCU_BOOT_RESPONSE_BYTE5_OFFSET 40
#define CAN_MCU_BOOT_RESPONSE_BYTE6_RANGE 8
#define CAN_MCU_BOOT_RESPONSE_BYTE6_OFFSET 48
#define CAN_MCU_BOOT_RESPONSE_BYTE7_RANGE 8
#define CAN_MCU_BOOT_RESPONSE_BYTE7_OFFSET 56

uint8_t CAN_mcu_boot_response_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_mcu_boot_response);
}
uint16_t CAN_mcu_boot_response_type_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_boot_response.payload, CAN_MCU_BOOT_RESPONSE_TYPE_OFFSET, CAN_MCU_BOOT_RESPONSE_TYPE_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_boot_response_code_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_boot_response.payload, CAN_MCU_BOOT_RESPONSE_CODE_OFFSET, CAN_MCU_BOOT_RESPONSE_CODE_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_boot_response_byte1_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_boot_response.payload, CAN_MCU_BOOT_RESPONSE_BYTE1_OFFSET, CAN_MCU_BOOT_RESPONSE_BYTE1_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_boot_response_byte2_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_boot_response.payload, CAN_MCU_BOOT_RESPONSE_BYTE2_OFFSET, CAN_MCU_BOOT_RESPONSE_BYTE2_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_boot_response_byte3_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_boot_response.payload, CAN_MCU_BOOT_RESPONSE_BYTE3_OFFSET, CAN_MCU_BOOT_RESPONSE_BYTE3_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_boot_response_byte4_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_boot_response.payload, CAN_MCU_BOOT_RESPONSE_BYTE4_OFFSET, CAN_MCU_BOOT_RESPONSE_BYTE4_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_boot_response_byte5_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_boot_response.payload, CAN_MCU_BOOT_RESPONSE_BYTE5_OFFSET, CAN_MCU_BOOT_RESPONSE_BYTE5_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_boot_response_byte6_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_boot_response.payload, CAN_MCU_BOOT_RESPONSE_BYTE6_OFFSET, CAN_MCU_BOOT_RESPONSE_BYTE6_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_boot_response_byte7_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_boot_response.payload, CAN_MCU_BOOT_RESPONSE_BYTE7_OFFSET, CAN_MCU_BOOT_RESPONSE_BYTE7_RANGE);
	return (data * 1.0) + 0;
}

/**********************************************************
 * bms NODE MESSAGES
 */
#define CAN_bms_debug_ID 0x723

static CAN_message_S CAN_bms_debug={
	.canID = CAN_bms_debug_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
};

#define CAN_BMS_DEBUG_BOOL0_RANGE 1
#define CAN_BMS_DEBUG_BOOL0_OFFSET 0
#define CAN_BMS_DEBUG_BOOL1_RANGE 1
#define CAN_BMS_DEBUG_BOOL1_OFFSET 1
#define CAN_BMS_DEBUG_FLOAT1_RANGE 16
#define CAN_BMS_DEBUG_FLOAT1_OFFSET 2
#define CAN_BMS_DEBUG_FLOAT2_RANGE 16
#define CAN_BMS_DEBUG_FLOAT2_OFFSET 18
#define CAN_BMS_DEBUG_VBUS_VOLTAGE_RANGE 10
#define CAN_BMS_DEBUG_VBUS_VOLTAGE_OFFSET 34
#define CAN_BMS_DEBUG_CPU_USAGE_RANGE 10
#define CAN_BMS_DEBUG_CPU_USAGE_OFFSET 44
#define CAN_BMS_DEBUG_CPU_PEAK_RANGE 10
#define CAN_BMS_DEBUG_CPU_PEAK_OFFSET 54

uint8_t CAN_bms_debug_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_bms_debug);
}
uint16_t CAN_bms_debug_bool0_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_debug.payload, CAN_BMS_DEBUG_BOOL0_OFFSET, CAN_BMS_DEBUG_BOOL0_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_debug_bool1_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_debug.payload, CAN_BMS_DEBUG_BOOL1_OFFSET, CAN_BMS_DEBUG_BOOL1_RANGE);
	return (data * 1.0) + 0;
}
float CAN_bms_debug_float1_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_debug.payload, CAN_BMS_DEBUG_FLOAT1_OFFSET, CAN_BMS_DEBUG_FLOAT1_RANGE);
	return (data * 0.01) + 0;
}
float CAN_bms_debug_float2_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_debug.payload, CAN_BMS_DEBUG_FLOAT2_OFFSET, CAN_BMS_DEBUG_FLOAT2_RANGE);
	return (data * 0.01) + 0;
}
float CAN_bms_debug_VBUS_Voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_debug.payload, CAN_BMS_DEBUG_VBUS_VOLTAGE_OFFSET, CAN_BMS_DEBUG_VBUS_VOLTAGE_RANGE);
	return (data * 0.1) + 0;
}
uint16_t CAN_bms_debug_CPU_USAGE_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_debug.payload, CAN_BMS_DEBUG_CPU_USAGE_OFFSET, CAN_BMS_DEBUG_CPU_USAGE_RANGE);
	return (data * 0.1) + 0;
}
uint16_t CAN_bms_debug_CPU_peak_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_debug.payload, CAN_BMS_DEBUG_CPU_PEAK_OFFSET, CAN_BMS_DEBUG_CPU_PEAK_RANGE);
	return (data * 0.1) + 0;
}

#define CAN_bms_boot_response_ID 0xa2

static CAN_message_S CAN_bms_boot_response={
	.canID = CAN_bms_boot_response_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
};

#define CAN_BMS_BOOT_RESPONSE_TYPE_RANGE 4
#define CAN_BMS_BOOT_RESPONSE_TYPE_OFFSET 0
#define CAN_BMS_BOOT_RESPONSE_CODE_RANGE 4
#define CAN_BMS_BOOT_RESPONSE_CODE_OFFSET 4
#define CAN_BMS_BOOT_RESPONSE_BYTE1_RANGE 8
#define CAN_BMS_BOOT_RESPONSE_BYTE1_OFFSET 8
#define CAN_BMS_BOOT_RESPONSE_BYTE2_RANGE 8
#define CAN_BMS_BOOT_RESPONSE_BYTE2_OFFSET 16
#define CAN_BMS_BOOT_RESPONSE_BYTE3_RANGE 8
#define CAN_BMS_BOOT_RESPONSE_BYTE3_OFFSET 24
#define CAN_BMS_BOOT_RESPONSE_BYTE4_RANGE 8
#define CAN_BMS_BOOT_RESPONSE_BYTE4_OFFSET 32
#define CAN_BMS_BOOT_RESPONSE_BYTE5_RANGE 8
#define CAN_BMS_BOOT_RESPONSE_BYTE5_OFFSET 40
#define CAN_BMS_BOOT_RESPONSE_BYTE6_RANGE 8
#define CAN_BMS_BOOT_RESPONSE_BYTE6_OFFSET 48
#define CAN_BMS_BOOT_RESPONSE_BYTE7_RANGE 8
#define CAN_BMS_BOOT_RESPONSE_BYTE7_OFFSET 56

uint8_t CAN_bms_boot_response_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_bms_boot_response);
}
uint16_t CAN_bms_boot_response_type_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_boot_response.payload, CAN_BMS_BOOT_RESPONSE_TYPE_OFFSET, CAN_BMS_BOOT_RESPONSE_TYPE_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_boot_response_code_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_boot_response.payload, CAN_BMS_BOOT_RESPONSE_CODE_OFFSET, CAN_BMS_BOOT_RESPONSE_CODE_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_boot_response_byte1_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_boot_response.payload, CAN_BMS_BOOT_RESPONSE_BYTE1_OFFSET, CAN_BMS_BOOT_RESPONSE_BYTE1_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_boot_response_byte2_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_boot_response.payload, CAN_BMS_BOOT_RESPONSE_BYTE2_OFFSET, CAN_BMS_BOOT_RESPONSE_BYTE2_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_boot_response_byte3_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_boot_response.payload, CAN_BMS_BOOT_RESPONSE_BYTE3_OFFSET, CAN_BMS_BOOT_RESPONSE_BYTE3_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_boot_response_byte4_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_boot_response.payload, CAN_BMS_BOOT_RESPONSE_BYTE4_OFFSET, CAN_BMS_BOOT_RESPONSE_BYTE4_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_boot_response_byte5_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_boot_response.payload, CAN_BMS_BOOT_RESPONSE_BYTE5_OFFSET, CAN_BMS_BOOT_RESPONSE_BYTE5_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_boot_response_byte6_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_boot_response.payload, CAN_BMS_BOOT_RESPONSE_BYTE6_OFFSET, CAN_BMS_BOOT_RESPONSE_BYTE6_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_boot_response_byte7_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_boot_response.payload, CAN_BMS_BOOT_RESPONSE_BYTE7_OFFSET, CAN_BMS_BOOT_RESPONSE_BYTE7_RANGE);
	return (data * 1.0) + 0;
}

/**********************************************************
 * motorcontroller NODE MESSAGES
 */
/**********************************************************
 * charger NODE MESSAGES
 */
/**********************************************************
 * boot_host NODE MESSAGES
 */
static CAN_payload_S CAN_boot_host_bms_payload __attribute__((aligned(sizeof(CAN_payload_S))));
#define CAN_boot_host_bms_ID 0xa1

static CAN_message_S CAN_boot_host_bms={
	.canID = CAN_boot_host_bms_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = &CAN_boot_host_bms_payload,
	.canMessageStatus = 0
};

#define CAN_BOOT_HOST_BMS_TYPE_RANGE 4
#define CAN_BOOT_HOST_BMS_TYPE_OFFSET 0
#define CAN_BOOT_HOST_BMS_CODE_RANGE 4
#define CAN_BOOT_HOST_BMS_CODE_OFFSET 4
#define CAN_BOOT_HOST_BMS_BYTE1_RANGE 8
#define CAN_BOOT_HOST_BMS_BYTE1_OFFSET 8
#define CAN_BOOT_HOST_BMS_BYTE2_RANGE 8
#define CAN_BOOT_HOST_BMS_BYTE2_OFFSET 16
#define CAN_BOOT_HOST_BMS_BYTE3_RANGE 8
#define CAN_BOOT_HOST_BMS_BYTE3_OFFSET 24
#define CAN_BOOT_HOST_BMS_BYTE4_RANGE 8
#define CAN_BOOT_HOST_BMS_BYTE4_OFFSET 32
#define CAN_BOOT_HOST_BMS_BYTE5_RANGE 8
#define CAN_BOOT_HOST_BMS_BYTE5_OFFSET 40
#define CAN_BOOT_HOST_BMS_BYTE6_RANGE 8
#define CAN_BOOT_HOST_BMS_BYTE6_OFFSET 48
#define CAN_BOOT_HOST_BMS_BYTE7_RANGE 8
#define CAN_BOOT_HOST_BMS_BYTE7_OFFSET 56

void CAN_boot_host_bms_type_set(uint16_t type){
	uint16_t data_scaled = (type - 0) / 1.0;
	CAN_boot_host_bms.payload->word0 &= ~0x000F;
	CAN_boot_host_bms.payload->word0 |= (data_scaled << 0) & 0x000F;
}
void CAN_boot_host_bms_code_set(uint16_t code){
	uint16_t data_scaled = (code - 0) / 1.0;
	CAN_boot_host_bms.payload->word0 &= ~0x00F0;
	CAN_boot_host_bms.payload->word0 |= (data_scaled << 4) & 0x00F0;
}
void CAN_boot_host_bms_byte1_set(uint16_t byte1){
	uint16_t data_scaled = (byte1 - 0) / 1.0;
	CAN_boot_host_bms.payload->word0 &= ~0xFF00;
	CAN_boot_host_bms.payload->word0 |= (data_scaled << 8) & 0xFF00;
}
void CAN_boot_host_bms_byte2_set(uint16_t byte2){
	uint16_t data_scaled = (byte2 - 0) / 1.0;
	CAN_boot_host_bms.payload->word1 &= ~0x00FF;
	CAN_boot_host_bms.payload->word1 |= (data_scaled << 0) & 0x00FF;
}
void CAN_boot_host_bms_byte3_set(uint16_t byte3){
	uint16_t data_scaled = (byte3 - 0) / 1.0;
	CAN_boot_host_bms.payload->word1 &= ~0xFF00;
	CAN_boot_host_bms.payload->word1 |= (data_scaled << 8) & 0xFF00;
}
void CAN_boot_host_bms_byte4_set(uint16_t byte4){
	uint16_t data_scaled = (byte4 - 0) / 1.0;
	CAN_boot_host_bms.payload->word2 &= ~0x00FF;
	CAN_boot_host_bms.payload->word2 |= (data_scaled << 0) & 0x00FF;
}
void CAN_boot_host_bms_byte5_set(uint16_t byte5){
	uint16_t data_scaled = (byte5 - 0) / 1.0;
	CAN_boot_host_bms.payload->word2 &= ~0xFF00;
	CAN_boot_host_bms.payload->word2 |= (data_scaled << 8) & 0xFF00;
}
void CAN_boot_host_bms_byte6_set(uint16_t byte6){
	uint16_t data_scaled = (byte6 - 0) / 1.0;
	CAN_boot_host_bms.payload->word3 &= ~0x00FF;
	CAN_boot_host_bms.payload->word3 |= (data_scaled << 0) & 0x00FF;
}
void CAN_boot_host_bms_byte7_set(uint16_t byte7){
	uint16_t data_scaled = (byte7 - 0) / 1.0;
	CAN_boot_host_bms.payload->word3 &= ~0xFF00;
	CAN_boot_host_bms.payload->word3 |= (data_scaled << 8) & 0xFF00;
}
void CAN_boot_host_bms_dlc_set(uint8_t dlc){
	CAN_boot_host_bms.dlc = dlc;
}
void CAN_boot_host_bms_send(void){
	CAN_write(CAN_boot_host_bms);
}

static CAN_payload_S CAN_boot_host_mcu_payload __attribute__((aligned(sizeof(CAN_payload_S))));
#define CAN_boot_host_mcu_ID 0xa3

static CAN_message_S CAN_boot_host_mcu={
	.canID = CAN_boot_host_mcu_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = &CAN_boot_host_mcu_payload,
	.canMessageStatus = 0
};

#define CAN_BOOT_HOST_MCU_TYPE_RANGE 4
#define CAN_BOOT_HOST_MCU_TYPE_OFFSET 0
#define CAN_BOOT_HOST_MCU_CODE_RANGE 4
#define CAN_BOOT_HOST_MCU_CODE_OFFSET 4
#define CAN_BOOT_HOST_MCU_BYTE1_RANGE 8
#define CAN_BOOT_HOST_MCU_BYTE1_OFFSET 8
#define CAN_BOOT_HOST_MCU_BYTE2_RANGE 8
#define CAN_BOOT_HOST_MCU_BYTE2_OFFSET 16
#define CAN_BOOT_HOST_MCU_BYTE3_RANGE 8
#define CAN_BOOT_HOST_MCU_BYTE3_OFFSET 24
#define CAN_BOOT_HOST_MCU_BYTE4_RANGE 8
#define CAN_BOOT_HOST_MCU_BYTE4_OFFSET 32
#define CAN_BOOT_HOST_MCU_BYTE5_RANGE 8
#define CAN_BOOT_HOST_MCU_BYTE5_OFFSET 40
#define CAN_BOOT_HOST_MCU_BYTE6_RANGE 8
#define CAN_BOOT_HOST_MCU_BYTE6_OFFSET 48
#define CAN_BOOT_HOST_MCU_BYTE7_RANGE 8
#define CAN_BOOT_HOST_MCU_BYTE7_OFFSET 56

void CAN_boot_host_mcu_type_set(uint16_t type){
	uint16_t data_scaled = (type - 0) / 1.0;
	CAN_boot_host_mcu.payload->word0 &= ~0x000F;
	CAN_boot_host_mcu.payload->word0 |= (data_scaled << 0) & 0x000F;
}
void CAN_boot_host_mcu_code_set(uint16_t code){
	uint16_t data_scaled = (code - 0) / 1.0;
	CAN_boot_host_mcu.payload->word0 &= ~0x00F0;
	CAN_boot_host_mcu.payload->word0 |= (data_scaled << 4) & 0x00F0;
}
void CAN_boot_host_mcu_byte1_set(uint16_t byte1){
	uint16_t data_scaled = (byte1 - 0) / 1.0;
	CAN_boot_host_mcu.payload->word0 &= ~0xFF00;
	CAN_boot_host_mcu.payload->word0 |= (data_scaled << 8) & 0xFF00;
}
void CAN_boot_host_mcu_byte2_set(uint16_t byte2){
	uint16_t data_scaled = (byte2 - 0) / 1.0;
	CAN_boot_host_mcu.payload->word1 &= ~0x00FF;
	CAN_boot_host_mcu.payload->word1 |= (data_scaled << 0) & 0x00FF;
}
void CAN_boot_host_mcu_byte3_set(uint16_t byte3){
	uint16_t data_scaled = (byte3 - 0) / 1.0;
	CAN_boot_host_mcu.payload->word1 &= ~0xFF00;
	CAN_boot_host_mcu.payload->word1 |= (data_scaled << 8) & 0xFF00;
}
void CAN_boot_host_mcu_byte4_set(uint16_t byte4){
	uint16_t data_scaled = (byte4 - 0) / 1.0;
	CAN_boot_host_mcu.payload->word2 &= ~0x00FF;
	CAN_boot_host_mcu.payload->word2 |= (data_scaled << 0) & 0x00FF;
}
void CAN_boot_host_mcu_byte5_set(uint16_t byte5){
	uint16_t data_scaled = (byte5 - 0) / 1.0;
	CAN_boot_host_mcu.payload->word2 &= ~0xFF00;
	CAN_boot_host_mcu.payload->word2 |= (data_scaled << 8) & 0xFF00;
}
void CAN_boot_host_mcu_byte6_set(uint16_t byte6){
	uint16_t data_scaled = (byte6 - 0) / 1.0;
	CAN_boot_host_mcu.payload->word3 &= ~0x00FF;
	CAN_boot_host_mcu.payload->word3 |= (data_scaled << 0) & 0x00FF;
}
void CAN_boot_host_mcu_byte7_set(uint16_t byte7){
	uint16_t data_scaled = (byte7 - 0) / 1.0;
	CAN_boot_host_mcu.payload->word3 &= ~0xFF00;
	CAN_boot_host_mcu.payload->word3 |= (data_scaled << 8) & 0xFF00;
}
void CAN_boot_host_mcu_dlc_set(uint8_t dlc){
	CAN_boot_host_mcu.dlc = dlc;
}
void CAN_boot_host_mcu_send(void){
	CAN_write(CAN_boot_host_mcu);
}

static CAN_payload_S CAN_boot_host_dash_payload __attribute__((aligned(sizeof(CAN_payload_S))));
#define CAN_boot_host_dash_ID 0xa5

static CAN_message_S CAN_boot_host_dash={
	.canID = CAN_boot_host_dash_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = &CAN_boot_host_dash_payload,
	.canMessageStatus = 0
};

#define CAN_BOOT_HOST_DASH_TYPE_RANGE 4
#define CAN_BOOT_HOST_DASH_TYPE_OFFSET 0
#define CAN_BOOT_HOST_DASH_CODE_RANGE 4
#define CAN_BOOT_HOST_DASH_CODE_OFFSET 4
#define CAN_BOOT_HOST_DASH_BYTE1_RANGE 8
#define CAN_BOOT_HOST_DASH_BYTE1_OFFSET 8
#define CAN_BOOT_HOST_DASH_BYTE2_RANGE 8
#define CAN_BOOT_HOST_DASH_BYTE2_OFFSET 16
#define CAN_BOOT_HOST_DASH_BYTE3_RANGE 8
#define CAN_BOOT_HOST_DASH_BYTE3_OFFSET 24
#define CAN_BOOT_HOST_DASH_BYTE4_RANGE 8
#define CAN_BOOT_HOST_DASH_BYTE4_OFFSET 32
#define CAN_BOOT_HOST_DASH_BYTE5_RANGE 8
#define CAN_BOOT_HOST_DASH_BYTE5_OFFSET 40
#define CAN_BOOT_HOST_DASH_BYTE6_RANGE 8
#define CAN_BOOT_HOST_DASH_BYTE6_OFFSET 48
#define CAN_BOOT_HOST_DASH_BYTE7_RANGE 8
#define CAN_BOOT_HOST_DASH_BYTE7_OFFSET 56

void CAN_boot_host_dash_type_set(uint16_t type){
	uint16_t data_scaled = (type - 0) / 1.0;
	CAN_boot_host_dash.payload->word0 &= ~0x000F;
	CAN_boot_host_dash.payload->word0 |= (data_scaled << 0) & 0x000F;
}
void CAN_boot_host_dash_code_set(uint16_t code){
	uint16_t data_scaled = (code - 0) / 1.0;
	CAN_boot_host_dash.payload->word0 &= ~0x00F0;
	CAN_boot_host_dash.payload->word0 |= (data_scaled << 4) & 0x00F0;
}
void CAN_boot_host_dash_byte1_set(uint16_t byte1){
	uint16_t data_scaled = (byte1 - 0) / 1.0;
	CAN_boot_host_dash.payload->word0 &= ~0xFF00;
	CAN_boot_host_dash.payload->word0 |= (data_scaled << 8) & 0xFF00;
}
void CAN_boot_host_dash_byte2_set(uint16_t byte2){
	uint16_t data_scaled = (byte2 - 0) / 1.0;
	CAN_boot_host_dash.payload->word1 &= ~0x00FF;
	CAN_boot_host_dash.payload->word1 |= (data_scaled << 0) & 0x00FF;
}
void CAN_boot_host_dash_byte3_set(uint16_t byte3){
	uint16_t data_scaled = (byte3 - 0) / 1.0;
	CAN_boot_host_dash.payload->word1 &= ~0xFF00;
	CAN_boot_host_dash.payload->word1 |= (data_scaled << 8) & 0xFF00;
}
void CAN_boot_host_dash_byte4_set(uint16_t byte4){
	uint16_t data_scaled = (byte4 - 0) / 1.0;
	CAN_boot_host_dash.payload->word2 &= ~0x00FF;
	CAN_boot_host_dash.payload->word2 |= (data_scaled << 0) & 0x00FF;
}
void CAN_boot_host_dash_byte5_set(uint16_t byte5){
	uint16_t data_scaled = (byte5 - 0) / 1.0;
	CAN_boot_host_dash.payload->word2 &= ~0xFF00;
	CAN_boot_host_dash.payload->word2 |= (data_scaled << 8) & 0xFF00;
}
void CAN_boot_host_dash_byte6_set(uint16_t byte6){
	uint16_t data_scaled = (byte6 - 0) / 1.0;
	CAN_boot_host_dash.payload->word3 &= ~0x00FF;
	CAN_boot_host_dash.payload->word3 |= (data_scaled << 0) & 0x00FF;
}
void CAN_boot_host_dash_byte7_set(uint16_t byte7){
	uint16_t data_scaled = (byte7 - 0) / 1.0;
	CAN_boot_host_dash.payload->word3 &= ~0xFF00;
	CAN_boot_host_dash.payload->word3 |= (data_scaled << 8) & 0xFF00;
}
void CAN_boot_host_dash_dlc_set(uint8_t dlc){
	CAN_boot_host_dash.dlc = dlc;
}
void CAN_boot_host_dash_send(void){
	CAN_write(CAN_boot_host_dash);
}

void CAN_DBC_init(void) {
	CAN_configureMailbox(&CAN_mcu_command);
	CAN_configureMailbox(&CAN_mcu_boot_response);
	CAN_configureMailbox(&CAN_bms_debug);
	CAN_configureMailbox(&CAN_bms_boot_response);
}

void CAN_send_1ms(void){
	CAN_boot_host_bms_send();
	CAN_boot_host_mcu_send();
	CAN_boot_host_dash_send();
}
