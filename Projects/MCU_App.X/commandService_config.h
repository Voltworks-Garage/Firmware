/* 
 * File:   commandService_config.h
 * Author: Claude/Voltworks
 * 
 * Command Service Configuration for MCU Project
 * 
 * This file defines function pointer arrays that map to the
 * MCU project's IO functions.
 *
 * Created: 2025-07-06
 */

#ifndef COMMAND_SERVICE_CONFIG_H
#define COMMAND_SERVICE_CONFIG_H

#include <stdint.h>
#include <stddef.h>
#include "IO.h"

// Command structure: Separate command type and array index (much simpler!)
// Payload: [msg_type, command_type, array_index, ...params]

// Command type values (8-bit) - shared across projects
#define CMD_TYPE_SET_DIGITAL_OUT    0x01
#define CMD_TYPE_GET_DIGITAL_IN     0x02
#define CMD_TYPE_SET_PWM_OUT        0x03
#define CMD_TYPE_GET_ANALOG_IN      0x04
#define CMD_TYPE_GET_VOLTAGE        0x05
#define CMD_TYPE_GET_CURRENT        0x06

// Response codes - duplicated here to avoid circular include
#define CMD_SUCCESS                    0x00
#define CMD_ERROR_UNKNOWN_COMMAND      0x01
#define CMD_ERROR_INVALID_LENGTH       0x02
#define CMD_ERROR_INVALID_PARAM        0x03
#define CMD_ERROR_PERMISSION_DENIED    0x04
#define CMD_ERROR_SYSTEM_BUSY          0x05

// Payload length validation (cmd_type + array_index + params)
#define MIN_PAYLOAD_SET_DIGITAL_OUT     3   // [cmd_type, array_index, state]
#define MIN_PAYLOAD_GET_DIGITAL_IN      2   // [cmd_type, array_index]
#define MIN_PAYLOAD_SET_PWM_OUT         3   // [cmd_type, array_index, duty]
#define MIN_PAYLOAD_GET_ANALOG_IN       2   // [cmd_type, array_index]
#define MIN_PAYLOAD_GET_VOLTAGE         2   // [cmd_type, array_index]
#define MIN_PAYLOAD_GET_CURRENT         2   // [cmd_type, array_index]

// MCU-specific digital output mapping (array_index to function)
// Array index 0 = Headlight High
// Array index 1 = Headlight Low  
// Array index 2 = Brake Light
// Array index 3 = Turn Signal Front
// Array index 4 = Turn Signal Rear
// Array index 5 = Horn
// Array index 6 = Heated Grips
// Array index 7 = Heated Seat
// Array index 8 = Motor Controller
// Array index 9 = Charge Controller
// Array index 10 = Battery Contactor
// Array index 11 = Precharge Relay

// MCU-specific digital input mapping (array_index to function)
// Array index 0 = Headlight High Status
// Array index 1 = Headlight Low Status
// Array index 2 = Brake Light Status
// Array index 3 = Turn Signal Front Status
// Array index 4 = Turn Signal Rear Status
// Array index 5 = Horn Status
// Array index 6 = Heated Grips Status
// Array index 7 = Heated Seat Status
// Array index 8 = Motor Controller Status
// Array index 9 = Charge Controller Status
// Array index 10 = Battery Contactor Status
// Array index 11 = Precharge Relay Status

#endif /* COMMAND_SERVICE_CONFIG_H */