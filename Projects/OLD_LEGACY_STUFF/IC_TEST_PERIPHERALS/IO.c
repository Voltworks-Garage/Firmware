/******************************************************************************
 * Includes
 *******************************************************************************/
#include "IO.h"
#include "pinSetup.h"
#include "ADC.h"


/******************************************************************************
 * Constants
 *******************************************************************************/

/******************************************************************************
 * Macros
 *******************************************************************************/
#define ADC_BIT_DEPTH 1023
#define ADC_REF_VOLTAGE 3.3

#define VBAT_VOLTAGE_CONVERSION 8.234
#define PILOT_VOLTAGE_CONVERSION 4.6
#define PROXIMITY_VOLTAGE_CONVERSION 1
/******************************************************************************
 * Configuration
 *******************************************************************************/

/******************************************************************************
 * Typedefs
 *******************************************************************************/

/******************************************************************************
 * Variable Declarations
 *******************************************************************************/

/******************************************************************************
 * Function Prototypes
 *******************************************************************************/

/******************************************************************************
 * Function Definitions
 *******************************************************************************/

void SET_DEBUG_LED_EN(uint8_t state){
    PINS_write(DEBUG_LED_EN, state);
}

void SET_SW_EN(uint8_t state) {
    PINS_write(SW_EN, state);
}

void SET_CAN_SLEEP_EN(uint8_t state) {
    PINS_write(CAN_SLEEP_EN, state);
}

/*INPUTS*/

uint8_t GET_DEBUG_LED_EN(void) {
    return PINS_read(DEBUG_LED_EN);
}

uint8_t GET_SW_EN(void) {
    return PINS_read(SW_EN);
}

uint8_t GET_CAN_SLEEP_EN(void) {
    return PINS_read(CAN_SLEEP_EN);
}


/*ANALOG*/

uint16_t GET_VOLTAGE_VBAT(void) {
    return (uint16_t)((((float)ADC_GetValue(V12_MONITOR_AI))*(ADC_REF_VOLTAGE*VBAT_VOLTAGE_CONVERSION*1000.0)/ADC_BIT_DEPTH));
}


/*** End of File **************************************************************/



