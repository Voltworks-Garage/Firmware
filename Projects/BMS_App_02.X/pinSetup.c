/* 
 * File:   pinSetup.c
 * Author: Zach Levenberg
 * Comments: Pin setup for projects
 * Revision history: 3/1/18 initial build
 */

// *****************************************************************************
// *****************************************************************************
// Section: Included Files 
// *****************************************************************************
// *****************************************************************************
#include "pinSetup.h"
#include "ADC.h"
//#include "uart.h"
#include "CAN.h"
#include "pins.h"
#include "OC.h"
#include "pps.h"
#include "sleep.h"
#include <xc.h>
#include "mcc_generated_files/clock.h"
#include "ic.h"

// *****************************************************************************
// *****************************************************************************
// Section: Module Defines and variables
// *****************************************************************************
// *****************************************************************************


// *****************************************************************************
// *****************************************************************************
// Section: Function Declarations
// *****************************************************************************
// *****************************************************************************

/**
 * 
 */
void PinSetup_Init(void) {
    /* Configure all AD pins as digital */
#ifdef ANSELA
    ANSELA = 0x0000;
#endif
#ifdef ANSELB
    ANSELB = 0x0000;
#endif
#ifdef ANSELC
    ANSELC = 0x0000;
#endif
#ifdef ANSELD
    ANSELD = 0x0000;
#endif
#ifdef ANSELE
    ANSELE = 0x0000;
#endif
#ifdef ANSELF
    ANSELF = 0x0000;
#endif
#ifdef ANSELG
    ANSELG = 0x0000;
#endif


    /* Set the PWM's off */
#ifdef IOCON1
    IOCON1bits.PENH = 0;
    IOCON1bits.PENL = 0;
#endif
#ifdef IOCON2
    IOCON2bits.PENH = 0;
    IOCON2bits.PENL = 0;
#endif
#ifdef IOCON3
    IOCON3bits.PENH = 0;
    IOCON3bits.PENL = 0;
#endif

    /*Set all digital IO*/
    PINS_write(DEBUG_LED_EN, LOW);
    //PINS_write(SW_EN, LOW); //don't change the state of SW_EN after bootloader.
    PINS_write(DCDC_EN, LOW);
    PINS_write(EV_CHARGER_EN, LOW);
    PINS_write(PRE_CHARGE_EN, LOW);
    PINS_write(MUX_A, LOW);
    PINS_write(MUX_B, LOW);
    PINS_write(MUX_C, LOW);
    
    PINS_direction(DEBUG_LED_EN, OUTPUT);
    PINS_direction(SW_EN, OUTPUT);
    PINS_direction(DEBUG_PIN, OUTPUT);
    PINS_direction(DCDC_EN, OUTPUT);
    PINS_direction(EV_CHARGER_EN, OUTPUT);
    PINS_direction(PRE_CHARGE_EN, OUTPUT);
    PINS_direction(MUX_A, OUTPUT);
    PINS_direction(MUX_B, OUTPUT);
    PINS_direction(MUX_C, OUTPUT);
    PINS_direction(SPI_CS, OUTPUT);
    PINS_direction(SPI_SDI, INPUT); // SPI SDI RX
    PINS_direction(PILOT_PWM_IN, INPUT); // PILOT PWM input
    
    PINS_direction(EV_CHARGER_nFAULT, INPUT);
    PINS_direction(DCDC_nFAULT, INPUT);
    PINS_direction(V12_POWER_STATUS, INPUT);
    
    PINS_openDrain(CAN_TX_PIN, HIGH);
    
    /*ANALOG*/
    ADC_Init();
    ADC_SetPin(ISOLATION_VOLTAGE_AI);
    ADC_SetPin(HV_BUS_VOLTAGE_AI);
    ADC_SetPin(VBUS_VOLTAGE_AI);
    ADC_SetPin(EV_CHARGER_CURRENT_AI);
    ADC_SetPin(DCDC_OUTPUT_CURRENT_AI);
    ADC_SetPin(EV_CHARGER_VOLTAGE_AI);
    ADC_SetPin(DCDC_OUTPUT_VOLTAGE_AI);
    ADC_SetPin(HIGH_CURRENT_SHUNT_AI);
    ADC_SetPin(LOW_CURRENT_SHUNT_AI);
    ADC_SetPin(TRANSDUCER_INPUT_AI);
    ADC_SetPin(MUX_1_AI);
    ADC_SetPin(MUX_2_AI);
    ADC_SetPin(MUX_3_AI);
    ADC_SetPin(PILOT_MONITOR_AI);
    ADC_SetPin(PROMIXITY_MONINOTR_AI);
    /*PWM*/
    pwmOCinit(CONTACTOR_1_PWM);
    pwmOCwriteFreq(CONTACTOR_1_PWM, 3000); //10kHz
    pwmOCinit(CONTACTOR_2_PWM);
    pwmOCwriteFreq(CONTACTOR_2_PWM, 3000); //20kHz
    
    // Configure Input Capture for PILOT PWM signal
    IC_Config_S pilotConfig = {
        .inputPin = PILOT_PWM_IN,
        .digitalPin = PILOT_MONITOR_PWM_IN,  // TODO: Replace with actual PILOT_PWM_IN digital pin
        .timerSource = IC_TIMER_SOURCE_PERIPHERAL,
        .captureMode = IC_CAPTURE_MODE_EVERY_EDGE,
        .triggerMode = IC_TRIGGER_INPUT_CAPTURE,  // Reset timer on each capture
        .interruptPriority = 4,
        .enableInterrupt = true,
        .clockFrequency = CLOCK_PeripheralFrequencyGet()  // peripheral clock frequency
    };
    IC_Init(IC_MODULE_1, &pilotConfig);
    
    /*UART*/
    //Uart1INIT(UART_TX, UART_RX, UART_BAUD_115200);
    
    /*CAN*/
    CAN_Init(CAN_TX, CAN_RX, CAN_BAUD_500k, CAN_DISABLE, CLOCK_SystemFrequencyGet());
    
    /*Wake inputs*/
    PINS_setInterrupt(V12_POWER_STATUS, 1);
}



