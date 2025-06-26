#ifndef SYS_TICK_H
#define SYS_TICK_H

#include <stdint.h>

typedef struct {
    uint32_t start_time;
    uint32_t end_value;
} SysTick_Timer_S;

/**
 * @brief SysTick_Init will start the system clock with interupt
 * @param sysClock is the system oscillator frequency
 */
void SysTick_Init(uint32_t sysClock);

/**
 * @brief Stops the Systick Hardware Timer
 */
void SysTick_Stop(void);

/**
 * @brief Resumes the Systick Hardware Timer
 */
void SysTick_Resume(void);

/**
 * @brief SystTick_Get will return the tick value 
 * @return current value of variable "Tick"
 */
uint32_t SysTick_Get(void);


/**
 * SysTick_Timer will create a timer variable with a given name.
 * @param myTimer name of variable
 */
#define NEW_TIMER(name, time) static SysTick_Timer_S name##_systimer = \
{.start_time = 0,\
.end_value = time};\
static SysTick_Timer_S *name = &name##_systimer\

/**
 * @brief SysTick_TimerStart will grab the current time and record the time
 * @param timer stuct 
 */
void SysTick_TimerStart(SysTick_Timer_S *timer);

/**
 * @brief SysTick_TimeOut will check if the timer is expired
 * @param timer
 * @return 
 */
uint8_t SysTick_TimeOut(SysTick_Timer_S *timer);

/**
 * @brief SysTick_CPUTimerStart will grab the value of Timer 5
 */
void SysTick_CPUTimerStart(void);


/**
 * @brief SysTick_CPUTimerEnd will return the percentage of time in the millisecond.
 * @return percentage of a millisecond
 */
uint16_t SysTick_CPUTimerEnd(void);

#endif