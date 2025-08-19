/* 
 * File:   contactorControl.h
 * Author: 
 * Comments: Contactor control state machine with PWM control
 * Revision history: 
 */

// This is a guard condition so that contents of this file are not included
// more than once.  
#ifndef CONTACTOR_CONTROL_H
#define	CONTACTOR_CONTROL_H

typedef enum {
    CONTACTOR_IDLE,
    CONTACTOR_PRECHARGE,
    CONTACTOR_PULL_IN,
    CONTACTOR_HOLD
} CONTACTOR_state_E;

void CONTACTOR_Init(void);

void CONTACTOR_Run_1ms(void);

void CONTACTOR_Run_100ms(void);

void CONTACTOR_Halt(void);

void CONTACTOR_Run(void);

CONTACTOR_state_E CONTACTOR_GetState(void);

#endif	/* CONTACTOR_CONTROL_H */