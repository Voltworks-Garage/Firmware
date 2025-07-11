/* 
 * File:   pins.h
 * Author: Zachary S. Levenberg
 * Revision history: initial build 10/2/16
 */

#ifndef PINS_H
#define	PINS_H
/*******************************************************************************
 * Include
 * ****************************************************************************/
#include <xc.h>
#include <stdint.h>

/*******************************************************************************
 * Defines and Datatypes
 * ****************************************************************************/

#define PIN_CONCAT(A, B) A##B

typedef enum {
    LOW,
    HIGH,
    TOGGLE
} PINS_State_E;

typedef enum {
    OUTPUT,
    INPUT
} PINS_direction_E;



/*******************************************************************************
 * STM32-style GPIO pin enumeration
 * ****************************************************************************/

// GPIO pin enumeration (port << 4 | pin_number)
typedef enum {
    // Port A pins
    PA0 = 0x00, PA1 = 0x01, PA2 = 0x02, PA3 = 0x03,
    PA4 = 0x04, PA5 = 0x05, PA6 = 0x06, PA7 = 0x07,
    PA8 = 0x08, PA9 = 0x09, PA10 = 0x0A, PA11 = 0x0B,
    PA12 = 0x0C, PA13 = 0x0D, PA14 = 0x0E, PA15 = 0x0F,
    
    // Port B pins
    PB0 = 0x10, PB1 = 0x11, PB2 = 0x12, PB3 = 0x13,
    PB4 = 0x14, PB5 = 0x15, PB6 = 0x16, PB7 = 0x17,
    PB8 = 0x18, PB9 = 0x19, PB10 = 0x1A, PB11 = 0x1B,
    PB12 = 0x1C, PB13 = 0x1D, PB14 = 0x1E, PB15 = 0x1F,
    
    // Port C pins
    PC0 = 0x20, PC1 = 0x21, PC2 = 0x22, PC3 = 0x23,
    PC4 = 0x24, PC5 = 0x25, PC6 = 0x26, PC7 = 0x27,
    PC8 = 0x28, PC9 = 0x29, PC10 = 0x2A, PC11 = 0x2B,
    PC12 = 0x2C, PC13 = 0x2D, PC14 = 0x2E, PC15 = 0x2F,
    
    // Port D pins
    PD0 = 0x30, PD1 = 0x31, PD2 = 0x32, PD3 = 0x33,
    PD4 = 0x34, PD5 = 0x35, PD6 = 0x36, PD7 = 0x37,
    PD8 = 0x38, PD9 = 0x39, PD10 = 0x3A, PD11 = 0x3B,
    PD12 = 0x3C, PD13 = 0x3D, PD14 = 0x3E, PD15 = 0x3F,
    
    // Port E pins
    PE0 = 0x40, PE1 = 0x41, PE2 = 0x42, PE3 = 0x43,
    PE4 = 0x44, PE5 = 0x45, PE6 = 0x46, PE7 = 0x47,
    PE8 = 0x48, PE9 = 0x49, PE10 = 0x4A, PE11 = 0x4B,
    PE12 = 0x4C, PE13 = 0x4D, PE14 = 0x4E, PE15 = 0x4F,
    
    // Port F pins
    PF0 = 0x50, PF1 = 0x51, PF2 = 0x52, PF3 = 0x53,
    PF4 = 0x54, PF5 = 0x55, PF6 = 0x56, PF7 = 0x57,
    PF8 = 0x58, PF9 = 0x59, PF10 = 0x5A, PF11 = 0x5B,
    PF12 = 0x5C, PF13 = 0x5D, PF14 = 0x5E, PF15 = 0x5F,
    
    // Port G pins
    PG0 = 0x60, PG1 = 0x61, PG2 = 0x62, PG3 = 0x63,
    PG4 = 0x64, PG5 = 0x65, PG6 = 0x66, PG7 = 0x67,
    PG8 = 0x68, PG9 = 0x69, PG10 = 0x6A, PG11 = 0x6B,
    PG12 = 0x6C, PG13 = 0x6D, PG14 = 0x6E, PG15 = 0x6F
} gpio_pin_t;



/*******************************************************************************
 * New STM32-style GPIO pin functions
 * ****************************************************************************/

/**
 * Set pin direction using new enum format
 * @param pin - GPIO pin in STM32-style enum format (e.g., PA0, PB4)
 * @param dir - INPUT or OUTPUT
 */
void PINS_direction(gpio_pin_t pin, PINS_direction_E dir);

/**
 * Write to pin using new enum format
 * @param pin - GPIO pin in STM32-style enum format
 * @param state - LOW, HIGH, or TOGGLE
 */
void PINS_write(gpio_pin_t pin, PINS_State_E state);

/**
 * Read from pin using new enum format
 * @param pin - GPIO pin in STM32-style enum format
 * @return pin state (LOW or HIGH)
 */
PINS_State_E PINS_read(gpio_pin_t pin);

/**
 * Set pull-up resistor using new enum format
 * @param pin - GPIO pin in STM32-style enum format
 * @param state - LOW to disable, HIGH to enable
 */
void PINS_pullUp(gpio_pin_t pin, PINS_State_E state);

/**
 * Set pull-down resistor using new enum format
 * @param pin - GPIO pin in STM32-style enum format
 * @param state - LOW to disable, HIGH to enable
 */
void PINS_pullDown(gpio_pin_t pin, PINS_State_E state);

/**
 * Set open drain mode using new enum format
 * @param pin - GPIO pin in STM32-style enum format
 * @param state - LOW to disable, HIGH to enable
 */
void PINS_openDrain(gpio_pin_t pin, PINS_State_E state);

/**
 * Set interrupt on pin change using new enum format
 * @param pin - GPIO pin in STM32-style enum format
 * @param state - LOW to disable, HIGH to enable
 */
void PINS_setInterrupt(gpio_pin_t pin, PINS_State_E state);


#endif	/* PINS_H */

