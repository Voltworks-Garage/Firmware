#include "timer.h"
#include <stdint.h>
#include <xc.h>

/*
 Function: timer1_enable()
 Param: time: timer period in microseconds
        clockfreq: peripheral clock frequency in Hz
 Return: 0 on success, 1 on failure
 Description: Enables timer 1 with highest resolution possible
 */
uint8_t timer1_enable(uint32_t time, uint32_t clockfreq) {
    uint32_t timer_clock = clockfreq / 2; // FCY = clockfreq / 2
    uint32_t required_ticks = (timer_clock / 1000000UL) * time; // Convert microseconds to ticks
    
    uint8_t prescaler_bits = 0;
    uint16_t prescaler_value = 1;
    
    // Find minimum prescaler for highest resolution (1, 8, 64, 256)
    while (required_ticks > 65535 && prescaler_bits < 3) {
        prescaler_bits++;
        switch (prescaler_bits) {
            case 1: prescaler_value = 8; break;
            case 2: prescaler_value = 64; break;
            case 3: prescaler_value = 256; break;
        }
        required_ticks = ((timer_clock / prescaler_value) / 1000000UL) * time;
    }
    
    if (required_ticks > 65535) {
        return 1; // Cannot fit in 16-bit timer
    }
    
    // Configure timer
    T1CON = 0;
    T1CONbits.TCKPS = prescaler_bits;
    PR1 = (uint16_t)required_ticks;
    TMR1 = 0;
    T1CONbits.TON = 1;
    
    return 0;
}

/*
 Function: timer1_disable()
 Params: none
 Return: void
 Description: Disables timer 1
 */
void timer1_disable(void) {
    T1CONbits.TON = 0;
}

/*
 Function: timer1_getFrequency()
 Param: clockfreq: peripheral clock frequency in Hz
 Return: frequency in Hz, 0 if timer disabled
 Description: Gets timer 1 frequency based on current configuration
 */
uint32_t timer1_getFrequency(uint32_t clockfreq) {
    if (!T1CONbits.TON) return 0; // Timer disabled
    
    uint32_t timer_clock = clockfreq / 2; // FCY = clockfreq / 2
    uint8_t prescaler_bits = T1CONbits.TCKPS;
    uint16_t prescaler_value = 1;
    
    switch (prescaler_bits) {
        case 1: prescaler_value = 8; break;
        case 2: prescaler_value = 64; break;
        case 3: prescaler_value = 256; break;
        default: prescaler_value = 1; break;
    }
    
    return (timer_clock / prescaler_value) / (PR1 + 1);
}

/*
 Function: timer2_enable()
 Param: time: timer period in microseconds
        clockfreq: peripheral clock frequency in Hz
 Return: 0 on success, 1 on failure
 Description: Enables timer 2 with highest resolution possible
 */
uint8_t timer2_enable(uint32_t time, uint32_t clockfreq) {
    uint32_t timer_clock = clockfreq / 2; // FCY = clockfreq / 2
    uint32_t required_ticks = (timer_clock / 1000000UL) * time; // Convert microseconds to ticks
    
    uint8_t prescaler_bits = 0;
    uint16_t prescaler_value = 1;
    
    // Find minimum prescaler for highest resolution (1, 8, 64, 256)
    while (required_ticks > 65535 && prescaler_bits < 3) {
        prescaler_bits++;
        switch (prescaler_bits) {
            case 1: prescaler_value = 8; break;
            case 2: prescaler_value = 64; break;
            case 3: prescaler_value = 256; break;
        }
        required_ticks = ((timer_clock / prescaler_value) / 1000000UL) * time;
    }
    
    if (required_ticks > 65535) {
        return 1; // Cannot fit in 16-bit timer
    }
    
    // Configure timer
    T2CON = 0;
    T2CONbits.TCKPS = prescaler_bits;
    PR2 = (uint16_t)required_ticks;
    TMR2 = 0;
    T2CONbits.TON = 1;
    
    return 0;
}

/*
 Function: timer2_disable()
 Params: none
 Return: void
 Description: Disables timer 2
 */
void timer2_disable(void) {
    T2CONbits.TON = 0;
}

/*
 Function: timer2_getFrequency()
 Param: clockfreq: peripheral clock frequency in Hz
 Return: frequency in Hz, 0 if timer disabled
 Description: Gets timer 2 frequency based on current configuration
 */
uint32_t timer2_getFrequency(uint32_t clockfreq) {
    if (!T2CONbits.TON) return 0; // Timer disabled
    
    uint32_t timer_clock = clockfreq / 2; // FCY = clockfreq / 2
    uint8_t prescaler_bits = T2CONbits.TCKPS;
    uint16_t prescaler_value = 1;
    
    switch (prescaler_bits) {
        case 1: prescaler_value = 8; break;
        case 2: prescaler_value = 64; break;
        case 3: prescaler_value = 256; break;
        default: prescaler_value = 1; break;
    }
    
    return (timer_clock / prescaler_value) / (PR2 + 1);
}

/*
 Function: timer3_enable()
 Param: time: timer period in microseconds
        clockfreq: peripheral clock frequency in Hz
 Return: 0 on success, 1 on failure
 Description: Enables timer 3 with highest resolution possible
 */
uint8_t timer3_enable(uint32_t time, uint32_t clockfreq) {
    uint32_t timer_clock = clockfreq / 2; // FCY = clockfreq / 2
    uint32_t required_ticks = (timer_clock / 1000000UL) * time; // Convert microseconds to ticks
    
    uint8_t prescaler_bits = 0;
    uint16_t prescaler_value = 1;
    
    // Find minimum prescaler for highest resolution (1, 8, 64, 256)
    while (required_ticks > 65535 && prescaler_bits < 3) {
        prescaler_bits++;
        switch (prescaler_bits) {
            case 1: prescaler_value = 8; break;
            case 2: prescaler_value = 64; break;
            case 3: prescaler_value = 256; break;
        }
        required_ticks = ((timer_clock / prescaler_value) / 1000000UL) * time;
    }
    
    if (required_ticks > 65535) {
        return 1; // Cannot fit in 16-bit timer
    }
    
    // Configure timer
    T3CON = 0;
    T3CONbits.TCKPS = prescaler_bits;
    PR3 = (uint16_t)required_ticks;
    TMR3 = 0;
    T3CONbits.TON = 1;
    
    return 0;
}

/*
 Function: timer3_disable()
 Params: none
 Return: void
 Description: Disables timer 3
 */
void timer3_disable(void) {
    T3CONbits.TON = 0;
}

/*
 Function: timer3_getFrequency()
 Param: clockfreq: peripheral clock frequency in Hz
 Return: frequency in Hz, 0 if timer disabled
 Description: Gets timer 3 frequency based on current configuration
 */
uint32_t timer3_getFrequency(uint32_t clockfreq) {
    if (!T3CONbits.TON) return 0; // Timer disabled
    
    uint32_t timer_clock = clockfreq / 2; // FCY = clockfreq / 2
    uint8_t prescaler_bits = T3CONbits.TCKPS;
    uint16_t prescaler_value = 1;
    
    switch (prescaler_bits) {
        case 1: prescaler_value = 8; break;
        case 2: prescaler_value = 64; break;
        case 3: prescaler_value = 256; break;
        default: prescaler_value = 1; break;
    }
    
    return (timer_clock / prescaler_value) / (PR3 + 1);
}

/*
 Function: timer4_enable()
 Param: time: timer period in microseconds
        clockfreq: peripheral clock frequency in Hz
 Return: 0 on success, 1 on failure
 Description: Enables timer 4 with highest resolution possible
 */
uint8_t timer4_enable(uint32_t time, uint32_t clockfreq) {
    uint32_t timer_clock = clockfreq / 2; // FCY = clockfreq / 2
    uint32_t required_ticks = (timer_clock / 1000000UL) * time; // Convert microseconds to ticks
    
    uint8_t prescaler_bits = 0;
    uint16_t prescaler_value = 1;
    
    // Find minimum prescaler for highest resolution (1, 8, 64, 256)
    while (required_ticks > 65535 && prescaler_bits < 3) {
        prescaler_bits++;
        switch (prescaler_bits) {
            case 1: prescaler_value = 8; break;
            case 2: prescaler_value = 64; break;
            case 3: prescaler_value = 256; break;
        }
        required_ticks = ((timer_clock / prescaler_value) / 1000000UL) * time;
    }
    
    if (required_ticks > 65535) {
        return 1; // Cannot fit in 16-bit timer
    }
    
    // Configure timer
    T4CON = 0;
    T4CONbits.TCKPS = prescaler_bits;
    PR4 = (uint16_t)required_ticks;
    TMR4 = 0;
    T4CONbits.TON = 1;
    
    return 0;
}

/*
 Function: timer4_disable()
 Params: none
 Return: void
 Description: Disables timer 4
 */
void timer4_disable(void) {
    T4CONbits.TON = 0;
}

/*
 Function: timer4_getFrequency()
 Param: clockfreq: peripheral clock frequency in Hz
 Return: frequency in Hz, 0 if timer disabled
 Description: Gets timer 4 frequency based on current configuration
 */
uint32_t timer4_getFrequency(uint32_t clockfreq) {
    if (!T4CONbits.TON) return 0; // Timer disabled
    
    uint32_t timer_clock = clockfreq / 2; // FCY = clockfreq / 2
    uint8_t prescaler_bits = T4CONbits.TCKPS;
    uint16_t prescaler_value = 1;
    
    switch (prescaler_bits) {
        case 1: prescaler_value = 8; break;
        case 2: prescaler_value = 64; break;
        case 3: prescaler_value = 256; break;
        default: prescaler_value = 1; break;
    }
    
    return (timer_clock / prescaler_value) / (PR4 + 1);
}