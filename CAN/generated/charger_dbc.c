#include "charger_dbc.h"
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

#define CAN_bms_charger_request_ID 0x18005074

static CAN_message_S CAN_bms_charger_request={
	.canID = CAN_bms_charger_request_ID,
	.canXID = 1,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
};

#define CAN_BMS_CHARGER_REQUEST_OUTPUT_VOLTAGE_HIGH_BYTE_RANGE 8
#define CAN_BMS_CHARGER_REQUEST_OUTPUT_VOLTAGE_HIGH_BYTE_OFFSET 0
#define CAN_BMS_CHARGER_REQUEST_OUTPUT_VOLTAGE_LOW_BYTE_RANGE 8
#define CAN_BMS_CHARGER_REQUEST_OUTPUT_VOLTAGE_LOW_BYTE_OFFSET 8
#define CAN_BMS_CHARGER_REQUEST_OUTPUT_CURRENT_HIGH_BYTE_RANGE 8
#define CAN_BMS_CHARGER_REQUEST_OUTPUT_CURRENT_HIGH_BYTE_OFFSET 16
#define CAN_BMS_CHARGER_REQUEST_OUTPUT_CURRENT_LOW_BYTE_RANGE 8
#define CAN_BMS_CHARGER_REQUEST_OUTPUT_CURRENT_LOW_BYTE_OFFSET 24
#define CAN_BMS_CHARGER_REQUEST_START_CHARGE_NOT_REQUEST_RANGE 8
#define CAN_BMS_CHARGER_REQUEST_START_CHARGE_NOT_REQUEST_OFFSET 32
#define CAN_BMS_CHARGER_REQUEST_CHARGE_MODE_RANGE 8
#define CAN_BMS_CHARGER_REQUEST_CHARGE_MODE_OFFSET 40
#define CAN_BMS_CHARGER_REQUEST_BYTE_7_RANGE 8
#define CAN_BMS_CHARGER_REQUEST_BYTE_7_OFFSET 48
#define CAN_BMS_CHARGER_REQUEST_BYTE_8_RANGE 8
#define CAN_BMS_CHARGER_REQUEST_BYTE_8_OFFSET 56

uint8_t CAN_bms_charger_request_checkDataIsUnread(void){
	return CAN_checkDataIsUnread(&CAN_bms_charger_request);
}
uint8_t CAN_bms_charger_request_checkDataIsStale(void){
	return CAN_checkDataIsStale(&CAN_bms_charger_request, 2000);
}
uint16_t CAN_bms_charger_request_output_voltage_high_byte_get(void){
	// Extract 8-bit signal at bit offset 0
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_charger_request.payload->word0 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_charger_request_output_voltage_low_byte_get(void){
	// Extract 8-bit signal at bit offset 8
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_charger_request.payload->word0 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_charger_request_output_current_high_byte_get(void){
	// Extract 8-bit signal at bit offset 16
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_charger_request.payload->word1 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_charger_request_output_current_low_byte_get(void){
	// Extract 8-bit signal at bit offset 24
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_charger_request.payload->word1 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_charger_request_start_charge_not_request_get(void){
	// Extract 8-bit signal at bit offset 32
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_charger_request.payload->word2 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_charger_request_charge_mode_get(void){
	// Extract 8-bit signal at bit offset 40
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_charger_request.payload->word2 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_charger_request_byte_7_get(void){
	// Extract 8-bit signal at bit offset 48
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_charger_request.payload->word3 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_charger_request_byte_8_get(void){
	// Extract 8-bit signal at bit offset 56
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_charger_request.payload->word3 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}

/**********************************************************
 * motorcontroller NODE MESSAGES
 */
/**********************************************************
 * charger NODE MESSAGES
 */
static CAN_payload_S CAN_charger_status_payload __attribute__((aligned(sizeof(CAN_payload_S))));
static volatile uint8_t CAN_charger_status_status = 0;
#define CAN_charger_status_ID 0x19005075

static CAN_message_S CAN_charger_status={
	.canID = CAN_charger_status_ID,
	.canXID = 1,
	.dlc = 8,
	.payload = &CAN_charger_status_payload,
	.canMessageStatus = &CAN_charger_status_status
};

#define CAN_CHARGER_STATUS_OUTPUT_VOLTAGE_HIGH_BYTE_RANGE 8
#define CAN_CHARGER_STATUS_OUTPUT_VOLTAGE_HIGH_BYTE_OFFSET 0
#define CAN_CHARGER_STATUS_OUTPUT_VOLTAGE_LOW_BYTE_RANGE 8
#define CAN_CHARGER_STATUS_OUTPUT_VOLTAGE_LOW_BYTE_OFFSET 8
#define CAN_CHARGER_STATUS_OUTPUT_CURRENT_HIGH_BYTE_RANGE 8
#define CAN_CHARGER_STATUS_OUTPUT_CURRENT_HIGH_BYTE_OFFSET 16
#define CAN_CHARGER_STATUS_OUTPUT_CURRENT_LOW_BYTE_RANGE 8
#define CAN_CHARGER_STATUS_OUTPUT_CURRENT_LOW_BYTE_OFFSET 24
#define CAN_CHARGER_STATUS_HARDWARE_ERROR_RANGE 1
#define CAN_CHARGER_STATUS_HARDWARE_ERROR_OFFSET 32
#define CAN_CHARGER_STATUS_CHARGER_OVERTEMP_ERROR_RANGE 1
#define CAN_CHARGER_STATUS_CHARGER_OVERTEMP_ERROR_OFFSET 33
#define CAN_CHARGER_STATUS_INPUT_VOLTAGE_ERROR_RANGE 1
#define CAN_CHARGER_STATUS_INPUT_VOLTAGE_ERROR_OFFSET 34
#define CAN_CHARGER_STATUS_BATTERY_DETECT_ERROR_RANGE 1
#define CAN_CHARGER_STATUS_BATTERY_DETECT_ERROR_OFFSET 35
#define CAN_CHARGER_STATUS_COMMUNICATION_ERROR_RANGE 1
#define CAN_CHARGER_STATUS_COMMUNICATION_ERROR_OFFSET 36
#define CAN_CHARGER_STATUS_BYTE7_RANGE 8
#define CAN_CHARGER_STATUS_BYTE7_OFFSET 37
#define CAN_CHARGER_STATUS_BYTE8_RANGE 8
#define CAN_CHARGER_STATUS_BYTE8_OFFSET 45

void CAN_charger_status_output_voltage_high_byte_set(uint16_t output_voltage_high_byte){
	uint16_t data_scaled = output_voltage_high_byte * 1.0;
	// Set 8-bit signal at bit offset 0
	CAN_charger_status.payload->word0 &= ~0x00FF;
	CAN_charger_status.payload->word0 |= data_scaled & 0x00FF;
}
void CAN_charger_status_output_voltage_low_byte_set(uint16_t output_voltage_low_byte){
	uint16_t data_scaled = output_voltage_low_byte * 1.0;
	// Set 8-bit signal at bit offset 8
	CAN_charger_status.payload->word0 &= ~0xFF00;
	CAN_charger_status.payload->word0 |= (data_scaled << 8) & 0xFF00;
}
void CAN_charger_status_output_current_high_byte_set(uint16_t output_current_high_byte){
	uint16_t data_scaled = output_current_high_byte * 1.0;
	// Set 8-bit signal at bit offset 16
	CAN_charger_status.payload->word1 &= ~0x00FF;
	CAN_charger_status.payload->word1 |= data_scaled & 0x00FF;
}
void CAN_charger_status_output_current_low_byte_set(uint16_t output_current_low_byte){
	uint16_t data_scaled = output_current_low_byte * 1.0;
	// Set 8-bit signal at bit offset 24
	CAN_charger_status.payload->word1 &= ~0xFF00;
	CAN_charger_status.payload->word1 |= (data_scaled << 8) & 0xFF00;
}
void CAN_charger_status_hardware_error_set(uint16_t hardware_error){
	uint16_t data_scaled = hardware_error * 1.0;
	// Set 1-bit signal at bit offset 32
	CAN_charger_status.payload->word2 &= ~0x0001;
	CAN_charger_status.payload->word2 |= data_scaled & 0x0001;
}
void CAN_charger_status_charger_overtemp_error_set(uint16_t charger_overtemp_error){
	uint16_t data_scaled = charger_overtemp_error * 1.0;
	// Set 1-bit signal at bit offset 33
	CAN_charger_status.payload->word2 &= ~0x0002;
	CAN_charger_status.payload->word2 |= (data_scaled << 1) & 0x0002;
}
void CAN_charger_status_input_voltage_error_set(uint16_t input_voltage_error){
	uint16_t data_scaled = input_voltage_error * 1.0;
	// Set 1-bit signal at bit offset 34
	CAN_charger_status.payload->word2 &= ~0x0004;
	CAN_charger_status.payload->word2 |= (data_scaled << 2) & 0x0004;
}
void CAN_charger_status_battery_detect_error_set(uint16_t battery_detect_error){
	uint16_t data_scaled = battery_detect_error * 1.0;
	// Set 1-bit signal at bit offset 35
	CAN_charger_status.payload->word2 &= ~0x0008;
	CAN_charger_status.payload->word2 |= (data_scaled << 3) & 0x0008;
}
void CAN_charger_status_communication_error_set(uint16_t communication_error){
	uint16_t data_scaled = communication_error * 1.0;
	// Set 1-bit signal at bit offset 36
	CAN_charger_status.payload->word2 &= ~0x0010;
	CAN_charger_status.payload->word2 |= (data_scaled << 4) & 0x0010;
}
void CAN_charger_status_byte7_set(uint16_t byte7){
	uint16_t data_scaled = byte7 * 1.0;
	// Set 8-bit signal at bit offset 37
	CAN_charger_status.payload->word2 &= ~0x1FE0;
	CAN_charger_status.payload->word2 |= (data_scaled << 5) & 0x1FE0;
}
void CAN_charger_status_byte8_set(uint16_t byte8){
	uint16_t data_scaled = byte8 * 1.0;
	// Set 8-bit signal at bit offset 45
	CAN_charger_status.payload->word2 &= ~0xE000;
	CAN_charger_status.payload->word2 |= (data_scaled << 13) & 0xE000;
	CAN_charger_status.payload->word3 &= ~0x001F;
	CAN_charger_status.payload->word3 |= (data_scaled >> 3) & 0x001F;
}
void CAN_charger_status_dlc_set(uint8_t dlc){
	CAN_charger_status.dlc = dlc;
}
void CAN_charger_status_send(void){
	// Update message status for self-consumption
	*CAN_charger_status.canMessageStatus = 1;
	CAN_write(&CAN_charger_status);
}

/**********************************************************
 * boot_host NODE MESSAGES
 */
void CAN_DBC_init(void) {
	CAN_configureMailbox(&CAN_mcu_command);
	CAN_configureMailbox(&CAN_mcu_mcu_debug);
	CAN_configureMailbox(&CAN_bms_debug);
	CAN_configureMailbox(&CAN_bms_charger_request);
}

void CAN_send_1ms(void){
	// No messages to send at this interval
}

void CAN_send_10ms(void){
	// No messages to send at this interval
}

void CAN_send_100ms(void){
	// No messages to send at this interval
}

void CAN_send_1000ms(void){
	CAN_charger_status_send();
}
