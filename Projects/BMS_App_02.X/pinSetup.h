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
    // Outputs
    SW_EN = PB4,
    DCDC_EN = PB7,
    EV_CHARGER_EN = PB8,
    PRE_CHARGE_EN = PB12,
    DEBUG_PIN = PB14,
    DEBUG_LED_EN = PC5,
    PILOT_EN = PC6,
    MUX_A = PE15,
    MUX_B = PC10,
    MUX_C = PC13,
    CAN_TX_PIN = PG6,
    SPI_CS = PC4,
    
    // Inputs
    V5_SW_nFAULT = PA8,
    V12_POWER_STATUS = PD8,
    DCDC_nFAULT = PD6,
    EV_CHARGER_nFAULT = PD5,
    SPI_SDI = PA9,
    PILOT_MONITOR_PWM_IN = PC7
} pin_assignments_t;

/*ANALOG INPUT DEFINITIONS*/



// Functional analog assignments
typedef enum {
    ISOLATION_VOLTAGE_AI = AN0,
    HV_BUS_VOLTAGE_AI = AN1,
    EV_CHARGER_CURRENT_AI = AN2,
    DCDC_OUTPUT_CURRENT_AI = AN3,
    EV_CHARGER_VOLTAGE_AI = AN4,
    DCDC_OUTPUT_VOLTAGE_AI = AN5,
    HIGH_CURRENT_SHUNT_AI = AN6,
    PROMIXITY_MONINOTR_AI = AN7,
    MUX_1_AI = AN8,
    TRANSDUCER_INPUT_AI = AN9,
    LOW_CURRENT_SHUNT_AI = AN10,
    MUX_2_AI = AN11,
    MUX_3_AI = AN12,
    PILOT_MONITOR_AI = AN13,
    VBUS_VOLTAGE_AI = AN14
} analog_assignments_t;


/*PWM DEFINITIONS*/

#define PILOT_PWM_IN RP55_IN

// Functional PWM assignments
typedef enum {
    CONTACTOR_1_PWM = PWM_PIN_RP57,
    CONTACTOR_2_PWM = PWM_PIN_RP56
} pwm_assignments_t;

/*COMMUNICATION DEFINITIONS*/

// Communication pin assignments
//typedef enum {
    // UART
    #define UART_TX _RP97R
    #define UART_RX RPI96_IN
    
    // CAN
    #define CAN_TX _RP118R
    #define CAN_RX RPI119_IN
    
\
//} comm_assignments_t;


/**
 * @PinSetup_Init will initialize all pins for their intended usage as defined above
 */
void PinSetup_Init(void);


#endif	/* PINSETUP_H */

