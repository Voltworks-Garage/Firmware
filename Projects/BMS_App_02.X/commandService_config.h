/* 
 * File:   commandService_config.h
 * Author: Claude/Voltworks
 * 
 * Command Service Configuration for BMS Project
 * 
 * This file defines function pointer arrays that map to the
 * BMS project's IO functions.
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

// Command type values (8-bit)
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

#endif /* COMMAND_SERVICE_CONFIG_H */