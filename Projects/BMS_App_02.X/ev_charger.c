/******************************************************************************
 * Includes
 *******************************************************************************/
#include "ev_charger.h"
#include "SysTick.h"
#include "IO.h"
#include "CAN.h"
#include "bms_dbc.h"
#include "movingAverage.h"

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
state(faulted)\

/*Creates an enum of states suffixed with _state*/
#define STATE_FORM(WORD) WORD##_state,
#define FUNCTION_FORM(WORD) static void WORD(EV_CHARGER_entry_types_E entry_type);
#define FUNC_PTR_FORM(WORD) WORD,

#define CHARGER_VOLTAGE_SCALING 10.0
#define CHARGER_CURRENT_SCALING 10.0
#define CHARGER_MILLI_TO_DECI(x) (x/100)
#define MIN(a, b) ((a) < (b) ? (a) : (b))

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

NEW_LOW_PASS_FILTER(charger_voltage, 10.0, 100.0);
NEW_LOW_PASS_FILTER(charger_current, 10.0, 100.0);
NEW_LOW_PASS_FILTER(vbus_voltage, 10.0, 100.0);

/******************************************************************************
 * Function Prototypes
 *******************************************************************************/
uint8_t checkHeartBeat(void);
uint8_t checkChargerErrors(void);
void EV_CHARGER_charge_voltage_mV_set(uint32_t volts);
void EV_CHARGER_charge_current_mA_set(uint32_t current);
void EV_CHARGER_charge_request_set(bool request);

/******************************************************************************
 * Function Definitions
 *******************************************************************************/
void EV_Charger_Init(void) {
}

void EV_CHARGER_Run_10ms(void) {

    takeLowPassFilter(vbus_voltage, IO_GET_VBUS_VOLTAGE());
    takeLowPassFilter(charger_voltage, IO_GET_EV_CHARGER_VOLTAGE());
    takeLowPassFilter(charger_current, IO_GET_EV_CHARGER_CURRENT());

    if (!CAN_mcu_command_checkDataIsStale()){
        chargeRequestFromMCU = CAN_mcu_command_ev_charger_enable_get();// && checkHeartBeat();
    } else {
        chargeRequestFromMCU = 0;
    }

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
            EV_CHARGER_charge_current_mA_set(0);
            EV_CHARGER_charge_voltage_mV_set(0);
            EV_CHARGER_charge_request_set(0);
            break;
        case RUN:
            CAN_bms_charger_request_start_charge_not_request_set(1);//inverted logic. 1 means stop charging
            if (!IO_GET_EV_CHARGER_EN()) {
                IO_SET_EV_CHARGER_CALIBRATION();
            }
            if (chargeRequestFromMCU) {
                nextState = precharging_state;
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
            if (getLowPassFilter(charger_voltage) > getLowPassFilter(vbus_voltage) * 0.90) {
                nextState = negotiating_state;
            }
            if (SysTick_TimeOut(precharge_timer)) {
                // If pre-charge timeout, stop pre-charge
                nextState = faulted_state;
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
            EV_CHARGER_charge_request_set(1);
            //SysTick_TimerStart(chargerMiaTimer); // Uncomment this when ready to charge with real charger
            break;

        case RUN:
            if (!chargeRequestFromMCU) {
                nextState = stopping_state;
            }

            if (SysTick_TimeOut(chargerMiaTimer)){
                if (CAN_charger_status_checkDataIsUnread()){
                    SysTick_TimerStart(chargerMiaTimer);
                } else {
                    nextState = stopping_state;
                }

            }
            //Always set the charge request to BMS or MCU command, whichever is less.
            uint32_t charging_current = MIN((CAN_mcu_command_ev_charger_current_get()*1000),
                                            CAN_bms_status_max_charge_current_mA_get());
            charging_current = MIN(charging_current, 5000); //TODO delete this when ready. sets a 5A cap.
            EV_CHARGER_charge_current_mA_set(charging_current);
            EV_CHARGER_charge_voltage_mV_set(CAN_bms_status_max_charge_voltage_mV_get());

            break;

        case EXIT:
            EV_CHARGER_charge_request_set(0);
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

void faulted(EV_CHARGER_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            CAN_bms_charger_request_start_charge_not_request_set(1);//inverted logic. 1 means stop charging
            IO_SET_EV_CHARGER_EN(LOW);
            break;
        case RUN:

            if (!chargeRequestFromMCU) {
                nextState = idle_state;
            }

            break;
        case EXIT:
            break;
        default:
            break;
    }
}


void EV_CHARGER_charge_voltage_mV_set(uint32_t volts) {
    // charge voltage target always set in 10th volts
    chargeVoltageTarget = (uint16_t) (CHARGER_MILLI_TO_DECI(volts));
    CAN_bms_charger_request_output_voltage_low_byte_set(chargeVoltageTarget);
    CAN_bms_charger_request_output_voltage_high_byte_set(chargeVoltageTarget>>8);
}

void EV_CHARGER_charge_current_mA_set(uint32_t current) {
    // charge current always sent in 10th amps
    chargeCurrentTarget = (uint16_t) (CHARGER_MILLI_TO_DECI(current));
    CAN_bms_charger_request_output_current_low_byte_set(chargeCurrentTarget);
    CAN_bms_charger_request_output_current_high_byte_set(chargeCurrentTarget>>8);
}

void EV_CHARGER_charge_request_set(bool request) {
    CAN_bms_charger_request_charge_mode_set(0); //always set to charing mode, not heating
    CAN_bms_charger_request_start_charge_not_request_set(!request);//inverted logic. 1 means stop charging
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


float EV_CHARGER_current_get(void){
    return getLowPassFilter(charger_current);
}
float EV_CHARGER_voltage_get(void){
    return getLowPassFilter(charger_voltage);
}