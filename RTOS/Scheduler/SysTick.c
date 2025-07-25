#include "SysTick.h"
#include "movingAverage.h"
#include <stdint.h>
#include <xc.h>

static uint32_t volatile Tick = 0;
static uint32_t TicksPerMS = 0;
static uint32_t CPU_Timer = 0;
static uint16_t CPU_peak = 0;
static uint16_t CPU_peak_last = 0;
static uint16_t CPU_peak_counter = 0;
#define CPU_PEAK_COUNTER_MAX 1000

NEW_LOW_PASS_FILTER(CPU_usage, 100.0, 1000.0);

uint32_t SysTick_Get(void) {
    return Tick;
}

void SysTick_Set(uint32_t value){
    Tick = value;
}

void SysTick_Init(uint32_t sysClock) {
    TicksPerMS = ((sysClock / 2) / 1000);
    uint8_t preScaler = 0;

    if (TicksPerMS > 0x0000FFFF) {
        preScaler = 1;
        TicksPerMS = (TicksPerMS / 8);
    }

    /* Initialize timer */
    T5CONbits.TON = 0;
    T5CON = 0; /* Clear timer config register */
    T5CONbits.TCKPS = preScaler; /* prescaler set to 0 */
    TMR5 = 0x00; /*Clear Timers*/
    PR5 = (uint16_t) TicksPerMS; /*set timer period */

    /* Enable level 1-7 interrupts */
    /* No restoring of previous CPU IPL state performed here */
    INTCON2bits.GIE = 1;

    /* set timer interrupt priority */
    _T5IP = 7;
    /* reset timer interrupt */
    _T5IF = 0;
    /* Enable timer interrupt */
    _T5IE = 1;

    /* Turn timer on */
    T5CONbits.TON = 1;
}

void SysTick_Stop(void){
        /* Turn timer off */
    T5CONbits.TON = 0;
}

void SysTick_Resume(void){
        /* Turn timer on */
    T5CONbits.TON = 1;
}

void SysTick_TimerStart(SysTick_Timer_S *timer){
    timer->start_time = SysTick_Get();
    timer->enabled = true;
}

uint8_t SysTick_TimeOut(SysTick_Timer_S *timer){
    if (timer->enabled && (SysTick_Get() - timer->start_time > timer->end_value)){
        timer->enabled = false;
        return 1;
    }
    return 0;
}

void SysTick_CPUTimerStart(void){
    CPU_Timer = TMR5;
}

void SysTick_CPUTimerEnd(void){
    uint32_t end_value = TMR5;
    uint32_t delta_ticks = 0;
    if (end_value >= CPU_Timer) {
        delta_ticks = (uint16_t)(end_value - CPU_Timer);
    } else {
        delta_ticks = (uint16_t)((TicksPerMS - CPU_Timer) + end_value); // wrapped around
    }
    uint16_t CPU_percentage = (uint16_t)((delta_ticks*100) / TicksPerMS); //10 to get the extra decimal place
    
    takeLowPassFilter(CPU_usage, CPU_percentage);
    if (CPU_percentage > CPU_peak){
        CPU_peak = CPU_percentage;
    }
    if (CPU_peak_counter++ > CPU_PEAK_COUNTER_MAX) {
            CPU_peak_counter = 0;
            CPU_peak_last = CPU_peak;
            CPU_peak = 0;
    }
}

float SysTick_GetCPUPercentage(void){
    return getLowPassFilter(CPU_usage); //Remove the decimal place before converting to float
}

float SysTick_GetCPUPeak(void){
    return (float)(CPU_peak_last); //Remove the decimal place before converting to float
}

void __attribute__((__interrupt__, __auto_psv__, __shadow__)) _T5Interrupt(void) {
    /* clear timer interrupt Flag*/
    _T5IF = 0;

    /*Put your code here*/
    Tick++;
}
