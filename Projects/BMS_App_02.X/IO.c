/******************************************************************************
 * Includes
 *******************************************************************************/
#include "IO.h"
#include "pinSetup.h"
#include "ADC.h"
#include "OC.h"


/******************************************************************************
 * Constants
 *******************************************************************************/

/******************************************************************************
 * Macros
 *******************************************************************************/
#define ADC_BIT_DEPTH 1023.0
#define ADC_REF_VOLTAGE 3.0 //TODO: change this to 3.3 when new regulator arrives
#define ADC_FACTOR (ADC_REF_VOLTAGE/ADC_BIT_DEPTH)

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

void IO_SET_DEBUG_LED_EN(uint8_t state){
    PINS_write(DEBUG_LED_EN, state);
}

void IO_SET_SW_EN(uint8_t state) {
    PINS_write(SW_EN, state);
}

void IO_SET_DCDC_EN(uint8_t state) {
    PINS_write(DCDC_EN, state);
}

void IO_SET_EV_CHARGER_EN(uint8_t state) {
    PINS_write(EV_CHARGER_EN, state);
}

void IO_SET_PRE_CHARGE_EN(uint8_t state) {
    PINS_write(PRE_CHARGE_EN, state);
}

void IO_SET_MUX_A(uint8_t state) {
    PINS_write(MUX_A, state);
}

void IO_SET_MUX_B(uint8_t state) {
    PINS_write(MUX_B, state);
}

void IO_SET_MUX_C(uint8_t state) {
    PINS_write(MUX_C, state);
}

void IO_SET_SPI_CS(uint8_t state){
    PINS_write(SPI_CS, state);
}

void IO_SET_CONTACTOR_1_PWM(uint8_t duty){
    pwmOCwriteDuty(CONTACTOR_1_PWM, duty);
}

void IO_SET_CONTACTOR_2_PWM(uint8_t duty){
    pwmOCwriteDuty(CONTACTOR_2_PWM, duty);
}

/*INPUTS*/

uint8_t IO_GET_DEBUG_LED_EN(void) {
    return PINS_read(DEBUG_LED_EN);
}

uint8_t IO_GET_SW_EN(void) {
    return PINS_read(SW_EN);
}

uint8_t IO_GET_DCDC_EN(void) {
    return PINS_read(DCDC_EN);
}

uint8_t IO_GET_EV_CHARGER_EN(void) {
    return PINS_read(EV_CHARGER_EN);
}

uint8_t IO_GET_PRE_CHARGE_EN(void) {
    return PINS_read(PRE_CHARGE_EN);
}

uint8_t IO_GET_MUX_A(void) {
    return PINS_read(MUX_A);
}

uint8_t IO_GET_MUX_B(void) {
    return PINS_read(MUX_B);
}

uint8_t IO_GET_MUX_C(void) {
    return PINS_read(MUX_C);
}

uint8_t IO_GET_V12_POWER_STATUS(void) {
    return PINS_read(V12_POWER_STATUS);
}

uint8_t IO_GET_V5_SW_FAULT(void) {
    return !PINS_read(V5_SW_nFAULT);
}

uint8_t IO_GET_DCDC_FAULT(void) {
    return !PINS_read(DCDC_nFAULT);
}

uint8_t IO_GET_EV_CHARGER_FAULT(void) {
    return !PINS_read(EV_CHARGER_nFAULT);
}


/* Analog */

float IO_GET_ISOLATION_VOLTAGE(void){
    return ((float)ADC_GetValue(ISOLATION_VOLTAGE_AI))*31.0*ADC_FACTOR;
}

#define HV_BUS_VOLTAGE_RTOP 3000000.0
#define HV_BUS_VOLTAGE_RBOT 100000.0
#define HV_BUS_VOLTAGE_DIVIDER (HV_BUS_VOLTAGE_RBOT/(HV_BUS_VOLTAGE_RBOT+HV_BUS_VOLTAGE_RTOP))
float IO_GET_HV_BUS_VOLTAGE(void){
    return (((float)ADC_GetValue(HV_BUS_VOLTAGE_AI))*ADC_FACTOR)/HV_BUS_VOLTAGE_DIVIDER;
}

#define VBUS_VOLTAGE_RTOP 3000000.0
#define VBUS_VOLTAGE_RBOT 100000.0
#define VBUS_VOLTAGE_DIVIDER (VBUS_VOLTAGE_RBOT/(VBUS_VOLTAGE_RBOT+VBUS_VOLTAGE_RTOP))
float IO_GET_VBUS_VOLTAGE(void){
    return (((float)ADC_GetValue(VBUS_VOLTAGE_AI))*ADC_FACTOR)/VBUS_VOLTAGE_DIVIDER;
}


#define EV_CHARGER_VOLTAGE_RTOP 330000.0
#define EV_CHARGER_VOLTAGE_RBOT 10000.0
#define EV_CHARGER_VOLTAGE_DIVIDER (EV_CHARGER_VOLTAGE_RBOT/(EV_CHARGER_VOLTAGE_RBOT+EV_CHARGER_VOLTAGE_RTOP))
float IO_GET_EV_CHARGER_VOLTAGE(void){
    return (((float)ADC_GetValue(EV_CHARGER_VOLTAGE_AI))*ADC_FACTOR)/EV_CHARGER_VOLTAGE_DIVIDER;
}

#define DCDC_VOLTAGE_RTOP 330000.0
#define DCDC_VOLTAGE_RBOT 10000.0
#define DCDC_VOLTAGE_DIVIDER (DCDC_VOLTAGE_RBOT/(DCDC_VOLTAGE_RBOT+DCDC_VOLTAGE_RTOP))
float IO_GET_DCDC_OUTPUT_VOLTAGE(void){
    return (((float)ADC_GetValue(DCDC_OUTPUT_VOLTAGE_AI))*ADC_FACTOR)/DCDC_VOLTAGE_DIVIDER;
}

float IO_GET_MUX_1_VOLTAGE(void){
    return ((float)ADC_GetValue(MUX_1_AI))*ADC_FACTOR;
}

float IO_GET_MUX_2_VOLTAGE(void){
    return ((float)ADC_GetValue(MUX_2_AI))*ADC_FACTOR;
}

float IO_GET_MUX_3_VOLTAGE(void){
    return ((float)ADC_GetValue(MUX_3_AI))*ADC_FACTOR;
}

float IO_GET_DCDC_CURRENT(void){
    return ((float)ADC_GetValue(DCDC_OUTPUT_CURRENT_AI))*5.0*ADC_FACTOR;
}

#define EV_CHARGER_CURRENT_REF_VOLTAGE 2.5
#define EV_CHARGER_CURRENT_GAIN_A_PER_V 50
#define EV_CHARGER_CURRENT_RTOP 10000.0
#define EV_CHARGER_CURRENT_RBOT 20000.0
#define EV_CHARGER_CURRENT_DIVIDER (EV_CHARGER_CURRENT_RBOT/(EV_CHARGER_CURRENT_RBOT+EV_CHARGER_CURRENT_RTOP))


float IO_GET_EV_CHARGER_CURRENT(void){
    return (((float)ADC_GetValue(EV_CHARGER_CURRENT_AI))*ADC_FACTOR)/EV_CHARGER_CURRENT_DIVIDER;
}

float IO_GET_SHUNT_HIGH_CURRENT(void){
    return 0;
}

float IO_GET_SHUNT_LOW_CURRENT(void){
    return 0;
}

float IO_GET_TRANSDUCER_CURRENT(void){
    return 0;
}




/*** End of File **************************************************************/



