/* 
 * File:   ThrottleControl.h
 * Author: Voltworks Garage
 *
 * Created on August 27, 2025
 */

#ifndef THROTTLECONTROL_H
#define THROTTLECONTROL_H

#include <stdbool.h>

void ThrottleControl_Init(void);

void ThrottleControl_Run_1ms(void);

void ThrottleControl_Halt(void);

void ThrottleControl_Enable(bool state);

#endif /* THROTTLECONTROL_H */