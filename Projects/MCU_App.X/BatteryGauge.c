/*
 * File:   BatteryGauge.c
 * Author: Claude Code
 * Comments: Battery gauge management and state of charge calculation
 * Provides battery monitoring, coulomb counting, and SoC estimation
 */

#include "BatteryGauge.h"
#include "IO.h"
#include "pinSetup.h"
#include "stdbool.h"
#include <xc.h>

#define BATTERY_GAUGE_DEFAULT_PERCENT       50   // Default SoC percentage (0-100)
#define BATTERY_GAUGE_RAMP_STEP_PERCENT     1    // Percentage ramp step per 10ms
#define BATTERY_GAUGE_MIN_DUTY_CYCLE        20    // Minimum duty cycle in percent (0%)
#define BATTERY_GAUGE_MAX_DUTY_CYCLE        80   // Maximum duty cycle in percent (100%)
static uint8_t batteryGauge_enable = 0;

static uint8_t current_percent = 0; // Current percentage (0-100)
static uint8_t target_percent = 0;  // Target percentage for ramping

// Convert percentage (0-100) to duty cycle (20-80%)
static uint16_t percent_to_duty_cycle(uint8_t percent) {
    if (percent > 100) percent = 100;
    return BATTERY_GAUGE_MIN_DUTY_CYCLE + ((uint32_t)percent * (BATTERY_GAUGE_MAX_DUTY_CYCLE - BATTERY_GAUGE_MIN_DUTY_CYCLE)) / 100;
}



uint8_t batteryGauge_init(void) {

    batteryGauge_enable = 1;
    current_percent = BATTERY_GAUGE_DEFAULT_PERCENT; // Default percentage
    target_percent = current_percent;

    IO_SET_STEERING_COLUMN_LOCK_EN(HIGH);
    pwmOCwriteDuty(CHARGE_PORT_LOCK_PWM, BATTERY_GAUGE_MIN_DUTY_CYCLE);

    return 1; // Success
}

uint8_t batteryGauge_set_percent(uint8_t percent) {
    if (!batteryGauge_enable) {
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

uint8_t batteryGauge_run_10ms(void) {
    if (!batteryGauge_enable) {
        return 0; // Not initialized
    }

    if (current_percent != target_percent) {
        // Ramp percentage towards target
        if (current_percent < target_percent) {
            current_percent += BATTERY_GAUGE_RAMP_STEP_PERCENT;
            if (current_percent > target_percent) {
                current_percent = target_percent;
            }
        } else {
            current_percent -= BATTERY_GAUGE_RAMP_STEP_PERCENT;
            if (current_percent < target_percent) {
                current_percent = target_percent;
            }
        }
    }

    pwmOCwriteDuty(CHARGE_PORT_LOCK_PWM, percent_to_duty_cycle(current_percent));

    return 1; // Success
}

uint8_t batteryGauge_halt(void) {
    if (!batteryGauge_enable) {
        return 0; // Not initialized
    }

    batteryGauge_enable = 0;

    IO_SET_STEERING_COLUMN_LOCK_EN(LOW);
    pwmOCwriteDuty(CHARGE_PORT_LOCK_PWM, 0);

    return 1; // Success
}