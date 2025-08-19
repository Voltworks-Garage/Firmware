/* 
 * File:   
 * Author: 
 * Comments:
 * Revision history: 
 */

// This is a guard condition so that contents of this file are not included
// more than once.  
#ifndef EV_CHARGER_H
#define	EV_CHARGER_H

#include <stdint.h>

void EV_Charger_Init(void);
void EV_CHARGER_Run_10ms(void);

uint8_t EV_CHARGER_is_charging(void);
float EV_CHARGER_current_get(void);
float EV_CHARGER_voltage_get(void);

#endif	/* EV_CHARGER_H */

