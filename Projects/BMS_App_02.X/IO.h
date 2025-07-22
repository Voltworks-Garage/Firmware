/* 
 * File:   IO.h
 * Author: kid group
 *
 * Created on March 10, 2018, 10:04 PM
 */

#ifndef IO_H
#define	IO_H

#include "stdint.h"
#include "stddef.h"  // For NULL
#include "pins.h"


/**
 * IO_SET_xxxx will set a digital output to the desired state
 * @param state: HIGH, LOW or TOGGLE (or duty cycle from 0-100)
 */
void IO_SET_DEBUG_LED_EN(uint8_t state);
void IO_SET_SW_EN(uint8_t state);
void IO_SET_DCDC_EN(uint8_t state);
void IO_SET_EV_CHARGER_EN(uint8_t state);
void IO_SET_DISCHARGE_EN(uint8_t state);
void IO_SET_PRE_CHARGE_EN(uint8_t state);
void IO_SET_MUX_A(uint8_t state);
void IO_SET_MUX_B(uint8_t state);
void IO_SET_MUX_C(uint8_t state);
void IO_SET_SPI_CS(uint8_t state);
void IO_SET_PILOT_EN(uint8_t state);

void IO_SET_CHARGEPUMP_PWM(uint8_t duty);
void IO_SET_CONTACTOR_1_PWM(uint8_t duty);
void IO_SET_CONTACTOR_2_PWM(uint8_t duty);


/**
 * IO_GET_xxxx will return the state of a digital input or output
 * @return: HIGH or LOW
 */
uint8_t IO_GET_DEBUG_LED_EN(void);
uint8_t IO_GET_SW_EN(void);
uint8_t IO_GET_DCDC_EN(void);
uint8_t IO_GET_EV_CHARGER_EN(void);
uint8_t IO_GET_DISCHARGE_EN(void);
uint8_t IO_GET_PRE_CHARGE_EN(void);
uint8_t IO_GET_MUX_A(void);
uint8_t IO_GET_MUX_B(void);
uint8_t IO_GET_MUX_C(void);
uint8_t IO_GET_V12_POWER_STATUS(void);
uint8_t IO_GET_SPI_SDI(void);
uint8_t IO_GET_PILOT_EN(void);

/**
 * IO_IO_GET_xxx_FAULT returns the Fault Status of a given output. If the fault
 * bit is set, the output has been automatically turned off, and will not reset 
 * until the unit is power cycled or reset.
 * @return HIGH = Faulted, Low = Not Faulted
 */

uint8_t IO_GET_V5_SW_FAULT(void);
uint8_t IO_GET_DCDC_FAULT(void);
uint8_t IO_GET_EV_CHARGER_FAULT(void);

/**
 * IO_GET_xxx_VOLTAGE will return the converted voltage (including divider) in Volts
 * @return Voltage in Volts
 */
float IO_GET_ISOLATION_VOLTAGE(void);
float IO_GET_HV_BUS_VOLTAGE(void);
float IO_GET_VBUS_VOLTAGE(void);
float IO_GET_EV_CHARGER_VOLTAGE(void);
float IO_GET_DCDC_OUTPUT_VOLTAGE(void);
float IO_GET_MUX_1_VOLTAGE(void);
float IO_GET_MUX_2_VOLTAGE(void);
float IO_GET_MUX_3_VOLTAGE(void);
float IO_GET_PILOT_MONITOR_VOLTAGE(void);
float IO_GET_PROXIMITY_VOLTAGE(void);

/**
 * IO_GET_xxx_CURRENT will return the converted current (including divider) in Amps
 * @return Current in Amps
 */
float IO_GET_DCDC_CURRENT(void);
float IO_GET_EV_CHARGER_CURRENT(void);
float IO_GET_SHUNT_HIGH_CURRENT(void);
float IO_GET_SHUNT_LOW_CURRENT(void);
float IO_GET_TRANSDUCER_CURRENT(void);





/******************************************************************************
 * CommandService Integration - Function Pointer Arrays
 * 
 * These arrays provide a bridge between ISO-TP commands and IO functions.
 * Adding a new IO function requires updating the appropriate array below.
 *******************************************************************************/

// Function pointer typedefs for CommandService
typedef void (*SetDigitalOut_FPtr)(uint8_t state);
typedef uint8_t (*GetDigitalIn_FPtr)(void);  
typedef void (*SetPwmOut_FPtr)(uint8_t duty);
typedef uint16_t (*GetAnalogIn_FPtr)(void);
typedef float (*GetVoltage_FPtr)(void);
typedef float (*GetCurrent_FPtr)(void);

// Digital output functions (index corresponds to payload[0] in set digital out commands)
static const SetDigitalOut_FPtr setDigitalOutFunctions[] = {
    NULL,                       // Index 0 - reserved/unused
    IO_SET_DEBUG_LED_EN,        // Index 1
    IO_SET_SW_EN,               // Index 2  
    IO_SET_DCDC_EN,             // Index 3
    IO_SET_EV_CHARGER_EN,       // Index 4
    IO_SET_PRE_CHARGE_EN,       // Index 5
    IO_SET_MUX_A,               // Index 6
    IO_SET_MUX_B,               // Index 7
    IO_SET_MUX_C,               // Index 8
    IO_SET_SPI_CS,              // Index 9
    IO_SET_PILOT_EN,            // Index 10
    NULL
};

// Digital input functions (index corresponds to payload[0] in get digital in commands)
static const GetDigitalIn_FPtr getDigitalInFunctions[] = {
    NULL,                       // Index 0 - reserved/unused
    IO_GET_DEBUG_LED_EN,        // Index 1
    IO_GET_SW_EN,               // Index 2
    IO_GET_DCDC_EN,             // Index 3
    IO_GET_EV_CHARGER_EN,       // Index 4
    IO_GET_PRE_CHARGE_EN,       // Index 5
    IO_GET_MUX_A,               // Index 6
    IO_GET_MUX_B,               // Index 7
    IO_GET_MUX_C,               // Index 8
    IO_GET_V12_POWER_STATUS,    // Index 9
    NULL
};

// PWM output functions (index corresponds to payload[0] in set PWM commands)
static const SetPwmOut_FPtr setPwmOutFunctions[] = {
    NULL,                       // Index 0 - reserved/unused
    IO_SET_CONTACTOR_1_PWM,     // Index 1
    IO_SET_CONTACTOR_2_PWM,     // Index 2
    NULL
};

// Analog input functions (not used in BMS, but included for completeness)
static const GetAnalogIn_FPtr getAnalogInFunctions[] = {
    NULL
};

// Voltage measurement functions (index corresponds to payload[0] in get voltage commands)
static const GetVoltage_FPtr getVoltageFunctions[] = {
    NULL,                           // Index 0 - reserved/unused
    IO_GET_HV_BUS_VOLTAGE,          // Index 1
    IO_GET_ISOLATION_VOLTAGE,       // Index 2
    IO_GET_PILOT_MONITOR_VOLTAGE,   // Index 3
    IO_GET_VBUS_VOLTAGE,            // Index 4
    IO_GET_EV_CHARGER_VOLTAGE,      // Index 5
    IO_GET_DCDC_OUTPUT_VOLTAGE,     // Index 6
    IO_GET_MUX_1_VOLTAGE,           // Index 7
    IO_GET_MUX_2_VOLTAGE,           // Index 8
    IO_GET_MUX_3_VOLTAGE,           // Index 9
    IO_GET_PROXIMITY_VOLTAGE,       // Index 10
    NULL
};

// Current measurement functions (index corresponds to payload[0] in get current commands)
static const GetCurrent_FPtr getCurrentFunctions[] = {
    NULL,                           // Index 0 - reserved/unused
    IO_GET_DCDC_CURRENT,            // Index 1
    IO_GET_EV_CHARGER_CURRENT,      // Index 2
    IO_GET_SHUNT_HIGH_CURRENT,      // Index 3
    IO_GET_SHUNT_LOW_CURRENT,       // Index 4
    IO_GET_TRANSDUCER_CURRENT,      // Index 5
    NULL
};

// Array sizes
#define SET_DIGITAL_OUT_FUNCTIONS_SIZE (sizeof(setDigitalOutFunctions)/sizeof(SetDigitalOut_FPtr))
#define GET_DIGITAL_IN_FUNCTIONS_SIZE (sizeof(getDigitalInFunctions)/sizeof(GetDigitalIn_FPtr))
#define SET_PWM_OUT_FUNCTIONS_SIZE (sizeof(setPwmOutFunctions)/sizeof(SetPwmOut_FPtr))
#define GET_ANALOG_IN_FUNCTIONS_SIZE (sizeof(getAnalogInFunctions)/sizeof(GetAnalogIn_FPtr))
#define GET_VOLTAGE_FUNCTIONS_SIZE (sizeof(getVoltageFunctions)/sizeof(GetVoltage_FPtr))
#define GET_CURRENT_FUNCTIONS_SIZE (sizeof(getCurrentFunctions)/sizeof(GetCurrent_FPtr))

#endif	/* IO_H */

