#include "bms_dbc.h"
#include "CAN.h"
#include "utils.h"
/**********************************************************
 * dash NODE MESSAGES
 */
/**********************************************************
 * mcu NODE MESSAGES
 */
static CAN_payload_S CAN_mcu_status_payloads[5] __attribute__((aligned(sizeof(CAN_payload_S))));
static uint8_t CAN_mcu_status_mux = 0;
#define CAN_mcu_status_ID 0x711

static CAN_message_S CAN_mcu_status={
	.canID = CAN_mcu_status_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
};

#define CAN_MCU_STATUS_MULTIPLEX_RANGE 3
#define CAN_MCU_STATUS_MULTIPLEX_OFFSET 0
#define CAN_MCU_STATUS_M0_VEHICLESTATE_RANGE 3
#define CAN_MCU_STATUS_M0_VEHICLESTATE_OFFSET 3
#define CAN_MCU_STATUS_M0_HIGHBEAM_RANGE 1
#define CAN_MCU_STATUS_M0_HIGHBEAM_OFFSET 6
#define CAN_MCU_STATUS_M0_LOWBEAM_RANGE 1
#define CAN_MCU_STATUS_M0_LOWBEAM_OFFSET 7
#define CAN_MCU_STATUS_M0_BRAKELIGHT_RANGE 1
#define CAN_MCU_STATUS_M0_BRAKELIGHT_OFFSET 8
#define CAN_MCU_STATUS_M0_TAILLIGHT_RANGE 1
#define CAN_MCU_STATUS_M0_TAILLIGHT_OFFSET 9
#define CAN_MCU_STATUS_M0_HORN_RANGE 1
#define CAN_MCU_STATUS_M0_HORN_OFFSET 10
#define CAN_MCU_STATUS_M0_TURNSIGNALFR_RANGE 1
#define CAN_MCU_STATUS_M0_TURNSIGNALFR_OFFSET 11
#define CAN_MCU_STATUS_M0_TURNSIGNALFL_RANGE 1
#define CAN_MCU_STATUS_M0_TURNSIGNALFL_OFFSET 12
#define CAN_MCU_STATUS_M0_TURNSIGNALRR_RANGE 1
#define CAN_MCU_STATUS_M0_TURNSIGNALRR_OFFSET 13
#define CAN_MCU_STATUS_M0_TURNSIGNALRL_RANGE 1
#define CAN_MCU_STATUS_M0_TURNSIGNALRL_OFFSET 14
#define CAN_MCU_STATUS_M0_BRAKESWITCHFRONT_RANGE 1
#define CAN_MCU_STATUS_M0_BRAKESWITCHFRONT_OFFSET 15
#define CAN_MCU_STATUS_M0_BRAKESWITCHREAR_RANGE 1
#define CAN_MCU_STATUS_M0_BRAKESWITCHREAR_OFFSET 16
#define CAN_MCU_STATUS_M0_KILLSWITCH_RANGE 1
#define CAN_MCU_STATUS_M0_KILLSWITCH_OFFSET 17
#define CAN_MCU_STATUS_M0_IGNITIONSWITCH_RANGE 1
#define CAN_MCU_STATUS_M0_IGNITIONSWITCH_OFFSET 18
#define CAN_MCU_STATUS_M0_LEFTTURNSWITCH_RANGE 1
#define CAN_MCU_STATUS_M0_LEFTTURNSWITCH_OFFSET 19
#define CAN_MCU_STATUS_M0_RIGHTTURNSWITCH_RANGE 1
#define CAN_MCU_STATUS_M0_RIGHTTURNSWITCH_OFFSET 20
#define CAN_MCU_STATUS_M0_LIGHTSWITCH_RANGE 1
#define CAN_MCU_STATUS_M0_LIGHTSWITCH_OFFSET 21
#define CAN_MCU_STATUS_M0_ASSSWITCH_RANGE 1
#define CAN_MCU_STATUS_M0_ASSSWITCH_OFFSET 22
#define CAN_MCU_STATUS_M0_HORNSWITCH_RANGE 1
#define CAN_MCU_STATUS_M0_HORNSWITCH_OFFSET 23
#define CAN_MCU_STATUS_M1_BATT_VOLTAGE_RANGE 8
#define CAN_MCU_STATUS_M1_BATT_VOLTAGE_OFFSET 3
#define CAN_MCU_STATUS_M1_BATT_CURRENT_RANGE 16
#define CAN_MCU_STATUS_M1_BATT_CURRENT_OFFSET 11
#define CAN_MCU_STATUS_M1_DCDC_CURRENT_RANGE 16
#define CAN_MCU_STATUS_M1_DCDC_CURRENT_OFFSET 27
#define CAN_MCU_STATUS_M1_BATT_FAULT_RANGE 1
#define CAN_MCU_STATUS_M1_BATT_FAULT_OFFSET 43
#define CAN_MCU_STATUS_M1_DCDC_FAULT_RANGE 1
#define CAN_MCU_STATUS_M1_DCDC_FAULT_OFFSET 44
#define CAN_MCU_STATUS_M1_FAN_FAULT_RANGE 1
#define CAN_MCU_STATUS_M1_FAN_FAULT_OFFSET 45
#define CAN_MCU_STATUS_M1_PUMP_FAULT_RANGE 1
#define CAN_MCU_STATUS_M1_PUMP_FAULT_OFFSET 46
#define CAN_MCU_STATUS_M1_TAILLIGHT_FAULT_RANGE 1
#define CAN_MCU_STATUS_M1_TAILLIGHT_FAULT_OFFSET 47
#define CAN_MCU_STATUS_M1_BRAKELIGHT_FAULT_RANGE 1
#define CAN_MCU_STATUS_M1_BRAKELIGHT_FAULT_OFFSET 48
#define CAN_MCU_STATUS_M1_LOWBEAM_FAULT_RANGE 1
#define CAN_MCU_STATUS_M1_LOWBEAM_FAULT_OFFSET 49
#define CAN_MCU_STATUS_M1_HIGHBEAM_FAULT_RANGE 1
#define CAN_MCU_STATUS_M1_HIGHBEAM_FAULT_OFFSET 50
#define CAN_MCU_STATUS_M1_HORN_FAULT_RANGE 1
#define CAN_MCU_STATUS_M1_HORN_FAULT_OFFSET 51
#define CAN_MCU_STATUS_M1_AUX_PORT_FAULT_RANGE 1
#define CAN_MCU_STATUS_M1_AUX_PORT_FAULT_OFFSET 52
#define CAN_MCU_STATUS_M1_HEATED_GRIPS_FAULT_RANGE 1
#define CAN_MCU_STATUS_M1_HEATED_GRIPS_FAULT_OFFSET 53
#define CAN_MCU_STATUS_M1_HEATED_SEAT_FAULT_RANGE 1
#define CAN_MCU_STATUS_M1_HEATED_SEAT_FAULT_OFFSET 54
#define CAN_MCU_STATUS_M1_CHARGE_CONTROLLER_FAULT_RANGE 1
#define CAN_MCU_STATUS_M1_CHARGE_CONTROLLER_FAULT_OFFSET 55
#define CAN_MCU_STATUS_M1_MOTOR_CONTROLLER_FAULT_RANGE 1
#define CAN_MCU_STATUS_M1_MOTOR_CONTROLLER_FAULT_OFFSET 56
#define CAN_MCU_STATUS_M1_BMS_CONTROLLER_FAULT_RANGE 1
#define CAN_MCU_STATUS_M1_BMS_CONTROLLER_FAULT_OFFSET 57
#define CAN_MCU_STATUS_M1_J1772_CONTROLLER_FAULT_RANGE 1
#define CAN_MCU_STATUS_M1_J1772_CONTROLLER_FAULT_OFFSET 58
#define CAN_MCU_STATUS_M1_IC_CONTROLLER_FAULT_RANGE 1
#define CAN_MCU_STATUS_M1_IC_CONTROLLER_FAULT_OFFSET 59
#define CAN_MCU_STATUS_M2_FAN_CURRENT_RANGE 12
#define CAN_MCU_STATUS_M2_FAN_CURRENT_OFFSET 3
#define CAN_MCU_STATUS_M2_PUMP_CURRENT_RANGE 12
#define CAN_MCU_STATUS_M2_PUMP_CURRENT_OFFSET 15
#define CAN_MCU_STATUS_M2_TAILLIGHT_CURRENT_RANGE 12
#define CAN_MCU_STATUS_M2_TAILLIGHT_CURRENT_OFFSET 27
#define CAN_MCU_STATUS_M2_BRAKELIGHT_CURRENT_RANGE 12
#define CAN_MCU_STATUS_M2_BRAKELIGHT_CURRENT_OFFSET 39
#define CAN_MCU_STATUS_M2_LOWBEAM_CURRENT_RANGE 12
#define CAN_MCU_STATUS_M2_LOWBEAM_CURRENT_OFFSET 51
#define CAN_MCU_STATUS_M3_HIGHBEAM_CURRENT_RANGE 12
#define CAN_MCU_STATUS_M3_HIGHBEAM_CURRENT_OFFSET 3
#define CAN_MCU_STATUS_M3_HORN_CURRENT_RANGE 12
#define CAN_MCU_STATUS_M3_HORN_CURRENT_OFFSET 15
#define CAN_MCU_STATUS_M3_AUX_PORT_CURRENT_RANGE 12
#define CAN_MCU_STATUS_M3_AUX_PORT_CURRENT_OFFSET 27
#define CAN_MCU_STATUS_M3_HEATED_GRIPS_CURRENT_RANGE 12
#define CAN_MCU_STATUS_M3_HEATED_GRIPS_CURRENT_OFFSET 39
#define CAN_MCU_STATUS_M3_HEATED_SEAT_CURRENT_RANGE 12
#define CAN_MCU_STATUS_M3_HEATED_SEAT_CURRENT_OFFSET 51
#define CAN_MCU_STATUS_M4_CHARGE_CONTROLLER_CURRENT_RANGE 12
#define CAN_MCU_STATUS_M4_CHARGE_CONTROLLER_CURRENT_OFFSET 3
#define CAN_MCU_STATUS_M4_MOTOR_CONTROLLER_CURRENT_RANGE 12
#define CAN_MCU_STATUS_M4_MOTOR_CONTROLLER_CURRENT_OFFSET 15
#define CAN_MCU_STATUS_M4_BMS_CONTROLLER_CURRENT_RANGE 12
#define CAN_MCU_STATUS_M4_BMS_CONTROLLER_CURRENT_OFFSET 27
#define CAN_MCU_STATUS_M4_J1772_CONTROLLER_CURRENT_RANGE 12
#define CAN_MCU_STATUS_M4_J1772_CONTROLLER_CURRENT_OFFSET 39

uint8_t CAN_mcu_status_checkDataIsUnread(void){
	return CAN_checkDataIsUnread(&CAN_mcu_status);
}
uint8_t CAN_mcu_status_checkDataIsStale(void){
	return CAN_checkDataIsStale(&CAN_mcu_status, 20);
}
uint16_t CAN_mcu_status_multiplex_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 3-bit signal at bit offset 0
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status.payload->word0 & 0x0007) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_vehicleState_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 3-bit signal at bit offset 3
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[0].word0 & 0x0038) >> 3) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_highBeam_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 6
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[0].word0 & 0x0040) >> 6) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_lowBeam_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 7
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[0].word0 & 0x0080) >> 7) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_brakeLight_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 8
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[0].word0 & 0x0100) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_tailLight_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 9
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[0].word0 & 0x0200) >> 9) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_horn_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 10
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[0].word0 & 0x0400) >> 10) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_turnSignalFR_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 11
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[0].word0 & 0x0800) >> 11) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_turnSignalFL_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 12
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[0].word0 & 0x1000) >> 12) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_turnSignalRR_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 13
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[0].word0 & 0x2000) >> 13) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_turnSignalRL_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 14
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[0].word0 & 0x4000) >> 14) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_brakeSwitchFront_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 15
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[0].word0 & 0x8000) >> 15) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_brakeSwitchRear_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 16
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[0].word1 & 0x0001) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_killSwitch_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 17
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[0].word1 & 0x0002) >> 1) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_ignitionSwitch_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 18
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[0].word1 & 0x0004) >> 2) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_leftTurnSwitch_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 19
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[0].word1 & 0x0008) >> 3) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_rightTurnSwitch_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 20
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[0].word1 & 0x0010) >> 4) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_lightSwitch_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 21
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[0].word1 & 0x0020) >> 5) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_assSwitch_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 22
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[0].word1 & 0x0040) >> 6) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_hornSwitch_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 23
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[0].word1 & 0x0080) >> 7) << 0;
	return (data * 1.0) + 0;
}
float CAN_mcu_status_batt_voltage_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 8-bit signal at bit offset 3
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[1].word0 & 0x07F8) >> 3) << 0;
	return (data * 0.1) + 0;
}
float CAN_mcu_status_batt_current_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 16-bit signal at bit offset 11
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[1].word0 & 0xF800) >> 11) << 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[1].word1 & 0x07FF) >> 0) << 5;
	return (data * 0.001) + -33;
}
float CAN_mcu_status_dcdc_current_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 16-bit signal at bit offset 27
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[1].word1 & 0xF800) >> 11) << 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[1].word2 & 0x07FF) >> 0) << 5;
	return (data * 0.001) + -33;
}
uint16_t CAN_mcu_status_batt_fault_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 43
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[1].word2 & 0x0800) >> 11) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_dcdc_fault_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 44
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[1].word2 & 0x1000) >> 12) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_fan_fault_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 45
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[1].word2 & 0x2000) >> 13) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_pump_fault_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 46
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[1].word2 & 0x4000) >> 14) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_taillight_fault_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 47
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[1].word2 & 0x8000) >> 15) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_brakelight_fault_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 48
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[1].word3 & 0x0001) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_lowbeam_fault_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 49
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[1].word3 & 0x0002) >> 1) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_highbeam_fault_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 50
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[1].word3 & 0x0004) >> 2) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_horn_fault_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 51
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[1].word3 & 0x0008) >> 3) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_aux_port_fault_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 52
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[1].word3 & 0x0010) >> 4) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_heated_grips_fault_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 53
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[1].word3 & 0x0020) >> 5) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_heated_seat_fault_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 54
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[1].word3 & 0x0040) >> 6) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_charge_controller_fault_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 55
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[1].word3 & 0x0080) >> 7) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_motor_controller_fault_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 56
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[1].word3 & 0x0100) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_bms_controller_fault_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 57
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[1].word3 & 0x0200) >> 9) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_J1772_controller_fault_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 58
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[1].word3 & 0x0400) >> 10) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_ic_controller_fault_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 59
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[1].word3 & 0x0800) >> 11) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_fan_current_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 3
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[2].word0 & 0x7FF8) >> 3) << 0;
	return (data * 1) + 0;
}
uint16_t CAN_mcu_status_pump_current_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 15
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[2].word0 & 0x8000) >> 15) << 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[2].word1 & 0x07FF) >> 0) << 1;
	return (data * 1) + 0;
}
uint16_t CAN_mcu_status_taillight_current_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 27
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[2].word1 & 0xF800) >> 11) << 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[2].word2 & 0x007F) >> 0) << 5;
	return (data * 1) + 0;
}
uint16_t CAN_mcu_status_brakelight_current_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 39
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[2].word2 & 0xFF80) >> 7) << 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[2].word3 & 0x0007) >> 0) << 9;
	return (data * 1) + 0;
}
uint16_t CAN_mcu_status_lowbeam_current_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 51
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[2].word3 & 0x7FF8) >> 3) << 0;
	return (data * 1) + 0;
}
uint16_t CAN_mcu_status_highbeam_current_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 3
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[3].word0 & 0x7FF8) >> 3) << 0;
	return (data * 1) + 0;
}
uint16_t CAN_mcu_status_horn_current_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 15
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[3].word0 & 0x8000) >> 15) << 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[3].word1 & 0x07FF) >> 0) << 1;
	return (data * 1) + 0;
}
uint16_t CAN_mcu_status_aux_port_current_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 27
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[3].word1 & 0xF800) >> 11) << 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[3].word2 & 0x007F) >> 0) << 5;
	return (data * 1) + 0;
}
uint16_t CAN_mcu_status_heated_grips_current_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 39
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[3].word2 & 0xFF80) >> 7) << 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[3].word3 & 0x0007) >> 0) << 9;
	return (data * 1) + 0;
}
uint16_t CAN_mcu_status_heated_seat_current_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 51
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[3].word3 & 0x7FF8) >> 3) << 0;
	return (data * 1) + 0;
}
uint16_t CAN_mcu_status_charge_controller_current_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 3
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[4].word0 & 0x7FF8) >> 3) << 0;
	return (data * 1) + 0;
}
uint16_t CAN_mcu_status_motor_controller_current_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 15
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[4].word0 & 0x8000) >> 15) << 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[4].word1 & 0x07FF) >> 0) << 1;
	return (data * 1) + 0;
}
uint16_t CAN_mcu_status_bms_controller_current_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 27
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[4].word1 & 0xF800) >> 11) << 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[4].word2 & 0x007F) >> 0) << 5;
	return (data * 1) + 0;
}
uint16_t CAN_mcu_status_J1772_controller_current_get(void){
	// Check for unread data and update payload arrays if needed
	if (*CAN_mcu_status.canMessageStatus) {
		// Unread data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_MULTIPLEX_OFFSET, CAN_MCU_STATUS_MULTIPLEX_RANGE);
		// Copy unread payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_status_payloads[mux_value] = *CAN_mcu_status.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 39
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[4].word2 & 0xFF80) >> 7) << 0;
	data |= (uint16_t)((CAN_mcu_status_payloads[4].word3 & 0x0007) >> 0) << 9;
	return (data * 1) + 0;
}

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
#define CAN_MCU_MCU_DEBUG_M0_DEBUG_VALUE_3_RANGE 8
#define CAN_MCU_MCU_DEBUG_M0_DEBUG_VALUE_3_OFFSET 2
#define CAN_MCU_MCU_DEBUG_M0_DEBUG_VALUE_4_RANGE 8
#define CAN_MCU_MCU_DEBUG_M0_DEBUG_VALUE_4_OFFSET 10
#define CAN_MCU_MCU_DEBUG_M1_DEBUG_VALUE_5_RANGE 8
#define CAN_MCU_MCU_DEBUG_M1_DEBUG_VALUE_5_OFFSET 2
#define CAN_MCU_MCU_DEBUG_M1_DEBUG_VALUE_6_RANGE 8
#define CAN_MCU_MCU_DEBUG_M1_DEBUG_VALUE_6_OFFSET 10
#define CAN_MCU_MCU_DEBUG_M1_DEBUG_VALUE_7_RANGE 8
#define CAN_MCU_MCU_DEBUG_M1_DEBUG_VALUE_7_OFFSET 18
#define CAN_MCU_MCU_DEBUG_M1_DEBUG_VALUE_8_RANGE 8
#define CAN_MCU_MCU_DEBUG_M1_DEBUG_VALUE_8_OFFSET 26
#define CAN_MCU_MCU_DEBUG_M1_TASK_1MS_CPU_PERCENT_RANGE 8
#define CAN_MCU_MCU_DEBUG_M1_TASK_1MS_CPU_PERCENT_OFFSET 34
#define CAN_MCU_MCU_DEBUG_M1_TASK_10MS_CPU_PERCENT_RANGE 8
#define CAN_MCU_MCU_DEBUG_M1_TASK_10MS_CPU_PERCENT_OFFSET 42
#define CAN_MCU_MCU_DEBUG_M0_TASK_100MS_CPU_PERCENT_RANGE 8
#define CAN_MCU_MCU_DEBUG_M0_TASK_100MS_CPU_PERCENT_OFFSET 18
#define CAN_MCU_MCU_DEBUG_M0_TASK_1000MS_CPU_PERCENT_RANGE 8
#define CAN_MCU_MCU_DEBUG_M0_TASK_1000MS_CPU_PERCENT_OFFSET 26
#define CAN_MCU_MCU_DEBUG_M2_DEBUG_VALUE_9_RANGE 8
#define CAN_MCU_MCU_DEBUG_M2_DEBUG_VALUE_9_OFFSET 18
#define CAN_MCU_MCU_DEBUG_M2_DEBUG_VALUE_10_RANGE 8
#define CAN_MCU_MCU_DEBUG_M2_DEBUG_VALUE_10_OFFSET 26
#define CAN_MCU_MCU_DEBUG_M3_DEBUG_VALUE_13_RANGE 8
#define CAN_MCU_MCU_DEBUG_M3_DEBUG_VALUE_13_OFFSET 2
#define CAN_MCU_MCU_DEBUG_M3_DEBUG_VALUE_14_RANGE 8
#define CAN_MCU_MCU_DEBUG_M3_DEBUG_VALUE_14_OFFSET 10
#define CAN_MCU_MCU_DEBUG_M3_TASK_1MS_PEAK_CPU_PERCENT_RANGE 8
#define CAN_MCU_MCU_DEBUG_M3_TASK_1MS_PEAK_CPU_PERCENT_OFFSET 18
#define CAN_MCU_MCU_DEBUG_M3_TASK_10MS_PEAK_CPU_PERCENT_RANGE 8
#define CAN_MCU_MCU_DEBUG_M3_TASK_10MS_PEAK_CPU_PERCENT_OFFSET 26
#define CAN_MCU_MCU_DEBUG_M2_TASK_100MS_PEAK_CPU_PERCENT_RANGE 8
#define CAN_MCU_MCU_DEBUG_M2_TASK_100MS_PEAK_CPU_PERCENT_OFFSET 34
#define CAN_MCU_MCU_DEBUG_M2_TASK_1000MS_PEAK_CPU_PERCENT_RANGE 8
#define CAN_MCU_MCU_DEBUG_M2_TASK_1000MS_PEAK_CPU_PERCENT_OFFSET 42

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
uint16_t CAN_mcu_mcu_debug_debug_value_3_get(void){
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
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[0].word0 & 0x03FC) >> 2) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_mcu_debug_debug_value_4_get(void){
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
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[0].word0 & 0xFC00) >> 10) << 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[0].word1 & 0x0003) >> 0) << 6;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_mcu_debug_debug_value_5_get(void){
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
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[1].word0 & 0x03FC) >> 2) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_mcu_debug_debug_value_6_get(void){
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
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[1].word0 & 0xFC00) >> 10) << 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[1].word1 & 0x0003) >> 0) << 6;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_mcu_debug_debug_value_7_get(void){
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
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[1].word1 & 0x03FC) >> 2) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_mcu_debug_debug_value_8_get(void){
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
	
	// Extract 8-bit signal at bit offset 34
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[1].word2 & 0x03FC) >> 2) << 0;
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
	
	// Extract 8-bit signal at bit offset 42
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[1].word2 & 0xFC00) >> 10) << 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[1].word3 & 0x0003) >> 0) << 6;
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
uint16_t CAN_mcu_mcu_debug_debug_value_9_get(void){
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
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[2].word1 & 0x03FC) >> 2) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_mcu_debug_debug_value_10_get(void){
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
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[2].word1 & 0xFC00) >> 10) << 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[2].word2 & 0x0003) >> 0) << 6;
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_mcu_debug_debug_value_13_get(void){
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
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_mcu_debug_debug_value_14_get(void){
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
	
	// Extract 8-bit signal at bit offset 18
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[3].word1 & 0x03FC) >> 2) << 0;
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
	
	// Extract 8-bit signal at bit offset 26
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[3].word1 & 0xFC00) >> 10) << 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[3].word2 & 0x0003) >> 0) << 6;
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
	
	// Extract 8-bit signal at bit offset 34
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[2].word2 & 0x03FC) >> 2) << 0;
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
	
	// Extract 8-bit signal at bit offset 42
	uint16_t data = 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[2].word2 & 0xFC00) >> 10) << 0;
	data |= (uint16_t)((CAN_mcu_mcu_debug_payloads[2].word3 & 0x0003) >> 0) << 6;
	return (data * 1) + 0;
}

/**********************************************************
 * bms NODE MESSAGES
 */
static CAN_payload_S CAN_bms_status_payloads[5] __attribute__((aligned(sizeof(CAN_payload_S))));
static uint8_t CAN_bms_status_mux = 0;
static volatile uint8_t CAN_bms_status_status = 0;
#define CAN_bms_status_ID 0x721

static CAN_message_S CAN_bms_status={
	.canID = CAN_bms_status_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = &CAN_bms_status_status
};

#define CAN_BMS_STATUS_MULTIPLEX_RANGE 3
#define CAN_BMS_STATUS_MULTIPLEX_OFFSET 0
#define CAN_BMS_STATUS_M0_BMS_STATE_RANGE 4
#define CAN_BMS_STATUS_M0_BMS_STATE_OFFSET 3
#define CAN_BMS_STATUS_M0_PACK_VOLTAGE_RANGE 16
#define CAN_BMS_STATUS_M0_PACK_VOLTAGE_OFFSET 7
#define CAN_BMS_STATUS_M0_PACK_CURRENT_RANGE 16
#define CAN_BMS_STATUS_M0_PACK_CURRENT_OFFSET 23
#define CAN_BMS_STATUS_M0_SOC_PERCENT_RANGE 8
#define CAN_BMS_STATUS_M0_SOC_PERCENT_OFFSET 39
#define CAN_BMS_STATUS_M0_PACK_TEMP_MIN_RANGE 8
#define CAN_BMS_STATUS_M0_PACK_TEMP_MIN_OFFSET 47
#define CAN_BMS_STATUS_M0_PACK_TEMP_MAX_RANGE 8
#define CAN_BMS_STATUS_M0_PACK_TEMP_MAX_OFFSET 55
#define CAN_BMS_STATUS_M1_STACK_VOLTAGE_1_RANGE 16
#define CAN_BMS_STATUS_M1_STACK_VOLTAGE_1_OFFSET 3
#define CAN_BMS_STATUS_M1_STACK_VOLTAGE_2_RANGE 16
#define CAN_BMS_STATUS_M1_STACK_VOLTAGE_2_OFFSET 19
#define CAN_BMS_STATUS_M1_PACK_VOLTAGE_SUM_OF_STACKS_RANGE 18
#define CAN_BMS_STATUS_M1_PACK_VOLTAGE_SUM_OF_STACKS_OFFSET 35
#define CAN_BMS_STATUS_M2_LTC_STATE_RANGE 4
#define CAN_BMS_STATUS_M2_LTC_STATE_OFFSET 3
#define CAN_BMS_STATUS_M2_LTC_ERROR_COUNT_RANGE 12
#define CAN_BMS_STATUS_M2_LTC_ERROR_COUNT_OFFSET 7
#define CAN_BMS_STATUS_M2_LTC_LAST_ERROR_RANGE 8
#define CAN_BMS_STATUS_M2_LTC_LAST_ERROR_OFFSET 19
#define CAN_BMS_STATUS_M2_CPU_USAGE_PERCENT_RANGE 8
#define CAN_BMS_STATUS_M2_CPU_USAGE_PERCENT_OFFSET 27
#define CAN_BMS_STATUS_M2_CPU_PEAK_PERCENT_RANGE 8
#define CAN_BMS_STATUS_M2_CPU_PEAK_PERCENT_OFFSET 35
#define CAN_BMS_STATUS_M2_VBUS_VOLTAGE_RANGE 10
#define CAN_BMS_STATUS_M2_VBUS_VOLTAGE_OFFSET 43
#define CAN_BMS_STATUS_M2_INTERNAL_TEMP_RANGE 8
#define CAN_BMS_STATUS_M2_INTERNAL_TEMP_OFFSET 53
#define CAN_BMS_STATUS_M3_MAX_CHARGE_CURRENT_MA_RANGE 16
#define CAN_BMS_STATUS_M3_MAX_CHARGE_CURRENT_MA_OFFSET 3
#define CAN_BMS_STATUS_M3_MAX_CHARGE_VOLTAGE_MV_RANGE 18
#define CAN_BMS_STATUS_M3_MAX_CHARGE_VOLTAGE_MV_OFFSET 19
#define CAN_BMS_STATUS_M3_CONTACTORS_CLOSED_RANGE 1
#define CAN_BMS_STATUS_M3_CONTACTORS_CLOSED_OFFSET 37
#define CAN_BMS_STATUS_M3_PRECHARGE_ACTIVE_RANGE 1
#define CAN_BMS_STATUS_M3_PRECHARGE_ACTIVE_OFFSET 38
#define CAN_BMS_STATUS_M3_CHARGE_ENABLED_RANGE 1
#define CAN_BMS_STATUS_M3_CHARGE_ENABLED_OFFSET 39
#define CAN_BMS_STATUS_M3_DISCHARGE_ENABLED_RANGE 1
#define CAN_BMS_STATUS_M3_DISCHARGE_ENABLED_OFFSET 40
#define CAN_BMS_STATUS_M3_FAULT_SUMMARY_RANGE 12
#define CAN_BMS_STATUS_M3_FAULT_SUMMARY_OFFSET 41
#define CAN_BMS_STATUS_M3_IS_BALANCING_RANGE 1
#define CAN_BMS_STATUS_M3_IS_BALANCING_OFFSET 53
#define CAN_BMS_STATUS_M3_CELL_A_BALANCING_RANGE 5
#define CAN_BMS_STATUS_M3_CELL_A_BALANCING_OFFSET 54
#define CAN_BMS_STATUS_M4_CELL_B_BALANCING_RANGE 5
#define CAN_BMS_STATUS_M4_CELL_B_BALANCING_OFFSET 3
#define CAN_BMS_STATUS_M4_CELL_C_BALANCING_RANGE 5
#define CAN_BMS_STATUS_M4_CELL_C_BALANCING_OFFSET 8
#define CAN_BMS_STATUS_M4_CELL_D_BALANCING_RANGE 5
#define CAN_BMS_STATUS_M4_CELL_D_BALANCING_OFFSET 13
#define CAN_BMS_STATUS_M4_CELL_E_BALANCING_RANGE 5
#define CAN_BMS_STATUS_M4_CELL_E_BALANCING_OFFSET 18

void CAN_bms_status_bms_state_set(uint16_t bms_state){
	uint16_t data_scaled = bms_state * 1.0;
	// Set 4-bit signal at bit offset 3
	CAN_bms_status_payloads[0].word0 &= ~0x0078;
	CAN_bms_status_payloads[0].word0 |= (data_scaled << 3) & 0x0078;
}
void CAN_bms_status_pack_voltage_set(float pack_voltage){
	uint16_t data_scaled = (uint16_t)(pack_voltage * 100.0f + 0.5f);
	// Set 16-bit signal at bit offset 7
	CAN_bms_status_payloads[0].word0 &= ~0xFF80;
	CAN_bms_status_payloads[0].word0 |= (data_scaled << 7) & 0xFF80;
	CAN_bms_status_payloads[0].word1 &= ~0x007F;
	CAN_bms_status_payloads[0].word1 |= (data_scaled >> 9) & 0x007F;
}
void CAN_bms_status_pack_current_set(float pack_current){
	uint16_t data_scaled = (uint16_t)((pack_current - -320) * 100.0f + 0.5f);
	// Set 16-bit signal at bit offset 23
	CAN_bms_status_payloads[0].word1 &= ~0xFF80;
	CAN_bms_status_payloads[0].word1 |= (data_scaled << 7) & 0xFF80;
	CAN_bms_status_payloads[0].word2 &= ~0x007F;
	CAN_bms_status_payloads[0].word2 |= (data_scaled >> 9) & 0x007F;
}
void CAN_bms_status_soc_percent_set(float soc_percent){
	uint16_t data_scaled = (uint16_t)(soc_percent * 2.0f + 0.5f);
	// Set 8-bit signal at bit offset 39
	CAN_bms_status_payloads[0].word2 &= ~0x7F80;
	CAN_bms_status_payloads[0].word2 |= (data_scaled << 7) & 0x7F80;
}
void CAN_bms_status_pack_temp_min_set(float pack_temp_min){
	uint16_t data_scaled = (uint16_t)((pack_temp_min - -40) * 1.0f + 0.5f);
	// Set 8-bit signal at bit offset 47
	CAN_bms_status_payloads[0].word2 &= ~0x8000;
	CAN_bms_status_payloads[0].word2 |= (data_scaled << 15) & 0x8000;
	CAN_bms_status_payloads[0].word3 &= ~0x007F;
	CAN_bms_status_payloads[0].word3 |= (data_scaled >> 1) & 0x007F;
}
void CAN_bms_status_pack_temp_max_set(float pack_temp_max){
	uint16_t data_scaled = (uint16_t)((pack_temp_max - -40) * 1.0f + 0.5f);
	// Set 8-bit signal at bit offset 55
	CAN_bms_status_payloads[0].word3 &= ~0x7F80;
	CAN_bms_status_payloads[0].word3 |= (data_scaled << 7) & 0x7F80;
}
void CAN_bms_status_stack_voltage_1_set(float stack_voltage_1){
	uint16_t data_scaled = (uint16_t)(stack_voltage_1 * 1000.0f + 0.5f);
	// Set 16-bit signal at bit offset 3
	CAN_bms_status_payloads[1].word0 &= ~0xFFF8;
	CAN_bms_status_payloads[1].word0 |= (data_scaled << 3) & 0xFFF8;
	CAN_bms_status_payloads[1].word1 &= ~0x0007;
	CAN_bms_status_payloads[1].word1 |= (data_scaled >> 13) & 0x0007;
}
void CAN_bms_status_stack_voltage_2_set(float stack_voltage_2){
	uint16_t data_scaled = (uint16_t)(stack_voltage_2 * 1000.0f + 0.5f);
	// Set 16-bit signal at bit offset 19
	CAN_bms_status_payloads[1].word1 &= ~0xFFF8;
	CAN_bms_status_payloads[1].word1 |= (data_scaled << 3) & 0xFFF8;
	CAN_bms_status_payloads[1].word2 &= ~0x0007;
	CAN_bms_status_payloads[1].word2 |= (data_scaled >> 13) & 0x0007;
}
void CAN_bms_status_pack_voltage_sum_of_stacks_set(float pack_voltage_sum_of_stacks){
	uint32_t data_scaled = (uint32_t)(pack_voltage_sum_of_stacks * 1000.0f + 0.5f);
	// Set 18-bit signal at bit offset 35
	CAN_bms_status_payloads[1].word2 &= ~0xFFF8;
	CAN_bms_status_payloads[1].word2 |= (data_scaled << 3) & 0xFFF8;
	CAN_bms_status_payloads[1].word3 &= ~0x001F;
	CAN_bms_status_payloads[1].word3 |= (data_scaled >> 13) & 0x001F;
}
void CAN_bms_status_ltc_state_set(uint16_t ltc_state){
	uint16_t data_scaled = ltc_state * 1.0;
	// Set 4-bit signal at bit offset 3
	CAN_bms_status_payloads[2].word0 &= ~0x0078;
	CAN_bms_status_payloads[2].word0 |= (data_scaled << 3) & 0x0078;
}
void CAN_bms_status_ltc_error_count_set(uint16_t ltc_error_count){
	uint16_t data_scaled = ltc_error_count * 1.0;
	// Set 12-bit signal at bit offset 7
	CAN_bms_status_payloads[2].word0 &= ~0xFF80;
	CAN_bms_status_payloads[2].word0 |= (data_scaled << 7) & 0xFF80;
	CAN_bms_status_payloads[2].word1 &= ~0x0007;
	CAN_bms_status_payloads[2].word1 |= (data_scaled >> 9) & 0x0007;
}
void CAN_bms_status_ltc_last_error_set(uint16_t ltc_last_error){
	uint16_t data_scaled = ltc_last_error * 1.0;
	// Set 8-bit signal at bit offset 19
	CAN_bms_status_payloads[2].word1 &= ~0x07F8;
	CAN_bms_status_payloads[2].word1 |= (data_scaled << 3) & 0x07F8;
}
void CAN_bms_status_cpu_usage_percent_set(float cpu_usage_percent){
	uint16_t data_scaled = (uint16_t)(cpu_usage_percent * 2.0f + 0.5f);
	// Set 8-bit signal at bit offset 27
	CAN_bms_status_payloads[2].word1 &= ~0xF800;
	CAN_bms_status_payloads[2].word1 |= (data_scaled << 11) & 0xF800;
	CAN_bms_status_payloads[2].word2 &= ~0x0007;
	CAN_bms_status_payloads[2].word2 |= (data_scaled >> 5) & 0x0007;
}
void CAN_bms_status_cpu_peak_percent_set(float cpu_peak_percent){
	uint16_t data_scaled = (uint16_t)(cpu_peak_percent * 2.0f + 0.5f);
	// Set 8-bit signal at bit offset 35
	CAN_bms_status_payloads[2].word2 &= ~0x07F8;
	CAN_bms_status_payloads[2].word2 |= (data_scaled << 3) & 0x07F8;
}
void CAN_bms_status_vbus_voltage_set(float vbus_voltage){
	uint16_t data_scaled = (uint16_t)(vbus_voltage * 10.0f + 0.5f);
	// Set 10-bit signal at bit offset 43
	CAN_bms_status_payloads[2].word2 &= ~0xF800;
	CAN_bms_status_payloads[2].word2 |= (data_scaled << 11) & 0xF800;
	CAN_bms_status_payloads[2].word3 &= ~0x001F;
	CAN_bms_status_payloads[2].word3 |= (data_scaled >> 5) & 0x001F;
}
void CAN_bms_status_internal_temp_set(float internal_temp){
	uint16_t data_scaled = (uint16_t)((internal_temp - -40) * 1.0f + 0.5f);
	// Set 8-bit signal at bit offset 53
	CAN_bms_status_payloads[2].word3 &= ~0x1FE0;
	CAN_bms_status_payloads[2].word3 |= (data_scaled << 5) & 0x1FE0;
}
void CAN_bms_status_max_charge_current_mA_set(uint16_t max_charge_current_mA){
	uint16_t data_scaled = max_charge_current_mA * 1.0;
	// Set 16-bit signal at bit offset 3
	CAN_bms_status_payloads[3].word0 &= ~0xFFF8;
	CAN_bms_status_payloads[3].word0 |= (data_scaled << 3) & 0xFFF8;
	CAN_bms_status_payloads[3].word1 &= ~0x0007;
	CAN_bms_status_payloads[3].word1 |= (data_scaled >> 13) & 0x0007;
}
void CAN_bms_status_max_charge_voltage_mV_set(uint32_t max_charge_voltage_mV){
	uint32_t data_scaled = max_charge_voltage_mV * 1.0;
	// Set 18-bit signal at bit offset 19
	CAN_bms_status_payloads[3].word1 &= ~0xFFF8;
	CAN_bms_status_payloads[3].word1 |= (data_scaled << 3) & 0xFFF8;
	CAN_bms_status_payloads[3].word2 &= ~0x001F;
	CAN_bms_status_payloads[3].word2 |= (data_scaled >> 13) & 0x001F;
}
void CAN_bms_status_contactors_closed_set(uint16_t contactors_closed){
	uint16_t data_scaled = contactors_closed * 1.0;
	// Set 1-bit signal at bit offset 37
	CAN_bms_status_payloads[3].word2 &= ~0x0020;
	CAN_bms_status_payloads[3].word2 |= (data_scaled << 5) & 0x0020;
}
void CAN_bms_status_precharge_active_set(uint16_t precharge_active){
	uint16_t data_scaled = precharge_active * 1.0;
	// Set 1-bit signal at bit offset 38
	CAN_bms_status_payloads[3].word2 &= ~0x0040;
	CAN_bms_status_payloads[3].word2 |= (data_scaled << 6) & 0x0040;
}
void CAN_bms_status_charge_enabled_set(uint16_t charge_enabled){
	uint16_t data_scaled = charge_enabled * 1.0;
	// Set 1-bit signal at bit offset 39
	CAN_bms_status_payloads[3].word2 &= ~0x0080;
	CAN_bms_status_payloads[3].word2 |= (data_scaled << 7) & 0x0080;
}
void CAN_bms_status_discharge_enabled_set(uint16_t discharge_enabled){
	uint16_t data_scaled = discharge_enabled * 1.0;
	// Set 1-bit signal at bit offset 40
	CAN_bms_status_payloads[3].word2 &= ~0x0100;
	CAN_bms_status_payloads[3].word2 |= (data_scaled << 8) & 0x0100;
}
void CAN_bms_status_fault_summary_set(uint16_t fault_summary){
	uint16_t data_scaled = fault_summary * 1.0;
	// Set 12-bit signal at bit offset 41
	CAN_bms_status_payloads[3].word2 &= ~0xFE00;
	CAN_bms_status_payloads[3].word2 |= (data_scaled << 9) & 0xFE00;
	CAN_bms_status_payloads[3].word3 &= ~0x001F;
	CAN_bms_status_payloads[3].word3 |= (data_scaled >> 7) & 0x001F;
}
void CAN_bms_status_is_balancing_set(uint16_t is_balancing){
	uint16_t data_scaled = is_balancing * 1.0;
	// Set 1-bit signal at bit offset 53
	CAN_bms_status_payloads[3].word3 &= ~0x0020;
	CAN_bms_status_payloads[3].word3 |= (data_scaled << 5) & 0x0020;
}
void CAN_bms_status_cell_A_balancing_set(uint16_t cell_A_balancing){
	uint16_t data_scaled = cell_A_balancing * 1.0;
	// Set 5-bit signal at bit offset 54
	CAN_bms_status_payloads[3].word3 &= ~0x07C0;
	CAN_bms_status_payloads[3].word3 |= (data_scaled << 6) & 0x07C0;
}
void CAN_bms_status_cell_B_balancing_set(uint16_t cell_B_balancing){
	uint16_t data_scaled = cell_B_balancing * 1.0;
	// Set 5-bit signal at bit offset 3
	CAN_bms_status_payloads[4].word0 &= ~0x00F8;
	CAN_bms_status_payloads[4].word0 |= (data_scaled << 3) & 0x00F8;
}
void CAN_bms_status_cell_C_balancing_set(uint16_t cell_C_balancing){
	uint16_t data_scaled = cell_C_balancing * 1.0;
	// Set 5-bit signal at bit offset 8
	CAN_bms_status_payloads[4].word0 &= ~0x1F00;
	CAN_bms_status_payloads[4].word0 |= (data_scaled << 8) & 0x1F00;
}
void CAN_bms_status_cell_D_balancing_set(uint16_t cell_D_balancing){
	uint16_t data_scaled = cell_D_balancing * 1.0;
	// Set 5-bit signal at bit offset 13
	CAN_bms_status_payloads[4].word0 &= ~0xE000;
	CAN_bms_status_payloads[4].word0 |= (data_scaled << 13) & 0xE000;
	CAN_bms_status_payloads[4].word1 &= ~0x0003;
	CAN_bms_status_payloads[4].word1 |= (data_scaled >> 3) & 0x0003;
}
void CAN_bms_status_cell_E_balancing_set(uint16_t cell_E_balancing){
	uint16_t data_scaled = cell_E_balancing * 1.0;
	// Set 5-bit signal at bit offset 18
	CAN_bms_status_payloads[4].word1 &= ~0x007C;
	CAN_bms_status_payloads[4].word1 |= (data_scaled << 2) & 0x007C;
}
uint8_t CAN_bms_status_checkDataIsUnread(void){
	return CAN_checkDataIsUnread(&CAN_bms_status);
}
uint8_t CAN_bms_status_checkDataIsStale(void){
	return CAN_checkDataIsStale(&CAN_bms_status, 20);
}
uint16_t CAN_bms_status_multiplex_get(void){
	// Extract 3-bit signal at bit offset 0
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status.payload->word0 & 0x0007) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_bms_state_get(void){
	// Extract 4-bit signal at bit offset 3
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[0].word0 & 0x0078) >> 3) << 0;
	return (data * 1.0) + 0;
}
float CAN_bms_status_pack_voltage_get(void){
	// Extract 16-bit signal at bit offset 7
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[0].word0 & 0xFF80) >> 7) << 0;
	data |= (uint16_t)((CAN_bms_status_payloads[0].word1 & 0x007F) >> 0) << 9;
	return (data * 0.01) + 0;
}
float CAN_bms_status_pack_current_get(void){
	// Extract 16-bit signal at bit offset 23
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[0].word1 & 0xFF80) >> 7) << 0;
	data |= (uint16_t)((CAN_bms_status_payloads[0].word2 & 0x007F) >> 0) << 9;
	return (data * 0.01) + -320;
}
float CAN_bms_status_soc_percent_get(void){
	// Extract 8-bit signal at bit offset 39
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[0].word2 & 0x7F80) >> 7) << 0;
	return (data * 0.5) + 0;
}
float CAN_bms_status_pack_temp_min_get(void){
	// Extract 8-bit signal at bit offset 47
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[0].word2 & 0x8000) >> 15) << 0;
	data |= (uint16_t)((CAN_bms_status_payloads[0].word3 & 0x007F) >> 0) << 1;
	return (data * 1.0) + -40;
}
float CAN_bms_status_pack_temp_max_get(void){
	// Extract 8-bit signal at bit offset 55
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[0].word3 & 0x7F80) >> 7) << 0;
	return (data * 1.0) + -40;
}
float CAN_bms_status_stack_voltage_1_get(void){
	// Extract 16-bit signal at bit offset 3
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[1].word0 & 0xFFF8) >> 3) << 0;
	data |= (uint16_t)((CAN_bms_status_payloads[1].word1 & 0x0007) >> 0) << 13;
	return (data * 0.001) + 0;
}
float CAN_bms_status_stack_voltage_2_get(void){
	// Extract 16-bit signal at bit offset 19
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[1].word1 & 0xFFF8) >> 3) << 0;
	data |= (uint16_t)((CAN_bms_status_payloads[1].word2 & 0x0007) >> 0) << 13;
	return (data * 0.001) + 0;
}
float CAN_bms_status_pack_voltage_sum_of_stacks_get(void){
	// Extract 18-bit signal at bit offset 35
	uint32_t data = 0;
	data |= (uint32_t)((CAN_bms_status_payloads[1].word2 & 0xFFF8) >> 3) << 0;
	data |= (uint32_t)((CAN_bms_status_payloads[1].word3 & 0x001F) >> 0) << 13;
	return (data * 0.001) + 0;
}
uint16_t CAN_bms_status_ltc_state_get(void){
	// Extract 4-bit signal at bit offset 3
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[2].word0 & 0x0078) >> 3) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_ltc_error_count_get(void){
	// Extract 12-bit signal at bit offset 7
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[2].word0 & 0xFF80) >> 7) << 0;
	data |= (uint16_t)((CAN_bms_status_payloads[2].word1 & 0x0007) >> 0) << 9;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_ltc_last_error_get(void){
	// Extract 8-bit signal at bit offset 19
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[2].word1 & 0x07F8) >> 3) << 0;
	return (data * 1.0) + 0;
}
float CAN_bms_status_cpu_usage_percent_get(void){
	// Extract 8-bit signal at bit offset 27
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[2].word1 & 0xF800) >> 11) << 0;
	data |= (uint16_t)((CAN_bms_status_payloads[2].word2 & 0x0007) >> 0) << 5;
	return (data * 0.5) + 0;
}
float CAN_bms_status_cpu_peak_percent_get(void){
	// Extract 8-bit signal at bit offset 35
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[2].word2 & 0x07F8) >> 3) << 0;
	return (data * 0.5) + 0;
}
float CAN_bms_status_vbus_voltage_get(void){
	// Extract 10-bit signal at bit offset 43
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[2].word2 & 0xF800) >> 11) << 0;
	data |= (uint16_t)((CAN_bms_status_payloads[2].word3 & 0x001F) >> 0) << 5;
	return (data * 0.1) + 0;
}
float CAN_bms_status_internal_temp_get(void){
	// Extract 8-bit signal at bit offset 53
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[2].word3 & 0x1FE0) >> 5) << 0;
	return (data * 1.0) + -40;
}
uint16_t CAN_bms_status_max_charge_current_mA_get(void){
	// Extract 16-bit signal at bit offset 3
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[3].word0 & 0xFFF8) >> 3) << 0;
	data |= (uint16_t)((CAN_bms_status_payloads[3].word1 & 0x0007) >> 0) << 13;
	return (data * 1.0) + 0;
}
uint32_t CAN_bms_status_max_charge_voltage_mV_get(void){
	// Extract 18-bit signal at bit offset 19
	uint32_t data = 0;
	data |= (uint32_t)((CAN_bms_status_payloads[3].word1 & 0xFFF8) >> 3) << 0;
	data |= (uint32_t)((CAN_bms_status_payloads[3].word2 & 0x001F) >> 0) << 13;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_contactors_closed_get(void){
	// Extract 1-bit signal at bit offset 37
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[3].word2 & 0x0020) >> 5) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_precharge_active_get(void){
	// Extract 1-bit signal at bit offset 38
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[3].word2 & 0x0040) >> 6) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_charge_enabled_get(void){
	// Extract 1-bit signal at bit offset 39
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[3].word2 & 0x0080) >> 7) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_discharge_enabled_get(void){
	// Extract 1-bit signal at bit offset 40
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[3].word2 & 0x0100) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_fault_summary_get(void){
	// Extract 12-bit signal at bit offset 41
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[3].word2 & 0xFE00) >> 9) << 0;
	data |= (uint16_t)((CAN_bms_status_payloads[3].word3 & 0x001F) >> 0) << 7;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_is_balancing_get(void){
	// Extract 1-bit signal at bit offset 53
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[3].word3 & 0x0020) >> 5) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_cell_A_balancing_get(void){
	// Extract 5-bit signal at bit offset 54
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[3].word3 & 0x07C0) >> 6) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_cell_B_balancing_get(void){
	// Extract 5-bit signal at bit offset 3
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[4].word0 & 0x00F8) >> 3) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_cell_C_balancing_get(void){
	// Extract 5-bit signal at bit offset 8
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[4].word0 & 0x1F00) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_cell_D_balancing_get(void){
	// Extract 5-bit signal at bit offset 13
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[4].word0 & 0xE000) >> 13) << 0;
	data |= (uint16_t)((CAN_bms_status_payloads[4].word1 & 0x0003) >> 0) << 3;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_cell_E_balancing_get(void){
	// Extract 5-bit signal at bit offset 18
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[4].word1 & 0x007C) >> 2) << 0;
	return (data * 1.0) + 0;
}

void CAN_bms_status_dlc_set(uint8_t dlc){
	CAN_bms_status.dlc = dlc;
}
void CAN_bms_status_send(void){
	// Update message status for self-consumption
	*CAN_bms_status.canMessageStatus = 1;
	// Auto-select current mux payload
	CAN_bms_status.payload = &CAN_bms_status_payloads[CAN_bms_status_mux];
	// Send the message
	CAN_write(&CAN_bms_status);
	// Increment mux counter for next time
	CAN_bms_status_mux++;
	if (CAN_bms_status_mux >= CAN_BMS_STATUS_NUM_MUX_VALUES) {
		CAN_bms_status_mux = 0;
	}
}

static CAN_payload_S CAN_bms_power_systems_payload __attribute__((aligned(sizeof(CAN_payload_S))));
static volatile uint8_t CAN_bms_power_systems_status = 0;
#define CAN_bms_power_systems_ID 0x722

static CAN_message_S CAN_bms_power_systems={
	.canID = CAN_bms_power_systems_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = &CAN_bms_power_systems_payload,
	.canMessageStatus = &CAN_bms_power_systems_status
};

#define CAN_BMS_POWER_SYSTEMS_DCDC_STATE_RANGE 1
#define CAN_BMS_POWER_SYSTEMS_DCDC_STATE_OFFSET 0
#define CAN_BMS_POWER_SYSTEMS_DCDC_FAULT_RANGE 1
#define CAN_BMS_POWER_SYSTEMS_DCDC_FAULT_OFFSET 1
#define CAN_BMS_POWER_SYSTEMS_DCDC_VOLTAGE_RANGE 10
#define CAN_BMS_POWER_SYSTEMS_DCDC_VOLTAGE_OFFSET 2
#define CAN_BMS_POWER_SYSTEMS_DCDC_CURRENT_RANGE 10
#define CAN_BMS_POWER_SYSTEMS_DCDC_CURRENT_OFFSET 12
#define CAN_BMS_POWER_SYSTEMS_EV_CHARGER_STATE_RANGE 1
#define CAN_BMS_POWER_SYSTEMS_EV_CHARGER_STATE_OFFSET 22
#define CAN_BMS_POWER_SYSTEMS_EV_CHARGER_FAULT_RANGE 1
#define CAN_BMS_POWER_SYSTEMS_EV_CHARGER_FAULT_OFFSET 23
#define CAN_BMS_POWER_SYSTEMS_EV_CHARGER_VOLTAGE_RANGE 10
#define CAN_BMS_POWER_SYSTEMS_EV_CHARGER_VOLTAGE_OFFSET 24
#define CAN_BMS_POWER_SYSTEMS_EV_CHARGER_CURRENT_RANGE 10
#define CAN_BMS_POWER_SYSTEMS_EV_CHARGER_CURRENT_OFFSET 34
#define CAN_BMS_POWER_SYSTEMS_HV_PRECHARGE_STATE_RANGE 1
#define CAN_BMS_POWER_SYSTEMS_HV_PRECHARGE_STATE_OFFSET 44
#define CAN_BMS_POWER_SYSTEMS_HV_ISOLATION_VOLTAGE_RANGE 10
#define CAN_BMS_POWER_SYSTEMS_HV_ISOLATION_VOLTAGE_OFFSET 45
#define CAN_BMS_POWER_SYSTEMS_HV_CONTACTOR_STATE_RANGE 1
#define CAN_BMS_POWER_SYSTEMS_HV_CONTACTOR_STATE_OFFSET 55

void CAN_bms_power_systems_DCDC_state_set(uint16_t DCDC_state){
	uint16_t data_scaled = DCDC_state * 1.0;
	// Set 1-bit signal at bit offset 0
	CAN_bms_power_systems.payload->word0 &= ~0x0001;
	CAN_bms_power_systems.payload->word0 |= data_scaled & 0x0001;
}
void CAN_bms_power_systems_DCDC_fault_set(uint16_t DCDC_fault){
	uint16_t data_scaled = DCDC_fault * 1.0;
	// Set 1-bit signal at bit offset 1
	CAN_bms_power_systems.payload->word0 &= ~0x0002;
	CAN_bms_power_systems.payload->word0 |= (data_scaled << 1) & 0x0002;
}
void CAN_bms_power_systems_DCDC_voltage_set(float DCDC_voltage){
	uint16_t data_scaled = (uint16_t)(DCDC_voltage * 10.0f + 0.5f);
	// Set 10-bit signal at bit offset 2
	CAN_bms_power_systems.payload->word0 &= ~0x0FFC;
	CAN_bms_power_systems.payload->word0 |= (data_scaled << 2) & 0x0FFC;
}
void CAN_bms_power_systems_DCDC_current_set(float DCDC_current){
	uint16_t data_scaled = (uint16_t)(DCDC_current * 10.0f + 0.5f);
	// Set 10-bit signal at bit offset 12
	CAN_bms_power_systems.payload->word0 &= ~0xF000;
	CAN_bms_power_systems.payload->word0 |= (data_scaled << 12) & 0xF000;
	CAN_bms_power_systems.payload->word1 &= ~0x003F;
	CAN_bms_power_systems.payload->word1 |= (data_scaled >> 4) & 0x003F;
}
void CAN_bms_power_systems_EV_charger_state_set(uint16_t EV_charger_state){
	uint16_t data_scaled = EV_charger_state * 1.0;
	// Set 1-bit signal at bit offset 22
	CAN_bms_power_systems.payload->word1 &= ~0x0040;
	CAN_bms_power_systems.payload->word1 |= (data_scaled << 6) & 0x0040;
}
void CAN_bms_power_systems_EV_charger_fault_set(uint16_t EV_charger_fault){
	uint16_t data_scaled = EV_charger_fault * 1.0;
	// Set 1-bit signal at bit offset 23
	CAN_bms_power_systems.payload->word1 &= ~0x0080;
	CAN_bms_power_systems.payload->word1 |= (data_scaled << 7) & 0x0080;
}
void CAN_bms_power_systems_EV_charger_voltage_set(float EV_charger_voltage){
	uint16_t data_scaled = (uint16_t)(EV_charger_voltage * 10.0f + 0.5f);
	// Set 10-bit signal at bit offset 24
	CAN_bms_power_systems.payload->word1 &= ~0xFF00;
	CAN_bms_power_systems.payload->word1 |= (data_scaled << 8) & 0xFF00;
	CAN_bms_power_systems.payload->word2 &= ~0x0003;
	CAN_bms_power_systems.payload->word2 |= (data_scaled >> 8) & 0x0003;
}
void CAN_bms_power_systems_EV_charger_current_set(float EV_charger_current){
	uint16_t data_scaled = (uint16_t)((EV_charger_current - -50) * 10.0f + 0.5f);
	// Set 10-bit signal at bit offset 34
	CAN_bms_power_systems.payload->word2 &= ~0x0FFC;
	CAN_bms_power_systems.payload->word2 |= (data_scaled << 2) & 0x0FFC;
}
void CAN_bms_power_systems_HV_precharge_state_set(uint16_t HV_precharge_state){
	uint16_t data_scaled = HV_precharge_state * 1.0;
	// Set 1-bit signal at bit offset 44
	CAN_bms_power_systems.payload->word2 &= ~0x1000;
	CAN_bms_power_systems.payload->word2 |= (data_scaled << 12) & 0x1000;
}
void CAN_bms_power_systems_HV_isolation_voltage_set(float HV_isolation_voltage){
	uint16_t data_scaled = (uint16_t)(HV_isolation_voltage * 10.0f + 0.5f);
	// Set 10-bit signal at bit offset 45
	CAN_bms_power_systems.payload->word2 &= ~0xE000;
	CAN_bms_power_systems.payload->word2 |= (data_scaled << 13) & 0xE000;
	CAN_bms_power_systems.payload->word3 &= ~0x007F;
	CAN_bms_power_systems.payload->word3 |= (data_scaled >> 3) & 0x007F;
}
void CAN_bms_power_systems_HV_contactor_state_set(uint16_t HV_contactor_state){
	uint16_t data_scaled = HV_contactor_state * 1.0;
	// Set 1-bit signal at bit offset 55
	CAN_bms_power_systems.payload->word3 &= ~0x0080;
	CAN_bms_power_systems.payload->word3 |= (data_scaled << 7) & 0x0080;
}
void CAN_bms_power_systems_dlc_set(uint8_t dlc){
	CAN_bms_power_systems.dlc = dlc;
}
void CAN_bms_power_systems_send(void){
	// Update message status for self-consumption
	*CAN_bms_power_systems.canMessageStatus = 1;
	CAN_write(&CAN_bms_power_systems);
}

static CAN_payload_S CAN_bms_debug_payload __attribute__((aligned(sizeof(CAN_payload_S))));
static volatile uint8_t CAN_bms_debug_status = 0;
#define CAN_bms_debug_ID 0x723

static CAN_message_S CAN_bms_debug={
	.canID = CAN_bms_debug_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = &CAN_bms_debug_payload,
	.canMessageStatus = &CAN_bms_debug_status
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

void CAN_bms_debug_bool0_set(uint16_t bool0){
	uint16_t data_scaled = bool0 * 1.0;
	// Set 1-bit signal at bit offset 0
	CAN_bms_debug.payload->word0 &= ~0x0001;
	CAN_bms_debug.payload->word0 |= data_scaled & 0x0001;
}
void CAN_bms_debug_bool1_set(uint16_t bool1){
	uint16_t data_scaled = bool1 * 1.0;
	// Set 1-bit signal at bit offset 1
	CAN_bms_debug.payload->word0 &= ~0x0002;
	CAN_bms_debug.payload->word0 |= (data_scaled << 1) & 0x0002;
}
void CAN_bms_debug_float1_set(float float1){
	uint16_t data_scaled = (uint16_t)(float1 * 100.0f + 0.5f);
	// Set 16-bit signal at bit offset 2
	CAN_bms_debug.payload->word0 &= ~0xFFFC;
	CAN_bms_debug.payload->word0 |= (data_scaled << 2) & 0xFFFC;
	CAN_bms_debug.payload->word1 &= ~0x0003;
	CAN_bms_debug.payload->word1 |= (data_scaled >> 14) & 0x0003;
}
void CAN_bms_debug_float2_set(float float2){
	uint16_t data_scaled = (uint16_t)(float2 * 100.0f + 0.5f);
	// Set 16-bit signal at bit offset 18
	CAN_bms_debug.payload->word1 &= ~0xFFFC;
	CAN_bms_debug.payload->word1 |= (data_scaled << 2) & 0xFFFC;
	CAN_bms_debug.payload->word2 &= ~0x0003;
	CAN_bms_debug.payload->word2 |= (data_scaled >> 14) & 0x0003;
}
void CAN_bms_debug_word1_set(uint16_t word1){
	uint16_t data_scaled = word1 * 1.0;
	// Set 16-bit signal at bit offset 34
	CAN_bms_debug.payload->word2 &= ~0xFFFC;
	CAN_bms_debug.payload->word2 |= (data_scaled << 2) & 0xFFFC;
	CAN_bms_debug.payload->word3 &= ~0x0003;
	CAN_bms_debug.payload->word3 |= (data_scaled >> 14) & 0x0003;
}
void CAN_bms_debug_byte1_set(uint16_t byte1){
	uint16_t data_scaled = byte1 * 1.0;
	// Set 8-bit signal at bit offset 50
	CAN_bms_debug.payload->word3 &= ~0x03FC;
	CAN_bms_debug.payload->word3 |= (data_scaled << 2) & 0x03FC;
}
void CAN_bms_debug_dlc_set(uint8_t dlc){
	CAN_bms_debug.dlc = dlc;
}
void CAN_bms_debug_send(void){
	// Update message status for self-consumption
	*CAN_bms_debug.canMessageStatus = 1;
	CAN_write(&CAN_bms_debug);
}

static CAN_payload_S CAN_bms_boot_response_payload __attribute__((aligned(sizeof(CAN_payload_S))));
static volatile uint8_t CAN_bms_boot_response_status = 0;
#define CAN_bms_boot_response_ID 0xA2

static CAN_message_S CAN_bms_boot_response={
	.canID = CAN_bms_boot_response_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = &CAN_bms_boot_response_payload,
	.canMessageStatus = &CAN_bms_boot_response_status
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

void CAN_bms_boot_response_type_set(uint16_t type){
	uint16_t data_scaled = type * 1.0;
	// Set 4-bit signal at bit offset 0
	CAN_bms_boot_response.payload->word0 &= ~0x000F;
	CAN_bms_boot_response.payload->word0 |= data_scaled & 0x000F;
}
void CAN_bms_boot_response_code_set(uint16_t code){
	uint16_t data_scaled = code * 1.0;
	// Set 4-bit signal at bit offset 4
	CAN_bms_boot_response.payload->word0 &= ~0x00F0;
	CAN_bms_boot_response.payload->word0 |= (data_scaled << 4) & 0x00F0;
}
void CAN_bms_boot_response_byte1_set(uint16_t byte1){
	uint16_t data_scaled = byte1 * 1.0;
	// Set 8-bit signal at bit offset 8
	CAN_bms_boot_response.payload->word0 &= ~0xFF00;
	CAN_bms_boot_response.payload->word0 |= (data_scaled << 8) & 0xFF00;
}
void CAN_bms_boot_response_byte2_set(uint16_t byte2){
	uint16_t data_scaled = byte2 * 1.0;
	// Set 8-bit signal at bit offset 16
	CAN_bms_boot_response.payload->word1 &= ~0x00FF;
	CAN_bms_boot_response.payload->word1 |= data_scaled & 0x00FF;
}
void CAN_bms_boot_response_byte3_set(uint16_t byte3){
	uint16_t data_scaled = byte3 * 1.0;
	// Set 8-bit signal at bit offset 24
	CAN_bms_boot_response.payload->word1 &= ~0xFF00;
	CAN_bms_boot_response.payload->word1 |= (data_scaled << 8) & 0xFF00;
}
void CAN_bms_boot_response_byte4_set(uint16_t byte4){
	uint16_t data_scaled = byte4 * 1.0;
	// Set 8-bit signal at bit offset 32
	CAN_bms_boot_response.payload->word2 &= ~0x00FF;
	CAN_bms_boot_response.payload->word2 |= data_scaled & 0x00FF;
}
void CAN_bms_boot_response_byte5_set(uint16_t byte5){
	uint16_t data_scaled = byte5 * 1.0;
	// Set 8-bit signal at bit offset 40
	CAN_bms_boot_response.payload->word2 &= ~0xFF00;
	CAN_bms_boot_response.payload->word2 |= (data_scaled << 8) & 0xFF00;
}
void CAN_bms_boot_response_byte6_set(uint16_t byte6){
	uint16_t data_scaled = byte6 * 1.0;
	// Set 8-bit signal at bit offset 48
	CAN_bms_boot_response.payload->word3 &= ~0x00FF;
	CAN_bms_boot_response.payload->word3 |= data_scaled & 0x00FF;
}
void CAN_bms_boot_response_byte7_set(uint16_t byte7){
	uint16_t data_scaled = byte7 * 1.0;
	// Set 8-bit signal at bit offset 56
	CAN_bms_boot_response.payload->word3 &= ~0xFF00;
	CAN_bms_boot_response.payload->word3 |= (data_scaled << 8) & 0xFF00;
}
void CAN_bms_boot_response_dlc_set(uint8_t dlc){
	CAN_bms_boot_response.dlc = dlc;
}
void CAN_bms_boot_response_send(void){
	// Update message status for self-consumption
	*CAN_bms_boot_response.canMessageStatus = 1;
	CAN_write(&CAN_bms_boot_response);
}

static CAN_payload_S CAN_bms_charger_request_payload __attribute__((aligned(sizeof(CAN_payload_S))));
static volatile uint8_t CAN_bms_charger_request_status = 0;
#define CAN_bms_charger_request_ID 0x18005074

static CAN_message_S CAN_bms_charger_request={
	.canID = CAN_bms_charger_request_ID,
	.canXID = 1,
	.dlc = 8,
	.payload = &CAN_bms_charger_request_payload,
	.canMessageStatus = &CAN_bms_charger_request_status
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

void CAN_bms_charger_request_output_voltage_high_byte_set(uint16_t output_voltage_high_byte){
	uint16_t data_scaled = output_voltage_high_byte * 1.0;
	// Set 8-bit signal at bit offset 0
	CAN_bms_charger_request.payload->word0 &= ~0x00FF;
	CAN_bms_charger_request.payload->word0 |= data_scaled & 0x00FF;
}
void CAN_bms_charger_request_output_voltage_low_byte_set(uint16_t output_voltage_low_byte){
	uint16_t data_scaled = output_voltage_low_byte * 1.0;
	// Set 8-bit signal at bit offset 8
	CAN_bms_charger_request.payload->word0 &= ~0xFF00;
	CAN_bms_charger_request.payload->word0 |= (data_scaled << 8) & 0xFF00;
}
void CAN_bms_charger_request_output_current_high_byte_set(uint16_t output_current_high_byte){
	uint16_t data_scaled = output_current_high_byte * 1.0;
	// Set 8-bit signal at bit offset 16
	CAN_bms_charger_request.payload->word1 &= ~0x00FF;
	CAN_bms_charger_request.payload->word1 |= data_scaled & 0x00FF;
}
void CAN_bms_charger_request_output_current_low_byte_set(uint16_t output_current_low_byte){
	uint16_t data_scaled = output_current_low_byte * 1.0;
	// Set 8-bit signal at bit offset 24
	CAN_bms_charger_request.payload->word1 &= ~0xFF00;
	CAN_bms_charger_request.payload->word1 |= (data_scaled << 8) & 0xFF00;
}
void CAN_bms_charger_request_start_charge_not_request_set(uint16_t start_charge_not_request){
	uint16_t data_scaled = start_charge_not_request * 1.0;
	// Set 8-bit signal at bit offset 32
	CAN_bms_charger_request.payload->word2 &= ~0x00FF;
	CAN_bms_charger_request.payload->word2 |= data_scaled & 0x00FF;
}
void CAN_bms_charger_request_charge_mode_set(uint16_t charge_mode){
	uint16_t data_scaled = charge_mode * 1.0;
	// Set 8-bit signal at bit offset 40
	CAN_bms_charger_request.payload->word2 &= ~0xFF00;
	CAN_bms_charger_request.payload->word2 |= (data_scaled << 8) & 0xFF00;
}
void CAN_bms_charger_request_byte_7_set(uint16_t byte_7){
	uint16_t data_scaled = byte_7 * 1.0;
	// Set 8-bit signal at bit offset 48
	CAN_bms_charger_request.payload->word3 &= ~0x00FF;
	CAN_bms_charger_request.payload->word3 |= data_scaled & 0x00FF;
}
void CAN_bms_charger_request_byte_8_set(uint16_t byte_8){
	uint16_t data_scaled = byte_8 * 1.0;
	// Set 8-bit signal at bit offset 56
	CAN_bms_charger_request.payload->word3 &= ~0xFF00;
	CAN_bms_charger_request.payload->word3 |= (data_scaled << 8) & 0xFF00;
}
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

void CAN_bms_charger_request_dlc_set(uint8_t dlc){
	CAN_bms_charger_request.dlc = dlc;
}
void CAN_bms_charger_request_send(void){
	// Update message status for self-consumption
	*CAN_bms_charger_request.canMessageStatus = 1;
	CAN_write(&CAN_bms_charger_request);
}

static CAN_payload_S CAN_bms_cell_voltages_payloads[6] __attribute__((aligned(sizeof(CAN_payload_S))));
static uint8_t CAN_bms_cell_voltages_mux = 0;
static volatile uint8_t CAN_bms_cell_voltages_status = 0;
#define CAN_bms_cell_voltages_ID 0x725

static CAN_message_S CAN_bms_cell_voltages={
	.canID = CAN_bms_cell_voltages_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = &CAN_bms_cell_voltages_status
};

#define CAN_BMS_CELL_VOLTAGES_MULTIPLEX_RANGE 3
#define CAN_BMS_CELL_VOLTAGES_MULTIPLEX_OFFSET 0
#define CAN_BMS_CELL_VOLTAGES_M0_CELL_1_VOLTAGE_RANGE 15
#define CAN_BMS_CELL_VOLTAGES_M0_CELL_1_VOLTAGE_OFFSET 3
#define CAN_BMS_CELL_VOLTAGES_M0_CELL_2_VOLTAGE_RANGE 15
#define CAN_BMS_CELL_VOLTAGES_M0_CELL_2_VOLTAGE_OFFSET 18
#define CAN_BMS_CELL_VOLTAGES_M0_CELL_3_VOLTAGE_RANGE 15
#define CAN_BMS_CELL_VOLTAGES_M0_CELL_3_VOLTAGE_OFFSET 33
#define CAN_BMS_CELL_VOLTAGES_M0_CELL_4_VOLTAGE_RANGE 15
#define CAN_BMS_CELL_VOLTAGES_M0_CELL_4_VOLTAGE_OFFSET 48
#define CAN_BMS_CELL_VOLTAGES_M1_CELL_5_VOLTAGE_RANGE 15
#define CAN_BMS_CELL_VOLTAGES_M1_CELL_5_VOLTAGE_OFFSET 3
#define CAN_BMS_CELL_VOLTAGES_M1_CELL_6_VOLTAGE_RANGE 15
#define CAN_BMS_CELL_VOLTAGES_M1_CELL_6_VOLTAGE_OFFSET 18
#define CAN_BMS_CELL_VOLTAGES_M1_CELL_7_VOLTAGE_RANGE 15
#define CAN_BMS_CELL_VOLTAGES_M1_CELL_7_VOLTAGE_OFFSET 33
#define CAN_BMS_CELL_VOLTAGES_M1_CELL_8_VOLTAGE_RANGE 15
#define CAN_BMS_CELL_VOLTAGES_M1_CELL_8_VOLTAGE_OFFSET 48
#define CAN_BMS_CELL_VOLTAGES_M2_CELL_9_VOLTAGE_RANGE 15
#define CAN_BMS_CELL_VOLTAGES_M2_CELL_9_VOLTAGE_OFFSET 3
#define CAN_BMS_CELL_VOLTAGES_M2_CELL_10_VOLTAGE_RANGE 15
#define CAN_BMS_CELL_VOLTAGES_M2_CELL_10_VOLTAGE_OFFSET 18
#define CAN_BMS_CELL_VOLTAGES_M2_CELL_11_VOLTAGE_RANGE 15
#define CAN_BMS_CELL_VOLTAGES_M2_CELL_11_VOLTAGE_OFFSET 33
#define CAN_BMS_CELL_VOLTAGES_M2_CELL_12_VOLTAGE_RANGE 15
#define CAN_BMS_CELL_VOLTAGES_M2_CELL_12_VOLTAGE_OFFSET 48
#define CAN_BMS_CELL_VOLTAGES_M3_CELL_13_VOLTAGE_RANGE 15
#define CAN_BMS_CELL_VOLTAGES_M3_CELL_13_VOLTAGE_OFFSET 3
#define CAN_BMS_CELL_VOLTAGES_M3_CELL_14_VOLTAGE_RANGE 15
#define CAN_BMS_CELL_VOLTAGES_M3_CELL_14_VOLTAGE_OFFSET 18
#define CAN_BMS_CELL_VOLTAGES_M3_CELL_15_VOLTAGE_RANGE 15
#define CAN_BMS_CELL_VOLTAGES_M3_CELL_15_VOLTAGE_OFFSET 33
#define CAN_BMS_CELL_VOLTAGES_M3_CELL_16_VOLTAGE_RANGE 15
#define CAN_BMS_CELL_VOLTAGES_M3_CELL_16_VOLTAGE_OFFSET 48
#define CAN_BMS_CELL_VOLTAGES_M4_CELL_17_VOLTAGE_RANGE 15
#define CAN_BMS_CELL_VOLTAGES_M4_CELL_17_VOLTAGE_OFFSET 3
#define CAN_BMS_CELL_VOLTAGES_M4_CELL_18_VOLTAGE_RANGE 15
#define CAN_BMS_CELL_VOLTAGES_M4_CELL_18_VOLTAGE_OFFSET 18
#define CAN_BMS_CELL_VOLTAGES_M4_CELL_19_VOLTAGE_RANGE 15
#define CAN_BMS_CELL_VOLTAGES_M4_CELL_19_VOLTAGE_OFFSET 33
#define CAN_BMS_CELL_VOLTAGES_M4_CELL_20_VOLTAGE_RANGE 15
#define CAN_BMS_CELL_VOLTAGES_M4_CELL_20_VOLTAGE_OFFSET 48
#define CAN_BMS_CELL_VOLTAGES_M5_CELL_21_VOLTAGE_RANGE 15
#define CAN_BMS_CELL_VOLTAGES_M5_CELL_21_VOLTAGE_OFFSET 3
#define CAN_BMS_CELL_VOLTAGES_M5_CELL_22_VOLTAGE_RANGE 15
#define CAN_BMS_CELL_VOLTAGES_M5_CELL_22_VOLTAGE_OFFSET 18
#define CAN_BMS_CELL_VOLTAGES_M5_CELL_23_VOLTAGE_RANGE 15
#define CAN_BMS_CELL_VOLTAGES_M5_CELL_23_VOLTAGE_OFFSET 33
#define CAN_BMS_CELL_VOLTAGES_M5_CELL_24_VOLTAGE_RANGE 15
#define CAN_BMS_CELL_VOLTAGES_M5_CELL_24_VOLTAGE_OFFSET 48

void CAN_bms_cell_voltages_cell_1_voltage_set(uint16_t cell_1_voltage){
	uint16_t data_scaled = cell_1_voltage * 1.0;
	// Set 15-bit signal at bit offset 3
	CAN_bms_cell_voltages_payloads[0].word0 &= ~0xFFF8;
	CAN_bms_cell_voltages_payloads[0].word0 |= (data_scaled << 3) & 0xFFF8;
	CAN_bms_cell_voltages_payloads[0].word1 &= ~0x0003;
	CAN_bms_cell_voltages_payloads[0].word1 |= (data_scaled >> 13) & 0x0003;
}
void CAN_bms_cell_voltages_cell_2_voltage_set(uint16_t cell_2_voltage){
	uint16_t data_scaled = cell_2_voltage * 1.0;
	// Set 15-bit signal at bit offset 18
	CAN_bms_cell_voltages_payloads[0].word1 &= ~0xFFFC;
	CAN_bms_cell_voltages_payloads[0].word1 |= (data_scaled << 2) & 0xFFFC;
	CAN_bms_cell_voltages_payloads[0].word2 &= ~0x0001;
	CAN_bms_cell_voltages_payloads[0].word2 |= (data_scaled >> 14) & 0x0001;
}
void CAN_bms_cell_voltages_cell_3_voltage_set(uint16_t cell_3_voltage){
	uint16_t data_scaled = cell_3_voltage * 1.0;
	// Set 15-bit signal at bit offset 33
	CAN_bms_cell_voltages_payloads[0].word2 &= ~0xFFFE;
	CAN_bms_cell_voltages_payloads[0].word2 |= (data_scaled << 1) & 0xFFFE;
}
void CAN_bms_cell_voltages_cell_4_voltage_set(uint16_t cell_4_voltage){
	uint16_t data_scaled = cell_4_voltage * 1.0;
	// Set 15-bit signal at bit offset 48
	CAN_bms_cell_voltages_payloads[0].word3 &= ~0x7FFF;
	CAN_bms_cell_voltages_payloads[0].word3 |= data_scaled & 0x7FFF;
}
void CAN_bms_cell_voltages_cell_5_voltage_set(uint16_t cell_5_voltage){
	uint16_t data_scaled = cell_5_voltage * 1.0;
	// Set 15-bit signal at bit offset 3
	CAN_bms_cell_voltages_payloads[1].word0 &= ~0xFFF8;
	CAN_bms_cell_voltages_payloads[1].word0 |= (data_scaled << 3) & 0xFFF8;
	CAN_bms_cell_voltages_payloads[1].word1 &= ~0x0003;
	CAN_bms_cell_voltages_payloads[1].word1 |= (data_scaled >> 13) & 0x0003;
}
void CAN_bms_cell_voltages_cell_6_voltage_set(uint16_t cell_6_voltage){
	uint16_t data_scaled = cell_6_voltage * 1.0;
	// Set 15-bit signal at bit offset 18
	CAN_bms_cell_voltages_payloads[1].word1 &= ~0xFFFC;
	CAN_bms_cell_voltages_payloads[1].word1 |= (data_scaled << 2) & 0xFFFC;
	CAN_bms_cell_voltages_payloads[1].word2 &= ~0x0001;
	CAN_bms_cell_voltages_payloads[1].word2 |= (data_scaled >> 14) & 0x0001;
}
void CAN_bms_cell_voltages_cell_7_voltage_set(uint16_t cell_7_voltage){
	uint16_t data_scaled = cell_7_voltage * 1.0;
	// Set 15-bit signal at bit offset 33
	CAN_bms_cell_voltages_payloads[1].word2 &= ~0xFFFE;
	CAN_bms_cell_voltages_payloads[1].word2 |= (data_scaled << 1) & 0xFFFE;
}
void CAN_bms_cell_voltages_cell_8_voltage_set(uint16_t cell_8_voltage){
	uint16_t data_scaled = cell_8_voltage * 1.0;
	// Set 15-bit signal at bit offset 48
	CAN_bms_cell_voltages_payloads[1].word3 &= ~0x7FFF;
	CAN_bms_cell_voltages_payloads[1].word3 |= data_scaled & 0x7FFF;
}
void CAN_bms_cell_voltages_cell_9_voltage_set(uint16_t cell_9_voltage){
	uint16_t data_scaled = cell_9_voltage * 1.0;
	// Set 15-bit signal at bit offset 3
	CAN_bms_cell_voltages_payloads[2].word0 &= ~0xFFF8;
	CAN_bms_cell_voltages_payloads[2].word0 |= (data_scaled << 3) & 0xFFF8;
	CAN_bms_cell_voltages_payloads[2].word1 &= ~0x0003;
	CAN_bms_cell_voltages_payloads[2].word1 |= (data_scaled >> 13) & 0x0003;
}
void CAN_bms_cell_voltages_cell_10_voltage_set(uint16_t cell_10_voltage){
	uint16_t data_scaled = cell_10_voltage * 1.0;
	// Set 15-bit signal at bit offset 18
	CAN_bms_cell_voltages_payloads[2].word1 &= ~0xFFFC;
	CAN_bms_cell_voltages_payloads[2].word1 |= (data_scaled << 2) & 0xFFFC;
	CAN_bms_cell_voltages_payloads[2].word2 &= ~0x0001;
	CAN_bms_cell_voltages_payloads[2].word2 |= (data_scaled >> 14) & 0x0001;
}
void CAN_bms_cell_voltages_cell_11_voltage_set(uint16_t cell_11_voltage){
	uint16_t data_scaled = cell_11_voltage * 1.0;
	// Set 15-bit signal at bit offset 33
	CAN_bms_cell_voltages_payloads[2].word2 &= ~0xFFFE;
	CAN_bms_cell_voltages_payloads[2].word2 |= (data_scaled << 1) & 0xFFFE;
}
void CAN_bms_cell_voltages_cell_12_voltage_set(uint16_t cell_12_voltage){
	uint16_t data_scaled = cell_12_voltage * 1.0;
	// Set 15-bit signal at bit offset 48
	CAN_bms_cell_voltages_payloads[2].word3 &= ~0x7FFF;
	CAN_bms_cell_voltages_payloads[2].word3 |= data_scaled & 0x7FFF;
}
void CAN_bms_cell_voltages_cell_13_voltage_set(uint16_t cell_13_voltage){
	uint16_t data_scaled = cell_13_voltage * 1.0;
	// Set 15-bit signal at bit offset 3
	CAN_bms_cell_voltages_payloads[3].word0 &= ~0xFFF8;
	CAN_bms_cell_voltages_payloads[3].word0 |= (data_scaled << 3) & 0xFFF8;
	CAN_bms_cell_voltages_payloads[3].word1 &= ~0x0003;
	CAN_bms_cell_voltages_payloads[3].word1 |= (data_scaled >> 13) & 0x0003;
}
void CAN_bms_cell_voltages_cell_14_voltage_set(uint16_t cell_14_voltage){
	uint16_t data_scaled = cell_14_voltage * 1.0;
	// Set 15-bit signal at bit offset 18
	CAN_bms_cell_voltages_payloads[3].word1 &= ~0xFFFC;
	CAN_bms_cell_voltages_payloads[3].word1 |= (data_scaled << 2) & 0xFFFC;
	CAN_bms_cell_voltages_payloads[3].word2 &= ~0x0001;
	CAN_bms_cell_voltages_payloads[3].word2 |= (data_scaled >> 14) & 0x0001;
}
void CAN_bms_cell_voltages_cell_15_voltage_set(uint16_t cell_15_voltage){
	uint16_t data_scaled = cell_15_voltage * 1.0;
	// Set 15-bit signal at bit offset 33
	CAN_bms_cell_voltages_payloads[3].word2 &= ~0xFFFE;
	CAN_bms_cell_voltages_payloads[3].word2 |= (data_scaled << 1) & 0xFFFE;
}
void CAN_bms_cell_voltages_cell_16_voltage_set(uint16_t cell_16_voltage){
	uint16_t data_scaled = cell_16_voltage * 1.0;
	// Set 15-bit signal at bit offset 48
	CAN_bms_cell_voltages_payloads[3].word3 &= ~0x7FFF;
	CAN_bms_cell_voltages_payloads[3].word3 |= data_scaled & 0x7FFF;
}
void CAN_bms_cell_voltages_cell_17_voltage_set(uint16_t cell_17_voltage){
	uint16_t data_scaled = cell_17_voltage * 1.0;
	// Set 15-bit signal at bit offset 3
	CAN_bms_cell_voltages_payloads[4].word0 &= ~0xFFF8;
	CAN_bms_cell_voltages_payloads[4].word0 |= (data_scaled << 3) & 0xFFF8;
	CAN_bms_cell_voltages_payloads[4].word1 &= ~0x0003;
	CAN_bms_cell_voltages_payloads[4].word1 |= (data_scaled >> 13) & 0x0003;
}
void CAN_bms_cell_voltages_cell_18_voltage_set(uint16_t cell_18_voltage){
	uint16_t data_scaled = cell_18_voltage * 1.0;
	// Set 15-bit signal at bit offset 18
	CAN_bms_cell_voltages_payloads[4].word1 &= ~0xFFFC;
	CAN_bms_cell_voltages_payloads[4].word1 |= (data_scaled << 2) & 0xFFFC;
	CAN_bms_cell_voltages_payloads[4].word2 &= ~0x0001;
	CAN_bms_cell_voltages_payloads[4].word2 |= (data_scaled >> 14) & 0x0001;
}
void CAN_bms_cell_voltages_cell_19_voltage_set(uint16_t cell_19_voltage){
	uint16_t data_scaled = cell_19_voltage * 1.0;
	// Set 15-bit signal at bit offset 33
	CAN_bms_cell_voltages_payloads[4].word2 &= ~0xFFFE;
	CAN_bms_cell_voltages_payloads[4].word2 |= (data_scaled << 1) & 0xFFFE;
}
void CAN_bms_cell_voltages_cell_20_voltage_set(uint16_t cell_20_voltage){
	uint16_t data_scaled = cell_20_voltage * 1.0;
	// Set 15-bit signal at bit offset 48
	CAN_bms_cell_voltages_payloads[4].word3 &= ~0x7FFF;
	CAN_bms_cell_voltages_payloads[4].word3 |= data_scaled & 0x7FFF;
}
void CAN_bms_cell_voltages_cell_21_voltage_set(uint16_t cell_21_voltage){
	uint16_t data_scaled = cell_21_voltage * 1.0;
	// Set 15-bit signal at bit offset 3
	CAN_bms_cell_voltages_payloads[5].word0 &= ~0xFFF8;
	CAN_bms_cell_voltages_payloads[5].word0 |= (data_scaled << 3) & 0xFFF8;
	CAN_bms_cell_voltages_payloads[5].word1 &= ~0x0003;
	CAN_bms_cell_voltages_payloads[5].word1 |= (data_scaled >> 13) & 0x0003;
}
void CAN_bms_cell_voltages_cell_22_voltage_set(uint16_t cell_22_voltage){
	uint16_t data_scaled = cell_22_voltage * 1.0;
	// Set 15-bit signal at bit offset 18
	CAN_bms_cell_voltages_payloads[5].word1 &= ~0xFFFC;
	CAN_bms_cell_voltages_payloads[5].word1 |= (data_scaled << 2) & 0xFFFC;
	CAN_bms_cell_voltages_payloads[5].word2 &= ~0x0001;
	CAN_bms_cell_voltages_payloads[5].word2 |= (data_scaled >> 14) & 0x0001;
}
void CAN_bms_cell_voltages_cell_23_voltage_set(uint16_t cell_23_voltage){
	uint16_t data_scaled = cell_23_voltage * 1.0;
	// Set 15-bit signal at bit offset 33
	CAN_bms_cell_voltages_payloads[5].word2 &= ~0xFFFE;
	CAN_bms_cell_voltages_payloads[5].word2 |= (data_scaled << 1) & 0xFFFE;
}
void CAN_bms_cell_voltages_cell_24_voltage_set(uint16_t cell_24_voltage){
	uint16_t data_scaled = cell_24_voltage * 1.0;
	// Set 15-bit signal at bit offset 48
	CAN_bms_cell_voltages_payloads[5].word3 &= ~0x7FFF;
	CAN_bms_cell_voltages_payloads[5].word3 |= data_scaled & 0x7FFF;
}
void CAN_bms_cell_voltages_dlc_set(uint8_t dlc){
	CAN_bms_cell_voltages.dlc = dlc;
}
void CAN_bms_cell_voltages_send(void){
	// Update message status for self-consumption
	*CAN_bms_cell_voltages.canMessageStatus = 1;
	// Auto-select current mux payload
	CAN_bms_cell_voltages.payload = &CAN_bms_cell_voltages_payloads[CAN_bms_cell_voltages_mux];
	// Send the message
	CAN_write(&CAN_bms_cell_voltages);
	// Increment mux counter for next time
	CAN_bms_cell_voltages_mux++;
	if (CAN_bms_cell_voltages_mux >= CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES) {
		CAN_bms_cell_voltages_mux = 0;
	}
}

static CAN_payload_S CAN_bms_cell_temperatures_payloads[7] __attribute__((aligned(sizeof(CAN_payload_S))));
static uint8_t CAN_bms_cell_temperatures_mux = 0;
static volatile uint8_t CAN_bms_cell_temperatures_status = 0;
#define CAN_bms_cell_temperatures_ID 0x726

static CAN_message_S CAN_bms_cell_temperatures={
	.canID = CAN_bms_cell_temperatures_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = &CAN_bms_cell_temperatures_status
};

#define CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_RANGE 3
#define CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_OFFSET 0
#define CAN_BMS_CELL_TEMPERATURES_M0_STACK_1_LTC_INTERNAL_TEMP_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M0_STACK_1_LTC_INTERNAL_TEMP_OFFSET 3
#define CAN_BMS_CELL_TEMPERATURES_M0_STACK_1_BALANCE_TEMP_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M0_STACK_1_BALANCE_TEMP_OFFSET 15
#define CAN_BMS_CELL_TEMPERATURES_M0_STACK_2_LTC_INTERNAL_TEMP_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M0_STACK_2_LTC_INTERNAL_TEMP_OFFSET 27
#define CAN_BMS_CELL_TEMPERATURES_M0_STACK_2_BALANCE_TEMP_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M0_STACK_2_BALANCE_TEMP_OFFSET 39
#define CAN_BMS_CELL_TEMPERATURES_M1_TEMP_1_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M1_TEMP_1_OFFSET 3
#define CAN_BMS_CELL_TEMPERATURES_M1_TEMP_2_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M1_TEMP_2_OFFSET 15
#define CAN_BMS_CELL_TEMPERATURES_M1_TEMP_3_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M1_TEMP_3_OFFSET 27
#define CAN_BMS_CELL_TEMPERATURES_M1_TEMP_4_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M1_TEMP_4_OFFSET 39
#define CAN_BMS_CELL_TEMPERATURES_M2_TEMP_5_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M2_TEMP_5_OFFSET 3
#define CAN_BMS_CELL_TEMPERATURES_M2_TEMP_6_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M2_TEMP_6_OFFSET 15
#define CAN_BMS_CELL_TEMPERATURES_M2_TEMP_7_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M2_TEMP_7_OFFSET 27
#define CAN_BMS_CELL_TEMPERATURES_M2_TEMP_8_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M2_TEMP_8_OFFSET 39
#define CAN_BMS_CELL_TEMPERATURES_M3_TEMP_9_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M3_TEMP_9_OFFSET 3
#define CAN_BMS_CELL_TEMPERATURES_M3_TEMP_10_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M3_TEMP_10_OFFSET 15
#define CAN_BMS_CELL_TEMPERATURES_M3_TEMP_11_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M3_TEMP_11_OFFSET 27
#define CAN_BMS_CELL_TEMPERATURES_M3_TEMP_12_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M3_TEMP_12_OFFSET 39
#define CAN_BMS_CELL_TEMPERATURES_M4_TEMP_13_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M4_TEMP_13_OFFSET 3
#define CAN_BMS_CELL_TEMPERATURES_M4_TEMP_14_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M4_TEMP_14_OFFSET 15
#define CAN_BMS_CELL_TEMPERATURES_M4_TEMP_15_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M4_TEMP_15_OFFSET 27
#define CAN_BMS_CELL_TEMPERATURES_M4_TEMP_16_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M4_TEMP_16_OFFSET 39
#define CAN_BMS_CELL_TEMPERATURES_M5_TEMP_17_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M5_TEMP_17_OFFSET 3
#define CAN_BMS_CELL_TEMPERATURES_M5_TEMP_18_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M5_TEMP_18_OFFSET 15
#define CAN_BMS_CELL_TEMPERATURES_M5_TEMP_19_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M5_TEMP_19_OFFSET 27
#define CAN_BMS_CELL_TEMPERATURES_M5_TEMP_20_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M5_TEMP_20_OFFSET 39
#define CAN_BMS_CELL_TEMPERATURES_M6_TEMP_21_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M6_TEMP_21_OFFSET 3
#define CAN_BMS_CELL_TEMPERATURES_M6_TEMP_22_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M6_TEMP_22_OFFSET 15
#define CAN_BMS_CELL_TEMPERATURES_M6_TEMP_23_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M6_TEMP_23_OFFSET 27
#define CAN_BMS_CELL_TEMPERATURES_M6_TEMP_24_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M6_TEMP_24_OFFSET 39

void CAN_bms_cell_temperatures_stack_1_LTC_internal_temp_set(float stack_1_LTC_internal_temp){
	uint16_t data_scaled = (uint16_t)((stack_1_LTC_internal_temp - -40) * 10.0f + 0.5f);
	// Set 12-bit signal at bit offset 3
	CAN_bms_cell_temperatures_payloads[0].word0 &= ~0x7FF8;
	CAN_bms_cell_temperatures_payloads[0].word0 |= (data_scaled << 3) & 0x7FF8;
}
void CAN_bms_cell_temperatures_stack_1_balance_temp_set(float stack_1_balance_temp){
	uint16_t data_scaled = (uint16_t)((stack_1_balance_temp - -40) * 10.0f + 0.5f);
	// Set 12-bit signal at bit offset 15
	CAN_bms_cell_temperatures_payloads[0].word0 &= ~0x8000;
	CAN_bms_cell_temperatures_payloads[0].word0 |= (data_scaled << 15) & 0x8000;
	CAN_bms_cell_temperatures_payloads[0].word1 &= ~0x07FF;
	CAN_bms_cell_temperatures_payloads[0].word1 |= (data_scaled >> 1) & 0x07FF;
}
void CAN_bms_cell_temperatures_stack_2_LTC_internal_temp_set(float stack_2_LTC_internal_temp){
	uint16_t data_scaled = (uint16_t)((stack_2_LTC_internal_temp - -40) * 10.0f + 0.5f);
	// Set 12-bit signal at bit offset 27
	CAN_bms_cell_temperatures_payloads[0].word1 &= ~0xF800;
	CAN_bms_cell_temperatures_payloads[0].word1 |= (data_scaled << 11) & 0xF800;
	CAN_bms_cell_temperatures_payloads[0].word2 &= ~0x007F;
	CAN_bms_cell_temperatures_payloads[0].word2 |= (data_scaled >> 5) & 0x007F;
}
void CAN_bms_cell_temperatures_stack_2_balance_temp_set(float stack_2_balance_temp){
	uint16_t data_scaled = (uint16_t)((stack_2_balance_temp - -40) * 10.0f + 0.5f);
	// Set 12-bit signal at bit offset 39
	CAN_bms_cell_temperatures_payloads[0].word2 &= ~0xFF80;
	CAN_bms_cell_temperatures_payloads[0].word2 |= (data_scaled << 7) & 0xFF80;
	CAN_bms_cell_temperatures_payloads[0].word3 &= ~0x0007;
	CAN_bms_cell_temperatures_payloads[0].word3 |= (data_scaled >> 9) & 0x0007;
}
void CAN_bms_cell_temperatures_temp_1_set(float temp_1){
	uint16_t data_scaled = (uint16_t)((temp_1 - -40) * 10.0f + 0.5f);
	// Set 12-bit signal at bit offset 3
	CAN_bms_cell_temperatures_payloads[1].word0 &= ~0x7FF8;
	CAN_bms_cell_temperatures_payloads[1].word0 |= (data_scaled << 3) & 0x7FF8;
}
void CAN_bms_cell_temperatures_temp_2_set(float temp_2){
	uint16_t data_scaled = (uint16_t)(temp_2 * 10.0f + 0.5f);
	// Set 12-bit signal at bit offset 15
	CAN_bms_cell_temperatures_payloads[1].word0 &= ~0x8000;
	CAN_bms_cell_temperatures_payloads[1].word0 |= (data_scaled << 15) & 0x8000;
	CAN_bms_cell_temperatures_payloads[1].word1 &= ~0x07FF;
	CAN_bms_cell_temperatures_payloads[1].word1 |= (data_scaled >> 1) & 0x07FF;
}
void CAN_bms_cell_temperatures_temp_3_set(float temp_3){
	uint16_t data_scaled = (uint16_t)((temp_3 - -40) * 10.0f + 0.5f);
	// Set 12-bit signal at bit offset 27
	CAN_bms_cell_temperatures_payloads[1].word1 &= ~0xF800;
	CAN_bms_cell_temperatures_payloads[1].word1 |= (data_scaled << 11) & 0xF800;
	CAN_bms_cell_temperatures_payloads[1].word2 &= ~0x007F;
	CAN_bms_cell_temperatures_payloads[1].word2 |= (data_scaled >> 5) & 0x007F;
}
void CAN_bms_cell_temperatures_temp_4_set(float temp_4){
	uint16_t data_scaled = (uint16_t)((temp_4 - -40) * 10.0f + 0.5f);
	// Set 12-bit signal at bit offset 39
	CAN_bms_cell_temperatures_payloads[1].word2 &= ~0xFF80;
	CAN_bms_cell_temperatures_payloads[1].word2 |= (data_scaled << 7) & 0xFF80;
	CAN_bms_cell_temperatures_payloads[1].word3 &= ~0x0007;
	CAN_bms_cell_temperatures_payloads[1].word3 |= (data_scaled >> 9) & 0x0007;
}
void CAN_bms_cell_temperatures_temp_5_set(float temp_5){
	uint16_t data_scaled = (uint16_t)((temp_5 - -40) * 10.0f + 0.5f);
	// Set 12-bit signal at bit offset 3
	CAN_bms_cell_temperatures_payloads[2].word0 &= ~0x7FF8;
	CAN_bms_cell_temperatures_payloads[2].word0 |= (data_scaled << 3) & 0x7FF8;
}
void CAN_bms_cell_temperatures_temp_6_set(float temp_6){
	uint16_t data_scaled = (uint16_t)((temp_6 - -40) * 10.0f + 0.5f);
	// Set 12-bit signal at bit offset 15
	CAN_bms_cell_temperatures_payloads[2].word0 &= ~0x8000;
	CAN_bms_cell_temperatures_payloads[2].word0 |= (data_scaled << 15) & 0x8000;
	CAN_bms_cell_temperatures_payloads[2].word1 &= ~0x07FF;
	CAN_bms_cell_temperatures_payloads[2].word1 |= (data_scaled >> 1) & 0x07FF;
}
void CAN_bms_cell_temperatures_temp_7_set(float temp_7){
	uint16_t data_scaled = (uint16_t)((temp_7 - -40) * 10.0f + 0.5f);
	// Set 12-bit signal at bit offset 27
	CAN_bms_cell_temperatures_payloads[2].word1 &= ~0xF800;
	CAN_bms_cell_temperatures_payloads[2].word1 |= (data_scaled << 11) & 0xF800;
	CAN_bms_cell_temperatures_payloads[2].word2 &= ~0x007F;
	CAN_bms_cell_temperatures_payloads[2].word2 |= (data_scaled >> 5) & 0x007F;
}
void CAN_bms_cell_temperatures_temp_8_set(float temp_8){
	uint16_t data_scaled = (uint16_t)((temp_8 - -40) * 10.0f + 0.5f);
	// Set 12-bit signal at bit offset 39
	CAN_bms_cell_temperatures_payloads[2].word2 &= ~0xFF80;
	CAN_bms_cell_temperatures_payloads[2].word2 |= (data_scaled << 7) & 0xFF80;
	CAN_bms_cell_temperatures_payloads[2].word3 &= ~0x0007;
	CAN_bms_cell_temperatures_payloads[2].word3 |= (data_scaled >> 9) & 0x0007;
}
void CAN_bms_cell_temperatures_temp_9_set(float temp_9){
	uint16_t data_scaled = (uint16_t)((temp_9 - -40) * 10.0f + 0.5f);
	// Set 12-bit signal at bit offset 3
	CAN_bms_cell_temperatures_payloads[3].word0 &= ~0x7FF8;
	CAN_bms_cell_temperatures_payloads[3].word0 |= (data_scaled << 3) & 0x7FF8;
}
void CAN_bms_cell_temperatures_temp_10_set(float temp_10){
	uint16_t data_scaled = (uint16_t)((temp_10 - -40) * 10.0f + 0.5f);
	// Set 12-bit signal at bit offset 15
	CAN_bms_cell_temperatures_payloads[3].word0 &= ~0x8000;
	CAN_bms_cell_temperatures_payloads[3].word0 |= (data_scaled << 15) & 0x8000;
	CAN_bms_cell_temperatures_payloads[3].word1 &= ~0x07FF;
	CAN_bms_cell_temperatures_payloads[3].word1 |= (data_scaled >> 1) & 0x07FF;
}
void CAN_bms_cell_temperatures_temp_11_set(float temp_11){
	uint16_t data_scaled = (uint16_t)((temp_11 - -40) * 10.0f + 0.5f);
	// Set 12-bit signal at bit offset 27
	CAN_bms_cell_temperatures_payloads[3].word1 &= ~0xF800;
	CAN_bms_cell_temperatures_payloads[3].word1 |= (data_scaled << 11) & 0xF800;
	CAN_bms_cell_temperatures_payloads[3].word2 &= ~0x007F;
	CAN_bms_cell_temperatures_payloads[3].word2 |= (data_scaled >> 5) & 0x007F;
}
void CAN_bms_cell_temperatures_temp_12_set(float temp_12){
	uint16_t data_scaled = (uint16_t)((temp_12 - -40) * 10.0f + 0.5f);
	// Set 12-bit signal at bit offset 39
	CAN_bms_cell_temperatures_payloads[3].word2 &= ~0xFF80;
	CAN_bms_cell_temperatures_payloads[3].word2 |= (data_scaled << 7) & 0xFF80;
	CAN_bms_cell_temperatures_payloads[3].word3 &= ~0x0007;
	CAN_bms_cell_temperatures_payloads[3].word3 |= (data_scaled >> 9) & 0x0007;
}
void CAN_bms_cell_temperatures_temp_13_set(float temp_13){
	uint16_t data_scaled = (uint16_t)((temp_13 - -40) * 10.0f + 0.5f);
	// Set 12-bit signal at bit offset 3
	CAN_bms_cell_temperatures_payloads[4].word0 &= ~0x7FF8;
	CAN_bms_cell_temperatures_payloads[4].word0 |= (data_scaled << 3) & 0x7FF8;
}
void CAN_bms_cell_temperatures_temp_14_set(float temp_14){
	uint16_t data_scaled = (uint16_t)((temp_14 - -40) * 10.0f + 0.5f);
	// Set 12-bit signal at bit offset 15
	CAN_bms_cell_temperatures_payloads[4].word0 &= ~0x8000;
	CAN_bms_cell_temperatures_payloads[4].word0 |= (data_scaled << 15) & 0x8000;
	CAN_bms_cell_temperatures_payloads[4].word1 &= ~0x07FF;
	CAN_bms_cell_temperatures_payloads[4].word1 |= (data_scaled >> 1) & 0x07FF;
}
void CAN_bms_cell_temperatures_temp_15_set(float temp_15){
	uint16_t data_scaled = (uint16_t)((temp_15 - -40) * 10.0f + 0.5f);
	// Set 12-bit signal at bit offset 27
	CAN_bms_cell_temperatures_payloads[4].word1 &= ~0xF800;
	CAN_bms_cell_temperatures_payloads[4].word1 |= (data_scaled << 11) & 0xF800;
	CAN_bms_cell_temperatures_payloads[4].word2 &= ~0x007F;
	CAN_bms_cell_temperatures_payloads[4].word2 |= (data_scaled >> 5) & 0x007F;
}
void CAN_bms_cell_temperatures_temp_16_set(float temp_16){
	uint16_t data_scaled = (uint16_t)((temp_16 - -40) * 10.0f + 0.5f);
	// Set 12-bit signal at bit offset 39
	CAN_bms_cell_temperatures_payloads[4].word2 &= ~0xFF80;
	CAN_bms_cell_temperatures_payloads[4].word2 |= (data_scaled << 7) & 0xFF80;
	CAN_bms_cell_temperatures_payloads[4].word3 &= ~0x0007;
	CAN_bms_cell_temperatures_payloads[4].word3 |= (data_scaled >> 9) & 0x0007;
}
void CAN_bms_cell_temperatures_temp_17_set(float temp_17){
	uint16_t data_scaled = (uint16_t)((temp_17 - -40) * 10.0f + 0.5f);
	// Set 12-bit signal at bit offset 3
	CAN_bms_cell_temperatures_payloads[5].word0 &= ~0x7FF8;
	CAN_bms_cell_temperatures_payloads[5].word0 |= (data_scaled << 3) & 0x7FF8;
}
void CAN_bms_cell_temperatures_temp_18_set(float temp_18){
	uint16_t data_scaled = (uint16_t)((temp_18 - -40) * 10.0f + 0.5f);
	// Set 12-bit signal at bit offset 15
	CAN_bms_cell_temperatures_payloads[5].word0 &= ~0x8000;
	CAN_bms_cell_temperatures_payloads[5].word0 |= (data_scaled << 15) & 0x8000;
	CAN_bms_cell_temperatures_payloads[5].word1 &= ~0x07FF;
	CAN_bms_cell_temperatures_payloads[5].word1 |= (data_scaled >> 1) & 0x07FF;
}
void CAN_bms_cell_temperatures_temp_19_set(float temp_19){
	uint16_t data_scaled = (uint16_t)((temp_19 - -40) * 10.0f + 0.5f);
	// Set 12-bit signal at bit offset 27
	CAN_bms_cell_temperatures_payloads[5].word1 &= ~0xF800;
	CAN_bms_cell_temperatures_payloads[5].word1 |= (data_scaled << 11) & 0xF800;
	CAN_bms_cell_temperatures_payloads[5].word2 &= ~0x007F;
	CAN_bms_cell_temperatures_payloads[5].word2 |= (data_scaled >> 5) & 0x007F;
}
void CAN_bms_cell_temperatures_temp_20_set(float temp_20){
	uint16_t data_scaled = (uint16_t)((temp_20 - -40) * 10.0f + 0.5f);
	// Set 12-bit signal at bit offset 39
	CAN_bms_cell_temperatures_payloads[5].word2 &= ~0xFF80;
	CAN_bms_cell_temperatures_payloads[5].word2 |= (data_scaled << 7) & 0xFF80;
	CAN_bms_cell_temperatures_payloads[5].word3 &= ~0x0007;
	CAN_bms_cell_temperatures_payloads[5].word3 |= (data_scaled >> 9) & 0x0007;
}
void CAN_bms_cell_temperatures_temp_21_set(float temp_21){
	uint16_t data_scaled = (uint16_t)((temp_21 - -40) * 10.0f + 0.5f);
	// Set 12-bit signal at bit offset 3
	CAN_bms_cell_temperatures_payloads[6].word0 &= ~0x7FF8;
	CAN_bms_cell_temperatures_payloads[6].word0 |= (data_scaled << 3) & 0x7FF8;
}
void CAN_bms_cell_temperatures_temp_22_set(float temp_22){
	uint16_t data_scaled = (uint16_t)((temp_22 - -40) * 10.0f + 0.5f);
	// Set 12-bit signal at bit offset 15
	CAN_bms_cell_temperatures_payloads[6].word0 &= ~0x8000;
	CAN_bms_cell_temperatures_payloads[6].word0 |= (data_scaled << 15) & 0x8000;
	CAN_bms_cell_temperatures_payloads[6].word1 &= ~0x07FF;
	CAN_bms_cell_temperatures_payloads[6].word1 |= (data_scaled >> 1) & 0x07FF;
}
void CAN_bms_cell_temperatures_temp_23_set(float temp_23){
	uint16_t data_scaled = (uint16_t)((temp_23 - -40) * 10.0f + 0.5f);
	// Set 12-bit signal at bit offset 27
	CAN_bms_cell_temperatures_payloads[6].word1 &= ~0xF800;
	CAN_bms_cell_temperatures_payloads[6].word1 |= (data_scaled << 11) & 0xF800;
	CAN_bms_cell_temperatures_payloads[6].word2 &= ~0x007F;
	CAN_bms_cell_temperatures_payloads[6].word2 |= (data_scaled >> 5) & 0x007F;
}
void CAN_bms_cell_temperatures_temp_24_set(float temp_24){
	uint16_t data_scaled = (uint16_t)((temp_24 - -40) * 10.0f + 0.5f);
	// Set 12-bit signal at bit offset 39
	CAN_bms_cell_temperatures_payloads[6].word2 &= ~0xFF80;
	CAN_bms_cell_temperatures_payloads[6].word2 |= (data_scaled << 7) & 0xFF80;
	CAN_bms_cell_temperatures_payloads[6].word3 &= ~0x0007;
	CAN_bms_cell_temperatures_payloads[6].word3 |= (data_scaled >> 9) & 0x0007;
}
void CAN_bms_cell_temperatures_dlc_set(uint8_t dlc){
	CAN_bms_cell_temperatures.dlc = dlc;
}
void CAN_bms_cell_temperatures_send(void){
	// Update message status for self-consumption
	*CAN_bms_cell_temperatures.canMessageStatus = 1;
	// Auto-select current mux payload
	CAN_bms_cell_temperatures.payload = &CAN_bms_cell_temperatures_payloads[CAN_bms_cell_temperatures_mux];
	// Send the message
	CAN_write(&CAN_bms_cell_temperatures);
	// Increment mux counter for next time
	CAN_bms_cell_temperatures_mux++;
	if (CAN_bms_cell_temperatures_mux >= CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES) {
		CAN_bms_cell_temperatures_mux = 0;
	}
}

/**********************************************************
 * motorcontroller NODE MESSAGES
 */
#define CAN_motorcontroller_heartbeat_ID 0x701

static CAN_message_S CAN_motorcontroller_heartbeat={
	.canID = CAN_motorcontroller_heartbeat_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
};

#define CAN_MOTORCONTROLLER_HEARTBEAT_MODE_RANGE 16
#define CAN_MOTORCONTROLLER_HEARTBEAT_MODE_OFFSET 0

uint8_t CAN_motorcontroller_heartbeat_checkDataIsUnread(void){
	return CAN_checkDataIsUnread(&CAN_motorcontroller_heartbeat);
}
uint8_t CAN_motorcontroller_heartbeat_checkDataIsStale(void){
	return CAN_checkDataIsStale(&CAN_motorcontroller_heartbeat, 60);
}
uint16_t CAN_motorcontroller_heartbeat_Mode_get(void){
	// Extract 16-bit signal at bit offset 0
	uint16_t data = 0;
	data |= (uint16_t)((CAN_motorcontroller_heartbeat.payload->word0 & 0xFFFF) >> 0) << 0;
	return (data * 1.0) + 0;
}

#define CAN_motorcontroller_SYNC_ID 0x80

static CAN_message_S CAN_motorcontroller_SYNC={
	.canID = CAN_motorcontroller_SYNC_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
};


uint8_t CAN_motorcontroller_SYNC_checkDataIsUnread(void){
	return CAN_checkDataIsUnread(&CAN_motorcontroller_SYNC);
}
uint8_t CAN_motorcontroller_SYNC_checkDataIsStale(void){
	return CAN_checkDataIsStale(&CAN_motorcontroller_SYNC, 60);
}

#define CAN_motorcontroller_SDO_response_ID 0x581

static CAN_message_S CAN_motorcontroller_SDO_response={
	.canID = CAN_motorcontroller_SDO_response_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
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

uint8_t CAN_motorcontroller_SDO_response_checkDataIsUnread(void){
	return CAN_checkDataIsUnread(&CAN_motorcontroller_SDO_response);
}
uint16_t CAN_motorcontroller_SDO_response_size_get(void){
	// Extract 1-bit signal at bit offset 0
	uint16_t data = 0;
	data |= (uint16_t)((CAN_motorcontroller_SDO_response.payload->word0 & 0x0001) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_motorcontroller_SDO_response_expidited_xfer_get(void){
	// Extract 1-bit signal at bit offset 1
	uint16_t data = 0;
	data |= (uint16_t)((CAN_motorcontroller_SDO_response.payload->word0 & 0x0002) >> 1) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_motorcontroller_SDO_response_n_bytes_get(void){
	// Extract 2-bit signal at bit offset 2
	uint16_t data = 0;
	data |= (uint16_t)((CAN_motorcontroller_SDO_response.payload->word0 & 0x000C) >> 2) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_motorcontroller_SDO_response_reserved_get(void){
	// Extract 1-bit signal at bit offset 4
	uint16_t data = 0;
	data |= (uint16_t)((CAN_motorcontroller_SDO_response.payload->word0 & 0x0010) >> 4) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_motorcontroller_SDO_response_ccs_get(void){
	// Extract 3-bit signal at bit offset 5
	uint16_t data = 0;
	data |= (uint16_t)((CAN_motorcontroller_SDO_response.payload->word0 & 0x00E0) >> 5) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_motorcontroller_SDO_response_index_get(void){
	// Extract 16-bit signal at bit offset 8
	uint16_t data = 0;
	data |= (uint16_t)((CAN_motorcontroller_SDO_response.payload->word0 & 0xFF00) >> 8) << 0;
	data |= (uint16_t)((CAN_motorcontroller_SDO_response.payload->word1 & 0x00FF) >> 0) << 8;
	return (data * 1.0) + 0;
}
uint16_t CAN_motorcontroller_SDO_response_subindex_get(void){
	// Extract 8-bit signal at bit offset 24
	uint16_t data = 0;
	data |= (uint16_t)((CAN_motorcontroller_SDO_response.payload->word1 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_motorcontroller_SDO_response_byte_4_get(void){
	// Extract 8-bit signal at bit offset 32
	uint16_t data = 0;
	data |= (uint16_t)((CAN_motorcontroller_SDO_response.payload->word2 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_motorcontroller_SDO_response_byte_5_get(void){
	// Extract 8-bit signal at bit offset 40
	uint16_t data = 0;
	data |= (uint16_t)((CAN_motorcontroller_SDO_response.payload->word2 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_motorcontroller_SDO_response_byte_6_get(void){
	// Extract 8-bit signal at bit offset 48
	uint16_t data = 0;
	data |= (uint16_t)((CAN_motorcontroller_SDO_response.payload->word3 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_motorcontroller_SDO_response_byte_7_get(void){
	// Extract 8-bit signal at bit offset 56
	uint16_t data = 0;
	data |= (uint16_t)((CAN_motorcontroller_SDO_response.payload->word3 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}

/**********************************************************
 * charger NODE MESSAGES
 */
#define CAN_charger_status_ID 0x19005075

static CAN_message_S CAN_charger_status={
	.canID = CAN_charger_status_ID,
	.canXID = 1,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
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

uint8_t CAN_charger_status_checkDataIsUnread(void){
	return CAN_checkDataIsUnread(&CAN_charger_status);
}
uint8_t CAN_charger_status_checkDataIsStale(void){
	return CAN_checkDataIsStale(&CAN_charger_status, 2000);
}
uint16_t CAN_charger_status_output_voltage_high_byte_get(void){
	// Extract 8-bit signal at bit offset 0
	uint16_t data = 0;
	data |= (uint16_t)((CAN_charger_status.payload->word0 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_charger_status_output_voltage_low_byte_get(void){
	// Extract 8-bit signal at bit offset 8
	uint16_t data = 0;
	data |= (uint16_t)((CAN_charger_status.payload->word0 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_charger_status_output_current_high_byte_get(void){
	// Extract 8-bit signal at bit offset 16
	uint16_t data = 0;
	data |= (uint16_t)((CAN_charger_status.payload->word1 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_charger_status_output_current_low_byte_get(void){
	// Extract 8-bit signal at bit offset 24
	uint16_t data = 0;
	data |= (uint16_t)((CAN_charger_status.payload->word1 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_charger_status_hardware_error_get(void){
	// Extract 1-bit signal at bit offset 32
	uint16_t data = 0;
	data |= (uint16_t)((CAN_charger_status.payload->word2 & 0x0001) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_charger_status_charger_overtemp_error_get(void){
	// Extract 1-bit signal at bit offset 33
	uint16_t data = 0;
	data |= (uint16_t)((CAN_charger_status.payload->word2 & 0x0002) >> 1) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_charger_status_input_voltage_error_get(void){
	// Extract 1-bit signal at bit offset 34
	uint16_t data = 0;
	data |= (uint16_t)((CAN_charger_status.payload->word2 & 0x0004) >> 2) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_charger_status_battery_detect_error_get(void){
	// Extract 1-bit signal at bit offset 35
	uint16_t data = 0;
	data |= (uint16_t)((CAN_charger_status.payload->word2 & 0x0008) >> 3) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_charger_status_communication_error_get(void){
	// Extract 1-bit signal at bit offset 36
	uint16_t data = 0;
	data |= (uint16_t)((CAN_charger_status.payload->word2 & 0x0010) >> 4) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_charger_status_byte7_get(void){
	// Extract 8-bit signal at bit offset 37
	uint16_t data = 0;
	data |= (uint16_t)((CAN_charger_status.payload->word2 & 0x1FE0) >> 5) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_charger_status_byte8_get(void){
	// Extract 8-bit signal at bit offset 45
	uint16_t data = 0;
	data |= (uint16_t)((CAN_charger_status.payload->word2 & 0xE000) >> 13) << 0;
	data |= (uint16_t)((CAN_charger_status.payload->word3 & 0x001F) >> 0) << 3;
	return (data * 1.0) + 0;
}

/**********************************************************
 * boot_host NODE MESSAGES
 */
#define CAN_boot_host_bms_ID 0xA1

static CAN_message_S CAN_boot_host_bms={
	.canID = CAN_boot_host_bms_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
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

uint8_t CAN_boot_host_bms_checkDataIsUnread(void){
	return CAN_checkDataIsUnread(&CAN_boot_host_bms);
}
uint8_t CAN_boot_host_bms_checkDataIsStale(void){
	return CAN_checkDataIsStale(&CAN_boot_host_bms, 2);
}
uint16_t CAN_boot_host_bms_type_get(void){
	// Extract 4-bit signal at bit offset 0
	uint16_t data = 0;
	data |= (uint16_t)((CAN_boot_host_bms.payload->word0 & 0x000F) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_bms_code_get(void){
	// Extract 4-bit signal at bit offset 4
	uint16_t data = 0;
	data |= (uint16_t)((CAN_boot_host_bms.payload->word0 & 0x00F0) >> 4) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_bms_byte1_get(void){
	// Extract 8-bit signal at bit offset 8
	uint16_t data = 0;
	data |= (uint16_t)((CAN_boot_host_bms.payload->word0 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_bms_byte2_get(void){
	// Extract 8-bit signal at bit offset 16
	uint16_t data = 0;
	data |= (uint16_t)((CAN_boot_host_bms.payload->word1 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_bms_byte3_get(void){
	// Extract 8-bit signal at bit offset 24
	uint16_t data = 0;
	data |= (uint16_t)((CAN_boot_host_bms.payload->word1 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_bms_byte4_get(void){
	// Extract 8-bit signal at bit offset 32
	uint16_t data = 0;
	data |= (uint16_t)((CAN_boot_host_bms.payload->word2 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_bms_byte5_get(void){
	// Extract 8-bit signal at bit offset 40
	uint16_t data = 0;
	data |= (uint16_t)((CAN_boot_host_bms.payload->word2 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_bms_byte6_get(void){
	// Extract 8-bit signal at bit offset 48
	uint16_t data = 0;
	data |= (uint16_t)((CAN_boot_host_bms.payload->word3 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_bms_byte7_get(void){
	// Extract 8-bit signal at bit offset 56
	uint16_t data = 0;
	data |= (uint16_t)((CAN_boot_host_bms.payload->word3 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}

void CAN_DBC_init(void) {
	// Initialize multiplexed message: status
	CAN_bms_status.payload = &CAN_bms_status_payloads[0];
	// Pre-set mux value 0 in payload 0
	// Set 3-bit signal at bit offset 0
	CAN_bms_status_payloads[0].word0 &= ~0x0007;
	CAN_bms_status_payloads[0].word0 |= 0 & 0x0007;
	// Pre-set mux value 1 in payload 1
	// Set 3-bit signal at bit offset 0
	CAN_bms_status_payloads[1].word0 &= ~0x0007;
	CAN_bms_status_payloads[1].word0 |= 1 & 0x0007;
	// Pre-set mux value 2 in payload 2
	// Set 3-bit signal at bit offset 0
	CAN_bms_status_payloads[2].word0 &= ~0x0007;
	CAN_bms_status_payloads[2].word0 |= 2 & 0x0007;
	// Pre-set mux value 3 in payload 3
	// Set 3-bit signal at bit offset 0
	CAN_bms_status_payloads[3].word0 &= ~0x0007;
	CAN_bms_status_payloads[3].word0 |= 3 & 0x0007;
	// Pre-set mux value 4 in payload 4
	// Set 3-bit signal at bit offset 0
	CAN_bms_status_payloads[4].word0 &= ~0x0007;
	CAN_bms_status_payloads[4].word0 |= 4 & 0x0007;
	// Initialize multiplexed message: cell_voltages
	CAN_bms_cell_voltages.payload = &CAN_bms_cell_voltages_payloads[0];
	// Pre-set mux value 0 in payload 0
	// Set 3-bit signal at bit offset 0
	CAN_bms_cell_voltages_payloads[0].word0 &= ~0x0007;
	CAN_bms_cell_voltages_payloads[0].word0 |= 0 & 0x0007;
	// Pre-set mux value 1 in payload 1
	// Set 3-bit signal at bit offset 0
	CAN_bms_cell_voltages_payloads[1].word0 &= ~0x0007;
	CAN_bms_cell_voltages_payloads[1].word0 |= 1 & 0x0007;
	// Pre-set mux value 2 in payload 2
	// Set 3-bit signal at bit offset 0
	CAN_bms_cell_voltages_payloads[2].word0 &= ~0x0007;
	CAN_bms_cell_voltages_payloads[2].word0 |= 2 & 0x0007;
	// Pre-set mux value 3 in payload 3
	// Set 3-bit signal at bit offset 0
	CAN_bms_cell_voltages_payloads[3].word0 &= ~0x0007;
	CAN_bms_cell_voltages_payloads[3].word0 |= 3 & 0x0007;
	// Pre-set mux value 4 in payload 4
	// Set 3-bit signal at bit offset 0
	CAN_bms_cell_voltages_payloads[4].word0 &= ~0x0007;
	CAN_bms_cell_voltages_payloads[4].word0 |= 4 & 0x0007;
	// Pre-set mux value 5 in payload 5
	// Set 3-bit signal at bit offset 0
	CAN_bms_cell_voltages_payloads[5].word0 &= ~0x0007;
	CAN_bms_cell_voltages_payloads[5].word0 |= 5 & 0x0007;
	// Initialize multiplexed message: cell_temperatures
	CAN_bms_cell_temperatures.payload = &CAN_bms_cell_temperatures_payloads[0];
	// Pre-set mux value 0 in payload 0
	// Set 3-bit signal at bit offset 0
	CAN_bms_cell_temperatures_payloads[0].word0 &= ~0x0007;
	CAN_bms_cell_temperatures_payloads[0].word0 |= 0 & 0x0007;
	// Pre-set mux value 1 in payload 1
	// Set 3-bit signal at bit offset 0
	CAN_bms_cell_temperatures_payloads[1].word0 &= ~0x0007;
	CAN_bms_cell_temperatures_payloads[1].word0 |= 1 & 0x0007;
	// Pre-set mux value 2 in payload 2
	// Set 3-bit signal at bit offset 0
	CAN_bms_cell_temperatures_payloads[2].word0 &= ~0x0007;
	CAN_bms_cell_temperatures_payloads[2].word0 |= 2 & 0x0007;
	// Pre-set mux value 3 in payload 3
	// Set 3-bit signal at bit offset 0
	CAN_bms_cell_temperatures_payloads[3].word0 &= ~0x0007;
	CAN_bms_cell_temperatures_payloads[3].word0 |= 3 & 0x0007;
	// Pre-set mux value 4 in payload 4
	// Set 3-bit signal at bit offset 0
	CAN_bms_cell_temperatures_payloads[4].word0 &= ~0x0007;
	CAN_bms_cell_temperatures_payloads[4].word0 |= 4 & 0x0007;
	// Pre-set mux value 5 in payload 5
	// Set 3-bit signal at bit offset 0
	CAN_bms_cell_temperatures_payloads[5].word0 &= ~0x0007;
	CAN_bms_cell_temperatures_payloads[5].word0 |= 5 & 0x0007;
	// Pre-set mux value 6 in payload 6
	// Set 3-bit signal at bit offset 0
	CAN_bms_cell_temperatures_payloads[6].word0 &= ~0x0007;
	CAN_bms_cell_temperatures_payloads[6].word0 |= 6 & 0x0007;
	CAN_configureMailbox(&CAN_mcu_status);
	CAN_configureMailbox(&CAN_mcu_command);
	CAN_configureMailbox(&CAN_mcu_mcu_debug);
	CAN_configureMailbox(&CAN_motorcontroller_heartbeat);
	CAN_configureMailbox(&CAN_motorcontroller_SYNC);
	CAN_configureMailbox(&CAN_motorcontroller_SDO_response);
	CAN_configureMailbox(&CAN_charger_status);
	CAN_configureMailbox(&CAN_boot_host_bms);
}

void CAN_send_1ms(void){
	// No messages to send at this interval
}

void CAN_send_10ms(void){
	CAN_bms_status_send();
	CAN_bms_power_systems_send();
	CAN_bms_debug_send();
}

void CAN_send_100ms(void){
	CAN_bms_cell_voltages_send();
}

void CAN_send_1000ms(void){
	CAN_bms_charger_request_send();
	CAN_bms_cell_temperatures_send();
}
