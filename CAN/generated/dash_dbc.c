#include "dash_dbc.h"
#include "CAN.h"
#include "utils.h"
/**********************************************************
 * dash NODE MESSAGES
 */
#define CAN_dash_status_ID 0x701

static CAN_payload_S CAN_dash_status_payload __attribute__((aligned(sizeof(CAN_payload_S))));
static CAN_message_S CAN_dash_status={
	.canID = CAN_dash_status_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = &CAN_dash_status_payload,
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

void CAN_dash_status_heartBeat_set(uint16_t heartBeat){
	uint16_t data_scaled = (heartBeat - 0) / 1.0;
	CAN_dash_status.payload->word0 &= ~0x000F;
	CAN_dash_status.payload->word0 |= (data_scaled << 0) & 0x000F;
}
void CAN_dash_status_state_set(uint16_t state){
	uint16_t data_scaled = (state - 0) / 1.0;
	CAN_dash_status.payload->word0 &= ~0x0070;
	CAN_dash_status.payload->word0 |= (data_scaled << 4) & 0x0070;
}
void CAN_dash_status_killButton_set(uint16_t killButton){
	uint16_t data_scaled = (killButton - 0) / 1.0;
	CAN_dash_status.payload->word0 &= ~0x0180;
	CAN_dash_status.payload->word0 |= (data_scaled << 7) & 0x0180;
}
void CAN_dash_status_ignButton_set(uint16_t ignButton){
	uint16_t data_scaled = (ignButton - 0) / 1.0;
	CAN_dash_status.payload->word0 &= ~0x0600;
	CAN_dash_status.payload->word0 |= (data_scaled << 9) & 0x0600;
}
void CAN_dash_status_modeButton_set(uint16_t modeButton){
	uint16_t data_scaled = (modeButton - 0) / 1.0;
	CAN_dash_status.payload->word0 &= ~0x1800;
	CAN_dash_status.payload->word0 |= (data_scaled << 11) & 0x1800;
}
void CAN_dash_status_selectButton_set(uint16_t selectButton){
	uint16_t data_scaled = (selectButton - 0) / 1.0;
	CAN_dash_status.payload->word0 &= ~0x6000;
	CAN_dash_status.payload->word0 |= (data_scaled << 13) & 0x6000;
}
void CAN_dash_status_driveMode_set(uint16_t driveMode){
	uint16_t data_scaled = (driveMode - 0) / 1.0;
	CAN_dash_status.payload->word0 &= ~0x8000;
	CAN_dash_status.payload->word0 |= (data_scaled << 15) & 0x8000;
	CAN_dash_status.payload->word1 &= ~0x0003;
	CAN_dash_status.payload->word1 |= (data_scaled >> 1) & 0x0003;
}
void CAN_dash_status_dlc_set(uint8_t dlc){
	CAN_dash_status.dlc = dlc;
}
void CAN_dash_status_send(void){
	CAN_write(CAN_dash_status);
}

#define CAN_dash_command_ID 0x702

static CAN_payload_S CAN_dash_command_payload __attribute__((aligned(sizeof(CAN_payload_S))));
static CAN_message_S CAN_dash_command={
	.canID = CAN_dash_command_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = &CAN_dash_command_payload,
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

void CAN_dash_command_ignitionRequest_set(uint16_t ignitionRequest){
	uint16_t data_scaled = (ignitionRequest - 0) / 1.0;
	CAN_dash_command.payload->word0 &= ~0x0001;
	CAN_dash_command.payload->word0 |= (data_scaled << 0) & 0x0001;
}
void CAN_dash_command_killRequest_set(uint16_t killRequest){
	uint16_t data_scaled = (killRequest - 0) / 1.0;
	CAN_dash_command.payload->word0 &= ~0x0002;
	CAN_dash_command.payload->word0 |= (data_scaled << 1) & 0x0002;
}
void CAN_dash_command_batteryEjectRequest_set(uint16_t batteryEjectRequest){
	uint16_t data_scaled = (batteryEjectRequest - 0) / 1.0;
	CAN_dash_command.payload->word0 &= ~0x0004;
	CAN_dash_command.payload->word0 |= (data_scaled << 2) & 0x0004;
}
void CAN_dash_command_lightsRequest_set(uint16_t lightsRequest){
	uint16_t data_scaled = (lightsRequest - 0) / 1.0;
	CAN_dash_command.payload->word0 &= ~0x0008;
	CAN_dash_command.payload->word0 |= (data_scaled << 3) & 0x0008;
}
void CAN_dash_command_hornRequest_set(uint16_t hornRequest){
	uint16_t data_scaled = (hornRequest - 0) / 1.0;
	CAN_dash_command.payload->word0 &= ~0x0010;
	CAN_dash_command.payload->word0 |= (data_scaled << 4) & 0x0010;
}
void CAN_dash_command_dlc_set(uint8_t dlc){
	CAN_dash_command.dlc = dlc;
}
void CAN_dash_command_send(void){
	CAN_write(CAN_dash_command);
}

#define CAN_dash_data1_ID 0x1806e5f5

static CAN_payload_S CAN_dash_data1_payload __attribute__((aligned(sizeof(CAN_payload_S))));
static CAN_message_S CAN_dash_data1={
	.canID = CAN_dash_data1_ID,
	.canXID = 1,
	.dlc = 8,
	.payload = &CAN_dash_data1_payload,
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

void CAN_dash_data1_speed_set(uint16_t speed){
	uint16_t data_scaled = (speed - 0) / 1.0;
	CAN_dash_data1.payload->word0 &= ~0xFFFF;
	CAN_dash_data1.payload->word0 |= (data_scaled << 0) & 0xFFFF;
}
void CAN_dash_data1_odometer_set(uint16_t odometer){
	uint16_t data_scaled = (odometer - 0) / 1.0;
	CAN_dash_data1.payload->word1 &= ~0xFFFF;
	CAN_dash_data1.payload->word1 |= (data_scaled << 0) & 0xFFFF;
}
void CAN_dash_data1_tripA_set(uint16_t tripA){
	uint16_t data_scaled = (tripA - 0) / 1.0;
	CAN_dash_data1.payload->word2 &= ~0xFFFF;
	CAN_dash_data1.payload->word2 |= (data_scaled << 0) & 0xFFFF;
}
void CAN_dash_data1_tripB_set(uint16_t tripB){
	uint16_t data_scaled = (tripB - 0) / 1.0;
	CAN_dash_data1.payload->word3 &= ~0xFFFF;
	CAN_dash_data1.payload->word3 |= (data_scaled << 0) & 0xFFFF;
}
void CAN_dash_data1_dlc_set(uint8_t dlc){
	CAN_dash_data1.dlc = dlc;
}
void CAN_dash_data1_send(void){
	CAN_write(CAN_dash_data1);
}

#define CAN_dash_data2_ID 0x704

static CAN_payload_S CAN_dash_data2_payload __attribute__((aligned(sizeof(CAN_payload_S))));
static CAN_message_S CAN_dash_data2={
	.canID = CAN_dash_data2_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = &CAN_dash_data2_payload,
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

void CAN_dash_data2_runningTime_set(uint16_t runningTime){
	uint16_t data_scaled = (runningTime - 0) / 1.0;
	CAN_dash_data2.payload->word0 &= ~0xFFFF;
	CAN_dash_data2.payload->word0 |= (data_scaled << 0) & 0xFFFF;
}
void CAN_dash_data2_odometer_set(uint16_t odometer){
	uint16_t data_scaled = (odometer - 0) / 1.0;
	CAN_dash_data2.payload->word1 &= ~0xFFFF;
	CAN_dash_data2.payload->word1 |= (data_scaled << 0) & 0xFFFF;
}
void CAN_dash_data2_tripA_set(uint16_t tripA){
	uint16_t data_scaled = (tripA - 0) / 1.0;
	CAN_dash_data2.payload->word2 &= ~0xFFFF;
	CAN_dash_data2.payload->word2 |= (data_scaled << 0) & 0xFFFF;
}
void CAN_dash_data2_tripB_set(uint16_t tripB){
	uint16_t data_scaled = (tripB - 0) / 1.0;
	CAN_dash_data2.payload->word3 &= ~0xFFFF;
	CAN_dash_data2.payload->word3 |= (data_scaled << 0) & 0xFFFF;
}
void CAN_dash_data2_dlc_set(uint8_t dlc){
	CAN_dash_data2.dlc = dlc;
}
void CAN_dash_data2_send(void){
	CAN_write(CAN_dash_data2);
}

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

uint8_t CAN_mcu_status_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_mcu_status);
}
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

uint8_t CAN_mcu_command_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_mcu_command);
}
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

/**********************************************************
 * bms NODE MESSAGES
 */
#define CAN_bms_status_ID 0x721

static CAN_message_S CAN_bms_status={
	.canID = CAN_bms_status_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
};

uint8_t CAN_bms_status_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_bms_status);
}
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

uint16_t CAN_bms_status_Multiplex_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_MULTIPLEX_OFFSET, CAN_BMS_STATUS_MULTIPLEX_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_M0_state_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_M0_STATE_OFFSET, CAN_BMS_STATUS_M0_STATE_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_M0_SOC_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_M0_SOC_OFFSET, CAN_BMS_STATUS_M0_SOC_RANGE);
	return (data * 0.5) + 0;
}
float CAN_bms_status_M0_packVoltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_M0_PACKVOLTAGE_OFFSET, CAN_BMS_STATUS_M0_PACKVOLTAGE_RANGE);
	return (data * 0.01) + 0;
}
float CAN_bms_status_M0_packCurrent_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_M0_PACKCURRENT_OFFSET, CAN_BMS_STATUS_M0_PACKCURRENT_RANGE);
	return (data * 0.01) + 0;
}
float CAN_bms_status_M0_minTemp_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_M0_MINTEMP_OFFSET, CAN_BMS_STATUS_M0_MINTEMP_RANGE);
	return (data * 0.2) + -40;
}
float CAN_bms_status_M0_maxTemp_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_M0_MAXTEMP_OFFSET, CAN_BMS_STATUS_M0_MAXTEMP_RANGE);
	return (data * 0.2) + -40;
}
float CAN_bms_status_M1_stackVoltage1_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_M1_STACKVOLTAGE1_OFFSET, CAN_BMS_STATUS_M1_STACKVOLTAGE1_RANGE);
	return (data * 0.001) + 0;
}
float CAN_bms_status_M1_stackVoltage2_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_M1_STACKVOLTAGE2_OFFSET, CAN_BMS_STATUS_M1_STACKVOLTAGE2_RANGE);
	return (data * 0.001) + 0;
}
float CAN_bms_status_M1_packVoltageSumOfStacks_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_M1_PACKVOLTAGESUMOFSTACKS_OFFSET, CAN_BMS_STATUS_M1_PACKVOLTAGESUMOFSTACKS_RANGE);
	return (data * 0.001) + 0;
}
uint16_t CAN_bms_status_M1_mux1_signal4_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_M1_MUX1_SIGNAL4_OFFSET, CAN_BMS_STATUS_M1_MUX1_SIGNAL4_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_M2_mux2_signal1_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_M2_MUX2_SIGNAL1_OFFSET, CAN_BMS_STATUS_M2_MUX2_SIGNAL1_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_M2_mux2_signal2_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_M2_MUX2_SIGNAL2_OFFSET, CAN_BMS_STATUS_M2_MUX2_SIGNAL2_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_M2_mux2_signal3_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_M2_MUX2_SIGNAL3_OFFSET, CAN_BMS_STATUS_M2_MUX2_SIGNAL3_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_M2_mux2_signal4_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_M2_MUX2_SIGNAL4_OFFSET, CAN_BMS_STATUS_M2_MUX2_SIGNAL4_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_M3_mux3_signal1_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_M3_MUX3_SIGNAL1_OFFSET, CAN_BMS_STATUS_M3_MUX3_SIGNAL1_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_M3_mux3_signal2_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_M3_MUX3_SIGNAL2_OFFSET, CAN_BMS_STATUS_M3_MUX3_SIGNAL2_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_M3_mux3_signal3_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_M3_MUX3_SIGNAL3_OFFSET, CAN_BMS_STATUS_M3_MUX3_SIGNAL3_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_M3_mux3_signal4_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status.payload, CAN_BMS_STATUS_M3_MUX3_SIGNAL4_OFFSET, CAN_BMS_STATUS_M3_MUX3_SIGNAL4_RANGE);
	return (data * 1.0) + 0;
}

#define CAN_bms_status_2_ID 0x722

static CAN_message_S CAN_bms_status_2={
	.canID = CAN_bms_status_2_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
};

uint8_t CAN_bms_status_2_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_bms_status_2);
}
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

uint16_t CAN_bms_status_2_DCDC_state_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status_2.payload, CAN_BMS_STATUS_2_DCDC_STATE_OFFSET, CAN_BMS_STATUS_2_DCDC_STATE_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_2_DCDC_fault_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status_2.payload, CAN_BMS_STATUS_2_DCDC_FAULT_OFFSET, CAN_BMS_STATUS_2_DCDC_FAULT_RANGE);
	return (data * 1.0) + 0;
}
float CAN_bms_status_2_DCDC_voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status_2.payload, CAN_BMS_STATUS_2_DCDC_VOLTAGE_OFFSET, CAN_BMS_STATUS_2_DCDC_VOLTAGE_RANGE);
	return (data * 0.1) + 0;
}
float CAN_bms_status_2_DCDC_current_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status_2.payload, CAN_BMS_STATUS_2_DCDC_CURRENT_OFFSET, CAN_BMS_STATUS_2_DCDC_CURRENT_RANGE);
	return (data * 0.1) + 0;
}
uint16_t CAN_bms_status_2_EV_charger_state_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status_2.payload, CAN_BMS_STATUS_2_EV_CHARGER_STATE_OFFSET, CAN_BMS_STATUS_2_EV_CHARGER_STATE_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_status_2_EV_charger_fault_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status_2.payload, CAN_BMS_STATUS_2_EV_CHARGER_FAULT_OFFSET, CAN_BMS_STATUS_2_EV_CHARGER_FAULT_RANGE);
	return (data * 1.0) + 0;
}
float CAN_bms_status_2_EV_charger_voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status_2.payload, CAN_BMS_STATUS_2_EV_CHARGER_VOLTAGE_OFFSET, CAN_BMS_STATUS_2_EV_CHARGER_VOLTAGE_RANGE);
	return (data * 0.1) + 0;
}
float CAN_bms_status_2_EV_charger_current_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status_2.payload, CAN_BMS_STATUS_2_EV_CHARGER_CURRENT_OFFSET, CAN_BMS_STATUS_2_EV_CHARGER_CURRENT_RANGE);
	return (data * 0.1) + 0;
}
uint16_t CAN_bms_status_2_HV_precharge_state_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status_2.payload, CAN_BMS_STATUS_2_HV_PRECHARGE_STATE_OFFSET, CAN_BMS_STATUS_2_HV_PRECHARGE_STATE_RANGE);
	return (data * 1.0) + 0;
}
float CAN_bms_status_2_HV_isolation_voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status_2.payload, CAN_BMS_STATUS_2_HV_ISOLATION_VOLTAGE_OFFSET, CAN_BMS_STATUS_2_HV_ISOLATION_VOLTAGE_RANGE);
	return (data * 0.1) + 0;
}
uint16_t CAN_bms_status_2_HV_contactor_state_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_status_2.payload, CAN_BMS_STATUS_2_HV_CONTACTOR_STATE_OFFSET, CAN_BMS_STATUS_2_HV_CONTACTOR_STATE_RANGE);
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

uint8_t CAN_bms_debug_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_bms_debug);
}
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

#define CAN_bms_charger_request_ID 0x1806e5f4

static CAN_message_S CAN_bms_charger_request={
	.canID = CAN_bms_charger_request_ID,
	.canXID = 1,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
};

uint8_t CAN_bms_charger_request_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_bms_charger_request);
}
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

uint16_t CAN_bms_charger_request_output_voltage_high_byte_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_charger_request.payload, CAN_BMS_CHARGER_REQUEST_OUTPUT_VOLTAGE_HIGH_BYTE_OFFSET, CAN_BMS_CHARGER_REQUEST_OUTPUT_VOLTAGE_HIGH_BYTE_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_charger_request_output_voltage_low_byte_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_charger_request.payload, CAN_BMS_CHARGER_REQUEST_OUTPUT_VOLTAGE_LOW_BYTE_OFFSET, CAN_BMS_CHARGER_REQUEST_OUTPUT_VOLTAGE_LOW_BYTE_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_charger_request_output_current_high_byte_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_charger_request.payload, CAN_BMS_CHARGER_REQUEST_OUTPUT_CURRENT_HIGH_BYTE_OFFSET, CAN_BMS_CHARGER_REQUEST_OUTPUT_CURRENT_HIGH_BYTE_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_charger_request_output_current_low_byte_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_charger_request.payload, CAN_BMS_CHARGER_REQUEST_OUTPUT_CURRENT_LOW_BYTE_OFFSET, CAN_BMS_CHARGER_REQUEST_OUTPUT_CURRENT_LOW_BYTE_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_charger_request_start_charge_not_request_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_charger_request.payload, CAN_BMS_CHARGER_REQUEST_START_CHARGE_NOT_REQUEST_OFFSET, CAN_BMS_CHARGER_REQUEST_START_CHARGE_NOT_REQUEST_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_charger_request_charge_mode_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_charger_request.payload, CAN_BMS_CHARGER_REQUEST_CHARGE_MODE_OFFSET, CAN_BMS_CHARGER_REQUEST_CHARGE_MODE_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_charger_request_byte_7_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_charger_request.payload, CAN_BMS_CHARGER_REQUEST_BYTE_7_OFFSET, CAN_BMS_CHARGER_REQUEST_BYTE_7_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_charger_request_byte_8_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_charger_request.payload, CAN_BMS_CHARGER_REQUEST_BYTE_8_OFFSET, CAN_BMS_CHARGER_REQUEST_BYTE_8_RANGE);
	return (data * 1.0) + 0;
}

#define CAN_bms_cellVoltages_ID 0x725

static CAN_message_S CAN_bms_cellVoltages={
	.canID = CAN_bms_cellVoltages_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
};

uint8_t CAN_bms_cellVoltages_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_bms_cellVoltages);
}
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

uint16_t CAN_bms_cellVoltages_MultiPlex_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellVoltages.payload, CAN_BMS_CELLVOLTAGES_MULTIPLEX_OFFSET, CAN_BMS_CELLVOLTAGES_MULTIPLEX_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_bms_cellVoltages_M0_cell_1_voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellVoltages.payload, CAN_BMS_CELLVOLTAGES_M0_CELL_1_VOLTAGE_OFFSET, CAN_BMS_CELLVOLTAGES_M0_CELL_1_VOLTAGE_RANGE);
	return (data * 1) + 0;
}
uint16_t CAN_bms_cellVoltages_M0_cell_2_voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellVoltages.payload, CAN_BMS_CELLVOLTAGES_M0_CELL_2_VOLTAGE_OFFSET, CAN_BMS_CELLVOLTAGES_M0_CELL_2_VOLTAGE_RANGE);
	return (data * 1) + 0;
}
uint16_t CAN_bms_cellVoltages_M0_cell_3_voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellVoltages.payload, CAN_BMS_CELLVOLTAGES_M0_CELL_3_VOLTAGE_OFFSET, CAN_BMS_CELLVOLTAGES_M0_CELL_3_VOLTAGE_RANGE);
	return (data * 1) + 0;
}
uint16_t CAN_bms_cellVoltages_M0_cell_4_voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellVoltages.payload, CAN_BMS_CELLVOLTAGES_M0_CELL_4_VOLTAGE_OFFSET, CAN_BMS_CELLVOLTAGES_M0_CELL_4_VOLTAGE_RANGE);
	return (data * 1) + 0;
}
uint16_t CAN_bms_cellVoltages_M1_cell_5_voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellVoltages.payload, CAN_BMS_CELLVOLTAGES_M1_CELL_5_VOLTAGE_OFFSET, CAN_BMS_CELLVOLTAGES_M1_CELL_5_VOLTAGE_RANGE);
	return (data * 1) + 0;
}
uint16_t CAN_bms_cellVoltages_M1_cell_6_voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellVoltages.payload, CAN_BMS_CELLVOLTAGES_M1_CELL_6_VOLTAGE_OFFSET, CAN_BMS_CELLVOLTAGES_M1_CELL_6_VOLTAGE_RANGE);
	return (data * 1) + 0;
}
uint16_t CAN_bms_cellVoltages_M1_cell_7_voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellVoltages.payload, CAN_BMS_CELLVOLTAGES_M1_CELL_7_VOLTAGE_OFFSET, CAN_BMS_CELLVOLTAGES_M1_CELL_7_VOLTAGE_RANGE);
	return (data * 1) + 0;
}
uint16_t CAN_bms_cellVoltages_M1_cell_8_voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellVoltages.payload, CAN_BMS_CELLVOLTAGES_M1_CELL_8_VOLTAGE_OFFSET, CAN_BMS_CELLVOLTAGES_M1_CELL_8_VOLTAGE_RANGE);
	return (data * 1) + 0;
}
uint16_t CAN_bms_cellVoltages_M2_cell_9_voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellVoltages.payload, CAN_BMS_CELLVOLTAGES_M2_CELL_9_VOLTAGE_OFFSET, CAN_BMS_CELLVOLTAGES_M2_CELL_9_VOLTAGE_RANGE);
	return (data * 1) + 0;
}
uint16_t CAN_bms_cellVoltages_M2_cell_10_voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellVoltages.payload, CAN_BMS_CELLVOLTAGES_M2_CELL_10_VOLTAGE_OFFSET, CAN_BMS_CELLVOLTAGES_M2_CELL_10_VOLTAGE_RANGE);
	return (data * 1) + 0;
}
uint16_t CAN_bms_cellVoltages_M2_cell_11_voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellVoltages.payload, CAN_BMS_CELLVOLTAGES_M2_CELL_11_VOLTAGE_OFFSET, CAN_BMS_CELLVOLTAGES_M2_CELL_11_VOLTAGE_RANGE);
	return (data * 1) + 0;
}
uint16_t CAN_bms_cellVoltages_M2_cell_12_voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellVoltages.payload, CAN_BMS_CELLVOLTAGES_M2_CELL_12_VOLTAGE_OFFSET, CAN_BMS_CELLVOLTAGES_M2_CELL_12_VOLTAGE_RANGE);
	return (data * 1) + 0;
}
uint16_t CAN_bms_cellVoltages_M3_cell_13_voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellVoltages.payload, CAN_BMS_CELLVOLTAGES_M3_CELL_13_VOLTAGE_OFFSET, CAN_BMS_CELLVOLTAGES_M3_CELL_13_VOLTAGE_RANGE);
	return (data * 1) + 0;
}
uint16_t CAN_bms_cellVoltages_M3_cell_14_voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellVoltages.payload, CAN_BMS_CELLVOLTAGES_M3_CELL_14_VOLTAGE_OFFSET, CAN_BMS_CELLVOLTAGES_M3_CELL_14_VOLTAGE_RANGE);
	return (data * 1) + 0;
}
uint16_t CAN_bms_cellVoltages_M3_cell_15_voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellVoltages.payload, CAN_BMS_CELLVOLTAGES_M3_CELL_15_VOLTAGE_OFFSET, CAN_BMS_CELLVOLTAGES_M3_CELL_15_VOLTAGE_RANGE);
	return (data * 1) + 0;
}
uint16_t CAN_bms_cellVoltages_M3_cell_16_voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellVoltages.payload, CAN_BMS_CELLVOLTAGES_M3_CELL_16_VOLTAGE_OFFSET, CAN_BMS_CELLVOLTAGES_M3_CELL_16_VOLTAGE_RANGE);
	return (data * 1) + 0;
}
uint16_t CAN_bms_cellVoltages_M4_cell_17_voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellVoltages.payload, CAN_BMS_CELLVOLTAGES_M4_CELL_17_VOLTAGE_OFFSET, CAN_BMS_CELLVOLTAGES_M4_CELL_17_VOLTAGE_RANGE);
	return (data * 1) + 0;
}
uint16_t CAN_bms_cellVoltages_M4_cell_18_voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellVoltages.payload, CAN_BMS_CELLVOLTAGES_M4_CELL_18_VOLTAGE_OFFSET, CAN_BMS_CELLVOLTAGES_M4_CELL_18_VOLTAGE_RANGE);
	return (data * 1) + 0;
}
uint16_t CAN_bms_cellVoltages_M4_cell_19_voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellVoltages.payload, CAN_BMS_CELLVOLTAGES_M4_CELL_19_VOLTAGE_OFFSET, CAN_BMS_CELLVOLTAGES_M4_CELL_19_VOLTAGE_RANGE);
	return (data * 1) + 0;
}
uint16_t CAN_bms_cellVoltages_M4_cell_20_voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellVoltages.payload, CAN_BMS_CELLVOLTAGES_M4_CELL_20_VOLTAGE_OFFSET, CAN_BMS_CELLVOLTAGES_M4_CELL_20_VOLTAGE_RANGE);
	return (data * 1) + 0;
}
uint16_t CAN_bms_cellVoltages_M5_cell_21_voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellVoltages.payload, CAN_BMS_CELLVOLTAGES_M5_CELL_21_VOLTAGE_OFFSET, CAN_BMS_CELLVOLTAGES_M5_CELL_21_VOLTAGE_RANGE);
	return (data * 1) + 0;
}
uint16_t CAN_bms_cellVoltages_M5_cell_22_voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellVoltages.payload, CAN_BMS_CELLVOLTAGES_M5_CELL_22_VOLTAGE_OFFSET, CAN_BMS_CELLVOLTAGES_M5_CELL_22_VOLTAGE_RANGE);
	return (data * 1) + 0;
}
uint16_t CAN_bms_cellVoltages_M5_cell_23_voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellVoltages.payload, CAN_BMS_CELLVOLTAGES_M5_CELL_23_VOLTAGE_OFFSET, CAN_BMS_CELLVOLTAGES_M5_CELL_23_VOLTAGE_RANGE);
	return (data * 1) + 0;
}
uint16_t CAN_bms_cellVoltages_M5_cell_24_voltage_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellVoltages.payload, CAN_BMS_CELLVOLTAGES_M5_CELL_24_VOLTAGE_OFFSET, CAN_BMS_CELLVOLTAGES_M5_CELL_24_VOLTAGE_RANGE);
	return (data * 1) + 0;
}

#define CAN_bms_cellTemperaturs_ID 0x726

static CAN_message_S CAN_bms_cellTemperaturs={
	.canID = CAN_bms_cellTemperaturs_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
};

uint8_t CAN_bms_cellTemperaturs_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_bms_cellTemperaturs);
}
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

uint16_t CAN_bms_cellTemperaturs_MultiPlex_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellTemperaturs.payload, CAN_BMS_CELLTEMPERATURS_MULTIPLEX_OFFSET, CAN_BMS_CELLTEMPERATURS_MULTIPLEX_RANGE);
	return (data * 1.0) + 0;
}
float CAN_bms_cellTemperaturs_M0_temp_1_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellTemperaturs.payload, CAN_BMS_CELLTEMPERATURS_M0_TEMP_1_OFFSET, CAN_BMS_CELLTEMPERATURS_M0_TEMP_1_RANGE);
	return (data * 0.1) + -40;
}
float CAN_bms_cellTemperaturs_M0_temp_2_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellTemperaturs.payload, CAN_BMS_CELLTEMPERATURS_M0_TEMP_2_OFFSET, CAN_BMS_CELLTEMPERATURS_M0_TEMP_2_RANGE);
	return (data * 0.1) + -40;
}
float CAN_bms_cellTemperaturs_M0_temp_3_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellTemperaturs.payload, CAN_BMS_CELLTEMPERATURS_M0_TEMP_3_OFFSET, CAN_BMS_CELLTEMPERATURS_M0_TEMP_3_RANGE);
	return (data * 0.1) + -40;
}
float CAN_bms_cellTemperaturs_M0_temp_4_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellTemperaturs.payload, CAN_BMS_CELLTEMPERATURS_M0_TEMP_4_OFFSET, CAN_BMS_CELLTEMPERATURS_M0_TEMP_4_RANGE);
	return (data * 0.1) + -40;
}
float CAN_bms_cellTemperaturs_M1_temp_5_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellTemperaturs.payload, CAN_BMS_CELLTEMPERATURS_M1_TEMP_5_OFFSET, CAN_BMS_CELLTEMPERATURS_M1_TEMP_5_RANGE);
	return (data * 0.1) + -40;
}
float CAN_bms_cellTemperaturs_M1_temp_6_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellTemperaturs.payload, CAN_BMS_CELLTEMPERATURS_M1_TEMP_6_OFFSET, CAN_BMS_CELLTEMPERATURS_M1_TEMP_6_RANGE);
	return (data * 0.1) + -40;
}
float CAN_bms_cellTemperaturs_M1_temp_7_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellTemperaturs.payload, CAN_BMS_CELLTEMPERATURS_M1_TEMP_7_OFFSET, CAN_BMS_CELLTEMPERATURS_M1_TEMP_7_RANGE);
	return (data * 0.1) + -40;
}
float CAN_bms_cellTemperaturs_M1_temp_8_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellTemperaturs.payload, CAN_BMS_CELLTEMPERATURS_M1_TEMP_8_OFFSET, CAN_BMS_CELLTEMPERATURS_M1_TEMP_8_RANGE);
	return (data * 0.1) + -40;
}
float CAN_bms_cellTemperaturs_M2_temp_9_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellTemperaturs.payload, CAN_BMS_CELLTEMPERATURS_M2_TEMP_9_OFFSET, CAN_BMS_CELLTEMPERATURS_M2_TEMP_9_RANGE);
	return (data * 0.1) + -40;
}
float CAN_bms_cellTemperaturs_M2_temp_10_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellTemperaturs.payload, CAN_BMS_CELLTEMPERATURS_M2_TEMP_10_OFFSET, CAN_BMS_CELLTEMPERATURS_M2_TEMP_10_RANGE);
	return (data * 0.1) + -40;
}
float CAN_bms_cellTemperaturs_M2_temp_11_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellTemperaturs.payload, CAN_BMS_CELLTEMPERATURS_M2_TEMP_11_OFFSET, CAN_BMS_CELLTEMPERATURS_M2_TEMP_11_RANGE);
	return (data * 0.1) + -40;
}
float CAN_bms_cellTemperaturs_M2_temp_12_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellTemperaturs.payload, CAN_BMS_CELLTEMPERATURS_M2_TEMP_12_OFFSET, CAN_BMS_CELLTEMPERATURS_M2_TEMP_12_RANGE);
	return (data * 0.1) + -40;
}
float CAN_bms_cellTemperaturs_M3_temp_13_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellTemperaturs.payload, CAN_BMS_CELLTEMPERATURS_M3_TEMP_13_OFFSET, CAN_BMS_CELLTEMPERATURS_M3_TEMP_13_RANGE);
	return (data * 0.1) + -40;
}
float CAN_bms_cellTemperaturs_M3_temp_14_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellTemperaturs.payload, CAN_BMS_CELLTEMPERATURS_M3_TEMP_14_OFFSET, CAN_BMS_CELLTEMPERATURS_M3_TEMP_14_RANGE);
	return (data * 0.1) + -40;
}
float CAN_bms_cellTemperaturs_M3_temp_15_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellTemperaturs.payload, CAN_BMS_CELLTEMPERATURS_M3_TEMP_15_OFFSET, CAN_BMS_CELLTEMPERATURS_M3_TEMP_15_RANGE);
	return (data * 0.1) + -40;
}
float CAN_bms_cellTemperaturs_M3_temp_16_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellTemperaturs.payload, CAN_BMS_CELLTEMPERATURS_M3_TEMP_16_OFFSET, CAN_BMS_CELLTEMPERATURS_M3_TEMP_16_RANGE);
	return (data * 0.1) + -40;
}
float CAN_bms_cellTemperaturs_M4_temp_17_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellTemperaturs.payload, CAN_BMS_CELLTEMPERATURS_M4_TEMP_17_OFFSET, CAN_BMS_CELLTEMPERATURS_M4_TEMP_17_RANGE);
	return (data * 0.1) + -40;
}
float CAN_bms_cellTemperaturs_M4_temp_18_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellTemperaturs.payload, CAN_BMS_CELLTEMPERATURS_M4_TEMP_18_OFFSET, CAN_BMS_CELLTEMPERATURS_M4_TEMP_18_RANGE);
	return (data * 0.1) + -40;
}
float CAN_bms_cellTemperaturs_M4_temp_19_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellTemperaturs.payload, CAN_BMS_CELLTEMPERATURS_M4_TEMP_19_OFFSET, CAN_BMS_CELLTEMPERATURS_M4_TEMP_19_RANGE);
	return (data * 0.1) + -40;
}
float CAN_bms_cellTemperaturs_M4_temp_20_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellTemperaturs.payload, CAN_BMS_CELLTEMPERATURS_M4_TEMP_20_OFFSET, CAN_BMS_CELLTEMPERATURS_M4_TEMP_20_RANGE);
	return (data * 0.1) + -40;
}
float CAN_bms_cellTemperaturs_M5_temp_21_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellTemperaturs.payload, CAN_BMS_CELLTEMPERATURS_M5_TEMP_21_OFFSET, CAN_BMS_CELLTEMPERATURS_M5_TEMP_21_RANGE);
	return (data * 0.1) + -40;
}
float CAN_bms_cellTemperaturs_M5_temp_22_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellTemperaturs.payload, CAN_BMS_CELLTEMPERATURS_M5_TEMP_22_OFFSET, CAN_BMS_CELLTEMPERATURS_M5_TEMP_22_RANGE);
	return (data * 0.1) + -40;
}
float CAN_bms_cellTemperaturs_M5_temp_23_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellTemperaturs.payload, CAN_BMS_CELLTEMPERATURS_M5_TEMP_23_OFFSET, CAN_BMS_CELLTEMPERATURS_M5_TEMP_23_RANGE);
	return (data * 0.1) + -40;
}
float CAN_bms_cellTemperaturs_M5_temp_24_get(void){
	uint16_t data = get_bits((size_t*)CAN_bms_cellTemperaturs.payload, CAN_BMS_CELLTEMPERATURS_M5_TEMP_24_OFFSET, CAN_BMS_CELLTEMPERATURS_M5_TEMP_24_RANGE);
	return (data * 0.1) + -40;
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
#define CAN_boot_host_dash_ID 0xa5

static CAN_message_S CAN_boot_host_dash={
	.canID = CAN_boot_host_dash_ID,
	.canXID = 0,
	.dlc = 8,
	.payload = 0,
	.canMessageStatus = 0
};

uint8_t CAN_boot_host_dash_checkDataIsFresh(void){
	return CAN_checkDataIsFresh(&CAN_boot_host_dash);
}
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

uint16_t CAN_boot_host_dash_type_get(void){
	uint16_t data = get_bits((size_t*)CAN_boot_host_dash.payload, CAN_BOOT_HOST_DASH_TYPE_OFFSET, CAN_BOOT_HOST_DASH_TYPE_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_dash_code_get(void){
	uint16_t data = get_bits((size_t*)CAN_boot_host_dash.payload, CAN_BOOT_HOST_DASH_CODE_OFFSET, CAN_BOOT_HOST_DASH_CODE_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_dash_byte1_get(void){
	uint16_t data = get_bits((size_t*)CAN_boot_host_dash.payload, CAN_BOOT_HOST_DASH_BYTE1_OFFSET, CAN_BOOT_HOST_DASH_BYTE1_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_dash_byte2_get(void){
	uint16_t data = get_bits((size_t*)CAN_boot_host_dash.payload, CAN_BOOT_HOST_DASH_BYTE2_OFFSET, CAN_BOOT_HOST_DASH_BYTE2_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_dash_byte3_get(void){
	uint16_t data = get_bits((size_t*)CAN_boot_host_dash.payload, CAN_BOOT_HOST_DASH_BYTE3_OFFSET, CAN_BOOT_HOST_DASH_BYTE3_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_dash_byte4_get(void){
	uint16_t data = get_bits((size_t*)CAN_boot_host_dash.payload, CAN_BOOT_HOST_DASH_BYTE4_OFFSET, CAN_BOOT_HOST_DASH_BYTE4_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_dash_byte5_get(void){
	uint16_t data = get_bits((size_t*)CAN_boot_host_dash.payload, CAN_BOOT_HOST_DASH_BYTE5_OFFSET, CAN_BOOT_HOST_DASH_BYTE5_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_dash_byte6_get(void){
	uint16_t data = get_bits((size_t*)CAN_boot_host_dash.payload, CAN_BOOT_HOST_DASH_BYTE6_OFFSET, CAN_BOOT_HOST_DASH_BYTE6_RANGE);
	return (data * 1.0) + 0;
}
uint16_t CAN_boot_host_dash_byte7_get(void){
	uint16_t data = get_bits((size_t*)CAN_boot_host_dash.payload, CAN_BOOT_HOST_DASH_BYTE7_OFFSET, CAN_BOOT_HOST_DASH_BYTE7_RANGE);
	return (data * 1.0) + 0;
}

void CAN_DBC_init(void) {
	CAN_configureMailbox(&CAN_mcu_status);
	CAN_configureMailbox(&CAN_mcu_command);
	CAN_configureMailbox(&CAN_bms_status);
	CAN_configureMailbox(&CAN_bms_status_2);
	CAN_configureMailbox(&CAN_bms_debug);
	CAN_configureMailbox(&CAN_bms_charger_request);
	CAN_configureMailbox(&CAN_bms_cellVoltages);
	CAN_configureMailbox(&CAN_bms_cellTemperaturs);
	CAN_configureMailbox(&CAN_boot_host_dash);
}

void CAN_send_10ms(void){
	CAN_dash_status_send();
	CAN_dash_command_send();
	CAN_dash_data1_send();
	CAN_dash_data2_send();
}
