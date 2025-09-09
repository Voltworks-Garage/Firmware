/******************************************************************************
 * Includes
 *******************************************************************************/
#include "ThrottleControl.h"
#include "IO.h"
#include "SysTick.h"
#include "mcu_dbc.h"
#include "movingAverageInt.h"

#include <stdint.h>
#include <stdbool.h>

/******************************************************************************
 * Constants
 *******************************************************************************/

/******************************************************************************
 * Macros
 *******************************************************************************/
#define THROTTLE_CONTROL_STATES(state)\
state(throttle_idle)\
state(throttle_active)\

#define STATE_FORM(WORD) WORD##_state,
#define FUNCTION_FORM(WORD) static void WORD(THROTTLE_CONTROL_entry_types_E entry_type);
#define FUNC_PTR_FORM(WORD) WORD,

/******************************************************************************
 * Configuration
 *******************************************************************************/

/******************************************************************************
 * Typedefs
 *******************************************************************************/
typedef enum {
    THROTTLE_CONTROL_STATES(STATE_FORM)
    NUMBER_OF_THROTTLE_STATES
} THROTTLE_CONTROL_states_E;

typedef enum {
    ENTRY,
    EXIT,
    RUN
} THROTTLE_CONTROL_entry_types_E;

typedef void(*throttleStatePtr)(THROTTLE_CONTROL_entry_types_E);

/******************************************************************************
 * Variable Declarations
 *******************************************************************************/
THROTTLE_CONTROL_STATES(FUNCTION_FORM)
static throttleStatePtr throttle_state_functions[] = {THROTTLE_CONTROL_STATES(FUNC_PTR_FORM)};

static THROTTLE_CONTROL_states_E throttle_prevState = throttle_idle_state;
static THROTTLE_CONTROL_states_E throttle_curState = throttle_idle_state;
static THROTTLE_CONTROL_states_E throttle_nextState = throttle_idle_state;

static bool throttleEnabled = false;

/* THROTTLE INPUT STUFF*/

#define THROTTLE_IDLE_OUTPUT 0 //THIS SHOULD ALWAYS BE ZERO
#define THROTTLE_ECO_OUTPUT 40
#define THROTTLE_NORMAL_OUTPUT 70
#define THROTTLE_SPORT_OUTPUT 100

#define THROTTLE_RAW_BOTTOM_DEAD_ZONE_LOWER 0   //mV
#define THROTTLE_RAW_BOTTOM_DEAD_ZONE_UPPER 900 //mV

#define THROTTLE_RAW_TOP_DEAD_ZONE_LOWER 2800 //mV
#define THROTTLE_RAW_TOP_DEAD_ZONE_UPPER 3300 //mV

// Sending value outside of this range results in a fault.
#define THROTTLE_DEMAND_LOW 0 //lower value that the motor controller is expecting
#define THROTTLE_DEMAND_HIGH 100 //upper value that the motor controller is expecting

NEW_LOW_PASS_FILTER_INT(rawThrottleInputVoltagemV, 350, 1000); //350Hz cutoff freq. samples at 1000Hz (1ms task)
static uint16_t commandedThrottleInputValue = 0; // throttle input command from 0 - 100

/* THROTTLE OUTPUT STUFF*/

// Sending value outside of this range results in a fault.
#define THROTTLE_OUTPUT_LOW 128 //lower value that the motor controller is expecting
#define THROTTLE_OUTPUT_HIGH 2892 //upper value that the motor controller is expecting

static uint16_t throttleOutputValue = 0; //actual value to send to motor controller
static uint16_t throttleOutputPercent = 0; //scaling for different driving modes


/******************************************************************************
 * Function Prototypes
 *******************************************************************************/
static void updateThrottleOutput(void);
static void getThrottleInputCommand(void);
uint16_t map(uint16_t value, uint16_t input_low, uint16_t input_high, uint16_t output_low, uint16_t output_high);

/******************************************************************************
 * Function Definitions
 *******************************************************************************/

void ThrottleControl_Init(void) {
    throttleEnabled = true;
    throttle_curState = throttle_idle_state;
    throttle_prevState = throttle_idle_state;
    throttle_nextState = throttle_idle_state;
    throttle_state_functions[throttle_curState](ENTRY);
}

void ThrottleControl_Run_1ms(void) {

    takeLowPassFilterInt(rawThrottleInputVoltagemV, IO_GET_VOLTAGE_THROTTLE_mV());

    if (!throttleEnabled) {
        return;
    }

    if (throttle_nextState != throttle_curState) {
        throttle_state_functions[throttle_curState](EXIT);
        throttle_prevState = throttle_curState;
        throttle_curState = throttle_nextState;
        throttle_state_functions[throttle_curState](ENTRY);
    }
    
    throttle_state_functions[throttle_curState](RUN);

    //Always read the throttle signal
    getThrottleInputCommand();
    
    // Always set the output
    updateThrottleOutput();

}

void ThrottleControl_Halt(void) {
    throttle_state_functions[throttle_curState](EXIT);
    throttleEnabled = false;
    throttleOutputPercent = THROTTLE_IDLE_OUTPUT;
    throttleOutputValue = 0;
    CAN_mcu_motorControllerRequest_Throttle_Value_set(THROTTLE_OUTPUT_LOW);
}

void ThrottleControl_Enable(bool state) {
    if (state == true){
        throttle_nextState = throttle_active_state;
    }
    else {
        throttle_nextState = throttle_idle_state;
    }
}

void throttle_idle(THROTTLE_CONTROL_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            throttleOutputPercent = THROTTLE_IDLE_OUTPUT;
            throttleOutputValue = 0;
            CAN_mcu_motorControllerRequest_Throttle_Value_set(THROTTLE_OUTPUT_LOW);
            CAN_mcu_motorControllerRequest_FS1_Switch_set(false);
            CAN_mcu_motorControllerRequest_Forward_Switch_set(false);
            CAN_mcu_motorControllerRequest_Reverse_Switch_set(false);
            CAN_mcu_motorControllerRequest_Seat_Switch_set(true);
            CAN_mcu_motorControllerRequest_Handbrake_Switch_set(false);
            break;
        case EXIT:

            break;
        case RUN:
            break;
        default:
            break;
    }
}

void throttle_active(THROTTLE_CONTROL_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            
            CAN_mcu_motorControllerRequest_Forward_Switch_set(true);
            
            throttleOutputPercent = THROTTLE_NORMAL_OUTPUT;
            break;
        case EXIT:
            CAN_mcu_motorControllerRequest_Throttle_Value_set(THROTTLE_OUTPUT_LOW);
            break;
        case RUN:
            CAN_mcu_motorControllerRequest_FS1_Switch_set(true);
            CAN_mcu_motorControllerRequest_Throttle_Value_set(throttleOutputValue);
            break;
        default:
            break;
    }
}

static void getThrottleInputCommand(void){

    uint16_t value = getLowPassFilterInt(rawThrottleInputVoltagemV);

    // Input sanitizing
    if (value < THROTTLE_RAW_BOTTOM_DEAD_ZONE_UPPER) {
        commandedThrottleInputValue = THROTTLE_DEMAND_LOW;
        return;
    }

    // Input sanitizing
    if (value > THROTTLE_RAW_TOP_DEAD_ZONE_LOWER) {
        commandedThrottleInputValue = THROTTLE_DEMAND_LOW;
        return;
    }

    commandedThrottleInputValue = map(value,
                                      THROTTLE_RAW_BOTTOM_DEAD_ZONE_UPPER,
                                      THROTTLE_RAW_TOP_DEAD_ZONE_LOWER,
                                      THROTTLE_DEMAND_LOW,
                                      THROTTLE_DEMAND_HIGH
                                    );
}

static void updateThrottleOutput(void) {
    // Scale the input by the drive mode percentage
    uint16_t newThrottleOutputValue = (commandedThrottleInputValue*throttleOutputPercent) / 100;
    
    // map the input value to the output format
    newThrottleOutputValue = map(newThrottleOutputValue,
                                 THROTTLE_DEMAND_LOW,
                                 THROTTLE_DEMAND_HIGH,
                                 THROTTLE_OUTPUT_LOW,
                                  THROTTLE_OUTPUT_HIGH
                                );
     
    // set the new value
    throttleOutputValue = newThrottleOutputValue;
}

uint16_t map(uint16_t value, uint16_t input_low, uint16_t input_high, uint16_t output_low, uint16_t output_high){

    if (value < input_low){
        value = input_low;
    }
    else if (value > input_high){
        value = input_high;
    }

    return output_low + (((uint32_t)(value - input_low) *(output_high - output_low)) / (input_high - input_low));
}

/*** End of File **************************************************************/