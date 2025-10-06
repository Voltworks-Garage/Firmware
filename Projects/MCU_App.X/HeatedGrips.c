/******************************************************************************
 * Includes
 *******************************************************************************/
#include "HeatedGrips.h"
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
#define HEATED_GRIPS_CONTROL_STATES(state)\
state(heated_grips_idle)\
state(heated_grips_low)\
state(heated_grips_medium)\
state(heated_grips_high)\

#define STATE_FORM(WORD) WORD##_state,
#define FUNCTION_FORM(WORD) static void WORD(HEATED_GRIPS_CONTROL_entry_types_E entry_type);
#define FUNC_PTR_FORM(WORD) WORD,

/******************************************************************************
 * Configuration
 *******************************************************************************/

/******************************************************************************
 * Typedefs
 *******************************************************************************/
typedef enum {
    HEATED_GRIPS_CONTROL_STATES(STATE_FORM)
    NUMBER_OF_HEATED_GRIPS_STATES
} HEATED_GRIPS_CONTROL_states_E;

typedef enum {
    ENTRY,
    EXIT,
    RUN
} HEATED_GRIPS_CONTROL_entry_types_E;

typedef void(*heatedGripsStatePtr)(HEATED_GRIPS_CONTROL_entry_types_E);

/******************************************************************************
 * Variable Declarations
 *******************************************************************************/
HEATED_GRIPS_CONTROL_STATES(FUNCTION_FORM)
static heatedGripsStatePtr heated_grips_state_functions[] = {HEATED_GRIPS_CONTROL_STATES(FUNC_PTR_FORM)};

static HEATED_GRIPS_CONTROL_states_E heated_grips_prevState = heated_grips_idle_state;
static HEATED_GRIPS_CONTROL_states_E heated_grips_curState = heated_grips_idle_state;
static HEATED_GRIPS_CONTROL_states_E heated_grips_nextState = heated_grips_idle_state;

static bool heatedGripsEnabled = false;


#define HEATED_GRIPS_LOW_PWM_DUTY 33
#define HEATED_GRIPS_MEDIUM_PWM_DUTY 66
#define HEATED_GRIPS_HIGH_PWM_DUTY 100

static uint32_t pwmDutyCycle = 0;

#define PWM_PERIOD_MS 3000
NEW_TIMER(pwmPeriod, PWM_PERIOD_MS);
NEW_TIMER(pwmDuty, 0);
/******************************************************************************
 * Function Prototypes
 *******************************************************************************/
static void updateHeatedGripsPWM(void);

/******************************************************************************
 * Function Definitions
 *******************************************************************************/

void HeatedGripControl_Init(void) {
    IO_SET_HEATED_GRIPS_EN(LOW);
    IO_SET_HEATED_SEAT_EN(LOW);
    heatedGripsEnabled = true;
    heated_grips_curState = heated_grips_idle_state;
    heated_grips_prevState = heated_grips_idle_state;
    heated_grips_nextState = heated_grips_idle_state;
    heated_grips_state_functions[heated_grips_curState](ENTRY);
    SysTick_TimerStart(pwmPeriod);
}

void HeatedGripControl_Run_100ms(void) {
    if (!heatedGripsEnabled) {
        return;
    }

    if (heated_grips_nextState != heated_grips_curState) {
        heated_grips_state_functions[heated_grips_curState](EXIT);
        heated_grips_prevState = heated_grips_curState;
        heated_grips_curState = heated_grips_nextState;
        heated_grips_state_functions[heated_grips_curState](ENTRY);
    }
    
    heated_grips_state_functions[heated_grips_curState](RUN);
    
    updateHeatedGripsPWM();
}

void HeatedGripControl_Halt(void) {
    heated_grips_state_functions[heated_grips_curState](EXIT);
    IO_SET_HEATED_GRIPS_EN(LOW);
    IO_SET_HEATED_SEAT_EN(LOW);
    heatedGripsEnabled = false;
}

void heated_grips_idle(HEATED_GRIPS_CONTROL_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            pwmDutyCycle = 0;
            break;
        case EXIT:
            break;
        case RUN:
            if (IgnitionControl_GetAssButtonEvent() == BUTTON_WAS_PRESSED) {
                heated_grips_nextState = heated_grips_low_state;
            }
            break;
        default:
            break;
    }
}

void heated_grips_low(HEATED_GRIPS_CONTROL_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            pwmDutyCycle = HEATED_GRIPS_LOW_PWM_DUTY;
            break;
        case EXIT:
            break;
        case RUN:
            if (IgnitionControl_GetAssButtonEvent() == BUTTON_WAS_PRESSED) {
                 heated_grips_nextState = heated_grips_medium_state;
            }
            break;
        default:
            break;
    }
}

void heated_grips_medium(HEATED_GRIPS_CONTROL_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            pwmDutyCycle = HEATED_GRIPS_MEDIUM_PWM_DUTY;
            break;
        case EXIT:
            break;
        case RUN:
            if (IgnitionControl_GetAssButtonEvent() == BUTTON_WAS_PRESSED) {
                heated_grips_nextState = heated_grips_high_state;
            }
            break;
        default:
            break;
    }
}

void heated_grips_high(HEATED_GRIPS_CONTROL_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            pwmDutyCycle = HEATED_GRIPS_HIGH_PWM_DUTY;
            break;
        case EXIT:
            break;
        case RUN:
            if (IgnitionControl_GetAssButtonEvent() == BUTTON_WAS_PRESSED) {
                heated_grips_nextState = heated_grips_idle_state;
            }
            break;
        default:
            break;
    }
}

static void updateHeatedGripsPWM(void) {
    if(SysTick_TimeOut(pwmPeriod)){
        SysTick_TimerUpdate(pwmDuty, pwmDutyCycle * PWM_PERIOD_MS / 100);
        SysTick_TimerStart(pwmDuty);
        SysTick_TimerStart(pwmPeriod);
        if(pwmDutyCycle > 0){
            IO_SET_HEATED_GRIPS_EN(HIGH);
            IO_SET_HEATED_SEAT_EN(HIGH);
        }
    } else if (SysTick_TimeOut(pwmDuty)) {
        IO_SET_HEATED_GRIPS_EN(LOW);
        IO_SET_HEATED_SEAT_EN(LOW);
    }

}

/*** End of File **************************************************************/





