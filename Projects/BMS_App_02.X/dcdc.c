#include "dcdc.h"
#include "IO.h"
#include "movingAverage.h"
#include "bms_dbc.h"
#include "SysTick.h"
#include <stdint.h>

/******************************************************************************
 * State Machine Definition
 *******************************************************************************/
#define DCDC_STATES(state)\
state(off) \
state(precharge) \
state(enable) \
state(fault)

// Generate state enum
#define STATE_FORM(WORD) WORD##_state,
typedef enum {
    DCDC_STATES(STATE_FORM)
} DCDC_states_E;

// Generate function prototypes
typedef enum {
    ENTRY,
    EXIT, 
    RUN
} DCDC_entry_types_E;

#define FUNCTION_FORM(WORD) static void WORD(DCDC_entry_types_E entry_type);
DCDC_STATES(FUNCTION_FORM)

// Function pointer type and array
typedef void (*state_FPtr)(DCDC_entry_types_E entry_type);
#define FUNC_PTR_FORM(WORD) WORD,
static state_FPtr state_functions[] = {DCDC_STATES(FUNC_PTR_FORM)};

/******************************************************************************
 * State Variables
 *******************************************************************************/
static uint8_t dcdcRun = 0;
static DCDC_states_E prevState = off_state;
static DCDC_states_E curState = off_state;
static DCDC_states_E nextState = off_state;
NEW_LOW_PASS_FILTER(dcdc_voltage, 10.0, 1000.0);
NEW_LOW_PASS_FILTER(dcdc_current, 10.0, 1000.0);
NEW_LOW_PASS_FILTER(vbus_voltage, 10.0, 1000.0);
NEW_TIMER(precharge_timer,3000);
NEW_TIMER(gateDriveChargeTimer, 400);

/******************************************************************************
 * Internal Variables
 *******************************************************************************/
static uint8_t dcdcCommandFromMcu = 0;

/******************************************************************************
 * Public Functions
 *******************************************************************************/
void DCDC_Init(void) {
    dcdcRun = 1;
    prevState = off_state;
    curState = off_state;
    nextState = off_state;
}

void DCDC_Run_1ms(void) {
    if (dcdcRun) {
        takeLowPassFilter(dcdc_voltage, IO_GET_DCDC_OUTPUT_VOLTAGE());
        takeLowPassFilter(dcdc_current, IO_GET_DCDC_CURRENT());
        takeLowPassFilter(vbus_voltage, IO_GET_VBUS_VOLTAGE());
    }
}

void DCDC_Run_100ms(void) {
    dcdcCommandFromMcu = CAN_mcu_command_DCDC_enable_get();
    if (dcdcRun) {
        // Check for state transitions
        if (nextState != curState) {
            // Exit current state
            state_functions[curState](EXIT);
            
            // Update state variables
            prevState = curState;
            curState = nextState;
            
            // Enter new state
            state_functions[curState](ENTRY);
        } else {
            // Run current state
            state_functions[curState](RUN);
        }
    }
}

void DCDC_Halt(void) {
    dcdcRun = 0;
    nextState = off_state;
    curState = off_state;
    prevState = off_state;
    IO_SET_DCDC_EN(LOW);
    IO_SET_PRE_CHARGE_EN(LOW);
    clearLowPassFilter(dcdc_voltage);
    clearLowPassFilter(dcdc_current);
    clearLowPassFilter(vbus_voltage);
}

void DCDC_Run(void){
    dcdcRun = 1;
}

DCDC_state_E DCDC_GetState(void){
    return (DCDC_state_E)curState;
}

float DCDC_GetVoltage(void){
    return getLowPassFilter(dcdc_voltage);
}

float DCDC_GetCurrent(void){
    return getLowPassFilter(dcdc_current);
}

/******************************************************************************
 * State Functions
 *******************************************************************************/
static void off(DCDC_entry_types_E entry_type) {
    
    switch (entry_type) {
        case ENTRY:
            IO_SET_DCDC_EN(LOW);
            IO_SET_PRE_CHARGE_EN(LOW);
            break;
            
        case RUN:
            if ((dcdcCommandFromMcu == true) && (IO_GET_SW_EN() == true)) {
                nextState = precharge_state;
            }
            break;
            
        case EXIT:
            break;
            
        default:
            break;
    }
}

static void precharge(DCDC_entry_types_E entry_type) {
    
    switch (entry_type) {
        case ENTRY:
            IO_SET_PRE_CHARGE_EN(HIGH);
            SysTick_TimerStart(precharge_timer);
            SysTick_TimerStart(gateDriveChargeTimer);
            break;
            
        case RUN:
            if ((getLowPassFilter(dcdc_voltage) > getLowPassFilter(vbus_voltage) * 0.90)
                && (SysTick_TimeOut(gateDriveChargeTimer))) {
                nextState = enable_state;
            }
            else if (dcdcCommandFromMcu == 0) {
                nextState = off_state;
            }
            else if (SysTick_TimeOut(precharge_timer)) {
                nextState = fault_state;
            }
            break;
            
        case EXIT:
            IO_SET_PRE_CHARGE_EN(LOW);
            break;
            
        default:
            break;
    }
}

static void enable(DCDC_entry_types_E entry_type) {

    switch (entry_type) {
        case ENTRY:
            IO_SET_DCDC_EN(HIGH);
            break;
            
        case RUN:
            if (IO_GET_DCDC_FAULT()) {
                nextState = fault_state;
            }
            else if (getLowPassFilter(dcdc_voltage) < getLowPassFilter(vbus_voltage) * 0.90) {
                nextState = fault_state;
            }
            else if (dcdcCommandFromMcu == 0) {
                nextState = off_state;
            }
            break;
            
        case EXIT:
            IO_SET_DCDC_EN(LOW);
            break;
            
        default:
            break;
    }
}

static void fault(DCDC_entry_types_E entry_type) {
    
    switch (entry_type) {
        case ENTRY:
            IO_SET_DCDC_EN(LOW);
            IO_SET_PRE_CHARGE_EN(LOW);
            break;
            
        case RUN:
                CAN_bms_debug_bool0_set(1);
            // if (dcdcCommandFromMcu == 0) {
            //     nextState = off_state;
            // }
            break;
            
        case EXIT:
            break;
            
        default:
            break;
    }
}