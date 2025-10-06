/*
 * File:   BatteryGauge.h
 * Author: Claude Code
 * Comments: Battery gauge management and state of charge calculation
 * Provides battery monitoring, coulomb counting, and SoC estimation
 */

#ifndef BATTERY_GAUGE_H
#define BATTERY_GAUGE_H

#include <stdint.h>

/**
 * Initialize battery gauge monitoring system
 * @return 1 if successful, 0 if failed
 */
uint8_t batteryGauge_init(void);

/**
 * Set battery state of charge as percentage (0% = empty, 100% = full)
 * @param percent: State of charge percentage (0 to 100)
 * @return 1 if successful, 0 if failed or out of range
 */
uint8_t batteryGauge_set_percent(uint8_t percent);

/**
 * Run battery gauge monitoring and SoC calculation
 * Should be called every 10ms for accurate monitoring
 * @return 1 if successful, 0 if failed
 */
uint8_t batteryGauge_run_10ms(void);

/**
 * Halt battery gauge operation
 * Disables monitoring and resets state
 * @return 1 if successful, 0 if failed
 */
uint8_t batteryGauge_halt(void);

#endif /* BATTERY_GAUGE_H */