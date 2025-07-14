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

// Command ID = Command Type + Array Index
// Using 16-bit commands: High byte = Type, Low byte = Index
// This provides 256 commands per type (much more scalable)

// Command type values (high byte)
#define CMD_TYPE_SET_DIGITAL_OUT    0x01
#define CMD_TYPE_GET_DIGITAL_IN     0x02
#define CMD_TYPE_SET_PWM_OUT        0x03
#define CMD_TYPE_GET_ANALOG_IN      0x04
#define CMD_TYPE_GET_VOLTAGE        0x05
#define CMD_TYPE_GET_CURRENT        0x06

// Command calculation macros (16-bit commands)
#define CMD_SET_DIGITAL_OUT(index)      ((CMD_TYPE_SET_DIGITAL_OUT << 8) | (index))
#define CMD_GET_DIGITAL_IN(index)       ((CMD_TYPE_GET_DIGITAL_IN << 8) | (index))
#define CMD_SET_PWM_OUT(index)          ((CMD_TYPE_SET_PWM_OUT << 8) | (index))
#define CMD_GET_ANALOG_IN(index)        ((CMD_TYPE_GET_ANALOG_IN << 8) | (index))
#define CMD_GET_VOLTAGE(index)          ((CMD_TYPE_GET_VOLTAGE << 8) | (index))
#define CMD_GET_CURRENT(index)          ((CMD_TYPE_GET_CURRENT << 8) | (index))

// Response codes - duplicated here to avoid circular include
#define CMD_SUCCESS                    0x00
#define CMD_ERROR_UNKNOWN_COMMAND      0x01
#define CMD_ERROR_INVALID_LENGTH       0x02
#define CMD_ERROR_INVALID_PARAM        0x03
#define CMD_ERROR_PERMISSION_DENIED    0x04
#define CMD_ERROR_SYSTEM_BUSY          0x05

// Command parsing macros for direct array indexing (16-bit commands)
#define GET_COMMAND_TYPE(cmd_id)        ((cmd_id) >> 8)            // Extract command type (high byte)
#define GET_ARRAY_INDEX(cmd_id)         ((cmd_id) & 0xFF)          // Extract array index (low byte)

// Command validation macros
#define IS_SET_DIGITAL_OUT_CMD(cmd_id)  (GET_COMMAND_TYPE(cmd_id) == CMD_TYPE_SET_DIGITAL_OUT)
#define IS_GET_DIGITAL_IN_CMD(cmd_id)   (GET_COMMAND_TYPE(cmd_id) == CMD_TYPE_GET_DIGITAL_IN)
#define IS_SET_PWM_OUT_CMD(cmd_id)      (GET_COMMAND_TYPE(cmd_id) == CMD_TYPE_SET_PWM_OUT)
#define IS_GET_ANALOG_IN_CMD(cmd_id)    (GET_COMMAND_TYPE(cmd_id) == CMD_TYPE_GET_ANALOG_IN)
#define IS_GET_VOLTAGE_CMD(cmd_id)      (GET_COMMAND_TYPE(cmd_id) == CMD_TYPE_GET_VOLTAGE)
#define IS_GET_CURRENT_CMD(cmd_id)      (GET_COMMAND_TYPE(cmd_id) == CMD_TYPE_GET_CURRENT)

// Payload length validation (index now encoded in command ID)
#define MIN_PAYLOAD_SET_DIGITAL_OUT     1   // [state]
#define MIN_PAYLOAD_GET_DIGITAL_IN      0   // []
#define MIN_PAYLOAD_SET_PWM_OUT         1   // [duty]
#define MIN_PAYLOAD_GET_ANALOG_IN       0   // []
#define MIN_PAYLOAD_GET_VOLTAGE         0   // []
#define MIN_PAYLOAD_GET_CURRENT         0   // []

#endif /* COMMAND_SERVICE_CONFIG_H */