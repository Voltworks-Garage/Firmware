/* 
 * File:   tachometer.h
 * Author: Claude Code
 * Comments: Tachometer PWM control using TIMER4
 * PWM frequency range: 50Hz to 400Hz
 */

#ifndef TACHOMETER_H
#define TACHOMETER_H

#include <stdint.h>

/**
 * Initialize tachometer PWM output using TIMER4
 * @param pin: PWM output pin from oc_pin_number enum
 * @return 1 if successful, 0 if failed
 */
uint8_t tachometer_init(void);

/**
 * Set PWM frequency as percentage (0% = 50Hz, 100% = 400Hz)
 * @param percent: Percentage (0 to 100)
 * @return 1 if successful, 0 if failed or out of range
 */
uint8_t tachometer_set_percent(uint8_t percent);

/**
 * Start tachometer operation
 * Enables TIMER4 and charger contactor
 * @return 1 if successful, 0 if failed
 */
uint8_t tachometer_run_10ms(void);

/**
 * Stop tachometer operation
 * Disables TIMER4 and charger contactor
 * @return 1 if successful, 0 if failed
 */
uint8_t tachometer_halt(void);

#endif /* TACHOMETER_H */