/* 
 * File:   commandService_config.h
 * Author: Claude/Voltworks
 * 
 * Command Service Configuration for MCU Project
 * 
 * This file defines the command mappings and handlers specific
 * to the MCU application, demonstrating how the same core
 * library can be used across different projects.
 *
 * Created: 2025-07-06
 */

#ifndef COMMAND_SERVICE_CONFIG_H
#define COMMAND_SERVICE_CONFIG_H

#include <stdint.h>
#include "IO.h"
#include <stddef.h>

// Command definitions for MCU project (different from BMS)
#define CMD_SET_HEADLIGHT_HI        0x01
#define CMD_SET_HEADLIGHT_LO        0x02
#define CMD_SET_BRAKE_LIGHT         0x03
#define CMD_SET_TURN_SIGNAL_FR      0x04
#define CMD_SET_TURN_SIGNAL_RR      0x05
#define CMD_SET_HORN                0x06
#define CMD_SET_HEATED_GRIPS        0x07
#define CMD_SET_HEATED_SEAT         0x08
#define CMD_SET_MOTOR_CONTROLLER    0x10
#define CMD_SET_CHARGE_CONTROLLER   0x11
#define CMD_SET_BATTERY_CONTACTOR   0x12
#define CMD_SET_PRECHARGE_RELAY     0x13
#define CMD_GET_MCU_STATUS          0x20
#define CMD_GET_LIGHT_STATUS        0x21

// Response codes - duplicated here to avoid circular include
#define CMD_SUCCESS                    0x00
#define CMD_ERROR_UNKNOWN_COMMAND      0x01
#define CMD_ERROR_INVALID_LENGTH       0x02
#define CMD_ERROR_INVALID_PARAM        0x03
#define CMD_ERROR_PERMISSION_DENIED    0x04
#define CMD_ERROR_SYSTEM_BUSY          0x05

// Generic command types - duplicated here to avoid circular include
#define CMD_TYPE_SET_DIGITAL_OUT    0x01
#define CMD_TYPE_GET_DIGITAL_IN     0x02
#define CMD_TYPE_SET_PWM_OUT        0x03
#define CMD_TYPE_GET_ANALOG_IN      0x04
#define CMD_TYPE_GET_VOLTAGE        0x05
#define CMD_TYPE_GET_CURRENT        0x06
#define CMD_TYPE_CUSTOM             0xFF

// Function pointer typedefs - duplicated here to avoid circular include
typedef void (*SetDigitalOut_FPtr)(uint8_t state);
typedef uint8_t (*GetDigitalIn_FPtr)(void);
typedef void (*SetPwmOut_FPtr)(uint8_t duty);
typedef uint16_t (*GetAnalogIn_FPtr)(void);
typedef float (*GetVoltage_FPtr)(void);
typedef float (*GetCurrent_FPtr)(void);

// Command mapping structure - defined here so config doesn't need to include core
typedef struct CommandMapEntry_S {
    uint8_t commandId;
    uint8_t commandType;
    uint8_t ioIndex;        // Index into the appropriate function pointer array
    uint8_t minPayloadLength;
    const char* description;
} CommandMapEntry_S;

// Function pointer arrays - these map command indexes to actual IO functions

// Digital output functions (index corresponds to payload[0] in set digital out commands)
const SetDigitalOut_FPtr setDigitalOutFunctions[] = {
    NULL,                           // Index 0 - reserved/unused
    IO_SET_HEADLIGHT_HI_EN,         // Index 1
    IO_SET_HEADLIGHT_LO_EN,         // Index 2
    IO_SET_BRAKE_LIGHT_EN,          // Index 3
    IO_SET_TURN_SIGNAL_FR_EN,       // Index 4
    IO_SET_TURN_SIGNAL_RR_EN,       // Index 5
    IO_SET_HORN_EN,                 // Index 6
    IO_SET_HEATED_GRIPS_EN,         // Index 7
    IO_SET_HEATED_SEAT_EN,          // Index 8
    IO_SET_MOTOR_CONTROLLER_EN,     // Index 9
    IO_SET_CHARGE_CONTROLLER_EN,    // Index 10
    IO_SET_BATTERY_CONTACTOR_EN,    // Index 11
    IO_SET_PRECHARGE_RELAY_EN,      // Index 12
    NULL
};

// Digital input functions (index corresponds to payload[0] in get digital in commands)
const GetDigitalIn_FPtr getDigitalInFunctions[] = {
    NULL,                           // Index 0 - reserved/unused
    IO_GET_HEADLIGHT_HI_EN,         // Index 1
    IO_GET_HEADLIGHT_LO_EN,         // Index 2
    IO_GET_BRAKE_LIGHT_EN,          // Index 3
    IO_GET_TURN_SIGNAL_FR_EN,       // Index 4
    IO_GET_TURN_SIGNAL_RR_EN,       // Index 5
    IO_GET_HORN_EN,                 // Index 6
    IO_GET_HEATED_GRIPS_EN,         // Index 7
    IO_GET_HEATED_SEAT_EN,          // Index 8
    IO_GET_MOTOR_CONTROLLER_EN,     // Index 9
    IO_GET_CHARGE_CONTROLLER_EN,    // Index 10
    IO_GET_BATTERY_CONTACTOR_EN,    // Index 11
    IO_GET_PRECHARGE_RELAY_EN,      // Index 12
    NULL
};

// PWM output functions (not used in MCU, but included for completeness)
const SetPwmOut_FPtr setPwmOutFunctions[] = {
    NULL
};

// Analog input functions (not used in MCU, but included for completeness)
const GetAnalogIn_FPtr getAnalogInFunctions[] = {
    NULL
};

// Voltage measurement functions (not used in MCU, but included for completeness)
const GetVoltage_FPtr getVoltageFunctions[] = {
    NULL
};

// Current measurement functions (not used in MCU, but included for completeness)
const GetCurrent_FPtr getCurrentFunctions[] = {
    NULL
};

// Command mapping table
const CommandMapEntry_S commandMap[] = {
    // Digital outputs - payload: [ioIndex, state]
    {CMD_SET_HEADLIGHT_HI,      CMD_TYPE_SET_DIGITAL_OUT,   0,  2, "Set Headlight High"},
    {CMD_SET_HEADLIGHT_LO,      CMD_TYPE_SET_DIGITAL_OUT,   0,  2, "Set Headlight Low"},
    {CMD_SET_BRAKE_LIGHT,       CMD_TYPE_SET_DIGITAL_OUT,   0,  2, "Set Brake Light"},
    {CMD_SET_TURN_SIGNAL_FR,    CMD_TYPE_SET_DIGITAL_OUT,   0,  2, "Set Turn Signal FR"},
    {CMD_SET_TURN_SIGNAL_RR,    CMD_TYPE_SET_DIGITAL_OUT,   0,  2, "Set Turn Signal RR"},
    {CMD_SET_HORN,              CMD_TYPE_SET_DIGITAL_OUT,   0,  2, "Set Horn"},
    {CMD_SET_HEATED_GRIPS,      CMD_TYPE_SET_DIGITAL_OUT,   0,  2, "Set Heated Grips"},
    {CMD_SET_HEATED_SEAT,       CMD_TYPE_SET_DIGITAL_OUT,   0,  2, "Set Heated Seat"},
    {CMD_SET_MOTOR_CONTROLLER,  CMD_TYPE_SET_DIGITAL_OUT,   0,  2, "Set Motor Controller"},
    {CMD_SET_CHARGE_CONTROLLER, CMD_TYPE_SET_DIGITAL_OUT,   0,  2, "Set Charge Controller"},
    {CMD_SET_BATTERY_CONTACTOR, CMD_TYPE_SET_DIGITAL_OUT,   0,  2, "Set Battery Contactor"},
    {CMD_SET_PRECHARGE_RELAY,   CMD_TYPE_SET_DIGITAL_OUT,   0,  2, "Set Precharge Relay"}
};

const uint8_t commandMapSize = sizeof(commandMap) / sizeof(CommandMapEntry_S);

#endif /* COMMAND_SERVICE_CONFIG_H */