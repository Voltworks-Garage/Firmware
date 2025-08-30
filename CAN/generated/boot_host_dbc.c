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

#define CAN_mcu_boot_response_ID 0xA2

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

uint8_t CAN_mcu_boot_response_checkDataIsUnread(void){
	return CAN_checkDataIsUnread(&CAN_mcu_boot_response);
}
uint16_t CAN_mcu_boot_response_type_get(void){
	// Extract 4-bit signal at bit offset 0
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_boot_response.payload->word0 & 0x000F) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_boot_response_code_get(void){
	// Extract 4-bit signal at bit offset 4
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_boot_response.payload->word0 & 0x00F0) >> 4) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_boot_response_byte1_get(void){
	// Extract 8-bit signal at bit offset 8
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_boot_response.payload->word0 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_boot_response_byte2_get(void){
	// Extract 8-bit signal at bit offset 16
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_boot_response.payload->word1 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_boot_response_byte3_get(void){
	// Extract 8-bit signal at bit offset 24
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_boot_response.payload->word1 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_boot_response_byte4_get(void){
	// Extract 8-bit signal at bit offset 32
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_boot_response.payload->word2 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_boot_response_byte5_get(void){
	// Extract 8-bit signal at bit offset 40
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_boot_response.payload->word2 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_boot_response_byte6_get(void){
	// Extract 8-bit signal at bit offset 48
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_boot_response.payload->word3 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_boot_response_byte7_get(void){
	// Extract 8-bit signal at bit offset 56
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_boot_response.payload->word3 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}

static CAN_payload_S CAN_mcu_mcu_debug_payloads[4] __attribute__((aligned(sizeof(CAN_payload_S))));
static uint8_t CAN_mcu_mcu_debug_mux = 0;
#define CAN_mcu_mcu_debug_ID 0x713

static CAN_message_S CAN_mcu_mcu_debug={
	.canID = CAN_mcu_mcu_debug_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
};

#define CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE 2
#define CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET 0
#define CAN_MCU_MCU_DEBUG_M2_CPU_USAGE_PERCENT_RANGE 8
#define CAN_MCU_MCU_DEBUG_M2_CPU_USAGE_PERCENT_OFFSET 2
#define CAN_MCU_MCU_DEBUG_M2_CPU_PEAK_PERCENT_RANGE 8
#define CAN_MCU_MCU_DEBUG_M2_CPU_PEAK_PERCENT_OFFSET 10
#define CAN_MCU_MCU_DEBUG_M0_DEBUG_VALUE_1_U16_RANGE 16
#define CAN_MCU_MCU_DEBUG_M0_DEBUG_VALUE_1_U16_OFFSET 2
#define CAN_MCU_MCU_DEBUG_M1_DEBUG_VALUE_1_U24_RANGE 24
#define CAN_MCU_MCU_DEBUG_M1_DEBUG_VALUE_1_U24_OFFSET 2
#define CAN_MCU_MCU_DEBUG_M1_TASK_1MS_CPU_PERCENT_RANGE 8
#define CAN_MCU_MCU_DEBUG_M1_TASK_1MS_CPU_PERCENT_OFFSET 26
#define CAN_MCU_MCU_DEBUG_M1_TASK_10MS_CPU_PERCENT_RANGE 8
#define CAN_MCU_MCU_DEBUG_M1_TASK_10MS_CPU_PERCENT_OFFSET 34
#define CAN_MCU_MCU_DEBUG_M0_TASK_100MS_CPU_PERCENT_RANGE 8
#define CAN_MCU_MCU_DEBUG_M0_TASK_100MS_CPU_PERCENT_OFFSET 18
#define CAN_MCU_MCU_DEBUG_M0_TASK_1000MS_CPU_PERCENT_RANGE 8
#define CAN_MCU_MCU_DEBUG_M0_TASK_1000MS_CPU_PERCENT_OFFSET 26
#define CAN_MCU_MCU_DEBUG_M2_DEBUG_VALUE_1_U30_RANGE 30
#define CAN_MCU_MCU_DEBUG_M2_DEBUG_VALUE_1_U30_OFFSET 18
#define CAN_MCU_MCU_DEBUG_M3_TASK_1MS_PEAK_CPU_PERCENT_RANGE 8
#define CAN_MCU_MCU_DEBUG_M3_TASK_1MS_PEAK_CPU_PERCENT_OFFSET 2
#define CAN_MCU_MCU_DEBUG_M3_TASK_10MS_PEAK_CPU_PERCENT_RANGE 8
#define CAN_MCU_MCU_DEBUG_M3_TASK_10MS_PEAK_CPU_PERCENT_OFFSET 10
#define CAN_MCU_MCU_DEBUG_M2_TASK_100MS_PEAK_CPU_PERCENT_RANGE 8
#define CAN_MCU_MCU_DEBUG_M2_TASK_100MS_PEAK_CPU_PERCENT_OFFSET 48
#define CAN_MCU_MCU_DEBUG_M2_TASK_1000MS_PEAK_CPU_PERCENT_RANGE 8
#define CAN_MCU_MCU_DEBUG_M2_TASK_1000MS_PEAK_CPU_PERCENT_OFFSET 56

uint8_t CAN_mcu_mcu_debug_checkDataIsUnread(void){
	return CAN_checkDataIsUnread(&CAN_mcu_mcu_debug);
}
uint8_t CAN_mcu_mcu_debug_checkDataIsStale(void){
	return CAN_checkDataIsStale(&CAN_mcu_mcu_debug, 20);
}
uint16_t CAN_mcu_mcu_debug_Multiplex_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	// Extract 2-bit signal at bit offset 0
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug.payload->word0 & 0x0003) >> 0) << 0;
	return (data * 1.0) + 0;
}
float CAN_mcu_mcu_debug_cpu_usage_percent_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	// Extract 8-bit signal at bit offset 2
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[2].word0 & 0x03FC) >> 2) << 0;
	return (data * 0.5) + 0;
}
float CAN_mcu_mcu_debug_cpu_peak_percent_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	// Extract 8-bit signal at bit offset 10
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[2].word0 & 0xFC00) >> 10) << 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[2].word1 & 0x0003) >> 0) << 6;
	return (data * 0.5) + 0;
}
uint16_t CAN_mcu_mcu_debug_debug_value_1_u16_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	// Extract 16-bit signal at bit offset 2
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[0].word0 & 0xFFFC) >> 2) << 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[0].word1 & 0x0003) >> 0) << 14;
	return (data * 1.0) + 0;
}
uint32_t CAN_mcu_mcu_debug_debug_value_1_u24_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	// Extract 24-bit signal at bit offset 2
	uint32_t data = 0;
	data |= (uint32_t)((CAN_mcu_mcu_debug_payloads[1].word0 & 0xFFFC) >> 2) << 0;
	data |= (uint32_t)((CAN_mcu_mcu_debug_payloads[1].word1 & 0x03FF) >> 0) << 14;
	return (data * 1.0) + 0;
}
float CAN_mcu_mcu_debug_task_1ms_cpu_percent_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	// Extract 8-bit signal at bit offset 26
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[1].word1 & 0xFC00) >> 10) << 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[1].word2 & 0x0003) >> 0) << 6;
	return (data * 1) + 0;
}
float CAN_mcu_mcu_debug_task_10ms_cpu_percent_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	// Extract 8-bit signal at bit offset 34
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[1].word2 & 0x03FC) >> 2) << 0;
	return (data * 1) + 0;
}
float CAN_mcu_mcu_debug_task_100ms_cpu_percent_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	// Extract 8-bit signal at bit offset 18
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[0].word1 & 0x03FC) >> 2) << 0;
	return (data * 1) + 0;
}
float CAN_mcu_mcu_debug_task_1000ms_cpu_percent_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	// Extract 8-bit signal at bit offset 26
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[0].word1 & 0xFC00) >> 10) << 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[0].word2 & 0x0003) >> 0) << 6;
	return (data * 1) + 0;
}
uint32_t CAN_mcu_mcu_debug_debug_value_1_u30_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	// Extract 30-bit signal at bit offset 18
	uint32_t data = 0;
	data |= (uint32_t)((CAN_mcu_mcu_debug_payloads[2].word1 & 0xFFFC) >> 2) << 0;
	data |= (uint32_t)((CAN_mcu_mcu_debug_payloads[2].word2 & 0xFFFF) >> 0) << 14;
	return (data * 1.0) + 0;
}
float CAN_mcu_mcu_debug_task_1ms_peak_cpu_percent_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	// Extract 8-bit signal at bit offset 2
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[3].word0 & 0x03FC) >> 2) << 0;
	return (data * 1) + 0;
}
float CAN_mcu_mcu_debug_task_10ms_peak_cpu_percent_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	// Extract 8-bit signal at bit offset 10
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[3].word0 & 0xFC00) >> 10) << 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[3].word1 & 0x0003) >> 0) << 6;
	return (data * 1) + 0;
}
float CAN_mcu_mcu_debug_task_100ms_peak_cpu_percent_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	// Extract 8-bit signal at bit offset 48
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[2].word3 & 0x00FF) >> 0) << 0;
	return (data * 1) + 0;
}
float CAN_mcu_mcu_debug_task_1000ms_peak_cpu_percent_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	// Extract 8-bit signal at bit offset 56
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[2].word3 & 0xFF00) >> 8) << 0;
	return (data * 1) + 0;
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

#define CAN_bms_boot_response_ID 0xA2

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

uint8_t CAN_bms_boot_response_checkDataIsUnread(void){
	return CAN_checkDataIsUnread(&CAN_bms_boot_response);
}
uint16_t CAN_bms_boot_response_type_get(void){
	// Extract 4-bit signal at bit offset 0
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_boot_response.payload->word0 & 0x000F) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_boot_response_code_get(void){
	// Extract 4-bit signal at bit offset 4
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_boot_response.payload->word0 & 0x00F0) >> 4) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_boot_response_byte1_get(void){
	// Extract 8-bit signal at bit offset 8
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_boot_response.payload->word0 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_boot_response_byte2_get(void){
	// Extract 8-bit signal at bit offset 16
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_boot_response.payload->word1 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_boot_response_byte3_get(void){
	// Extract 8-bit signal at bit offset 24
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_boot_response.payload->word1 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_boot_response_byte4_get(void){
	// Extract 8-bit signal at bit offset 32
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_boot_response.payload->word2 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_boot_response_byte5_get(void){
	// Extract 8-bit signal at bit offset 40
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_boot_response.payload->word2 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_boot_response_byte6_get(void){
	// Extract 8-bit signal at bit offset 48
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_boot_response.payload->word3 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_boot_response_byte7_get(void){
	// Extract 8-bit signal at bit offset 56
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_boot_response.payload->word3 & 0xFF00) >> 8) << 0;
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
static volatile uint8_t CAN_boot_host_bms_status = 0;
#define CAN_boot_host_bms_ID 0xA1

static CAN_message_S CAN_boot_host_bms={
	.canID = CAN_boot_host_bms_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = &CAN_boot_host_bms_payload,
	.canMessageStatus = &CAN_boot_host_bms_status
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
	uint16_t data_scaled = type * 1.0;
	// Set 4-bit signal at bit offset 0
	CAN_boot_host_bms.payload->word0 &= ~0x000F;
	CAN_boot_host_bms.payload->word0 |= data_scaled & 0x000F;
}
void CAN_boot_host_bms_code_set(uint16_t code){
	uint16_t data_scaled = code * 1.0;
	// Set 4-bit signal at bit offset 4
	CAN_boot_host_bms.payload->word0 &= ~0x00F0;
	CAN_boot_host_bms.payload->word0 |= (data_scaled << 4) & 0x00F0;
}
void CAN_boot_host_bms_byte1_set(uint16_t byte1){
	uint16_t data_scaled = byte1 * 1.0;
	// Set 8-bit signal at bit offset 8
	CAN_boot_host_bms.payload->word0 &= ~0xFF00;
	CAN_boot_host_bms.payload->word0 |= (data_scaled << 8) & 0xFF00;
}
void CAN_boot_host_bms_byte2_set(uint16_t byte2){
	uint16_t data_scaled = byte2 * 1.0;
	// Set 8-bit signal at bit offset 16
	CAN_boot_host_bms.payload->word1 &= ~0x00FF;
	CAN_boot_host_bms.payload->word1 |= data_scaled & 0x00FF;
}
void CAN_boot_host_bms_byte3_set(uint16_t byte3){
	uint16_t data_scaled = byte3 * 1.0;
	// Set 8-bit signal at bit offset 24
	CAN_boot_host_bms.payload->word1 &= ~0xFF00;
	CAN_boot_host_bms.payload->word1 |= (data_scaled << 8) & 0xFF00;
}
void CAN_boot_host_bms_byte4_set(uint16_t byte4){
	uint16_t data_scaled = byte4 * 1.0;
	// Set 8-bit signal at bit offset 32
	CAN_boot_host_bms.payload->word2 &= ~0x00FF;
	CAN_boot_host_bms.payload->word2 |= data_scaled & 0x00FF;
}
void CAN_boot_host_bms_byte5_set(uint16_t byte5){
	uint16_t data_scaled = byte5 * 1.0;
	// Set 8-bit signal at bit offset 40
	CAN_boot_host_bms.payload->word2 &= ~0xFF00;
	CAN_boot_host_bms.payload->word2 |= (data_scaled << 8) & 0xFF00;
}
void CAN_boot_host_bms_byte6_set(uint16_t byte6){
	uint16_t data_scaled = byte6 * 1.0;
	// Set 8-bit signal at bit offset 48
	CAN_boot_host_bms.payload->word3 &= ~0x00FF;
	CAN_boot_host_bms.payload->word3 |= data_scaled & 0x00FF;
}
void CAN_boot_host_bms_byte7_set(uint16_t byte7){
	uint16_t data_scaled = byte7 * 1.0;
	// Set 8-bit signal at bit offset 56
	CAN_boot_host_bms.payload->word3 &= ~0xFF00;
	CAN_boot_host_bms.payload->word3 |= (data_scaled << 8) & 0xFF00;
}
void CAN_boot_host_bms_dlc_set(uint8_t dlc){
	CAN_boot_host_bms.dlc = dlc;
}
void CAN_boot_host_bms_send(void){
	// Update message status for self-consumption
	*CAN_boot_host_bms.canMessageStatus = 1;
	CAN_write(&CAN_boot_host_bms);
}

static CAN_payload_S CAN_boot_host_mcu_payload __attribute__((aligned(sizeof(CAN_payload_S))));
static volatile uint8_t CAN_boot_host_mcu_status = 0;
#define CAN_boot_host_mcu_ID 0xA3

static CAN_message_S CAN_boot_host_mcu={
	.canID = CAN_boot_host_mcu_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = &CAN_boot_host_mcu_payload,
	.canMessageStatus = &CAN_boot_host_mcu_status
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
	uint16_t data_scaled = type * 1.0;
	// Set 4-bit signal at bit offset 0
	CAN_boot_host_mcu.payload->word0 &= ~0x000F;
	CAN_boot_host_mcu.payload->word0 |= data_scaled & 0x000F;
}
void CAN_boot_host_mcu_code_set(uint16_t code){
	uint16_t data_scaled = code * 1.0;
	// Set 4-bit signal at bit offset 4
	CAN_boot_host_mcu.payload->word0 &= ~0x00F0;
	CAN_boot_host_mcu.payload->word0 |= (data_scaled << 4) & 0x00F0;
}
void CAN_boot_host_mcu_byte1_set(uint16_t byte1){
	uint16_t data_scaled = byte1 * 1.0;
	// Set 8-bit signal at bit offset 8
	CAN_boot_host_mcu.payload->word0 &= ~0xFF00;
	CAN_boot_host_mcu.payload->word0 |= (data_scaled << 8) & 0xFF00;
}
void CAN_boot_host_mcu_byte2_set(uint16_t byte2){
	uint16_t data_scaled = byte2 * 1.0;
	// Set 8-bit signal at bit offset 16
	CAN_boot_host_mcu.payload->word1 &= ~0x00FF;
	CAN_boot_host_mcu.payload->word1 |= data_scaled & 0x00FF;
}
void CAN_boot_host_mcu_byte3_set(uint16_t byte3){
	uint16_t data_scaled = byte3 * 1.0;
	// Set 8-bit signal at bit offset 24
	CAN_boot_host_mcu.payload->word1 &= ~0xFF00;
	CAN_boot_host_mcu.payload->word1 |= (data_scaled << 8) & 0xFF00;
}
void CAN_boot_host_mcu_byte4_set(uint16_t byte4){
	uint16_t data_scaled = byte4 * 1.0;
	// Set 8-bit signal at bit offset 32
	CAN_boot_host_mcu.payload->word2 &= ~0x00FF;
	CAN_boot_host_mcu.payload->word2 |= data_scaled & 0x00FF;
}
void CAN_boot_host_mcu_byte5_set(uint16_t byte5){
	uint16_t data_scaled = byte5 * 1.0;
	// Set 8-bit signal at bit offset 40
	CAN_boot_host_mcu.payload->word2 &= ~0xFF00;
	CAN_boot_host_mcu.payload->word2 |= (data_scaled << 8) & 0xFF00;
}
void CAN_boot_host_mcu_byte6_set(uint16_t byte6){
	uint16_t data_scaled = byte6 * 1.0;
	// Set 8-bit signal at bit offset 48
	CAN_boot_host_mcu.payload->word3 &= ~0x00FF;
	CAN_boot_host_mcu.payload->word3 |= data_scaled & 0x00FF;
}
void CAN_boot_host_mcu_byte7_set(uint16_t byte7){
	uint16_t data_scaled = byte7 * 1.0;
	// Set 8-bit signal at bit offset 56
	CAN_boot_host_mcu.payload->word3 &= ~0xFF00;
	CAN_boot_host_mcu.payload->word3 |= (data_scaled << 8) & 0xFF00;
}
void CAN_boot_host_mcu_dlc_set(uint8_t dlc){
	CAN_boot_host_mcu.dlc = dlc;
}
void CAN_boot_host_mcu_send(void){
	// Update message status for self-consumption
	*CAN_boot_host_mcu.canMessageStatus = 1;
	CAN_write(&CAN_boot_host_mcu);
}

static CAN_payload_S CAN_boot_host_dash_payload __attribute__((aligned(sizeof(CAN_payload_S))));
static volatile uint8_t CAN_boot_host_dash_status = 0;
#define CAN_boot_host_dash_ID 0xA5

static CAN_message_S CAN_boot_host_dash={
	.canID = CAN_boot_host_dash_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = &CAN_boot_host_dash_payload,
	.canMessageStatus = &CAN_boot_host_dash_status
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
	uint16_t data_scaled = type * 1.0;
	// Set 4-bit signal at bit offset 0
	CAN_boot_host_dash.payload->word0 &= ~0x000F;
	CAN_boot_host_dash.payload->word0 |= data_scaled & 0x000F;
}
void CAN_boot_host_dash_code_set(uint16_t code){
	uint16_t data_scaled = code * 1.0;
	// Set 4-bit signal at bit offset 4
	CAN_boot_host_dash.payload->word0 &= ~0x00F0;
	CAN_boot_host_dash.payload->word0 |= (data_scaled << 4) & 0x00F0;
}
void CAN_boot_host_dash_byte1_set(uint16_t byte1){
	uint16_t data_scaled = byte1 * 1.0;
	// Set 8-bit signal at bit offset 8
	CAN_boot_host_dash.payload->word0 &= ~0xFF00;
	CAN_boot_host_dash.payload->word0 |= (data_scaled << 8) & 0xFF00;
}
void CAN_boot_host_dash_byte2_set(uint16_t byte2){
	uint16_t data_scaled = byte2 * 1.0;
	// Set 8-bit signal at bit offset 16
	CAN_boot_host_dash.payload->word1 &= ~0x00FF;
	CAN_boot_host_dash.payload->word1 |= data_scaled & 0x00FF;
}
void CAN_boot_host_dash_byte3_set(uint16_t byte3){
	uint16_t data_scaled = byte3 * 1.0;
	// Set 8-bit signal at bit offset 24
	CAN_boot_host_dash.payload->word1 &= ~0xFF00;
	CAN_boot_host_dash.payload->word1 |= (data_scaled << 8) & 0xFF00;
}
void CAN_boot_host_dash_byte4_set(uint16_t byte4){
	uint16_t data_scaled = byte4 * 1.0;
	// Set 8-bit signal at bit offset 32
	CAN_boot_host_dash.payload->word2 &= ~0x00FF;
	CAN_boot_host_dash.payload->word2 |= data_scaled & 0x00FF;
}
void CAN_boot_host_dash_byte5_set(uint16_t byte5){
	uint16_t data_scaled = byte5 * 1.0;
	// Set 8-bit signal at bit offset 40
	CAN_boot_host_dash.payload->word2 &= ~0xFF00;
	CAN_boot_host_dash.payload->word2 |= (data_scaled << 8) & 0xFF00;
}
void CAN_boot_host_dash_byte6_set(uint16_t byte6){
	uint16_t data_scaled = byte6 * 1.0;
	// Set 8-bit signal at bit offset 48
	CAN_boot_host_dash.payload->word3 &= ~0x00FF;
	CAN_boot_host_dash.payload->word3 |= data_scaled & 0x00FF;
}
void CAN_boot_host_dash_byte7_set(uint16_t byte7){
	uint16_t data_scaled = byte7 * 1.0;
	// Set 8-bit signal at bit offset 56
	CAN_boot_host_dash.payload->word3 &= ~0xFF00;
	CAN_boot_host_dash.payload->word3 |= (data_scaled << 8) & 0xFF00;
}
void CAN_boot_host_dash_dlc_set(uint8_t dlc){
	CAN_boot_host_dash.dlc = dlc;
}
void CAN_boot_host_dash_send(void){
	// Update message status for self-consumption
	*CAN_boot_host_dash.canMessageStatus = 1;
	CAN_write(&CAN_boot_host_dash);
}

void CAN_DBC_init(void) {
	CAN_configureMailbox(&CAN_mcu_command);
	CAN_configureMailbox(&CAN_mcu_boot_response);
	CAN_configureMailbox(&CAN_mcu_mcu_debug);
	CAN_configureMailbox(&CAN_bms_debug);
	CAN_configureMailbox(&CAN_bms_boot_response);
}

void CAN_send_1ms(void){
	CAN_boot_host_bms_send();
	CAN_boot_host_mcu_send();
	CAN_boot_host_dash_send();
}

void CAN_send_10ms(void){
	// No messages to send at this interval
}

void CAN_send_100ms(void){
	// No messages to send at this interval
}

void CAN_send_1000ms(void){
	// No messages to send at this interval
}
