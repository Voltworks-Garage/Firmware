/* 
 * File:   IgnitionControl.h
 * Author: kid group
 *
 * Created on June 12, 2018, 10:38 PM
 */

#ifndef IGNITIONCONTROL_H
#define	IGNITIONCONTROL_H

#include "button.h"

void IgnitionControl_Init(void);

void IgnitionControl_Run_10ms(void);

ButtonStatus_E IgnitionControl_GetKillStatus(void);

ButtonStatus_E IgnitionControl_GetIgnitionStatus(void);

void IgnitionControl_Halt(void);

#endif	/* IGNITIONCONTROL_H */

