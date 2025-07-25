#include "bms_dbc.h"
#include "CAN.h"
#include "utils.h"
/**********************************************************
 * dash NODE MESSAGES
 */
/**********************************************************
 * mcu NODE MESSAGES
 */
#define CAN_mcu_status_ID 0x711

static CAN_message_S CAN_mcu_status={
	.canID = CAN_mcu_status_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
};

#define CAN_MCU_STATUS_HEARTBEAT_RANGE 4
#define CAN_MCU_STATUS_HEARTBEAT_OFFSET 0
#define CAN_MCU_STATUS_HIGHBEAM_RANGE 1
#define CAN_MCU_STATUS_HIGHBEAM_OFFSET 4
#define CAN_MCU_STATUS_LOWBEAM_RANGE 1
#define CAN_MCU_STATUS_LOWBEAM_OFFSET 5
#define CAN_MCU_STATUS_BRAKELIGHT_RANGE 1
#define CAN_MCU_STATUS_BRAKELIGHT_OFFSET 6
#define CAN_MCU_STATUS_TAILLIGHT_RANGE 1
#define CAN_MCU_STATUS_TAILLIGHT_OFFSET 7
#define CAN_MCU_STATUS_HORN_RANGE 1
#define CAN_MCU_STATUS_HORN_OFFSET 8
#define CAN_MCU_STATUS_TURNSIGNALFR_RANGE 1
#define CAN_MCU_STATUS_TURNSIGNALFR_OFFSET 9
#define CAN_MCU_STATUS_TURNSIGNALFL_RANGE 1
#define CAN_MCU_STATUS_TURNSIGNALFL_OFFSET 10
#define CAN_MCU_STATUS_TURNSIGNALRR_RANGE 1
#define CAN_MCU_STATUS_TURNSIGNALRR_OFFSET 11
#define CAN_MCU_STATUS_TURNSIGNALRL_RANGE 1
#define CAN_MCU_STATUS_TURNSIGNALRL_OFFSET 12
#define CAN_MCU_STATUS_BRAKESWITCHFRONT_RANGE 1
#define CAN_MCU_STATUS_BRAKESWITCHFRONT_OFFSET 13
#define CAN_MCU_STATUS_BRAKESWITCHREAR_RANGE 1
#define CAN_MCU_STATUS_BRAKESWITCHREAR_OFFSET 14
#define CAN_MCU_STATUS_KILLSWITCH_RANGE 1
#define CAN_MCU_STATUS_KILLSWITCH_OFFSET 15
#define CAN_MCU_STATUS_IGNITIONSWITCH_RANGE 1
#define CAN_MCU_STATUS_IGNITIONSWITCH_OFFSET 16
#define CAN_MCU_STATUS_LEFTTURNSWITCH_RANGE 1
#define CAN_MCU_STATUS_LEFTTURNSWITCH_OFFSET 17
#define CAN_MCU_STATUS_RIGHTTURNSWITCH_RANGE 1
#define CAN_MCU_STATUS_RIGHTTURNSWITCH_OFFSET 18
#define CAN_MCU_STATUS_LIGHTSWITCH_RANGE 1
#define CAN_MCU_STATUS_LIGHTSWITCH_OFFSET 19
#define CAN_MCU_STATUS_ASSSWITCH_RANGE 1
#define CAN_MCU_STATUS_ASSSWITCH_OFFSET 20
#define CAN_MCU_STATUS_HORNSWITCH_RANGE 1
#define CAN_MCU_STATUS_HORNSWITCH_OFFSET 21
#define CAN_MCU_STATUS_BATT_VOLTAGE_RANGE 8
#define CAN_MCU_STATUS_BATT_VOLTAGE_OFFSET 22
#define CAN_MCU_STATUS_BATT_CURRENT_RANGE 16
#define CAN_MCU_STATUS_BATT_CURRENT_OFFSET 30
#define CAN_MCU_STATUS_DCDC_CURRENT_RANGE 16
#define CAN_MCU_STATUS_DCDC_CURRENT_OFFSET 46
#define CAN_MCU_STATUS_BATT_FAULT_RANGE 1
#define CAN_MCU_STATUS_BATT_FAULT_OFFSET 62
#define CAN_MCU_STATUS_DCDC_FAULT_RANGE 1
#define CAN_MCU_STATUS_DCDC_FAULT_OFFSET 63

uint8_t CAN_mcu_status_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_mcu_status);
}
uint16_t CAN_mcu_status_heartbeat_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_HEARTBEAT_OFFSET, CAN_MCU_STATUS_HEARTBEAT_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_highBeam_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_HIGHBEAM_OFFSET, CAN_MCU_STATUS_HIGHBEAM_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_lowBeam_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_LOWBEAM_OFFSET, CAN_MCU_STATUS_LOWBEAM_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_brakeLight_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_BRAKELIGHT_OFFSET, CAN_MCU_STATUS_BRAKELIGHT_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_tailLight_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_TAILLIGHT_OFFSET, CAN_MCU_STATUS_TAILLIGHT_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_horn_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_HORN_OFFSET, CAN_MCU_STATUS_HORN_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_turnSignalFR_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_TURNSIGNALFR_OFFSET, CAN_MCU_STATUS_TURNSIGNALFR_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_turnSignalFL_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_TURNSIGNALFL_OFFSET, CAN_MCU_STATUS_TURNSIGNALFL_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_turnSignalRR_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_TURNSIGNALRR_OFFSET, CAN_MCU_STATUS_TURNSIGNALRR_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_turnSignalRL_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_TURNSIGNALRL_OFFSET, CAN_MCU_STATUS_TURNSIGNALRL_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_brakeSwitchFront_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_BRAKESWITCHFRONT_OFFSET, CAN_MCU_STATUS_BRAKESWITCHFRONT_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_brakeSwitchRear_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_BRAKESWITCHREAR_OFFSET, CAN_MCU_STATUS_BRAKESWITCHREAR_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_killSwitch_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_KILLSWITCH_OFFSET, CAN_MCU_STATUS_KILLSWITCH_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_ignitionSwitch_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_IGNITIONSWITCH_OFFSET, CAN_MCU_STATUS_IGNITIONSWITCH_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_leftTurnSwitch_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_LEFTTURNSWITCH_OFFSET, CAN_MCU_STATUS_LEFTTURNSWITCH_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_rightTurnSwitch_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_RIGHTTURNSWITCH_OFFSET, CAN_MCU_STATUS_RIGHTTURNSWITCH_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_lightSwitch_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_LIGHTSWITCH_OFFSET, CAN_MCU_STATUS_LIGHTSWITCH_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_assSwitch_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_ASSSWITCH_OFFSET, CAN_MCU_STATUS_ASSSWITCH_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_hornSwitch_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_HORNSWITCH_OFFSET, CAN_MCU_STATUS_HORNSWITCH_RANGE);
	return (data * 1.0) + 0;
}
float CAN_mcu_status_batt_voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_BATT_VOLTAGE_OFFSET, CAN_MCU_STATUS_BATT_VOLTAGE_RANGE);
	return (data * 0.1) + 0;
}
float CAN_mcu_status_batt_current_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_BATT_CURRENT_OFFSET, CAN_MCU_STATUS_BATT_CURRENT_RANGE);
	return (data * 0.001) + -33;
}
float CAN_mcu_status_dcdc_current_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_DCDC_CURRENT_OFFSET, CAN_MCU_STATUS_DCDC_CURRENT_RANGE);
	return (data * 0.001) + -33;
}
uint16_t CAN_mcu_status_batt_fault_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_BATT_FAULT_OFFSET, CAN_MCU_STATUS_BATT_FAULT_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_status_dcdc_fault_get(void){
	uint16_t data = get_bits((size_t*)CAN_mcu_status.payload, CAN_MCU_STATUS_DCDC_FAULT_OFFSET, CAN_MCU_STATUS_DCDC_FAULT_RANGE);
	return (data * 1.0) + 0;
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
#define CAN_MCU_MCU_DEBUG_M0_DEBUG_VALUE_1_RANGE 8
#define CAN_MCU_MCU_DEBUG_M0_DEBUG_VALUE_1_OFFSET 2
#define CAN_MCU_MCU_DEBUG_M0_DEBUG_VALUE_2_RANGE 8
#define CAN_MCU_MCU_DEBUG_M0_DEBUG_VALUE_2_OFFSET 10
#define CAN_MCU_MCU_DEBUG_M0_DEBUG_VALUE_3_RANGE 8
#define CAN_MCU_MCU_DEBUG_M0_DEBUG_VALUE_3_OFFSET 18
#define CAN_MCU_MCU_DEBUG_M0_DEBUG_VALUE_4_RANGE 8
#define CAN_MCU_MCU_DEBUG_M0_DEBUG_VALUE_4_OFFSET 26
#define CAN_MCU_MCU_DEBUG_M1_DEBUG_VALUE_5_RANGE 8
#define CAN_MCU_MCU_DEBUG_M1_DEBUG_VALUE_5_OFFSET 2
#define CAN_MCU_MCU_DEBUG_M1_DEBUG_VALUE_6_RANGE 8
#define CAN_MCU_MCU_DEBUG_M1_DEBUG_VALUE_6_OFFSET 10
#define CAN_MCU_MCU_DEBUG_M1_DEBUG_VALUE_7_RANGE 8
#define CAN_MCU_MCU_DEBUG_M1_DEBUG_VALUE_7_OFFSET 18
#define CAN_MCU_MCU_DEBUG_M1_DEBUG_VALUE_8_RANGE 8
#define CAN_MCU_MCU_DEBUG_M1_DEBUG_VALUE_8_OFFSET 26
#define CAN_MCU_MCU_DEBUG_M2_DEBUG_VALUE_9_RANGE 8
#define CAN_MCU_MCU_DEBUG_M2_DEBUG_VALUE_9_OFFSET 2
#define CAN_MCU_MCU_DEBUG_M2_DEBUG_VALUE_10_RANGE 8
#define CAN_MCU_MCU_DEBUG_M2_DEBUG_VALUE_10_OFFSET 10
#define CAN_MCU_MCU_DEBUG_M2_DEBUG_VALUE_11_RANGE 8
#define CAN_MCU_MCU_DEBUG_M2_DEBUG_VALUE_11_OFFSET 18
#define CAN_MCU_MCU_DEBUG_M2_DEBUG_VALUE_12_RANGE 8
#define CAN_MCU_MCU_DEBUG_M2_DEBUG_VALUE_12_OFFSET 26
#define CAN_MCU_MCU_DEBUG_M3_DEBUG_VALUE_13_RANGE 8
#define CAN_MCU_MCU_DEBUG_M3_DEBUG_VALUE_13_OFFSET 2
#define CAN_MCU_MCU_DEBUG_M3_DEBUG_VALUE_14_RANGE 8
#define CAN_MCU_MCU_DEBUG_M3_DEBUG_VALUE_14_OFFSET 10
#define CAN_MCU_MCU_DEBUG_M3_DEBUG_VALUE_15_RANGE 8
#define CAN_MCU_MCU_DEBUG_M3_DEBUG_VALUE_15_OFFSET 18
#define CAN_MCU_MCU_DEBUG_M3_DEBUG_VALUE_16_RANGE 8
#define CAN_MCU_MCU_DEBUG_M3_DEBUG_VALUE_16_OFFSET 26

uint8_t CAN_mcu_mcu_debug_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_mcu_mcu_debug);
}
uint16_t CAN_mcu_mcu_debug_Multiplex_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	uint16_t data = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_mcu_debug_M0_debug_value_1_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	uint16_t data = get_bits((size_t*)&CAN_mcu_mcu_debug_payloads[0], CAN_MCU_MCU_DEBUG_M0_DEBUG_VALUE_1_OFFSET, CAN_MCU_MCU_DEBUG_M0_DEBUG_VALUE_1_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_mcu_debug_M0_debug_value_2_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	uint16_t data = get_bits((size_t*)&CAN_mcu_mcu_debug_payloads[0], CAN_MCU_MCU_DEBUG_M0_DEBUG_VALUE_2_OFFSET, CAN_MCU_MCU_DEBUG_M0_DEBUG_VALUE_2_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_mcu_debug_M0_debug_value_3_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	uint16_t data = get_bits((size_t*)&CAN_mcu_mcu_debug_payloads[0], CAN_MCU_MCU_DEBUG_M0_DEBUG_VALUE_3_OFFSET, CAN_MCU_MCU_DEBUG_M0_DEBUG_VALUE_3_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_mcu_debug_M0_debug_value_4_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	uint16_t data = get_bits((size_t*)&CAN_mcu_mcu_debug_payloads[0], CAN_MCU_MCU_DEBUG_M0_DEBUG_VALUE_4_OFFSET, CAN_MCU_MCU_DEBUG_M0_DEBUG_VALUE_4_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_mcu_debug_M1_debug_value_5_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	uint16_t data = get_bits((size_t*)&CAN_mcu_mcu_debug_payloads[1], CAN_MCU_MCU_DEBUG_M1_DEBUG_VALUE_5_OFFSET, CAN_MCU_MCU_DEBUG_M1_DEBUG_VALUE_5_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_mcu_debug_M1_debug_value_6_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	uint16_t data = get_bits((size_t*)&CAN_mcu_mcu_debug_payloads[1], CAN_MCU_MCU_DEBUG_M1_DEBUG_VALUE_6_OFFSET, CAN_MCU_MCU_DEBUG_M1_DEBUG_VALUE_6_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_mcu_debug_M1_debug_value_7_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	uint16_t data = get_bits((size_t*)&CAN_mcu_mcu_debug_payloads[1], CAN_MCU_MCU_DEBUG_M1_DEBUG_VALUE_7_OFFSET, CAN_MCU_MCU_DEBUG_M1_DEBUG_VALUE_7_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_mcu_debug_M1_debug_value_8_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	uint16_t data = get_bits((size_t*)&CAN_mcu_mcu_debug_payloads[1], CAN_MCU_MCU_DEBUG_M1_DEBUG_VALUE_8_OFFSET, CAN_MCU_MCU_DEBUG_M1_DEBUG_VALUE_8_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_mcu_debug_M2_debug_value_9_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	uint16_t data = get_bits((size_t*)&CAN_mcu_mcu_debug_payloads[2], CAN_MCU_MCU_DEBUG_M2_DEBUG_VALUE_9_OFFSET, CAN_MCU_MCU_DEBUG_M2_DEBUG_VALUE_9_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_mcu_debug_M2_debug_value_10_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	uint16_t data = get_bits((size_t*)&CAN_mcu_mcu_debug_payloads[2], CAN_MCU_MCU_DEBUG_M2_DEBUG_VALUE_10_OFFSET, CAN_MCU_MCU_DEBUG_M2_DEBUG_VALUE_10_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_mcu_debug_M2_debug_value_11_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	uint16_t data = get_bits((size_t*)&CAN_mcu_mcu_debug_payloads[2], CAN_MCU_MCU_DEBUG_M2_DEBUG_VALUE_11_OFFSET, CAN_MCU_MCU_DEBUG_M2_DEBUG_VALUE_11_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_mcu_debug_M2_debug_value_12_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	uint16_t data = get_bits((size_t*)&CAN_mcu_mcu_debug_payloads[2], CAN_MCU_MCU_DEBUG_M2_DEBUG_VALUE_12_OFFSET, CAN_MCU_MCU_DEBUG_M2_DEBUG_VALUE_12_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_mcu_debug_M3_debug_value_13_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	uint16_t data = get_bits((size_t*)&CAN_mcu_mcu_debug_payloads[3], CAN_MCU_MCU_DEBUG_M3_DEBUG_VALUE_13_OFFSET, CAN_MCU_MCU_DEBUG_M3_DEBUG_VALUE_13_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_mcu_debug_M3_debug_value_14_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	uint16_t data = get_bits((size_t*)&CAN_mcu_mcu_debug_payloads[3], CAN_MCU_MCU_DEBUG_M3_DEBUG_VALUE_14_OFFSET, CAN_MCU_MCU_DEBUG_M3_DEBUG_VALUE_14_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_mcu_debug_M3_debug_value_15_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	uint16_t data = get_bits((size_t*)&CAN_mcu_mcu_debug_payloads[3], CAN_MCU_MCU_DEBUG_M3_DEBUG_VALUE_15_OFFSET, CAN_MCU_MCU_DEBUG_M3_DEBUG_VALUE_15_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_mcu_mcu_debug_M3_debug_value_16_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_mcu_mcu_debug.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_mcu_mcu_debug.payload, CAN_MCU_MCU_DEBUG_MULTIPLEX_OFFSET, CAN_MCU_MCU_DEBUG_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_mcu_mcu_debug_payloads[mux_value] = *CAN_mcu_mcu_debug.payload;
		}
	}
	
	uint16_t data = get_bits((size_t*)&CAN_mcu_mcu_debug_payloads[3], CAN_MCU_MCU_DEBUG_M3_DEBUG_VALUE_16_OFFSET, CAN_MCU_MCU_DEBUG_M3_DEBUG_VALUE_16_RANGE);
	return (data * 1.0) + 0;
}

/**********************************************************
 * bms NODE MESSAGES
 */
static CAN_payload_S CAN_bms_status_payloads[4] __attribute__((aligned(sizeof(CAN_payload_S))));
static uint8_t CAN_bms_status_mux = 0;
#define CAN_bms_status_ID 0x721

static CAN_message_S CAN_bms_status={
	.canID = CAN_bms_status_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
};

#define CAN_BMS_STATUS_MULTIPLEX_RANGE 2
#define CAN_BMS_STATUS_MULTIPLEX_OFFSET 0
#define CAN_BMS_STATUS_M0_STATE_RANGE 3
#define CAN_BMS_STATUS_M0_STATE_OFFSET 2
#define CAN_BMS_STATUS_M0_SOC_RANGE 8
#define CAN_BMS_STATUS_M0_SOC_OFFSET 5
#define CAN_BMS_STATUS_M0_PACKVOLTAGE_RANGE 16
#define CAN_BMS_STATUS_M0_PACKVOLTAGE_OFFSET 13
#define CAN_BMS_STATUS_M0_PACKCURRENT_RANGE 16
#define CAN_BMS_STATUS_M0_PACKCURRENT_OFFSET 29
#define CAN_BMS_STATUS_M0_MINTEMP_RANGE 9
#define CAN_BMS_STATUS_M0_MINTEMP_OFFSET 45
#define CAN_BMS_STATUS_M0_MAXTEMP_RANGE 10
#define CAN_BMS_STATUS_M0_MAXTEMP_OFFSET 54
#define CAN_BMS_STATUS_M1_STACKVOLTAGE1_RANGE 16
#define CAN_BMS_STATUS_M1_STACKVOLTAGE1_OFFSET 2
#define CAN_BMS_STATUS_M1_STACKVOLTAGE2_RANGE 16
#define CAN_BMS_STATUS_M1_STACKVOLTAGE2_OFFSET 18
#define CAN_BMS_STATUS_M1_PACKVOLTAGESUMOFSTACKS_RANGE 18
#define CAN_BMS_STATUS_M1_PACKVOLTAGESUMOFSTACKS_OFFSET 34
#define CAN_BMS_STATUS_M1_MUX1_SIGNAL4_RANGE 12
#define CAN_BMS_STATUS_M1_MUX1_SIGNAL4_OFFSET 52
#define CAN_BMS_STATUS_M2_MUX2_SIGNAL1_RANGE 16
#define CAN_BMS_STATUS_M2_MUX2_SIGNAL1_OFFSET 2
#define CAN_BMS_STATUS_M2_MUX2_SIGNAL2_RANGE 16
#define CAN_BMS_STATUS_M2_MUX2_SIGNAL2_OFFSET 18
#define CAN_BMS_STATUS_M2_MUX2_SIGNAL3_RANGE 16
#define CAN_BMS_STATUS_M2_MUX2_SIGNAL3_OFFSET 34
#define CAN_BMS_STATUS_M2_MUX2_SIGNAL4_RANGE 14
#define CAN_BMS_STATUS_M2_MUX2_SIGNAL4_OFFSET 50
#define CAN_BMS_STATUS_M3_MUX3_SIGNAL1_RANGE 16
#define CAN_BMS_STATUS_M3_MUX3_SIGNAL1_OFFSET 2
#define CAN_BMS_STATUS_M3_MUX3_SIGNAL2_RANGE 16
#define CAN_BMS_STATUS_M3_MUX3_SIGNAL2_OFFSET 18
#define CAN_BMS_STATUS_M3_MUX3_SIGNAL3_RANGE 16
#define CAN_BMS_STATUS_M3_MUX3_SIGNAL3_OFFSET 34
#define CAN_BMS_STATUS_M3_MUX3_SIGNAL4_RANGE 14
#define CAN_BMS_STATUS_M3_MUX3_SIGNAL4_OFFSET 50

void CAN_bms_status_M0_state_set(uint16_t state){
	uint16_t data_scaled = (state - 0) / 1.0;
	CAN_bms_status_payloads[0].word0 &= ~0x001C;
	CAN_bms_status_payloads[0].word0 |= (data_scaled << 2) & 0x001C;
}
void CAN_bms_status_M0_SOC_set(float SOC){
	uint16_t data_scaled = (uint16_t)((SOC - 0) / 0.5 + 0.5f);
	CAN_bms_status_payloads[0].word0 &= ~0x1FE0;
	CAN_bms_status_payloads[0].word0 |= (data_scaled << 5) & 0x1FE0;
}
void CAN_bms_status_M0_packVoltage_set(float packVoltage){
	uint16_t data_scaled = (uint16_t)((packVoltage - 0) / 0.01 + 0.5f);
	CAN_bms_status_payloads[0].word0 &= ~0xE000;
	CAN_bms_status_payloads[0].word0 |= (data_scaled << 13) & 0xE000;
	CAN_bms_status_payloads[0].word1 &= ~0x1FFF;
	CAN_bms_status_payloads[0].word1 |= (data_scaled >> 3) & 0x1FFF;
}
void CAN_bms_status_M0_packCurrent_set(float packCurrent){
	uint16_t data_scaled = (uint16_t)((packCurrent - 0) / 0.01 + 0.5f);
	CAN_bms_status_payloads[0].word1 &= ~0xE000;
	CAN_bms_status_payloads[0].word1 |= (data_scaled << 13) & 0xE000;
	CAN_bms_status_payloads[0].word2 &= ~0x1FFF;
	CAN_bms_status_payloads[0].word2 |= (data_scaled >> 3) & 0x1FFF;
}
void CAN_bms_status_M0_minTemp_set(float minTemp){
	uint16_t data_scaled = (uint16_t)((minTemp - -40) / 0.2 + 0.5f);
	CAN_bms_status_payloads[0].word2 &= ~0xE000;
	CAN_bms_status_payloads[0].word2 |= (data_scaled << 13) & 0xE000;
	CAN_bms_status_payloads[0].word3 &= ~0x003F;
	CAN_bms_status_payloads[0].word3 |= (data_scaled >> 3) & 0x003F;
}
void CAN_bms_status_M0_maxTemp_set(float maxTemp){
	uint16_t data_scaled = (uint16_t)((maxTemp - -40) / 0.2 + 0.5f);
	CAN_bms_status_payloads[0].word3 &= ~0xFFC0;
	CAN_bms_status_payloads[0].word3 |= (data_scaled << 6) & 0xFFC0;
}
void CAN_bms_status_M1_stackVoltage1_set(float stackVoltage1){
	uint16_t data_scaled = (uint16_t)((stackVoltage1 - 0) / 0.001 + 0.5f);
	CAN_bms_status_payloads[1].word0 &= ~0xFFFC;
	CAN_bms_status_payloads[1].word0 |= (data_scaled << 2) & 0xFFFC;
	CAN_bms_status_payloads[1].word1 &= ~0x0003;
	CAN_bms_status_payloads[1].word1 |= (data_scaled >> 14) & 0x0003;
}
void CAN_bms_status_M1_stackVoltage2_set(float stackVoltage2){
	uint16_t data_scaled = (uint16_t)((stackVoltage2 - 0) / 0.001 + 0.5f);
	CAN_bms_status_payloads[1].word1 &= ~0xFFFC;
	CAN_bms_status_payloads[1].word1 |= (data_scaled << 2) & 0xFFFC;
	CAN_bms_status_payloads[1].word2 &= ~0x0003;
	CAN_bms_status_payloads[1].word2 |= (data_scaled >> 14) & 0x0003;
}
void CAN_bms_status_M1_packVoltageSumOfStacks_set(float packVoltageSumOfStacks){
	uint32_t data_scaled = (uint32_t)((packVoltageSumOfStacks - 0) / 0.001 + 0.5f);
	CAN_bms_status_payloads[1].word2 &= ~0xFFFC;
	CAN_bms_status_payloads[1].word2 |= (data_scaled << 2) & 0xFFFC;
	CAN_bms_status_payloads[1].word3 &= ~0x000F;
	CAN_bms_status_payloads[1].word3 |= (data_scaled >> 14) & 0x000F;
}
void CAN_bms_status_M1_mux1_signal4_set(uint16_t mux1_signal4){
	uint16_t data_scaled = (mux1_signal4 - 0) / 1.0;
	CAN_bms_status_payloads[1].word3 &= ~0xFFF0;
	CAN_bms_status_payloads[1].word3 |= (data_scaled << 4) & 0xFFF0;
}
void CAN_bms_status_M2_mux2_signal1_set(uint16_t mux2_signal1){
	uint16_t data_scaled = (mux2_signal1 - 0) / 1.0;
	CAN_bms_status_payloads[2].word0 &= ~0xFFFC;
	CAN_bms_status_payloads[2].word0 |= (data_scaled << 2) & 0xFFFC;
	CAN_bms_status_payloads[2].word1 &= ~0x0003;
	CAN_bms_status_payloads[2].word1 |= (data_scaled >> 14) & 0x0003;
}
void CAN_bms_status_M2_mux2_signal2_set(uint16_t mux2_signal2){
	uint16_t data_scaled = (mux2_signal2 - 0) / 1.0;
	CAN_bms_status_payloads[2].word1 &= ~0xFFFC;
	CAN_bms_status_payloads[2].word1 |= (data_scaled << 2) & 0xFFFC;
	CAN_bms_status_payloads[2].word2 &= ~0x0003;
	CAN_bms_status_payloads[2].word2 |= (data_scaled >> 14) & 0x0003;
}
void CAN_bms_status_M2_mux2_signal3_set(uint16_t mux2_signal3){
	uint16_t data_scaled = (mux2_signal3 - 0) / 1.0;
	CAN_bms_status_payloads[2].word2 &= ~0xFFFC;
	CAN_bms_status_payloads[2].word2 |= (data_scaled << 2) & 0xFFFC;
	CAN_bms_status_payloads[2].word3 &= ~0x0003;
	CAN_bms_status_payloads[2].word3 |= (data_scaled >> 14) & 0x0003;
}
void CAN_bms_status_M2_mux2_signal4_set(uint16_t mux2_signal4){
	uint16_t data_scaled = (mux2_signal4 - 0) / 1.0;
	CAN_bms_status_payloads[2].word3 &= ~0xFFFC;
	CAN_bms_status_payloads[2].word3 |= (data_scaled << 2) & 0xFFFC;
}
void CAN_bms_status_M3_mux3_signal1_set(uint16_t mux3_signal1){
	uint16_t data_scaled = (mux3_signal1 - 0) / 1.0;
	CAN_bms_status_payloads[3].word0 &= ~0xFFFC;
	CAN_bms_status_payloads[3].word0 |= (data_scaled << 2) & 0xFFFC;
	CAN_bms_status_payloads[3].word1 &= ~0x0003;
	CAN_bms_status_payloads[3].word1 |= (data_scaled >> 14) & 0x0003;
}
void CAN_bms_status_M3_mux3_signal2_set(uint16_t mux3_signal2){
	uint16_t data_scaled = (mux3_signal2 - 0) / 1.0;
	CAN_bms_status_payloads[3].word1 &= ~0xFFFC;
	CAN_bms_status_payloads[3].word1 |= (data_scaled << 2) & 0xFFFC;
	CAN_bms_status_payloads[3].word2 &= ~0x0003;
	CAN_bms_status_payloads[3].word2 |= (data_scaled >> 14) & 0x0003;
}
void CAN_bms_status_M3_mux3_signal3_set(uint16_t mux3_signal3){
	uint16_t data_scaled = (mux3_signal3 - 0) / 1.0;
	CAN_bms_status_payloads[3].word2 &= ~0xFFFC;
	CAN_bms_status_payloads[3].word2 |= (data_scaled << 2) & 0xFFFC;
	CAN_bms_status_payloads[3].word3 &= ~0x0003;
	CAN_bms_status_payloads[3].word3 |= (data_scaled >> 14) & 0x0003;
}
void CAN_bms_status_M3_mux3_signal4_set(uint16_t mux3_signal4){
	uint16_t data_scaled = (mux3_signal4 - 0) / 1.0;
	CAN_bms_status_payloads[3].word3 &= ~0xFFFC;
	CAN_bms_status_payloads[3].word3 |= (data_scaled << 2) & 0xFFFC;
}
void CAN_bms_status_dlc_set(uint8_t dlc){
	CAN_bms_status.dlc = dlc;
}
void CAN_bms_status_send(void){
	// Auto-select current mux payload
	CAN_bms_status.payload = &CAN_bms_status_payloads[CAN_bms_status_mux];
	// Send the message
	CAN_write(CAN_bms_status);
	// Increment mux counter for next time
	CAN_bms_status_mux++;
	if (CAN_bms_status_mux >= CAN_BMS_STATUS_NUM_MUX_VALUES) {
		CAN_bms_status_mux = 0;
	}
}

static CAN_payload_S CAN_bms_status_2_payload __attribute__((aligned(sizeof(CAN_payload_S))));
#define CAN_bms_status_2_ID 0x722

static CAN_message_S CAN_bms_status_2={
	.canID = CAN_bms_status_2_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = &CAN_bms_status_2_payload,
	.canMessageStatus = 0
};

#define CAN_BMS_STATUS_2_DCDC_STATE_RANGE 1
#define CAN_BMS_STATUS_2_DCDC_STATE_OFFSET 0
#define CAN_BMS_STATUS_2_DCDC_FAULT_RANGE 1
#define CAN_BMS_STATUS_2_DCDC_FAULT_OFFSET 1
#define CAN_BMS_STATUS_2_DCDC_VOLTAGE_RANGE 10
#define CAN_BMS_STATUS_2_DCDC_VOLTAGE_OFFSET 2
#define CAN_BMS_STATUS_2_DCDC_CURRENT_RANGE 10
#define CAN_BMS_STATUS_2_DCDC_CURRENT_OFFSET 12
#define CAN_BMS_STATUS_2_EV_CHARGER_STATE_RANGE 1
#define CAN_BMS_STATUS_2_EV_CHARGER_STATE_OFFSET 22
#define CAN_BMS_STATUS_2_EV_CHARGER_FAULT_RANGE 1
#define CAN_BMS_STATUS_2_EV_CHARGER_FAULT_OFFSET 23
#define CAN_BMS_STATUS_2_EV_CHARGER_VOLTAGE_RANGE 10
#define CAN_BMS_STATUS_2_EV_CHARGER_VOLTAGE_OFFSET 24
#define CAN_BMS_STATUS_2_EV_CHARGER_CURRENT_RANGE 10
#define CAN_BMS_STATUS_2_EV_CHARGER_CURRENT_OFFSET 34
#define CAN_BMS_STATUS_2_HV_PRECHARGE_STATE_RANGE 1
#define CAN_BMS_STATUS_2_HV_PRECHARGE_STATE_OFFSET 44
#define CAN_BMS_STATUS_2_HV_ISOLATION_VOLTAGE_RANGE 10
#define CAN_BMS_STATUS_2_HV_ISOLATION_VOLTAGE_OFFSET 45
#define CAN_BMS_STATUS_2_HV_CONTACTOR_STATE_RANGE 1
#define CAN_BMS_STATUS_2_HV_CONTACTOR_STATE_OFFSET 55

void CAN_bms_status_2_DCDC_state_set(uint16_t DCDC_state){
	uint16_t data_scaled = (DCDC_state - 0) / 1.0;
	CAN_bms_status_2.payload->word0 &= ~0x0001;
	CAN_bms_status_2.payload->word0 |= (data_scaled << 0) & 0x0001;
}
void CAN_bms_status_2_DCDC_fault_set(uint16_t DCDC_fault){
	uint16_t data_scaled = (DCDC_fault - 0) / 1.0;
	CAN_bms_status_2.payload->word0 &= ~0x0002;
	CAN_bms_status_2.payload->word0 |= (data_scaled << 1) & 0x0002;
}
void CAN_bms_status_2_DCDC_voltage_set(float DCDC_voltage){
	uint16_t data_scaled = (uint16_t)((DCDC_voltage - 0) / 0.1 + 0.5f);
	CAN_bms_status_2.payload->word0 &= ~0x0FFC;
	CAN_bms_status_2.payload->word0 |= (data_scaled << 2) & 0x0FFC;
}
void CAN_bms_status_2_DCDC_current_set(float DCDC_current){
	uint16_t data_scaled = (uint16_t)((DCDC_current - 0) / 0.1 + 0.5f);
	CAN_bms_status_2.payload->word0 &= ~0xF000;
	CAN_bms_status_2.payload->word0 |= (data_scaled << 12) & 0xF000;
	CAN_bms_status_2.payload->word1 &= ~0x003F;
	CAN_bms_status_2.payload->word1 |= (data_scaled >> 4) & 0x003F;
}
void CAN_bms_status_2_EV_charger_state_set(uint16_t EV_charger_state){
	uint16_t data_scaled = (EV_charger_state - 0) / 1.0;
	CAN_bms_status_2.payload->word1 &= ~0x0040;
	CAN_bms_status_2.payload->word1 |= (data_scaled << 6) & 0x0040;
}
void CAN_bms_status_2_EV_charger_fault_set(uint16_t EV_charger_fault){
	uint16_t data_scaled = (EV_charger_fault - 0) / 1.0;
	CAN_bms_status_2.payload->word1 &= ~0x0080;
	CAN_bms_status_2.payload->word1 |= (data_scaled << 7) & 0x0080;
}
void CAN_bms_status_2_EV_charger_voltage_set(float EV_charger_voltage){
	uint16_t data_scaled = (uint16_t)((EV_charger_voltage - 0) / 0.1 + 0.5f);
	CAN_bms_status_2.payload->word1 &= ~0xFF00;
	CAN_bms_status_2.payload->word1 |= (data_scaled << 8) & 0xFF00;
	CAN_bms_status_2.payload->word2 &= ~0x0003;
	CAN_bms_status_2.payload->word2 |= (data_scaled >> 8) & 0x0003;
}
void CAN_bms_status_2_EV_charger_current_set(float EV_charger_current){
	uint16_t data_scaled = (uint16_t)((EV_charger_current - -50) / 0.1 + 0.5f);
	CAN_bms_status_2.payload->word2 &= ~0x0FFC;
	CAN_bms_status_2.payload->word2 |= (data_scaled << 2) & 0x0FFC;
}
void CAN_bms_status_2_HV_precharge_state_set(uint16_t HV_precharge_state){
	uint16_t data_scaled = (HV_precharge_state - 0) / 1.0;
	CAN_bms_status_2.payload->word2 &= ~0x1000;
	CAN_bms_status_2.payload->word2 |= (data_scaled << 12) & 0x1000;
}
void CAN_bms_status_2_HV_isolation_voltage_set(float HV_isolation_voltage){
	uint16_t data_scaled = (uint16_t)((HV_isolation_voltage - 0) / 0.1 + 0.5f);
	CAN_bms_status_2.payload->word2 &= ~0xE000;
	CAN_bms_status_2.payload->word2 |= (data_scaled << 13) & 0xE000;
	CAN_bms_status_2.payload->word3 &= ~0x007F;
	CAN_bms_status_2.payload->word3 |= (data_scaled >> 3) & 0x007F;
}
void CAN_bms_status_2_HV_contactor_state_set(uint16_t HV_contactor_state){
	uint16_t data_scaled = (HV_contactor_state - 0) / 1.0;
	CAN_bms_status_2.payload->word3 &= ~0x0080;
	CAN_bms_status_2.payload->word3 |= (data_scaled << 7) & 0x0080;
}
void CAN_bms_status_2_dlc_set(uint8_t dlc){
	CAN_bms_status_2.dlc = dlc;
}
void CAN_bms_status_2_send(void){
	CAN_write(CAN_bms_status_2);
}

static CAN_payload_S CAN_bms_debug_payload __attribute__((aligned(sizeof(CAN_payload_S))));
#define CAN_bms_debug_ID 0x723

static CAN_message_S CAN_bms_debug={
	.canID = CAN_bms_debug_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = &CAN_bms_debug_payload,
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

void CAN_bms_debug_bool0_set(uint16_t bool0){
	uint16_t data_scaled = (bool0 - 0) / 1.0;
	CAN_bms_debug.payload->word0 &= ~0x0001;
	CAN_bms_debug.payload->word0 |= (data_scaled << 0) & 0x0001;
}
void CAN_bms_debug_bool1_set(uint16_t bool1){
	uint16_t data_scaled = (bool1 - 0) / 1.0;
	CAN_bms_debug.payload->word0 &= ~0x0002;
	CAN_bms_debug.payload->word0 |= (data_scaled << 1) & 0x0002;
}
void CAN_bms_debug_float1_set(float float1){
	uint16_t data_scaled = (uint16_t)((float1 - 0) / 0.01 + 0.5f);
	CAN_bms_debug.payload->word0 &= ~0xFFFC;
	CAN_bms_debug.payload->word0 |= (data_scaled << 2) & 0xFFFC;
	CAN_bms_debug.payload->word1 &= ~0x0003;
	CAN_bms_debug.payload->word1 |= (data_scaled >> 14) & 0x0003;
}
void CAN_bms_debug_float2_set(float float2){
	uint16_t data_scaled = (uint16_t)((float2 - 0) / 0.01 + 0.5f);
	CAN_bms_debug.payload->word1 &= ~0xFFFC;
	CAN_bms_debug.payload->word1 |= (data_scaled << 2) & 0xFFFC;
	CAN_bms_debug.payload->word2 &= ~0x0003;
	CAN_bms_debug.payload->word2 |= (data_scaled >> 14) & 0x0003;
}
void CAN_bms_debug_VBUS_Voltage_set(float VBUS_Voltage){
	uint16_t data_scaled = (uint16_t)((VBUS_Voltage - 0) / 0.1 + 0.5f);
	CAN_bms_debug.payload->word2 &= ~0x0FFC;
	CAN_bms_debug.payload->word2 |= (data_scaled << 2) & 0x0FFC;
}
void CAN_bms_debug_CPU_USAGE_set(float CPU_USAGE){
	uint16_t data_scaled = (uint16_t)((CPU_USAGE - 0) / 0.1 + 0.5f);
	CAN_bms_debug.payload->word2 &= ~0xF000;
	CAN_bms_debug.payload->word2 |= (data_scaled << 12) & 0xF000;
	CAN_bms_debug.payload->word3 &= ~0x003F;
	CAN_bms_debug.payload->word3 |= (data_scaled >> 4) & 0x003F;
}
void CAN_bms_debug_CPU_peak_set(float CPU_peak){
	uint16_t data_scaled = (uint16_t)((CPU_peak - 0) / 0.1 + 0.5f);
	CAN_bms_debug.payload->word3 &= ~0xFFC0;
	CAN_bms_debug.payload->word3 |= (data_scaled << 6) & 0xFFC0;
}
void CAN_bms_debug_dlc_set(uint8_t dlc){
	CAN_bms_debug.dlc = dlc;
}
void CAN_bms_debug_send(void){
	CAN_write(CAN_bms_debug);
}

static CAN_payload_S CAN_bms_boot_response_payload __attribute__((aligned(sizeof(CAN_payload_S))));
#define CAN_bms_boot_response_ID 0xa2

static CAN_message_S CAN_bms_boot_response={
	.canID = CAN_bms_boot_response_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = &CAN_bms_boot_response_payload,
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

void CAN_bms_boot_response_type_set(uint16_t type){
	uint16_t data_scaled = (type - 0) / 1.0;
	CAN_bms_boot_response.payload->word0 &= ~0x000F;
	CAN_bms_boot_response.payload->word0 |= (data_scaled << 0) & 0x000F;
}
void CAN_bms_boot_response_code_set(uint16_t code){
	uint16_t data_scaled = (code - 0) / 1.0;
	CAN_bms_boot_response.payload->word0 &= ~0x00F0;
	CAN_bms_boot_response.payload->word0 |= (data_scaled << 4) & 0x00F0;
}
void CAN_bms_boot_response_byte1_set(uint16_t byte1){
	uint16_t data_scaled = (byte1 - 0) / 1.0;
	CAN_bms_boot_response.payload->word0 &= ~0xFF00;
	CAN_bms_boot_response.payload->word0 |= (data_scaled << 8) & 0xFF00;
}
void CAN_bms_boot_response_byte2_set(uint16_t byte2){
	uint16_t data_scaled = (byte2 - 0) / 1.0;
	CAN_bms_boot_response.payload->word1 &= ~0x00FF;
	CAN_bms_boot_response.payload->word1 |= (data_scaled << 0) & 0x00FF;
}
void CAN_bms_boot_response_byte3_set(uint16_t byte3){
	uint16_t data_scaled = (byte3 - 0) / 1.0;
	CAN_bms_boot_response.payload->word1 &= ~0xFF00;
	CAN_bms_boot_response.payload->word1 |= (data_scaled << 8) & 0xFF00;
}
void CAN_bms_boot_response_byte4_set(uint16_t byte4){
	uint16_t data_scaled = (byte4 - 0) / 1.0;
	CAN_bms_boot_response.payload->word2 &= ~0x00FF;
	CAN_bms_boot_response.payload->word2 |= (data_scaled << 0) & 0x00FF;
}
void CAN_bms_boot_response_byte5_set(uint16_t byte5){
	uint16_t data_scaled = (byte5 - 0) / 1.0;
	CAN_bms_boot_response.payload->word2 &= ~0xFF00;
	CAN_bms_boot_response.payload->word2 |= (data_scaled << 8) & 0xFF00;
}
void CAN_bms_boot_response_byte6_set(uint16_t byte6){
	uint16_t data_scaled = (byte6 - 0) / 1.0;
	CAN_bms_boot_response.payload->word3 &= ~0x00FF;
	CAN_bms_boot_response.payload->word3 |= (data_scaled << 0) & 0x00FF;
}
void CAN_bms_boot_response_byte7_set(uint16_t byte7){
	uint16_t data_scaled = (byte7 - 0) / 1.0;
	CAN_bms_boot_response.payload->word3 &= ~0xFF00;
	CAN_bms_boot_response.payload->word3 |= (data_scaled << 8) & 0xFF00;
}
void CAN_bms_boot_response_dlc_set(uint8_t dlc){
	CAN_bms_boot_response.dlc = dlc;
}
void CAN_bms_boot_response_send(void){
	CAN_write(CAN_bms_boot_response);
}

static CAN_payload_S CAN_bms_charger_request_payload __attribute__((aligned(sizeof(CAN_payload_S))));
#define CAN_bms_charger_request_ID 0x1806e5f4

static CAN_message_S CAN_bms_charger_request={
	.canID = CAN_bms_charger_request_ID,
	.canXID = 1,
	.dlc = 8,
	.payload = &CAN_bms_charger_request_payload,
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

void CAN_bms_charger_request_output_voltage_high_byte_set(uint16_t output_voltage_high_byte){
	uint16_t data_scaled = (output_voltage_high_byte - 0) / 1.0;
	CAN_bms_charger_request.payload->word0 &= ~0x00FF;
	CAN_bms_charger_request.payload->word0 |= (data_scaled << 0) & 0x00FF;
}
void CAN_bms_charger_request_output_voltage_low_byte_set(uint16_t output_voltage_low_byte){
	uint16_t data_scaled = (output_voltage_low_byte - 0) / 1.0;
	CAN_bms_charger_request.payload->word0 &= ~0xFF00;
	CAN_bms_charger_request.payload->word0 |= (data_scaled << 8) & 0xFF00;
}
void CAN_bms_charger_request_output_current_high_byte_set(uint16_t output_current_high_byte){
	uint16_t data_scaled = (output_current_high_byte - 0) / 1.0;
	CAN_bms_charger_request.payload->word1 &= ~0x00FF;
	CAN_bms_charger_request.payload->word1 |= (data_scaled << 0) & 0x00FF;
}
void CAN_bms_charger_request_output_current_low_byte_set(uint16_t output_current_low_byte){
	uint16_t data_scaled = (output_current_low_byte - 0) / 1.0;
	CAN_bms_charger_request.payload->word1 &= ~0xFF00;
	CAN_bms_charger_request.payload->word1 |= (data_scaled << 8) & 0xFF00;
}
void CAN_bms_charger_request_start_charge_not_request_set(uint16_t start_charge_not_request){
	uint16_t data_scaled = (start_charge_not_request - 0) / 1.0;
	CAN_bms_charger_request.payload->word2 &= ~0x00FF;
	CAN_bms_charger_request.payload->word2 |= (data_scaled << 0) & 0x00FF;
}
void CAN_bms_charger_request_charge_mode_set(uint16_t charge_mode){
	uint16_t data_scaled = (charge_mode - 0) / 1.0;
	CAN_bms_charger_request.payload->word2 &= ~0xFF00;
	CAN_bms_charger_request.payload->word2 |= (data_scaled << 8) & 0xFF00;
}
void CAN_bms_charger_request_byte_7_set(uint16_t byte_7){
	uint16_t data_scaled = (byte_7 - 0) / 1.0;
	CAN_bms_charger_request.payload->word3 &= ~0x00FF;
	CAN_bms_charger_request.payload->word3 |= (data_scaled << 0) & 0x00FF;
}
void CAN_bms_charger_request_byte_8_set(uint16_t byte_8){
	uint16_t data_scaled = (byte_8 - 0) / 1.0;
	CAN_bms_charger_request.payload->word3 &= ~0xFF00;
	CAN_bms_charger_request.payload->word3 |= (data_scaled << 8) & 0xFF00;
}
void CAN_bms_charger_request_dlc_set(uint8_t dlc){
	CAN_bms_charger_request.dlc = dlc;
}
void CAN_bms_charger_request_send(void){
	CAN_write(CAN_bms_charger_request);
}

static CAN_payload_S CAN_bms_cellVoltages_payloads[6] __attribute__((aligned(sizeof(CAN_payload_S))));
static uint8_t CAN_bms_cellVoltages_mux = 0;
#define CAN_bms_cellVoltages_ID 0x725

static CAN_message_S CAN_bms_cellVoltages={
	.canID = CAN_bms_cellVoltages_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
};

#define CAN_BMS_CELLVOLTAGES_MULTIPLEX_RANGE 4
#define CAN_BMS_CELLVOLTAGES_MULTIPLEX_OFFSET 0
#define CAN_BMS_CELLVOLTAGES_M0_CELL_1_VOLTAGE_RANGE 15
#define CAN_BMS_CELLVOLTAGES_M0_CELL_1_VOLTAGE_OFFSET 4
#define CAN_BMS_CELLVOLTAGES_M0_CELL_2_VOLTAGE_RANGE 15
#define CAN_BMS_CELLVOLTAGES_M0_CELL_2_VOLTAGE_OFFSET 19
#define CAN_BMS_CELLVOLTAGES_M0_CELL_3_VOLTAGE_RANGE 15
#define CAN_BMS_CELLVOLTAGES_M0_CELL_3_VOLTAGE_OFFSET 34
#define CAN_BMS_CELLVOLTAGES_M0_CELL_4_VOLTAGE_RANGE 15
#define CAN_BMS_CELLVOLTAGES_M0_CELL_4_VOLTAGE_OFFSET 49
#define CAN_BMS_CELLVOLTAGES_M1_CELL_5_VOLTAGE_RANGE 15
#define CAN_BMS_CELLVOLTAGES_M1_CELL_5_VOLTAGE_OFFSET 4
#define CAN_BMS_CELLVOLTAGES_M1_CELL_6_VOLTAGE_RANGE 15
#define CAN_BMS_CELLVOLTAGES_M1_CELL_6_VOLTAGE_OFFSET 19
#define CAN_BMS_CELLVOLTAGES_M1_CELL_7_VOLTAGE_RANGE 15
#define CAN_BMS_CELLVOLTAGES_M1_CELL_7_VOLTAGE_OFFSET 34
#define CAN_BMS_CELLVOLTAGES_M1_CELL_8_VOLTAGE_RANGE 15
#define CAN_BMS_CELLVOLTAGES_M1_CELL_8_VOLTAGE_OFFSET 49
#define CAN_BMS_CELLVOLTAGES_M2_CELL_9_VOLTAGE_RANGE 15
#define CAN_BMS_CELLVOLTAGES_M2_CELL_9_VOLTAGE_OFFSET 4
#define CAN_BMS_CELLVOLTAGES_M2_CELL_10_VOLTAGE_RANGE 15
#define CAN_BMS_CELLVOLTAGES_M2_CELL_10_VOLTAGE_OFFSET 19
#define CAN_BMS_CELLVOLTAGES_M2_CELL_11_VOLTAGE_RANGE 15
#define CAN_BMS_CELLVOLTAGES_M2_CELL_11_VOLTAGE_OFFSET 34
#define CAN_BMS_CELLVOLTAGES_M2_CELL_12_VOLTAGE_RANGE 15
#define CAN_BMS_CELLVOLTAGES_M2_CELL_12_VOLTAGE_OFFSET 49
#define CAN_BMS_CELLVOLTAGES_M3_CELL_13_VOLTAGE_RANGE 15
#define CAN_BMS_CELLVOLTAGES_M3_CELL_13_VOLTAGE_OFFSET 4
#define CAN_BMS_CELLVOLTAGES_M3_CELL_14_VOLTAGE_RANGE 15
#define CAN_BMS_CELLVOLTAGES_M3_CELL_14_VOLTAGE_OFFSET 19
#define CAN_BMS_CELLVOLTAGES_M3_CELL_15_VOLTAGE_RANGE 15
#define CAN_BMS_CELLVOLTAGES_M3_CELL_15_VOLTAGE_OFFSET 34
#define CAN_BMS_CELLVOLTAGES_M3_CELL_16_VOLTAGE_RANGE 15
#define CAN_BMS_CELLVOLTAGES_M3_CELL_16_VOLTAGE_OFFSET 49
#define CAN_BMS_CELLVOLTAGES_M4_CELL_17_VOLTAGE_RANGE 15
#define CAN_BMS_CELLVOLTAGES_M4_CELL_17_VOLTAGE_OFFSET 4
#define CAN_BMS_CELLVOLTAGES_M4_CELL_18_VOLTAGE_RANGE 15
#define CAN_BMS_CELLVOLTAGES_M4_CELL_18_VOLTAGE_OFFSET 19
#define CAN_BMS_CELLVOLTAGES_M4_CELL_19_VOLTAGE_RANGE 15
#define CAN_BMS_CELLVOLTAGES_M4_CELL_19_VOLTAGE_OFFSET 34
#define CAN_BMS_CELLVOLTAGES_M4_CELL_20_VOLTAGE_RANGE 15
#define CAN_BMS_CELLVOLTAGES_M4_CELL_20_VOLTAGE_OFFSET 49
#define CAN_BMS_CELLVOLTAGES_M5_CELL_21_VOLTAGE_RANGE 15
#define CAN_BMS_CELLVOLTAGES_M5_CELL_21_VOLTAGE_OFFSET 4
#define CAN_BMS_CELLVOLTAGES_M5_CELL_22_VOLTAGE_RANGE 15
#define CAN_BMS_CELLVOLTAGES_M5_CELL_22_VOLTAGE_OFFSET 19
#define CAN_BMS_CELLVOLTAGES_M5_CELL_23_VOLTAGE_RANGE 15
#define CAN_BMS_CELLVOLTAGES_M5_CELL_23_VOLTAGE_OFFSET 34
#define CAN_BMS_CELLVOLTAGES_M5_CELL_24_VOLTAGE_RANGE 15
#define CAN_BMS_CELLVOLTAGES_M5_CELL_24_VOLTAGE_OFFSET 49

void CAN_bms_cellVoltages_M0_cell_1_voltage_set(uint16_t cell_1_voltage){
	uint16_t data_scaled = (cell_1_voltage - 0) / 1;
	CAN_bms_cellVoltages_payloads[0].word0 &= ~0xFFF0;
	CAN_bms_cellVoltages_payloads[0].word0 |= (data_scaled << 4) & 0xFFF0;
	CAN_bms_cellVoltages_payloads[0].word1 &= ~0x0007;
	CAN_bms_cellVoltages_payloads[0].word1 |= (data_scaled >> 12) & 0x0007;
}
void CAN_bms_cellVoltages_M0_cell_2_voltage_set(uint16_t cell_2_voltage){
	uint16_t data_scaled = (cell_2_voltage - 0) / 1;
	CAN_bms_cellVoltages_payloads[0].word1 &= ~0xFFF8;
	CAN_bms_cellVoltages_payloads[0].word1 |= (data_scaled << 3) & 0xFFF8;
	CAN_bms_cellVoltages_payloads[0].word2 &= ~0x0003;
	CAN_bms_cellVoltages_payloads[0].word2 |= (data_scaled >> 13) & 0x0003;
}
void CAN_bms_cellVoltages_M0_cell_3_voltage_set(uint16_t cell_3_voltage){
	uint16_t data_scaled = (cell_3_voltage - 0) / 1;
	CAN_bms_cellVoltages_payloads[0].word2 &= ~0xFFFC;
	CAN_bms_cellVoltages_payloads[0].word2 |= (data_scaled << 2) & 0xFFFC;
	CAN_bms_cellVoltages_payloads[0].word3 &= ~0x0001;
	CAN_bms_cellVoltages_payloads[0].word3 |= (data_scaled >> 14) & 0x0001;
}
void CAN_bms_cellVoltages_M0_cell_4_voltage_set(uint16_t cell_4_voltage){
	uint16_t data_scaled = (cell_4_voltage - 0) / 1;
	CAN_bms_cellVoltages_payloads[0].word3 &= ~0xFFFE;
	CAN_bms_cellVoltages_payloads[0].word3 |= (data_scaled << 1) & 0xFFFE;
}
void CAN_bms_cellVoltages_M1_cell_5_voltage_set(uint16_t cell_5_voltage){
	uint16_t data_scaled = (cell_5_voltage - 0) / 1;
	CAN_bms_cellVoltages_payloads[1].word0 &= ~0xFFF0;
	CAN_bms_cellVoltages_payloads[1].word0 |= (data_scaled << 4) & 0xFFF0;
	CAN_bms_cellVoltages_payloads[1].word1 &= ~0x0007;
	CAN_bms_cellVoltages_payloads[1].word1 |= (data_scaled >> 12) & 0x0007;
}
void CAN_bms_cellVoltages_M1_cell_6_voltage_set(uint16_t cell_6_voltage){
	uint16_t data_scaled = (cell_6_voltage - 0) / 1;
	CAN_bms_cellVoltages_payloads[1].word1 &= ~0xFFF8;
	CAN_bms_cellVoltages_payloads[1].word1 |= (data_scaled << 3) & 0xFFF8;
	CAN_bms_cellVoltages_payloads[1].word2 &= ~0x0003;
	CAN_bms_cellVoltages_payloads[1].word2 |= (data_scaled >> 13) & 0x0003;
}
void CAN_bms_cellVoltages_M1_cell_7_voltage_set(uint16_t cell_7_voltage){
	uint16_t data_scaled = (cell_7_voltage - 0) / 1;
	CAN_bms_cellVoltages_payloads[1].word2 &= ~0xFFFC;
	CAN_bms_cellVoltages_payloads[1].word2 |= (data_scaled << 2) & 0xFFFC;
	CAN_bms_cellVoltages_payloads[1].word3 &= ~0x0001;
	CAN_bms_cellVoltages_payloads[1].word3 |= (data_scaled >> 14) & 0x0001;
}
void CAN_bms_cellVoltages_M1_cell_8_voltage_set(uint16_t cell_8_voltage){
	uint16_t data_scaled = (cell_8_voltage - 0) / 1;
	CAN_bms_cellVoltages_payloads[1].word3 &= ~0xFFFE;
	CAN_bms_cellVoltages_payloads[1].word3 |= (data_scaled << 1) & 0xFFFE;
}
void CAN_bms_cellVoltages_M2_cell_9_voltage_set(uint16_t cell_9_voltage){
	uint16_t data_scaled = (cell_9_voltage - 0) / 1;
	CAN_bms_cellVoltages_payloads[2].word0 &= ~0xFFF0;
	CAN_bms_cellVoltages_payloads[2].word0 |= (data_scaled << 4) & 0xFFF0;
	CAN_bms_cellVoltages_payloads[2].word1 &= ~0x0007;
	CAN_bms_cellVoltages_payloads[2].word1 |= (data_scaled >> 12) & 0x0007;
}
void CAN_bms_cellVoltages_M2_cell_10_voltage_set(uint16_t cell_10_voltage){
	uint16_t data_scaled = (cell_10_voltage - 0) / 1;
	CAN_bms_cellVoltages_payloads[2].word1 &= ~0xFFF8;
	CAN_bms_cellVoltages_payloads[2].word1 |= (data_scaled << 3) & 0xFFF8;
	CAN_bms_cellVoltages_payloads[2].word2 &= ~0x0003;
	CAN_bms_cellVoltages_payloads[2].word2 |= (data_scaled >> 13) & 0x0003;
}
void CAN_bms_cellVoltages_M2_cell_11_voltage_set(uint16_t cell_11_voltage){
	uint16_t data_scaled = (cell_11_voltage - 0) / 1;
	CAN_bms_cellVoltages_payloads[2].word2 &= ~0xFFFC;
	CAN_bms_cellVoltages_payloads[2].word2 |= (data_scaled << 2) & 0xFFFC;
	CAN_bms_cellVoltages_payloads[2].word3 &= ~0x0001;
	CAN_bms_cellVoltages_payloads[2].word3 |= (data_scaled >> 14) & 0x0001;
}
void CAN_bms_cellVoltages_M2_cell_12_voltage_set(uint16_t cell_12_voltage){
	uint16_t data_scaled = (cell_12_voltage - 0) / 1;
	CAN_bms_cellVoltages_payloads[2].word3 &= ~0xFFFE;
	CAN_bms_cellVoltages_payloads[2].word3 |= (data_scaled << 1) & 0xFFFE;
}
void CAN_bms_cellVoltages_M3_cell_13_voltage_set(uint16_t cell_13_voltage){
	uint16_t data_scaled = (cell_13_voltage - 0) / 1;
	CAN_bms_cellVoltages_payloads[3].word0 &= ~0xFFF0;
	CAN_bms_cellVoltages_payloads[3].word0 |= (data_scaled << 4) & 0xFFF0;
	CAN_bms_cellVoltages_payloads[3].word1 &= ~0x0007;
	CAN_bms_cellVoltages_payloads[3].word1 |= (data_scaled >> 12) & 0x0007;
}
void CAN_bms_cellVoltages_M3_cell_14_voltage_set(uint16_t cell_14_voltage){
	uint16_t data_scaled = (cell_14_voltage - 0) / 1;
	CAN_bms_cellVoltages_payloads[3].word1 &= ~0xFFF8;
	CAN_bms_cellVoltages_payloads[3].word1 |= (data_scaled << 3) & 0xFFF8;
	CAN_bms_cellVoltages_payloads[3].word2 &= ~0x0003;
	CAN_bms_cellVoltages_payloads[3].word2 |= (data_scaled >> 13) & 0x0003;
}
void CAN_bms_cellVoltages_M3_cell_15_voltage_set(uint16_t cell_15_voltage){
	uint16_t data_scaled = (cell_15_voltage - 0) / 1;
	CAN_bms_cellVoltages_payloads[3].word2 &= ~0xFFFC;
	CAN_bms_cellVoltages_payloads[3].word2 |= (data_scaled << 2) & 0xFFFC;
	CAN_bms_cellVoltages_payloads[3].word3 &= ~0x0001;
	CAN_bms_cellVoltages_payloads[3].word3 |= (data_scaled >> 14) & 0x0001;
}
void CAN_bms_cellVoltages_M3_cell_16_voltage_set(uint16_t cell_16_voltage){
	uint16_t data_scaled = (cell_16_voltage - 0) / 1;
	CAN_bms_cellVoltages_payloads[3].word3 &= ~0xFFFE;
	CAN_bms_cellVoltages_payloads[3].word3 |= (data_scaled << 1) & 0xFFFE;
}
void CAN_bms_cellVoltages_M4_cell_17_voltage_set(uint16_t cell_17_voltage){
	uint16_t data_scaled = (cell_17_voltage - 0) / 1;
	CAN_bms_cellVoltages_payloads[4].word0 &= ~0xFFF0;
	CAN_bms_cellVoltages_payloads[4].word0 |= (data_scaled << 4) & 0xFFF0;
	CAN_bms_cellVoltages_payloads[4].word1 &= ~0x0007;
	CAN_bms_cellVoltages_payloads[4].word1 |= (data_scaled >> 12) & 0x0007;
}
void CAN_bms_cellVoltages_M4_cell_18_voltage_set(uint16_t cell_18_voltage){
	uint16_t data_scaled = (cell_18_voltage - 0) / 1;
	CAN_bms_cellVoltages_payloads[4].word1 &= ~0xFFF8;
	CAN_bms_cellVoltages_payloads[4].word1 |= (data_scaled << 3) & 0xFFF8;
	CAN_bms_cellVoltages_payloads[4].word2 &= ~0x0003;
	CAN_bms_cellVoltages_payloads[4].word2 |= (data_scaled >> 13) & 0x0003;
}
void CAN_bms_cellVoltages_M4_cell_19_voltage_set(uint16_t cell_19_voltage){
	uint16_t data_scaled = (cell_19_voltage - 0) / 1;
	CAN_bms_cellVoltages_payloads[4].word2 &= ~0xFFFC;
	CAN_bms_cellVoltages_payloads[4].word2 |= (data_scaled << 2) & 0xFFFC;
	CAN_bms_cellVoltages_payloads[4].word3 &= ~0x0001;
	CAN_bms_cellVoltages_payloads[4].word3 |= (data_scaled >> 14) & 0x0001;
}
void CAN_bms_cellVoltages_M4_cell_20_voltage_set(uint16_t cell_20_voltage){
	uint16_t data_scaled = (cell_20_voltage - 0) / 1;
	CAN_bms_cellVoltages_payloads[4].word3 &= ~0xFFFE;
	CAN_bms_cellVoltages_payloads[4].word3 |= (data_scaled << 1) & 0xFFFE;
}
void CAN_bms_cellVoltages_M5_cell_21_voltage_set(uint16_t cell_21_voltage){
	uint16_t data_scaled = (cell_21_voltage - 0) / 1;
	CAN_bms_cellVoltages_payloads[5].word0 &= ~0xFFF0;
	CAN_bms_cellVoltages_payloads[5].word0 |= (data_scaled << 4) & 0xFFF0;
	CAN_bms_cellVoltages_payloads[5].word1 &= ~0x0007;
	CAN_bms_cellVoltages_payloads[5].word1 |= (data_scaled >> 12) & 0x0007;
}
void CAN_bms_cellVoltages_M5_cell_22_voltage_set(uint16_t cell_22_voltage){
	uint16_t data_scaled = (cell_22_voltage - 0) / 1;
	CAN_bms_cellVoltages_payloads[5].word1 &= ~0xFFF8;
	CAN_bms_cellVoltages_payloads[5].word1 |= (data_scaled << 3) & 0xFFF8;
	CAN_bms_cellVoltages_payloads[5].word2 &= ~0x0003;
	CAN_bms_cellVoltages_payloads[5].word2 |= (data_scaled >> 13) & 0x0003;
}
void CAN_bms_cellVoltages_M5_cell_23_voltage_set(uint16_t cell_23_voltage){
	uint16_t data_scaled = (cell_23_voltage - 0) / 1;
	CAN_bms_cellVoltages_payloads[5].word2 &= ~0xFFFC;
	CAN_bms_cellVoltages_payloads[5].word2 |= (data_scaled << 2) & 0xFFFC;
	CAN_bms_cellVoltages_payloads[5].word3 &= ~0x0001;
	CAN_bms_cellVoltages_payloads[5].word3 |= (data_scaled >> 14) & 0x0001;
}
void CAN_bms_cellVoltages_M5_cell_24_voltage_set(uint16_t cell_24_voltage){
	uint16_t data_scaled = (cell_24_voltage - 0) / 1;
	CAN_bms_cellVoltages_payloads[5].word3 &= ~0xFFFE;
	CAN_bms_cellVoltages_payloads[5].word3 |= (data_scaled << 1) & 0xFFFE;
}
void CAN_bms_cellVoltages_dlc_set(uint8_t dlc){
	CAN_bms_cellVoltages.dlc = dlc;
}
void CAN_bms_cellVoltages_send(void){
	// Auto-select current mux payload
	CAN_bms_cellVoltages.payload = &CAN_bms_cellVoltages_payloads[CAN_bms_cellVoltages_mux];
	// Send the message
	CAN_write(CAN_bms_cellVoltages);
	// Increment mux counter for next time
	CAN_bms_cellVoltages_mux++;
	if (CAN_bms_cellVoltages_mux >= CAN_BMS_CELLVOLTAGES_NUM_MUX_VALUES) {
		CAN_bms_cellVoltages_mux = 0;
	}
}

static CAN_payload_S CAN_bms_ltc_debug_payloads[3] __attribute__((aligned(sizeof(CAN_payload_S))));
static uint8_t CAN_bms_ltc_debug_mux = 0;
#define CAN_bms_ltc_debug_ID 0x727

static CAN_message_S CAN_bms_ltc_debug={
	.canID = CAN_bms_ltc_debug_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
};

#define CAN_BMS_LTC_DEBUG_MULTIPLEX_RANGE 2
#define CAN_BMS_LTC_DEBUG_MULTIPLEX_OFFSET 0
#define CAN_BMS_LTC_DEBUG_M0_LTC_STATE_RANGE 4
#define CAN_BMS_LTC_DEBUG_M0_LTC_STATE_OFFSET 2
#define CAN_BMS_LTC_DEBUG_M0_LASTERRORSTATE_RANGE 8
#define CAN_BMS_LTC_DEBUG_M0_LASTERRORSTATE_OFFSET 6
#define CAN_BMS_LTC_DEBUG_M0_ERRORCOUNT_RANGE 16
#define CAN_BMS_LTC_DEBUG_M0_ERRORCOUNT_OFFSET 14
#define CAN_BMS_LTC_DEBUG_M0_BALANCINGACTIVE_RANGE 1
#define CAN_BMS_LTC_DEBUG_M0_BALANCINGACTIVE_OFFSET 30
#define CAN_BMS_LTC_DEBUG_M1_CELL_A_BALANCING_RANGE 8
#define CAN_BMS_LTC_DEBUG_M1_CELL_A_BALANCING_OFFSET 2
#define CAN_BMS_LTC_DEBUG_M1_CELL_B_BALANCING_RANGE 8
#define CAN_BMS_LTC_DEBUG_M1_CELL_B_BALANCING_OFFSET 10
#define CAN_BMS_LTC_DEBUG_M1_CELL_C_BALANCING_RANGE 8
#define CAN_BMS_LTC_DEBUG_M1_CELL_C_BALANCING_OFFSET 18
#define CAN_BMS_LTC_DEBUG_M1_CELL_D_BALANCING_RANGE 8
#define CAN_BMS_LTC_DEBUG_M1_CELL_D_BALANCING_OFFSET 26
#define CAN_BMS_LTC_DEBUG_M1_CELL_E_BALANCING_RANGE 8
#define CAN_BMS_LTC_DEBUG_M1_CELL_E_BALANCING_OFFSET 34
#define CAN_BMS_LTC_DEBUG_M2_MAX_CELL_DELTA_MV_RANGE 13
#define CAN_BMS_LTC_DEBUG_M2_MAX_CELL_DELTA_MV_OFFSET 2
#define CAN_BMS_LTC_DEBUG_M2_MAX_CELL_MV_RANGE 13
#define CAN_BMS_LTC_DEBUG_M2_MAX_CELL_MV_OFFSET 15
#define CAN_BMS_LTC_DEBUG_M2_MIN_CELL_MV_RANGE 13
#define CAN_BMS_LTC_DEBUG_M2_MIN_CELL_MV_OFFSET 28
#define CAN_BMS_LTC_DEBUG_M2_MAX_CHARGE_CURRENT_ALLOWED_RANGE 16
#define CAN_BMS_LTC_DEBUG_M2_MAX_CHARGE_CURRENT_ALLOWED_OFFSET 41

void CAN_bms_ltc_debug_M0_ltc_state_set(uint16_t ltc_state){
	uint16_t data_scaled = (ltc_state - 0) / 1.0;
	CAN_bms_ltc_debug_payloads[0].word0 &= ~0x003C;
	CAN_bms_ltc_debug_payloads[0].word0 |= (data_scaled << 2) & 0x003C;
}
void CAN_bms_ltc_debug_M0_lastErrorState_set(uint16_t lastErrorState){
	uint16_t data_scaled = (lastErrorState - 0) / 1.0;
	CAN_bms_ltc_debug_payloads[0].word0 &= ~0x3FC0;
	CAN_bms_ltc_debug_payloads[0].word0 |= (data_scaled << 6) & 0x3FC0;
}
void CAN_bms_ltc_debug_M0_ErrorCount_set(uint16_t ErrorCount){
	uint16_t data_scaled = (ErrorCount - 0) / 1.0;
	CAN_bms_ltc_debug_payloads[0].word0 &= ~0xC000;
	CAN_bms_ltc_debug_payloads[0].word0 |= (data_scaled << 14) & 0xC000;
	CAN_bms_ltc_debug_payloads[0].word1 &= ~0x3FFF;
	CAN_bms_ltc_debug_payloads[0].word1 |= (data_scaled >> 2) & 0x3FFF;
}
void CAN_bms_ltc_debug_M0_balancingActive_set(uint16_t balancingActive){
	uint16_t data_scaled = (balancingActive - 0) / 1.0;
	CAN_bms_ltc_debug_payloads[0].word1 &= ~0x4000;
	CAN_bms_ltc_debug_payloads[0].word1 |= (data_scaled << 14) & 0x4000;
}
void CAN_bms_ltc_debug_M1_cell_A_balancing_set(uint16_t cell_A_balancing){
	uint16_t data_scaled = (cell_A_balancing - 0) / 1.0;
	CAN_bms_ltc_debug_payloads[1].word0 &= ~0x03FC;
	CAN_bms_ltc_debug_payloads[1].word0 |= (data_scaled << 2) & 0x03FC;
}
void CAN_bms_ltc_debug_M1_cell_B_balancing_set(uint16_t cell_B_balancing){
	uint16_t data_scaled = (cell_B_balancing - 0) / 1.0;
	CAN_bms_ltc_debug_payloads[1].word0 &= ~0xFC00;
	CAN_bms_ltc_debug_payloads[1].word0 |= (data_scaled << 10) & 0xFC00;
	CAN_bms_ltc_debug_payloads[1].word1 &= ~0x0003;
	CAN_bms_ltc_debug_payloads[1].word1 |= (data_scaled >> 6) & 0x0003;
}
void CAN_bms_ltc_debug_M1_cell_C_balancing_set(uint16_t cell_C_balancing){
	uint16_t data_scaled = (cell_C_balancing - 0) / 1.0;
	CAN_bms_ltc_debug_payloads[1].word1 &= ~0x03FC;
	CAN_bms_ltc_debug_payloads[1].word1 |= (data_scaled << 2) & 0x03FC;
}
void CAN_bms_ltc_debug_M1_cell_D_balancing_set(uint16_t cell_D_balancing){
	uint16_t data_scaled = (cell_D_balancing - 0) / 1.0;
	CAN_bms_ltc_debug_payloads[1].word1 &= ~0xFC00;
	CAN_bms_ltc_debug_payloads[1].word1 |= (data_scaled << 10) & 0xFC00;
	CAN_bms_ltc_debug_payloads[1].word2 &= ~0x0003;
	CAN_bms_ltc_debug_payloads[1].word2 |= (data_scaled >> 6) & 0x0003;
}
void CAN_bms_ltc_debug_M1_cell_E_balancing_set(uint16_t cell_E_balancing){
	uint16_t data_scaled = (cell_E_balancing - 0) / 1.0;
	CAN_bms_ltc_debug_payloads[1].word2 &= ~0x03FC;
	CAN_bms_ltc_debug_payloads[1].word2 |= (data_scaled << 2) & 0x03FC;
}
void CAN_bms_ltc_debug_M2_max_cell_delta_mV_set(uint16_t max_cell_delta_mV){
	uint16_t data_scaled = (max_cell_delta_mV - 0) / 1.0;
	CAN_bms_ltc_debug_payloads[2].word0 &= ~0x7FFC;
	CAN_bms_ltc_debug_payloads[2].word0 |= (data_scaled << 2) & 0x7FFC;
}
void CAN_bms_ltc_debug_M2_max_cell_mV_set(uint16_t max_cell_mV){
	uint16_t data_scaled = (max_cell_mV - 0) / 1.0;
	CAN_bms_ltc_debug_payloads[2].word0 &= ~0x8000;
	CAN_bms_ltc_debug_payloads[2].word0 |= (data_scaled << 15) & 0x8000;
	CAN_bms_ltc_debug_payloads[2].word1 &= ~0x0FFF;
	CAN_bms_ltc_debug_payloads[2].word1 |= (data_scaled >> 1) & 0x0FFF;
}
void CAN_bms_ltc_debug_M2_min_cell_mV_set(uint16_t min_cell_mV){
	uint16_t data_scaled = (min_cell_mV - 0) / 1.0;
	CAN_bms_ltc_debug_payloads[2].word1 &= ~0xF000;
	CAN_bms_ltc_debug_payloads[2].word1 |= (data_scaled << 12) & 0xF000;
	CAN_bms_ltc_debug_payloads[2].word2 &= ~0x01FF;
	CAN_bms_ltc_debug_payloads[2].word2 |= (data_scaled >> 4) & 0x01FF;
}
void CAN_bms_ltc_debug_M2_max_charge_current_allowed_set(uint16_t max_charge_current_allowed){
	uint16_t data_scaled = (max_charge_current_allowed - 0) / 1.0;
	CAN_bms_ltc_debug_payloads[2].word2 &= ~0xFE00;
	CAN_bms_ltc_debug_payloads[2].word2 |= (data_scaled << 9) & 0xFE00;
	CAN_bms_ltc_debug_payloads[2].word3 &= ~0x01FF;
	CAN_bms_ltc_debug_payloads[2].word3 |= (data_scaled >> 7) & 0x01FF;
}
uint8_t CAN_bms_ltc_debug_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_bms_ltc_debug);
}
uint16_t CAN_bms_ltc_debug_Multiplex_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_ltc_debug.payload, CAN_BMS_LTC_DEBUG_MULTIPLEX_OFFSET, CAN_BMS_LTC_DEBUG_MULTIPLEX_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_ltc_debug_M0_ltc_state_get(void){
	uint16_t data = get_bits((size_t*)&CAN_bms_ltc_debug_payloads[0], CAN_BMS_LTC_DEBUG_M0_LTC_STATE_OFFSET, CAN_BMS_LTC_DEBUG_M0_LTC_STATE_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_ltc_debug_M0_lastErrorState_get(void){
	uint16_t data = get_bits((size_t*)&CAN_bms_ltc_debug_payloads[0], CAN_BMS_LTC_DEBUG_M0_LASTERRORSTATE_OFFSET, CAN_BMS_LTC_DEBUG_M0_LASTERRORSTATE_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_ltc_debug_M0_ErrorCount_get(void){
	uint16_t data = get_bits((size_t*)&CAN_bms_ltc_debug_payloads[0], CAN_BMS_LTC_DEBUG_M0_ERRORCOUNT_OFFSET, CAN_BMS_LTC_DEBUG_M0_ERRORCOUNT_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_ltc_debug_M0_balancingActive_get(void){
	uint16_t data = get_bits((size_t*)&CAN_bms_ltc_debug_payloads[0], CAN_BMS_LTC_DEBUG_M0_BALANCINGACTIVE_OFFSET, CAN_BMS_LTC_DEBUG_M0_BALANCINGACTIVE_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_ltc_debug_M1_cell_A_balancing_get(void){
	uint16_t data = get_bits((size_t*)&CAN_bms_ltc_debug_payloads[1], CAN_BMS_LTC_DEBUG_M1_CELL_A_BALANCING_OFFSET, CAN_BMS_LTC_DEBUG_M1_CELL_A_BALANCING_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_ltc_debug_M1_cell_B_balancing_get(void){
	uint16_t data = get_bits((size_t*)&CAN_bms_ltc_debug_payloads[1], CAN_BMS_LTC_DEBUG_M1_CELL_B_BALANCING_OFFSET, CAN_BMS_LTC_DEBUG_M1_CELL_B_BALANCING_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_ltc_debug_M1_cell_C_balancing_get(void){
	uint16_t data = get_bits((size_t*)&CAN_bms_ltc_debug_payloads[1], CAN_BMS_LTC_DEBUG_M1_CELL_C_BALANCING_OFFSET, CAN_BMS_LTC_DEBUG_M1_CELL_C_BALANCING_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_ltc_debug_M1_cell_D_balancing_get(void){
	uint16_t data = get_bits((size_t*)&CAN_bms_ltc_debug_payloads[1], CAN_BMS_LTC_DEBUG_M1_CELL_D_BALANCING_OFFSET, CAN_BMS_LTC_DEBUG_M1_CELL_D_BALANCING_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_ltc_debug_M1_cell_E_balancing_get(void){
	uint16_t data = get_bits((size_t*)&CAN_bms_ltc_debug_payloads[1], CAN_BMS_LTC_DEBUG_M1_CELL_E_BALANCING_OFFSET, CAN_BMS_LTC_DEBUG_M1_CELL_E_BALANCING_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_ltc_debug_M2_max_cell_delta_mV_get(void){
	uint16_t data = get_bits((size_t*)&CAN_bms_ltc_debug_payloads[2], CAN_BMS_LTC_DEBUG_M2_MAX_CELL_DELTA_MV_OFFSET, CAN_BMS_LTC_DEBUG_M2_MAX_CELL_DELTA_MV_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_ltc_debug_M2_max_cell_mV_get(void){
	uint16_t data = get_bits((size_t*)&CAN_bms_ltc_debug_payloads[2], CAN_BMS_LTC_DEBUG_M2_MAX_CELL_MV_OFFSET, CAN_BMS_LTC_DEBUG_M2_MAX_CELL_MV_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_ltc_debug_M2_min_cell_mV_get(void){
	uint16_t data = get_bits((size_t*)&CAN_bms_ltc_debug_payloads[2], CAN_BMS_LTC_DEBUG_M2_MIN_CELL_MV_OFFSET, CAN_BMS_LTC_DEBUG_M2_MIN_CELL_MV_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_ltc_debug_M2_max_charge_current_allowed_get(void){
	uint16_t data = get_bits((size_t*)&CAN_bms_ltc_debug_payloads[2], CAN_BMS_LTC_DEBUG_M2_MAX_CHARGE_CURRENT_ALLOWED_OFFSET, CAN_BMS_LTC_DEBUG_M2_MAX_CHARGE_CURRENT_ALLOWED_RANGE);
	return (data * 1.0) + 0;
}

void CAN_bms_ltc_debug_dlc_set(uint8_t dlc){
	CAN_bms_ltc_debug.dlc = dlc;
}
void CAN_bms_ltc_debug_send(void){
	// Auto-select current mux payload
	CAN_bms_ltc_debug.payload = &CAN_bms_ltc_debug_payloads[CAN_bms_ltc_debug_mux];
	// Update message status for self-consumption
	CAN_bms_ltc_debug.canMessageStatus = 1;
	// Send the message
	CAN_write(CAN_bms_ltc_debug);
	// Increment mux counter for next time
	CAN_bms_ltc_debug_mux++;
	if (CAN_bms_ltc_debug_mux >= CAN_BMS_LTC_DEBUG_NUM_MUX_VALUES) {
		CAN_bms_ltc_debug_mux = 0;
	}
}

static CAN_payload_S CAN_bms_cellTemperaturs_payloads[6] __attribute__((aligned(sizeof(CAN_payload_S))));
static uint8_t CAN_bms_cellTemperaturs_mux = 0;
#define CAN_bms_cellTemperaturs_ID 0x726

static CAN_message_S CAN_bms_cellTemperaturs={
	.canID = CAN_bms_cellTemperaturs_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
};

#define CAN_BMS_CELLTEMPERATURS_MULTIPLEX_RANGE 4
#define CAN_BMS_CELLTEMPERATURS_MULTIPLEX_OFFSET 0
#define CAN_BMS_CELLTEMPERATURS_M0_TEMP_1_RANGE 12
#define CAN_BMS_CELLTEMPERATURS_M0_TEMP_1_OFFSET 4
#define CAN_BMS_CELLTEMPERATURS_M0_TEMP_2_RANGE 12
#define CAN_BMS_CELLTEMPERATURS_M0_TEMP_2_OFFSET 16
#define CAN_BMS_CELLTEMPERATURS_M0_TEMP_3_RANGE 12
#define CAN_BMS_CELLTEMPERATURS_M0_TEMP_3_OFFSET 28
#define CAN_BMS_CELLTEMPERATURS_M0_TEMP_4_RANGE 12
#define CAN_BMS_CELLTEMPERATURS_M0_TEMP_4_OFFSET 40
#define CAN_BMS_CELLTEMPERATURS_M1_TEMP_5_RANGE 12
#define CAN_BMS_CELLTEMPERATURS_M1_TEMP_5_OFFSET 4
#define CAN_BMS_CELLTEMPERATURS_M1_TEMP_6_RANGE 12
#define CAN_BMS_CELLTEMPERATURS_M1_TEMP_6_OFFSET 16
#define CAN_BMS_CELLTEMPERATURS_M1_TEMP_7_RANGE 12
#define CAN_BMS_CELLTEMPERATURS_M1_TEMP_7_OFFSET 28
#define CAN_BMS_CELLTEMPERATURS_M1_TEMP_8_RANGE 12
#define CAN_BMS_CELLTEMPERATURS_M1_TEMP_8_OFFSET 40
#define CAN_BMS_CELLTEMPERATURS_M2_TEMP_9_RANGE 12
#define CAN_BMS_CELLTEMPERATURS_M2_TEMP_9_OFFSET 4
#define CAN_BMS_CELLTEMPERATURS_M2_TEMP_10_RANGE 12
#define CAN_BMS_CELLTEMPERATURS_M2_TEMP_10_OFFSET 16
#define CAN_BMS_CELLTEMPERATURS_M2_TEMP_11_RANGE 12
#define CAN_BMS_CELLTEMPERATURS_M2_TEMP_11_OFFSET 28
#define CAN_BMS_CELLTEMPERATURS_M2_TEMP_12_RANGE 12
#define CAN_BMS_CELLTEMPERATURS_M2_TEMP_12_OFFSET 40
#define CAN_BMS_CELLTEMPERATURS_M3_TEMP_13_RANGE 12
#define CAN_BMS_CELLTEMPERATURS_M3_TEMP_13_OFFSET 4
#define CAN_BMS_CELLTEMPERATURS_M3_TEMP_14_RANGE 12
#define CAN_BMS_CELLTEMPERATURS_M3_TEMP_14_OFFSET 16
#define CAN_BMS_CELLTEMPERATURS_M3_TEMP_15_RANGE 12
#define CAN_BMS_CELLTEMPERATURS_M3_TEMP_15_OFFSET 28
#define CAN_BMS_CELLTEMPERATURS_M3_TEMP_16_RANGE 12
#define CAN_BMS_CELLTEMPERATURS_M3_TEMP_16_OFFSET 40
#define CAN_BMS_CELLTEMPERATURS_M4_TEMP_17_RANGE 12
#define CAN_BMS_CELLTEMPERATURS_M4_TEMP_17_OFFSET 4
#define CAN_BMS_CELLTEMPERATURS_M4_TEMP_18_RANGE 12
#define CAN_BMS_CELLTEMPERATURS_M4_TEMP_18_OFFSET 16
#define CAN_BMS_CELLTEMPERATURS_M4_TEMP_19_RANGE 12
#define CAN_BMS_CELLTEMPERATURS_M4_TEMP_19_OFFSET 28
#define CAN_BMS_CELLTEMPERATURS_M4_TEMP_20_RANGE 12
#define CAN_BMS_CELLTEMPERATURS_M4_TEMP_20_OFFSET 40
#define CAN_BMS_CELLTEMPERATURS_M5_TEMP_21_RANGE 12
#define CAN_BMS_CELLTEMPERATURS_M5_TEMP_21_OFFSET 4
#define CAN_BMS_CELLTEMPERATURS_M5_TEMP_22_RANGE 12
#define CAN_BMS_CELLTEMPERATURS_M5_TEMP_22_OFFSET 16
#define CAN_BMS_CELLTEMPERATURS_M5_TEMP_23_RANGE 12
#define CAN_BMS_CELLTEMPERATURS_M5_TEMP_23_OFFSET 28
#define CAN_BMS_CELLTEMPERATURS_M5_TEMP_24_RANGE 12
#define CAN_BMS_CELLTEMPERATURS_M5_TEMP_24_OFFSET 40

void CAN_bms_cellTemperaturs_M0_temp_1_set(float temp_1){
	uint16_t data_scaled = (uint16_t)((temp_1 - -40) / 0.1 + 0.5f);
	CAN_bms_cellTemperaturs_payloads[0].word0 &= ~0xFFF0;
	CAN_bms_cellTemperaturs_payloads[0].word0 |= (data_scaled << 4) & 0xFFF0;
}
void CAN_bms_cellTemperaturs_M0_temp_2_set(float temp_2){
	uint16_t data_scaled = (uint16_t)((temp_2 - -40) / 0.1 + 0.5f);
	CAN_bms_cellTemperaturs_payloads[0].word1 &= ~0x0FFF;
	CAN_bms_cellTemperaturs_payloads[0].word1 |= (data_scaled << 0) & 0x0FFF;
}
void CAN_bms_cellTemperaturs_M0_temp_3_set(float temp_3){
	uint16_t data_scaled = (uint16_t)((temp_3 - -40) / 0.1 + 0.5f);
	CAN_bms_cellTemperaturs_payloads[0].word1 &= ~0xF000;
	CAN_bms_cellTemperaturs_payloads[0].word1 |= (data_scaled << 12) & 0xF000;
	CAN_bms_cellTemperaturs_payloads[0].word2 &= ~0x00FF;
	CAN_bms_cellTemperaturs_payloads[0].word2 |= (data_scaled >> 4) & 0x00FF;
}
void CAN_bms_cellTemperaturs_M0_temp_4_set(float temp_4){
	uint16_t data_scaled = (uint16_t)((temp_4 - -40) / 0.1 + 0.5f);
	CAN_bms_cellTemperaturs_payloads[0].word2 &= ~0xFF00;
	CAN_bms_cellTemperaturs_payloads[0].word2 |= (data_scaled << 8) & 0xFF00;
	CAN_bms_cellTemperaturs_payloads[0].word3 &= ~0x000F;
	CAN_bms_cellTemperaturs_payloads[0].word3 |= (data_scaled >> 8) & 0x000F;
}
void CAN_bms_cellTemperaturs_M1_temp_5_set(float temp_5){
	uint16_t data_scaled = (uint16_t)((temp_5 - -40) / 0.1 + 0.5f);
	CAN_bms_cellTemperaturs_payloads[1].word0 &= ~0xFFF0;
	CAN_bms_cellTemperaturs_payloads[1].word0 |= (data_scaled << 4) & 0xFFF0;
}
void CAN_bms_cellTemperaturs_M1_temp_6_set(float temp_6){
	uint16_t data_scaled = (uint16_t)((temp_6 - -40) / 0.1 + 0.5f);
	CAN_bms_cellTemperaturs_payloads[1].word1 &= ~0x0FFF;
	CAN_bms_cellTemperaturs_payloads[1].word1 |= (data_scaled << 0) & 0x0FFF;
}
void CAN_bms_cellTemperaturs_M1_temp_7_set(float temp_7){
	uint16_t data_scaled = (uint16_t)((temp_7 - -40) / 0.1 + 0.5f);
	CAN_bms_cellTemperaturs_payloads[1].word1 &= ~0xF000;
	CAN_bms_cellTemperaturs_payloads[1].word1 |= (data_scaled << 12) & 0xF000;
	CAN_bms_cellTemperaturs_payloads[1].word2 &= ~0x00FF;
	CAN_bms_cellTemperaturs_payloads[1].word2 |= (data_scaled >> 4) & 0x00FF;
}
void CAN_bms_cellTemperaturs_M1_temp_8_set(float temp_8){
	uint16_t data_scaled = (uint16_t)((temp_8 - -40) / 0.1 + 0.5f);
	CAN_bms_cellTemperaturs_payloads[1].word2 &= ~0xFF00;
	CAN_bms_cellTemperaturs_payloads[1].word2 |= (data_scaled << 8) & 0xFF00;
	CAN_bms_cellTemperaturs_payloads[1].word3 &= ~0x000F;
	CAN_bms_cellTemperaturs_payloads[1].word3 |= (data_scaled >> 8) & 0x000F;
}
void CAN_bms_cellTemperaturs_M2_temp_9_set(float temp_9){
	uint16_t data_scaled = (uint16_t)((temp_9 - -40) / 0.1 + 0.5f);
	CAN_bms_cellTemperaturs_payloads[2].word0 &= ~0xFFF0;
	CAN_bms_cellTemperaturs_payloads[2].word0 |= (data_scaled << 4) & 0xFFF0;
}
void CAN_bms_cellTemperaturs_M2_temp_10_set(float temp_10){
	uint16_t data_scaled = (uint16_t)((temp_10 - -40) / 0.1 + 0.5f);
	CAN_bms_cellTemperaturs_payloads[2].word1 &= ~0x0FFF;
	CAN_bms_cellTemperaturs_payloads[2].word1 |= (data_scaled << 0) & 0x0FFF;
}
void CAN_bms_cellTemperaturs_M2_temp_11_set(float temp_11){
	uint16_t data_scaled = (uint16_t)((temp_11 - -40) / 0.1 + 0.5f);
	CAN_bms_cellTemperaturs_payloads[2].word1 &= ~0xF000;
	CAN_bms_cellTemperaturs_payloads[2].word1 |= (data_scaled << 12) & 0xF000;
	CAN_bms_cellTemperaturs_payloads[2].word2 &= ~0x00FF;
	CAN_bms_cellTemperaturs_payloads[2].word2 |= (data_scaled >> 4) & 0x00FF;
}
void CAN_bms_cellTemperaturs_M2_temp_12_set(float temp_12){
	uint16_t data_scaled = (uint16_t)((temp_12 - -40) / 0.1 + 0.5f);
	CAN_bms_cellTemperaturs_payloads[2].word2 &= ~0xFF00;
	CAN_bms_cellTemperaturs_payloads[2].word2 |= (data_scaled << 8) & 0xFF00;
	CAN_bms_cellTemperaturs_payloads[2].word3 &= ~0x000F;
	CAN_bms_cellTemperaturs_payloads[2].word3 |= (data_scaled >> 8) & 0x000F;
}
void CAN_bms_cellTemperaturs_M3_temp_13_set(float temp_13){
	uint16_t data_scaled = (uint16_t)((temp_13 - -40) / 0.1 + 0.5f);
	CAN_bms_cellTemperaturs_payloads[3].word0 &= ~0xFFF0;
	CAN_bms_cellTemperaturs_payloads[3].word0 |= (data_scaled << 4) & 0xFFF0;
}
void CAN_bms_cellTemperaturs_M3_temp_14_set(float temp_14){
	uint16_t data_scaled = (uint16_t)((temp_14 - -40) / 0.1 + 0.5f);
	CAN_bms_cellTemperaturs_payloads[3].word1 &= ~0x0FFF;
	CAN_bms_cellTemperaturs_payloads[3].word1 |= (data_scaled << 0) & 0x0FFF;
}
void CAN_bms_cellTemperaturs_M3_temp_15_set(float temp_15){
	uint16_t data_scaled = (uint16_t)((temp_15 - -40) / 0.1 + 0.5f);
	CAN_bms_cellTemperaturs_payloads[3].word1 &= ~0xF000;
	CAN_bms_cellTemperaturs_payloads[3].word1 |= (data_scaled << 12) & 0xF000;
	CAN_bms_cellTemperaturs_payloads[3].word2 &= ~0x00FF;
	CAN_bms_cellTemperaturs_payloads[3].word2 |= (data_scaled >> 4) & 0x00FF;
}
void CAN_bms_cellTemperaturs_M3_temp_16_set(float temp_16){
	uint16_t data_scaled = (uint16_t)((temp_16 - -40) / 0.1 + 0.5f);
	CAN_bms_cellTemperaturs_payloads[3].word2 &= ~0xFF00;
	CAN_bms_cellTemperaturs_payloads[3].word2 |= (data_scaled << 8) & 0xFF00;
	CAN_bms_cellTemperaturs_payloads[3].word3 &= ~0x000F;
	CAN_bms_cellTemperaturs_payloads[3].word3 |= (data_scaled >> 8) & 0x000F;
}
void CAN_bms_cellTemperaturs_M4_temp_17_set(float temp_17){
	uint16_t data_scaled = (uint16_t)((temp_17 - -40) / 0.1 + 0.5f);
	CAN_bms_cellTemperaturs_payloads[4].word0 &= ~0xFFF0;
	CAN_bms_cellTemperaturs_payloads[4].word0 |= (data_scaled << 4) & 0xFFF0;
}
void CAN_bms_cellTemperaturs_M4_temp_18_set(float temp_18){
	uint16_t data_scaled = (uint16_t)((temp_18 - -40) / 0.1 + 0.5f);
	CAN_bms_cellTemperaturs_payloads[4].word1 &= ~0x0FFF;
	CAN_bms_cellTemperaturs_payloads[4].word1 |= (data_scaled << 0) & 0x0FFF;
}
void CAN_bms_cellTemperaturs_M4_temp_19_set(float temp_19){
	uint16_t data_scaled = (uint16_t)((temp_19 - -40) / 0.1 + 0.5f);
	CAN_bms_cellTemperaturs_payloads[4].word1 &= ~0xF000;
	CAN_bms_cellTemperaturs_payloads[4].word1 |= (data_scaled << 12) & 0xF000;
	CAN_bms_cellTemperaturs_payloads[4].word2 &= ~0x00FF;
	CAN_bms_cellTemperaturs_payloads[4].word2 |= (data_scaled >> 4) & 0x00FF;
}
void CAN_bms_cellTemperaturs_M4_temp_20_set(float temp_20){
	uint16_t data_scaled = (uint16_t)((temp_20 - -40) / 0.1 + 0.5f);
	CAN_bms_cellTemperaturs_payloads[4].word2 &= ~0xFF00;
	CAN_bms_cellTemperaturs_payloads[4].word2 |= (data_scaled << 8) & 0xFF00;
	CAN_bms_cellTemperaturs_payloads[4].word3 &= ~0x000F;
	CAN_bms_cellTemperaturs_payloads[4].word3 |= (data_scaled >> 8) & 0x000F;
}
void CAN_bms_cellTemperaturs_M5_temp_21_set(float temp_21){
	uint16_t data_scaled = (uint16_t)((temp_21 - -40) / 0.1 + 0.5f);
	CAN_bms_cellTemperaturs_payloads[5].word0 &= ~0xFFF0;
	CAN_bms_cellTemperaturs_payloads[5].word0 |= (data_scaled << 4) & 0xFFF0;
}
void CAN_bms_cellTemperaturs_M5_temp_22_set(float temp_22){
	uint16_t data_scaled = (uint16_t)((temp_22 - -40) / 0.1 + 0.5f);
	CAN_bms_cellTemperaturs_payloads[5].word1 &= ~0x0FFF;
	CAN_bms_cellTemperaturs_payloads[5].word1 |= (data_scaled << 0) & 0x0FFF;
}
void CAN_bms_cellTemperaturs_M5_temp_23_set(float temp_23){
	uint16_t data_scaled = (uint16_t)((temp_23 - -40) / 0.1 + 0.5f);
	CAN_bms_cellTemperaturs_payloads[5].word1 &= ~0xF000;
	CAN_bms_cellTemperaturs_payloads[5].word1 |= (data_scaled << 12) & 0xF000;
	CAN_bms_cellTemperaturs_payloads[5].word2 &= ~0x00FF;
	CAN_bms_cellTemperaturs_payloads[5].word2 |= (data_scaled >> 4) & 0x00FF;
}
void CAN_bms_cellTemperaturs_M5_temp_24_set(float temp_24){
	uint16_t data_scaled = (uint16_t)((temp_24 - -40) / 0.1 + 0.5f);
	CAN_bms_cellTemperaturs_payloads[5].word2 &= ~0xFF00;
	CAN_bms_cellTemperaturs_payloads[5].word2 |= (data_scaled << 8) & 0xFF00;
	CAN_bms_cellTemperaturs_payloads[5].word3 &= ~0x000F;
	CAN_bms_cellTemperaturs_payloads[5].word3 |= (data_scaled >> 8) & 0x000F;
}
void CAN_bms_cellTemperaturs_dlc_set(uint8_t dlc){
	CAN_bms_cellTemperaturs.dlc = dlc;
}
void CAN_bms_cellTemperaturs_send(void){
	// Auto-select current mux payload
	CAN_bms_cellTemperaturs.payload = &CAN_bms_cellTemperaturs_payloads[CAN_bms_cellTemperaturs_mux];
	// Send the message
	CAN_write(CAN_bms_cellTemperaturs);
	// Increment mux counter for next time
	CAN_bms_cellTemperaturs_mux++;
	if (CAN_bms_cellTemperaturs_mux >= CAN_BMS_CELLTEMPERATURS_NUM_MUX_VALUES) {
		CAN_bms_cellTemperaturs_mux = 0;
	}
}

/**********************************************************
 * motorcontroller NODE MESSAGES
 */
/**********************************************************
 * charger NODE MESSAGES
 */
#define CAN_charger_status_ID 0x18ff50e5

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

uint8_t CAN_charger_status_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_charger_status);
}
uint16_t CAN_charger_status_output_voltage_high_byte_get(void){
	uint16_t data = get_bits((size_t*)CAN_charger_status.payload, CAN_CHARGER_STATUS_OUTPUT_VOLTAGE_HIGH_BYTE_OFFSET, CAN_CHARGER_STATUS_OUTPUT_VOLTAGE_HIGH_BYTE_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_charger_status_output_voltage_low_byte_get(void){
	uint16_t data = get_bits((size_t*)CAN_charger_status.payload, CAN_CHARGER_STATUS_OUTPUT_VOLTAGE_LOW_BYTE_OFFSET, CAN_CHARGER_STATUS_OUTPUT_VOLTAGE_LOW_BYTE_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_charger_status_output_current_high_byte_get(void){
	uint16_t data = get_bits((size_t*)CAN_charger_status.payload, CAN_CHARGER_STATUS_OUTPUT_CURRENT_HIGH_BYTE_OFFSET, CAN_CHARGER_STATUS_OUTPUT_CURRENT_HIGH_BYTE_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_charger_status_output_current_low_byte_get(void){
	uint16_t data = get_bits((size_t*)CAN_charger_status.payload, CAN_CHARGER_STATUS_OUTPUT_CURRENT_LOW_BYTE_OFFSET, CAN_CHARGER_STATUS_OUTPUT_CURRENT_LOW_BYTE_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_charger_status_hardware_error_get(void){
	uint16_t data = get_bits((size_t*)CAN_charger_status.payload, CAN_CHARGER_STATUS_HARDWARE_ERROR_OFFSET, CAN_CHARGER_STATUS_HARDWARE_ERROR_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_charger_status_charger_overtemp_error_get(void){
	uint16_t data = get_bits((size_t*)CAN_charger_status.payload, CAN_CHARGER_STATUS_CHARGER_OVERTEMP_ERROR_OFFSET, CAN_CHARGER_STATUS_CHARGER_OVERTEMP_ERROR_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_charger_status_input_voltage_error_get(void){
	uint16_t data = get_bits((size_t*)CAN_charger_status.payload, CAN_CHARGER_STATUS_INPUT_VOLTAGE_ERROR_OFFSET, CAN_CHARGER_STATUS_INPUT_VOLTAGE_ERROR_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_charger_status_battery_detect_error_get(void){
	uint16_t data = get_bits((size_t*)CAN_charger_status.payload, CAN_CHARGER_STATUS_BATTERY_DETECT_ERROR_OFFSET, CAN_CHARGER_STATUS_BATTERY_DETECT_ERROR_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_charger_status_communication_error_get(void){
	uint16_t data = get_bits((size_t*)CAN_charger_status.payload, CAN_CHARGER_STATUS_COMMUNICATION_ERROR_OFFSET, CAN_CHARGER_STATUS_COMMUNICATION_ERROR_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_charger_status_byte7_get(void){
	uint16_t data = get_bits((size_t*)CAN_charger_status.payload, CAN_CHARGER_STATUS_BYTE7_OFFSET, CAN_CHARGER_STATUS_BYTE7_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_charger_status_byte8_get(void){
	uint16_t data = get_bits((size_t*)CAN_charger_status.payload, CAN_CHARGER_STATUS_BYTE8_OFFSET, CAN_CHARGER_STATUS_BYTE8_RANGE);
	return (data * 1.0) + 0;
}

/**********************************************************
 * boot_host NODE MESSAGES
 */
#define CAN_boot_host_bms_ID 0xa1

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

uint8_t CAN_boot_host_bms_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_boot_host_bms);
}
uint16_t CAN_boot_host_bms_type_get(void){
	uint16_t data = get_bits((size_t*)CAN_boot_host_bms.payload, CAN_BOOT_HOST_BMS_TYPE_OFFSET, CAN_BOOT_HOST_BMS_TYPE_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_bms_code_get(void){
	uint16_t data = get_bits((size_t*)CAN_boot_host_bms.payload, CAN_BOOT_HOST_BMS_CODE_OFFSET, CAN_BOOT_HOST_BMS_CODE_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_bms_byte1_get(void){
	uint16_t data = get_bits((size_t*)CAN_boot_host_bms.payload, CAN_BOOT_HOST_BMS_BYTE1_OFFSET, CAN_BOOT_HOST_BMS_BYTE1_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_bms_byte2_get(void){
	uint16_t data = get_bits((size_t*)CAN_boot_host_bms.payload, CAN_BOOT_HOST_BMS_BYTE2_OFFSET, CAN_BOOT_HOST_BMS_BYTE2_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_bms_byte3_get(void){
	uint16_t data = get_bits((size_t*)CAN_boot_host_bms.payload, CAN_BOOT_HOST_BMS_BYTE3_OFFSET, CAN_BOOT_HOST_BMS_BYTE3_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_bms_byte4_get(void){
	uint16_t data = get_bits((size_t*)CAN_boot_host_bms.payload, CAN_BOOT_HOST_BMS_BYTE4_OFFSET, CAN_BOOT_HOST_BMS_BYTE4_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_bms_byte5_get(void){
	uint16_t data = get_bits((size_t*)CAN_boot_host_bms.payload, CAN_BOOT_HOST_BMS_BYTE5_OFFSET, CAN_BOOT_HOST_BMS_BYTE5_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_bms_byte6_get(void){
	uint16_t data = get_bits((size_t*)CAN_boot_host_bms.payload, CAN_BOOT_HOST_BMS_BYTE6_OFFSET, CAN_BOOT_HOST_BMS_BYTE6_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_bms_byte7_get(void){
	uint16_t data = get_bits((size_t*)CAN_boot_host_bms.payload, CAN_BOOT_HOST_BMS_BYTE7_OFFSET, CAN_BOOT_HOST_BMS_BYTE7_RANGE);
	return (data * 1.0) + 0;
}

void CAN_DBC_init(void) {
	// Initialize multiplexed message: status
	CAN_bms_status.payload = &CAN_bms_status_payloads[0];
	// Pre-set mux value 0 in payload 0
	CAN_bms_status_payloads[0].word0 &= ~0x0003;
	CAN_bms_status_payloads[0].word0 |= (0 << 0) & 0x0003;
	// Pre-set mux value 1 in payload 1
	CAN_bms_status_payloads[1].word0 &= ~0x0003;
	CAN_bms_status_payloads[1].word0 |= (1 << 0) & 0x0003;
	// Pre-set mux value 2 in payload 2
	CAN_bms_status_payloads[2].word0 &= ~0x0003;
	CAN_bms_status_payloads[2].word0 |= (2 << 0) & 0x0003;
	// Pre-set mux value 3 in payload 3
	CAN_bms_status_payloads[3].word0 &= ~0x0003;
	CAN_bms_status_payloads[3].word0 |= (3 << 0) & 0x0003;
	// Initialize multiplexed message: cellVoltages
	CAN_bms_cellVoltages.payload = &CAN_bms_cellVoltages_payloads[0];
	// Pre-set mux value 0 in payload 0
	CAN_bms_cellVoltages_payloads[0].word0 &= ~0x000F;
	CAN_bms_cellVoltages_payloads[0].word0 |= (0 << 0) & 0x000F;
	// Pre-set mux value 1 in payload 1
	CAN_bms_cellVoltages_payloads[1].word0 &= ~0x000F;
	CAN_bms_cellVoltages_payloads[1].word0 |= (1 << 0) & 0x000F;
	// Pre-set mux value 2 in payload 2
	CAN_bms_cellVoltages_payloads[2].word0 &= ~0x000F;
	CAN_bms_cellVoltages_payloads[2].word0 |= (2 << 0) & 0x000F;
	// Pre-set mux value 3 in payload 3
	CAN_bms_cellVoltages_payloads[3].word0 &= ~0x000F;
	CAN_bms_cellVoltages_payloads[3].word0 |= (3 << 0) & 0x000F;
	// Pre-set mux value 4 in payload 4
	CAN_bms_cellVoltages_payloads[4].word0 &= ~0x000F;
	CAN_bms_cellVoltages_payloads[4].word0 |= (4 << 0) & 0x000F;
	// Pre-set mux value 5 in payload 5
	CAN_bms_cellVoltages_payloads[5].word0 &= ~0x000F;
	CAN_bms_cellVoltages_payloads[5].word0 |= (5 << 0) & 0x000F;
	// Initialize multiplexed message: ltc_debug
	CAN_bms_ltc_debug.payload = &CAN_bms_ltc_debug_payloads[0];
	// Pre-set mux value 0 in payload 0
	CAN_bms_ltc_debug_payloads[0].word0 &= ~0x0003;
	CAN_bms_ltc_debug_payloads[0].word0 |= (0 << 0) & 0x0003;
	// Pre-set mux value 1 in payload 1
	CAN_bms_ltc_debug_payloads[1].word0 &= ~0x0003;
	CAN_bms_ltc_debug_payloads[1].word0 |= (1 << 0) & 0x0003;
	// Pre-set mux value 2 in payload 2
	CAN_bms_ltc_debug_payloads[2].word0 &= ~0x0003;
	CAN_bms_ltc_debug_payloads[2].word0 |= (2 << 0) & 0x0003;
	// Initialize multiplexed message: cellTemperaturs
	CAN_bms_cellTemperaturs.payload = &CAN_bms_cellTemperaturs_payloads[0];
	// Pre-set mux value 0 in payload 0
	CAN_bms_cellTemperaturs_payloads[0].word0 &= ~0x000F;
	CAN_bms_cellTemperaturs_payloads[0].word0 |= (0 << 0) & 0x000F;
	// Pre-set mux value 1 in payload 1
	CAN_bms_cellTemperaturs_payloads[1].word0 &= ~0x000F;
	CAN_bms_cellTemperaturs_payloads[1].word0 |= (1 << 0) & 0x000F;
	// Pre-set mux value 2 in payload 2
	CAN_bms_cellTemperaturs_payloads[2].word0 &= ~0x000F;
	CAN_bms_cellTemperaturs_payloads[2].word0 |= (2 << 0) & 0x000F;
	// Pre-set mux value 3 in payload 3
	CAN_bms_cellTemperaturs_payloads[3].word0 &= ~0x000F;
	CAN_bms_cellTemperaturs_payloads[3].word0 |= (3 << 0) & 0x000F;
	// Pre-set mux value 4 in payload 4
	CAN_bms_cellTemperaturs_payloads[4].word0 &= ~0x000F;
	CAN_bms_cellTemperaturs_payloads[4].word0 |= (4 << 0) & 0x000F;
	// Pre-set mux value 5 in payload 5
	CAN_bms_cellTemperaturs_payloads[5].word0 &= ~0x000F;
	CAN_bms_cellTemperaturs_payloads[5].word0 |= (5 << 0) & 0x000F;
	CAN_configureMailbox(&CAN_mcu_status);
	CAN_configureMailbox(&CAN_mcu_command);
	CAN_configureMailbox(&CAN_mcu_mcu_debug);
	CAN_configureMailbox(&CAN_charger_status);
	CAN_configureMailbox(&CAN_boot_host_bms);
}

void CAN_send_10ms(void){
	CAN_bms_status_send();
	CAN_bms_status_2_send();
	CAN_bms_debug_send();
}

void CAN_send_1000ms(void){
	CAN_bms_charger_request_send();
	CAN_bms_cellVoltages_send();
	CAN_bms_cellTemperaturs_send();
}

void CAN_send_1ms(void){
	CAN_bms_ltc_debug_send();
}
