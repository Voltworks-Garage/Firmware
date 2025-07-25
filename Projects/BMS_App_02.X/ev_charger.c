/******************************************************************************
 * Includes
 *******************************************************************************/
#include "ev_charger.h"
#include "SysTick.h"
#include "IO.h"
#include "CAN.h"
#include "bms_dbc.h"

#include <stdio.h>
#include <string.h>

/******************************************************************************
 * Constants
 *******************************************************************************/

/******************************************************************************
 * Macros
 *******************************************************************************/

#define EV_CHARGER_STATES(state)\
state(idle) /* init state for startup code */ \
state(precharging)\
state(negotiating)\
state(charging)\
state(stopping)\

/*Creates an enum of states suffixed with _state*/
#define STATE_FORM(WORD) WORD##_state,
#define FUNCTION_FORM(WORD) static void WORD(EV_CHARGER_entry_types_E entry_type);
#define FUNC_PTR_FORM(WORD) WORD,

#define CHARGER_VOLTAGE_SCALING 10.0
#define CHARGER_CURRENT_SCALING 10.0


/******************************************************************************
 * Configuration
 *******************************************************************************/

/******************************************************************************
 * Typedefs
 *******************************************************************************/
typedef enum {
    EV_CHARGER_STATES(STATE_FORM)
    NUMBER_OF_STATES
} EV_CHARGER_states_E;

typedef enum {
    ENTRY,
    EXIT,
    RUN
} EV_CHARGER_entry_types_E;

typedef void(*statePtr)(EV_CHARGER_entry_types_E);

/******************************************************************************
 * Variable Declarations
 *******************************************************************************/
/*State variables*/
/* function-ifies the state list*/
EV_CHARGER_STATES(FUNCTION_FORM)
static statePtr state_functions[] = {EV_CHARGER_STATES(FUNC_PTR_FORM)};

static EV_CHARGER_states_E prevState = 0; /* initialize previous state */
static EV_CHARGER_states_E curState = 0; /* initialize current state */
static EV_CHARGER_states_E nextState = idle_state; /* initialize current state */

NEW_TIMER(chargerMiaTimer, 1500); /*Timer for state machine*/
NEW_TIMER(precharge_timer, 3000); /*Timer for pre-charge state*/

static uint8_t chargeRequestFromMCU = 0;
static uint8_t chargeRequestFromBMS = 0; //TODO delete this
static uint16_t chargeVoltageTarget = 24 * 4.2 * CHARGER_VOLTAGE_SCALING; //24 cells, 4.2v each, 0.1V/bit
static uint16_t chargeCurrentTarget = 5 * CHARGER_CURRENT_SCALING;

/******************************************************************************
 * Function Prototypes
 *******************************************************************************/
uint8_t checkHeartBeat(void);
uint8_t checkChargerErrors(void);

/******************************************************************************
 * Function Definitions
 *******************************************************************************/
void EV_Charger_Init(void) {
}

void EV_CHARGER_Run_10ms(void) {

    chargeRequestFromMCU = CAN_mcu_command_ev_charger_enable_get();// && checkHeartBeat();

    /* This only happens during state transition
     * State transitions thus have priority over posting new events
     * State transitions always consist of an exit event to curState and entry event to nextState */
    if (nextState != curState) {
        state_functions[curState](EXIT);
        prevState = curState;
        curState = nextState;
        state_functions[curState](ENTRY);
    } else {
        state_functions[curState](RUN);
    }
}

void idle(EV_CHARGER_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            IO_SET_EV_CHARGER_EN(LOW);
            CAN_bms_charger_request_output_voltage_low_byte_set(0);
            CAN_bms_charger_request_output_voltage_high_byte_set(0);
            CAN_bms_charger_request_output_current_low_byte_set(0);
            CAN_bms_charger_request_output_current_high_byte_set(0);
            CAN_bms_charger_request_start_charge_not_request_set(1);
            CAN_bms_charger_request_charge_mode_set(0);
            break;
        case RUN:
            CAN_bms_charger_request_start_charge_not_request_set(1);//inverted logic. 1 means stop charging
            if (!IO_GET_EV_CHARGER_EN()) {
                IO_SET_EV_CHARGER_CALIBRATION();
            }
            if (chargeRequestFromMCU) {
                nextState = negotiating_state;
            }

            break;
        case EXIT:
            break;
        default:
            break;
    }

}

void precharging(EV_CHARGER_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            IO_SET_EV_CHARGER_EN(LOW);
            IO_SET_PRE_CHARGE_EN(HIGH);
            SysTick_TimerStart(precharge_timer);
            break;

        case RUN:
            if (IO_GET_EV_CHARGER_VOLTAGE() > IO_GET_VBUS_VOLTAGE() * 0.9) {
                nextState = negotiating_state;
            }
            if (SysTick_TimeOut(precharge_timer)) {
                // If pre-charge timeout, stop pre-charge
                nextState = idle_state;
            }
            if (chargeRequestFromMCU == 0) {
                // If no charge request, stop pre-charge
                nextState = idle_state;
            }

            break;
        case EXIT:
            IO_SET_PRE_CHARGE_EN(LOW);
            break;
        default:
            break;
    }
}

void negotiating(EV_CHARGER_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            IO_SET_EV_CHARGER_EN(HIGH);
            break;

        case RUN:
            // TODO: Implement negotiation logic
            // For now, just check if we should stop charging
            CAN_bms_charger_request_output_voltage_low_byte_set(chargeVoltageTarget);
            CAN_bms_charger_request_output_voltage_high_byte_set(chargeVoltageTarget>>8);
            CAN_bms_charger_request_output_current_low_byte_set(chargeCurrentTarget);
            CAN_bms_charger_request_output_current_high_byte_set(chargeCurrentTarget>>8);
            CAN_bms_charger_request_charge_mode_set(0); //always set to charing mode, not heating
            CAN_bms_charger_request_start_charge_not_request_set(1);//inverted logic. 1 means stop charging
            if (!chargeRequestFromMCU) {
                nextState = idle_state;
            } else if (!checkChargerErrors()) {
                nextState = charging_state;
            }
            break;

        case EXIT:
            break;
        default:
            break;
    }
}

void charging(EV_CHARGER_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            IO_SET_EV_CHARGER_EN(HIGH);
            CAN_bms_charger_request_start_charge_not_request_set(0);//start charging with inverted logic. 1 means stop charging
            //SysTick_TimerStart(chargerMiaTimer); // Uncomment this when ready to charge with real charger
            break;

        case RUN:
            if (!chargeRequestFromMCU || checkChargerErrors()) {
                nextState = stopping_state;
            }
            if (SysTick_TimeOut(chargerMiaTimer)){
                if (CAN_charger_status_checkDataIsFresh()){
                    SysTick_TimerStart(chargerMiaTimer);
                } else {
                    nextState = stopping_state;
                }

            }
            //Always set the charge request to BMS
            CAN_bms_charger_request_output_voltage_low_byte_set(chargeVoltageTarget);
            CAN_bms_charger_request_output_voltage_high_byte_set(chargeVoltageTarget>>8);
            CAN_bms_charger_request_output_current_low_byte_set(chargeCurrentTarget);
            CAN_bms_charger_request_output_current_high_byte_set(chargeCurrentTarget>>8);
            break;

        case EXIT:
            CAN_bms_charger_request_start_charge_not_request_set(1);//inverted logic. 1 means stop charging
            break;
        default:
            break;
    }
}

void stopping(EV_CHARGER_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            CAN_bms_charger_request_start_charge_not_request_set(1);//inverted logic. 1 means stop charging
            IO_SET_EV_CHARGER_EN(LOW);
            break;
        case RUN:

            nextState = idle_state;

            break;
        case EXIT:
            break;
        default:
            break;
    }
}

void EV_CHARGER_set_charge_voltage(float volts) {
    chargeVoltageTarget = (uint16_t) (volts * CHARGER_VOLTAGE_SCALING);
}

void EV_CHARGER_set_charge_current(float current) {
    chargeCurrentTarget = (uint16_t) (current * CHARGER_CURRENT_SCALING);
}

float EV_CHARGER_get_charge_current() {
    return (float) chargeCurrentTarget / CHARGER_CURRENT_SCALING;
}

float EV_CHARGER_get_charge_voltage() {
    return (float) chargeVoltageTarget / CHARGER_VOLTAGE_SCALING;
}

uint8_t EV_CHARGER_get_bms_request_charge(void) {
    return chargeRequestFromBMS;
}

uint8_t EV_CHARGER_is_charging(void) {
    return (curState == charging_state);
}

uint8_t checkHeartBeat(void) {
    static uint8_t lastHeartBeat = 0;
    static uint32_t lastTime = 0;

    /*Check if heartbeat is within interval and updating*/
    uint8_t heartBeat = CAN_mcu_status_heartbeat_get();

    if (heartBeat != lastHeartBeat) {
        lastHeartBeat = heartBeat;
        lastTime = SysTick_Get();
        return 1;
    } else if ((SysTick_Get() - lastTime) < 4 * CAN_mcu_status_interval()) {
        return 1;
    } else {
        return 0;
    }

}

uint8_t checkChargerErrors(void) {
    uint8_t chargerError = 0;
    chargerError |= CAN_charger_status_charger_overtemp_error_get();
    chargerError |= CAN_charger_status_battery_detect_error_get();
    chargerError |= CAN_charger_status_communication_error_get();
    chargerError |= CAN_charger_status_hardware_error_get();
    chargerError |= CAN_charger_status_input_voltage_error_get();
    return chargerError;
}
