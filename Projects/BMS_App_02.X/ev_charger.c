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
#include <stdbool.h>

/******************************************************************************
 * Constants
 *******************************************************************************/

/******************************************************************************
 * Macros
 *******************************************************************************/

#define EV_CHARGER_STATES(state)\
state(idle) /* init state for startup code */ \
state(j1772_handshake) /* waiting for J1772 connection */ \
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

typedef enum prox_status_E {
    J1772_DISCONNECTED,
    J1772_CONNECTED,
    J1772_REQUEST_DISCONNECT,
    J1772_SNA_PROX
} prox_status_E;

typedef void(*statePtr)(EV_CHARGER_entry_types_E);

/******************************************************************************
 * Variable Declarations
 *******************************************************************************/
/*State variables*/
/* function-ifies the state list*/
EV_CHARGER_STATES(FUNCTION_FORM)
static statePtr state_functions[] = {EV_CHARGER_STATES(FUNC_PTR_FORM)};

static EV_CHARGER_states_E prevState = idle_state; /* initialize previous state */
static EV_CHARGER_states_E curState = idle_state; /* initialize current state */
static EV_CHARGER_states_E nextState = idle_state; /* initialize current state */

NEW_TIMER(chargerMiaTimer, 1500); /*Timer for state machine*/
NEW_TIMER(wait_for_charge_timer, 5000); /*Timer for waiting for charge to start*/
NEW_TIMER(precharge_timer, 5000); /*Timer for pre-charge state*/

static uint16_t chargeVoltageTarget = 24 * 4.2 * CHARGER_VOLTAGE_SCALING; //24 cells, 4.2v each, 0.1V/bit
static uint16_t chargeCurrentTarget = 5 * CHARGER_CURRENT_SCALING;

NEW_LOW_PASS_FILTER(charger_voltage, 10.0, 100.0);
NEW_LOW_PASS_FILTER(charger_current, 10.0, 100.0);
NEW_LOW_PASS_FILTER(vbus_voltage, 10.0, 100.0);

prox_status_E J1772_prox_status = J1772_DISCONNECTED;
uint16_t J1772_pilot_current = 0;
uint32_t maximumChargerCurrentAllowedmA = 0;

bool systemIsReadyToCharge = false;

/******************************************************************************
 * Function Prototypes
 *******************************************************************************/
uint8_t checkChargerErrors(void);
void EV_CHARGER_charge_voltage_mV_set(uint32_t volts);
void EV_CHARGER_charge_current_mA_set(uint32_t current);
void EV_CHARGER_charge_request_set(bool request);
void EV_CHARGER_calculate_max_dc_current_from_pilot(void);

/******************************************************************************
 * Function DefinitionsW
 *******************************************************************************/
void EV_Charger_Init(void) {
    static EV_CHARGER_states_E prevState = idle_state; /* initialize previous state */
    static EV_CHARGER_states_E curState = idle_state; /* initialize current state */
    static EV_CHARGER_states_E nextState = idle_state; /* initialize current state */
    state_functions[curState](ENTRY);
}

void EV_CHARGER_Run_10ms(void) {

    takeLowPassFilter(vbus_voltage, IO_GET_VBUS_VOLTAGE());
    takeLowPassFilter(charger_voltage, IO_GET_EV_CHARGER_VOLTAGE());
    takeLowPassFilter(charger_current, IO_GET_EV_CHARGER_CURRENT());

    CAN_bms_debug_byte1_set((uint8_t)curState);

    // Always check if this data is stale.
    if (!CAN_mcu_command_checkDataIsStale()){
        J1772_prox_status = CAN_mcu_command_J1772_prox_status_get();
        J1772_pilot_current = CAN_mcu_command_J1772_pilot_current_get();
        EV_CHARGER_calculate_max_dc_current_from_pilot();
    } else {
        J1772_prox_status = J1772_DISCONNECTED;
        J1772_pilot_current = 0;
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
            // set Efuse output low
            IO_SET_EV_CHARGER_EN(LOW);
            // set all can message requests to 0
            EV_CHARGER_charge_current_mA_set(0);
            EV_CHARGER_charge_voltage_mV_set(0);
            EV_CHARGER_charge_request_set(0);
            // don't allow EVSE charger to close relays yet.
            CAN_bms_power_systems_J1772_ready_to_charge_set(0);
            break;
        case RUN:
            // While the charger efuse is off, calibrate the 0-current.
            if (!IO_GET_EV_CHARGER_EN()) {
                IO_SET_EV_CHARGER_CALIBRATION();
            }

            // If J1772 EVSE detected, 
            if (J1772_prox_status == J1772_CONNECTED) {
                nextState = j1772_handshake_state;
            }

            break;
        case EXIT:
            break;
        default:
            break;
    }

}

void j1772_handshake(EV_CHARGER_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            // allow EVSE charger to close relays.
            CAN_bms_power_systems_J1772_ready_to_charge_set(1);
            SysTick_TimerStart(wait_for_charge_timer);
            break;

        case RUN:
            // If no charge request, stop cancel charging
            if (J1772_prox_status == J1772_REQUEST_DISCONNECT ||
                J1772_prox_status == J1772_DISCONNECTED) {
                nextState = idle_state;
            }

            // If charger appears on the CAN bus, move to pre-charging state
            if (!CAN_charger_status_checkDataIsStale()){
                nextState = precharging_state;
            }

            // If the charger does not appear on the CAN bus, cancel charging, and move to faulted to prevent toggling the EVSE.
            if (SysTick_TimeOut(wait_for_charge_timer)){
                nextState = faulted_state;
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
            // If precharging is successful, move to next state.
            if (getLowPassFilter(charger_voltage) > getLowPassFilter(vbus_voltage) * 0.90) {
                IO_SET_EV_CHARGER_EN(HIGH); //Enable the charger efuse here so precharge doesn't fail
                nextState = negotiating_state;
            }

            // If pre-charge timeout, stop pre-charge
            if (SysTick_TimeOut(precharge_timer)) {
                nextState = faulted_state;
            }
            
            // If no charge request, stop pre-charge
            if (J1772_prox_status == J1772_REQUEST_DISCONNECT ||
                J1772_prox_status == J1772_DISCONNECTED) {
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
            SysTick_TimerStart(wait_for_charge_timer);
            break;

        case RUN:
            // If no charge request, stop pre-charge
            if (J1772_prox_status == J1772_REQUEST_DISCONNECT ||
                J1772_prox_status == J1772_DISCONNECTED) {
                nextState = idle_state;
            }
            
            // If no errors from the charger, start charging
            if (!checkChargerErrors()) {
                nextState = charging_state;
            }

            // If errors wont clear in time, go to faulted state
            if(SysTick_TimeOut(wait_for_charge_timer)){
                nextState = faulted_state;
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
            break;

        case RUN:
            // If no charge request, stop pre-charge
            if (J1772_prox_status == J1772_REQUEST_DISCONNECT ||
                J1772_prox_status == J1772_DISCONNECTED) {
                nextState = stopping_state;
            }

            // If charger is MIA,
            if (CAN_charger_status_checkDataIsStale()){
                nextState = stopping_state;
            }

            // If any errors from the charger, stop charging
            if (checkChargerErrors()) {
                nextState = faulted_state;
            }

            //Always set the charge request to BMS or MCU command, whichever is less.
            uint32_t charging_current = MIN(maximumChargerCurrentAllowedmA,
                                            CAN_bms_status_max_charge_current_mA_get());
            charging_current = MIN(charging_current, 5000); //TODO delete this when ready. sets a 5A cap.
            EV_CHARGER_charge_current_mA_set(charging_current);
            EV_CHARGER_charge_voltage_mV_set(CAN_bms_status_max_charge_voltage_mV_get());

            // If the BMS is requesting 0 current, it means we just want to balance cells
            // for a while without charging due to high cell imbalance
            // TODO: Think of a more elegant way to acheive this
            if (charging_current <= 0) {
                EV_CHARGER_charge_request_set(0);
            } else {
                EV_CHARGER_charge_request_set(1);
            }

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
            EV_CHARGER_charge_request_set(0);
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
            EV_CHARGER_charge_request_set(0);
            IO_SET_EV_CHARGER_EN(LOW);
            break;
        case RUN:
            
            //To get out of faulted state, disconnect or request disconnect to the charger.
            if (J1772_prox_status == J1772_REQUEST_DISCONNECT ||
                J1772_prox_status == J1772_DISCONNECTED) {
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

void EV_CHARGER_calculate_max_dc_current_from_pilot(void) {
    if (J1772_pilot_current == 0) {
        maximumChargerCurrentAllowedmA = 0; // No pilot signal, no charging allowed
        return;
    }
    
    // Determine AC voltage based on pilot current
    uint16_t ac_voltage;
    if (J1772_pilot_current <= 16) {
        ac_voltage = 120; // 120V AC for 16A and below
    } else {
        ac_voltage = 240; // 240V AC for above 16A
    }
    
    // Calculate AC power: P = V * I
    uint32_t ac_power_watts = (uint32_t)ac_voltage * J1772_pilot_current;
    
    // Get current DC bus voltage. Cast to int is okay since accuracy isn't critical here.
    uint32_t dc_voltage = getLowPassFilter(vbus_voltage);
    
    // Prevent division by zero
    if (dc_voltage == 0) {
        maximumChargerCurrentAllowedmA = 0;
        return;
    }
    
    // Calculate DC current: I_DC = P_AC / V_DC
    // Assuming 90% efficiency (multiply by 0.9)
    maximumChargerCurrentAllowedmA = (ac_power_watts * 900) / dc_voltage; // 0.9 * 1000 for mA conversion
}