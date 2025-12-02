/**
 * BLE Application Message Handler
 *
 * Handles periodic transmission of CAN bus data over BLE using the
 * BLE protocol schema. Populates BLE messages with real-time CAN data.
 */

#ifndef APP_HANDLER_H
#define APP_HANDLER_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>

/**
 * Initialize the application handler
 * Must be called before any run_XXms functions
 */
void app_handler_init(void);

/**
 * 10ms periodic task
 * Sends high-frequency motor and safety data
 */
void app_handler_run_10ms(void);

/**
 * 100ms periodic task
 * Sends medium-frequency BMS status data
 */
void app_handler_run_100ms(void);

/**
 * 1000ms periodic task
 * Sends low-frequency heartbeat and performance data
 */
void app_handler_run_1000ms(void);

#ifdef __cplusplus
}
#endif

#endif // APP_HANDLER_H
