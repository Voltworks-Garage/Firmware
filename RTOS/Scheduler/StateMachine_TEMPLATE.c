/******************************************************************************
 * Includes
 *******************************************************************************/
#include "StateMachine_TEMPLATE.h"
// #include "IO.h"
// #include "SysTick.h"

#include <stdint.h>
#include <stdbool.h>

/******************************************************************************
 * Constants
 *******************************************************************************/

/******************************************************************************
 * Macros
 *******************************************************************************/
#define TEMPLATE_STATES(state)\
state(template_idle)\
state(template_active)\

#define STATE_FORM(WORD) WORD##_state,
#define FUNCTION_FORM(WORD) static void WORD(TEMPLATE_entry_types_E entry_type);
#define FUNC_PTR_FORM(WORD) WORD,

/******************************************************************************
 * Configuration
 *******************************************************************************/

/******************************************************************************
 * Typedefs
 *******************************************************************************/
typedef enum {
    TEMPLATE_STATES(STATE_FORM)
    NUMBER_OF_TEMPLATE_STATES
} TEMPLATE_states_E;

typedef enum {
    ENTRY,
    EXIT,
    RUN
} TEMPLATE_entry_types_E;

typedef void(*templateStatePtr)(TEMPLATE_entry_types_E);

/******************************************************************************
 * Variable Declarations
 *******************************************************************************/
TEMPLATE_STATES(FUNCTION_FORM)
static templateStatePtr template_state_functions[] = {TEMPLATE_STATES(FUNC_PTR_FORM)};

static TEMPLATE_states_E template_prevState = template_idle_state;
static TEMPLATE_states_E template_curState = template_idle_state;
static TEMPLATE_states_E template_nextState = template_idle_state;

static bool templateEnabled = false;

// Example timer declaration (uncomment if needed)
// #define TEMPLATE_TIMEOUT 1000
// NEW_TIMER(templateTimer, TEMPLATE_TIMEOUT);

/******************************************************************************
 * Function Prototypes
 *******************************************************************************/

/******************************************************************************
 * Function Definitions
 *******************************************************************************/

void Template_Init(void) {
    // Initialize hardware/peripherals here

    templateEnabled = true;
    template_curState = template_idle_state;
    template_prevState = template_idle_state;
    template_nextState = template_idle_state;
    template_state_functions[template_curState](ENTRY);
}

void Template_Run_10ms(void) {
    if (!templateEnabled) {
        return;
    }

    if (template_nextState != template_curState) {
        template_state_functions[template_curState](EXIT);
        template_prevState = template_curState;
        template_curState = template_nextState;
        template_state_functions[template_curState](ENTRY);
    }

    template_state_functions[template_curState](RUN);
}

void Template_Halt(void) {
    template_state_functions[template_curState](EXIT);
    // Clean up hardware/peripherals here
    templateEnabled = false;
}

void template_idle(TEMPLATE_entry_types_E entry_type) {
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
            //     template_nextState = template_active_state;
            // }
            break;
        default:
            break;
    }
}

void template_active(TEMPLATE_entry_types_E entry_type) {
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
            //     template_nextState = template_idle_state;
            // }
            break;
        default:
            break;
    }
}

/*** End of File **************************************************************/
