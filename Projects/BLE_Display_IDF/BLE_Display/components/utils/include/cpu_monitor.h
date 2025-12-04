/**
 * @file cpu_monitor.h
 * @brief Lightweight CPU usage monitoring for FreeRTOS tasks
 *
 * This module provides per-task CPU usage tracking with minimal overhead.
 * It tracks average and peak CPU usage for individual tasks using FreeRTOS
 * runtime statistics.
 *
 * Usage:
 * 1. Declare a CPUMonitor_t structure for your task
 * 2. Call CPUMonitor_Init() once before task starts
 * 3. Call CPUMonitor_Update() at the end of each task iteration
 * 4. Access statistics via the structure members
 *
 * Example:
 *   static CPUMonitor_t myTaskMonitor = {0};
 *
 *   void myTask(void *parameter) {
 *     CPUMonitor_Init(&myTaskMonitor);
 *
 *     while(1) {
 *       // ... task work ...
 *
 *       CPUMonitor_Update(&myTaskMonitor);
 *
 *       // Optional: print stats
 *       printf("CPU: %.2f%% (peak: %.2f%%)\n",
 *              myTaskMonitor.cpuUsageAvg,
 *              myTaskMonitor.cpuUsagePeak);
 *     }
 *   }
 */

#ifndef CPU_MONITOR_H
#define CPU_MONITOR_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

/**
 * @brief CPU monitoring statistics structure
 *
 * This structure holds all state needed to track CPU usage for a single task.
 * All fields are managed internally by the CPUMonitor functions.
 */
typedef struct {
    uint32_t lastRunTime;        ///< Last recorded task runtime counter (microseconds)
    uint32_t runTimeDelta;       ///< Runtime since last update (microseconds)
    uint32_t periodStartTime;    ///< Wall-clock time of previous update (microseconds)
    uint32_t period;             ///< Wall-clock time between updates (microseconds)
    float cpuUsageAvg;           ///< Average CPU usage percentage (exponential moving average)
    float cpuUsagePeak;          ///< Peak CPU usage percentage since last reset
    uint32_t peakPeriod;         ///< Period (microseconds) when peak CPU was captured
    uint32_t maxPeriod;          ///< Maximum period (microseconds) observed
} CPUMonitor_t;

/**
 * @brief Initialize CPU monitor for a task
 *
 * Call this once before the task starts its main loop. This initializes
 * the internal state and takes the first timestamp.
 *
 * @param monitor Pointer to CPUMonitor_t structure to initialize
 */
void CPUMonitor_Init(CPUMonitor_t *monitor);

/**
 * @brief Update CPU usage statistics
 *
 * Call this at the end of each task iteration (after vTaskDelayUntil).
 * This calculates the CPU usage percentage for the current iteration
 * and updates the average and peak statistics.
 *
 * The function queries FreeRTOS for the current task's runtime statistics
 * and compares them against the wall-clock time to determine CPU percentage.
 *
 * @param monitor Pointer to CPUMonitor_t structure to update
 */
void CPUMonitor_Update(CPUMonitor_t *monitor);

/**
 * @brief Reset peak CPU usage statistic
 *
 * Resets the peak CPU usage counter to zero. This is useful for
 * periodic reporting where you want to track the peak over a specific
 * time window (e.g., reset every second when printing stats).
 *
 * @param monitor Pointer to CPUMonitor_t structure to reset
 */
void CPUMonitor_ResetPeak(CPUMonitor_t *monitor);

/**
 * @brief Get instantaneous CPU usage
 *
 * Returns the CPU usage percentage calculated during the last update.
 * This is the raw value before averaging.
 *
 * @param monitor Pointer to CPUMonitor_t structure
 * @return CPU usage percentage (0.0 - 100.0)
 */
float CPUMonitor_GetInstantaneous(CPUMonitor_t *monitor);

#ifdef __cplusplus
}
#endif

#endif // CPU_MONITOR_H
