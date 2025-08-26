#include "contactorControl.h"
#include "IO.h"
#include "movingAverage.h"
#include "bms_dbc.h"
#include "SysTick.h"
#include <stdint.h>

/******************************************************************************
 * State Machine Definition
 *******************************************************************************/
#define CONTACTOR_STATES(state)\
state(idle) \
state(precharge) \
state(pull_in) \
state(hold)

// Generate state enum
#define STATE_FORM(WORD) WORD##_state,
typedef enum {
    CONTACTOR_STATES(STATE_FORM)
} CONTACTOR_states_E;

// Generate function prototypes
typedef enum {
    ENTRY,
    EXIT, 
    RUN
} CONTACTOR_entry_types_E;

#define FUNCTION_FORM(WORD) static void WORD(CONTACTOR_entry_types_E entry_type);
CONTACTOR_STATES(FUNCTION_FORM)

// Function pointer type and array
typedef void (*state_FPtr)(CONTACTOR_entry_types_E entry_type);
#define FUNC_PTR_FORM(WORD) WORD,
static state_FPtr state_functions[] = {CONTACTOR_STATES(FUNC_PTR_FORM)};

/******************************************************************************
 * State Variables
 *******************************************************************************/
static uint8_t contactorRun = 0;
static CONTACTOR_states_E prevState = idle_state;
static CONTACTOR_states_E curState = idle_state;
static CONTACTOR_states_E nextState = idle_state;


/******************************************************************************
 * Internal Variables
 *******************************************************************************/
NEW_LOW_PASS_FILTER(contactor_vbus_voltage, 10.0, 1000.0);
NEW_LOW_PASS_FILTER(contactor_hv_bus_voltage, 10.0, 1000.0);
NEW_TIMER(precharge_timer, 3000);  // 3 second precharge timeout
NEW_TIMER(pull_in_timer, 200);  // 200ms pull-in time

static uint8_t contactorCommandFromMcu = 0;
static float dcLinkVoltage = 0;
static uint16_t pull_in_pwm_duty = 80;   // 80% duty cycle for pull-in
static uint16_t hold_pwm_duty = 15;       // 10% duty cycle for hold
static const float final_precharge_percent = 0.85; //Sevcon controller is set to 90%, so allow a little margin here.

/******************************************************************************
 * Public Functions
 *******************************************************************************/
void CONTACTOR_Init(void) {
    contactorRun = 1;
    prevState = idle_state;
    curState = idle_state;
    nextState = idle_state;
    // Initialize PWM to 0%
    IO_SET_CONTACTOR_1_PWM(0);
}

void CONTACTOR_Run_1ms(void) {
    if (contactorRun) {
        takeLowPassFilter(contactor_vbus_voltage, IO_GET_VBUS_VOLTAGE());
        takeLowPassFilter(contactor_hv_bus_voltage, IO_GET_HV_BUS_VOLTAGE());
    }
}

void CONTACTOR_Run_100ms(void) {
    // always get the motor controller status request
    if(!CAN_mcu_command_checkDataIsStale()){
        contactorCommandFromMcu = CAN_mcu_command_motor_controller_enable_get();
    } else {
        contactorCommandFromMcu = 0;
    }

    // always get the motor controller input cap voltage for determining precharge
    if(!CAN_motorcontroller_motor_status_PDO4_checkDataIsStale()){
        dcLinkVoltage = CAN_motorcontroller_motor_status_PDO4_Capacitor_Voltage_get();
    } else {
        dcLinkVoltage = 0;
    }

    if (contactorRun) {
        // Check for state transitions
        if (nextState != curState) {
            // Exit current state
            state_functions[curState](EXIT);
            
            // Update state variables
            prevState = curState;
            curState = nextState;
            
            // Enter new state
            state_functions[curState](ENTRY);
        } else {
            // Run current state
            state_functions[curState](RUN);
        }
    }
}

void CONTACTOR_Halt(void) {
    contactorRun = 0;
    nextState = idle_state;
    curState = idle_state;
    prevState = idle_state;
    IO_SET_CONTACTOR_1_PWM(0);
    IO_SET_PRE_CHARGE_EN(LOW);
    clearLowPassFilter(contactor_vbus_voltage);
    clearLowPassFilter(contactor_hv_bus_voltage);
}

void CONTACTOR_Run(void){
    contactorRun = 1;
}

CONTACTOR_state_E CONTACTOR_GetState(void){
    return (CONTACTOR_state_E)curState;
}


/******************************************************************************
 * State Functions
 *******************************************************************************/
static void idle(CONTACTOR_entry_types_E entry_type) {
    
    switch (entry_type) {
        case ENTRY:
            IO_SET_CONTACTOR_1_PWM(0);
            break;
            
        case RUN:
            if (contactorCommandFromMcu == true) {
                nextState = precharge_state;
            }
            break;
            
        case EXIT:
            break;
            
        default:
            break;
    }
}

static void precharge(CONTACTOR_entry_types_E entry_type) {
    
    switch (entry_type) {
        case ENTRY:
            CAN_bms_SDO_request_size_set(1); // size shown in n
            CAN_bms_SDO_request_expidited_xfer_set(1); //exp transfer yes
            CAN_bms_SDO_request_n_bytes_set(3); // e and s are set, and three bytes are NOT used.
            CAN_bms_SDO_request_ccs_set(1); //download
            CAN_bms_SDO_request_index_set(0x5180); //Capacitor Precharge Activate
            CAN_bms_SDO_request_subindex_set(0); // no subindex
            CAN_bms_SDO_request_byte_4_set(0x01);
            CAN_bms_SDO_request_byte_5_set(0x00);
            CAN_bms_SDO_request_byte_6_set(0x00);
            CAN_bms_SDO_request_byte_7_set(0x00);
            CAN_bms_SDO_request_send();
            SysTick_TimerStart(precharge_timer);
            break;
            
        case RUN:
            if ((dcLinkVoltage > getLowPassFilter(contactor_vbus_voltage) * final_precharge_percent)) {
                nextState = pull_in_state;
            }
            else if (contactorCommandFromMcu == false) {
                nextState = idle_state;
            }
            else if (SysTick_TimeOut(precharge_timer)) {
                // Precharge timeout - return to idle for safety
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

static void pull_in(CONTACTOR_entry_types_E entry_type) {
    
    switch (entry_type) {
        case ENTRY:
            IO_SET_CONTACTOR_1_PWM(pull_in_pwm_duty);
            SysTick_TimerStart(pull_in_timer);
            break;
            
        case RUN:
            if (SysTick_TimeOut(pull_in_timer)) {
                nextState = hold_state;
            }
            else if (contactorCommandFromMcu == false) {
                nextState = idle_state;
            }
            break;
            
        case EXIT:
            break;
            
        default:
            break;
    }
}

static void hold(CONTACTOR_entry_types_E entry_type) {

    switch (entry_type) {
        case ENTRY:
            IO_SET_CONTACTOR_1_PWM(hold_pwm_duty);
            break;
            
        case RUN:
            if (contactorCommandFromMcu == false) {
                nextState = idle_state;
            }
            break;
            
        case EXIT:
            break;
            
        default:
            break;
    }
}