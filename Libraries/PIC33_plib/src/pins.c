#include "pins.h"
#include <stddef.h>


#define set(reg,val) (*(reg) |= (val))
#define clear(reg, val) (*(reg) &= ~(val))
#define toggle(reg, val) (*(reg) ^= (val))
#define get(reg,val) (*(reg) & (val))

// Support for new STM32-style enum format
#define PINS_PIN_TO_PORT(pin) ((pin) >> 4)
#define PINS_PIN_TO_NUM(pin) ((pin) & 0x0F)
#define PINS_PIN_TO_PINS_S(pin) (PINS_pin_S){PINS_PIN_TO_PORT(pin), PINS_PIN_TO_NUM(pin)}

typedef enum {
#ifdef PORTA
    PIN_PORTA,
#endif
#ifdef PORTB
    PIN_PORTB,
#endif
#ifdef PORTC
    PIN_PORTC,
#endif
#ifdef PORTD
    PIN_PORTD,
#endif
#ifdef PORTE
    PIN_PORTE,
#endif
#ifdef PORTF
    PIN_PORTF,
#endif
#ifdef PORTG
    PIN_PORTG,
#endif
    PINS_NUMBER_OF_PORTS
} PINS_portNumber_E;

typedef struct {
    volatile uint16_t* const tris;
    volatile uint16_t* const port;
    volatile uint16_t* const lat;
    volatile uint16_t* const pu;
    volatile uint16_t* const pd;
    volatile uint16_t* const od;
    volatile uint16_t* const inter;
} PINS_S;

/*******************************************************************************
 * PORTA
 */
static const PINS_S PINS_portsArray[PINS_NUMBER_OF_PORTS] = {
#ifdef PORTA
    [PIN_PORTA].tris = &TRISA,
    [PIN_PORTA].port = &PORTA,
    [PIN_PORTA].lat = &LATA,
    [PIN_PORTA].pu = &CNPUA,
    [PIN_PORTA].pd = &CNPDA,
    #ifdef ODCA
    [PIN_PORTA].od = &ODCA,
    #else
    [PIN_PORTA].od = NULL,
    #endif
    [PIN_PORTA].inter = &CNENA,
#endif
#ifdef PORTB
    [PIN_PORTB].tris = &TRISB,
    [PIN_PORTB].port = &PORTB,
    [PIN_PORTB].lat = &LATB,
    [PIN_PORTB].pu = &CNPUB,
    [PIN_PORTB].pd = &CNPDB,
    #ifdef ODCB
    [PIN_PORTB].od = &ODCB,
    #else
    [PIN_PORTB].od = NULL,
    #endif
    [PIN_PORTB].inter = &CNENB,
#endif
#ifdef PORTC
    [PIN_PORTC].tris = &TRISC,
    [PIN_PORTC].port = &PORTC,
    [PIN_PORTC].lat = &LATC,
    [PIN_PORTC].pu = &CNPUC,
    [PIN_PORTC].pd = &CNPDC,
    #ifdef ODCC
    [PIN_PORTC].od = &ODCC,
    #else
    [PIN_PORTC].od = NULL,
    #endif
    [PIN_PORTC].inter = &CNENC,
#endif
#ifdef PORTD
    [PIN_PORTD].tris = &TRISD,
    [PIN_PORTD].port = &PORTD,
    [PIN_PORTD].lat = &LATD,
    [PIN_PORTD].pu = &CNPUD,
    [PIN_PORTD].pd = &CNPDD,
    #ifdef ODCD
    [PIN_PORTD].od = &ODCD,
    #else
    [PIN_PORTD].od = NULL,
    #endif
    [PIN_PORTD].inter = &CNEND,
#endif
#ifdef PORTE
    [PIN_PORTE].tris = &TRISE,
    [PIN_PORTE].port = &PORTE,
    [PIN_PORTE].lat = &LATE,
    [PIN_PORTE].pu = &CNPUE,
    [PIN_PORTE].pd = &CNPDE,
    #ifdef ODCE
    [PIN_PORTE].od = &ODCE,
    #else
    [PIN_PORTE].od = NULL,
    #endif
    [PIN_PORTE].inter = &CNENE,
#endif
#ifdef PORTF
    [PIN_PORTF].tris = &TRISF,
    [PIN_PORTF].port = &PORTF,
    [PIN_PORTF].lat = &LATF,
    [PIN_PORTF].pu = &CNPUF,
    [PIN_PORTF].pd = &CNPDF,
    #ifdef ODCF
    [PIN_PORTF].od = &ODCF,
    #else
    [PIN_PORTF].od = NULL,
    #endif
    [PIN_PORTF].inter = &CNENF,
#endif
#ifdef PORTG
    [PIN_PORTG].tris = &TRISG,
    [PIN_PORTG].port = &PORTG,
    [PIN_PORTG].lat = &LATG,
    [PIN_PORTG].pu = &CNPUG,
    [PIN_PORTG].pd = &CNPDG,
    #ifdef ODCG
    [PIN_PORTG].od = &ODCG,
    #else
    [PIN_PORTG].od = NULL,
    #endif
    [PIN_PORTG].inter = &CNENG,
#endif
};


/*******************************************************************************
 * GPIO pin functions implementation (Simplified)
 * ****************************************************************************/

void PINS_direction(gpio_pin_t pin, PINS_direction_E dir) {
    uint8_t port = PINS_PIN_TO_PORT(pin);
    uint8_t pin_num = PINS_PIN_TO_NUM(pin);
    uint16_t pin_mask = 1 << pin_num;
    
    if (dir == OUTPUT) {
        clear(PINS_portsArray[port].tris, pin_mask);
    } else {
        set(PINS_portsArray[port].tris, pin_mask);
    }
}

void PINS_write(gpio_pin_t pin, PINS_State_E state) {
    uint8_t port = PINS_PIN_TO_PORT(pin);
    uint8_t pin_num = PINS_PIN_TO_NUM(pin);
    uint16_t pin_mask = 1 << pin_num;
    
    switch (state) {
        case LOW:
            clear(PINS_portsArray[port].lat, pin_mask);
            break;
        case HIGH:
            set(PINS_portsArray[port].lat, pin_mask);
            break;
        case TOGGLE:
            toggle(PINS_portsArray[port].lat, pin_mask);
            break;
        default:
            break;
    }
}

PINS_State_E PINS_read(gpio_pin_t pin) {
    uint8_t port = PINS_PIN_TO_PORT(pin);
    uint8_t pin_num = PINS_PIN_TO_NUM(pin);
    uint16_t pin_mask = 1 << pin_num;
    
    return get(PINS_portsArray[port].port, pin_mask) >> pin_num;
}

void PINS_pullUp(gpio_pin_t pin, PINS_State_E state) {
    uint8_t port = PINS_PIN_TO_PORT(pin);
    uint8_t pin_num = PINS_PIN_TO_NUM(pin);
    uint16_t pin_mask = 1 << pin_num;
    
    if (state == LOW) {
        clear(PINS_portsArray[port].pu, pin_mask);
    } else {
        set(PINS_portsArray[port].pu, pin_mask);
    }
}

void PINS_pullDown(gpio_pin_t pin, PINS_State_E state) {
    uint8_t port = PINS_PIN_TO_PORT(pin);
    uint8_t pin_num = PINS_PIN_TO_NUM(pin);
    uint16_t pin_mask = 1 << pin_num;
    
    if (state == LOW) {
        clear(PINS_portsArray[port].pd, pin_mask);
    } else {
        set(PINS_portsArray[port].pd, pin_mask);
    }
}

void PINS_openDrain(gpio_pin_t pin, PINS_State_E state) {
    uint8_t port = PINS_PIN_TO_PORT(pin);
    uint8_t pin_num = PINS_PIN_TO_NUM(pin);
    uint16_t pin_mask = 1 << pin_num;

    if (PINS_portsArray[port].od == NULL) {
        return; // Open drain not supported on this port
    }
    
    if (state == LOW) {
        clear(PINS_portsArray[port].od, pin_mask);
    } else {
        set(PINS_portsArray[port].od, pin_mask);
    }
}

void PINS_setInterrupt(gpio_pin_t pin, PINS_State_E state) {
    uint8_t port = PINS_PIN_TO_PORT(pin);
    uint8_t pin_num = PINS_PIN_TO_NUM(pin);
    uint16_t pin_mask = 1 << pin_num;
    
    if (state == LOW) {
        clear(PINS_portsArray[port].inter, pin_mask);
    } else {
        set(PINS_portsArray[port].inter, pin_mask);
    }
}
