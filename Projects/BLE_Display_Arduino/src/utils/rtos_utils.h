#ifndef RTOS_UTILS_H
#define RTOS_UTILS_H

#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include <stdbool.h>

/******************************************************************************
 * Timer Macros (similar to SysTick pattern)
 *******************************************************************************/
typedef struct {
    TickType_t start_tick;
    TickType_t timeout_ms;
    bool enabled;
} RtosTimer_S;

#define NEW_TIMER(name, ms) \
    static RtosTimer_S name = { .start_tick = 0, .timeout_ms = (ms), .enabled = false }

#define TIMER_START(timer) do { \
    (timer).start_tick = xTaskGetTickCount(); \
    (timer).enabled = true; \
} while(0)

#define TIMER_IS_UP(timer) \
    ((timer).enabled && \
     ((xTaskGetTickCount() - (timer).start_tick) * portTICK_PERIOD_MS >= (timer).timeout_ms) ? \
     ((timer).enabled = false, true) : false)

#endif // RTOS_UTILS_H
