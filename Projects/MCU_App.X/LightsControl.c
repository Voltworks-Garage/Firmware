/******************************************************************************
 * Includes
 *******************************************************************************/
#include "LightsControl.h"
#include "IO.h"
#include "SysTick.h"
#include "IgnitionControl.h"
#include <stdint.h>
#include <stdbool.h>

/******************************************************************************
 * Constants
 *******************************************************************************/

/******************************************************************************
 * Macros
 *******************************************************************************/
#define LEFT_TURN_SIGNAL_FREQUENCY 500 // ms
#define RIGHT_TURN_SIGNAL_FREQUENCY 500 // ms
#define BRAKE_LIGHT_FLASH_FREQUENCY 50 // ms
#define BRAKE_LIGHT_FLASH_COUNT 5 // Number of flashes before staying on
#define BRAKE_LIGHT_COOLDOWN_TIME 5000 // ms (5 seconds)

#define LIGHTS_CONTROL_STATES(state)\
state(lights_idle)\
state(lights_active)\

#define STATE_FORM(WORD) WORD##_state,
#define FUNCTION_FORM(WORD) static void WORD(LIGHTS_CONTROL_entry_types_E entry_type);
#define FUNC_PTR_FORM(WORD) WORD,

NEW_TIMER(leftTurnTimer, LEFT_TURN_SIGNAL_FREQUENCY);
NEW_TIMER(rightTurnTimer, RIGHT_TURN_SIGNAL_FREQUENCY);
NEW_TIMER(brakeTimer, BRAKE_LIGHT_FLASH_FREQUENCY);
NEW_TIMER(brakeCooldownTimer, BRAKE_LIGHT_COOLDOWN_TIME);
/******************************************************************************
 * Configuration
 *******************************************************************************/

/******************************************************************************
 * Typedefs
 *******************************************************************************/
typedef enum {
    LIGHTS_CONTROL_STATES(STATE_FORM)
    NUMBER_OF_LIGHTS_STATES
} LIGHTS_CONTROL_states_E;

typedef enum {
    ENTRY,
    EXIT,
    RUN
} LIGHTS_CONTROL_entry_types_E;

typedef void(*lightsStatePtr)(LIGHTS_CONTROL_entry_types_E);

/******************************************************************************
 * Variable Declarations
 *******************************************************************************/
LIGHTS_CONTROL_STATES(FUNCTION_FORM)
static lightsStatePtr lights_state_functions[] = {LIGHTS_CONTROL_STATES(FUNC_PTR_FORM)};

static LIGHTS_CONTROL_states_E lights_prevState = lights_idle_state;
static LIGHTS_CONTROL_states_E lights_curState = lights_idle_state;
static LIGHTS_CONTROL_states_E lights_nextState = lights_idle_state;

static bool lightsEnabled = false;

static bool leftTurnSignalEnabled = false;
static bool rightTurnSignalEnabled = false;
static bool brakePressed = false;
static bool highBeamEnabled = false;

/******************************************************************************
 * Function Prototypes
 *******************************************************************************/
static void handleLeftTurnSignal(bool enable);
static void handleRightTurnSignal(bool enable);
static void handleBrakeLight(bool enable);

/******************************************************************************
 * Function Definitions
 *******************************************************************************/

void LightsControl_Init(void) {
    lightsEnabled = true;
    IO_SET_TURN_SIGNAL_FL_EN(LOW);
    IO_SET_TURN_SIGNAL_FR_EN(LOW);
    IO_SET_TURN_SIGNAL_RR_EN(LOW);
    IO_SET_TURN_SIGNAL_RL_EN(LOW);

    IO_SET_HEADLIGHT_LO_EN(LOW);
    IO_SET_HEADLIGHT_HI_EN(LOW);

    IO_SET_TAILLIGHT_EN(LOW);
    IO_SET_BRAKE_LIGHT_EN(LOW);

    lights_prevState = lights_idle_state;
    lights_curState = lights_idle_state;
    lights_nextState = lights_idle_state;
    
    lights_state_functions[lights_curState](ENTRY);
}

void LightsControl_Run_10ms(void) {
    if (!lightsEnabled) {
        return;
    }

    if (lights_nextState != lights_curState) {
        lights_state_functions[lights_curState](EXIT);
        lights_prevState = lights_curState;
        lights_curState = lights_nextState;
        lights_state_functions[lights_curState](ENTRY);
    }
    
    lights_state_functions[lights_curState](RUN);
}

void LightsControl_Halt(void){
    lights_state_functions[lights_curState](EXIT);
    lightsEnabled = false;
    IO_SET_TURN_SIGNAL_FL_EN(LOW);
    IO_SET_TURN_SIGNAL_FR_EN(LOW);
    IO_SET_TURN_SIGNAL_RR_EN(LOW);
    IO_SET_TURN_SIGNAL_RL_EN(LOW);

    IO_SET_HEADLIGHT_LO_EN(LOW);
    IO_SET_HEADLIGHT_HI_EN(LOW);

    IO_SET_TAILLIGHT_EN(LOW);
    IO_SET_BRAKE_LIGHT_EN(LOW);

    IO_SET_J1772_CONTROLLER_EN(LOW); //RUNNING_LIGHTS
}

void lights_idle(LIGHTS_CONTROL_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            IO_SET_TURN_SIGNAL_FL_EN(LOW);
            IO_SET_TURN_SIGNAL_FR_EN(LOW);
            IO_SET_TURN_SIGNAL_RR_EN(LOW);
            IO_SET_TURN_SIGNAL_RL_EN(LOW);
            IO_SET_HEADLIGHT_LO_EN(LOW);
            IO_SET_HEADLIGHT_HI_EN(LOW);
            IO_SET_TAILLIGHT_EN(LOW);
            IO_SET_BRAKE_LIGHT_EN(LOW);
            IO_SET_J1772_CONTROLLER_EN(LOW); //RUNNING_LIGHTS
            break;
        case EXIT:
            break;
        case RUN:
            if (IO_GET_SW_EN()) {
                lights_nextState = lights_active_state;
            }
            break;
        default:
            break;
    }
}

void lights_active(LIGHTS_CONTROL_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            break;
        case EXIT:
            IO_SET_TURN_SIGNAL_FL_EN(LOW);
            IO_SET_TURN_SIGNAL_FR_EN(LOW);
            IO_SET_TURN_SIGNAL_RR_EN(LOW);
            IO_SET_TURN_SIGNAL_RL_EN(LOW);
            IO_SET_HEADLIGHT_LO_EN(LOW);
            IO_SET_HEADLIGHT_HI_EN(LOW);
            IO_SET_TAILLIGHT_EN(LOW);
            IO_SET_BRAKE_LIGHT_EN(LOW);
            IO_SET_J1772_CONTROLLER_EN(LOW); //RUNNING_LIGHTS
            break;
        case RUN:
            if (!IO_GET_SW_EN()) {
                lights_nextState = lights_idle_state;
                break;
            }

            // Handle LEFT turn signal
            leftTurnSignalEnabled = false;
            if (IgnitionControl_GetLeftTurnButtonStatus() == BUTTON_PRESSED){
                leftTurnSignalEnabled = true;
            }
            handleLeftTurnSignal(leftTurnSignalEnabled);
            
            // Handle RIGHT turn signal
            rightTurnSignalEnabled = false;
            if (IgnitionControl_GetRightTurnButtonStatus() == BUTTON_PRESSED){
                rightTurnSignalEnabled = true;
            }
            handleRightTurnSignal(rightTurnSignalEnabled);
            
            // Handle brake light with flash pattern
            brakePressed = false;
            if (IgnitionControl_GetLeftBrakeButtonStatus() == BUTTON_PRESSED) {
                brakePressed = true;
            }
            if (IgnitionControl_GetRightBrakeButtonStatus() == BUTTON_PRESSED) {
                brakePressed = true;
            }
            handleBrakeLight(brakePressed);

            // IO_SET_HEADLIGHT_LO_EN(true);
            IO_SET_TAILLIGHT_EN(true);

            IO_SET_J1772_CONTROLLER_EN(HIGH); //RUNNING_LIGHTS
            
            // Handle High Beam Button
            highBeamEnabled = false;
            if (IgnitionControl_GetHighBeamButtonStatus() == BUTTON_PRESSED) {
                highBeamEnabled = true;
            }
            IO_SET_HEADLIGHT_HI_EN(highBeamEnabled);

            break;
        default:
            break;
    }
}



static void handleLeftTurnSignal(bool enable) {
    typedef enum {
        LEFT_TURN_IDLE,
        LEFT_TURN_ON,
        LEFT_TURN_OFF
    } LeftTurnState_E;
    
    static LeftTurnState_E leftTurnState = LEFT_TURN_IDLE;
    
    if (enable) {
        switch (leftTurnState) {
            case LEFT_TURN_IDLE:
                IO_SET_TURN_SIGNAL_FL_EN(HIGH);
                IO_SET_TURN_SIGNAL_RL_EN(HIGH);
                leftTurnState = LEFT_TURN_ON;
                SysTick_TimerStart(leftTurnTimer);
                break;
            case LEFT_TURN_ON:
                if (SysTick_TimeOut(leftTurnTimer)) {
                    IO_SET_TURN_SIGNAL_FL_EN(LOW);
                    IO_SET_TURN_SIGNAL_RL_EN(LOW);
                    leftTurnState = LEFT_TURN_OFF;
                    SysTick_TimerStart(leftTurnTimer);
                }
                break;
            case LEFT_TURN_OFF:
                if (SysTick_TimeOut(leftTurnTimer)) {
                    IO_SET_TURN_SIGNAL_FL_EN(HIGH);
                    IO_SET_TURN_SIGNAL_RL_EN(HIGH);
                    leftTurnState = LEFT_TURN_ON;
                    SysTick_TimerStart(leftTurnTimer);
                }
                break;
        }
    } else {
        IO_SET_TURN_SIGNAL_FL_EN(LOW);
        IO_SET_TURN_SIGNAL_RL_EN(LOW);
        leftTurnState = LEFT_TURN_IDLE;
    }
}

static void handleRightTurnSignal(bool enable) {
    typedef enum {
        RIGHT_TURN_IDLE,
        RIGHT_TURN_ON,
        RIGHT_TURN_OFF
    } RightTurnState_E;
    
    static RightTurnState_E rightTurnState = RIGHT_TURN_IDLE;
    
    if (enable) {
        switch (rightTurnState) {
            case RIGHT_TURN_IDLE:
                IO_SET_TURN_SIGNAL_FR_EN(HIGH);
                IO_SET_TURN_SIGNAL_RR_EN(HIGH);
                rightTurnState = RIGHT_TURN_ON;
                SysTick_TimerStart(rightTurnTimer);
                break;
            case RIGHT_TURN_ON:
                if (SysTick_TimeOut(rightTurnTimer)) {
                    IO_SET_TURN_SIGNAL_FR_EN(LOW);
                    IO_SET_TURN_SIGNAL_RR_EN(LOW);
                    rightTurnState = RIGHT_TURN_OFF;
                    SysTick_TimerStart(rightTurnTimer);
                }
                break;
            case RIGHT_TURN_OFF:
                if (SysTick_TimeOut(rightTurnTimer)) {
                    IO_SET_TURN_SIGNAL_FR_EN(HIGH);
                    IO_SET_TURN_SIGNAL_RR_EN(HIGH);
                    rightTurnState = RIGHT_TURN_ON;
                    SysTick_TimerStart(rightTurnTimer);
                }
                break;
        }
    } else {
        IO_SET_TURN_SIGNAL_FR_EN(LOW);
        IO_SET_TURN_SIGNAL_RR_EN(LOW);
        rightTurnState = RIGHT_TURN_IDLE;
    }
}

static void handleBrakeLight(bool enable) {
    typedef enum {
        BRAKE_IDLE,
        BRAKE_FLASHING,
        BRAKE_ON_SOLID,
        BRAKE_COOLDOWN
    } BrakeState_E;
    
    static BrakeState_E brakeState = BRAKE_IDLE;
    static uint8_t flashCount = 0;
    static bool lightOn = false;
    
    if (enable) {
        switch (brakeState) {
            case BRAKE_IDLE:
                IO_SET_BRAKE_LIGHT_EN(HIGH);
                lightOn = true;
                flashCount = 0;
                brakeState = BRAKE_FLASHING;
                SysTick_TimerStart(brakeTimer);
                break;
            case BRAKE_FLASHING:
                if (SysTick_TimeOut(brakeTimer)) {
                    if (lightOn) {
                        IO_SET_BRAKE_LIGHT_EN(LOW);
                        lightOn = false;
                    } else {
                        IO_SET_BRAKE_LIGHT_EN(HIGH);
                        lightOn = true;
                        flashCount++;
                        if (flashCount >= BRAKE_LIGHT_FLASH_COUNT) {
                            brakeState = BRAKE_ON_SOLID;
                            break;
                        }
                    }
                    SysTick_TimerStart(brakeTimer);
                }
                break;
            case BRAKE_ON_SOLID:
                IO_SET_BRAKE_LIGHT_EN(HIGH);
                break;
            case BRAKE_COOLDOWN:
                IO_SET_BRAKE_LIGHT_EN(HIGH);
                break;
        }
    } else {
        switch (brakeState) {
            case BRAKE_IDLE:
                IO_SET_BRAKE_LIGHT_EN(LOW);
                break;
            case BRAKE_FLASHING:
            case BRAKE_ON_SOLID:
                IO_SET_BRAKE_LIGHT_EN(LOW);
                brakeState = BRAKE_COOLDOWN;
                SysTick_TimerStart(brakeCooldownTimer);
                break;
            case BRAKE_COOLDOWN:
                IO_SET_BRAKE_LIGHT_EN(LOW);
                if (SysTick_TimeOut(brakeCooldownTimer)) {
                    brakeState = BRAKE_IDLE;
                    flashCount = 0;
                    lightOn = false;
                }
                break;
        }
    }
}

/*** End of File **************************************************************/
