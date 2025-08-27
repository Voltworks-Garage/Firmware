/******************************************************************************
 * Includes
 *******************************************************************************/
#include <stdint.h>

#include "StateMachine.h"
#include "CAN.h"
#include "sleep.h"
#include "SysTick.h"

#include "LightsControl.h"
#include "IgnitionControl.h"
#include "HornControl.h"
#include "HeatedGrips.h"
#include "j1772.h"
#include "IO.h"
#include "mcu_dbc.h"
#include "button.h"
#include "lvBattery.h"
#include "can_iso_tp_lite.h"
#include "mcc_generated_files/watchdog.h"
#include "CommandService.h"
#include "tachometer.h"


/******************************************************************************
 * Constants
 *******************************************************************************/

/******************************************************************************
 * Macros
 *******************************************************************************/

#define STATE_MACHINE_STATES(state)\
state(boot)\
state(idle)\
state(silent_wake)\
state(running)\
state(charging)\
state(goingToSleep)\
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

static STATE_MACHINE_states_E sm_prevState = boot_state; /* initialize previous state */
static STATE_MACHINE_states_E sm_curState = boot_state; /* initialize current state */
static STATE_MACHINE_states_E sm_nextState = boot_state; /* initialize next state */

uint8_t sm_keepAwakeFlag = 0;

NEW_TIMER(idleTimer, 60000);
NEW_TIMER(SwEnTimer, 1);
NEW_TIMER(diagTimer, 10*60000); //10 minute diag timer.
NEW_TIMER(tachTimer, 1500);

static uint8_t tach = 0;

/******************************************************************************
 * Function Prototypes
 *******************************************************************************/
void halt_all_tasks(void);
void resume_all_tasks(void);
/******************************************************************************
 * Function Definitions
 *******************************************************************************/
void StateMachine_Init(void) {
    state_functions[sm_curState](ENTRY);
}

void StateMachine_Run(void) {

    if(CAN_motorcontroller_SYNC_checkDataIsUnread()){
        CAN_mcu_motorControllerRequest_send();
    }

    CAN_mcu_status_vehicleState_set(sm_curState);
                
    /* This only happens during state transition
     * State transitions thus have priority over posting new events
     * State transitions always consist of an exit event to sm_curState and entry event to sm_nextState */
    if (sm_nextState != sm_curState) {
        state_functions[sm_curState](EXIT);
        sm_prevState = sm_curState;
        sm_curState = sm_nextState;
        state_functions[sm_curState](ENTRY);
    }
            
    state_functions[sm_curState](RUN);
}

void boot(STATE_MACHINE_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            //Initialize the board.
            IO_SET_SW_EN(HIGH);
            CAN_changeOpMode(CAN_NORMAL);
            IO_SET_CAN_SLEEP_EN(LOW);

            //Initialize each application.
            IgnitionControl_Init();
            IO_Efuse_Init();
            LightsControl_Init();
            HeatedGripControl_Init();
            HornControl_Init();
            j1772Control_Init();
            LvBattery_Init();
            tachometer_init();
        

            //Get HV support ready.
            IO_SET_BMS_CONTROLLER_EN(HIGH);

            break;
        case EXIT:
            break;
        case RUN:

                sm_nextState = idle_state;

        default:
            break;
        }
    }

void idle(STATE_MACHINE_entry_types_E entry_type) {


    switch (entry_type) {
        case ENTRY:
            SysTick_TimerStart(idleTimer);
            SysTick_TimerStart(tachTimer);
            tachometer_set_percent(100);
            break;

        case EXIT:
            break;

        case RUN:
            // If any sm_keepAwakeFlag reason is set, just reset the timer.
            if(sm_keepAwakeFlag){
                SysTick_TimerStart(idleTimer);
            }
            // Once the timer expires, go to goingToSleep and prepare for sleep.
            if (SysTick_TimeOut(idleTimer)) {
                sm_nextState = goingToSleep_state;
            }
            // Connection of charged triggers charging
            if (j1772getProxState() == J1772_CONNECTED) {
                sm_nextState = charging_state;
            }
            switch (CommandService_GetEvent()) {
                case COMMAND_SERVICE_TYPE_TESTER_PRESENT:
                case COMMAND_SERVICE_TYPE_IO_CONTROL:
                    sm_nextState = diag_state;
                    break;
                case COMMAND_SERVICE_TYPE_SLEEP:
                    sm_nextState = goingToSleep_state;
                    break;
                default:
                    break;
            }

            // If the kill switch is pressed, go to goingToSleep and prepare for sleep.
            if (IgnitionControl_GetKillSwitchStatus() == BUTTON_PRESSED) {
                sm_nextState = goingToSleep_state;
            }

            // If the start button is held, go to running state.
            // Clear the hold flag to prevent re-entry.
            if (IgnitionControl_GetStartButtonIsHeld(true)) {
                sm_nextState = running_state;
            }

            if(SysTick_TimeOut(tachTimer)){
                tachometer_set_percent(0);
                // tach += 10;
                // if(tach > 100) tach = 0;
                // SysTick_TimerStart(tachTimer);
            }

            break;

        default:
            break;
    }

}

void silent_wake(STATE_MACHINE_entry_types_E entry_type) {
    NEW_TIMER(chargeTimer, 10000);
    switch (entry_type) {
        case ENTRY:
            SysTick_TimerStart(chargeTimer);
            IO_SET_SW_EN(HIGH);
            LvBattery_Init();
            break;
        case EXIT:
            break;
        case RUN:
            break;
        default:
            break;
    }
}

void running(STATE_MACHINE_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            IO_SET_HEADLIGHT_LO_EN(HIGH);
            CAN_mcu_command_motor_controller_enable_set(1);
            break;
        case EXIT:
            IO_SET_HEADLIGHT_LO_EN(LOW);
            CAN_mcu_command_motor_controller_enable_set(0);
            CAN_mcu_motorControllerRequest_Throttle_Value_set(0x00);
            break;
        case RUN:
            CAN_mcu_motorControllerRequest_Throttle_Value_set(0xAA);
            // If the start button is held, go to idle state.
            // Clear the hold flag to prevent re-entry.
            if (IgnitionControl_GetStartButtonIsHeld(true)) {
                sm_nextState = idle_state;
            }
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
            CAN_mcu_command_ev_charger_current_set(0);
            CAN_mcu_command_ev_charger_enable_set(0);
            break;
        case RUN:
            switch (j1772getProxState()) {
                case J1772_CONNECTED:
                    CAN_mcu_command_ev_charger_current_set(j1772getPilotCurrent());
                    CAN_mcu_command_ev_charger_enable_set(1);
                    break;
                case J1772_DISCONNECTED:
                case J1772_REQUEST_DISCONNECT:
                case J1772_SNA_PROX:
                default:
                    sm_nextState = idle_state;
                    break;
            }
            break;
        default:
            break;
    }
}

void goingToSleep(STATE_MACHINE_entry_types_E entry_type) {
    NEW_TIMER(quietTimer, 3000);
    NEW_TIMER(goingToSleepTimer, 6000);
    switch (entry_type) {
        case ENTRY:
            SysTick_TimerStart(quietTimer);
            SysTick_TimerStart(goingToSleepTimer);
            CAN_changeOpMode(CAN_LISTEN);
            IO_SET_BMS_CONTROLLER_EN(LOW);
            break;
        case EXIT:
            break;
        case RUN:
            // Allow for time for CAN to go quiet on the bus.
            if (CAN_RxDataIsReady() && SysTick_TimeOut(quietTimer)) {
                sm_nextState = boot_state;
            }
            // If can goes quiet and we hit this timer, actually go to sleep.
            if (SysTick_TimeOut(goingToSleepTimer)) {
                sm_nextState = sleep_state;
            }
            break;
        default:
            break;
    }
}


void sleep(STATE_MACHINE_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:

            //stop all apps
            IO_Efuse_Halt();
            LightsControl_Halt();
            HeatedGripControl_Halt();
            HornControl_Halt();
            j1772Control_Halt();
            IgnitionControl_Halt();
            LvBattery_Halt();

            //shut down external controllers
            IO_SET_IC_CONTROLLER_SLEEP_EN(HIGH);
            IO_SET_BMS_CONTROLLER_EN(LOW);

            //shut down the board
            IO_SET_SW_EN(LOW);
            CAN_changeOpMode(CAN_DISABLE);
            IO_SET_CAN_SLEEP_EN(HIGH);
            IO_SET_DEBUG_LED_EN(LOW);
            break;

        case EXIT:
            IO_SET_SW_EN(HIGH);
            break;
        case RUN:
            SysTick_Stop();
            WATCHDOG_TimerSoftwareDisable();
            SleepNow(); //Go to sleep
            WATCHDOG_TimerClear();
            WATCHDOG_TimerSoftwareEnable();
            SysTick_Resume();
            // if (RCONbits.WDTO) {
            //     sm_nextState = silent_wake_state;
            // } else {
                sm_nextState = boot_state;
            // }

            asm("reset");

            break;
        default:
            break;
    }
}

void diag(STATE_MACHINE_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            SysTick_TimerStart(diagTimer);
            halt_all_tasks();
            break;
        case EXIT:
            resume_all_tasks();
            break;
        case RUN:
            if (SysTick_TimeOut(diagTimer)) {
                sm_nextState = boot_state;
            }
            switch (CommandService_GetEvent()) {
                case COMMAND_SERVICE_TYPE_TESTER_PRESENT:
                    sm_nextState = boot_state;
                    break;
                case COMMAND_SERVICE_TYPE_IO_CONTROL:
                    SysTick_TimerStart(diagTimer);
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
}

/****Helpers*******************************************************************/
void halt_all_tasks(void) {
    LightsControl_Halt();
    HeatedGripControl_Halt();
    HornControl_Halt();
    j1772Control_Halt();
    IgnitionControl_Halt();
    // LvBattery_Halt();
    tachometer_halt();
}
void resume_all_tasks(void) {
    LightsControl_Init();
    HeatedGripControl_Init();
    HornControl_Init();
    j1772Control_Init();
    IgnitionControl_Init();
    // LvBattery_Init();
    tachometer_init();
}

/*** End of File **************************************************************/




