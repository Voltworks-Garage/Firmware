/* 
 * File:   
 * Author: 
 * Comments:
 * Revision history: 
 */

// This is a guard condition so that contents of this file are not included
// more than once.  
#ifndef DCDC_H
#define	DCDC_H

typedef enum {
    DCDC_OFF,
    DCDC_PRECHARGE,
    DCDC_ENABLE,
    DCDC_FAULT
} DCDC_state_E;

void DCDC_Init(void);

void DCDC_Run_1ms(void);

void DCDC_Run_100ms(void);

void DCDC_Halt(void);

void DCDC_Run(void);

DCDC_state_E DCDC_GetState(void);

float DCDC_GetVoltage(void);

float DCDC_GetCurrent(void);

#endif	/* DCDC_H */

