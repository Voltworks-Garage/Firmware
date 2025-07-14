/* 
 * File:   pinSetup.h
 * Author: kid group
 *
 * Created on March 1, 2018, 8:04 AM
 */

#ifndef PINSETUP_H
#define	PINSETUP_H

#include <stdint.h>
#include "pins.h"
#include "ADC.h"
#include "OC.h"
#include "pps.h"

/*FUNCTIONAL PIN ASSIGNMENTS*/

// Digital pin assignments (using gpio_pin_t from pins.h)
typedef enum {
    DEBUG_LED_EN = PA0,
    DEBUG_PIN_EN = PA1,
    BMS_CONTROLLER_EN = PA2,
    J1772_CONTROLLER_EN = PA3,
    MOTOR_CONTROLLER_EN = PA4,
    CHARGE_CONTROLLER_EN = PA5,
    PILOT_EN = PA6,
    TURN_SIGNAL_L_STATUS = PA9,
    TURN_SIGNAL_R_STATUS = PA10,
    CONTACT_1_2_STATUS = PA14,
    CONTACT_3_4_STATUS = PA15,
    SPARE_SWITCH_1_IN = PC2,
    SPARE_SWITCH_2_IN = PC3,
    BRAKE_LIGHT_EN = PD0,
    TAILLIGHT_EN = PD1,
    HEADLIGHT_HI_EN = PD2,
    HEADLIGHT_LO_EN = PD3,
    CHARGER_CONTACTOR_EN = PD4,
    DCDC_CONTACTOR_EN = PD5,
    BATTERY_CONTACTOR_EN = PD6,
    PRECHARGE_RELAY_EN = PD7,
    HORN_EN = PD8,
    AUX_PORT_EN = PD9,
    TURN_SIGNAL_FR_EN = PD10,
    TURN_SIGNAL_RR_EN = PD11,
    TURN_SIGNAL_FL_EN = PD12,
    TURN_SIGNAL_RL_EN = PD13,
    HEATED_GRIPS_EN = PD14,
    HEATED_SEAT_EN = PD15,
    SW_EN = PE0,
    DIAG_EN = PE1,
    DIAG_SELECT_EN = PE2,
    DCDC_EN = PE3,
    BATT_EN = PE4,
    CAN_SLEEP_EN = PE5,
    IC_CONTROLLER_SLEEP_EN = PE6,
    IC_CONTROLLER_nFAULT = PE7,
    DCDC_nFAULT = PE8,
    BATT_nFAULT = PE9,
    PUMP_1_EN = PF2,
    FAN_1_EN = PF3,
    BRAKE_SWITCH_1_IN = PF13,
    BRAKE_SWITCH_2_IN = PF12,
    IGNITION_SWITCH_IN = PG1,
    KILL_SWITCH_IN = PG0,
    TURN_LEFT_SWITCH_IN = PG2,
    TURN_RIGHT_SWITCH_IN = PG3,
    BRIGHTS_SWITCH_IN = PG12,
    HORN_SWITCH_IN = PG13,
    KICKSTAND_SWITCH_IN = PG14
} pin_assignments_t;

/*ANALOG INPUT DEFINITIONS*/

// Functional analog assignments
typedef enum {
    FAN_ISENSE_AI = AN0,
    THROTTLE_SIGNAL_MONITOR_AI = AN1,
    TAILLIGHT_ISENSE_AI = AN2,
    HEADLIGHT_ISENSE_AI = AN3,
    HORN_ISENSE_AI = AN4,
    AUX_PORT_ISENSE_AI = AN5,
    LOCK_ISENSE_AI = AN6,
    HEATER_ISENSE_AI = AN7,
    ECU_2_ISENSE_AI = AN8,
    ECU_1_ISENSE_AI = AN9,
    V12_MONITOR_AI = AN10,
    BATT_ISENSE_AI = AN11,
    DCDC_ISENSE_AI = AN12,
    IC_CONTROLLER_ISENSE_AI = AN13,
    RADIATOR_INPUT_TEMP_AI = AN14,
    RADIATOR_OUTPUT_TEMP_AI = AN15,
    P12_MONITOR_AI = AN16,
    PILOT_MONITOR_AI = AN19,    // R177 is wrong, should be 560k, not 10k
    PROXIMITY_MONITOR_AI = AN23
} analog_assignments_t;

/*PWM DEFINITIONS*/

// Functional PWM assignments
typedef enum {
    PWM_1_OUT = PWM_PIN_RP100,
    PWM_2_OUT = PWM_PIN_RP101
} pwm_assignments_t;

/*COMMUNICATION DEFINITIONS*/

// Communication pin assignments
    // UART
    #define UART_TX _RP120R
    #define UART_RX RPI121_IN
    
    // CAN
    #define CAN_TX _RP118R
    #define CAN_RX RPI119_IN

/**
 * @PinSetup_Init will initialize all pins for their intended usage as defined above
 */
void PinSetup_Init(void);


#endif	/* PINSETUP_H */

