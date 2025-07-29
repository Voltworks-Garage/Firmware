#include "mcu_dbc.h"
#include "CAN.h"
#include "utils.h"
/**********************************************************
 * dash NODE MESSAGES
 */
#define CAN_dash_status_ID 0x701

static CAN_message_S CAN_dash_status={
	.canID = CAN_dash_status_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
};

#define CAN_DASH_STATUS_HEARTBEAT_RANGE 4
#define CAN_DASH_STATUS_HEARTBEAT_OFFSET 0
#define CAN_DASH_STATUS_STATE_RANGE 3
#define CAN_DASH_STATUS_STATE_OFFSET 4
#define CAN_DASH_STATUS_KILLBUTTON_RANGE 2
#define CAN_DASH_STATUS_KILLBUTTON_OFFSET 7
#define CAN_DASH_STATUS_IGNBUTTON_RANGE 2
#define CAN_DASH_STATUS_IGNBUTTON_OFFSET 9
#define CAN_DASH_STATUS_MODEBUTTON_RANGE 2
#define CAN_DASH_STATUS_MODEBUTTON_OFFSET 11
#define CAN_DASH_STATUS_SELECTBUTTON_RANGE 2
#define CAN_DASH_STATUS_SELECTBUTTON_OFFSET 13
#define CAN_DASH_STATUS_DRIVEMODE_RANGE 3
#define CAN_DASH_STATUS_DRIVEMODE_OFFSET 15

uint8_t CAN_dash_status_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_dash_status);
}
uint16_t CAN_dash_status_heartBeat_get(void){
	// Extract 4-bit signal at bit offset 0
	uint16_t data = 0;
	data |= (uint16_t)((CAN_dash_status.payload->word0 & 0x000F) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_dash_status_state_get(void){
	// Extract 3-bit signal at bit offset 4
	uint16_t data = 0;
	data |= (uint16_t)((CAN_dash_status.payload->word0 & 0x0070) >> 4) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_dash_status_killButton_get(void){
	// Extract 2-bit signal at bit offset 7
	uint16_t data = 0;
	data |= (uint16_t)((CAN_dash_status.payload->word0 & 0x0180) >> 7) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_dash_status_ignButton_get(void){
	// Extract 2-bit signal at bit offset 9
	uint16_t data = 0;
	data |= (uint16_t)((CAN_dash_status.payload->word0 & 0x0600) >> 9) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_dash_status_modeButton_get(void){
	// Extract 2-bit signal at bit offset 11
	uint16_t data = 0;
	data |= (uint16_t)((CAN_dash_status.payload->word0 & 0x1800) >> 11) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_dash_status_selectButton_get(void){
	// Extract 2-bit signal at bit offset 13
	uint16_t data = 0;
	data |= (uint16_t)((CAN_dash_status.payload->word0 & 0x6000) >> 13) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_dash_status_driveMode_get(void){
	// Extract 3-bit signal at bit offset 15
	uint16_t data = 0;
	data |= (uint16_t)((CAN_dash_status.payload->word0 & 0x8000) >> 15) << 0;
	data |= (uint16_t)((CAN_dash_status.payload->word1 & 0x0003) >> 0) << 1;
	return (data * 1.0) + 0;
}

#define CAN_dash_command_ID 0x702

static CAN_message_S CAN_dash_command={
	.canID = CAN_dash_command_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
};

#define CAN_DASH_COMMAND_IGNITIONREQUEST_RANGE 1
#define CAN_DASH_COMMAND_IGNITIONREQUEST_OFFSET 0
#define CAN_DASH_COMMAND_KILLREQUEST_RANGE 1
#define CAN_DASH_COMMAND_KILLREQUEST_OFFSET 1
#define CAN_DASH_COMMAND_BATTERYEJECTREQUEST_RANGE 1
#define CAN_DASH_COMMAND_BATTERYEJECTREQUEST_OFFSET 2
#define CAN_DASH_COMMAND_LIGHTSREQUEST_RANGE 1
#define CAN_DASH_COMMAND_LIGHTSREQUEST_OFFSET 3
#define CAN_DASH_COMMAND_HORNREQUEST_RANGE 1
#define CAN_DASH_COMMAND_HORNREQUEST_OFFSET 4

uint8_t CAN_dash_command_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_dash_command);
}
uint16_t CAN_dash_command_ignitionRequest_get(void){
	// Extract 1-bit signal at bit offset 0
	uint16_t data = 0;
	data |= (uint16_t)((CAN_dash_command.payload->word0 & 0x0001) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_dash_command_killRequest_get(void){
	// Extract 1-bit signal at bit offset 1
	uint16_t data = 0;
	data |= (uint16_t)((CAN_dash_command.payload->word0 & 0x0002) >> 1) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_dash_command_batteryEjectRequest_get(void){
	// Extract 1-bit signal at bit offset 2
	uint16_t data = 0;
	data |= (uint16_t)((CAN_dash_command.payload->word0 & 0x0004) >> 2) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_dash_command_lightsRequest_get(void){
	// Extract 1-bit signal at bit offset 3
	uint16_t data = 0;
	data |= (uint16_t)((CAN_dash_command.payload->word0 & 0x0008) >> 3) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_dash_command_hornRequest_get(void){
	// Extract 1-bit signal at bit offset 4
	uint16_t data = 0;
	data |= (uint16_t)((CAN_dash_command.payload->word0 & 0x0010) >> 4) << 0;
	return (data * 1.0) + 0;
}

#define CAN_dash_data1_ID 0x1806e5f5

static CAN_message_S CAN_dash_data1={
	.canID = CAN_dash_data1_ID,
	.canXID = 1,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
};

#define CAN_DASH_DATA1_SPEED_RANGE 16
#define CAN_DASH_DATA1_SPEED_OFFSET 0
#define CAN_DASH_DATA1_ODOMETER_RANGE 16
#define CAN_DASH_DATA1_ODOMETER_OFFSET 16
#define CAN_DASH_DATA1_TRIPA_RANGE 16
#define CAN_DASH_DATA1_TRIPA_OFFSET 32
#define CAN_DASH_DATA1_TRIPB_RANGE 16
#define CAN_DASH_DATA1_TRIPB_OFFSET 48

uint8_t CAN_dash_data1_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_dash_data1);
}
uint16_t CAN_dash_data1_speed_get(void){
	// Extract 16-bit signal at bit offset 0
	uint16_t data = 0;
	data |= (uint16_t)((CAN_dash_data1.payload->word0 & 0xFFFF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_dash_data1_odometer_get(void){
	// Extract 16-bit signal at bit offset 16
	uint16_t data = 0;
	data |= (uint16_t)((CAN_dash_data1.payload->word1 & 0xFFFF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_dash_data1_tripA_get(void){
	// Extract 16-bit signal at bit offset 32
	uint16_t data = 0;
	data |= (uint16_t)((CAN_dash_data1.payload->word2 & 0xFFFF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_dash_data1_tripB_get(void){
	// Extract 16-bit signal at bit offset 48
	uint16_t data = 0;
	data |= (uint16_t)((CAN_dash_data1.payload->word3 & 0xFFFF) >> 0) << 0;
	return (data * 1.0) + 0;
}

#define CAN_dash_data2_ID 0x704

static CAN_message_S CAN_dash_data2={
	.canID = CAN_dash_data2_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
};

#define CAN_DASH_DATA2_RUNNINGTIME_RANGE 16
#define CAN_DASH_DATA2_RUNNINGTIME_OFFSET 0
#define CAN_DASH_DATA2_ODOMETER_RANGE 16
#define CAN_DASH_DATA2_ODOMETER_OFFSET 16
#define CAN_DASH_DATA2_TRIPA_RANGE 16
#define CAN_DASH_DATA2_TRIPA_OFFSET 32
#define CAN_DASH_DATA2_TRIPB_RANGE 16
#define CAN_DASH_DATA2_TRIPB_OFFSET 48

uint8_t CAN_dash_data2_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_dash_data2);
}
uint16_t CAN_dash_data2_runningTime_get(void){
	// Extract 16-bit signal at bit offset 0
	uint16_t data = 0;
	data |= (uint16_t)((CAN_dash_data2.payload->word0 & 0xFFFF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_dash_data2_odometer_get(void){
	// Extract 16-bit signal at bit offset 16
	uint16_t data = 0;
	data |= (uint16_t)((CAN_dash_data2.payload->word1 & 0xFFFF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_dash_data2_tripA_get(void){
	// Extract 16-bit signal at bit offset 32
	uint16_t data = 0;
	data |= (uint16_t)((CAN_dash_data2.payload->word2 & 0xFFFF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_dash_data2_tripB_get(void){
	// Extract 16-bit signal at bit offset 48
	uint16_t data = 0;
	data |= (uint16_t)((CAN_dash_data2.payload->word3 & 0xFFFF) >> 0) << 0;
	return (data * 1.0) + 0;
}

/**********************************************************
 * mcu NODE MESSAGES
 */
static CAN_payload_S CAN_mcu_status_payload __attribute__((aligned(sizeof(CAN_payload_S))));
static volatile uint8_t CAN_mcu_status_status = 0;
#define CAN_mcu_status_ID 0x711

static CAN_message_S CAN_mcu_status={
	.canID = CAN_mcu_status_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = &CAN_mcu_status_payload,
	.canMessageStatus = &CAN_mcu_status_status
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

void CAN_mcu_status_heartbeat_set(uint16_t heartbeat){
	uint16_t data_scaled = (heartbeat - 0) / 1.0;
	// Set 4-bit signal at bit offset 0
	CAN_mcu_status.payload->word0 &= ~0x000F;
	CAN_mcu_status.payload->word0 |= data_scaled & 0x000F;
}
void CAN_mcu_status_highBeam_set(uint16_t highBeam){
	uint16_t data_scaled = (highBeam - 0) / 1.0;
	// Set 1-bit signal at bit offset 4
	CAN_mcu_status.payload->word0 &= ~0x0010;
	CAN_mcu_status.payload->word0 |= (data_scaled << 4) & 0x0010;
}
void CAN_mcu_status_lowBeam_set(uint16_t lowBeam){
	uint16_t data_scaled = (lowBeam - 0) / 1.0;
	// Set 1-bit signal at bit offset 5
	CAN_mcu_status.payload->word0 &= ~0x0020;
	CAN_mcu_status.payload->word0 |= (data_scaled << 5) & 0x0020;
}
void CAN_mcu_status_brakeLight_set(uint16_t brakeLight){
	uint16_t data_scaled = (brakeLight - 0) / 1.0;
	// Set 1-bit signal at bit offset 6
	CAN_mcu_status.payload->word0 &= ~0x0040;
	CAN_mcu_status.payload->word0 |= (data_scaled << 6) & 0x0040;
}
void CAN_mcu_status_tailLight_set(uint16_t tailLight){
	uint16_t data_scaled = (tailLight - 0) / 1.0;
	// Set 1-bit signal at bit offset 7
	CAN_mcu_status.payload->word0 &= ~0x0080;
	CAN_mcu_status.payload->word0 |= (data_scaled << 7) & 0x0080;
}
void CAN_mcu_status_horn_set(uint16_t horn){
	uint16_t data_scaled = (horn - 0) / 1.0;
	// Set 1-bit signal at bit offset 8
	CAN_mcu_status.payload->word0 &= ~0x0100;
	CAN_mcu_status.payload->word0 |= (data_scaled << 8) & 0x0100;
}
void CAN_mcu_status_turnSignalFR_set(uint16_t turnSignalFR){
	uint16_t data_scaled = (turnSignalFR - 0) / 1.0;
	// Set 1-bit signal at bit offset 9
	CAN_mcu_status.payload->word0 &= ~0x0200;
	CAN_mcu_status.payload->word0 |= (data_scaled << 9) & 0x0200;
}
void CAN_mcu_status_turnSignalFL_set(uint16_t turnSignalFL){
	uint16_t data_scaled = (turnSignalFL - 0) / 1.0;
	// Set 1-bit signal at bit offset 10
	CAN_mcu_status.payload->word0 &= ~0x0400;
	CAN_mcu_status.payload->word0 |= (data_scaled << 10) & 0x0400;
}
void CAN_mcu_status_turnSignalRR_set(uint16_t turnSignalRR){
	uint16_t data_scaled = (turnSignalRR - 0) / 1.0;
	// Set 1-bit signal at bit offset 11
	CAN_mcu_status.payload->word0 &= ~0x0800;
	CAN_mcu_status.payload->word0 |= (data_scaled << 11) & 0x0800;
}
void CAN_mcu_status_turnSignalRL_set(uint16_t turnSignalRL){
	uint16_t data_scaled = (turnSignalRL - 0) / 1.0;
	// Set 1-bit signal at bit offset 12
	CAN_mcu_status.payload->word0 &= ~0x1000;
	CAN_mcu_status.payload->word0 |= (data_scaled << 12) & 0x1000;
}
void CAN_mcu_status_brakeSwitchFront_set(uint16_t brakeSwitchFront){
	uint16_t data_scaled = (brakeSwitchFront - 0) / 1.0;
	// Set 1-bit signal at bit offset 13
	CAN_mcu_status.payload->word0 &= ~0x2000;
	CAN_mcu_status.payload->word0 |= (data_scaled << 13) & 0x2000;
}
void CAN_mcu_status_brakeSwitchRear_set(uint16_t brakeSwitchRear){
	uint16_t data_scaled = (brakeSwitchRear - 0) / 1.0;
	// Set 1-bit signal at bit offset 14
	CAN_mcu_status.payload->word0 &= ~0x4000;
	CAN_mcu_status.payload->word0 |= (data_scaled << 14) & 0x4000;
}
void CAN_mcu_status_killSwitch_set(uint16_t killSwitch){
	uint16_t data_scaled = (killSwitch - 0) / 1.0;
	// Set 1-bit signal at bit offset 15
	CAN_mcu_status.payload->word0 &= ~0x8000;
	CAN_mcu_status.payload->word0 |= (data_scaled << 15) & 0x8000;
}
void CAN_mcu_status_ignitionSwitch_set(uint16_t ignitionSwitch){
	uint16_t data_scaled = (ignitionSwitch - 0) / 1.0;
	// Set 1-bit signal at bit offset 16
	CAN_mcu_status.payload->word1 &= ~0x0001;
	CAN_mcu_status.payload->word1 |= data_scaled & 0x0001;
}
void CAN_mcu_status_leftTurnSwitch_set(uint16_t leftTurnSwitch){
	uint16_t data_scaled = (leftTurnSwitch - 0) / 1.0;
	// Set 1-bit signal at bit offset 17
	CAN_mcu_status.payload->word1 &= ~0x0002;
	CAN_mcu_status.payload->word1 |= (data_scaled << 1) & 0x0002;
}
void CAN_mcu_status_rightTurnSwitch_set(uint16_t rightTurnSwitch){
	uint16_t data_scaled = (rightTurnSwitch - 0) / 1.0;
	// Set 1-bit signal at bit offset 18
	CAN_mcu_status.payload->word1 &= ~0x0004;
	CAN_mcu_status.payload->word1 |= (data_scaled << 2) & 0x0004;
}
void CAN_mcu_status_lightSwitch_set(uint16_t lightSwitch){
	uint16_t data_scaled = (lightSwitch - 0) / 1.0;
	// Set 1-bit signal at bit offset 19
	CAN_mcu_status.payload->word1 &= ~0x0008;
	CAN_mcu_status.payload->word1 |= (data_scaled << 3) & 0x0008;
}
void CAN_mcu_status_assSwitch_set(uint16_t assSwitch){
	uint16_t data_scaled = (assSwitch - 0) / 1.0;
	// Set 1-bit signal at bit offset 20
	CAN_mcu_status.payload->word1 &= ~0x0010;
	CAN_mcu_status.payload->word1 |= (data_scaled << 4) & 0x0010;
}
void CAN_mcu_status_hornSwitch_set(uint16_t hornSwitch){
	uint16_t data_scaled = (hornSwitch - 0) / 1.0;
	// Set 1-bit signal at bit offset 21
	CAN_mcu_status.payload->word1 &= ~0x0020;
	CAN_mcu_status.payload->word1 |= (data_scaled << 5) & 0x0020;
}
void CAN_mcu_status_batt_voltage_set(float batt_voltage){
	uint16_t data_scaled = (uint16_t)((batt_voltage - 0) / 0.1 + 0.5f);
	// Set 8-bit signal at bit offset 22
	CAN_mcu_status.payload->word1 &= ~0x3FC0;
	CAN_mcu_status.payload->word1 |= (data_scaled << 6) & 0x3FC0;
}
void CAN_mcu_status_batt_current_set(float batt_current){
	uint16_t data_scaled = (uint16_t)((batt_current - -33) / 0.001 + 0.5f);
	// Set 16-bit signal at bit offset 30
	CAN_mcu_status.payload->word1 &= ~0xC000;
	CAN_mcu_status.payload->word1 |= (data_scaled << 14) & 0xC000;
	CAN_mcu_status.payload->word2 &= ~0x3FFF;
	CAN_mcu_status.payload->word2 |= (data_scaled >> 2) & 0x3FFF;
}
void CAN_mcu_status_dcdc_current_set(float dcdc_current){
	uint16_t data_scaled = (uint16_t)((dcdc_current - -33) / 0.001 + 0.5f);
	// Set 16-bit signal at bit offset 46
	CAN_mcu_status.payload->word2 &= ~0xC000;
	CAN_mcu_status.payload->word2 |= (data_scaled << 14) & 0xC000;
	CAN_mcu_status.payload->word3 &= ~0x3FFF;
	CAN_mcu_status.payload->word3 |= (data_scaled >> 2) & 0x3FFF;
}
void CAN_mcu_status_batt_fault_set(uint16_t batt_fault){
	uint16_t data_scaled = (batt_fault - 0) / 1.0;
	// Set 1-bit signal at bit offset 62
	CAN_mcu_status.payload->word3 &= ~0x4000;
	CAN_mcu_status.payload->word3 |= (data_scaled << 14) & 0x4000;
}
void CAN_mcu_status_dcdc_fault_set(uint16_t dcdc_fault){
	uint16_t data_scaled = (dcdc_fault - 0) / 1.0;
	// Set 1-bit signal at bit offset 63
	CAN_mcu_status.payload->word3 &= ~0x8000;
	CAN_mcu_status.payload->word3 |= (data_scaled << 15) & 0x8000;
}
void CAN_mcu_status_dlc_set(uint8_t dlc){
	CAN_mcu_status.dlc = dlc;
}
void CAN_mcu_status_send(void){
	// Update message status for self-consumption
	*CAN_mcu_status.canMessageStatus = 1;
	CAN_write(CAN_mcu_status);
}

static CAN_payload_S CAN_mcu_command_payload __attribute__((aligned(sizeof(CAN_payload_S))));
static volatile uint8_t CAN_mcu_command_status = 0;
#define CAN_mcu_command_ID 0x712

static CAN_message_S CAN_mcu_command={
	.canID = CAN_mcu_command_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = &CAN_mcu_command_payload,
	.canMessageStatus = &CAN_mcu_command_status
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

void CAN_mcu_command_DCDC_enable_set(uint16_t DCDC_enable){
	uint16_t data_scaled = (DCDC_enable - 0) / 1.0;
	// Set 1-bit signal at bit offset 0
	CAN_mcu_command.payload->word0 &= ~0x0001;
	CAN_mcu_command.payload->word0 |= data_scaled & 0x0001;
}
void CAN_mcu_command_ev_charger_enable_set(uint16_t ev_charger_enable){
	uint16_t data_scaled = (ev_charger_enable - 0) / 1.0;
	// Set 1-bit signal at bit offset 1
	CAN_mcu_command.payload->word0 &= ~0x0002;
	CAN_mcu_command.payload->word0 |= (data_scaled << 1) & 0x0002;
}
void CAN_mcu_command_ev_charger_current_set(float ev_charger_current){
	uint16_t data_scaled = (uint16_t)((ev_charger_current - 0) / 0.1 + 0.5f);
	// Set 13-bit signal at bit offset 2
	CAN_mcu_command.payload->word0 &= ~0x7FFC;
	CAN_mcu_command.payload->word0 |= (data_scaled << 2) & 0x7FFC;
}
void CAN_mcu_command_precharge_enable_set(uint16_t precharge_enable){
	uint16_t data_scaled = (precharge_enable - 0) / 1.0;
	// Set 1-bit signal at bit offset 15
	CAN_mcu_command.payload->word0 &= ~0x8000;
	CAN_mcu_command.payload->word0 |= (data_scaled << 15) & 0x8000;
}
void CAN_mcu_command_motor_controller_enable_set(uint16_t motor_controller_enable){
	uint16_t data_scaled = (motor_controller_enable - 0) / 1.0;
	// Set 1-bit signal at bit offset 16
	CAN_mcu_command.payload->word1 &= ~0x0001;
	CAN_mcu_command.payload->word1 |= data_scaled & 0x0001;
}
void CAN_mcu_command_dlc_set(uint8_t dlc){
	CAN_mcu_command.dlc = dlc;
}
void CAN_mcu_command_send(void){
	// Update message status for self-consumption
	*CAN_mcu_command.canMessageStatus = 1;
	CAN_write(CAN_mcu_command);
}

static CAN_payload_S CAN_mcu_motorControllerRequest_payload __attribute__((aligned(sizeof(CAN_payload_S))));
static volatile uint8_t CAN_mcu_motorControllerRequest_status = 0;
#define CAN_mcu_motorControllerRequest_ID 0x700

static CAN_message_S CAN_mcu_motorControllerRequest={
	.canID = CAN_mcu_motorControllerRequest_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = &CAN_mcu_motorControllerRequest_payload,
	.canMessageStatus = &CAN_mcu_motorControllerRequest_status
};

#define CAN_MCU_MOTORCONTROLLERREQUEST_REQUESTTYPE_RANGE 8
#define CAN_MCU_MOTORCONTROLLERREQUEST_REQUESTTYPE_OFFSET 0

void CAN_mcu_motorControllerRequest_requestType_set(uint16_t requestType){
	uint16_t data_scaled = (requestType - 0) / 1.0;
	// Set 8-bit signal at bit offset 0
	CAN_mcu_motorControllerRequest.payload->word0 &= ~0x00FF;
	CAN_mcu_motorControllerRequest.payload->word0 |= data_scaled & 0x00FF;
}
void CAN_mcu_motorControllerRequest_dlc_set(uint8_t dlc){
	CAN_mcu_motorControllerRequest.dlc = dlc;
}
void CAN_mcu_motorControllerRequest_send(void){
	// Update message status for self-consumption
	*CAN_mcu_motorControllerRequest.canMessageStatus = 1;
	CAN_write(CAN_mcu_motorControllerRequest);
}

static CAN_payload_S CAN_mcu_boot_response_payload __attribute__((aligned(sizeof(CAN_payload_S))));
static volatile uint8_t CAN_mcu_boot_response_status = 0;
#define CAN_mcu_boot_response_ID 0xa2

static CAN_message_S CAN_mcu_boot_response={
	.canID = CAN_mcu_boot_response_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = &CAN_mcu_boot_response_payload,
	.canMessageStatus = &CAN_mcu_boot_response_status
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

void CAN_mcu_boot_response_type_set(uint16_t type){
	uint16_t data_scaled = (type - 0) / 1.0;
	// Set 4-bit signal at bit offset 0
	CAN_mcu_boot_response.payload->word0 &= ~0x000F;
	CAN_mcu_boot_response.payload->word0 |= data_scaled & 0x000F;
}
void CAN_mcu_boot_response_code_set(uint16_t code){
	uint16_t data_scaled = (code - 0) / 1.0;
	// Set 4-bit signal at bit offset 4
	CAN_mcu_boot_response.payload->word0 &= ~0x00F0;
	CAN_mcu_boot_response.payload->word0 |= (data_scaled << 4) & 0x00F0;
}
void CAN_mcu_boot_response_byte1_set(uint16_t byte1){
	uint16_t data_scaled = (byte1 - 0) / 1.0;
	// Set 8-bit signal at bit offset 8
	CAN_mcu_boot_response.payload->word0 &= ~0xFF00;
	CAN_mcu_boot_response.payload->word0 |= (data_scaled << 8) & 0xFF00;
}
void CAN_mcu_boot_response_byte2_set(uint16_t byte2){
	uint16_t data_scaled = (byte2 - 0) / 1.0;
	// Set 8-bit signal at bit offset 16
	CAN_mcu_boot_response.payload->word1 &= ~0x00FF;
	CAN_mcu_boot_response.payload->word1 |= data_scaled & 0x00FF;
}
void CAN_mcu_boot_response_byte3_set(uint16_t byte3){
	uint16_t data_scaled = (byte3 - 0) / 1.0;
	// Set 8-bit signal at bit offset 24
	CAN_mcu_boot_response.payload->word1 &= ~0xFF00;
	CAN_mcu_boot_response.payload->word1 |= (data_scaled << 8) & 0xFF00;
}
void CAN_mcu_boot_response_byte4_set(uint16_t byte4){
	uint16_t data_scaled = (byte4 - 0) / 1.0;
	// Set 8-bit signal at bit offset 32
	CAN_mcu_boot_response.payload->word2 &= ~0x00FF;
	CAN_mcu_boot_response.payload->word2 |= data_scaled & 0x00FF;
}
void CAN_mcu_boot_response_byte5_set(uint16_t byte5){
	uint16_t data_scaled = (byte5 - 0) / 1.0;
	// Set 8-bit signal at bit offset 40
	CAN_mcu_boot_response.payload->word2 &= ~0xFF00;
	CAN_mcu_boot_response.payload->word2 |= (data_scaled << 8) & 0xFF00;
}
void CAN_mcu_boot_response_byte6_set(uint16_t byte6){
	uint16_t data_scaled = (byte6 - 0) / 1.0;
	// Set 8-bit signal at bit offset 48
	CAN_mcu_boot_response.payload->word3 &= ~0x00FF;
	CAN_mcu_boot_response.payload->word3 |= data_scaled & 0x00FF;
}
void CAN_mcu_boot_response_byte7_set(uint16_t byte7){
	uint16_t data_scaled = (byte7 - 0) / 1.0;
	// Set 8-bit signal at bit offset 56
	CAN_mcu_boot_response.payload->word3 &= ~0xFF00;
	CAN_mcu_boot_response.payload->word3 |= (data_scaled << 8) & 0xFF00;
}
void CAN_mcu_boot_response_dlc_set(uint8_t dlc){
	CAN_mcu_boot_response.dlc = dlc;
}
void CAN_mcu_boot_response_send(void){
	// Update message status for self-consumption
	*CAN_mcu_boot_response.canMessageStatus = 1;
	CAN_write(CAN_mcu_boot_response);
}

static CAN_payload_S CAN_mcu_mcu_debug_payloads[4] __attribute__((aligned(sizeof(CAN_payload_S))));
static uint8_t CAN_mcu_mcu_debug_mux = 0;
static volatile uint8_t CAN_mcu_mcu_debug_status = 0;
#define CAN_mcu_mcu_debug_ID 0x713

static CAN_message_S CAN_mcu_mcu_debug={
	.canID = CAN_mcu_mcu_debug_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = &CAN_mcu_mcu_debug_status
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

void CAN_mcu_mcu_debug_M0_debug_value_1_set(uint16_t debug_value_1){
	uint16_t data_scaled = (debug_value_1 - 0) / 1.0;
	// Set 8-bit signal at bit offset 2
	CAN_mcu_mcu_debug_payloads[0].word0 &= ~0x03FC;
	CAN_mcu_mcu_debug_payloads[0].word0 |= (data_scaled << 2) & 0x03FC;
}
void CAN_mcu_mcu_debug_M0_debug_value_2_set(uint16_t debug_value_2){
	uint16_t data_scaled = (debug_value_2 - 0) / 1.0;
	// Set 8-bit signal at bit offset 10
	CAN_mcu_mcu_debug_payloads[0].word0 &= ~0xFC00;
	CAN_mcu_mcu_debug_payloads[0].word0 |= (data_scaled << 10) & 0xFC00;
	CAN_mcu_mcu_debug_payloads[0].word1 &= ~0x0003;
	CAN_mcu_mcu_debug_payloads[0].word1 |= (data_scaled >> 6) & 0x0003;
}
void CAN_mcu_mcu_debug_M0_debug_value_3_set(uint16_t debug_value_3){
	uint16_t data_scaled = (debug_value_3 - 0) / 1.0;
	// Set 8-bit signal at bit offset 18
	CAN_mcu_mcu_debug_payloads[0].word1 &= ~0x03FC;
	CAN_mcu_mcu_debug_payloads[0].word1 |= (data_scaled << 2) & 0x03FC;
}
void CAN_mcu_mcu_debug_M0_debug_value_4_set(uint16_t debug_value_4){
	uint16_t data_scaled = (debug_value_4 - 0) / 1.0;
	// Set 8-bit signal at bit offset 26
	CAN_mcu_mcu_debug_payloads[0].word1 &= ~0xFC00;
	CAN_mcu_mcu_debug_payloads[0].word1 |= (data_scaled << 10) & 0xFC00;
	CAN_mcu_mcu_debug_payloads[0].word2 &= ~0x0003;
	CAN_mcu_mcu_debug_payloads[0].word2 |= (data_scaled >> 6) & 0x0003;
}
void CAN_mcu_mcu_debug_M1_debug_value_5_set(uint16_t debug_value_5){
	uint16_t data_scaled = (debug_value_5 - 0) / 1.0;
	// Set 8-bit signal at bit offset 2
	CAN_mcu_mcu_debug_payloads[1].word0 &= ~0x03FC;
	CAN_mcu_mcu_debug_payloads[1].word0 |= (data_scaled << 2) & 0x03FC;
}
void CAN_mcu_mcu_debug_M1_debug_value_6_set(uint16_t debug_value_6){
	uint16_t data_scaled = (debug_value_6 - 0) / 1.0;
	// Set 8-bit signal at bit offset 10
	CAN_mcu_mcu_debug_payloads[1].word0 &= ~0xFC00;
	CAN_mcu_mcu_debug_payloads[1].word0 |= (data_scaled << 10) & 0xFC00;
	CAN_mcu_mcu_debug_payloads[1].word1 &= ~0x0003;
	CAN_mcu_mcu_debug_payloads[1].word1 |= (data_scaled >> 6) & 0x0003;
}
void CAN_mcu_mcu_debug_M1_debug_value_7_set(uint16_t debug_value_7){
	uint16_t data_scaled = (debug_value_7 - 0) / 1.0;
	// Set 8-bit signal at bit offset 18
	CAN_mcu_mcu_debug_payloads[1].word1 &= ~0x03FC;
	CAN_mcu_mcu_debug_payloads[1].word1 |= (data_scaled << 2) & 0x03FC;
}
void CAN_mcu_mcu_debug_M1_debug_value_8_set(uint16_t debug_value_8){
	uint16_t data_scaled = (debug_value_8 - 0) / 1.0;
	// Set 8-bit signal at bit offset 26
	CAN_mcu_mcu_debug_payloads[1].word1 &= ~0xFC00;
	CAN_mcu_mcu_debug_payloads[1].word1 |= (data_scaled << 10) & 0xFC00;
	CAN_mcu_mcu_debug_payloads[1].word2 &= ~0x0003;
	CAN_mcu_mcu_debug_payloads[1].word2 |= (data_scaled >> 6) & 0x0003;
}
void CAN_mcu_mcu_debug_M2_debug_value_9_set(uint16_t debug_value_9){
	uint16_t data_scaled = (debug_value_9 - 0) / 1.0;
	// Set 8-bit signal at bit offset 2
	CAN_mcu_mcu_debug_payloads[2].word0 &= ~0x03FC;
	CAN_mcu_mcu_debug_payloads[2].word0 |= (data_scaled << 2) & 0x03FC;
}
void CAN_mcu_mcu_debug_M2_debug_value_10_set(uint16_t debug_value_10){
	uint16_t data_scaled = (debug_value_10 - 0) / 1.0;
	// Set 8-bit signal at bit offset 10
	CAN_mcu_mcu_debug_payloads[2].word0 &= ~0xFC00;
	CAN_mcu_mcu_debug_payloads[2].word0 |= (data_scaled << 10) & 0xFC00;
	CAN_mcu_mcu_debug_payloads[2].word1 &= ~0x0003;
	CAN_mcu_mcu_debug_payloads[2].word1 |= (data_scaled >> 6) & 0x0003;
}
void CAN_mcu_mcu_debug_M2_debug_value_11_set(uint16_t debug_value_11){
	uint16_t data_scaled = (debug_value_11 - 0) / 1.0;
	// Set 8-bit signal at bit offset 18
	CAN_mcu_mcu_debug_payloads[2].word1 &= ~0x03FC;
	CAN_mcu_mcu_debug_payloads[2].word1 |= (data_scaled << 2) & 0x03FC;
}
void CAN_mcu_mcu_debug_M2_debug_value_12_set(uint16_t debug_value_12){
	uint16_t data_scaled = (debug_value_12 - 0) / 1.0;
	// Set 8-bit signal at bit offset 26
	CAN_mcu_mcu_debug_payloads[2].word1 &= ~0xFC00;
	CAN_mcu_mcu_debug_payloads[2].word1 |= (data_scaled << 10) & 0xFC00;
	CAN_mcu_mcu_debug_payloads[2].word2 &= ~0x0003;
	CAN_mcu_mcu_debug_payloads[2].word2 |= (data_scaled >> 6) & 0x0003;
}
void CAN_mcu_mcu_debug_M3_debug_value_13_set(uint16_t debug_value_13){
	uint16_t data_scaled = (debug_value_13 - 0) / 1.0;
	// Set 8-bit signal at bit offset 2
	CAN_mcu_mcu_debug_payloads[3].word0 &= ~0x03FC;
	CAN_mcu_mcu_debug_payloads[3].word0 |= (data_scaled << 2) & 0x03FC;
}
void CAN_mcu_mcu_debug_M3_debug_value_14_set(uint16_t debug_value_14){
	uint16_t data_scaled = (debug_value_14 - 0) / 1.0;
	// Set 8-bit signal at bit offset 10
	CAN_mcu_mcu_debug_payloads[3].word0 &= ~0xFC00;
	CAN_mcu_mcu_debug_payloads[3].word0 |= (data_scaled << 10) & 0xFC00;
	CAN_mcu_mcu_debug_payloads[3].word1 &= ~0x0003;
	CAN_mcu_mcu_debug_payloads[3].word1 |= (data_scaled >> 6) & 0x0003;
}
void CAN_mcu_mcu_debug_M3_debug_value_15_set(uint16_t debug_value_15){
	uint16_t data_scaled = (debug_value_15 - 0) / 1.0;
	// Set 8-bit signal at bit offset 18
	CAN_mcu_mcu_debug_payloads[3].word1 &= ~0x03FC;
	CAN_mcu_mcu_debug_payloads[3].word1 |= (data_scaled << 2) & 0x03FC;
}
void CAN_mcu_mcu_debug_M3_debug_value_16_set(uint16_t debug_value_16){
	uint16_t data_scaled = (debug_value_16 - 0) / 1.0;
	// Set 8-bit signal at bit offset 26
	CAN_mcu_mcu_debug_payloads[3].word1 &= ~0xFC00;
	CAN_mcu_mcu_debug_payloads[3].word1 |= (data_scaled << 10) & 0xFC00;
	CAN_mcu_mcu_debug_payloads[3].word2 &= ~0x0003;
	CAN_mcu_mcu_debug_payloads[3].word2 |= (data_scaled >> 6) & 0x0003;
}
void CAN_mcu_mcu_debug_dlc_set(uint8_t dlc){
	CAN_mcu_mcu_debug.dlc = dlc;
}
void CAN_mcu_mcu_debug_send(void){
	// Update message status for self-consumption
	*CAN_mcu_mcu_debug.canMessageStatus = 1;
	// Auto-select current mux payload
	CAN_mcu_mcu_debug.payload = &CAN_mcu_mcu_debug_payloads[CAN_mcu_mcu_debug_mux];
	// Send the message
	CAN_write(CAN_mcu_mcu_debug);
	// Increment mux counter for next time
	CAN_mcu_mcu_debug_mux++;
	if (CAN_mcu_mcu_debug_mux >= CAN_MCU_MCU_DEBUG_NUM_MUX_VALUES) {
		CAN_mcu_mcu_debug_mux = 0;
	}
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
#define CAN_BMS_STATUS_M0_BMS_STATE_RANGE 4
#define CAN_BMS_STATUS_M0_BMS_STATE_OFFSET 2
#define CAN_BMS_STATUS_M0_PACK_VOLTAGE_RANGE 16
#define CAN_BMS_STATUS_M0_PACK_VOLTAGE_OFFSET 6
#define CAN_BMS_STATUS_M0_PACK_CURRENT_RANGE 16
#define CAN_BMS_STATUS_M0_PACK_CURRENT_OFFSET 22
#define CAN_BMS_STATUS_M0_SOC_PERCENT_RANGE 8
#define CAN_BMS_STATUS_M0_SOC_PERCENT_OFFSET 38
#define CAN_BMS_STATUS_M0_PACK_TEMP_MIN_RANGE 8
#define CAN_BMS_STATUS_M0_PACK_TEMP_MIN_OFFSET 46
#define CAN_BMS_STATUS_M0_PACK_TEMP_MAX_RANGE 8
#define CAN_BMS_STATUS_M0_PACK_TEMP_MAX_OFFSET 54
#define CAN_BMS_STATUS_M1_STACK_VOLTAGE_1_RANGE 16
#define CAN_BMS_STATUS_M1_STACK_VOLTAGE_1_OFFSET 2
#define CAN_BMS_STATUS_M1_STACK_VOLTAGE_2_RANGE 16
#define CAN_BMS_STATUS_M1_STACK_VOLTAGE_2_OFFSET 18
#define CAN_BMS_STATUS_M1_PACK_VOLTAGE_SUM_OF_STACKS_RANGE 18
#define CAN_BMS_STATUS_M1_PACK_VOLTAGE_SUM_OF_STACKS_OFFSET 34
#define CAN_BMS_STATUS_M1_DEBUG_SIGNAL_1_RANGE 12
#define CAN_BMS_STATUS_M1_DEBUG_SIGNAL_1_OFFSET 52
#define CAN_BMS_STATUS_M2_LTC_STATE_RANGE 4
#define CAN_BMS_STATUS_M2_LTC_STATE_OFFSET 2
#define CAN_BMS_STATUS_M2_LTC_ERROR_COUNT_RANGE 12
#define CAN_BMS_STATUS_M2_LTC_ERROR_COUNT_OFFSET 6
#define CAN_BMS_STATUS_M2_LTC_LAST_ERROR_RANGE 8
#define CAN_BMS_STATUS_M2_LTC_LAST_ERROR_OFFSET 18
#define CAN_BMS_STATUS_M2_CPU_USAGE_PERCENT_RANGE 8
#define CAN_BMS_STATUS_M2_CPU_USAGE_PERCENT_OFFSET 26
#define CAN_BMS_STATUS_M2_CPU_PEAK_PERCENT_RANGE 8
#define CAN_BMS_STATUS_M2_CPU_PEAK_PERCENT_OFFSET 34
#define CAN_BMS_STATUS_M2_VBUS_VOLTAGE_RANGE 10
#define CAN_BMS_STATUS_M2_VBUS_VOLTAGE_OFFSET 42
#define CAN_BMS_STATUS_M2_INTERNAL_TEMP_RANGE 8
#define CAN_BMS_STATUS_M2_INTERNAL_TEMP_OFFSET 52
#define CAN_BMS_STATUS_M3_MAX_CHARGE_CURRENT_MA_RANGE 16
#define CAN_BMS_STATUS_M3_MAX_CHARGE_CURRENT_MA_OFFSET 2
#define CAN_BMS_STATUS_M3_MAX_CHARGE_VOLTAGE_MV_RANGE 18
#define CAN_BMS_STATUS_M3_MAX_CHARGE_VOLTAGE_MV_OFFSET 18
#define CAN_BMS_STATUS_M3_CONTACTORS_CLOSED_RANGE 1
#define CAN_BMS_STATUS_M3_CONTACTORS_CLOSED_OFFSET 36
#define CAN_BMS_STATUS_M3_PRECHARGE_ACTIVE_RANGE 1
#define CAN_BMS_STATUS_M3_PRECHARGE_ACTIVE_OFFSET 37
#define CAN_BMS_STATUS_M3_CHARGE_ENABLED_RANGE 1
#define CAN_BMS_STATUS_M3_CHARGE_ENABLED_OFFSET 38
#define CAN_BMS_STATUS_M3_DISCHARGE_ENABLED_RANGE 1
#define CAN_BMS_STATUS_M3_DISCHARGE_ENABLED_OFFSET 39
#define CAN_BMS_STATUS_M3_FAULT_SUMMARY_RANGE 12
#define CAN_BMS_STATUS_M3_FAULT_SUMMARY_OFFSET 40

uint8_t CAN_bms_status_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_bms_status);
}
uint16_t CAN_bms_status_multiplex_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_status.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_MULTIPLEX_OFFSET, CAN_BMS_STATUS_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_status_payloads[mux_value] = *CAN_bms_status.payload;
		}
	}
	
	// Extract 2-bit signal at bit offset 0
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status.payload->word0 & 0x0003) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_M0_bms_state_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_status.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_MULTIPLEX_OFFSET, CAN_BMS_STATUS_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_status_payloads[mux_value] = *CAN_bms_status.payload;
		}
	}
	
	// Extract 4-bit signal at bit offset 2
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[0].word0 & 0x003C) >> 2) << 0;
	return (data * 1.0) + 0;
}
float CAN_bms_status_M0_pack_voltage_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_status.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_MULTIPLEX_OFFSET, CAN_BMS_STATUS_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_status_payloads[mux_value] = *CAN_bms_status.payload;
		}
	}
	
	// Extract 16-bit signal at bit offset 6
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[0].word0 & 0xFFC0) >> 6) << 0;
	data |= (uint16_t)((CAN_bms_status_payloads[0].word1 & 0x003F) >> 0) << 10;
	return (data * 0.01) + 0;
}
float CAN_bms_status_M0_pack_current_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_status.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_MULTIPLEX_OFFSET, CAN_BMS_STATUS_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_status_payloads[mux_value] = *CAN_bms_status.payload;
		}
	}
	
	// Extract 16-bit signal at bit offset 22
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[0].word1 & 0xFFC0) >> 6) << 0;
	data |= (uint16_t)((CAN_bms_status_payloads[0].word2 & 0x003F) >> 0) << 10;
	return (data * 0.01) + -320;
}
float CAN_bms_status_M0_soc_percent_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_status.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_MULTIPLEX_OFFSET, CAN_BMS_STATUS_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_status_payloads[mux_value] = *CAN_bms_status.payload;
		}
	}
	
	// Extract 8-bit signal at bit offset 38
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[0].word2 & 0x3FC0) >> 6) << 0;
	return (data * 0.5) + 0;
}
float CAN_bms_status_M0_pack_temp_min_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_status.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_MULTIPLEX_OFFSET, CAN_BMS_STATUS_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_status_payloads[mux_value] = *CAN_bms_status.payload;
		}
	}
	
	// Extract 8-bit signal at bit offset 46
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[0].word2 & 0xC000) >> 14) << 0;
	data |= (uint16_t)((CAN_bms_status_payloads[0].word3 & 0x003F) >> 0) << 2;
	return (data * 1.0) + -40;
}
float CAN_bms_status_M0_pack_temp_max_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_status.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_MULTIPLEX_OFFSET, CAN_BMS_STATUS_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_status_payloads[mux_value] = *CAN_bms_status.payload;
		}
	}
	
	// Extract 8-bit signal at bit offset 54
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[0].word3 & 0x3FC0) >> 6) << 0;
	return (data * 1.0) + -40;
}
float CAN_bms_status_M1_stack_voltage_1_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_status.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_MULTIPLEX_OFFSET, CAN_BMS_STATUS_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_status_payloads[mux_value] = *CAN_bms_status.payload;
		}
	}
	
	// Extract 16-bit signal at bit offset 2
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[1].word0 & 0xFFFC) >> 2) << 0;
	data |= (uint16_t)((CAN_bms_status_payloads[1].word1 & 0x0003) >> 0) << 14;
	return (data * 0.001) + 0;
}
float CAN_bms_status_M1_stack_voltage_2_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_status.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_MULTIPLEX_OFFSET, CAN_BMS_STATUS_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_status_payloads[mux_value] = *CAN_bms_status.payload;
		}
	}
	
	// Extract 16-bit signal at bit offset 18
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[1].word1 & 0xFFFC) >> 2) << 0;
	data |= (uint16_t)((CAN_bms_status_payloads[1].word2 & 0x0003) >> 0) << 14;
	return (data * 0.001) + 0;
}
float CAN_bms_status_M1_pack_voltage_sum_of_stacks_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_status.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_MULTIPLEX_OFFSET, CAN_BMS_STATUS_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_status_payloads[mux_value] = *CAN_bms_status.payload;
		}
	}
	
	// Extract 18-bit signal at bit offset 34
	uint32_t data = 0;
	data |= (uint32_t)((CAN_bms_status_payloads[1].word2 & 0xFFFC) >> 2) << 0;
	data |= (uint32_t)((CAN_bms_status_payloads[1].word3 & 0x000F) >> 0) << 14;
	return (data * 0.001) + 0;
}
uint16_t CAN_bms_status_M1_debug_signal_1_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_status.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_MULTIPLEX_OFFSET, CAN_BMS_STATUS_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_status_payloads[mux_value] = *CAN_bms_status.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 52
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[1].word3 & 0xFFF0) >> 4) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_M2_ltc_state_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_status.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_MULTIPLEX_OFFSET, CAN_BMS_STATUS_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_status_payloads[mux_value] = *CAN_bms_status.payload;
		}
	}
	
	// Extract 4-bit signal at bit offset 2
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[2].word0 & 0x003C) >> 2) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_M2_ltc_error_count_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_status.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_MULTIPLEX_OFFSET, CAN_BMS_STATUS_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_status_payloads[mux_value] = *CAN_bms_status.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 6
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[2].word0 & 0xFFC0) >> 6) << 0;
	data |= (uint16_t)((CAN_bms_status_payloads[2].word1 & 0x0003) >> 0) << 10;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_M2_ltc_last_error_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_status.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_MULTIPLEX_OFFSET, CAN_BMS_STATUS_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_status_payloads[mux_value] = *CAN_bms_status.payload;
		}
	}
	
	// Extract 8-bit signal at bit offset 18
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[2].word1 & 0x03FC) >> 2) << 0;
	return (data * 1.0) + 0;
}
float CAN_bms_status_M2_cpu_usage_percent_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_status.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_MULTIPLEX_OFFSET, CAN_BMS_STATUS_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_status_payloads[mux_value] = *CAN_bms_status.payload;
		}
	}
	
	// Extract 8-bit signal at bit offset 26
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[2].word1 & 0xFC00) >> 10) << 0;
	data |= (uint16_t)((CAN_bms_status_payloads[2].word2 & 0x0003) >> 0) << 6;
	return (data * 0.5) + 0;
}
float CAN_bms_status_M2_cpu_peak_percent_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_status.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_MULTIPLEX_OFFSET, CAN_BMS_STATUS_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_status_payloads[mux_value] = *CAN_bms_status.payload;
		}
	}
	
	// Extract 8-bit signal at bit offset 34
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[2].word2 & 0x03FC) >> 2) << 0;
	return (data * 0.5) + 0;
}
float CAN_bms_status_M2_vbus_voltage_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_status.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_MULTIPLEX_OFFSET, CAN_BMS_STATUS_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_status_payloads[mux_value] = *CAN_bms_status.payload;
		}
	}
	
	// Extract 10-bit signal at bit offset 42
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[2].word2 & 0xFC00) >> 10) << 0;
	data |= (uint16_t)((CAN_bms_status_payloads[2].word3 & 0x000F) >> 0) << 6;
	return (data * 0.1) + 0;
}
float CAN_bms_status_M2_internal_temp_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_status.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_MULTIPLEX_OFFSET, CAN_BMS_STATUS_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_status_payloads[mux_value] = *CAN_bms_status.payload;
		}
	}
	
	// Extract 8-bit signal at bit offset 52
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[2].word3 & 0x0FF0) >> 4) << 0;
	return (data * 1.0) + -40;
}
uint16_t CAN_bms_status_M3_max_charge_current_mA_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_status.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_MULTIPLEX_OFFSET, CAN_BMS_STATUS_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_status_payloads[mux_value] = *CAN_bms_status.payload;
		}
	}
	
	// Extract 16-bit signal at bit offset 2
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[3].word0 & 0xFFFC) >> 2) << 0;
	data |= (uint16_t)((CAN_bms_status_payloads[3].word1 & 0x0003) >> 0) << 14;
	return (data * 1.0) + 0;
}
uint32_t CAN_bms_status_M3_max_charge_voltage_mV_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_status.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_MULTIPLEX_OFFSET, CAN_BMS_STATUS_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_status_payloads[mux_value] = *CAN_bms_status.payload;
		}
	}
	
	// Extract 18-bit signal at bit offset 18
	uint32_t data = 0;
	data |= (uint32_t)((CAN_bms_status_payloads[3].word1 & 0xFFFC) >> 2) << 0;
	data |= (uint32_t)((CAN_bms_status_payloads[3].word2 & 0x000F) >> 0) << 14;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_M3_contactors_closed_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_status.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_MULTIPLEX_OFFSET, CAN_BMS_STATUS_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_status_payloads[mux_value] = *CAN_bms_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 36
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[3].word2 & 0x0010) >> 4) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_M3_precharge_active_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_status.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_MULTIPLEX_OFFSET, CAN_BMS_STATUS_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_status_payloads[mux_value] = *CAN_bms_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 37
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[3].word2 & 0x0020) >> 5) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_M3_charge_enabled_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_status.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_MULTIPLEX_OFFSET, CAN_BMS_STATUS_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_status_payloads[mux_value] = *CAN_bms_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 38
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[3].word2 & 0x0040) >> 6) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_M3_discharge_enabled_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_status.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_MULTIPLEX_OFFSET, CAN_BMS_STATUS_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_status_payloads[mux_value] = *CAN_bms_status.payload;
		}
	}
	
	// Extract 1-bit signal at bit offset 39
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[3].word2 & 0x0080) >> 7) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_M3_fault_summary_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_status.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_MULTIPLEX_OFFSET, CAN_BMS_STATUS_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_STATUS_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_status_payloads[mux_value] = *CAN_bms_status.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 40
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_status_payloads[3].word2 & 0xFF00) >> 8) << 0;
	data |= (uint16_t)((CAN_bms_status_payloads[3].word3 & 0x000F) >> 0) << 8;
	return (data * 1.0) + 0;
}

#define CAN_bms_power_systems_ID 0x722

static CAN_message_S CAN_bms_power_systems={
	.canID = CAN_bms_power_systems_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
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

uint8_t CAN_bms_power_systems_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_bms_power_systems);
}
uint16_t CAN_bms_power_systems_DCDC_state_get(void){
	// Extract 1-bit signal at bit offset 0
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_power_systems.payload->word0 & 0x0001) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_power_systems_DCDC_fault_get(void){
	// Extract 1-bit signal at bit offset 1
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_power_systems.payload->word0 & 0x0002) >> 1) << 0;
	return (data * 1.0) + 0;
}
float CAN_bms_power_systems_DCDC_voltage_get(void){
	// Extract 10-bit signal at bit offset 2
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_power_systems.payload->word0 & 0x0FFC) >> 2) << 0;
	return (data * 0.1) + 0;
}
float CAN_bms_power_systems_DCDC_current_get(void){
	// Extract 10-bit signal at bit offset 12
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_power_systems.payload->word0 & 0xF000) >> 12) << 0;
	data |= (uint16_t)((CAN_bms_power_systems.payload->word1 & 0x003F) >> 0) << 4;
	return (data * 0.1) + 0;
}
uint16_t CAN_bms_power_systems_EV_charger_state_get(void){
	// Extract 1-bit signal at bit offset 22
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_power_systems.payload->word1 & 0x0040) >> 6) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_power_systems_EV_charger_fault_get(void){
	// Extract 1-bit signal at bit offset 23
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_power_systems.payload->word1 & 0x0080) >> 7) << 0;
	return (data * 1.0) + 0;
}
float CAN_bms_power_systems_EV_charger_voltage_get(void){
	// Extract 10-bit signal at bit offset 24
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_power_systems.payload->word1 & 0xFF00) >> 8) << 0;
	data |= (uint16_t)((CAN_bms_power_systems.payload->word2 & 0x0003) >> 0) << 8;
	return (data * 0.1) + 0;
}
float CAN_bms_power_systems_EV_charger_current_get(void){
	// Extract 10-bit signal at bit offset 34
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_power_systems.payload->word2 & 0x0FFC) >> 2) << 0;
	return (data * 0.1) + -50;
}
uint16_t CAN_bms_power_systems_HV_precharge_state_get(void){
	// Extract 1-bit signal at bit offset 44
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_power_systems.payload->word2 & 0x1000) >> 12) << 0;
	return (data * 1.0) + 0;
}
float CAN_bms_power_systems_HV_isolation_voltage_get(void){
	// Extract 10-bit signal at bit offset 45
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_power_systems.payload->word2 & 0xE000) >> 13) << 0;
	data |= (uint16_t)((CAN_bms_power_systems.payload->word3 & 0x007F) >> 0) << 3;
	return (data * 0.1) + 0;
}
uint16_t CAN_bms_power_systems_HV_contactor_state_get(void){
	// Extract 1-bit signal at bit offset 55
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_power_systems.payload->word3 & 0x0080) >> 7) << 0;
	return (data * 1.0) + 0;
}

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

uint8_t CAN_bms_debug_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_bms_debug);
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

static CAN_payload_S CAN_bms_cell_voltages_payloads[6] __attribute__((aligned(sizeof(CAN_payload_S))));
static uint8_t CAN_bms_cell_voltages_mux = 0;
#define CAN_bms_cell_voltages_ID 0x725

static CAN_message_S CAN_bms_cell_voltages={
	.canID = CAN_bms_cell_voltages_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
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

uint8_t CAN_bms_cell_voltages_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_bms_cell_voltages);
}
uint16_t CAN_bms_cell_voltages_multiplex_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_voltages.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_voltages.payload, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_OFFSET, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_voltages_payloads[mux_value] = *CAN_bms_cell_voltages.payload;
		}
	}
	
	// Extract 3-bit signal at bit offset 0
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_voltages.payload->word0 & 0x0007) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_cell_voltages_M0_cell_1_voltage_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_voltages.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_voltages.payload, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_OFFSET, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_voltages_payloads[mux_value] = *CAN_bms_cell_voltages.payload;
		}
	}
	
	// Extract 15-bit signal at bit offset 3
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[0].word0 & 0xFFF8) >> 3) << 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[0].word1 & 0x0003) >> 0) << 13;
	return (data * 1) + 0;
}
uint16_t CAN_bms_cell_voltages_M0_cell_2_voltage_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_voltages.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_voltages.payload, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_OFFSET, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_voltages_payloads[mux_value] = *CAN_bms_cell_voltages.payload;
		}
	}
	
	// Extract 15-bit signal at bit offset 18
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[0].word1 & 0xFFFC) >> 2) << 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[0].word2 & 0x0001) >> 0) << 14;
	return (data * 1) + 0;
}
uint16_t CAN_bms_cell_voltages_M0_cell_3_voltage_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_voltages.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_voltages.payload, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_OFFSET, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_voltages_payloads[mux_value] = *CAN_bms_cell_voltages.payload;
		}
	}
	
	// Extract 15-bit signal at bit offset 33
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[0].word2 & 0xFFFE) >> 1) << 0;
	return (data * 1) + 0;
}
uint16_t CAN_bms_cell_voltages_M0_cell_4_voltage_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_voltages.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_voltages.payload, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_OFFSET, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_voltages_payloads[mux_value] = *CAN_bms_cell_voltages.payload;
		}
	}
	
	// Extract 15-bit signal at bit offset 48
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[0].word3 & 0x7FFF) >> 0) << 0;
	return (data * 1) + 0;
}
uint16_t CAN_bms_cell_voltages_M1_cell_5_voltage_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_voltages.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_voltages.payload, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_OFFSET, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_voltages_payloads[mux_value] = *CAN_bms_cell_voltages.payload;
		}
	}
	
	// Extract 15-bit signal at bit offset 3
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[1].word0 & 0xFFF8) >> 3) << 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[1].word1 & 0x0003) >> 0) << 13;
	return (data * 1) + 0;
}
uint16_t CAN_bms_cell_voltages_M1_cell_6_voltage_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_voltages.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_voltages.payload, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_OFFSET, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_voltages_payloads[mux_value] = *CAN_bms_cell_voltages.payload;
		}
	}
	
	// Extract 15-bit signal at bit offset 18
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[1].word1 & 0xFFFC) >> 2) << 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[1].word2 & 0x0001) >> 0) << 14;
	return (data * 1) + 0;
}
uint16_t CAN_bms_cell_voltages_M1_cell_7_voltage_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_voltages.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_voltages.payload, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_OFFSET, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_voltages_payloads[mux_value] = *CAN_bms_cell_voltages.payload;
		}
	}
	
	// Extract 15-bit signal at bit offset 33
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[1].word2 & 0xFFFE) >> 1) << 0;
	return (data * 1) + 0;
}
uint16_t CAN_bms_cell_voltages_M1_cell_8_voltage_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_voltages.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_voltages.payload, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_OFFSET, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_voltages_payloads[mux_value] = *CAN_bms_cell_voltages.payload;
		}
	}
	
	// Extract 15-bit signal at bit offset 48
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[1].word3 & 0x7FFF) >> 0) << 0;
	return (data * 1) + 0;
}
uint16_t CAN_bms_cell_voltages_M2_cell_9_voltage_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_voltages.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_voltages.payload, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_OFFSET, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_voltages_payloads[mux_value] = *CAN_bms_cell_voltages.payload;
		}
	}
	
	// Extract 15-bit signal at bit offset 3
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[2].word0 & 0xFFF8) >> 3) << 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[2].word1 & 0x0003) >> 0) << 13;
	return (data * 1) + 0;
}
uint16_t CAN_bms_cell_voltages_M2_cell_10_voltage_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_voltages.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_voltages.payload, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_OFFSET, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_voltages_payloads[mux_value] = *CAN_bms_cell_voltages.payload;
		}
	}
	
	// Extract 15-bit signal at bit offset 18
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[2].word1 & 0xFFFC) >> 2) << 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[2].word2 & 0x0001) >> 0) << 14;
	return (data * 1) + 0;
}
uint16_t CAN_bms_cell_voltages_M2_cell_11_voltage_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_voltages.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_voltages.payload, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_OFFSET, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_voltages_payloads[mux_value] = *CAN_bms_cell_voltages.payload;
		}
	}
	
	// Extract 15-bit signal at bit offset 33
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[2].word2 & 0xFFFE) >> 1) << 0;
	return (data * 1) + 0;
}
uint16_t CAN_bms_cell_voltages_M2_cell_12_voltage_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_voltages.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_voltages.payload, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_OFFSET, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_voltages_payloads[mux_value] = *CAN_bms_cell_voltages.payload;
		}
	}
	
	// Extract 15-bit signal at bit offset 48
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[2].word3 & 0x7FFF) >> 0) << 0;
	return (data * 1) + 0;
}
uint16_t CAN_bms_cell_voltages_M3_cell_13_voltage_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_voltages.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_voltages.payload, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_OFFSET, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_voltages_payloads[mux_value] = *CAN_bms_cell_voltages.payload;
		}
	}
	
	// Extract 15-bit signal at bit offset 3
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[3].word0 & 0xFFF8) >> 3) << 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[3].word1 & 0x0003) >> 0) << 13;
	return (data * 1) + 0;
}
uint16_t CAN_bms_cell_voltages_M3_cell_14_voltage_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_voltages.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_voltages.payload, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_OFFSET, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_voltages_payloads[mux_value] = *CAN_bms_cell_voltages.payload;
		}
	}
	
	// Extract 15-bit signal at bit offset 18
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[3].word1 & 0xFFFC) >> 2) << 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[3].word2 & 0x0001) >> 0) << 14;
	return (data * 1) + 0;
}
uint16_t CAN_bms_cell_voltages_M3_cell_15_voltage_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_voltages.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_voltages.payload, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_OFFSET, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_voltages_payloads[mux_value] = *CAN_bms_cell_voltages.payload;
		}
	}
	
	// Extract 15-bit signal at bit offset 33
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[3].word2 & 0xFFFE) >> 1) << 0;
	return (data * 1) + 0;
}
uint16_t CAN_bms_cell_voltages_M3_cell_16_voltage_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_voltages.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_voltages.payload, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_OFFSET, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_voltages_payloads[mux_value] = *CAN_bms_cell_voltages.payload;
		}
	}
	
	// Extract 15-bit signal at bit offset 48
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[3].word3 & 0x7FFF) >> 0) << 0;
	return (data * 1) + 0;
}
uint16_t CAN_bms_cell_voltages_M4_cell_17_voltage_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_voltages.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_voltages.payload, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_OFFSET, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_voltages_payloads[mux_value] = *CAN_bms_cell_voltages.payload;
		}
	}
	
	// Extract 15-bit signal at bit offset 3
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[4].word0 & 0xFFF8) >> 3) << 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[4].word1 & 0x0003) >> 0) << 13;
	return (data * 1) + 0;
}
uint16_t CAN_bms_cell_voltages_M4_cell_18_voltage_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_voltages.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_voltages.payload, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_OFFSET, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_voltages_payloads[mux_value] = *CAN_bms_cell_voltages.payload;
		}
	}
	
	// Extract 15-bit signal at bit offset 18
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[4].word1 & 0xFFFC) >> 2) << 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[4].word2 & 0x0001) >> 0) << 14;
	return (data * 1) + 0;
}
uint16_t CAN_bms_cell_voltages_M4_cell_19_voltage_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_voltages.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_voltages.payload, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_OFFSET, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_voltages_payloads[mux_value] = *CAN_bms_cell_voltages.payload;
		}
	}
	
	// Extract 15-bit signal at bit offset 33
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[4].word2 & 0xFFFE) >> 1) << 0;
	return (data * 1) + 0;
}
uint16_t CAN_bms_cell_voltages_M4_cell_20_voltage_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_voltages.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_voltages.payload, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_OFFSET, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_voltages_payloads[mux_value] = *CAN_bms_cell_voltages.payload;
		}
	}
	
	// Extract 15-bit signal at bit offset 48
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[4].word3 & 0x7FFF) >> 0) << 0;
	return (data * 1) + 0;
}
uint16_t CAN_bms_cell_voltages_M5_cell_21_voltage_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_voltages.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_voltages.payload, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_OFFSET, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_voltages_payloads[mux_value] = *CAN_bms_cell_voltages.payload;
		}
	}
	
	// Extract 15-bit signal at bit offset 3
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[5].word0 & 0xFFF8) >> 3) << 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[5].word1 & 0x0003) >> 0) << 13;
	return (data * 1) + 0;
}
uint16_t CAN_bms_cell_voltages_M5_cell_22_voltage_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_voltages.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_voltages.payload, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_OFFSET, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_voltages_payloads[mux_value] = *CAN_bms_cell_voltages.payload;
		}
	}
	
	// Extract 15-bit signal at bit offset 18
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[5].word1 & 0xFFFC) >> 2) << 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[5].word2 & 0x0001) >> 0) << 14;
	return (data * 1) + 0;
}
uint16_t CAN_bms_cell_voltages_M5_cell_23_voltage_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_voltages.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_voltages.payload, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_OFFSET, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_voltages_payloads[mux_value] = *CAN_bms_cell_voltages.payload;
		}
	}
	
	// Extract 15-bit signal at bit offset 33
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[5].word2 & 0xFFFE) >> 1) << 0;
	return (data * 1) + 0;
}
uint16_t CAN_bms_cell_voltages_M5_cell_24_voltage_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_voltages.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_voltages.payload, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_OFFSET, CAN_BMS_CELL_VOLTAGES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_VOLTAGES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_voltages_payloads[mux_value] = *CAN_bms_cell_voltages.payload;
		}
	}
	
	// Extract 15-bit signal at bit offset 48
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_voltages_payloads[5].word3 & 0x7FFF) >> 0) << 0;
	return (data * 1) + 0;
}

static CAN_payload_S CAN_bms_cell_temperatures_payloads[6] __attribute__((aligned(sizeof(CAN_payload_S))));
static uint8_t CAN_bms_cell_temperatures_mux = 0;
#define CAN_bms_cell_temperatures_ID 0x726

static CAN_message_S CAN_bms_cell_temperatures={
	.canID = CAN_bms_cell_temperatures_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
};

#define CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_RANGE 3
#define CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_OFFSET 0
#define CAN_BMS_CELL_TEMPERATURES_M0_EXT_TEMP_1_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M0_EXT_TEMP_1_OFFSET 3
#define CAN_BMS_CELL_TEMPERATURES_M0_STACK_VOLTAGE_1_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M0_STACK_VOLTAGE_1_OFFSET 15
#define CAN_BMS_CELL_TEMPERATURES_M0_INT_VOLTAGE_1_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M0_INT_VOLTAGE_1_OFFSET 27
#define CAN_BMS_CELL_TEMPERATURES_M0_TEMP_4_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M0_TEMP_4_OFFSET 39
#define CAN_BMS_CELL_TEMPERATURES_M1_TEMP_5_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M1_TEMP_5_OFFSET 3
#define CAN_BMS_CELL_TEMPERATURES_M1_TEMP_6_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M1_TEMP_6_OFFSET 15
#define CAN_BMS_CELL_TEMPERATURES_M1_TEMP_7_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M1_TEMP_7_OFFSET 27
#define CAN_BMS_CELL_TEMPERATURES_M1_TEMP_8_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M1_TEMP_8_OFFSET 39
#define CAN_BMS_CELL_TEMPERATURES_M2_TEMP_9_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M2_TEMP_9_OFFSET 3
#define CAN_BMS_CELL_TEMPERATURES_M2_TEMP_10_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M2_TEMP_10_OFFSET 15
#define CAN_BMS_CELL_TEMPERATURES_M2_TEMP_11_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M2_TEMP_11_OFFSET 27
#define CAN_BMS_CELL_TEMPERATURES_M2_TEMP_12_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M2_TEMP_12_OFFSET 39
#define CAN_BMS_CELL_TEMPERATURES_M3_TEMP_13_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M3_TEMP_13_OFFSET 3
#define CAN_BMS_CELL_TEMPERATURES_M3_TEMP_14_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M3_TEMP_14_OFFSET 15
#define CAN_BMS_CELL_TEMPERATURES_M3_TEMP_15_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M3_TEMP_15_OFFSET 27
#define CAN_BMS_CELL_TEMPERATURES_M3_TEMP_16_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M3_TEMP_16_OFFSET 39
#define CAN_BMS_CELL_TEMPERATURES_M4_TEMP_17_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M4_TEMP_17_OFFSET 3
#define CAN_BMS_CELL_TEMPERATURES_M4_TEMP_18_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M4_TEMP_18_OFFSET 15
#define CAN_BMS_CELL_TEMPERATURES_M4_TEMP_19_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M4_TEMP_19_OFFSET 27
#define CAN_BMS_CELL_TEMPERATURES_M4_TEMP_20_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M4_TEMP_20_OFFSET 39
#define CAN_BMS_CELL_TEMPERATURES_M5_TEMP_21_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M5_TEMP_21_OFFSET 3
#define CAN_BMS_CELL_TEMPERATURES_M5_TEMP_22_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M5_TEMP_22_OFFSET 15
#define CAN_BMS_CELL_TEMPERATURES_M5_TEMP_23_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M5_TEMP_23_OFFSET 27
#define CAN_BMS_CELL_TEMPERATURES_M5_TEMP_24_RANGE 12
#define CAN_BMS_CELL_TEMPERATURES_M5_TEMP_24_OFFSET 39

uint8_t CAN_bms_cell_temperatures_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_bms_cell_temperatures);
}
uint16_t CAN_bms_cell_temperatures_multiplex_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_temperatures.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_temperatures.payload, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_OFFSET, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_temperatures_payloads[mux_value] = *CAN_bms_cell_temperatures.payload;
		}
	}
	
	// Extract 3-bit signal at bit offset 0
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures.payload->word0 & 0x0007) >> 0) << 0;
	return (data * 1.0) + 0;
}
float CAN_bms_cell_temperatures_M0_ext_temp_1_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_temperatures.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_temperatures.payload, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_OFFSET, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_temperatures_payloads[mux_value] = *CAN_bms_cell_temperatures.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 3
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[0].word0 & 0x7FF8) >> 3) << 0;
	return (data * 0.1) + -40;
}
float CAN_bms_cell_temperatures_M0_stack_voltage_1_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_temperatures.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_temperatures.payload, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_OFFSET, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_temperatures_payloads[mux_value] = *CAN_bms_cell_temperatures.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 15
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[0].word0 & 0x8000) >> 15) << 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[0].word1 & 0x07FF) >> 0) << 1;
	return (data * 0.1) + 0;
}
float CAN_bms_cell_temperatures_M0_int_voltage_1_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_temperatures.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_temperatures.payload, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_OFFSET, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_temperatures_payloads[mux_value] = *CAN_bms_cell_temperatures.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 27
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[0].word1 & 0xF800) >> 11) << 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[0].word2 & 0x007F) >> 0) << 5;
	return (data * 0.1) + -40;
}
float CAN_bms_cell_temperatures_M0_temp_4_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_temperatures.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_temperatures.payload, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_OFFSET, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_temperatures_payloads[mux_value] = *CAN_bms_cell_temperatures.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 39
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[0].word2 & 0xFF80) >> 7) << 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[0].word3 & 0x0007) >> 0) << 9;
	return (data * 0.1) + -40;
}
float CAN_bms_cell_temperatures_M1_temp_5_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_temperatures.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_temperatures.payload, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_OFFSET, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_temperatures_payloads[mux_value] = *CAN_bms_cell_temperatures.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 3
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[1].word0 & 0x7FF8) >> 3) << 0;
	return (data * 0.1) + -40;
}
float CAN_bms_cell_temperatures_M1_temp_6_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_temperatures.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_temperatures.payload, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_OFFSET, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_temperatures_payloads[mux_value] = *CAN_bms_cell_temperatures.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 15
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[1].word0 & 0x8000) >> 15) << 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[1].word1 & 0x07FF) >> 0) << 1;
	return (data * 0.1) + -40;
}
float CAN_bms_cell_temperatures_M1_temp_7_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_temperatures.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_temperatures.payload, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_OFFSET, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_temperatures_payloads[mux_value] = *CAN_bms_cell_temperatures.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 27
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[1].word1 & 0xF800) >> 11) << 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[1].word2 & 0x007F) >> 0) << 5;
	return (data * 0.1) + -40;
}
float CAN_bms_cell_temperatures_M1_temp_8_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_temperatures.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_temperatures.payload, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_OFFSET, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_temperatures_payloads[mux_value] = *CAN_bms_cell_temperatures.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 39
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[1].word2 & 0xFF80) >> 7) << 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[1].word3 & 0x0007) >> 0) << 9;
	return (data * 0.1) + -40;
}
float CAN_bms_cell_temperatures_M2_temp_9_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_temperatures.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_temperatures.payload, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_OFFSET, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_temperatures_payloads[mux_value] = *CAN_bms_cell_temperatures.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 3
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[2].word0 & 0x7FF8) >> 3) << 0;
	return (data * 0.1) + -40;
}
float CAN_bms_cell_temperatures_M2_temp_10_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_temperatures.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_temperatures.payload, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_OFFSET, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_temperatures_payloads[mux_value] = *CAN_bms_cell_temperatures.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 15
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[2].word0 & 0x8000) >> 15) << 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[2].word1 & 0x07FF) >> 0) << 1;
	return (data * 0.1) + -40;
}
float CAN_bms_cell_temperatures_M2_temp_11_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_temperatures.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_temperatures.payload, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_OFFSET, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_temperatures_payloads[mux_value] = *CAN_bms_cell_temperatures.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 27
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[2].word1 & 0xF800) >> 11) << 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[2].word2 & 0x007F) >> 0) << 5;
	return (data * 0.1) + -40;
}
float CAN_bms_cell_temperatures_M2_temp_12_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_temperatures.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_temperatures.payload, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_OFFSET, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_temperatures_payloads[mux_value] = *CAN_bms_cell_temperatures.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 39
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[2].word2 & 0xFF80) >> 7) << 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[2].word3 & 0x0007) >> 0) << 9;
	return (data * 0.1) + -40;
}
float CAN_bms_cell_temperatures_M3_temp_13_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_temperatures.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_temperatures.payload, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_OFFSET, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_temperatures_payloads[mux_value] = *CAN_bms_cell_temperatures.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 3
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[3].word0 & 0x7FF8) >> 3) << 0;
	return (data * 0.1) + -40;
}
float CAN_bms_cell_temperatures_M3_temp_14_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_temperatures.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_temperatures.payload, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_OFFSET, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_temperatures_payloads[mux_value] = *CAN_bms_cell_temperatures.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 15
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[3].word0 & 0x8000) >> 15) << 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[3].word1 & 0x07FF) >> 0) << 1;
	return (data * 0.1) + -40;
}
float CAN_bms_cell_temperatures_M3_temp_15_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_temperatures.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_temperatures.payload, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_OFFSET, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_temperatures_payloads[mux_value] = *CAN_bms_cell_temperatures.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 27
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[3].word1 & 0xF800) >> 11) << 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[3].word2 & 0x007F) >> 0) << 5;
	return (data * 0.1) + -40;
}
float CAN_bms_cell_temperatures_M3_temp_16_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_temperatures.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_temperatures.payload, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_OFFSET, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_temperatures_payloads[mux_value] = *CAN_bms_cell_temperatures.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 39
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[3].word2 & 0xFF80) >> 7) << 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[3].word3 & 0x0007) >> 0) << 9;
	return (data * 0.1) + -40;
}
float CAN_bms_cell_temperatures_M4_temp_17_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_temperatures.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_temperatures.payload, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_OFFSET, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_temperatures_payloads[mux_value] = *CAN_bms_cell_temperatures.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 3
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[4].word0 & 0x7FF8) >> 3) << 0;
	return (data * 0.1) + -40;
}
float CAN_bms_cell_temperatures_M4_temp_18_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_temperatures.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_temperatures.payload, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_OFFSET, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_temperatures_payloads[mux_value] = *CAN_bms_cell_temperatures.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 15
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[4].word0 & 0x8000) >> 15) << 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[4].word1 & 0x07FF) >> 0) << 1;
	return (data * 0.1) + -40;
}
float CAN_bms_cell_temperatures_M4_temp_19_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_temperatures.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_temperatures.payload, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_OFFSET, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_temperatures_payloads[mux_value] = *CAN_bms_cell_temperatures.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 27
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[4].word1 & 0xF800) >> 11) << 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[4].word2 & 0x007F) >> 0) << 5;
	return (data * 0.1) + -40;
}
float CAN_bms_cell_temperatures_M4_temp_20_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_temperatures.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_temperatures.payload, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_OFFSET, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_temperatures_payloads[mux_value] = *CAN_bms_cell_temperatures.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 39
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[4].word2 & 0xFF80) >> 7) << 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[4].word3 & 0x0007) >> 0) << 9;
	return (data * 0.1) + -40;
}
float CAN_bms_cell_temperatures_M5_temp_21_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_temperatures.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_temperatures.payload, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_OFFSET, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_temperatures_payloads[mux_value] = *CAN_bms_cell_temperatures.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 3
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[5].word0 & 0x7FF8) >> 3) << 0;
	return (data * 0.1) + -40;
}
float CAN_bms_cell_temperatures_M5_temp_22_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_temperatures.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_temperatures.payload, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_OFFSET, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_temperatures_payloads[mux_value] = *CAN_bms_cell_temperatures.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 15
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[5].word0 & 0x8000) >> 15) << 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[5].word1 & 0x07FF) >> 0) << 1;
	return (data * 0.1) + -40;
}
float CAN_bms_cell_temperatures_M5_temp_23_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_temperatures.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_temperatures.payload, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_OFFSET, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_temperatures_payloads[mux_value] = *CAN_bms_cell_temperatures.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 27
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[5].word1 & 0xF800) >> 11) << 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[5].word2 & 0x007F) >> 0) << 5;
	return (data * 0.1) + -40;
}
float CAN_bms_cell_temperatures_M5_temp_24_get(void){
	// Check for fresh data and update payload arrays if needed
	if (*CAN_bms_cell_temperatures.canMessageStatus) {
		// Fresh data received - determine which mux payload to update
		uint16_t mux_value = get_bits((size_t*)CAN_bms_cell_temperatures.payload, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_OFFSET, CAN_BMS_CELL_TEMPERATURES_MULTIPLEX_RANGE);
		// Copy fresh payload data to appropriate mux payload array
		if (mux_value < CAN_BMS_CELL_TEMPERATURES_NUM_MUX_VALUES) {
			// Copy the entire payload structure to the appropriate mux array
			CAN_bms_cell_temperatures_payloads[mux_value] = *CAN_bms_cell_temperatures.payload;
		}
	}
	
	// Extract 12-bit signal at bit offset 39
	uint16_t data = 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[5].word2 & 0xFF80) >> 7) << 0;
	data |= (uint16_t)((CAN_bms_cell_temperatures_payloads[5].word3 & 0x0007) >> 0) << 9;
	return (data * 0.1) + -40;
}

/**********************************************************
 * motorcontroller NODE MESSAGES
 */
#define CAN_motorcontroller_motorStatus_ID 0x731

static CAN_message_S CAN_motorcontroller_motorStatus={
	.canID = CAN_motorcontroller_motorStatus_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
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

uint8_t CAN_motorcontroller_motorStatus_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_motorcontroller_motorStatus);
}
uint16_t CAN_motorcontroller_motorStatus_motorSpeed_get(void){
	// Extract 8-bit signal at bit offset 0
	uint16_t data = 0;
	data |= (uint16_t)((CAN_motorcontroller_motorStatus.payload->word0 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
float CAN_motorcontroller_motorStatus_motorCurrent_get(void){
	// Extract 8-bit signal at bit offset 8
	uint16_t data = 0;
	data |= (uint16_t)((CAN_motorcontroller_motorStatus.payload->word0 & 0xFF00) >> 8) << 0;
	return (data * 0.01) + 0;
}
uint16_t CAN_motorcontroller_motorStatus_IphaseA_get(void){
	// Extract 8-bit signal at bit offset 16
	uint16_t data = 0;
	data |= (uint16_t)((CAN_motorcontroller_motorStatus.payload->word1 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_motorcontroller_motorStatus_IphaseB_get(void){
	// Extract 8-bit signal at bit offset 24
	uint16_t data = 0;
	data |= (uint16_t)((CAN_motorcontroller_motorStatus.payload->word1 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_motorcontroller_motorStatus_IphaseC_get(void){
	// Extract 8-bit signal at bit offset 32
	uint16_t data = 0;
	data |= (uint16_t)((CAN_motorcontroller_motorStatus.payload->word2 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_motorcontroller_motorStatus_VphaseA_get(void){
	// Extract 8-bit signal at bit offset 40
	uint16_t data = 0;
	data |= (uint16_t)((CAN_motorcontroller_motorStatus.payload->word2 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_motorcontroller_motorStatus_VphaseB_get(void){
	// Extract 8-bit signal at bit offset 48
	uint16_t data = 0;
	data |= (uint16_t)((CAN_motorcontroller_motorStatus.payload->word3 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_motorcontroller_motorStatus_VphaseC_get(void){
	// Extract 8-bit signal at bit offset 56
	uint16_t data = 0;
	data |= (uint16_t)((CAN_motorcontroller_motorStatus.payload->word3 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}

#define CAN_motorcontroller_response_ID 0x6ff

static CAN_message_S CAN_motorcontroller_response={
	.canID = CAN_motorcontroller_response_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
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

uint8_t CAN_motorcontroller_response_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_motorcontroller_response);
}
uint16_t CAN_motorcontroller_response_byte1_get(void){
	// Extract 8-bit signal at bit offset 0
	uint16_t data = 0;
	data |= (uint16_t)((CAN_motorcontroller_response.payload->word0 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_motorcontroller_response_byte2_get(void){
	// Extract 8-bit signal at bit offset 8
	uint16_t data = 0;
	data |= (uint16_t)((CAN_motorcontroller_response.payload->word0 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_motorcontroller_response_byte3_get(void){
	// Extract 8-bit signal at bit offset 16
	uint16_t data = 0;
	data |= (uint16_t)((CAN_motorcontroller_response.payload->word1 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_motorcontroller_response_byte4_get(void){
	// Extract 8-bit signal at bit offset 24
	uint16_t data = 0;
	data |= (uint16_t)((CAN_motorcontroller_response.payload->word1 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_motorcontroller_response_byte5_get(void){
	// Extract 8-bit signal at bit offset 32
	uint16_t data = 0;
	data |= (uint16_t)((CAN_motorcontroller_response.payload->word2 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_motorcontroller_response_byte6_get(void){
	// Extract 8-bit signal at bit offset 40
	uint16_t data = 0;
	data |= (uint16_t)((CAN_motorcontroller_response.payload->word2 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_motorcontroller_response_byte7_get(void){
	// Extract 8-bit signal at bit offset 48
	uint16_t data = 0;
	data |= (uint16_t)((CAN_motorcontroller_response.payload->word3 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_motorcontroller_response_byte8_get(void){
	// Extract 8-bit signal at bit offset 56
	uint16_t data = 0;
	data |= (uint16_t)((CAN_motorcontroller_response.payload->word3 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}

/**********************************************************
 * charger NODE MESSAGES
 */
/**********************************************************
 * boot_host NODE MESSAGES
 */
#define CAN_boot_host_mcu_ID 0xa3

static CAN_message_S CAN_boot_host_mcu={
	.canID = CAN_boot_host_mcu_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
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

uint8_t CAN_boot_host_mcu_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_boot_host_mcu);
}
uint16_t CAN_boot_host_mcu_type_get(void){
	// Extract 4-bit signal at bit offset 0
	uint16_t data = 0;
	data |= (uint16_t)((CAN_boot_host_mcu.payload->word0 & 0x000F) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_mcu_code_get(void){
	// Extract 4-bit signal at bit offset 4
	uint16_t data = 0;
	data |= (uint16_t)((CAN_boot_host_mcu.payload->word0 & 0x00F0) >> 4) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_mcu_byte1_get(void){
	// Extract 8-bit signal at bit offset 8
	uint16_t data = 0;
	data |= (uint16_t)((CAN_boot_host_mcu.payload->word0 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_mcu_byte2_get(void){
	// Extract 8-bit signal at bit offset 16
	uint16_t data = 0;
	data |= (uint16_t)((CAN_boot_host_mcu.payload->word1 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_mcu_byte3_get(void){
	// Extract 8-bit signal at bit offset 24
	uint16_t data = 0;
	data |= (uint16_t)((CAN_boot_host_mcu.payload->word1 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_mcu_byte4_get(void){
	// Extract 8-bit signal at bit offset 32
	uint16_t data = 0;
	data |= (uint16_t)((CAN_boot_host_mcu.payload->word2 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_mcu_byte5_get(void){
	// Extract 8-bit signal at bit offset 40
	uint16_t data = 0;
	data |= (uint16_t)((CAN_boot_host_mcu.payload->word2 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_mcu_byte6_get(void){
	// Extract 8-bit signal at bit offset 48
	uint16_t data = 0;
	data |= (uint16_t)((CAN_boot_host_mcu.payload->word3 & 0x00FF) >> 0) << 0;
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_mcu_byte7_get(void){
	// Extract 8-bit signal at bit offset 56
	uint16_t data = 0;
	data |= (uint16_t)((CAN_boot_host_mcu.payload->word3 & 0xFF00) >> 8) << 0;
	return (data * 1.0) + 0;
}

void CAN_DBC_init(void) {
	// Initialize multiplexed message: mcu_debug
	CAN_mcu_mcu_debug.payload = &CAN_mcu_mcu_debug_payloads[0];
	// Pre-set mux value 0 in payload 0
	// Set 2-bit signal at bit offset 0
	CAN_mcu_mcu_debug_payloads[0].word0 &= ~0x0003;
	CAN_mcu_mcu_debug_payloads[0].word0 |= 0 & 0x0003;
	// Pre-set mux value 1 in payload 1
	// Set 2-bit signal at bit offset 0
	CAN_mcu_mcu_debug_payloads[1].word0 &= ~0x0003;
	CAN_mcu_mcu_debug_payloads[1].word0 |= 1 & 0x0003;
	// Pre-set mux value 2 in payload 2
	// Set 2-bit signal at bit offset 0
	CAN_mcu_mcu_debug_payloads[2].word0 &= ~0x0003;
	CAN_mcu_mcu_debug_payloads[2].word0 |= 2 & 0x0003;
	// Pre-set mux value 3 in payload 3
	// Set 2-bit signal at bit offset 0
	CAN_mcu_mcu_debug_payloads[3].word0 &= ~0x0003;
	CAN_mcu_mcu_debug_payloads[3].word0 |= 3 & 0x0003;
	CAN_configureMailbox(&CAN_dash_status);
	CAN_configureMailbox(&CAN_dash_command);
	CAN_configureMailbox(&CAN_dash_data1);
	CAN_configureMailbox(&CAN_dash_data2);
	CAN_configureMailbox(&CAN_bms_status);
	CAN_configureMailbox(&CAN_bms_power_systems);
	CAN_configureMailbox(&CAN_bms_debug);
	CAN_configureMailbox(&CAN_bms_cell_voltages);
	CAN_configureMailbox(&CAN_bms_cell_temperatures);
	CAN_configureMailbox(&CAN_motorcontroller_motorStatus);
	CAN_configureMailbox(&CAN_motorcontroller_response);
	CAN_configureMailbox(&CAN_boot_host_mcu);
}

void CAN_send_1ms(void){
	CAN_mcu_motorControllerRequest_send();
}

void CAN_send_10ms(void){
	CAN_mcu_status_send();
	CAN_mcu_mcu_debug_send();
}

void CAN_send_100ms(void){
	CAN_mcu_command_send();
}

void CAN_send_1000ms(void){
	// No messages to send at this interval
}
