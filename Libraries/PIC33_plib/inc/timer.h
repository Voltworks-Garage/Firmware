/* 
 * File:   timer.h
 * Author: Claude Code
 * Comments: Timer control functions for PIC33
 */

#ifndef TIMER_H
#define TIMER_H

#include <xc.h>
#include <stdint.h>

/**
 * Enable timer 1 with highest resolution possible
 * @param time: timer period in microseconds
 * @param clockfreq: peripheral clock frequency in Hz
 * @return 0 on success, 1 on failure
 */
uint8_t timer1_enable(uint32_t time, uint32_t clockfreq);

/**
 * Disable timer 1
 */
void timer1_disable(void);

/**
 * Get timer 1 frequency in Hz
 * @param clockfreq: peripheral clock frequency in Hz
 * @return frequency in Hz, 0 if timer disabled
 */
uint32_t timer1_getFrequency(uint32_t clockfreq);

/**
 * Enable timer 2 with highest resolution possible
 * @param time: timer period in microseconds
 * @param clockfreq: peripheral clock frequency in Hz
 * @return 0 on success, 1 on failure
 */
uint8_t timer2_enable(uint32_t time, uint32_t clockfreq);

/**
 * Disable timer 2
 */
void timer2_disable(void);

/**
 * Get timer 2 frequency in Hz
 * @param clockfreq: peripheral clock frequency in Hz
 * @return frequency in Hz, 0 if timer disabled
 */
uint32_t timer2_getFrequency(uint32_t clockfreq);

/**
 * Enable timer 3 with highest resolution possible
 * @param time: timer period in microseconds
 * @param clockfreq: peripheral clock frequency in Hz
 * @return 0 on success, 1 on failure
 */
uint8_t timer3_enable(uint32_t time, uint32_t clockfreq);

/**
 * Disable timer 3
 */
void timer3_disable(void);

/**
 * Get timer 3 frequency in Hz
 * @param clockfreq: peripheral clock frequency in Hz
 * @return frequency in Hz, 0 if timer disabled
 */
uint32_t timer3_getFrequency(uint32_t clockfreq);

/**
 * Enable timer 4 with highest resolution possible
 * @param time: timer period in microseconds
 * @param clockfreq: peripheral clock frequency in Hz
 * @return 0 on success, 1 on failure
 */
uint8_t timer4_enable(uint32_t time, uint32_t clockfreq);

/**
 * Disable timer 4
 */
void timer4_disable(void);

/**
 * Get timer 4 frequency in Hz
 * @param clockfreq: peripheral clock frequency in Hz
 * @return frequency in Hz, 0 if timer disabled
 */
uint32_t timer4_getFrequency(uint32_t clockfreq);

#endif /* TIMER_H */