/**
 * @file cpu_monitor.c
 * @brief Implementation of lightweight CPU usage monitoring for FreeRTOS tasks
 */

#include "cpu_monitor.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_timer.h"

void CPUMonitor_Init(CPUMonitor_t *monitor) {
    if (monitor == NULL) {
        return;
    }

    // Zero out the structure
    monitor->lastRunTime = 0;
    monitor->runTimeDelta = 0;
    monitor->periodStartTime = esp_timer_get_time();
    monitor->period = 0;
    monitor->cpuUsageAvg = 0.0f;
    monitor->cpuUsagePeak = 0.0f;
    monitor->peakPeriod = 0;
    monitor->maxPeriod = 0;

    // Get initial runtime for the calling task
    TaskStatus_t taskStatus;
    vTaskGetInfo(NULL, &taskStatus, pdFALSE, eInvalid);
    monitor->lastRunTime = taskStatus.ulRunTimeCounter;
}

void CPUMonitor_Update(CPUMonitor_t *monitor) {
    if (monitor == NULL) {
        return;
    }

    // Query current task's CPU stats
    TaskStatus_t taskStatus;
    vTaskGetInfo(NULL, &taskStatus, pdFALSE, eInvalid);

    // Get wall-clock time
    uint32_t now = esp_timer_get_time();
    uint32_t taskTotalRunTime = taskStatus.ulRunTimeCounter;

    // Calculate period (wall-clock time elapsed)
    monitor->period = now - monitor->periodStartTime;
    monitor->periodStartTime = now;

    // Calculate task run time delta
    monitor->runTimeDelta = taskTotalRunTime - monitor->lastRunTime;
    monitor->lastRunTime = taskTotalRunTime;

    // Track maximum period observed
    if (monitor->period > monitor->maxPeriod) {
        monitor->maxPeriod = monitor->period;
    }

    // Calculate CPU usage percentage
    // CPU% = (task_runtime / wall_clock_time) * 100
    if (monitor->period > 0) {
        float cpuUsage = ((float)monitor->runTimeDelta / (float)monitor->period) * 100.0f;

        // Update exponential moving average (simple average of current and previous)
        monitor->cpuUsageAvg = (monitor->cpuUsageAvg + cpuUsage) / 2.0f;

        // Update peak and capture the period when peak occurred
        if (cpuUsage > monitor->cpuUsagePeak) {
            monitor->cpuUsagePeak = cpuUsage;
            monitor->peakPeriod = monitor->period;
        }
    }
}

void CPUMonitor_ResetPeak(CPUMonitor_t *monitor) {
    if (monitor == NULL) {
        return;
    }

    monitor->cpuUsagePeak = 0.0f;
    monitor->peakPeriod = 0;
    monitor->maxPeriod = 0;
}

float CPUMonitor_GetInstantaneous(CPUMonitor_t *monitor) {
    if (monitor == NULL || monitor->period == 0) {
        return 0.0f;
    }

    return ((float)monitor->runTimeDelta / (float)monitor->period) * 100.0f;
}
