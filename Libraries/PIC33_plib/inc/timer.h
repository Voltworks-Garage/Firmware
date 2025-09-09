/* 
 * File:   timer.h
 * Author: Claude Code
 * Comments: Timer control functions for PIC33
 */

#ifndef TIMER_H
#define TIMER_H

#include <xc.h>
#include <stdint.h>
#include <stdbool.h>

/**
 * Initialize timer 1 with highest resolution possible
 * @param time: timer period in microseconds
 * @param clockfreq: peripheral clock frequency in Hz
 * @return 0 on success, 1 on failure
 */
uint8_t timer1_init(uint32_t time, uint32_t clockfreq);

/**
 * Enable or disable timer 1 interrupt
 * @param enable: true to enable interrupt, false to disable
 */
void timer1_enableInterrupt(bool enable);

/**
 * Enable or disable timer 1
 * @param enable: true to enable timer, false to disable
 */
void timer1_enable(bool enable);

/**
 * Get timer 1 frequency in Hz
 * @param clockfreq: peripheral clock frequency in Hz
 * @return frequency in Hz, 0 if timer disabled
 */
uint32_t timer1_getFrequency(uint32_t clockfreq);

/**
 * Initialize timer 2 with highest resolution possible
 * @param time: timer period in microseconds
 * @param clockfreq: peripheral clock frequency in Hz
 * @return 0 on success, 1 on failure
 */
uint8_t timer2_init(uint32_t time, uint32_t clockfreq);

/**
 * Enable or disable timer 2 interrupt
 * @param enable: true to enable interrupt, false to disable
 */
void timer2_enableInterrupt(bool enable);

/**
 * Enable or disable timer 2
 * @param enable: true to enable timer, false to disable
 */
void timer2_enable(bool enable);

/**
 * Get timer 2 frequency in Hz
 * @param clockfreq: peripheral clock frequency in Hz
 * @return frequency in Hz, 0 if timer disabled
 */
uint32_t timer2_getFrequency(uint32_t clockfreq);

/**
 * Initialize timer 3 with highest resolution possible
 * @param time: timer period in microseconds
 * @param clockfreq: peripheral clock frequency in Hz
 * @return 0 on success, 1 on failure
 */
uint8_t timer3_init(uint32_t time, uint32_t clockfreq);

/**
 * Enable or disable timer 3 interrupt
 * @param enable: true to enable interrupt, false to disable
 */
void timer3_enableInterrupt(bool enable);

/**
 * Enable or disable timer 3
 * @param enable: true to enable timer, false to disable
 */
void timer3_enable(bool enable);

/**
 * Get timer 3 frequency in Hz
 * @param clockfreq: peripheral clock frequency in Hz
 * @return frequency in Hz, 0 if timer disabled
 */
uint32_t timer3_getFrequency(uint32_t clockfreq);

/**
 * Initialize timer 4 with highest resolution possible
 * @param time: timer period in microseconds
 * @param clockfreq: peripheral clock frequency in Hz
 * @return 0 on success, 1 on failure
 */
uint8_t timer4_init(uint32_t time, uint32_t clockfreq);

/**
 * Enable or disable timer 4 interrupt
 * @param enable: true to enable interrupt, false to disable
 */
void timer4_enableInterrupt(bool enable);

/**
 * Enable or disable timer 4
 * @param enable: true to enable timer, false to disable
 */
void timer4_enable(bool enable);

/**
 * Get timer 4 frequency in Hz
 * @param clockfreq: peripheral clock frequency in Hz
 * @return frequency in Hz, 0 if timer disabled
 */
uint32_t timer4_getFrequency(uint32_t clockfreq);

/**
 * Set callback function for timer 1 interrupt
 * @param callback: function pointer to user interrupt handler
 */
void timer1_setCallback(void (*callback)(void));

/**
 * Set callback function for timer 2 interrupt
 * @param callback: function pointer to user interrupt handler
 */
void timer2_setCallback(void (*callback)(void));

/**
 * Set callback function for timer 3 interrupt
 * @param callback: function pointer to user interrupt handler
 */
void timer3_setCallback(void (*callback)(void));

/**
 * Set callback function for timer 4 interrupt
 * @param callback: function pointer to user interrupt handler
 */
void timer4_setCallback(void (*callback)(void));

/**
 * Inline functions for clearing timer interrupt flags
 * These can be copied to other files without needing xc.h include
 */
static inline void timer1_clearInterruptFlag(void) {
    IFS0bits.T1IF = 0;
}

static inline void timer2_clearInterruptFlag(void) {
    IFS0bits.T2IF = 0;
}

static inline void timer3_clearInterruptFlag(void) {
    IFS0bits.T3IF = 0;
}

static inline void timer4_clearInterruptFlag(void) {
    IFS1bits.T4IF = 0;
}

#endif /* TIMER_H */