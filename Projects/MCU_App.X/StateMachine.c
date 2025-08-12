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


/******************************************************************************
 * Constants
 *******************************************************************************/

/******************************************************************************
 * Macros
 *******************************************************************************/

#define STATE_MACHINE_STATES(state)\
state(idle)\
state(standby)\
state(silent_wake)\
state(running)\
state(charging)\
state(sleep)\

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

static STATE_MACHINE_states_E sm_prevState = idle_state; /* initialize previous state */
static STATE_MACHINE_states_E sm_curState = idle_state; /* initialize current state */
static STATE_MACHINE_states_E sm_nextState = idle_state; /* initialize next state */

uint8_t sm_keepAwakeFlag = 0;

NEW_TIMER(idleTimer, 10000);
NEW_TIMER(SwEnTimer, 1);

/******************************************************************************
 * Function Prototypes
 *******************************************************************************/

/******************************************************************************
 * Function Definitions
 *******************************************************************************/
void StateMachine_Init(void) {
    state_functions[sm_curState](ENTRY);
}

void StateMachine_Run(void) {
    
    // switch(isoTP_getCommand().command){
    //     case ISO_TP_NONE:
    //         sm_keepAwakeFlag = 0;
    //         break;
    //     case ISO_TP_RESET:
    //         CAN_changeOpMode(CAN_DISABLE);
    //         asm ("reset");
    //         break;
    //     case ISO_TP_SLEEP:
    //         sm_nextState = standby_state;
    //         break;
    //     case ISO_TP_IO_CONTROL:
    //         sm_keepAwakeFlag = 1;
    //         break;
    //     case ISO_TP_TESTER_PRESENT:
    //         sm_keepAwakeFlag = 1;
    //         break;
    //     default:
    //         break;
    // }
    
    //If the kill switch is pressed, go straight to sleep. Regardless of state.
//    switch(IgnitionControl_GetKillStatus()){
//        case BUTTON_PRESSED:
//        case BUTTON_HELD:
//            sm_nextState = sleep_state;
//        default:
//            break;
//    }
                
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

void idle(STATE_MACHINE_entry_types_E entry_type) {


    switch (entry_type) {
        case ENTRY:
            SysTick_TimerStart(idleTimer);
            SysTick_TimerStart(SwEnTimer);
            IO_SET_BATT_EN(LOW); //TODO: check this enable sequence
            IO_SET_DCDC_EN(LOW);

            //Initialize the board.
            IO_SET_SW_EN(HIGH);
            IO_SET_IC_CONTROLLER_SLEEP_EN(LOW);
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

            break;

        case EXIT:
            break;

        case RUN:

            // TODO: why is this here?
            if (SysTick_TimeOut(SwEnTimer)) {
                IO_SET_BATT_EN(HIGH); //TODO: check this enable sequence
                IO_SET_DCDC_EN(HIGH);
                IO_SET_BMS_CONTROLLER_EN(HIGH);
            }
            // If any sm_keepAwakeFlag reason is set, just reset the timer.
            if(sm_keepAwakeFlag){
                SysTick_TimerStart(idleTimer);
            }
            // Once the timer expires, go to standby and prepare for sleep.
            if (SysTick_TimeOut(idleTimer)) {
                sm_nextState = standby_state;
            }
            // Connection of charged triggers charging
            if (j1772getProxState() == J1772_CONNECTED) {
                sm_nextState = charging_state;
            }
            //If the kill switch is pressed, go straight to sleep. Regardless of state.
            if (IgnitionControl_GetKillStatus() == BUTTON_PRESSED || IgnitionControl_GetKillStatus() == BUTTON_HELD) {
                sm_nextState = sleep_state;
            }

            break;

        default:
            break;
    }

}

void standby(STATE_MACHINE_entry_types_E entry_type) {
    NEW_TIMER(quietTimer, 3000);
    NEW_TIMER(standbyTimer, 6000);
    switch (entry_type) {
        case ENTRY:
            SysTick_TimerStart(quietTimer);
            SysTick_TimerStart(standbyTimer);
            CAN_changeOpMode(CAN_LISTEN);
            IO_SET_BMS_CONTROLLER_EN(LOW);
            break;
        case EXIT:
            break;
        case RUN:
            // Allow for time for CAN to go quiet on the bus.
            if (CAN_RxDataIsReady() && SysTick_TimeOut(quietTimer)) {
                sm_nextState = idle_state;
            }
            // If can goes quiet and we hit this timer, actually go to sleep.
            if (SysTick_TimeOut(standbyTimer)) {
                sm_nextState = sleep_state;
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
            IO_SET_DEBUG_LED_EN(HIGH);
            break;
        case EXIT:
            IO_SET_DEBUG_LED_EN(LOW);
            break;
        case RUN:
            switch (LvBattery_GetState()) {
                case LV_BATTERY_NOMINAL:
                    //Just go back to sleep if nominal.
                    sm_nextState = sleep_state;
                    break;
                case LV_BATTERY_CHARGE_NEEDED:
                    //Charge is needed so lets wake up.
                    IO_SET_BMS_CONTROLLER_EN(HIGH);
                    IO_SET_DCDC_EN(HIGH);
                    IO_SET_BATT_EN(HIGH);
                    CAN_changeOpMode(CAN_NORMAL);
                    break;
                case LV_BATTERY_CHARGING:
                    //Look for wake inputs here...
                    break;
                case LV_BATTERY_CHARGED:
                    //Once charged, go quiet and back to sleep.
                    CAN_changeOpMode(CAN_LISTEN);
                    IO_SET_BMS_CONTROLLER_EN(LOW);
                    IO_SET_DCDC_EN(LOW);
                    IO_SET_BATT_EN(LOW);
                    IO_SET_SW_EN(LOW);
                    LvBattery_Halt();
                    sm_nextState = sleep_state;
                    break;
                default:
                    break;
            }

            if (CAN_RxDataIsReady()) {
                sm_nextState = idle_state;
            }
            
            //If the kill switch is pressed, go straight to sleep. Regardless of state.
            if (IgnitionControl_GetKillStatus() == BUTTON_PRESSED || IgnitionControl_GetKillStatus() == BUTTON_HELD) {
                sm_nextState = sleep_state;
            }
            sm_nextState = idle_state;
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
            sm_nextState = idle_state;
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

void sleep(STATE_MACHINE_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            IO_SET_SW_EN(LOW);
            IO_SET_IC_CONTROLLER_SLEEP_EN(HIGH);
            IO_SET_BMS_CONTROLLER_EN(LOW);
            IO_SET_DCDC_EN(LOW);
            CAN_changeOpMode(CAN_DISABLE);
            IO_SET_CAN_SLEEP_EN(HIGH);
            IO_SET_DEBUG_LED_EN(LOW);

            //stop all apps
            IO_Efuse_Halt();
            LightsControl_Halt();
            HeatedGripControl_Halt();
            HornControl_Halt();
            j1772Control_Halt();
            IgnitionControl_Halt();
            LvBattery_Halt();
            break;

        case EXIT:
            IO_SET_SW_EN(HIGH);
            break;
        case RUN:
            SysTick_Stop();
            RCONbits.SWDTEN = 0;
            SleepNow(); //Go to sleep
            asm ("reset");
            RCONbits.SWDTEN = 1;
            SysTick_Resume();
            if (RCONbits.WDTO) {
                sm_nextState = silent_wake_state;
            } else {
                sm_nextState = idle_state;
            }

            break;
        default:
            break;
    }
}

/****Helpers*******************************************************************/


/*** End of File **************************************************************/




