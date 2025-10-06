#include "timer.h"
#include <stdint.h>
#include <stdbool.h>
#include <xc.h>

// Forward declarations for callback function pointers
extern void (*timer1_callback)(void);
extern void (*timer2_callback)(void);
extern void (*timer3_callback)(void);
extern void (*timer4_callback)(void);

// Weak interrupt vector declarations - can be overridden in application code
void __attribute__((weak)) __attribute__((interrupt, auto_psv)) _T1Interrupt(void) {
    if (timer1_callback != 0) {
        timer1_callback();
    }
    timer1_clearInterruptFlag();
}

void __attribute__((weak)) __attribute__((interrupt, auto_psv)) _T2Interrupt(void) {
    if (timer2_callback != 0) {
        timer2_callback();
    }
    timer2_clearInterruptFlag();
}

void __attribute__((weak)) __attribute__((interrupt, auto_psv)) _T3Interrupt(void) {
    if (timer3_callback != 0) {
        timer3_callback();
    }
    timer3_clearInterruptFlag();
}

void __attribute__((weak)) __attribute__((interrupt, auto_psv)) _T4Interrupt(void) {
    if (timer4_callback != 0) {
        timer4_callback();
    }
    timer4_clearInterruptFlag();
}

/*
 Function: timer1_init()
 Param: time: timer period in microseconds
        clockfreq: peripheral clock frequency in Hz
 Return: 0 on success, 1 on failure
 Description: Initializes timer 1 with highest resolution possible
 */
uint8_t timer1_init(uint32_t time, uint32_t clockfreq) {
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
 Function: timer1_enableInterrupt()
 Params: enable: true to enable interrupt, false to disable
 Return: void
 Description: Enables or disables timer 1 interrupt
 */
void timer1_enableInterrupt(bool enable) {
    IEC0bits.T1IE = enable ? 1 : 0;
}

/*
 Function: timer1_enable()
 Params: enable: true to enable timer, false to disable
 Return: void
 Description: Enables or disables timer 1
 */
void timer1_enable(bool enable) {
    T1CONbits.TON = enable ? 1 : 0;
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
 Function: timer2_init()
 Param: time: timer period in microseconds
        clockfreq: peripheral clock frequency in Hz
 Return: 0 on success, 1 on failure
 Description: Initializes timer 2 with highest resolution possible
 */
uint8_t timer2_init(uint32_t time, uint32_t clockfreq) {
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
 Function: timer2_enableInterrupt()
 Params: enable: true to enable interrupt, false to disable
 Return: void
 Description: Enables or disables timer 2 interrupt
 */
void timer2_enableInterrupt(bool enable) {
    IEC0bits.T2IE = enable ? 1 : 0;
}

/*
 Function: timer2_enable()
 Params: enable: true to enable timer, false to disable
 Return: void
 Description: Enables or disables timer 2
 */
void timer2_enable(bool enable) {
    T2CONbits.TON = enable ? 1 : 0;
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
 Function: timer3_init()
 Param: time: timer period in microseconds
        clockfreq: peripheral clock frequency in Hz
 Return: 0 on success, 1 on failure
 Description: Initializes timer 3 with highest resolution possible
 */
uint8_t timer3_init(uint32_t time, uint32_t clockfreq) {
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
 Function: timer3_enableInterrupt()
 Params: enable: true to enable interrupt, false to disable
 Return: void
 Description: Enables or disables timer 3 interrupt
 */
void timer3_enableInterrupt(bool enable) {
    IEC0bits.T3IE = enable ? 1 : 0;
}

/*
 Function: timer3_enable()
 Params: enable: true to enable timer, false to disable
 Return: void
 Description: Enables or disables timer 3
 */
void timer3_enable(bool enable) {
    T3CONbits.TON = enable ? 1 : 0;
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
 Function: timer4_init()
 Param: time: timer period in microseconds
        clockfreq: peripheral clock frequency in Hz
 Return: 0 on success, 1 on failure
 Description: Initializes timer 4 with highest resolution possible
 */
uint8_t timer4_init(uint32_t time, uint32_t clockfreq) {
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
 Function: timer4_enableInterrupt()
 Params: enable: true to enable interrupt, false to disable
 Return: void
 Description: Enables or disables timer 4 interrupt
 */
void timer4_enableInterrupt(bool enable) {
    IEC1bits.T4IE = enable ? 1 : 0;
}

/*
 Function: timer4_enable()
 Params: enable: true to enable timer, false to disable
 Return: void
 Description: Enables or disables timer 4
 */
void timer4_enable(bool enable) {
    T4CONbits.TON = enable ? 1 : 0;
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

// Function pointer approach - alternative method
// Global function pointers for user-defined interrupt handlers
void (*timer1_callback)(void) = 0;
void (*timer2_callback)(void) = 0;
void (*timer3_callback)(void) = 0;
void (*timer4_callback)(void) = 0;

void timer1_setCallback(void (*callback)(void)) {
    timer1_callback = callback;
}

void timer2_setCallback(void (*callback)(void)) {
    timer2_callback = callback;
}

void timer3_setCallback(void (*callback)(void)) {
    timer3_callback = callback;
}

void timer4_setCallback(void (*callback)(void)) {
    timer4_callback = callback;
}