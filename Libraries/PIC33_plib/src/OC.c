/* 
 * File:   OutputCompare
 * Author: Zach Levenberg
 * Comments: This module is intended for use as PWM module
 * Revision history: 
 */

#include "OC.h" // include processor files - each processor file is guarded.  

#define AVAILABLE 0
#define UNAVAILABLE 1

/* OC Register Structure for array-based access */
typedef struct {
    volatile uint16_t* CON1;
    volatile uint16_t* CON2;
    volatile uint16_t* R;
    volatile uint16_t* RS;
    const uint16_t PPS_MAP;
} OCRegisters;

/* Array of OC register pointers - ifdef protected for each module */
static OCRegisters oc_regs[] = {
#ifdef OC1CON1
    #define OC1_PPS_MAP 0b00010000
    {&OC1CON1, &OC1CON2, &OC1R, &OC1RS, OC1_PPS_MAP}
    #undef NUMBER_OC_MODULES
    #define NUMBER_OC_MODULES 1
#endif
#ifdef OC2CON1
    #define OC2_PPS_MAP 0b00010001
    ,{&OC2CON1, &OC2CON2, &OC2R, &OC2RS, OC2_PPS_MAP}
    #undef NUMBER_OC_MODULES
    #define NUMBER_OC_MODULES 2

#endif
#ifdef OC3CON1
    #define OC3_PPS_MAP 0b00010010
    ,{&OC3CON1, &OC3CON2, &OC3R, &OC3RS, OC3_PPS_MAP}
    #undef NUMBER_OC_MODULES
    #define NUMBER_OC_MODULES 3
#endif
#ifdef OC4CON1
    #define OC4_PPS_MAP 0b00010011
    ,{&OC4CON1, &OC4CON2, &OC4R, &OC4RS, OC4_PPS_MAP}
    #undef NUMBER_OC_MODULES
    #define NUMBER_OC_MODULES 4
#endif
#ifdef OC5CON1
    #define OC5_PPS_MAP 0b00010100
    ,{&OC5CON1, &OC5CON2, &OC5R, &OC5RS, OC5_PPS_MAP}
    #undef NUMBER_OC_MODULES
    #define NUMBER_OC_MODULES 5
#endif
#ifdef OC6CON1
    #define OC6_PPS_MAP 0b00010101
    ,{&OC6CON1, &OC6CON2, &OC6R, &OC6RS, OC6_PPS_MAP}
    #undef NUMBER_OC_MODULES
    #define NUMBER_OC_MODULES 6
#endif
#ifdef OC7CON1
    #define OC7_PPS_MAP 0b00010110
    ,{&OC7CON1, &OC7CON2, &OC7R, &OC7RS, OC7_PPS_MAP}
    #undef NUMBER_OC_MODULES
    #define NUMBER_OC_MODULES 7
#endif
#ifdef OC8CON1
    #define OC8_PPS_MAP 0b00010111
    ,{&OC8CON1, &OC8CON2, &OC8R, &OC8RS, OC8_PPS_MAP}
    #undef NUMBER_OC_MODULES
    #define NUMBER_OC_MODULES 8
#endif
};

typedef struct _OCmodule {
    uint8_t moduleNumber;
    uint8_t ppsMap;
    uint8_t Pin;
    uint8_t status;
    uint8_t duty;
    uint32_t freq;
    oc_clock_source clockSource;
    uint32_t clock_freq;
    uint16_t period_ticks;
} OCmodule;

static OCmodule modules[NUMBER_OC_MODULES];

/* Helper macros for bit field manipulation using Microchip-defined masks */
#define SET_OC_OCTSEL(module, value) \
    (*oc_regs[module].CON1 = (*oc_regs[module].CON1 & ~_OC1CON1_OCTSEL_MASK) | \
     ((value << _OC1CON1_OCTSEL_POSITION) & _OC1CON1_OCTSEL_MASK))

#define SET_OC_OCM(module, value) \
    (*oc_regs[module].CON1 = (*oc_regs[module].CON1 & ~_OC1CON1_OCM_MASK) | \
     ((value << _OC1CON1_OCM_POSITION) & _OC1CON1_OCM_MASK))

#define SET_OC_SYNCSEL(module, value) \
    (*oc_regs[module].CON2 = (*oc_regs[module].CON2 & ~_OC1CON2_SYNCSEL_MASK) | \
     ((value << _OC1CON2_SYNCSEL_POSITION) & _OC1CON2_SYNCSEL_MASK))

  uint16_t calculate_period(uint32_t clock_freq, uint32_t desired_freq);
  uint16_t calculate_duty(uint32_t period_ticks, uint8_t duty);

/**
 * pwm init, there are only 4 modules.
 * @param pin RP pin number
 * @return succes or failure
 */
uint8_t pwmOCinit(oc_pin_number pin, uint32_t clock_freq, oc_clock_source clock_source) {

    OCmodule currentModule = {}; /*variable to hold module to assign*/
    uint8_t i = 0;

    /*check the pin for available modules*/
    for (i = 0; i < NUMBER_OC_MODULES; i++) {/*check modules in use*/
        if (modules[i].status == AVAILABLE) {
            modules[i].status = UNAVAILABLE;
            modules[i].moduleNumber = i;
            modules[i].Pin = pin;
            modules[i].ppsMap = oc_regs[i].PPS_MAP;
            modules[i].duty = 0;
            modules[i].freq = 0xFFFFFFFF; /*default to max period*/
            modules[i].clockSource = clock_source;
            modules[i].clock_freq = clock_freq;
            modules[i].period_ticks = 0xFFFF; /*default to max period*/
            currentModule = modules[i];
            break;
        }
    }

    if (i == NUMBER_OC_MODULES) {
        return 0; /*all modules are in use*/
    }

    /*set the pinmap to the correct pin*/
    switch (pin) {
#ifdef _RP20R
        case PWM_PIN_RP20:
            _RP20R = currentModule.ppsMap;
            break;
#endif
#ifdef _RP35R
        case PWM_PIN_RP35:
            _RP35R = currentModule.ppsMap;
            break;
#endif
#ifdef _RP36R
        case PWM_PIN_RP36:
            _RP36R = currentModule.ppsMap;
            break;
#endif
#ifdef _RP37R
        case PWM_PIN_RP37:
            _RP37R = currentModule.ppsMap;
            break;
#endif
#ifdef _RP38R
        case PWM_PIN_RP38:
            _RP38R = currentModule.ppsMap;
            break;
#endif
#ifdef _RP39R
        case PWM_PIN_RP39:
            _RP39R = currentModule.ppsMap;
            break;
#endif
#ifdef _RP40R
        case PWM_PIN_RP40:
            _RP40R = currentModule.ppsMap;
            break;
#endif
#ifdef _RP41R
        case PWM_PIN_RP41:
            _RP41R = currentModule.ppsMap;
            break;
#endif
#ifdef _RP42R
        case PWM_PIN_RP42:
            _RP42R = currentModule.ppsMap;
            break;
#endif
#ifdef _RP43R
        case PWM_PIN_RP43:
            _RP43R = currentModule.ppsMap;
            break;
#endif
#ifdef _RP54R
        case PWM_PIN_RP54:
            _RP54R = currentModule.ppsMap;
            break;
#endif
#ifdef _RP55R
        case PWM_PIN_RP55:
            _RP55R = currentModule.ppsMap;
            break;
#endif
#ifdef _RP56R
        case PWM_PIN_RP56:
            _RP56R = currentModule.ppsMap;
            break;
#endif
#ifdef _RP57R
        case PWM_PIN_RP57:
            _RP57R = currentModule.ppsMap;
            break;
#endif
#ifdef _RP96R
        case PWM_PIN_RP96:
            _RP96R = currentModule.ppsMap;
            break;
#endif
#ifdef _RP97R
        case PWM_PIN_RP97:
            _RP97R = currentModule.ppsMap;
            break;
#endif
#ifdef _RP100R
        case PWM_PIN_RP100:
            _RP100R = currentModule.ppsMap;
            break;
#endif
#ifdef _RP101R
        case PWM_PIN_RP101:
            _RP101R = currentModule.ppsMap;
            break;
#endif
#ifdef _RP126R
        case PWM_PIN_RP126:
            _RP126R = currentModule.ppsMap;
            break;
#endif
#ifdef _RP127R
        case PWM_PIN_RP127:
            _RP127R = currentModule.ppsMap;
            break;
#endif

        default:
            return 0; /*not a valid pin*/
            break;
    }

    /*configure the module using register array*/
    uint8_t module_num = currentModule.moduleNumber;

    /* Clear control bits initially */
    *oc_regs[module_num].CON1 = 0;
    *oc_regs[module_num].CON2 = 0;

    /* Configure using Microchip-defined bit masks */
    SET_OC_OCTSEL(module_num, currentModule.clockSource);
    SET_OC_OCM(module_num, 0b110); /* PWM mode */
    SET_OC_SYNCSEL(module_num, 0x1F); /* sync source is itself */

    /* Set duty cycle and period */
    *oc_regs[module_num].R = 0; /* duty cycle */
    *oc_regs[module_num].RS = currentModule.period_ticks; /* period */

    return 1;
}

uint8_t pwmOCwriteDuty(oc_pin_number pin, uint16_t dutyCycle) {
    if (dutyCycle > 100) {
        dutyCycle = 100; /*invalid dutycycle*/
    }
    
    uint8_t i = 0;
    uint8_t currentModule = 0;
    for (i = 0; i < NUMBER_OC_MODULES; i++) {
        if (modules[i].Pin == pin) {
            currentModule = modules[i].moduleNumber;
            modules[i].duty = dutyCycle;
            break;
        }
    }
    if (i == NUMBER_OC_MODULES) {
        return 0; /*invalid pin*/
    }


    /* Set duty cycle using register array */
    *oc_regs[currentModule].R = calculate_duty(modules[currentModule].period_ticks,
                                                 modules[currentModule].duty);
    return 1;
}

uint8_t pwmOCwriteFreq(oc_pin_number pin, uint16_t frequency) {
    uint8_t i = 0;
    uint8_t currentModule = 0;
    for (i = 0; i < NUMBER_OC_MODULES; i++) {
        if (modules[i].Pin == pin) {
            currentModule = modules[i].moduleNumber;
            modules[i].freq = frequency;
            modules[i].period_ticks = calculate_period(modules[i].clock_freq, frequency);
            break;
        }
    }
    if (i == NUMBER_OC_MODULES) {
        return 0; /*invalid pin*/
    }

    /* Set period and duty cycle using register array */
    *oc_regs[currentModule].RS = modules[currentModule].period_ticks; /* period */
    *oc_regs[currentModule].R = calculate_duty(modules[currentModule].period_ticks,
                                                 modules[currentModule].duty); /* duty cycle */
    return 1;
}

  uint16_t calculate_period(uint32_t clock_freq, uint32_t desired_freq) {
      return (clock_freq / desired_freq) - 1;
  }

    // Calculate duty cycle in timer ticks
  // clock_freq: Timer clock frequency (Hz)
  // desired_freq: PWM frequency (Hz)
  // duty: 0 to 100 (integer percentage)
  uint16_t calculate_duty(uint32_t period_ticks, uint8_t duty) {
      return (duty * period_ticks) / 100;
  }