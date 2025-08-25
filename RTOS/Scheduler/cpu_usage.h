/**
 * @file cpu_usage.h
 * @brief Per-task CPU usage measurement module
 * 
 * This module provides functions to measure CPU usage for individual tasks
 * using integer math and moving averages.
 */

#ifndef CPU_USAGE_H
#define CPU_USAGE_H

/******************************************************************************
* Includes
*******************************************************************************/
#include <stdint.h>
#include "tsk_cfg.h"

/******************************************************************************
* Function Prototypes
*******************************************************************************/

/**
 * @brief CPUUsage_Init initializes the CPU usage measurement system
 * @note Must be called after SysTick_Init()
 */
void CPUUsage_Init(void);

/**
 * @brief CPUUsage_StartTaskTiming starts timing for a specific task
 * @param task Pointer to the task structure
 */
void CPUUsage_StartTaskTiming(TaskType *task);

/**
 * @brief CPUUsage_EndTaskTiming ends timing for a specific task and calculates CPU usage
 * @param task Pointer to the task structure
 */
void CPUUsage_EndTaskTiming(TaskType *task);

/**
 * @brief CPUUsage_GetTaskCPUPercent returns the moving average CPU percentage for a task
 * @param task Pointer to the task structure
 * @return CPU percentage (0.1% resolution)
 */
uint16_t CPUUsage_GetTaskCPUPercent(TaskType *task);

/**
 * @brief CPUUsage_GetTaskPeakCPU returns the peak CPU percentage for a task
 * @param task Pointer to the task structure
 * @return Peak CPU percentage (0.1% resolution)
 */
uint16_t CPUUsage_GetTaskPeakCPU(TaskType *task);

/**
 * @brief CPUUsage_GetTaskExecutionCount returns the number of times a task has executed
 * @param task Pointer to the task structure
 * @return Execution count
 */
uint32_t CPUUsage_GetTaskExecutionCount(TaskType *task);

#endif /* CPU_USAGE_H */