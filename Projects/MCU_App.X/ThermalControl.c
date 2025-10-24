/******************************************************************************
 * Includes
 *******************************************************************************/
#include "ThermalControl.h"
#include "IO.h"
#include "pinSetup.h"
#include "SysTick.h"

#include <stdint.h>
#include <stdbool.h>

/******************************************************************************
 * Constants
 *******************************************************************************/

/******************************************************************************
 * Macros
 *******************************************************************************/
#define THERMAL_CONTROL_STATES(state)\
state(thermal_idle)\
state(thermal_active)\

#define STATE_FORM(WORD) WORD##_state,
#define FUNCTION_FORM(WORD) static void WORD(THERMAL_CONTROL_entry_types_E entry_type);
#define FUNC_PTR_FORM(WORD) WORD,

/******************************************************************************
 * Configuration
 *******************************************************************************/

/******************************************************************************
 * Typedefs
 *******************************************************************************/
typedef enum {
    THERMAL_CONTROL_STATES(STATE_FORM)
    NUMBER_OF_THERMAL_STATES
} THERMAL_CONTROL_states_E;

typedef enum {
    ENTRY,
    EXIT,
    RUN
} THERMAL_CONTROL_entry_types_E;

typedef void(*thermalStatePtr)(THERMAL_CONTROL_entry_types_E);

/******************************************************************************
 * Variable Declarations
 *******************************************************************************/
THERMAL_CONTROL_STATES(FUNCTION_FORM)
static thermalStatePtr thermal_state_functions[] = {THERMAL_CONTROL_STATES(FUNC_PTR_FORM)};

static THERMAL_CONTROL_states_E thermal_prevState = thermal_idle_state;
static THERMAL_CONTROL_states_E thermal_curState = thermal_idle_state;
static THERMAL_CONTROL_states_E thermal_nextState = thermal_idle_state;

static bool thermalEnabled = false;

// Example timer declaration (uncomment if needed)
// #define THERMAL_TIMEOUT 1000
// NEW_TIMER(thermalTimer, THERMAL_TIMEOUT);

/******************************************************************************
 * Function Prototypes
 *******************************************************************************/

/******************************************************************************
 * Function Definitions
 *******************************************************************************/

void ThermalControl_Init(void) {
    // Initialize hardware/peripherals here

    thermalEnabled = true;
    thermal_curState = thermal_idle_state;
    thermal_prevState = thermal_idle_state;
    thermal_nextState = thermal_idle_state;
    thermal_state_functions[thermal_curState](ENTRY);
}

void ThermalControl_Run_10ms(void) {
    if (!thermalEnabled) {
        return;
    }

    if (thermal_nextState != thermal_curState) {
        thermal_state_functions[thermal_curState](EXIT);
        thermal_prevState = thermal_curState;
        thermal_curState = thermal_nextState;
        thermal_state_functions[thermal_curState](ENTRY);
    }

    thermal_state_functions[thermal_curState](RUN);
}

void ThermalControl_Halt(void) {
    thermal_state_functions[thermal_curState](EXIT);
    // Clean up hardware/peripherals here
    thermalEnabled = false;
}

void thermal_idle(THERMAL_CONTROL_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:

            // Entry actions here
            break;
        case EXIT:
            IO_SET_FAN_1_EN(LOW);
            IO_SET_PUMP_1_EN(LOW);
            pwmOCwriteDuty(FAN_PWM_OUT, 25); // 5% duty cycle
            pwmOCwriteDuty(PUMP_PWM_OUT, 50); // 5% duty cycle
            // Exit actions here
            break;
        case RUN:
            IO_SET_FAN_1_EN(HIGH);
            IO_SET_PUMP_1_EN(HIGH);
            pwmOCwriteDuty(FAN_PWM_OUT, 25); // 5% duty cycle
            pwmOCwriteDuty(PUMP_PWM_OUT, 50); // 5% duty cycle
            // Run actions here
            // Example state transition:
            // if (some_condition) {
            //     thermal_nextState = thermal_active_state;
            // }
            break;
        default:
            break;
    }
}

void thermal_active(THERMAL_CONTROL_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            // Entry actions here
            break;
        case EXIT:
            // Exit actions here
            break;
        case RUN:
            // Run actions here
            // Example state transition:
            // if (some_condition) {
            //     thermal_nextState = thermal_idle_state;
            // }
            break;
        default:
            break;
    }
}

/*** End of File **************************************************************/
