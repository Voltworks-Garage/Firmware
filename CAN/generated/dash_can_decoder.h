#ifndef DASH_CAN_DECODER_H
#define DASH_CAN_DECODER_H

#include <Arduino.h>
#include "driver/twai.h"

// Auto-generated CAN decoder for ESP32
// Node: dash

// Helper function to extract bits from CAN data
uint32_t CAN_ExtractBits(const uint8_t* data, uint16_t startBit, uint8_t numBits);
float CAN_ExtractFloat(const uint8_t* data, uint16_t startBit, uint8_t numBits, float scale, float offset);

// CAN Message IDs
#define CAN_ID_MOTORCONTROLLER_SYNC                        0x080
#define CAN_ID_MOTORCONTROLLER_EMERGENCY                   0x081
#define CAN_ID_BOOT_HOST_BMS                               0x0A1
#define CAN_ID_BMS_BOOT_RESPONSE                           0x0A2
#define CAN_ID_BOOT_HOST_MCU                               0x0A3
#define CAN_ID_BOOT_HOST_DASH                              0x0A5
#define CAN_ID_MCU_MOTORCONTROLLERREQUEST                  0x201
#define CAN_ID_MOTORCONTROLLER_MOTOR_STATUS_PDO4           0x271
#define CAN_ID_MOTORCONTROLLER_MOTORSTATUS_PDO2            0x330
#define CAN_ID_MCU_STATUS                                  0x388
#define CAN_ID_MCU_COMMAND                                 0x389
#define CAN_ID_MCU_MCU_DEBUG                               0x38A
#define CAN_ID_BMS_STATUS                                  0x38B
#define CAN_ID_BMS_POWER_SYSTEMS                           0x38C
#define CAN_ID_BMS_DEBUG                                   0x38D
#define CAN_ID_BMS_CELL_VOLTAGES                           0x38E
#define CAN_ID_BMS_CELL_TEMPERATURES                       0x38F
#define CAN_ID_MOTORCONTROLLER_MOTORSTATUS_PDO1            0x391
#define CAN_ID_MOTORCONTROLLER_SDO_RESPONSE                0x581
#define CAN_ID_BMS_SDO_REQUEST                             0x601
#define CAN_ID_MOTORCONTROLLER_HEARTBEAT                   0x701
#define CAN_ID_BMS_CHARGER_REQUEST                         0x1806E5F4
#define CAN_ID_CHARGER_STATUS                              0x18FF50E5

// Decoded message structures
typedef struct {
  bool valid;  // Set to true after successful decode
  uint32_t timestamp_ms;  // Timestamp of last update
} motorcontroller_SYNC_T;

typedef struct {
  bool valid;  // Set to true after successful decode
  uint32_t timestamp_ms;  // Timestamp of last update
  uint16_t     EMCY;
} motorcontroller_Emergency_T;

typedef struct {
  bool valid;  // Set to true after successful decode
  uint32_t timestamp_ms;  // Timestamp of last update
  uint8_t      type;
  uint8_t      code;
  uint8_t      byte1;
  uint8_t      byte2;
  uint8_t      byte3;
  uint8_t      byte4;
  uint8_t      byte5;
  uint8_t      byte6;
  uint8_t      byte7;
} boot_host_bms_T;

typedef struct {
  bool valid;  // Set to true after successful decode
  uint32_t timestamp_ms;  // Timestamp of last update
  uint8_t      type;
  uint8_t      code;
  uint8_t      byte1;
  uint8_t      byte2;
  uint8_t      byte3;
  uint8_t      byte4;
  uint8_t      byte5;
  uint8_t      byte6;
  uint8_t      byte7;
} bms_boot_response_T;

typedef struct {
  bool valid;  // Set to true after successful decode
  uint32_t timestamp_ms;  // Timestamp of last update
  uint8_t      type;
  uint8_t      code;
  uint8_t      byte1;
  uint8_t      byte2;
  uint8_t      byte3;
  uint8_t      byte4;
  uint8_t      byte5;
  uint8_t      byte6;
  uint8_t      byte7;
} boot_host_mcu_T;

typedef struct {
  bool valid;  // Set to true after successful decode
  uint32_t timestamp_ms;  // Timestamp of last update
  uint8_t      type;
  uint8_t      code;
  uint8_t      byte1;
  uint8_t      byte2;
  uint8_t      byte3;
  uint8_t      byte4;
  uint8_t      byte5;
  uint8_t      byte6;
  uint8_t      byte7;
} boot_host_dash_T;

typedef struct {
  bool valid;  // Set to true after successful decode
  uint32_t timestamp_ms;  // Timestamp of last update
  uint16_t     Throttle_Value;
  bool         Forward_Switch;  // bool
  bool         Reverse_Switch;  // bool
  bool         FS1_Switch;  // bool
  bool         Seat_Switch;  // bool
  bool         Handbrake_Switch;  // bool
  uint16_t     Footbrake_Value;
} mcu_motorControllerRequest_T;

typedef struct {
  bool valid;  // Set to true after successful decode
  uint32_t timestamp_ms;  // Timestamp of last update
  float        Motor_Torque;  // nM
  uint32_t     Motor_Velocity;  // RPM
  uint16_t     Motor_AC_Current;  // A
} motorcontroller_motor_status_PDO4_T;

typedef struct {
  bool valid;  // Set to true after successful decode
  uint32_t timestamp_ms;  // Timestamp of last update
  float        Throttle_Input_Voltage;  // V
  float        Throttle_Value;  // %
} motorcontroller_motorStatus_PDO2_T;

typedef struct {
  bool valid;  // Set to true after successful decode
  uint32_t timestamp_ms;  // Timestamp of last update
  uint16_t multiplex;  // Multiplex value
  uint8_t      vehicleState;
  bool         highBeam;  // bool
  bool         lowBeam;  // bool
  bool         brakeLight;  // bool
  bool         tailLight;  // bool
  bool         horn;  // bool
  bool         turnSignalFR;  // bool
  bool         turnSignalFL;  // bool
  bool         turnSignalRR;  // bool
  bool         turnSignalRL;  // bool
  bool         brakeSwitchFront;  // bool
  bool         brakeSwitchRear;  // bool
  bool         killSwitch;  // bool
  bool         ignitionSwitch;  // bool
  bool         leftTurnSwitch;  // bool
  bool         rightTurnSwitch;  // bool
  bool         lightSwitch;  // bool
  bool         assSwitch;  // bool
  bool         hornSwitch;  // bool
  float        batt_voltage;  // V
  float        batt_current;  // A
  float        dcdc_current;  // A
  bool         batt_fault;  // bool
  bool         dcdc_fault;  // bool
  bool         fan_fault;  // bool
  bool         pump_fault;  // bool
  bool         taillight_fault;  // bool
  bool         brakelight_fault;  // bool
  bool         lowbeam_fault;  // bool
  bool         highbeam_fault;  // bool
  bool         horn_fault;  // bool
  bool         aux_port_fault;  // bool
  bool         heated_grips_fault;  // bool
  bool         heated_seat_fault;  // bool
  bool         charge_controller_fault;  // bool
  bool         motor_controller_fault;  // bool
  bool         bms_controller_fault;  // bool
  bool         J1772_controller_fault;  // bool
  bool         ic_controller_fault;  // bool
  uint16_t     fan_current;  // mA
  uint16_t     pump_current;  // mA
  uint16_t     taillight_current;  // mA
  uint16_t     brakelight_current;  // mA
  uint16_t     lowbeam_current;  // mA
  uint16_t     highbeam_current;  // mA
  uint16_t     horn_current;  // mA
  uint16_t     aux_port_current;  // mA
  uint16_t     heated_grips_current;  // mA
  uint16_t     heated_seat_current;  // mA
  uint16_t     charge_controller_current;  // mA
  uint16_t     motor_controller_current;  // mA
  uint16_t     bms_controller_current;  // mA
  uint16_t     J1772_controller_current;  // mA
} mcu_status_T;

typedef struct {
  bool valid;  // Set to true after successful decode
  uint32_t timestamp_ms;  // Timestamp of last update
  bool         DCDC_enable;  // bool
  uint8_t      J1772_prox_status;  // enum
  uint8_t      J1772_pilot_current;  // A
  bool         precharge_enable;  // bool
  bool         motor_controller_enable;  // bool
} mcu_command_T;

typedef struct {
  bool valid;  // Set to true after successful decode
  uint32_t timestamp_ms;  // Timestamp of last update
  uint16_t multiplex;  // Multiplex value
  float        cpu_usage_percent;  // %
  float        cpu_peak_percent;  // %
  uint16_t     debug_value_1_u16;
  uint32_t     debug_value_1_u24;
  uint8_t      task_1ms_cpu_percent;  // %
  uint8_t      task_10ms_cpu_percent;  // %
  uint8_t      task_100ms_cpu_percent;  // %
  uint8_t      task_1000ms_cpu_percent;  // %
  uint32_t     debug_value_1_u30;
  uint8_t      task_1ms_peak_cpu_percent;  // %
  uint8_t      task_10ms_peak_cpu_percent;  // %
  uint8_t      task_100ms_peak_cpu_percent;  // %
  uint8_t      task_1000ms_peak_cpu_percent;  // %
} mcu_mcu_debug_T;

typedef struct {
  bool valid;  // Set to true after successful decode
  uint32_t timestamp_ms;  // Timestamp of last update
  uint16_t multiplex;  // Multiplex value
  uint8_t      bms_state;  // enum
  float        pack_voltage;  // V
  float        pack_current;  // A
  float        soc_percent;  // %
  float        pack_temp_min;  // degC
  float        pack_temp_max;  // degC
  float        stack_voltage_1;  // V
  float        stack_voltage_2;  // V
  float        pack_voltage_sum_of_stacks;  // V
  uint8_t      ltc_state;  // enum
  uint16_t     ltc_error_count;
  uint8_t      ltc_last_error;  // enum
  float        cpu_usage_percent;  // %
  float        cpu_peak_percent;  // %
  float        vbus_voltage;  // V
  float        internal_temp;  // degC
  uint16_t     max_charge_current_mA;  // mA
  uint32_t     max_charge_voltage_mV;  // mV
  bool         contactors_closed;  // bool
  bool         precharge_active;  // bool
  bool         charge_allowed;  // bool
  bool         discharge_allowed;  // bool
  uint16_t     fault_summary;  // bitfield
  bool         is_balancing;  // bool
  uint8_t      cell_A_balancing;
  uint8_t      cell_B_balancing;
  uint8_t      cell_C_balancing;
  uint8_t      cell_D_balancing;
  uint8_t      cell_E_balancing;
} bms_status_T;

typedef struct {
  bool valid;  // Set to true after successful decode
  uint32_t timestamp_ms;  // Timestamp of last update
  bool         DCDC_state;  // bool
  bool         DCDC_fault;  // bool
  float        DCDC_voltage;  // V
  float        DCDC_current;  // A
  bool         EV_charger_state;  // bool
  bool         EV_charger_fault;  // bool
  float        EV_charger_voltage;  // V
  float        EV_charger_current;  // A
  bool         J1772_ready_to_charge;  // bool
  bool         HV_precharge_state;  // bool
  float        HV_isolation_voltage;  // V
  bool         HV_contactor_state;  // bool
} bms_power_systems_T;

typedef struct {
  bool valid;  // Set to true after successful decode
  uint32_t timestamp_ms;  // Timestamp of last update
  uint16_t multiplex;  // Multiplex value
  uint8_t      task_1ms_cpu_percent;  // %
  uint8_t      task_10ms_cpu_percent;  // %
  uint8_t      task_100ms_cpu_percent;  // %
  uint8_t      task_1000ms_cpu_percent;  // %
  uint8_t      task_1ms_peak_cpu_percent;  // %
  uint8_t      task_10ms_peak_cpu_percent;  // %
  uint8_t      task_100ms_peak_cpu_percent;  // %
  uint8_t      task_1000ms_peak_cpu_percent;  // %
  bool         bool0;  // bool
  bool         bool1;  // bool
  float        float1;  // V
  float        float2;  // V
  uint16_t     word1;
  uint8_t      byte1;
} bms_debug_T;

typedef struct {
  bool valid;  // Set to true after successful decode
  uint32_t timestamp_ms;  // Timestamp of last update
  uint16_t multiplex;  // Multiplex value
  uint16_t     cell_1_voltage;  // mV
  uint16_t     cell_2_voltage;  // mV
  uint16_t     cell_3_voltage;  // mV
  uint16_t     cell_4_voltage;  // mV
  uint16_t     cell_5_voltage;  // mV
  uint16_t     cell_6_voltage;  // mV
  uint16_t     cell_7_voltage;  // mV
  uint16_t     cell_8_voltage;  // mV
  uint16_t     cell_9_voltage;  // mV
  uint16_t     cell_10_voltage;  // mV
  uint16_t     cell_11_voltage;  // mV
  uint16_t     cell_12_voltage;  // mV
  uint16_t     cell_13_voltage;  // mV
  uint16_t     cell_14_voltage;  // mV
  uint16_t     cell_15_voltage;  // mV
  uint16_t     cell_16_voltage;  // mV
  uint16_t     cell_17_voltage;  // mV
  uint16_t     cell_18_voltage;  // mV
  uint16_t     cell_19_voltage;  // mV
  uint16_t     cell_20_voltage;  // mV
  uint16_t     cell_21_voltage;  // mV
  uint16_t     cell_22_voltage;  // mV
  uint16_t     cell_23_voltage;  // mV
  uint16_t     cell_24_voltage;  // mV
} bms_cell_voltages_T;

typedef struct {
  bool valid;  // Set to true after successful decode
  uint32_t timestamp_ms;  // Timestamp of last update
  uint16_t multiplex;  // Multiplex value
  float        stack_1_LTC_internal_temp;  // degC
  float        stack_1_balance_temp;  // degC
  float        stack_2_LTC_internal_temp;  // degC
  float        stack_2_balance_temp;  // degC
  float        temp_1;  // degC
  float        temp_2;  // degC
  float        temp_3;  // degC
  float        temp_4;  // degC
  float        temp_5;  // degC
  float        temp_6;  // degC
  float        temp_7;  // degC
  float        temp_8;  // degC
  float        temp_9;  // degC
  float        temp_10;  // degC
  float        temp_11;  // degC
  float        temp_12;  // degC
  float        temp_13;  // degC
  float        temp_14;  // degC
  float        temp_15;  // degC
  float        temp_16;  // degC
  float        temp_17;  // degC
  float        temp_18;  // degC
  float        temp_19;  // degC
  float        temp_20;  // degC
  float        temp_21;  // degC
  float        temp_22;  // degC
  float        temp_23;  // degC
  float        temp_24;  // degC
} bms_cell_temperatures_T;

typedef struct {
  bool valid;  // Set to true after successful decode
  uint32_t timestamp_ms;  // Timestamp of last update
  float        Battery_Voltage;  // V
  float        Battery_Current;  // A
  float        Capacitor_Voltage;  // V
  uint16_t     Heatsink_Temperature;  // degC
} motorcontroller_motorStatus_PDO1_T;

typedef struct {
  bool valid;  // Set to true after successful decode
  uint32_t timestamp_ms;  // Timestamp of last update
  bool         size;  // bool
  bool         expidited_xfer;  // bool
  uint8_t      n_bytes;  // enum
  bool         reserved;
  uint8_t      ccs;  // enum
  uint16_t     index;  // 0x
  uint8_t      subindex;  // 0x
  uint8_t      byte_4;
  uint8_t      byte_5;
  uint8_t      byte_6;
  uint8_t      byte_7;
} motorcontroller_SDO_response_T;

typedef struct {
  bool valid;  // Set to true after successful decode
  uint32_t timestamp_ms;  // Timestamp of last update
  bool         size;  // bool
  bool         expidited_xfer;  // bool
  uint8_t      n_bytes;  // enum
  bool         reserved;
  uint8_t      ccs;  // enum
  uint16_t     index;  // 0x
  uint8_t      subindex;  // 0x
  uint8_t      byte_4;
  uint8_t      byte_5;
  uint8_t      byte_6;
  uint8_t      byte_7;
} bms_SDO_request_T;

typedef struct {
  bool valid;  // Set to true after successful decode
  uint32_t timestamp_ms;  // Timestamp of last update
  uint16_t     Mode;  // enum
} motorcontroller_heartbeat_T;

typedef struct {
  bool valid;  // Set to true after successful decode
  uint32_t timestamp_ms;  // Timestamp of last update
  uint8_t      output_voltage_high_byte;
  uint8_t      output_voltage_low_byte;
  uint8_t      output_current_high_byte;
  uint8_t      output_current_low_byte;
  uint8_t      start_charge_not_request;
  uint8_t      charge_mode;
  uint8_t      byte_7;
  uint8_t      byte_8;
} bms_charger_request_T;

typedef struct {
  bool valid;  // Set to true after successful decode
  uint32_t timestamp_ms;  // Timestamp of last update
  uint8_t      output_voltage_high_byte;
  uint8_t      output_voltage_low_byte;
  uint8_t      output_current_high_byte;
  uint8_t      output_current_low_byte;
  bool         hardware_error;  // bool
  bool         charger_overtemp_error;  // bool
  bool         input_voltage_error;  // bool
  bool         battery_detect_error;  // bool
  bool         communication_error;  // bool
  uint8_t      byte7;
  uint8_t      byte8;
} charger_status_T;

// Decoder functions
void CAN_Decode_motorcontroller_SYNC(const twai_message_t* msg, motorcontroller_SYNC_T* out);
void CAN_Decode_motorcontroller_Emergency(const twai_message_t* msg, motorcontroller_Emergency_T* out);
void CAN_Decode_boot_host_bms(const twai_message_t* msg, boot_host_bms_T* out);
void CAN_Decode_bms_boot_response(const twai_message_t* msg, bms_boot_response_T* out);
void CAN_Decode_boot_host_mcu(const twai_message_t* msg, boot_host_mcu_T* out);
void CAN_Decode_boot_host_dash(const twai_message_t* msg, boot_host_dash_T* out);
void CAN_Decode_mcu_motorControllerRequest(const twai_message_t* msg, mcu_motorControllerRequest_T* out);
void CAN_Decode_motorcontroller_motor_status_PDO4(const twai_message_t* msg, motorcontroller_motor_status_PDO4_T* out);
void CAN_Decode_motorcontroller_motorStatus_PDO2(const twai_message_t* msg, motorcontroller_motorStatus_PDO2_T* out);
void CAN_Decode_mcu_status(const twai_message_t* msg, mcu_status_T* out);
void CAN_Decode_mcu_command(const twai_message_t* msg, mcu_command_T* out);
void CAN_Decode_mcu_mcu_debug(const twai_message_t* msg, mcu_mcu_debug_T* out);
void CAN_Decode_bms_status(const twai_message_t* msg, bms_status_T* out);
void CAN_Decode_bms_power_systems(const twai_message_t* msg, bms_power_systems_T* out);
void CAN_Decode_bms_debug(const twai_message_t* msg, bms_debug_T* out);
void CAN_Decode_bms_cell_voltages(const twai_message_t* msg, bms_cell_voltages_T* out);
void CAN_Decode_bms_cell_temperatures(const twai_message_t* msg, bms_cell_temperatures_T* out);
void CAN_Decode_motorcontroller_motorStatus_PDO1(const twai_message_t* msg, motorcontroller_motorStatus_PDO1_T* out);
void CAN_Decode_motorcontroller_SDO_response(const twai_message_t* msg, motorcontroller_SDO_response_T* out);
void CAN_Decode_bms_SDO_request(const twai_message_t* msg, bms_SDO_request_T* out);
void CAN_Decode_motorcontroller_heartbeat(const twai_message_t* msg, motorcontroller_heartbeat_T* out);
void CAN_Decode_bms_charger_request(const twai_message_t* msg, bms_charger_request_T* out);
void CAN_Decode_charger_status(const twai_message_t* msg, charger_status_T* out);

#endif // DASH_CAN_DECODER_H
