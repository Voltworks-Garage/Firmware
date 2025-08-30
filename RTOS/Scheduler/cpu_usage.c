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
static uint16_t current_task_start_timer = 0;  /**< Timer value when current task started */
static uint32_t current_task_start_systick = 0; /**< SysTick value when current task started */

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
        current_task_start_timer = SysTick_GetTimerValue();
        current_task_start_systick = SysTick_Get();
    }
}

void CPUUsage_EndTaskTiming(TaskType *task)
{
    if (task == NULL) return;
    
    uint16_t end_timer = SysTick_GetTimerValue();
    uint32_t end_systick = SysTick_Get();
    uint16_t execution_ticks = 0;
    uint16_t cpu_percent = 0;
    
    // Check for SysTick overflow during task execution
    // If more than 1ms has passed, we likely had an overflow
    uint32_t systick_duration = end_systick - current_task_start_systick;
    if (systick_duration > 1) {
        // Overflow detected - set CPU usage to 100%
        cpu_percent = 100;
        execution_ticks = ticks_per_ms_cached;
    } else {
        // Handle timer wraparound
        if (end_timer >= current_task_start_timer) {
            execution_ticks = end_timer - current_task_start_timer;
        } else {
            execution_ticks = (ticks_per_ms_cached - current_task_start_timer) + end_timer;
        }
        
        // Calculate CPU percentage (0-100%)
        // Formula: (execution_ticks * 100) / (1ms_ticks)
        cpu_percent = (uint16_t)((execution_ticks * 100UL) / ticks_per_ms_cached);
        
        // Cap at 100% 
        if (cpu_percent > 100) {
            cpu_percent = 100;
        }
    }
    
    // Update peak execution time
    if (execution_ticks > task->peak_execution_ticks) {
        task->peak_execution_ticks = execution_ticks;
    }
    
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