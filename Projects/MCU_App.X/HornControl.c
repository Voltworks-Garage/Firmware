/******************************************************************************
 * Includes
 *******************************************************************************/
#include "HornControl.h"
#include "IO.h"
#include "IgnitionControl.h"
#include "SysTick.h"

#include <stdint.h>
#include <stdbool.h>

/******************************************************************************
 * Constants
 *******************************************************************************/

/******************************************************************************
 * Macros
 *******************************************************************************/
#define HORN_CONTROL_STATES(state)\
state(horn_idle)\
state(horn_active)\
state(horn_timeout)\

#define STATE_FORM(WORD) WORD##_state,
#define FUNCTION_FORM(WORD) static void WORD(HORN_CONTROL_entry_types_E entry_type);
#define FUNC_PTR_FORM(WORD) WORD,

/******************************************************************************
 * Configuration
 *******************************************************************************/

/******************************************************************************
 * Typedefs
 *******************************************************************************/
typedef enum {
    HORN_CONTROL_STATES(STATE_FORM)
    NUMBER_OF_HORN_STATES
} HORN_CONTROL_states_E;

typedef enum {
    ENTRY,
    EXIT,
    RUN
} HORN_CONTROL_entry_types_E;

typedef void(*hornStatePtr)(HORN_CONTROL_entry_types_E);

/******************************************************************************
 * Variable Declarations
 *******************************************************************************/
HORN_CONTROL_STATES(FUNCTION_FORM)
static hornStatePtr horn_state_functions[] = {HORN_CONTROL_STATES(FUNC_PTR_FORM)};

static HORN_CONTROL_states_E horn_prevState = horn_idle_state;
static HORN_CONTROL_states_E horn_curState = horn_idle_state;
static HORN_CONTROL_states_E horn_nextState = horn_idle_state;

static bool hornEnabled = false; // Flag to indicate if the horn is enabled

#define HORN_MAX_TIME 5000 
NEW_TIMER(hornTimer, HORN_MAX_TIME);
/******************************************************************************
 * Function Prototypes
 *******************************************************************************/

/******************************************************************************
 * Function Definitions
 *******************************************************************************/

void HornControl_Init(void) {
    IO_SET_HORN_EN(LOW);
    hornEnabled = true; // Enable the horn control
    horn_curState = horn_idle_state;
    horn_prevState = horn_idle_state;
    horn_nextState = horn_idle_state;
    horn_state_functions[horn_curState](ENTRY);
}

void HornControl_Run_10ms(void) {
    if (!hornEnabled) {
        return;
    }

    if (horn_nextState != horn_curState) {
        horn_state_functions[horn_curState](EXIT);
        horn_prevState = horn_curState;
        horn_curState = horn_nextState;
        horn_state_functions[horn_curState](ENTRY);
    }
    
    horn_state_functions[horn_curState](RUN);
}

void HornControl_Halt(void) {
    horn_state_functions[horn_curState](EXIT);
    IO_SET_HORN_EN(LOW);
    hornEnabled = false; // Disable the horn control
}

void horn_idle(HORN_CONTROL_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            IO_SET_HORN_EN(LOW);
            break;
        case EXIT:
            break;
        case RUN:
            if (IgnitionControl_GetHornButtonStatus() == BUTTON_PRESSED) {
                horn_nextState = horn_active_state;
            }
            break;
        default:
            break;
    }
}

void horn_active(HORN_CONTROL_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            IO_SET_HORN_EN(HIGH);
            SysTick_TimerStart(hornTimer);
            break;
        case EXIT:
            IO_SET_HORN_EN(LOW);
            break;
        case RUN:
            if (IgnitionControl_GetHornButtonStatus() == BUTTON_RELEASED) {
                horn_nextState = horn_idle_state;
                break;
            }
            if (SysTick_TimeOut(hornTimer)) {
                horn_nextState = horn_timeout_state;
                break;
            }
            break;
        default:
            break;
    }
}

void horn_timeout(HORN_CONTROL_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            IO_SET_HORN_EN(LOW);
            break;
        case EXIT:
            break;
        case RUN:
            if (IgnitionControl_GetHornButtonStatus() == BUTTON_RELEASED) {
                horn_nextState = horn_idle_state;
                break;
            }
            break;
        default:
            break;
    }
}

/*** End of File **************************************************************/




