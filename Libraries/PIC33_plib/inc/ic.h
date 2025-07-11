/* 
 * File:   ic.h
 * Author: Zachary Levenberg
 *
 * Created on August 6, 2016, 9:28 AM
 */

#ifndef IC_H
#define	IC_H

#include <stdint.h>
#include "pps.h"

typedef enum _ic_mode {
    IC_16_BIT, 
    IC_32_BIT /*Select this option for 32-bit IC module, uses 1&2 or 3&4*/
} ic_mode;

typedef enum _ic_status {
    CHARGING,
    RESLEASED,
    RUNNING,
    DONE
} ic_status;


/**
 * Init an Input Capture module on the specified Pin
 * @param newICPin from #define list above
 * @param mode 16 or 32 bit
 * @return success (1) or failure (0)
 */
uint8_t ic_Init(pps_input_pin_t newICPin, ic_mode mode);

/**
 * Check to see if pulse width has been captured
 * @return a 4-bit field corresponding to each IC module
 */
uint8_t ic_Ready(void);

/**
 * get the captured time from a specified module
 * @param thisModule a module from the #define list above
 * @return the 16bit time in Peripheral Clock Ticks
 */
uint16_t ic_getTime(pps_input_pin_t thisModule);


#endif	/* IC_H */

