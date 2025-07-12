/* 
 * File:   commandService.c
 * Author: Claude/Voltworks
 * 
 * Command Service - Core Implementation
 * 
 * This contains the generic IO handlers and command processing.
 * Project-specific configuration is provided via config arrays.
 *
 * Created: 2025-07-06
 */

#include "can_iso_tp_lite.h"
#include "commandService_config.h"  // Must include config first to get definitions
#include "commandService.h"
#include <stddef.h>

// External arrays defined in config file
extern const CommandMapEntry_S commandMap[];
extern const uint8_t commandMapSize;
extern const SetDigitalOut_FPtr setDigitalOutFunctions[];
extern const GetDigitalIn_FPtr getDigitalInFunctions[];
extern const SetPwmOut_FPtr setPwmOutFunctions[];
extern const GetAnalogIn_FPtr getAnalogInFunctions[];
extern const GetVoltage_FPtr getVoltageFunctions[];
extern const GetCurrent_FPtr getCurrentFunctions[];

// Array size calculations for bounds checking
#define SET_DIGITAL_OUT_ARRAY_SIZE (sizeof(setDigitalOutFunctions) / sizeof(setDigitalOutFunctions[0]))
#define GET_DIGITAL_IN_ARRAY_SIZE (sizeof(getDigitalInFunctions) / sizeof(getDigitalInFunctions[0]))
#define SET_PWM_OUT_ARRAY_SIZE (sizeof(setPwmOutFunctions) / sizeof(setPwmOutFunctions[0]))
#define GET_ANALOG_IN_ARRAY_SIZE (sizeof(getAnalogInFunctions) / sizeof(getAnalogInFunctions[0]))
#define GET_VOLTAGE_ARRAY_SIZE (sizeof(getVoltageFunctions) / sizeof(getVoltageFunctions[0]))
#define GET_CURRENT_ARRAY_SIZE (sizeof(getCurrentFunctions) / sizeof(getCurrentFunctions[0]))

// Private function prototypes
static void commandService_processIoCommand(uint8_t* payload, uint8_t length);
static uint8_t commandService_executeCommand(const CommandMapEntry_S* cmd, uint8_t* payload, uint8_t length);
static uint8_t commandService_handleSetDigitalOut(uint8_t* payload, uint8_t length);
static uint8_t commandService_handleGetDigitalIn(uint8_t* payload, uint8_t length);
static uint8_t commandService_handleSetPwmOut(uint8_t* payload, uint8_t length);
static uint8_t commandService_handleGetAnalogIn(uint8_t* payload, uint8_t length);
static uint8_t commandService_handleGetVoltage(uint8_t* payload, uint8_t length);
static uint8_t commandService_handleGetCurrent(uint8_t* payload, uint8_t length);

void CommandService_Init(void) {
    isoTP_init();
}

void CommandService_Run(void) {
    if (isoTP_peekCommand() != ISO_TP_NONE) {
        isoTP_command_S command = isoTP_getCommand();
        
        if (command.command == ISO_TP_IO_CONTROL) {
            // Process IO control command, send paylaod minus the first byte (command ID)
            commandService_processIoCommand(&command.payload[1], command.payloadLength - 1);
        }
    }
}

static void commandService_processIoCommand(uint8_t* payload, uint8_t length) {
    if (length < 1) {
        CommandService_SendResponse(CMD_ERROR_INVALID_LENGTH, NULL, 0);
        return;
    }
    
    uint8_t commandId = payload[0];
    
    // Find command in mapping table
    for (uint8_t i = 0; i < commandMapSize; i++) {
        if (commandMap[i].commandId == commandId) {
            if (length >= commandMap[i].minPayloadLength + 1) {
                commandService_executeCommand(&commandMap[i], &payload[1], length - 1);
            } else {
                CommandService_SendResponse(CMD_ERROR_INVALID_LENGTH, NULL, 0);
            }
            return;
        }
    }
    
    CommandService_SendResponse(CMD_ERROR_UNKNOWN_COMMAND, NULL, 0);
}

static uint8_t commandService_executeCommand(const CommandMapEntry_S* cmd, uint8_t* payload, uint8_t length) {
    switch(cmd->commandType) {
        case CMD_TYPE_SET_DIGITAL_OUT:
            return commandService_handleSetDigitalOut(payload, length);
        case CMD_TYPE_GET_DIGITAL_IN:
            return commandService_handleGetDigitalIn(payload, length);
        case CMD_TYPE_SET_PWM_OUT:
            return commandService_handleSetPwmOut(payload, length);
        case CMD_TYPE_GET_ANALOG_IN:
            return commandService_handleGetAnalogIn(payload, length);
        case CMD_TYPE_GET_VOLTAGE:
            return commandService_handleGetVoltage(payload, length);
        case CMD_TYPE_GET_CURRENT:
            return commandService_handleGetCurrent(payload, length);
        default:
            CommandService_SendResponse(CMD_ERROR_UNKNOWN_COMMAND, NULL, 0);
            return CMD_ERROR_UNKNOWN_COMMAND;
    }
}

// Private command handler implementations
static uint8_t commandService_handleSetDigitalOut(uint8_t* payload, uint8_t length) {
    if (length < 2) return CMD_ERROR_INVALID_LENGTH;
    
    uint8_t ioIndex = payload[0];
    uint8_t state = payload[1];
    
    if (ioIndex >= SET_DIGITAL_OUT_ARRAY_SIZE) {
        return CMD_ERROR_INVALID_PARAM;
    }
    
    if (setDigitalOutFunctions[ioIndex] != NULL) {
        setDigitalOutFunctions[ioIndex](state);
        CommandService_SendResponse(CMD_SUCCESS, NULL, 0);
        return CMD_SUCCESS;
    }
    
    return CMD_ERROR_INVALID_PARAM;
}

static uint8_t commandService_handleGetDigitalIn(uint8_t* payload, uint8_t length) {
    if (length < 1) return CMD_ERROR_INVALID_LENGTH;
    
    uint8_t ioIndex = payload[0];
    
    if (ioIndex >= GET_DIGITAL_IN_ARRAY_SIZE) {
        return CMD_ERROR_INVALID_PARAM;
    }
    
    if (getDigitalInFunctions[ioIndex] != NULL) {
        uint8_t state = getDigitalInFunctions[ioIndex]();
        CommandService_SendResponse(CMD_SUCCESS, &state, 1);
        return CMD_SUCCESS;
    }
    
    return CMD_ERROR_INVALID_PARAM;
}

static uint8_t commandService_handleSetPwmOut(uint8_t* payload, uint8_t length) {
    if (length < 2) return CMD_ERROR_INVALID_LENGTH;
    
    uint8_t ioIndex = payload[0];
    uint8_t duty = payload[1];
    
    if (ioIndex >= SET_PWM_OUT_ARRAY_SIZE) {
        return CMD_ERROR_INVALID_PARAM;
    }
    
    if (setPwmOutFunctions[ioIndex] != NULL) {
        setPwmOutFunctions[ioIndex](duty);
        CommandService_SendResponse(CMD_SUCCESS, NULL, 0);
        return CMD_SUCCESS;
    }
    
    return CMD_ERROR_INVALID_PARAM;
}

static uint8_t commandService_handleGetAnalogIn(uint8_t* payload, uint8_t length) {
    if (length < 1) return CMD_ERROR_INVALID_LENGTH;
    
    uint8_t ioIndex = payload[0];
    
    if (ioIndex >= GET_ANALOG_IN_ARRAY_SIZE) {
        return CMD_ERROR_INVALID_PARAM;
    }
    
    if (getAnalogInFunctions[ioIndex] != NULL) {
        uint16_t value = getAnalogInFunctions[ioIndex]();
        CommandService_SendResponse(CMD_SUCCESS, (uint8_t*)&value, sizeof(uint16_t));
        return CMD_SUCCESS;
    }
    
    return CMD_ERROR_INVALID_PARAM;
}

static uint8_t commandService_handleGetVoltage(uint8_t* payload, uint8_t length) {
    if (length < 1) return CMD_ERROR_INVALID_LENGTH;
    
    uint8_t ioIndex = payload[0];
    
    if (ioIndex >= GET_VOLTAGE_ARRAY_SIZE) {
        return CMD_ERROR_INVALID_PARAM;
    }
    
    if (getVoltageFunctions[ioIndex] != NULL) {
        float voltage = getVoltageFunctions[ioIndex]();
        CommandService_SendResponse(CMD_SUCCESS, (uint8_t*)&voltage, sizeof(float));
        return CMD_SUCCESS;
    }
    
    return CMD_ERROR_INVALID_PARAM;
}

static uint8_t commandService_handleGetCurrent(uint8_t* payload, uint8_t length) {
    if (length < 1) return CMD_ERROR_INVALID_LENGTH;
    
    uint8_t ioIndex = payload[0];
    
    if (ioIndex >= GET_CURRENT_ARRAY_SIZE) {
        return CMD_ERROR_INVALID_PARAM;
    }
    
    if (getCurrentFunctions[ioIndex] != NULL) {
        float current = getCurrentFunctions[ioIndex]();
        CommandService_SendResponse(CMD_SUCCESS, (uint8_t*)&current, sizeof(float));
        return CMD_SUCCESS;
    }
    
    return CMD_ERROR_INVALID_PARAM;
}

// Public API implementation for response handling
void CommandService_SendResponse(uint8_t responseCode, uint8_t* data, uint8_t dataLength) {
    // TODO: Implement actual ISO-TP response mechanism
    // This would typically build a response packet and send it back
    // via the same ISO-TP channel that received the command
    
    // Example implementation:
    uint8_t responsePacket[64];
    responsePacket[0] = responseCode;
    if (data && dataLength > 0) {
        memcpy(&responsePacket[1], data, dataLength);
    }
    isoTP_SendData(responsePacket, dataLength + 1);

}