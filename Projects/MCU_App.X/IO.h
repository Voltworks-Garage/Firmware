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
 * Initializes Module
 */
void IO_Efuse_Init(void);

/**
 * Run function must be called periodically by scheduler. recommend 1-10ms loop
 */
void IO_Efuse_Run_10ms(void);

/**
 * Disables Module even if RUN is called
 */
void IO_Efuse_Halt(void);

/**
 * IO_SET_xxxx will set a digital output to the desired state
 * @param state: HIGH, LOW or TOGGLE
 */
void IO_SET_DEBUG_LED_EN(uint8_t state);
void IO_SET_DEBUG_PIN_EN(uint8_t state);
void IO_SET_BMS_CONTROLLER_EN(uint8_t state);
void IO_SET_J1772_CONTROLLER_EN(uint8_t state);
void IO_SET_MOTOR_CONTROLLER_EN(uint8_t state);
void IO_SET_CHARGE_CONTROLLER_EN(uint8_t state);
void IO_SET_PILOT_EN(uint8_t state);
void IO_SET_BRAKE_LIGHT_EN(uint8_t state);
void IO_SET_TAILLIGHT_EN(uint8_t state);
void IO_SET_HEADLIGHT_HI_EN(uint8_t state);
void IO_SET_HEADLIGHT_LO_EN(uint8_t state);
void IO_SET_CHARGER_CONTACTOR_EN(uint8_t state);
void IO_SET_DCDC_CONTACTOR_EN(uint8_t state);
void IO_SET_BATTERY_CONTACTOR_EN(uint8_t state);
void IO_SET_PRECHARGE_RELAY_EN(uint8_t state);
void IO_SET_HORN_EN(uint8_t state);
void IO_SET_AUX_PORT_EN(uint8_t state);
void IO_SET_TURN_SIGNAL_FR_EN(uint8_t state);
void IO_SET_TURN_SIGNAL_RR_EN(uint8_t state);
void IO_SET_TURN_SIGNAL_FL_EN(uint8_t state);
void IO_SET_TURN_SIGNAL_RL_EN(uint8_t state);
void IO_SET_HEATED_GRIPS_EN(uint8_t state);
void IO_SET_HEATED_SEAT_EN(uint8_t state);
void IO_SET_SW_EN(uint8_t state);
void IO_SET_DIAG_EN(uint8_t state);
void IO_SET_DIAG_SELECT_EN(uint8_t state);
void IO_SET_DCDC_EN(uint8_t state);
void IO_SET_BATT_EN(uint8_t state);
void IO_SET_CAN_SLEEP_EN(uint8_t state);
void IO_SET_IC_CONTROLLER_SLEEP_EN(uint8_t state);
void IO_SET_PUMP_1_EN(uint8_t state);
void IO_SET_FAN_1_EN(uint8_t state);
void IO_SET_KICKSTAND_SWITCH_IN(uint8_t state);

/**
 * IO_GET_xxxx will return the state of a digital input or output
 * @return: HIGH or LOW
 */
uint8_t IO_GET_DEBUG_LED_EN(void);
uint8_t IO_GET_DEBUG_PIN_EN(void);
uint8_t IO_GET_BMS_CONTROLLER_EN(void);
uint8_t IO_GET_J1772_CONTROLLER_EN(void);
uint8_t IO_GET_MOTOR_CONTROLLER_EN(void);
uint8_t IO_GET_CHARGE_CONTROLLER_EN(void);
uint8_t IO_GET_PILOT_EN(void);
uint8_t IO_GET_BRAKE_LIGHT_EN(void);
uint8_t IO_GET_TAILLIGHT_EN(void);
uint8_t IO_GET_HEADLIGHT_HI_EN(void);
uint8_t IO_GET_HEADLIGHT_LO_EN(void);
uint8_t IO_GET_CHARGER_CONTACTOR_EN(void);
uint8_t IO_GET_DCDC_CONTACTOR_EN(void);
uint8_t IO_GET_BATTERY_CONTACTOR_EN(void);
uint8_t IO_GET_PRECHARGE_RELAY_EN(void);
uint8_t IO_GET_HORN_EN(void);
uint8_t IO_GET_AUX_PORT_EN(void);
uint8_t IO_GET_TURN_SIGNAL_FR_EN(void);
uint8_t IO_GET_TURN_SIGNAL_RR_EN(void);
uint8_t IO_GET_TURN_SIGNAL_FL_EN(void);
uint8_t IO_GET_TURN_SIGNAL_RL_EN(void);
uint8_t IO_GET_HEATED_GRIPS_EN(void);
uint8_t IO_GET_HEATED_SEAT_EN(void);
uint8_t IO_GET_SW_EN(void);
uint8_t IO_GET_DIAG_EN(void);
uint8_t IO_GET_DIAG_SELECT_EN(void);
uint8_t IO_GET_DCDC_EN(void);
uint8_t IO_GET_BATT_EN(void);
uint8_t IO_GET_CAN_SLEEP_EN(void);
uint8_t IO_GET_IC_CONTROLLER_SLEEP_EN(void);
uint8_t IO_GET_PUMP_1_EN(void);
uint8_t IO_GET_FAN_1_EN(void);
uint8_t IO_GET_IC_CONTROLLER_FAULT(void);
uint8_t IO_GET_DCDC_FAULT(void);
uint8_t IO_GET_BATT_FAULT(void);
uint8_t IO_GET_TURN_SIGNAL_L_STATUS(void);
uint8_t IO_GET_TURN_SIGNAL_R_STATUS(void);
uint8_t IO_GET_CONTACT_1_2_STATUS(void);
uint8_t IO_GET_CONTACT_3_4_STATUS(void);
uint8_t IO_GET_SPARE_SWITCH_1_IN(void);
uint8_t IO_GET_SPARE_SWITCH_2_IN(void);
uint8_t IO_GET_BRAKE_SWITCH_1_IN(void);
uint8_t IO_GET_BRAKE_SWITCH_2_IN(void);
uint8_t IO_GET_IGNITION_SWITCH_IN(void);
uint8_t IO_GET_KILL_SWITCH_IN(void);
uint8_t IO_GET_TURN_LEFT_SWITCH_IN(void);
uint8_t IO_GET_TURN_RIGHT_SWITCH_IN(void);
uint8_t IO_GET_BRIGHTS_SWITCH_IN(void);
uint8_t IO_GET_HORN_SWITCH_IN(void);
uint8_t IO_GET_KICKSTAND_SWITCH_IN(void);

/**
 * IO_GET_CURRENT_xxx will return the Current in milliamps of the desired Output
 * @return Current in mA (milliamps)
 */
uint16_t IO_GET_CURRENT_FAN(void);
uint16_t IO_GET_CURRENT_PUMP(void);
uint16_t IO_GET_CURRENT_TAILLIGHT(void);
uint16_t IO_GET_CURRENT_BRAKELIGHT(void);
uint16_t IO_GET_CURRENT_LOWBEAM(void);
uint16_t IO_GET_CURRENT_HIGHBEAM(void);
uint16_t IO_GET_CURRENT_HORN(void);
uint16_t IO_GET_CURRENT_AUX_PORT(void);
uint16_t IO_GET_CURRENT_HEATED_GRIPS(void);
uint16_t IO_GET_CURRENT_HEATED_SEAT(void);
uint16_t IO_GET_CURRENT_CHARGE_CONTROLLER(void);
uint16_t IO_GET_CURRENT_MOTOR_CONTROLLER(void);
uint16_t IO_GET_CURRENT_BMS_CONTROLLER(void);
uint16_t IO_GET_CURRENT_J1772_CONTROLLER(void);
float IO_GET_CURRENT_BATT(void);//TODO: Change mA.
float IO_GET_CURRENT_DCDC(void);//TODO: Change mA.
float IO_GET_CURRENT_IC_CONTROLLER(void);//TODO: Change mA.

/**
 * IO_GET_VOLTAGE_xxx will return the converted voltage (including divider) in Volts
 * @return Voltage in Volts
 */
//TODO: Change everything to mV.
float IO_GET_VOLTAGE_PILOT(void);
float IO_GET_VOLTAGE_PROXIMITY(void);
float IO_GET_VOLTAGE_VBAT(void);
float IO_GET_VOLTAGE_VBAT_SW(void);
uint16_t IO_GET_VOLTAGE_THROTTLE_mV(void); //This one is in millivolts already


/**
 * IO_GET_xxx_FAULT returns the Fault Status of a given output. If the fault
 * bit is set, the output has been automatically turned off, and will not reset 
 * until the unit is power cycled or reset.
 * @return HIGH = Faulted, Low = Not Faulted
 */
uint8_t IO_GET_FAN_FAULT(void);
uint8_t IO_GET_PUMP_FAULT(void);
uint8_t IO_GET_TAILLIGHT_FAULT(void);
uint8_t IO_GET_BRAKELIGHT_FAULT(void);
uint8_t IO_GET_LOWBEAM_FAULT(void);
uint8_t IO_GET_HIGHBEAM_FAULT(void);
uint8_t IO_GET_HORN_FAULT(void);
uint8_t IO_GET_AUX_PORT_FAULT(void);
uint8_t IO_GET_HEATED_GRIPS_FAULT(void);
uint8_t IO_GET_HEATED_SEAT_FAULT(void);
uint8_t IO_GET_CHARGE_CONTROLLER_FAULT(void);
uint8_t IO_GET_MOTOR_CONTROLLER_FAULT(void);
uint8_t IO_GET_BMS_CONTROLLER_FAULT(void);
uint8_t IO_GET_J1772_CONTROLLER_FAULT(void);


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

// Digital output functions (index corresponds to payload[1] in set digital out commands)
static const SetDigitalOut_FPtr setDigitalOutFunctions[] = {
    NULL,                           // Index 0 - reserved/unused
    IO_SET_DEBUG_LED_EN,            // Index 1
    IO_SET_DEBUG_PIN_EN,            // Index 2
    IO_SET_BMS_CONTROLLER_EN,       // Index 3
    IO_SET_J1772_CONTROLLER_EN,     // Index 4
    IO_SET_MOTOR_CONTROLLER_EN,     // Index 5
    IO_SET_CHARGE_CONTROLLER_EN,    // Index 6
    IO_SET_PILOT_EN,                // Index 7
    IO_SET_BRAKE_LIGHT_EN,          // Index 8
    IO_SET_TAILLIGHT_EN,            // Index 9
    IO_SET_HEADLIGHT_HI_EN,         // Index 10
    IO_SET_HEADLIGHT_LO_EN,         // Index 11
    IO_SET_CHARGER_CONTACTOR_EN,    // Index 12
    IO_SET_DCDC_CONTACTOR_EN,       // Index 13
    IO_SET_BATTERY_CONTACTOR_EN,    // Index 14
    IO_SET_PRECHARGE_RELAY_EN,      // Index 15
    IO_SET_HORN_EN,                 // Index 16
    IO_SET_AUX_PORT_EN,             // Index 17
    IO_SET_TURN_SIGNAL_FR_EN,       // Index 18
    IO_SET_TURN_SIGNAL_RR_EN,       // Index 19
    IO_SET_TURN_SIGNAL_FL_EN,       // Index 20
    IO_SET_TURN_SIGNAL_RL_EN,       // Index 21
    IO_SET_HEATED_GRIPS_EN,         // Index 22
    IO_SET_HEATED_SEAT_EN,          // Index 23
    IO_SET_SW_EN,                   // Index 24
    IO_SET_DIAG_EN,                 // Index 25
    IO_SET_DIAG_SELECT_EN,          // Index 26
    IO_SET_DCDC_EN,                 // Index 27
    IO_SET_BATT_EN,                 // Index 28
    IO_SET_CAN_SLEEP_EN,            // Index 29
    IO_SET_IC_CONTROLLER_SLEEP_EN,  // Index 30
    IO_SET_PUMP_1_EN,               // Index 31
    IO_SET_FAN_1_EN,                // Index 32
    NULL
};

// Digital input functions (index corresponds to payload[1] in get digital in commands)
static const GetDigitalIn_FPtr getDigitalInFunctions[] = {
    NULL,                               // Index 0 - reserved/unused
    IO_GET_DEBUG_LED_EN,                // Index 1
    IO_GET_DEBUG_PIN_EN,                // Index 2
    IO_GET_BMS_CONTROLLER_EN,           // Index 3
    IO_GET_J1772_CONTROLLER_EN,         // Index 4
    IO_GET_MOTOR_CONTROLLER_EN,         // Index 5
    IO_GET_CHARGE_CONTROLLER_EN,        // Index 6
    IO_GET_PILOT_EN,                    // Index 7
    IO_GET_BRAKE_LIGHT_EN,              // Index 8
    IO_GET_TAILLIGHT_EN,                // Index 9
    IO_GET_HEADLIGHT_HI_EN,             // Index 10
    IO_GET_HEADLIGHT_LO_EN,             // Index 11
    IO_GET_CHARGER_CONTACTOR_EN,        // Index 12
    IO_GET_DCDC_CONTACTOR_EN,           // Index 13
    IO_GET_BATTERY_CONTACTOR_EN,        // Index 14
    IO_GET_PRECHARGE_RELAY_EN,          // Index 15
    IO_GET_HORN_EN,                     // Index 16
    IO_GET_AUX_PORT_EN,                 // Index 17
    IO_GET_TURN_SIGNAL_FR_EN,           // Index 18
    IO_GET_TURN_SIGNAL_RR_EN,           // Index 19
    IO_GET_TURN_SIGNAL_FL_EN,           // Index 20
    IO_GET_TURN_SIGNAL_RL_EN,           // Index 21
    IO_GET_HEATED_GRIPS_EN,             // Index 22
    IO_GET_HEATED_SEAT_EN,              // Index 23
    IO_GET_SW_EN,                       // Index 24
    IO_GET_DIAG_EN,                     // Index 25
    IO_GET_DIAG_SELECT_EN,              // Index 26
    IO_GET_DCDC_EN,                     // Index 27
    IO_GET_BATT_EN,                     // Index 28
    IO_GET_CAN_SLEEP_EN,                // Index 29
    IO_GET_IC_CONTROLLER_SLEEP_EN,      // Index 30
    IO_GET_PUMP_1_EN,                   // Index 31
    IO_GET_FAN_1_EN,                    // Index 32
    IO_GET_IC_CONTROLLER_FAULT,         // Index 33
    IO_GET_DCDC_FAULT,                  // Index 34
    IO_GET_BATT_FAULT,                  // Index 35
    IO_GET_TURN_SIGNAL_L_STATUS,        // Index 36
    IO_GET_TURN_SIGNAL_R_STATUS,        // Index 37
    IO_GET_CONTACT_1_2_STATUS,          // Index 38
    IO_GET_CONTACT_3_4_STATUS,          // Index 39
    IO_GET_SPARE_SWITCH_1_IN,           // Index 40
    IO_GET_SPARE_SWITCH_2_IN,           // Index 41
    IO_GET_BRAKE_SWITCH_1_IN,           // Index 42
    IO_GET_BRAKE_SWITCH_2_IN,           // Index 43
    IO_GET_IGNITION_SWITCH_IN,          // Index 44
    IO_GET_KILL_SWITCH_IN,              // Index 45
    IO_GET_TURN_LEFT_SWITCH_IN,         // Index 46
    IO_GET_TURN_RIGHT_SWITCH_IN,        // Index 47
    IO_GET_BRIGHTS_SWITCH_IN,           // Index 48
    IO_GET_HORN_SWITCH_IN,              // Index 49
    IO_GET_KICKSTAND_SWITCH_IN,         // Index 50
    NULL
};

// PWM output functions (index corresponds to payload[1] in set PWM commands)
static const SetPwmOut_FPtr setPwmOutFunctions[] = {
    NULL                                // Index 0 - reserved/unused - No PWM functions in MCU_App
};

// Analog input functions (index corresponds to payload[1] in get analog commands)
static const GetAnalogIn_FPtr getAnalogInFunctions[] = {
    NULL,                               // Index 0 - reserved/unused
    IO_GET_CURRENT_FAN,                 // Index 1
    IO_GET_CURRENT_PUMP,                // Index 2
    IO_GET_CURRENT_TAILLIGHT,           // Index 3
    IO_GET_CURRENT_BRAKELIGHT,          // Index 4
    IO_GET_CURRENT_LOWBEAM,             // Index 5
    IO_GET_CURRENT_HIGHBEAM,            // Index 6
    IO_GET_CURRENT_HORN,                // Index 7
    IO_GET_CURRENT_AUX_PORT,            // Index 8
    IO_GET_CURRENT_HEATED_GRIPS,        // Index 9
    IO_GET_CURRENT_HEATED_SEAT,         // Index 10
    IO_GET_CURRENT_CHARGE_CONTROLLER,   // Index 11
    IO_GET_CURRENT_MOTOR_CONTROLLER,    // Index 12
    IO_GET_CURRENT_BMS_CONTROLLER,      // Index 13
    IO_GET_CURRENT_J1772_CONTROLLER,  // Index 14
    NULL
};

// Voltage measurement functions (index corresponds to payload[1] in get voltage commands)
static const GetVoltage_FPtr getVoltageFunctions[] = {
    NULL,                               // Index 0 - reserved/unused
    IO_GET_VOLTAGE_PILOT,               // Index 1
    IO_GET_VOLTAGE_PROXIMITY,           // Index 2
    IO_GET_VOLTAGE_VBAT,                // Index 3
    IO_GET_VOLTAGE_VBAT_SW,             // Index 4
    NULL
};

// Current measurement functions (index corresponds to payload[1] in get current commands)
static const GetCurrent_FPtr getCurrentFunctions[] = {
    NULL,                               // Index 0 - reserved/unused
    IO_GET_CURRENT_BATT,                // Index 1
    IO_GET_CURRENT_DCDC,                // Index 2
    IO_GET_CURRENT_IC_CONTROLLER,       // Index 3
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

