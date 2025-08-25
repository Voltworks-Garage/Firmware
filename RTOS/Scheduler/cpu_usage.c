/**
 * @file cpu_usage.c
 * @brief Per-task CPU usage measurement implementation
 * 
 * This module provides functions to measure CPU usage for individual tasks
 * using integer math and moving averages.
 */

/******************************************************************************
* Includes
*******************************************************************************/
#include "cpu_usage.h"
#include "SysTick.h"
#include "movingAverageInt.h"
#include <stddef.h>

/******************************************************************************
* Static Variables
*******************************************************************************/
static uint16_t ticks_per_ms_cached = 0;

/******************************************************************************
* Function Implementations
*******************************************************************************/

void CPUUsage_Init(void)
{
    // Cache ticks_per_ms to avoid repeated function calls
    ticks_per_ms_cached = SysTick_GetTicksPerMS();
}

void CPUUsage_StartTaskTiming(TaskType *task)
{
    if (task != NULL) {
        task->start_timer = SysTick_GetTimerValue();
    }
}

void CPUUsage_EndTaskTiming(TaskType *task)
{
    if (task == NULL) return;
    
    uint16_t end_timer = SysTick_GetTimerValue();
    uint16_t execution_ticks = 0;
    
    // Handle timer wraparound
    if (end_timer >= task->start_timer) {
        execution_ticks = end_timer - task->start_timer;
    } else {
        execution_ticks = (ticks_per_ms_cached - task->start_timer) + end_timer;
    }
    
    // Update peak execution time
    if (execution_ticks > task->peak_execution_ticks) {
        task->peak_execution_ticks = execution_ticks;
    }
    
    // Calculate CPU percentage (0-100%)
    // Formula: (execution_ticks * 100) / (1ms_ticks)
    uint16_t cpu_percent = 0;
    
    cpu_percent = (uint16_t)((execution_ticks * 100UL) / ticks_per_ms_cached);
    
    takeMovingAverageInt(&task->cpu_filter, cpu_percent);
    
    // Update peak CPU percentage
    if (cpu_percent > task->peak_cpu_percent) {
        task->peak_cpu_percent = cpu_percent;
    }
}

uint16_t CPUUsage_GetTaskCPUPercent(TaskType *task)
{
    if (task != NULL) {
        return getMovingAverageInt(&task->cpu_filter);
    }
    return 0;
}

uint16_t CPUUsage_GetTaskPeakCPU(TaskType *task)
{
    if (task != NULL) {
        return task->peak_cpu_percent;
    }
    return 0;
}