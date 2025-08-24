/* 
 * File:   tachometer.c
 * Author: Claude Code
 * Comments: Configures TIMER4 and PWM for tachometer output
 * PWM frequency range: 50Hz to 400Hz
 */

#include "tachometer.h"
#include "IO.h"
#include "OC.h"
#include "pinSetup.h"
#include "stdbool.h"
#include <xc.h>

#define TACHOMETER_DEFAULT_PERCENT      0    // Default percentage (0-100)
#define TACHOMETER_RAMP_STEP_PERCENT    1    // Percentage ramp step per 10ms
#define TACHOMETER_MIN_FREQ_HZ          5   // Minimum frequency in Hz (0%)
#define TACHOMETER_MAX_FREQ_HZ          160  // Maximum frequency in Hz (100%)
#define TACHOMETER_MIN_DUTY_CYCLE       5    // Minimum duty cycle in percent (0%)
#define TACHOMETER_MAX_DUTY_CYCLE       10   // Maximum duty cycle in percent (100%)

static uint8_t tachometer_enable = 0;

static uint8_t current_percent = 0; // Current percentage (0-100)
static uint8_t target_percent = 0;  // Target percentage for ramping

// Convert percentage (0-100) to frequency (16-160 Hz)
static uint16_t percent_to_frequency(uint8_t percent) {
    if (percent > 100) percent = 100;
    return TACHOMETER_MIN_FREQ_HZ + ((uint32_t)percent * (TACHOMETER_MAX_FREQ_HZ - TACHOMETER_MIN_FREQ_HZ)) / 100;
}

// Convert percentage (0-100) to duty cycle (5-10%)
static uint8_t percent_to_duty_cycle(uint8_t percent) {
    if(percent < 1){
        return 0; // 0% duty cycle for 0%
    }
    if (percent > 100) percent = 100;
    return TACHOMETER_MIN_DUTY_CYCLE + ((uint32_t)percent * (TACHOMETER_MAX_DUTY_CYCLE - TACHOMETER_MIN_DUTY_CYCLE)) / 100;
}

uint8_t tachometer_init(void) {
    
    // Configure TIMER4 with prescaler = 64 for good resolution across 50-400Hz range
    T4CON = 0; // Clear timer configuration
    T4CONbits.TCKPS = 3; // Prescaler = 64
    PR4 = 65535; // Max period for flexibility
    TMR4 = 0; // Clear timer count
    T4CONbits.TON = 1; // Turn on timer
    
    tachometer_enable = 1;
    current_percent = TACHOMETER_DEFAULT_PERCENT; // Default percentage

    // Enable charger contactor
    IO_SET_CHARGER_CONTACTOR_EN(HIGH);

    pwmOCwriteDuty(KICKSTAND_SWITCH_IN, percent_to_duty_cycle(current_percent));
    pwmOCwriteFreq(KICKSTAND_SWITCH_IN, percent_to_frequency(current_percent));
    
    return 1; // Success
}

uint8_t tachometer_set_percent(uint8_t percent) {
    if (!tachometer_enable) {
        return 0; // Not initialized
    }
    
    // Validate percentage range: 0% to 100%
    if (percent > 100) {
        return 0; // Out of range
    }
    
    // Set target percentage
    target_percent = percent;
    
    return 1; // Success
}

uint8_t tachometer_run_10ms(void) {
    if (!tachometer_enable) {
        return 0; // Not initialized
    }

    if (current_percent != target_percent) {
        // Ramp percentage towards target
        if (current_percent < target_percent) {
            current_percent += TACHOMETER_RAMP_STEP_PERCENT;
            if (current_percent > target_percent) {
                current_percent = target_percent;
            }
        } else {
            current_percent -= TACHOMETER_RAMP_STEP_PERCENT;
            if (current_percent < target_percent) {
                current_percent = target_percent;
            }
        }
    }

    pwmOCwriteFreq(KICKSTAND_SWITCH_IN, percent_to_frequency(current_percent));
    pwmOCwriteDuty(KICKSTAND_SWITCH_IN, percent_to_duty_cycle(current_percent));

    
    return 1; // Success
}

uint8_t tachometer_halt(void) {
    if (!tachometer_enable) {
        return 0; // Not initialized
    }
    
    // Stop TIMER4
    T4CONbits.TON = 0;
    
    // Disable charger contactor
    IO_SET_CHARGER_CONTACTOR_EN(LOW);

    pwmOCwriteDuty(KICKSTAND_SWITCH_IN, 0);

    tachometer_enable = 0;
    
    return 1; // Success
}