#include "motorcontroller_dbc.h"
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

uint8_t CAN_mcu_command_checkDataIsUnread(void){
	return CAN_checkDataIsUnread(&CAN_mcu_command);
}
uint8_t CAN_mcu_command_checkDataIsStale(void){
	return CAN_checkDataIsStale(&CAN_mcu_command, 200);
}
uint16_t CAN_mcu_command_DCDC_enable_get(void){
	// Extract 1-bit signal at bit offset 0
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_command.payload->word0 & 0x0001) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_command_ev_charger_enable_get(void){
	// Extract 1-bit signal at bit offset 1
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_command.payload->word0 & 0x0002) >> 1) << 0;
	return (data * 1.0) + 0;
}
float CAN_mcu_command_ev_charger_current_get(void){
	// Extract 13-bit signal at bit offset 2
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_command.payload->word0 & 0x7FFC) >> 2) << 0;
	return (data * 0.1) + 0;
}
uint16_t CAN_mcu_command_precharge_enable_get(void){
	// Extract 1-bit signal at bit offset 15
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_command.payload->word0 & 0x8000) >> 15) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_command_motor_controller_enable_get(void){
	// Extract 1-bit signal at bit offset 16
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_command.payload->word1 & 0x0001) >> 0) << 0;
	return (data * 1.0) + 0;
}

#define CAN_mcu_motorControllerRequest_ID 0x700

static CAN_message_S CAN_mcu_motorControllerRequest={
	.canID = CAN_mcu_motorControllerRequest_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
};

#define CAN_MCU_MOTORCONTROLLERREQUEST_REQUESTTYPE_RANGE 8
#define CAN_MCU_MOTORCONTROLLERREQUEST_REQUESTTYPE_OFFSET 0

uint8_t CAN_mcu_motorControllerRequest_checkDataIsUnread(void){
	return CAN_checkDataIsUnread(&CAN_mcu_motorControllerRequest);
}
uint8_t CAN_mcu_motorControllerRequest_checkDataIsStale(void){
	return CAN_checkDataIsStale(&CAN_mcu_motorControllerRequest, 2);
}
uint16_t CAN_mcu_motorControllerRequest_requestType_get(void){
	// Extract 8-bit signal at bit offset 0
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_motorControllerRequest.payload->word0 & 0x00FF) >> 0) << 0;
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
#define CAN_BMS_DEBUG_WORD1_RANGE 16
#define CAN_BMS_DEBUG_WORD1_OFFSET 34
#define CAN_BMS_DEBUG_BYTE1_RANGE 8
#define CAN_BMS_DEBUG_BYTE1_OFFSET 50

uint8_t CAN_bms_debug_checkDataIsUnread(void){
	return CAN_checkDataIsUnread(&CAN_bms_debug);
}
uint8_t CAN_bms_debug_checkDataIsStale(void){
	return CAN_checkDataIsStale(&CAN_bms_debug, 20);
}
uint16_t CAN_bms_debug_bool0_get(void){
	// Extract 1-bit signal at bit offset 0
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_debug.payload->word0 & 0x0001) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_debug_bool1_get(void){
	// Extract 1-bit signal at bit offset 1
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_debug.payload->word0 & 0x0002) >> 1) << 0;
	return (data * 1.0) + 0;
}
float CAN_bms_debug_float1_get(void){
	// Extract 16-bit signal at bit offset 2
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_debug.payload->word0 & 0xFFFC) >> 2) << 0;
	data |= (uint16_t)((CAN_bms_debug.payload->word1 & 0x0003) >> 0) << 14;
	return (data * 0.01) + 0;
}
float CAN_bms_debug_float2_get(void){
	// Extract 16-bit signal at bit offset 18
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_debug.payload->word1 & 0xFFFC) >> 2) << 0;
	data |= (uint16_t)((CAN_bms_debug.payload->word2 & 0x0003) >> 0) << 14;
	return (data * 0.01) + 0;
}
uint16_t CAN_bms_debug_word1_get(void){
	// Extract 16-bit signal at bit offset 34
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_debug.payload->word2 & 0xFFFC) >> 2) << 0;
	data |= (uint16_t)((CAN_bms_debug.payload->word3 & 0x0003) >> 0) << 14;
	return (data * 1) + 0;
}
uint16_t CAN_bms_debug_byte1_get(void){
	// Extract 8-bit signal at bit offset 50
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_debug.payload->word3 & 0x03FC) >> 2) << 0;
	return (data * 1) + 0;
}

/**********************************************************
 * motorcontroller NODE MESSAGES
 */
static CAN_payload_S CAN_motorcontroller_motorStatus_payload __attribute__((aligned(sizeof(CAN_payload_S))));
static volatile uint8_t CAN_motorcontroller_motorStatus_status = 0;
#define CAN_motorcontroller_motorStatus_ID 0x731

static CAN_message_S CAN_motorcontroller_motorStatus={
	.canID = CAN_motorcontroller_motorStatus_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = &CAN_motorcontroller_motorStatus_payload,
	.canMessageStatus = &CAN_motorcontroller_motorStatus_status
};

#define CAN_MOTORCONTROLLER_MOTORSTATUS_MOTORSPEED_RANGE 8
#define CAN_MOTORCONTROLLER_MOTORSTATUS_MOTORSPEED_OFFSET 0
#define CAN_MOTORCONTROLLER_MOTORSTATUS_MOTORCURRENT_RANGE 8
#define CAN_MOTORCONTROLLER_MOTORSTATUS_MOTORCURRENT_OFFSET 8
#define CAN_MOTORCONTROLLER_MOTORSTATUS_IPHASEA_RANGE 8
#define CAN_MOTORCONTROLLER_MOTORSTATUS_IPHASEA_OFFSET 16
#define CAN_MOTORCONTROLLER_MOTORSTATUS_IPHASEB_RANGE 8
#define CAN_MOTORCONTROLLER_MOTORSTATUS_IPHASEB_OFFSET 24
#define CAN_MOTORCONTROLLER_MOTORSTATUS_IPHASEC_RANGE 8
#define CAN_MOTORCONTROLLER_MOTORSTATUS_IPHASEC_OFFSET 32
#define CAN_MOTORCONTROLLER_MOTORSTATUS_VPHASEA_RANGE 8
#define CAN_MOTORCONTROLLER_MOTORSTATUS_VPHASEA_OFFSET 40
#define CAN_MOTORCONTROLLER_MOTORSTATUS_VPHASEB_RANGE 8
#define CAN_MOTORCONTROLLER_MOTORSTATUS_VPHASEB_OFFSET 48
#define CAN_MOTORCONTROLLER_MOTORSTATUS_VPHASEC_RANGE 8
#define CAN_MOTORCONTROLLER_MOTORSTATUS_VPHASEC_OFFSET 56

void CAN_motorcontroller_motorStatus_motorSpeed_set(uint16_t motorSpeed){
	uint16_t data_scaled = (motorSpeed - 0) / 1.0;
	// Set 8-bit signal at bit offset 0
	CAN_motorcontroller_motorStatus.payload->word0 &= ~0x00FF;
	CAN_motorcontroller_motorStatus.payload->word0 |= data_scaled & 0x00FF;
}
void CAN_motorcontroller_motorStatus_motorCurrent_set(float motorCurrent){
	uint16_t data_scaled = (uint16_t)((motorCurrent - 0) / 0.01 + 0.5f);
	// Set 8-bit signal at bit offset 8
	CAN_motorcontroller_motorStatus.payload->word0 &= ~0xFF00;
	CAN_motorcontroller_motorStatus.payload->word0 |= (data_scaled << 8) & 0xFF00;
}
void CAN_motorcontroller_motorStatus_IphaseA_set(uint16_t IphaseA){
	uint16_t data_scaled = (IphaseA - 0) / 1.0;
	// Set 8-bit signal at bit offset 16
	CAN_motorcontroller_motorStatus.payload->word1 &= ~0x00FF;
	CAN_motorcontroller_motorStatus.payload->word1 |= data_scaled & 0x00FF;
}
void CAN_motorcontroller_motorStatus_IphaseB_set(uint16_t IphaseB){
	uint16_t data_scaled = (IphaseB - 0) / 1.0;
	// Set 8-bit signal at bit offset 24
	CAN_motorcontroller_motorStatus.payload->word1 &= ~0xFF00;
	CAN_motorcontroller_motorStatus.payload->word1 |= (data_scaled << 8) & 0xFF00;
}
void CAN_motorcontroller_motorStatus_IphaseC_set(uint16_t IphaseC){
	uint16_t data_scaled = (IphaseC - 0) / 1.0;
	// Set 8-bit signal at bit offset 32
	CAN_motorcontroller_motorStatus.payload->word2 &= ~0x00FF;
	CAN_motorcontroller_motorStatus.payload->word2 |= data_scaled & 0x00FF;
}
void CAN_motorcontroller_motorStatus_VphaseA_set(uint16_t VphaseA){
	uint16_t data_scaled = (VphaseA - 0) / 1.0;
	// Set 8-bit signal at bit offset 40
	CAN_motorcontroller_motorStatus.payload->word2 &= ~0xFF00;
	CAN_motorcontroller_motorStatus.payload->word2 |= (data_scaled << 8) & 0xFF00;
}
void CAN_motorcontroller_motorStatus_VphaseB_set(uint16_t VphaseB){
	uint16_t data_scaled = (VphaseB - 0) / 1.0;
	// Set 8-bit signal at bit offset 48
	CAN_motorcontroller_motorStatus.payload->word3 &= ~0x00FF;
	CAN_motorcontroller_motorStatus.payload->word3 |= data_scaled & 0x00FF;
}
void CAN_motorcontroller_motorStatus_VphaseC_set(uint16_t VphaseC){
	uint16_t data_scaled = (VphaseC - 0) / 1.0;
	// Set 8-bit signal at bit offset 56
	CAN_motorcontroller_motorStatus.payload->word3 &= ~0xFF00;
	CAN_motorcontroller_motorStatus.payload->word3 |= (data_scaled << 8) & 0xFF00;
}
void CAN_motorcontroller_motorStatus_dlc_set(uint8_t dlc){
	CAN_motorcontroller_motorStatus.dlc = dlc;
}
void CAN_motorcontroller_motorStatus_send(void){
	// Update message status for self-consumption
	*CAN_motorcontroller_motorStatus.canMessageStatus = 1;
	CAN_write(CAN_motorcontroller_motorStatus);
}

static CAN_payload_S CAN_motorcontroller_response_payload __attribute__((aligned(sizeof(CAN_payload_S))));
static volatile uint8_t CAN_motorcontroller_response_status = 0;
#define CAN_motorcontroller_response_ID 0x6ff

static CAN_message_S CAN_motorcontroller_response={
	.canID = CAN_motorcontroller_response_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = &CAN_motorcontroller_response_payload,
	.canMessageStatus = &CAN_motorcontroller_response_status
};

#define CAN_MOTORCONTROLLER_RESPONSE_BYTE1_RANGE 8
#define CAN_MOTORCONTROLLER_RESPONSE_BYTE1_OFFSET 0
#define CAN_MOTORCONTROLLER_RESPONSE_BYTE2_RANGE 8
#define CAN_MOTORCONTROLLER_RESPONSE_BYTE2_OFFSET 8
#define CAN_MOTORCONTROLLER_RESPONSE_BYTE3_RANGE 8
#define CAN_MOTORCONTROLLER_RESPONSE_BYTE3_OFFSET 16
#define CAN_MOTORCONTROLLER_RESPONSE_BYTE4_RANGE 8
#define CAN_MOTORCONTROLLER_RESPONSE_BYTE4_OFFSET 24
#define CAN_MOTORCONTROLLER_RESPONSE_BYTE5_RANGE 8
#define CAN_MOTORCONTROLLER_RESPONSE_BYTE5_OFFSET 32
#define CAN_MOTORCONTROLLER_RESPONSE_BYTE6_RANGE 8
#define CAN_MOTORCONTROLLER_RESPONSE_BYTE6_OFFSET 40
#define CAN_MOTORCONTROLLER_RESPONSE_BYTE7_RANGE 8
#define CAN_MOTORCONTROLLER_RESPONSE_BYTE7_OFFSET 48
#define CAN_MOTORCONTROLLER_RESPONSE_BYTE8_RANGE 8
#define CAN_MOTORCONTROLLER_RESPONSE_BYTE8_OFFSET 56

void CAN_motorcontroller_response_byte1_set(uint16_t byte1){
	uint16_t data_scaled = (byte1 - 0) / 1.0;
	// Set 8-bit signal at bit offset 0
	CAN_motorcontroller_response.payload->word0 &= ~0x00FF;
	CAN_motorcontroller_response.payload->word0 |= data_scaled & 0x00FF;
}
void CAN_motorcontroller_response_byte2_set(uint16_t byte2){
	uint16_t data_scaled = (byte2 - 0) / 1.0;
	// Set 8-bit signal at bit offset 8
	CAN_motorcontroller_response.payload->word0 &= ~0xFF00;
	CAN_motorcontroller_response.payload->word0 |= (data_scaled << 8) & 0xFF00;
}
void CAN_motorcontroller_response_byte3_set(uint16_t byte3){
	uint16_t data_scaled = (byte3 - 0) / 1.0;
	// Set 8-bit signal at bit offset 16
	CAN_motorcontroller_response.payload->word1 &= ~0x00FF;
	CAN_motorcontroller_response.payload->word1 |= data_scaled & 0x00FF;
}
void CAN_motorcontroller_response_byte4_set(uint16_t byte4){
	uint16_t data_scaled = (byte4 - 0) / 1.0;
	// Set 8-bit signal at bit offset 24
	CAN_motorcontroller_response.payload->word1 &= ~0xFF00;
	CAN_motorcontroller_response.payload->word1 |= (data_scaled << 8) & 0xFF00;
}
void CAN_motorcontroller_response_byte5_set(uint16_t byte5){
	uint16_t data_scaled = (byte5 - 0) / 1.0;
	// Set 8-bit signal at bit offset 32
	CAN_motorcontroller_response.payload->word2 &= ~0x00FF;
	CAN_motorcontroller_response.payload->word2 |= data_scaled & 0x00FF;
}
void CAN_motorcontroller_response_byte6_set(uint16_t byte6){
	uint16_t data_scaled = (byte6 - 0) / 1.0;
	// Set 8-bit signal at bit offset 40
	CAN_motorcontroller_response.payload->word2 &= ~0xFF00;
	CAN_motorcontroller_response.payload->word2 |= (data_scaled << 8) & 0xFF00;
}
void CAN_motorcontroller_response_byte7_set(uint16_t byte7){
	uint16_t data_scaled = (byte7 - 0) / 1.0;
	// Set 8-bit signal at bit offset 48
	CAN_motorcontroller_response.payload->word3 &= ~0x00FF;
	CAN_motorcontroller_response.payload->word3 |= data_scaled & 0x00FF;
}
void CAN_motorcontroller_response_byte8_set(uint16_t byte8){
	uint16_t data_scaled = (byte8 - 0) / 1.0;
	// Set 8-bit signal at bit offset 56
	CAN_motorcontroller_response.payload->word3 &= ~0xFF00;
	CAN_motorcontroller_response.payload->word3 |= (data_scaled << 8) & 0xFF00;
}
void CAN_motorcontroller_response_dlc_set(uint8_t dlc){
	CAN_motorcontroller_response.dlc = dlc;
}
void CAN_motorcontroller_response_send(void){
	// Update message status for self-consumption
	*CAN_motorcontroller_response.canMessageStatus = 1;
	CAN_write(CAN_motorcontroller_response);
}

/**********************************************************
 * charger NODE MESSAGES
 */
/**********************************************************
 * boot_host NODE MESSAGES
 */
void CAN_DBC_init(void) {
	CAN_configureMailbox(&CAN_mcu_command);
	CAN_configureMailbox(&CAN_mcu_motorControllerRequest);
	CAN_configureMailbox(&CAN_bms_debug);
}

void CAN_send_1ms(void){
	// No messages to send at this interval
}

void CAN_send_10ms(void){
	CAN_motorcontroller_motorStatus_send();
}

void CAN_send_100ms(void){
	// No messages to send at this interval
}

void CAN_send_1000ms(void){
	// No messages to send at this interval
}
