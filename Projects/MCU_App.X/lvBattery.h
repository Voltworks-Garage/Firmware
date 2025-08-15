/* 
 * File:   
 * Author: 
 * Comments:
 * Revision history: 
 */

// This is a guard condition so that contents of this file are not included
// more than once.  
#ifndef LV_BATTERY_H
#define	LV_BATTERY_H
#include <stdbool.h>

void LvBattery_Init(void);

void LvBattery_Run_10ms(void);

void LvBattery_Halt(void);

bool LvBattery_HasDCDCSupport(void);


#endif	/* LV_BATTERY_H */

