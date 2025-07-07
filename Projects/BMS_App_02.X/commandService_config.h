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

// Command definitions for BMS project
#define CMD_SET_DEBUG_LED       0x01
#define CMD_SET_SW_EN           0x02
#define CMD_SET_DCDC_EN         0x03
#define CMD_SET_EV_CHARGER_EN   0x04
#define CMD_SET_PRE_CHARGE_EN   0x05
#define CMD_SET_PWM_CONTACTOR1  0x10
#define CMD_SET_PWM_CONTACTOR2  0x11
#define CMD_GET_HV_BUS_VOLTAGE  0x20
#define CMD_GET_DCDC_CURRENT    0x21
#define CMD_GET_ISOLATION_VOLT  0x22
#define CMD_GET_PILOT_VOLTAGE   0x23

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
    NULL,                       // Index 0 - reserved/unused
    IO_SET_DEBUG_LED_EN,        // Index 1
    IO_SET_SW_EN,               // Index 2  
    IO_SET_DCDC_EN,             // Index 3
    IO_SET_EV_CHARGER_EN,       // Index 4
    IO_SET_PRE_CHARGE_EN,       // Index 5
    // Add more as needed
    NULL
};

// Digital input functions (index corresponds to payload[0] in get digital in commands)
const GetDigitalIn_FPtr getDigitalInFunctions[] = {
    NULL,                       // Index 0 - reserved/unused
    IO_GET_DEBUG_LED_EN,        // Index 1
    IO_GET_SW_EN,               // Index 2
    IO_GET_DCDC_EN,             // Index 3
    IO_GET_EV_CHARGER_EN,       // Index 4
    IO_GET_PRE_CHARGE_EN,       // Index 5
    // Add more as needed
    NULL
};

// PWM output functions (index corresponds to payload[0] in set PWM commands)
const SetPwmOut_FPtr setPwmOutFunctions[] = {
    NULL,                       // Index 0 - reserved/unused
    IO_SET_CONTACTOR_1_PWM,     // Index 1
    IO_SET_CONTACTOR_2_PWM,     // Index 2
    // Add more as needed
    NULL
};

// Analog input functions (not used in BMS, but included for completeness)
const GetAnalogIn_FPtr getAnalogInFunctions[] = {
    NULL
};

// Voltage measurement functions (index corresponds to payload[0] in get voltage commands)
const GetVoltage_FPtr getVoltageFunctions[] = {
    NULL,                           // Index 0 - reserved/unused
    IO_GET_HV_BUS_VOLTAGE,          // Index 1
    IO_GET_ISOLATION_VOLTAGE,       // Index 2
    IO_GET_PILOT_MONITOR_VOLTAGE,   // Index 3
    IO_GET_VBUS_VOLTAGE,            // Index 4
    IO_GET_EV_CHARGER_VOLTAGE,      // Index 5
    IO_GET_DCDC_OUTPUT_VOLTAGE,     // Index 6
    // Add more as needed
    NULL
};

// Current measurement functions (index corresponds to payload[0] in get current commands)
const GetCurrent_FPtr getCurrentFunctions[] = {
    NULL,                           // Index 0 - reserved/unused
    IO_GET_DCDC_CURRENT,            // Index 1
    IO_GET_EV_CHARGER_CURRENT,      // Index 2
    IO_GET_SHUNT_HIGH_CURRENT,      // Index 3
    IO_GET_SHUNT_LOW_CURRENT,       // Index 4
    IO_GET_TRANSDUCER_CURRENT,      // Index 5
    // Add more as needed
    NULL
};

// Command mapping table
const CommandMapEntry_S commandMap[] = {
    // Digital outputs - payload: [ioIndex, state]
    {CMD_SET_DEBUG_LED,     CMD_TYPE_SET_DIGITAL_OUT,   0,  2, "Set Debug LED"},
    {CMD_SET_SW_EN,         CMD_TYPE_SET_DIGITAL_OUT,   0,  2, "Set SW Enable"},
    {CMD_SET_DCDC_EN,       CMD_TYPE_SET_DIGITAL_OUT,   0,  2, "Set DCDC Enable"},
    {CMD_SET_EV_CHARGER_EN, CMD_TYPE_SET_DIGITAL_OUT,   0,  2, "Set EV Charger Enable"},
    {CMD_SET_PRE_CHARGE_EN, CMD_TYPE_SET_DIGITAL_OUT,   0,  2, "Set Pre-charge Enable"},
    
    // PWM outputs - payload: [ioIndex, duty]
    {CMD_SET_PWM_CONTACTOR1, CMD_TYPE_SET_PWM_OUT,      0,  2, "Set Contactor 1 PWM"},
    {CMD_SET_PWM_CONTACTOR2, CMD_TYPE_SET_PWM_OUT,      0,  2, "Set Contactor 2 PWM"},
    
    // Voltage readings - payload: [ioIndex]
    {CMD_GET_HV_BUS_VOLTAGE, CMD_TYPE_GET_VOLTAGE,      0,  1, "Get HV Bus Voltage"},
    {CMD_GET_ISOLATION_VOLT, CMD_TYPE_GET_VOLTAGE,      0,  1, "Get Isolation Voltage"},
    {CMD_GET_PILOT_VOLTAGE,  CMD_TYPE_GET_VOLTAGE,      0,  1, "Get Pilot Voltage"},
    
    // Current readings - payload: [ioIndex]
    {CMD_GET_DCDC_CURRENT,   CMD_TYPE_GET_CURRENT,      0,  1, "Get DCDC Current"}
};

const uint8_t commandMapSize = sizeof(commandMap) / sizeof(CommandMapEntry_S);

#endif /* COMMAND_SERVICE_CONFIG_H */