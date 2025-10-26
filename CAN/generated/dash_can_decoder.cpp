#include "dash_can_decoder.h"

// Auto-generated CAN decoder implementation

uint32_t CAN_ExtractBits(const uint8_t* data, uint16_t startBit, uint8_t numBits) {
  uint32_t value = 0;
  for (uint8_t i = 0; i < numBits; i++) {
    uint16_t bitPos = startBit + i;
    uint8_t bytePos = bitPos / 8;
    uint8_t bitOffset = bitPos % 8;
    if (data[bytePos] & (1 << bitOffset)) {
      value |= (1 << i);
    }
  }
  return value;
}

float CAN_ExtractFloat(const uint8_t* data, uint16_t startBit, uint8_t numBits, float scale, float offset) {
  uint32_t raw = CAN_ExtractBits(data, startBit, numBits);
  return (raw * scale) + offset;
}

void CAN_Decode_motorcontroller_SYNC(const twai_message_t* msg, motorcontroller_SYNC_T* out) {
  if (msg == NULL || out == NULL) return;
  if (msg->identifier != 0x080) return;

  const uint8_t* data = msg->data;
  out->valid = true;
  out->timestamp_ms = millis();

}

void CAN_Decode_motorcontroller_Emergency(const twai_message_t* msg, motorcontroller_Emergency_T* out) {
  if (msg == NULL || out == NULL) return;
  if (msg->identifier != 0x081) return;

  const uint8_t* data = msg->data;
  out->valid = true;
  out->timestamp_ms = millis();

  out->EMCY = ((data[0] >> 0) | (data[1] << 8)) & 0xFFFF;
}

void CAN_Decode_boot_host_bms(const twai_message_t* msg, boot_host_bms_T* out) {
  if (msg == NULL || out == NULL) return;
  if (msg->identifier != 0x0A1) return;

  const uint8_t* data = msg->data;
  out->valid = true;
  out->timestamp_ms = millis();

  out->type = (data[0] >> 0) & 0x0F;
  out->code = (data[0] >> 4) & 0x0F;
  out->byte1 = (data[1] >> 0) & 0xFF;
  out->byte2 = (data[2] >> 0) & 0xFF;
  out->byte3 = (data[3] >> 0) & 0xFF;
  out->byte4 = (data[4] >> 0) & 0xFF;
  out->byte5 = (data[5] >> 0) & 0xFF;
  out->byte6 = (data[6] >> 0) & 0xFF;
  out->byte7 = (data[7] >> 0) & 0xFF;
}

void CAN_Decode_bms_boot_response(const twai_message_t* msg, bms_boot_response_T* out) {
  if (msg == NULL || out == NULL) return;
  if (msg->identifier != 0x0A2) return;

  const uint8_t* data = msg->data;
  out->valid = true;
  out->timestamp_ms = millis();

  out->type = (data[0] >> 0) & 0x0F;
  out->code = (data[0] >> 4) & 0x0F;
  out->byte1 = (data[1] >> 0) & 0xFF;
  out->byte2 = (data[2] >> 0) & 0xFF;
  out->byte3 = (data[3] >> 0) & 0xFF;
  out->byte4 = (data[4] >> 0) & 0xFF;
  out->byte5 = (data[5] >> 0) & 0xFF;
  out->byte6 = (data[6] >> 0) & 0xFF;
  out->byte7 = (data[7] >> 0) & 0xFF;
}

void CAN_Decode_boot_host_mcu(const twai_message_t* msg, boot_host_mcu_T* out) {
  if (msg == NULL || out == NULL) return;
  if (msg->identifier != 0x0A3) return;

  const uint8_t* data = msg->data;
  out->valid = true;
  out->timestamp_ms = millis();

  out->type = (data[0] >> 0) & 0x0F;
  out->code = (data[0] >> 4) & 0x0F;
  out->byte1 = (data[1] >> 0) & 0xFF;
  out->byte2 = (data[2] >> 0) & 0xFF;
  out->byte3 = (data[3] >> 0) & 0xFF;
  out->byte4 = (data[4] >> 0) & 0xFF;
  out->byte5 = (data[5] >> 0) & 0xFF;
  out->byte6 = (data[6] >> 0) & 0xFF;
  out->byte7 = (data[7] >> 0) & 0xFF;
}

void CAN_Decode_boot_host_dash(const twai_message_t* msg, boot_host_dash_T* out) {
  if (msg == NULL || out == NULL) return;
  if (msg->identifier != 0x0A5) return;

  const uint8_t* data = msg->data;
  out->valid = true;
  out->timestamp_ms = millis();

  out->type = (data[0] >> 0) & 0x0F;
  out->code = (data[0] >> 4) & 0x0F;
  out->byte1 = (data[1] >> 0) & 0xFF;
  out->byte2 = (data[2] >> 0) & 0xFF;
  out->byte3 = (data[3] >> 0) & 0xFF;
  out->byte4 = (data[4] >> 0) & 0xFF;
  out->byte5 = (data[5] >> 0) & 0xFF;
  out->byte6 = (data[6] >> 0) & 0xFF;
  out->byte7 = (data[7] >> 0) & 0xFF;
}

void CAN_Decode_mcu_motorControllerRequest(const twai_message_t* msg, mcu_motorControllerRequest_T* out) {
  if (msg == NULL || out == NULL) return;
  if (msg->identifier != 0x201) return;

  const uint8_t* data = msg->data;
  out->valid = true;
  out->timestamp_ms = millis();

  out->Throttle_Value = ((data[0] >> 0) | (data[1] << 8)) & 0xFFFF;
  out->Forward_Switch = ((data[2] >> 0) & 0x01) ? true : false;
  out->Reverse_Switch = ((data[2] >> 1) & 0x01) ? true : false;
  out->FS1_Switch = ((data[2] >> 2) & 0x01) ? true : false;
  out->Seat_Switch = ((data[2] >> 3) & 0x01) ? true : false;
  out->Handbrake_Switch = ((data[2] >> 4) & 0x01) ? true : false;
  out->Footbrake_Value = ((data[2] >> 5) | (data[3] << 3)) & 0xFFFF;
}

void CAN_Decode_motorcontroller_motor_status_PDO4(const twai_message_t* msg, motorcontroller_motor_status_PDO4_T* out) {
  if (msg == NULL || out == NULL) return;
  if (msg->identifier != 0x271) return;

  const uint8_t* data = msg->data;
  out->valid = true;
  out->timestamp_ms = millis();

  out->Motor_Torque = CAN_ExtractFloat(data, 0, 16, 0.001, 0);
  out->Motor_Velocity = CAN_ExtractBits(data, 16, 32);
  out->Motor_AC_Current = ((data[6] >> 0) | (data[7] << 8)) & 0xFFFF;
}

void CAN_Decode_motorcontroller_motorStatus_PDO2(const twai_message_t* msg, motorcontroller_motorStatus_PDO2_T* out) {
  if (msg == NULL || out == NULL) return;
  if (msg->identifier != 0x330) return;

  const uint8_t* data = msg->data;
  out->valid = true;
  out->timestamp_ms = millis();

  out->Throttle_Input_Voltage = CAN_ExtractFloat(data, 0, 16, 0.0039, 0);
  out->Throttle_Value = CAN_ExtractFloat(data, 16, 16, 0.00305, 0);
}

void CAN_Decode_mcu_status(const twai_message_t* msg, mcu_status_T* out) {
  if (msg == NULL || out == NULL) return;
  if (msg->identifier != 0x388) return;

  const uint8_t* data = msg->data;
  out->valid = true;
  out->timestamp_ms = millis();

  out->multiplex = (data[0] >> 0) & 0x07;

  out->vehicleState = (data[0] >> 3) & 0x07;
  out->highBeam = ((data[0] >> 6) & 0x01) ? true : false;
  out->lowBeam = ((data[0] >> 7) & 0x01) ? true : false;
  out->brakeLight = ((data[1] >> 0) & 0x01) ? true : false;
  out->tailLight = ((data[1] >> 1) & 0x01) ? true : false;
  out->horn = ((data[1] >> 2) & 0x01) ? true : false;
  out->turnSignalFR = ((data[1] >> 3) & 0x01) ? true : false;
  out->turnSignalFL = ((data[1] >> 4) & 0x01) ? true : false;
  out->turnSignalRR = ((data[1] >> 5) & 0x01) ? true : false;
  out->turnSignalRL = ((data[1] >> 6) & 0x01) ? true : false;
  out->brakeSwitchFront = ((data[1] >> 7) & 0x01) ? true : false;
  out->brakeSwitchRear = ((data[2] >> 0) & 0x01) ? true : false;
  out->killSwitch = ((data[2] >> 1) & 0x01) ? true : false;
  out->ignitionSwitch = ((data[2] >> 2) & 0x01) ? true : false;
  out->leftTurnSwitch = ((data[2] >> 3) & 0x01) ? true : false;
  out->rightTurnSwitch = ((data[2] >> 4) & 0x01) ? true : false;
  out->lightSwitch = ((data[2] >> 5) & 0x01) ? true : false;
  out->assSwitch = ((data[2] >> 6) & 0x01) ? true : false;
  out->hornSwitch = ((data[2] >> 7) & 0x01) ? true : false;
  out->batt_voltage = CAN_ExtractFloat(data, 24, 8, 0.1, 0);
  out->batt_current = CAN_ExtractFloat(data, 32, 16, 0.001, -33);
  out->dcdc_current = CAN_ExtractFloat(data, 48, 16, 0.001, -33);
  out->batt_fault = ((data[8] >> 0) & 0x01) ? true : false;
  out->dcdc_fault = ((data[8] >> 1) & 0x01) ? true : false;
  out->fan_fault = ((data[8] >> 2) & 0x01) ? true : false;
  out->pump_fault = ((data[8] >> 3) & 0x01) ? true : false;
  out->taillight_fault = ((data[8] >> 4) & 0x01) ? true : false;
  out->brakelight_fault = ((data[8] >> 5) & 0x01) ? true : false;
  out->lowbeam_fault = ((data[8] >> 6) & 0x01) ? true : false;
  out->highbeam_fault = ((data[8] >> 7) & 0x01) ? true : false;
  out->horn_fault = ((data[9] >> 0) & 0x01) ? true : false;
  out->aux_port_fault = ((data[9] >> 1) & 0x01) ? true : false;
  out->heated_grips_fault = ((data[9] >> 2) & 0x01) ? true : false;
  out->heated_seat_fault = ((data[9] >> 3) & 0x01) ? true : false;
  out->charge_controller_fault = ((data[9] >> 4) & 0x01) ? true : false;
  out->motor_controller_fault = ((data[9] >> 5) & 0x01) ? true : false;
  out->bms_controller_fault = ((data[9] >> 6) & 0x01) ? true : false;
  out->J1772_controller_fault = ((data[9] >> 7) & 0x01) ? true : false;
  out->ic_controller_fault = ((data[10] >> 0) & 0x01) ? true : false;
  out->fan_current = ((data[10] >> 1) | (data[11] << 7)) & 0x0FFF;
  out->pump_current = ((data[11] >> 5) | (data[12] << 3)) & 0x0FFF;
  out->taillight_current = ((data[13] >> 1) | (data[14] << 7)) & 0x0FFF;
  out->brakelight_current = ((data[14] >> 5) | (data[15] << 3)) & 0x0FFF;
  out->lowbeam_current = ((data[16] >> 1) | (data[17] << 7)) & 0x0FFF;
  out->highbeam_current = ((data[17] >> 5) | (data[18] << 3)) & 0x0FFF;
  out->horn_current = ((data[19] >> 1) | (data[20] << 7)) & 0x0FFF;
  out->aux_port_current = ((data[20] >> 5) | (data[21] << 3)) & 0x0FFF;
  out->heated_grips_current = ((data[22] >> 1) | (data[23] << 7)) & 0x0FFF;
  out->heated_seat_current = ((data[23] >> 5) | (data[24] << 3)) & 0x0FFF;
  out->charge_controller_current = ((data[25] >> 1) | (data[26] << 7)) & 0x0FFF;
  out->motor_controller_current = ((data[26] >> 5) | (data[27] << 3)) & 0x0FFF;
  out->bms_controller_current = ((data[28] >> 1) | (data[29] << 7)) & 0x0FFF;
  out->J1772_controller_current = ((data[29] >> 5) | (data[30] << 3)) & 0x0FFF;
}

void CAN_Decode_mcu_command(const twai_message_t* msg, mcu_command_T* out) {
  if (msg == NULL || out == NULL) return;
  if (msg->identifier != 0x389) return;

  const uint8_t* data = msg->data;
  out->valid = true;
  out->timestamp_ms = millis();

  out->DCDC_enable = ((data[0] >> 0) & 0x01) ? true : false;
  out->J1772_prox_status = (data[0] >> 1) & 0x03;
  out->J1772_pilot_current = ((data[0] >> 3) | (data[1] << 5)) & 0x00FF;
  out->precharge_enable = ((data[1] >> 3) & 0x01) ? true : false;
  out->motor_controller_enable = ((data[1] >> 4) & 0x01) ? true : false;
}

void CAN_Decode_mcu_mcu_debug(const twai_message_t* msg, mcu_mcu_debug_T* out) {
  if (msg == NULL || out == NULL) return;
  if (msg->identifier != 0x38A) return;

  const uint8_t* data = msg->data;
  out->valid = true;
  out->timestamp_ms = millis();

  out->multiplex = (data[0] >> 0) & 0x03;

  out->cpu_usage_percent = CAN_ExtractFloat(data, 2, 8, 0.5, 0);
  out->cpu_peak_percent = CAN_ExtractFloat(data, 10, 8, 0.5, 0);
  out->debug_value_1_u16 = ((data[2] >> 2) | (data[3] << 6)) & 0xFFFF;
  out->debug_value_1_u24 = CAN_ExtractBits(data, 34, 24);
  out->task_1ms_cpu_percent = ((data[7] >> 2) | (data[8] << 6)) & 0x00FF;
  out->task_10ms_cpu_percent = ((data[8] >> 2) | (data[9] << 6)) & 0x00FF;
  out->task_100ms_cpu_percent = ((data[9] >> 2) | (data[10] << 6)) & 0x00FF;
  out->task_1000ms_cpu_percent = ((data[10] >> 2) | (data[11] << 6)) & 0x00FF;
  out->debug_value_1_u30 = CAN_ExtractBits(data, 90, 30);
  out->task_1ms_peak_cpu_percent = (data[15] >> 0) & 0xFF;
  out->task_10ms_peak_cpu_percent = (data[16] >> 0) & 0xFF;
  out->task_100ms_peak_cpu_percent = (data[17] >> 0) & 0xFF;
  out->task_1000ms_peak_cpu_percent = (data[18] >> 0) & 0xFF;
}

void CAN_Decode_bms_status(const twai_message_t* msg, bms_status_T* out) {
  if (msg == NULL || out == NULL) return;
  if (msg->identifier != 0x38B) return;

  const uint8_t* data = msg->data;
  out->valid = true;
  out->timestamp_ms = millis();

  out->multiplex = (data[0] >> 0) & 0x07;

  out->bms_state = (data[0] >> 3) & 0x0F;
  out->pack_voltage = CAN_ExtractFloat(data, 7, 16, 0.01, 0);
  out->pack_current = CAN_ExtractFloat(data, 23, 16, 0.01, -320);
  out->soc_percent = CAN_ExtractFloat(data, 39, 8, 0.5, 0);
  out->pack_temp_min = CAN_ExtractFloat(data, 47, 8, 1.0, -40);
  out->pack_temp_max = CAN_ExtractFloat(data, 55, 8, 1.0, -40);
  out->stack_voltage_1 = CAN_ExtractFloat(data, 63, 16, 0.001, 0);
  out->stack_voltage_2 = CAN_ExtractFloat(data, 79, 16, 0.001, 0);
  out->pack_voltage_sum_of_stacks = CAN_ExtractFloat(data, 95, 18, 0.001, 0);
  out->ltc_state = (data[14] >> 1) & 0x0F;
  out->ltc_error_count = ((data[14] >> 5) | (data[15] << 3)) & 0x0FFF;
  out->ltc_last_error = ((data[16] >> 1) | (data[17] << 7)) & 0x00FF;
  out->cpu_usage_percent = CAN_ExtractFloat(data, 137, 8, 0.5, 0);
  out->cpu_peak_percent = CAN_ExtractFloat(data, 145, 8, 0.5, 0);
  out->vbus_voltage = CAN_ExtractFloat(data, 153, 10, 0.1, 0);
  out->internal_temp = CAN_ExtractFloat(data, 163, 8, 1.0, -40);
  out->max_charge_current_mA = ((data[21] >> 3) | (data[22] << 5)) & 0xFFFF;
  out->max_charge_voltage_mV = CAN_ExtractBits(data, 187, 18);
  out->contactors_closed = ((data[25] >> 5) & 0x01) ? true : false;
  out->precharge_active = ((data[25] >> 6) & 0x01) ? true : false;
  out->charge_allowed = ((data[25] >> 7) & 0x01) ? true : false;
  out->discharge_allowed = ((data[26] >> 0) & 0x01) ? true : false;
  out->fault_summary = ((data[26] >> 1) | (data[27] << 7)) & 0x0FFF;
  out->is_balancing = ((data[27] >> 5) & 0x01) ? true : false;
  out->cell_A_balancing = ((data[27] >> 6) | (data[28] << 2)) & 0x001F;
  out->cell_B_balancing = (data[28] >> 3) & 0x1F;
  out->cell_C_balancing = (data[29] >> 0) & 0x1F;
  out->cell_D_balancing = ((data[29] >> 5) | (data[30] << 3)) & 0x001F;
  out->cell_E_balancing = (data[30] >> 2) & 0x1F;
}

void CAN_Decode_bms_power_systems(const twai_message_t* msg, bms_power_systems_T* out) {
  if (msg == NULL || out == NULL) return;
  if (msg->identifier != 0x38C) return;

  const uint8_t* data = msg->data;
  out->valid = true;
  out->timestamp_ms = millis();

  out->DCDC_state = ((data[0] >> 0) & 0x01) ? true : false;
  out->DCDC_fault = ((data[0] >> 1) & 0x01) ? true : false;
  out->DCDC_voltage = CAN_ExtractFloat(data, 2, 10, 0.1, 0);
  out->DCDC_current = CAN_ExtractFloat(data, 12, 10, 0.1, 0);
  out->EV_charger_state = ((data[2] >> 6) & 0x01) ? true : false;
  out->EV_charger_fault = ((data[2] >> 7) & 0x01) ? true : false;
  out->EV_charger_voltage = CAN_ExtractFloat(data, 24, 10, 0.1, 0);
  out->EV_charger_current = CAN_ExtractFloat(data, 34, 10, 0.1, -50);
  out->J1772_ready_to_charge = ((data[5] >> 4) & 0x01) ? true : false;
  out->HV_precharge_state = ((data[5] >> 5) & 0x01) ? true : false;
  out->HV_isolation_voltage = CAN_ExtractFloat(data, 46, 10, 0.1, 0);
  out->HV_contactor_state = ((data[7] >> 0) & 0x01) ? true : false;
}

void CAN_Decode_bms_debug(const twai_message_t* msg, bms_debug_T* out) {
  if (msg == NULL || out == NULL) return;
  if (msg->identifier != 0x38D) return;

  const uint8_t* data = msg->data;
  out->valid = true;
  out->timestamp_ms = millis();

  out->multiplex = (data[0] >> 0) & 0x03;

  out->task_1ms_cpu_percent = ((data[0] >> 2) | (data[1] << 6)) & 0x00FF;
  out->task_10ms_cpu_percent = ((data[1] >> 2) | (data[2] << 6)) & 0x00FF;
  out->task_100ms_cpu_percent = ((data[2] >> 2) | (data[3] << 6)) & 0x00FF;
  out->task_1000ms_cpu_percent = ((data[3] >> 2) | (data[4] << 6)) & 0x00FF;
  out->task_1ms_peak_cpu_percent = ((data[4] >> 2) | (data[5] << 6)) & 0x00FF;
  out->task_10ms_peak_cpu_percent = ((data[5] >> 2) | (data[6] << 6)) & 0x00FF;
  out->task_100ms_peak_cpu_percent = ((data[6] >> 2) | (data[7] << 6)) & 0x00FF;
  out->task_1000ms_peak_cpu_percent = ((data[7] >> 2) | (data[8] << 6)) & 0x00FF;
  out->bool0 = ((data[8] >> 2) & 0x01) ? true : false;
  out->bool1 = ((data[8] >> 3) & 0x01) ? true : false;
  out->float1 = CAN_ExtractFloat(data, 68, 16, 0.01, 0);
  out->float2 = CAN_ExtractFloat(data, 84, 16, 0.01, 0);
  out->word1 = ((data[12] >> 4) | (data[13] << 4)) & 0xFFFF;
  out->byte1 = ((data[14] >> 4) | (data[15] << 4)) & 0x00FF;
}

void CAN_Decode_bms_cell_voltages(const twai_message_t* msg, bms_cell_voltages_T* out) {
  if (msg == NULL || out == NULL) return;
  if (msg->identifier != 0x38E) return;

  const uint8_t* data = msg->data;
  out->valid = true;
  out->timestamp_ms = millis();

  out->multiplex = (data[0] >> 0) & 0x07;

  out->cell_1_voltage = ((data[0] >> 3) | (data[1] << 5)) & 0x7FFF;
  out->cell_2_voltage = ((data[2] >> 2) | (data[3] << 6)) & 0x7FFF;
  out->cell_3_voltage = ((data[4] >> 1) | (data[5] << 7)) & 0x7FFF;
  out->cell_4_voltage = ((data[6] >> 0) | (data[7] << 8)) & 0x7FFF;
  out->cell_5_voltage = ((data[7] >> 7) | (data[8] << 1)) & 0x7FFF;
  out->cell_6_voltage = ((data[9] >> 6) | (data[10] << 2)) & 0x7FFF;
  out->cell_7_voltage = ((data[11] >> 5) | (data[12] << 3)) & 0x7FFF;
  out->cell_8_voltage = ((data[13] >> 4) | (data[14] << 4)) & 0x7FFF;
  out->cell_9_voltage = ((data[15] >> 3) | (data[16] << 5)) & 0x7FFF;
  out->cell_10_voltage = ((data[17] >> 2) | (data[18] << 6)) & 0x7FFF;
  out->cell_11_voltage = ((data[19] >> 1) | (data[20] << 7)) & 0x7FFF;
  out->cell_12_voltage = ((data[21] >> 0) | (data[22] << 8)) & 0x7FFF;
  out->cell_13_voltage = ((data[22] >> 7) | (data[23] << 1)) & 0x7FFF;
  out->cell_14_voltage = ((data[24] >> 6) | (data[25] << 2)) & 0x7FFF;
  out->cell_15_voltage = ((data[26] >> 5) | (data[27] << 3)) & 0x7FFF;
  out->cell_16_voltage = ((data[28] >> 4) | (data[29] << 4)) & 0x7FFF;
  out->cell_17_voltage = ((data[30] >> 3) | (data[31] << 5)) & 0x7FFF;
  out->cell_18_voltage = ((data[32] >> 2) | (data[33] << 6)) & 0x7FFF;
  out->cell_19_voltage = ((data[34] >> 1) | (data[35] << 7)) & 0x7FFF;
  out->cell_20_voltage = ((data[36] >> 0) | (data[37] << 8)) & 0x7FFF;
  out->cell_21_voltage = ((data[37] >> 7) | (data[38] << 1)) & 0x7FFF;
  out->cell_22_voltage = ((data[39] >> 6) | (data[40] << 2)) & 0x7FFF;
  out->cell_23_voltage = ((data[41] >> 5) | (data[42] << 3)) & 0x7FFF;
  out->cell_24_voltage = ((data[43] >> 4) | (data[44] << 4)) & 0x7FFF;
}

void CAN_Decode_bms_cell_temperatures(const twai_message_t* msg, bms_cell_temperatures_T* out) {
  if (msg == NULL || out == NULL) return;
  if (msg->identifier != 0x38F) return;

  const uint8_t* data = msg->data;
  out->valid = true;
  out->timestamp_ms = millis();

  out->multiplex = (data[0] >> 0) & 0x07;

  out->stack_1_LTC_internal_temp = CAN_ExtractFloat(data, 3, 12, 0.1, -40);
  out->stack_1_balance_temp = CAN_ExtractFloat(data, 15, 12, 0.1, -40);
  out->stack_2_LTC_internal_temp = CAN_ExtractFloat(data, 27, 12, 0.1, -40);
  out->stack_2_balance_temp = CAN_ExtractFloat(data, 39, 12, 0.1, -40);
  out->temp_1 = CAN_ExtractFloat(data, 51, 12, 0.1, -40);
  out->temp_2 = CAN_ExtractFloat(data, 63, 12, 0.1, 0);
  out->temp_3 = CAN_ExtractFloat(data, 75, 12, 0.1, -40);
  out->temp_4 = CAN_ExtractFloat(data, 87, 12, 0.1, -40);
  out->temp_5 = CAN_ExtractFloat(data, 99, 12, 0.1, -40);
  out->temp_6 = CAN_ExtractFloat(data, 111, 12, 0.1, -40);
  out->temp_7 = CAN_ExtractFloat(data, 123, 12, 0.1, -40);
  out->temp_8 = CAN_ExtractFloat(data, 135, 12, 0.1, -40);
  out->temp_9 = CAN_ExtractFloat(data, 147, 12, 0.1, -40);
  out->temp_10 = CAN_ExtractFloat(data, 159, 12, 0.1, -40);
  out->temp_11 = CAN_ExtractFloat(data, 171, 12, 0.1, -40);
  out->temp_12 = CAN_ExtractFloat(data, 183, 12, 0.1, -40);
  out->temp_13 = CAN_ExtractFloat(data, 195, 12, 0.1, -40);
  out->temp_14 = CAN_ExtractFloat(data, 207, 12, 0.1, -40);
  out->temp_15 = CAN_ExtractFloat(data, 219, 12, 0.1, -40);
  out->temp_16 = CAN_ExtractFloat(data, 231, 12, 0.1, -40);
  out->temp_17 = CAN_ExtractFloat(data, 243, 12, 0.1, -40);
  out->temp_18 = CAN_ExtractFloat(data, 255, 12, 0.1, -40);
  out->temp_19 = CAN_ExtractFloat(data, 267, 12, 0.1, -40);
  out->temp_20 = CAN_ExtractFloat(data, 279, 12, 0.1, -40);
  out->temp_21 = CAN_ExtractFloat(data, 291, 12, 0.1, -40);
  out->temp_22 = CAN_ExtractFloat(data, 303, 12, 0.1, -40);
  out->temp_23 = CAN_ExtractFloat(data, 315, 12, 0.1, -40);
  out->temp_24 = CAN_ExtractFloat(data, 327, 12, 0.1, -40);
}

void CAN_Decode_motorcontroller_motorStatus_PDO1(const twai_message_t* msg, motorcontroller_motorStatus_PDO1_T* out) {
  if (msg == NULL || out == NULL) return;
  if (msg->identifier != 0x391) return;

  const uint8_t* data = msg->data;
  out->valid = true;
  out->timestamp_ms = millis();

  out->Battery_Voltage = CAN_ExtractFloat(data, 0, 16, 0.0625, 0);
  out->Battery_Current = CAN_ExtractFloat(data, 16, 16, 0.0625, 0);
  out->Capacitor_Voltage = CAN_ExtractFloat(data, 32, 16, 0.0625, 0);
  out->Heatsink_Temperature = ((data[6] >> 0) | (data[7] << 8)) & 0xFFFF;
}

void CAN_Decode_motorcontroller_SDO_response(const twai_message_t* msg, motorcontroller_SDO_response_T* out) {
  if (msg == NULL || out == NULL) return;
  if (msg->identifier != 0x581) return;

  const uint8_t* data = msg->data;
  out->valid = true;
  out->timestamp_ms = millis();

  out->size = ((data[0] >> 0) & 0x01) ? true : false;
  out->expidited_xfer = ((data[0] >> 1) & 0x01) ? true : false;
  out->n_bytes = (data[0] >> 2) & 0x03;
  out->reserved = ((data[0] >> 4) & 0x01) ? true : false;
  out->ccs = (data[0] >> 5) & 0x07;
  out->index = ((data[1] >> 0) | (data[2] << 8)) & 0xFFFF;
  out->subindex = (data[3] >> 0) & 0xFF;
  out->byte_4 = (data[4] >> 0) & 0xFF;
  out->byte_5 = (data[5] >> 0) & 0xFF;
  out->byte_6 = (data[6] >> 0) & 0xFF;
  out->byte_7 = (data[7] >> 0) & 0xFF;
}

void CAN_Decode_bms_SDO_request(const twai_message_t* msg, bms_SDO_request_T* out) {
  if (msg == NULL || out == NULL) return;
  if (msg->identifier != 0x601) return;

  const uint8_t* data = msg->data;
  out->valid = true;
  out->timestamp_ms = millis();

  out->size = ((data[0] >> 0) & 0x01) ? true : false;
  out->expidited_xfer = ((data[0] >> 1) & 0x01) ? true : false;
  out->n_bytes = (data[0] >> 2) & 0x03;
  out->reserved = ((data[0] >> 4) & 0x01) ? true : false;
  out->ccs = (data[0] >> 5) & 0x07;
  out->index = ((data[1] >> 0) | (data[2] << 8)) & 0xFFFF;
  out->subindex = (data[3] >> 0) & 0xFF;
  out->byte_4 = (data[4] >> 0) & 0xFF;
  out->byte_5 = (data[5] >> 0) & 0xFF;
  out->byte_6 = (data[6] >> 0) & 0xFF;
  out->byte_7 = (data[7] >> 0) & 0xFF;
}

void CAN_Decode_motorcontroller_heartbeat(const twai_message_t* msg, motorcontroller_heartbeat_T* out) {
  if (msg == NULL || out == NULL) return;
  if (msg->identifier != 0x701) return;

  const uint8_t* data = msg->data;
  out->valid = true;
  out->timestamp_ms = millis();

  out->Mode = ((data[0] >> 0) | (data[1] << 8)) & 0xFFFF;
}

void CAN_Decode_bms_charger_request(const twai_message_t* msg, bms_charger_request_T* out) {
  if (msg == NULL || out == NULL) return;
  if (msg->identifier != 0x1806E5F4) return;

  const uint8_t* data = msg->data;
  out->valid = true;
  out->timestamp_ms = millis();

  out->output_voltage_high_byte = (data[0] >> 0) & 0xFF;
  out->output_voltage_low_byte = (data[1] >> 0) & 0xFF;
  out->output_current_high_byte = (data[2] >> 0) & 0xFF;
  out->output_current_low_byte = (data[3] >> 0) & 0xFF;
  out->start_charge_not_request = (data[4] >> 0) & 0xFF;
  out->charge_mode = (data[5] >> 0) & 0xFF;
  out->byte_7 = (data[6] >> 0) & 0xFF;
  out->byte_8 = (data[7] >> 0) & 0xFF;
}

void CAN_Decode_charger_status(const twai_message_t* msg, charger_status_T* out) {
  if (msg == NULL || out == NULL) return;
  if (msg->identifier != 0x18FF50E5) return;

  const uint8_t* data = msg->data;
  out->valid = true;
  out->timestamp_ms = millis();

  out->output_voltage_high_byte = (data[0] >> 0) & 0xFF;
  out->output_voltage_low_byte = (data[1] >> 0) & 0xFF;
  out->output_current_high_byte = (data[2] >> 0) & 0xFF;
  out->output_current_low_byte = (data[3] >> 0) & 0xFF;
  out->hardware_error = ((data[4] >> 0) & 0x01) ? true : false;
  out->charger_overtemp_error = ((data[4] >> 1) & 0x01) ? true : false;
  out->input_voltage_error = ((data[4] >> 2) & 0x01) ? true : false;
  out->battery_detect_error = ((data[4] >> 3) & 0x01) ? true : false;
  out->communication_error = ((data[4] >> 4) & 0x01) ? true : false;
  out->byte7 = ((data[4] >> 5) | (data[5] << 3)) & 0x00FF;
  out->byte8 = ((data[5] >> 5) | (data[6] << 3)) & 0x00FF;
}

