/******************************************************************************
 * Includes
 *******************************************************************************/
#include "SysTick.h"
#include "IO.h"
#include "CAN.h"
#include "bms_dbc.h"
#include "pinSetup.h"
#include "sleep.h"
#include "dcdc.h"
#include "can_iso_tp_lite.h"
#include "watchdog.h"
#include "Events.h"


/******************************************************************************
 * Constants
 *******************************************************************************/

/******************************************************************************
 * Macros
 *******************************************************************************/

#define STATE_MACHINE_STATES(state)\
state(idle) /* init state for startup code */ \
state(standby)\
state(running)\
state(charging)\
state(sleep)\
state(diag)\

/*Creates an enum of states suffixed with _state*/
#define STATE_FORM(WORD) WORD##_state,
#define FUNCTION_FORM(WORD) static void WORD(STATE_MACHINE_entry_types_E entry_type);
#define FUNC_PTR_FORM(WORD) WORD,


/******************************************************************************
 * Configuration
 *******************************************************************************/

/******************************************************************************
 * Typedefs
 *******************************************************************************/
typedef enum {
    STATE_MACHINE_STATES(STATE_FORM)
    NUMBER_OF_STATES
} STATE_MACHINE_states_E;

typedef enum {
    ENTRY,
    EXIT,
    RUN
} STATE_MACHINE_entry_types_E;

typedef void(*statePtr)(STATE_MACHINE_entry_types_E);

/******************************************************************************
 * Variable Declarations
 *******************************************************************************/
/*State variables*/
/* function-ifies the state list*/
STATE_MACHINE_STATES(FUNCTION_FORM)
static statePtr state_functions[] = {STATE_MACHINE_STATES(FUNC_PTR_FORM)};

static STATE_MACHINE_states_E prevState = 0; /* initialize previous state */
static STATE_MACHINE_states_E curState = 0; /* initialize current state */
static STATE_MACHINE_states_E nextState = standby_state; /* initialize current state */

uint64_t my_64_bit_word = 0;

NEW_TIMER(diag_timeout, 1000);

/******************************************************************************
 * Function Prototypes
 *******************************************************************************/
void halt_all_tasks(void);
void resume_all_tasks(void);
/******************************************************************************
 * Function Definitions
 *******************************************************************************/
void StateMachine_Init(void) {
    DCDC_init();
}

void StateMachine_Run(void) {
    
    CAN_bms_debug_float1_set(curState);
    /* This only happens during state transition
     * State transitions thus have priority over posting new events
     * State transitions always consist of an exit event to curState and entry event to nextState */
    if (nextState != curState) {
        state_functions[curState](EXIT);
        prevState = curState;
        curState = nextState;
        state_functions[curState](ENTRY);
    }
    
    state_functions[curState](RUN);

}

void idle(STATE_MACHINE_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            IO_SET_SW_EN(HIGH);
            CAN_changeOpMode(CAN_NORMAL);
            DCDC_init();
            break;
        case EXIT:
            break;
        case RUN:
            if (isoTP_peekCommand() == ISO_TP_TESTER_PRESENT){
                nextState = diag_state;
            }
            if (isoTP_peekCommand() == ISO_TP_IO_CONTROL){
                nextState = diag_state;
            }
            if (IO_GET_V12_POWER_STATUS() == 0) {
                nextState = standby_state;
            }
            break;
        default:
            break;
    }

}

void standby(STATE_MACHINE_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            CAN_changeOpMode(CAN_DISABLE);
            IO_SET_SW_EN(LOW);
            break;
        case EXIT:
            break;
        case RUN:
            if (IO_GET_V12_POWER_STATUS()) {
                nextState = idle_state;
            } else {
                nextState = sleep_state;
            }
            break;
        default:
            break;
    }
}

void running(STATE_MACHINE_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:

            break;
        case EXIT:
            break;
        case RUN:

            break;
        default:
            break;
    }
}

void charging(STATE_MACHINE_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            break;
        case EXIT:
            break;
        case RUN:
            break;
        default:
            break;
    }
}

void sleep(STATE_MACHINE_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            halt_all_tasks();
            IO_SET_DEBUG_LED_EN(LOW);
            break;
        case EXIT:
            resume_all_tasks();
            break;
        case RUN:
            SysTick_Stop();
            WATCHDOG_TimerSoftwareDisable();
            SleepNow(); //Go to sleep
            WATCHDOG_TimerSoftwareEnable();
            WATCHDOG_TimerClear();
            SysTick_Resume();
            nextState = idle_state;
            break;
        default:
            break;
    }
}

void diag(STATE_MACHINE_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            halt_all_tasks();
            SysTick_TimerStart(diag_timeout);
            break;
        case EXIT:
            break;
        case RUN:
            IO_SET_DEBUG_LED_EN(!IO_GET_DEBUG_LED_EN());
            if (isoTP_peekCommand() != ISO_TP_NONE){
                SysTick_TimerStart(diag_timeout);
            }
            if(SysTick_TimeOut(diag_timeout)){
                nextState = idle_state;
            }
            break;
        default:
            break;
    }
}

/****Helpers*******************************************************************/
void halt_all_tasks(void){
    DCDC_halt();
}

void resume_all_tasks(void){
    DCDC_run();
}

/*** End of File **************************************************************/




