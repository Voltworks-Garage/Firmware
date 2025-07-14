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

// Function pointer arrays are now defined in IO.h and included via commandService_config.h

// Array size calculations for bounds checking
#define SET_DIGITAL_OUT_ARRAY_SIZE (sizeof(setDigitalOutFunctions) / sizeof(setDigitalOutFunctions[0]))
#define GET_DIGITAL_IN_ARRAY_SIZE (sizeof(getDigitalInFunctions) / sizeof(getDigitalInFunctions[0]))
#define SET_PWM_OUT_ARRAY_SIZE (sizeof(setPwmOutFunctions) / sizeof(setPwmOutFunctions[0]))
#define GET_ANALOG_IN_ARRAY_SIZE (sizeof(getAnalogInFunctions) / sizeof(getAnalogInFunctions[0]))
#define GET_VOLTAGE_ARRAY_SIZE (sizeof(getVoltageFunctions) / sizeof(getVoltageFunctions[0]))
#define GET_CURRENT_ARRAY_SIZE (sizeof(getCurrentFunctions) / sizeof(getCurrentFunctions[0]))

// Private function prototypes
static void commandService_processIoCommand(uint8_t* payload, uint8_t length);
static uint8_t commandService_handleSetDigitalOut(uint8_t arrayIndex, uint8_t* payload, uint8_t length);
static uint8_t commandService_handleGetDigitalIn(uint8_t arrayIndex, uint8_t* payload, uint8_t length);
static uint8_t commandService_handleSetPwmOut(uint8_t arrayIndex, uint8_t* payload, uint8_t length);
static uint8_t commandService_handleGetAnalogIn(uint8_t arrayIndex, uint8_t* payload, uint8_t length);
static uint8_t commandService_handleGetVoltage(uint8_t arrayIndex, uint8_t* payload, uint8_t length);
static uint8_t commandService_handleGetCurrent(uint8_t arrayIndex, uint8_t* payload, uint8_t length);

void CommandService_Init(void) {
    isoTP_init();
}

void CommandService_Run(void) {
    if (isoTP_peekCommand() != ISO_TP_NONE) {
        isoTP_command_S command = isoTP_getCommand();
        
        switch (command.command) {
            case ISO_TP_IO_CONTROL:
                // Process IO control command, send payload minus the first byte (command ID)
                commandService_processIoCommand(&command.payload[1], command.payloadLength - 1);
                break;
                
            case ISO_TP_RESET:
                // Handle reset command - typically resets the system
                //CommandService_SendResponse(CMD_SUCCESS, NULL, 0);
                // TODO: Implement system reset functionality
                asm("reset"); // Uncomment when ready to implement actual reset
                break;
                
            case ISO_TP_SLEEP:
                // Handle sleep command - puts system into low power mode
                CommandService_SendResponse(CMD_SUCCESS, NULL, 0);
                // TODO: Implement sleep/low power mode functionality
                break;
                
            case ISO_TP_TESTER_PRESENT:
                // Handle tester present - keeps communication alive
                CommandService_SendResponse(CMD_SUCCESS, NULL, 0);
                break;
                
            case ISO_TP_NONE:
            default:
                // Should not reach here, but handle gracefully
                break;
        }
    }
}

static void commandService_processIoCommand(uint8_t* payload, uint8_t length) {
    if (length < 2) {
        CommandService_SendResponse(CMD_ERROR_INVALID_LENGTH, NULL, 0);
        return;
    }
    
    // Simple approach: [command_type, array_index, ...params]
    uint8_t commandType = payload[0];
    uint8_t arrayIndex = payload[1];
    
    // Route to appropriate handler based on command type (much simpler!)
    if (commandType == CMD_TYPE_SET_DIGITAL_OUT) {
        if (length >= MIN_PAYLOAD_SET_DIGITAL_OUT) {
            commandService_handleSetDigitalOut(arrayIndex, &payload[2], length - 2);
        } else {
            CommandService_SendResponse(CMD_ERROR_INVALID_LENGTH, NULL, 0);
        }
    } else if (commandType == CMD_TYPE_GET_DIGITAL_IN) {
        if (length >= MIN_PAYLOAD_GET_DIGITAL_IN) {
            commandService_handleGetDigitalIn(arrayIndex, &payload[2], length - 2);
        } else {
            CommandService_SendResponse(CMD_ERROR_INVALID_LENGTH, NULL, 0);
        }
    } else if (commandType == CMD_TYPE_SET_PWM_OUT) {
        if (length >= MIN_PAYLOAD_SET_PWM_OUT) {
            commandService_handleSetPwmOut(arrayIndex, &payload[2], length - 2);
        } else {
            CommandService_SendResponse(CMD_ERROR_INVALID_LENGTH, NULL, 0);
        }
    } else if (commandType == CMD_TYPE_GET_ANALOG_IN) {
        if (length >= MIN_PAYLOAD_GET_ANALOG_IN) {
            commandService_handleGetAnalogIn(arrayIndex, &payload[2], length - 2);
        } else {
            CommandService_SendResponse(CMD_ERROR_INVALID_LENGTH, NULL, 0);
        }
    } else if (commandType == CMD_TYPE_GET_VOLTAGE) {
        if (length >= MIN_PAYLOAD_GET_VOLTAGE) {
            commandService_handleGetVoltage(arrayIndex, &payload[2], length - 2);
        } else {
            CommandService_SendResponse(CMD_ERROR_INVALID_LENGTH, NULL, 0);
        }
    } else if (commandType == CMD_TYPE_GET_CURRENT) {
        if (length >= MIN_PAYLOAD_GET_CURRENT) {
            commandService_handleGetCurrent(arrayIndex, &payload[2], length - 2);
        } else {
            CommandService_SendResponse(CMD_ERROR_INVALID_LENGTH, NULL, 0);
        }
    } else {
        CommandService_SendResponse(CMD_ERROR_UNKNOWN_COMMAND, NULL, 0);
    }
}

// Private command handler implementations
static uint8_t commandService_handleSetDigitalOut(uint8_t arrayIndex, uint8_t* payload, uint8_t length) {
    if (length < 1) return CMD_ERROR_INVALID_LENGTH;
    
    uint8_t state = payload[0];
    
    if (arrayIndex >= SET_DIGITAL_OUT_ARRAY_SIZE) {
        return CMD_ERROR_INVALID_PARAM;
    }
    
    if (setDigitalOutFunctions[arrayIndex] != NULL) {
        setDigitalOutFunctions[arrayIndex](state);
        CommandService_SendResponse(CMD_SUCCESS, NULL, 0);
        return CMD_SUCCESS;
    }
    
    return CMD_ERROR_INVALID_PARAM;
}

static uint8_t commandService_handleGetDigitalIn(uint8_t arrayIndex, uint8_t* payload, uint8_t length) {
    // No payload needed for digital input read
    
    if (arrayIndex >= GET_DIGITAL_IN_ARRAY_SIZE) {
        return CMD_ERROR_INVALID_PARAM;
    }
    
    if (getDigitalInFunctions[arrayIndex] != NULL) {
        uint8_t state = getDigitalInFunctions[arrayIndex]();
        CommandService_SendResponse(CMD_SUCCESS, &state, 1);
        return CMD_SUCCESS;
    }
    
    return CMD_ERROR_INVALID_PARAM;
}

static uint8_t commandService_handleSetPwmOut(uint8_t arrayIndex, uint8_t* payload, uint8_t length) {
    if (length < 1) return CMD_ERROR_INVALID_LENGTH;
    
    uint8_t duty = payload[0];
    
    if (arrayIndex >= SET_PWM_OUT_ARRAY_SIZE) {
        return CMD_ERROR_INVALID_PARAM;
    }
    
    if (setPwmOutFunctions[arrayIndex] != NULL) {
        setPwmOutFunctions[arrayIndex](duty);
        CommandService_SendResponse(CMD_SUCCESS, NULL, 0);
        return CMD_SUCCESS;
    }
    
    return CMD_ERROR_INVALID_PARAM;
}

static uint8_t commandService_handleGetAnalogIn(uint8_t arrayIndex, uint8_t* payload, uint8_t length) {
    // No payload needed for analog input read
    
    if (arrayIndex >= GET_ANALOG_IN_ARRAY_SIZE) {
        return CMD_ERROR_INVALID_PARAM;
    }
    
    if (getAnalogInFunctions[arrayIndex] != NULL) {
        uint16_t value = getAnalogInFunctions[arrayIndex]();
        CommandService_SendResponse(CMD_SUCCESS, (uint8_t*)&value, sizeof(uint16_t));
        return CMD_SUCCESS;
    }
    
    return CMD_ERROR_INVALID_PARAM;
}

static uint8_t commandService_handleGetVoltage(uint8_t arrayIndex, uint8_t* payload, uint8_t length) {
    // No payload needed for voltage read
    
    if (arrayIndex >= GET_VOLTAGE_ARRAY_SIZE) {
        return CMD_ERROR_INVALID_PARAM;
    }
    
    if (getVoltageFunctions[arrayIndex] != NULL) {
        float voltage = getVoltageFunctions[arrayIndex]();
        CommandService_SendResponse(CMD_SUCCESS, (uint8_t*)&voltage, sizeof(float));
        return CMD_SUCCESS;
    }
    
    return CMD_ERROR_INVALID_PARAM;
}

static uint8_t commandService_handleGetCurrent(uint8_t arrayIndex, uint8_t* payload, uint8_t length) {
    // No payload needed for current read
    
    if (arrayIndex >= GET_CURRENT_ARRAY_SIZE) {
        return CMD_ERROR_INVALID_PARAM;
    }
    
    if (getCurrentFunctions[arrayIndex] != NULL) {
        float current = getCurrentFunctions[arrayIndex]();
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