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

#define CAN_mcu_motorControllerRequest_ID 0x201

static CAN_message_S CAN_mcu_motorControllerRequest={
	.canID = CAN_mcu_motorControllerRequest_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
};

#define CAN_MCU_MOTORCONTROLLERREQUEST_THROTTLE_VALUE_RANGE 16
#define CAN_MCU_MOTORCONTROLLERREQUEST_THROTTLE_VALUE_OFFSET 0
#define CAN_MCU_MOTORCONTROLLERREQUEST_FORWARD_SWITCH_RANGE 1
#define CAN_MCU_MOTORCONTROLLERREQUEST_FORWARD_SWITCH_OFFSET 16
#define CAN_MCU_MOTORCONTROLLERREQUEST_REVERSE_SWITCH_RANGE 1
#define CAN_MCU_MOTORCONTROLLERREQUEST_REVERSE_SWITCH_OFFSET 17
#define CAN_MCU_MOTORCONTROLLERREQUEST_FS1_SWITCH_RANGE 1
#define CAN_MCU_MOTORCONTROLLERREQUEST_FS1_SWITCH_OFFSET 18
#define CAN_MCU_MOTORCONTROLLERREQUEST_SEAT_SWITCH_RANGE 1
#define CAN_MCU_MOTORCONTROLLERREQUEST_SEAT_SWITCH_OFFSET 19
#define CAN_MCU_MOTORCONTROLLERREQUEST_HANDBRAKE_SWITCH_RANGE 1
#define CAN_MCU_MOTORCONTROLLERREQUEST_HANDBRAKE_SWITCH_OFFSET 20

uint8_t CAN_mcu_motorControllerRequest_checkDataIsUnread(void){
	return CAN_checkDataIsUnread(&CAN_mcu_motorControllerRequest);
}
uint16_t CAN_mcu_motorControllerRequest_Throttle_Value_get(void){
	// Extract 16-bit signal at bit offset 0
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_motorControllerRequest.payload->word0 & 0xFFFF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_motorControllerRequest_Forward_Switch_get(void){
	// Extract 1-bit signal at bit offset 16
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_motorControllerRequest.payload->word1 & 0x0001) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_motorControllerRequest_Reverse_Switch_get(void){
	// Extract 1-bit signal at bit offset 17
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_motorControllerRequest.payload->word1 & 0x0002) >> 1) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_motorControllerRequest_FS1_Switch_get(void){
	// Extract 1-bit signal at bit offset 18
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_motorControllerRequest.payload->word1 & 0x0004) >> 2) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_motorControllerRequest_Seat_Switch_get(void){
	// Extract 1-bit signal at bit offset 19
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_motorControllerRequest.payload->word1 & 0x0008) >> 3) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_motorControllerRequest_Handbrake_Switch_get(void){
	// Extract 1-bit signal at bit offset 20
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_motorControllerRequest.payload->word1 & 0x0010) >> 4) << 0;
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

#define CAN_bms_SDO_request_ID 0x601

static CAN_message_S CAN_bms_SDO_request={
	.canID = CAN_bms_SDO_request_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
};

#define CAN_BMS_SDO_REQUEST_SIZE_RANGE 1
#define CAN_BMS_SDO_REQUEST_SIZE_OFFSET 0
#define CAN_BMS_SDO_REQUEST_EXPIDITED_XFER_RANGE 1
#define CAN_BMS_SDO_REQUEST_EXPIDITED_XFER_OFFSET 1
#define CAN_BMS_SDO_REQUEST_N_BYTES_RANGE 2
#define CAN_BMS_SDO_REQUEST_N_BYTES_OFFSET 2
#define CAN_BMS_SDO_REQUEST_RESERVED_RANGE 1
#define CAN_BMS_SDO_REQUEST_RESERVED_OFFSET 4
#define CAN_BMS_SDO_REQUEST_CCS_RANGE 3
#define CAN_BMS_SDO_REQUEST_CCS_OFFSET 5
#define CAN_BMS_SDO_REQUEST_INDEX_RANGE 16
#define CAN_BMS_SDO_REQUEST_INDEX_OFFSET 8
#define CAN_BMS_SDO_REQUEST_SUBINDEX_RANGE 8
#define CAN_BMS_SDO_REQUEST_SUBINDEX_OFFSET 24
#define CAN_BMS_SDO_REQUEST_BYTE_4_RANGE 8
#define CAN_BMS_SDO_REQUEST_BYTE_4_OFFSET 32
#define CAN_BMS_SDO_REQUEST_BYTE_5_RANGE 8
#define CAN_BMS_SDO_REQUEST_BYTE_5_OFFSET 40
#define CAN_BMS_SDO_REQUEST_BYTE_6_RANGE 8
#define CAN_BMS_SDO_REQUEST_BYTE_6_OFFSET 48
#define CAN_BMS_SDO_REQUEST_BYTE_7_RANGE 8
#define CAN_BMS_SDO_REQUEST_BYTE_7_OFFSET 56

uint8_t CAN_bms_SDO_request_checkDataIsUnread(void){
	return CAN_checkDataIsUnread(&CAN_bms_SDO_request);
}
uint16_t CAN_bms_SDO_request_size_get(void){
	// Extract 1-bit signal at bit offset 0
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_SDO_request.payload->word0 & 0x0001) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_SDO_request_expidited_xfer_get(void){
	// Extract 1-bit signal at bit offset 1
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_SDO_request.payload->word0 & 0x0002) >> 1) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_SDO_request_n_bytes_get(void){
	// Extract 2-bit signal at bit offset 2
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_SDO_request.payload->word0 & 0x000C) >> 2) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_SDO_request_reserved_get(void){
	// Extract 1-bit signal at bit offset 4
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_SDO_request.payload->word0 & 0x0010) >> 4) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_SDO_request_ccs_get(void){
	// Extract 3-bit signal at bit offset 5
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_SDO_request.payload->word0 & 0x00E0) >> 5) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_SDO_request_index_get(void){
	// Extract 16-bit signal at bit offset 8
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_SDO_request.payload->word0 & 0xFF00) >> 8) << 0;
	data |= (uint16_t)((CAN_bms_SDO_request.payload->word1 & 0x00FF) >> 0) << 8;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_SDO_request_subindex_get(void){
	// Extract 8-bit signal at bit offset 24
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_SDO_request.payload->word1 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_SDO_request_byte_4_get(void){
	// Extract 8-bit signal at bit offset 32
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_SDO_request.payload->word2 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_SDO_request_byte_5_get(void){
	// Extract 8-bit signal at bit offset 40
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_SDO_request.payload->word2 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_SDO_request_byte_6_get(void){
	// Extract 8-bit signal at bit offset 48
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_SDO_request.payload->word3 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_SDO_request_byte_7_get(void){
	// Extract 8-bit signal at bit offset 56
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_SDO_request.payload->word3 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}

/**********************************************************
 * motorcontroller NODE MESSAGES
 */
static CAN_payload_S CAN_motorcontroller_heartbeat_payload __attribute__((aligned(sizeof(CAN_payload_S))));
static volatile uint8_t CAN_motorcontroller_heartbeat_status = 0;
#define CAN_motorcontroller_heartbeat_ID 0x701

static CAN_message_S CAN_motorcontroller_heartbeat={
	.canID = CAN_motorcontroller_heartbeat_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = &CAN_motorcontroller_heartbeat_payload,
	.canMessageStatus = &CAN_motorcontroller_heartbeat_status
};

#define CAN_MOTORCONTROLLER_HEARTBEAT_MODE_RANGE 16
#define CAN_MOTORCONTROLLER_HEARTBEAT_MODE_OFFSET 0

void CAN_motorcontroller_heartbeat_Mode_set(uint16_t Mode){
	uint16_t data_scaled = Mode * 1.0;
	// Set 16-bit signal at bit offset 0
	CAN_motorcontroller_heartbeat.payload->word0 &= ~0xFFFF;
	CAN_motorcontroller_heartbeat.payload->word0 |= data_scaled & 0xFFFF;
}
void CAN_motorcontroller_heartbeat_dlc_set(uint8_t dlc){
	CAN_motorcontroller_heartbeat.dlc = dlc;
}
void CAN_motorcontroller_heartbeat_send(void){
	// Update message status for self-consumption
	*CAN_motorcontroller_heartbeat.canMessageStatus = 1;
	CAN_write(&CAN_motorcontroller_heartbeat);
}

static CAN_payload_S CAN_motorcontroller_SYNC_payload __attribute__((aligned(sizeof(CAN_payload_S))));
static volatile uint8_t CAN_motorcontroller_SYNC_status = 0;
#define CAN_motorcontroller_SYNC_ID 0x80

static CAN_message_S CAN_motorcontroller_SYNC={
	.canID = CAN_motorcontroller_SYNC_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = &CAN_motorcontroller_SYNC_payload,
	.canMessageStatus = &CAN_motorcontroller_SYNC_status
};


void CAN_motorcontroller_SYNC_dlc_set(uint8_t dlc){
	CAN_motorcontroller_SYNC.dlc = dlc;
}
void CAN_motorcontroller_SYNC_send(void){
	// Update message status for self-consumption
	*CAN_motorcontroller_SYNC.canMessageStatus = 1;
	CAN_write(&CAN_motorcontroller_SYNC);
}

static CAN_payload_S CAN_motorcontroller_SDO_response_payload __attribute__((aligned(sizeof(CAN_payload_S))));
static volatile uint8_t CAN_motorcontroller_SDO_response_status = 0;
#define CAN_motorcontroller_SDO_response_ID 0x581

static CAN_message_S CAN_motorcontroller_SDO_response={
	.canID = CAN_motorcontroller_SDO_response_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = &CAN_motorcontroller_SDO_response_payload,
	.canMessageStatus = &CAN_motorcontroller_SDO_response_status
};

#define CAN_MOTORCONTROLLER_SDO_RESPONSE_SIZE_RANGE 1
#define CAN_MOTORCONTROLLER_SDO_RESPONSE_SIZE_OFFSET 0
#define CAN_MOTORCONTROLLER_SDO_RESPONSE_EXPIDITED_XFER_RANGE 1
#define CAN_MOTORCONTROLLER_SDO_RESPONSE_EXPIDITED_XFER_OFFSET 1
#define CAN_MOTORCONTROLLER_SDO_RESPONSE_N_BYTES_RANGE 2
#define CAN_MOTORCONTROLLER_SDO_RESPONSE_N_BYTES_OFFSET 2
#define CAN_MOTORCONTROLLER_SDO_RESPONSE_RESERVED_RANGE 1
#define CAN_MOTORCONTROLLER_SDO_RESPONSE_RESERVED_OFFSET 4
#define CAN_MOTORCONTROLLER_SDO_RESPONSE_CCS_RANGE 3
#define CAN_MOTORCONTROLLER_SDO_RESPONSE_CCS_OFFSET 5
#define CAN_MOTORCONTROLLER_SDO_RESPONSE_INDEX_RANGE 16
#define CAN_MOTORCONTROLLER_SDO_RESPONSE_INDEX_OFFSET 8
#define CAN_MOTORCONTROLLER_SDO_RESPONSE_SUBINDEX_RANGE 8
#define CAN_MOTORCONTROLLER_SDO_RESPONSE_SUBINDEX_OFFSET 24
#define CAN_MOTORCONTROLLER_SDO_RESPONSE_BYTE_4_RANGE 8
#define CAN_MOTORCONTROLLER_SDO_RESPONSE_BYTE_4_OFFSET 32
#define CAN_MOTORCONTROLLER_SDO_RESPONSE_BYTE_5_RANGE 8
#define CAN_MOTORCONTROLLER_SDO_RESPONSE_BYTE_5_OFFSET 40
#define CAN_MOTORCONTROLLER_SDO_RESPONSE_BYTE_6_RANGE 8
#define CAN_MOTORCONTROLLER_SDO_RESPONSE_BYTE_6_OFFSET 48
#define CAN_MOTORCONTROLLER_SDO_RESPONSE_BYTE_7_RANGE 8
#define CAN_MOTORCONTROLLER_SDO_RESPONSE_BYTE_7_OFFSET 56

void CAN_motorcontroller_SDO_response_size_set(uint16_t size){
	uint16_t data_scaled = size * 1.0;
	// Set 1-bit signal at bit offset 0
	CAN_motorcontroller_SDO_response.payload->word0 &= ~0x0001;
	CAN_motorcontroller_SDO_response.payload->word0 |= data_scaled & 0x0001;
}
void CAN_motorcontroller_SDO_response_expidited_xfer_set(uint16_t expidited_xfer){
	uint16_t data_scaled = expidited_xfer * 1.0;
	// Set 1-bit signal at bit offset 1
	CAN_motorcontroller_SDO_response.payload->word0 &= ~0x0002;
	CAN_motorcontroller_SDO_response.payload->word0 |= (data_scaled << 1) & 0x0002;
}
void CAN_motorcontroller_SDO_response_n_bytes_set(uint16_t n_bytes){
	uint16_t data_scaled = n_bytes * 1.0;
	// Set 2-bit signal at bit offset 2
	CAN_motorcontroller_SDO_response.payload->word0 &= ~0x000C;
	CAN_motorcontroller_SDO_response.payload->word0 |= (data_scaled << 2) & 0x000C;
}
void CAN_motorcontroller_SDO_response_reserved_set(uint16_t reserved){
	uint16_t data_scaled = reserved * 1.0;
	// Set 1-bit signal at bit offset 4
	CAN_motorcontroller_SDO_response.payload->word0 &= ~0x0010;
	CAN_motorcontroller_SDO_response.payload->word0 |= (data_scaled << 4) & 0x0010;
}
void CAN_motorcontroller_SDO_response_ccs_set(uint16_t ccs){
	uint16_t data_scaled = ccs * 1.0;
	// Set 3-bit signal at bit offset 5
	CAN_motorcontroller_SDO_response.payload->word0 &= ~0x00E0;
	CAN_motorcontroller_SDO_response.payload->word0 |= (data_scaled << 5) & 0x00E0;
}
void CAN_motorcontroller_SDO_response_index_set(uint16_t index){
	uint16_t data_scaled = index * 1.0;
	// Set 16-bit signal at bit offset 8
	CAN_motorcontroller_SDO_response.payload->word0 &= ~0xFF00;
	CAN_motorcontroller_SDO_response.payload->word0 |= (data_scaled << 8) & 0xFF00;
	CAN_motorcontroller_SDO_response.payload->word1 &= ~0x00FF;
	CAN_motorcontroller_SDO_response.payload->word1 |= (data_scaled >> 8) & 0x00FF;
}
void CAN_motorcontroller_SDO_response_subindex_set(uint16_t subindex){
	uint16_t data_scaled = subindex * 1.0;
	// Set 8-bit signal at bit offset 24
	CAN_motorcontroller_SDO_response.payload->word1 &= ~0xFF00;
	CAN_motorcontroller_SDO_response.payload->word1 |= (data_scaled << 8) & 0xFF00;
}
void CAN_motorcontroller_SDO_response_byte_4_set(uint16_t byte_4){
	uint16_t data_scaled = byte_4 * 1.0;
	// Set 8-bit signal at bit offset 32
	CAN_motorcontroller_SDO_response.payload->word2 &= ~0x00FF;
	CAN_motorcontroller_SDO_response.payload->word2 |= data_scaled & 0x00FF;
}
void CAN_motorcontroller_SDO_response_byte_5_set(uint16_t byte_5){
	uint16_t data_scaled = byte_5 * 1.0;
	// Set 8-bit signal at bit offset 40
	CAN_motorcontroller_SDO_response.payload->word2 &= ~0xFF00;
	CAN_motorcontroller_SDO_response.payload->word2 |= (data_scaled << 8) & 0xFF00;
}
void CAN_motorcontroller_SDO_response_byte_6_set(uint16_t byte_6){
	uint16_t data_scaled = byte_6 * 1.0;
	// Set 8-bit signal at bit offset 48
	CAN_motorcontroller_SDO_response.payload->word3 &= ~0x00FF;
	CAN_motorcontroller_SDO_response.payload->word3 |= data_scaled & 0x00FF;
}
void CAN_motorcontroller_SDO_response_byte_7_set(uint16_t byte_7){
	uint16_t data_scaled = byte_7 * 1.0;
	// Set 8-bit signal at bit offset 56
	CAN_motorcontroller_SDO_response.payload->word3 &= ~0xFF00;
	CAN_motorcontroller_SDO_response.payload->word3 |= (data_scaled << 8) & 0xFF00;
}
void CAN_motorcontroller_SDO_response_dlc_set(uint8_t dlc){
	CAN_motorcontroller_SDO_response.dlc = dlc;
}
void CAN_motorcontroller_SDO_response_send(void){
	// Update message status for self-consumption
	*CAN_motorcontroller_SDO_response.canMessageStatus = 1;
	CAN_write(&CAN_motorcontroller_SDO_response);
}

static CAN_payload_S CAN_motorcontroller_Emergency_payload __attribute__((aligned(sizeof(CAN_payload_S))));
static volatile uint8_t CAN_motorcontroller_Emergency_status = 0;
#define CAN_motorcontroller_Emergency_ID 0x81

static CAN_message_S CAN_motorcontroller_Emergency={
	.canID = CAN_motorcontroller_Emergency_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = &CAN_motorcontroller_Emergency_payload,
	.canMessageStatus = &CAN_motorcontroller_Emergency_status
};

#define CAN_MOTORCONTROLLER_EMERGENCY_EMCY_RANGE 16
#define CAN_MOTORCONTROLLER_EMERGENCY_EMCY_OFFSET 0

void CAN_motorcontroller_Emergency_EMCY_set(uint16_t EMCY){
	uint16_t data_scaled = EMCY * 1.0;
	// Set 16-bit signal at bit offset 0
	CAN_motorcontroller_Emergency.payload->word0 &= ~0xFFFF;
	CAN_motorcontroller_Emergency.payload->word0 |= data_scaled & 0xFFFF;
}
void CAN_motorcontroller_Emergency_dlc_set(uint8_t dlc){
	CAN_motorcontroller_Emergency.dlc = dlc;
}
void CAN_motorcontroller_Emergency_send(void){
	// Update message status for self-consumption
	*CAN_motorcontroller_Emergency.canMessageStatus = 1;
	CAN_write(&CAN_motorcontroller_Emergency);
}

static CAN_payload_S CAN_motorcontroller_motorStatus_PDO1_payload __attribute__((aligned(sizeof(CAN_payload_S))));
static volatile uint8_t CAN_motorcontroller_motorStatus_PDO1_status = 0;
#define CAN_motorcontroller_motorStatus_PDO1_ID 0x391

static CAN_message_S CAN_motorcontroller_motorStatus_PDO1={
	.canID = CAN_motorcontroller_motorStatus_PDO1_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = &CAN_motorcontroller_motorStatus_PDO1_payload,
	.canMessageStatus = &CAN_motorcontroller_motorStatus_PDO1_status
};

#define CAN_MOTORCONTROLLER_MOTORSTATUS_PDO1_BATTERY_VOLTAGE_RANGE 16
#define CAN_MOTORCONTROLLER_MOTORSTATUS_PDO1_BATTERY_VOLTAGE_OFFSET 0
#define CAN_MOTORCONTROLLER_MOTORSTATUS_PDO1_BATTERY_CURRENT_RANGE 16
#define CAN_MOTORCONTROLLER_MOTORSTATUS_PDO1_BATTERY_CURRENT_OFFSET 16
#define CAN_MOTORCONTROLLER_MOTORSTATUS_PDO1_CAPACITOR_VOLTAGE_RANGE 16
#define CAN_MOTORCONTROLLER_MOTORSTATUS_PDO1_CAPACITOR_VOLTAGE_OFFSET 32
#define CAN_MOTORCONTROLLER_MOTORSTATUS_PDO1_HEATSINK_TEMPERATURE_RANGE 16
#define CAN_MOTORCONTROLLER_MOTORSTATUS_PDO1_HEATSINK_TEMPERATURE_OFFSET 48

void CAN_motorcontroller_motorStatus_PDO1_Battery_Voltage_set(float Battery_Voltage){
	uint16_t data_scaled = (uint16_t)(Battery_Voltage * 16.0f + 0.5f);
	// Set 16-bit signal at bit offset 0
	CAN_motorcontroller_motorStatus_PDO1.payload->word0 &= ~0xFFFF;
	CAN_motorcontroller_motorStatus_PDO1.payload->word0 |= data_scaled & 0xFFFF;
}
void CAN_motorcontroller_motorStatus_PDO1_Battery_Current_set(float Battery_Current){
	uint16_t data_scaled = (uint16_t)(Battery_Current * 16.0f + 0.5f);
	// Set 16-bit signal at bit offset 16
	CAN_motorcontroller_motorStatus_PDO1.payload->word1 &= ~0xFFFF;
	CAN_motorcontroller_motorStatus_PDO1.payload->word1 |= data_scaled & 0xFFFF;
}
void CAN_motorcontroller_motorStatus_PDO1_Capacitor_Voltage_set(float Capacitor_Voltage){
	uint16_t data_scaled = (uint16_t)(Capacitor_Voltage * 16.0f + 0.5f);
	// Set 16-bit signal at bit offset 32
	CAN_motorcontroller_motorStatus_PDO1.payload->word2 &= ~0xFFFF;
	CAN_motorcontroller_motorStatus_PDO1.payload->word2 |= data_scaled & 0xFFFF;
}
void CAN_motorcontroller_motorStatus_PDO1_Heatsink_Temperature_set(float Heatsink_Temperature){
	uint16_t data_scaled = (uint16_t)(Heatsink_Temperature * 1.0f + 0.5f);
	// Set 16-bit signal at bit offset 48
	CAN_motorcontroller_motorStatus_PDO1.payload->word3 &= ~0xFFFF;
	CAN_motorcontroller_motorStatus_PDO1.payload->word3 |= data_scaled & 0xFFFF;
}
void CAN_motorcontroller_motorStatus_PDO1_dlc_set(uint8_t dlc){
	CAN_motorcontroller_motorStatus_PDO1.dlc = dlc;
}
void CAN_motorcontroller_motorStatus_PDO1_send(void){
	// Update message status for self-consumption
	*CAN_motorcontroller_motorStatus_PDO1.canMessageStatus = 1;
	CAN_write(&CAN_motorcontroller_motorStatus_PDO1);
}

static CAN_payload_S CAN_motorcontroller_motorStatus_PDO2_payload __attribute__((aligned(sizeof(CAN_payload_S))));
static volatile uint8_t CAN_motorcontroller_motorStatus_PDO2_status = 0;
#define CAN_motorcontroller_motorStatus_PDO2_ID 0x330

static CAN_message_S CAN_motorcontroller_motorStatus_PDO2={
	.canID = CAN_motorcontroller_motorStatus_PDO2_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = &CAN_motorcontroller_motorStatus_PDO2_payload,
	.canMessageStatus = &CAN_motorcontroller_motorStatus_PDO2_status
};

#define CAN_MOTORCONTROLLER_MOTORSTATUS_PDO2_THROTTLE_INPUT_VOLTAGE_RANGE 16
#define CAN_MOTORCONTROLLER_MOTORSTATUS_PDO2_THROTTLE_INPUT_VOLTAGE_OFFSET 0
#define CAN_MOTORCONTROLLER_MOTORSTATUS_PDO2_THROTTLE_VALUE_RANGE 16
#define CAN_MOTORCONTROLLER_MOTORSTATUS_PDO2_THROTTLE_VALUE_OFFSET 16

void CAN_motorcontroller_motorStatus_PDO2_Throttle_Input_Voltage_set(float Throttle_Input_Voltage){
	uint16_t data_scaled = (uint16_t)(Throttle_Input_Voltage * 256.4102564102564f + 0.5f);
	// Set 16-bit signal at bit offset 0
	CAN_motorcontroller_motorStatus_PDO2.payload->word0 &= ~0xFFFF;
	CAN_motorcontroller_motorStatus_PDO2.payload->word0 |= data_scaled & 0xFFFF;
}
void CAN_motorcontroller_motorStatus_PDO2_Throttle_Value_set(float Throttle_Value){
	uint16_t data_scaled = (uint16_t)(Throttle_Value * 327.86885245901635f + 0.5f);
	// Set 16-bit signal at bit offset 16
	CAN_motorcontroller_motorStatus_PDO2.payload->word1 &= ~0xFFFF;
	CAN_motorcontroller_motorStatus_PDO2.payload->word1 |= data_scaled & 0xFFFF;
}
void CAN_motorcontroller_motorStatus_PDO2_dlc_set(uint8_t dlc){
	CAN_motorcontroller_motorStatus_PDO2.dlc = dlc;
}
void CAN_motorcontroller_motorStatus_PDO2_send(void){
	// Update message status for self-consumption
	*CAN_motorcontroller_motorStatus_PDO2.canMessageStatus = 1;
	CAN_write(&CAN_motorcontroller_motorStatus_PDO2);
}

static CAN_payload_S CAN_motorcontroller_motor_status_PDO4_payload __attribute__((aligned(sizeof(CAN_payload_S))));
static volatile uint8_t CAN_motorcontroller_motor_status_PDO4_status = 0;
#define CAN_motorcontroller_motor_status_PDO4_ID 0x271

static CAN_message_S CAN_motorcontroller_motor_status_PDO4={
	.canID = CAN_motorcontroller_motor_status_PDO4_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = &CAN_motorcontroller_motor_status_PDO4_payload,
	.canMessageStatus = &CAN_motorcontroller_motor_status_PDO4_status
};

#define CAN_MOTORCONTROLLER_MOTOR_STATUS_PDO4_CAPACITOR_VOLTAGE_RANGE 16
#define CAN_MOTORCONTROLLER_MOTOR_STATUS_PDO4_CAPACITOR_VOLTAGE_OFFSET 0
#define CAN_MOTORCONTROLLER_MOTOR_STATUS_PDO4_HEATSINK_TEMPERATURE_RANGE 8
#define CAN_MOTORCONTROLLER_MOTOR_STATUS_PDO4_HEATSINK_TEMPERATURE_OFFSET 16
#define CAN_MOTORCONTROLLER_MOTOR_STATUS_PDO4_BATTERY_CURRENT_RANGE 16
#define CAN_MOTORCONTROLLER_MOTOR_STATUS_PDO4_BATTERY_CURRENT_OFFSET 24
#define CAN_MOTORCONTROLLER_MOTOR_STATUS_PDO4_MAX_TORQUE_LEFT_MOTOR_RANGE 16
#define CAN_MOTORCONTROLLER_MOTOR_STATUS_PDO4_MAX_TORQUE_LEFT_MOTOR_OFFSET 40

void CAN_motorcontroller_motor_status_PDO4_Capacitor_Voltage_set(float Capacitor_Voltage){
	uint16_t data_scaled = (uint16_t)(Capacitor_Voltage * 16.0f + 0.5f);
	// Set 16-bit signal at bit offset 0
	CAN_motorcontroller_motor_status_PDO4.payload->word0 &= ~0xFFFF;
	CAN_motorcontroller_motor_status_PDO4.payload->word0 |= data_scaled & 0xFFFF;
}
void CAN_motorcontroller_motor_status_PDO4_Heatsink_Temperature_set(float Heatsink_Temperature){
	uint16_t data_scaled = (uint16_t)(Heatsink_Temperature * 1.0f + 0.5f);
	// Set 8-bit signal at bit offset 16
	CAN_motorcontroller_motor_status_PDO4.payload->word1 &= ~0x00FF;
	CAN_motorcontroller_motor_status_PDO4.payload->word1 |= data_scaled & 0x00FF;
}
void CAN_motorcontroller_motor_status_PDO4_Battery_Current_set(float Battery_Current){
	uint16_t data_scaled = (uint16_t)(Battery_Current * 16.0f + 0.5f);
	// Set 16-bit signal at bit offset 24
	CAN_motorcontroller_motor_status_PDO4.payload->word1 &= ~0xFF00;
	CAN_motorcontroller_motor_status_PDO4.payload->word1 |= (data_scaled << 8) & 0xFF00;
	CAN_motorcontroller_motor_status_PDO4.payload->word2 &= ~0x00FF;
	CAN_motorcontroller_motor_status_PDO4.payload->word2 |= (data_scaled >> 8) & 0x00FF;
}
void CAN_motorcontroller_motor_status_PDO4_Max_Torque_Left_Motor_set(uint16_t Max_Torque_Left_Motor){
	uint16_t data_scaled = Max_Torque_Left_Motor * 1000.0;
	// Set 16-bit signal at bit offset 40
	CAN_motorcontroller_motor_status_PDO4.payload->word2 &= ~0xFF00;
	CAN_motorcontroller_motor_status_PDO4.payload->word2 |= (data_scaled << 8) & 0xFF00;
	CAN_motorcontroller_motor_status_PDO4.payload->word3 &= ~0x00FF;
	CAN_motorcontroller_motor_status_PDO4.payload->word3 |= (data_scaled >> 8) & 0x00FF;
}
void CAN_motorcontroller_motor_status_PDO4_dlc_set(uint8_t dlc){
	CAN_motorcontroller_motor_status_PDO4.dlc = dlc;
}
void CAN_motorcontroller_motor_status_PDO4_send(void){
	// Update message status for self-consumption
	*CAN_motorcontroller_motor_status_PDO4.canMessageStatus = 1;
	CAN_write(&CAN_motorcontroller_motor_status_PDO4);
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
	CAN_configureMailbox(&CAN_mcu_mcu_debug);
	CAN_configureMailbox(&CAN_bms_debug);
	CAN_configureMailbox(&CAN_bms_SDO_request);
}

void CAN_send_1ms(void){
	CAN_motorcontroller_SYNC_send();
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

void CAN_send_30ms(void){
	CAN_motorcontroller_heartbeat_send();
	CAN_motorcontroller_Emergency_send();
}

void CAN_send_20ms(void){
	CAN_motorcontroller_motorStatus_PDO1_send();
	CAN_motorcontroller_motorStatus_PDO2_send();
	CAN_motorcontroller_motor_status_PDO4_send();
}
