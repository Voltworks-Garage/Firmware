/**
 * @file bms.c
 * @brief BMS application implementation using stateful LTC6802-1 driver
 * 
 * This provides a clean interface between the BMS application and the
 * stateful LTC6802-1 driver. No callbacks, just simple request/response.
 * 
 * @author Generated for Voltworks Garage
 * @date 2025
 */

#include "bms.h"
#include "ltc6802_1_nb.h"
#include "SysTick.h"

/******************************************************************************
 * State Machine Definition
 *******************************************************************************/
#define BMS_STATES(state)\
state(bms_idle) /* init state for startup code */ \
state(bms_voltage)\
state(bms_temperature)\
state(bms_flag)\
state(bms_balance)\
state(bms_dataComplete)\
state(bms_error)

/*Creates an enum of states suffixed with _state*/
#define STATE_FORM(WORD) WORD##_state,
#define FUNCTION_FORM(WORD) static void WORD(BMS_entry_types_E entry_type);
#define FUNC_PTR_FORM(WORD) WORD,

/******************************************************************************
 * Typedefs
 *******************************************************************************/
typedef enum {
    BMS_STATES(STATE_FORM)
    NUMBER_OF_BMS_STATES
} BMS_states_E;

typedef enum {
    ENTRY,
    EXIT,
    RUN
} BMS_entry_types_E;

typedef void(*bmsState_FPtr)(BMS_entry_types_E);

/******************************************************************************
 * State Variables
 *******************************************************************************/
BMS_STATES(FUNCTION_FORM)
static bmsState_FPtr bms_state_functions[] = {BMS_STATES(FUNC_PTR_FORM)};

static BMS_states_E prevState = 0;
static BMS_states_E curState = 0;
static BMS_states_E nextState = bms_idle_state;

/******************************************************************************
 * Internal Variables
 *******************************************************************************/
static bool balancingAllowed = false;
NEW_TIMER(error_timer, 3000); // 3000ms timer for BMS error operation
NEW_TIMER(balancing_timer, 1000); // 1000ms timer for balancing operations

/******************************************************************************
 * Public Function Implementations
 *******************************************************************************/

void BMS_Init(void) {
    // Initialize the stateful LTC6802-1 driver
    LTC6802_1_Init();
    
    // Configure for BMS operation with safe defaults
    
    // Reset to safe defaults first
    LTC6802_1_ResetConfigToDefaults(false);
    
    // Set voltage thresholds for safe BMS operation
    // 4.2V overvoltage, 2.5V undervoltage (converted to millivolts)
    LTC6802_1_SetVoltageThresholds(4200, 2500, false);
    
    // Enable monitoring for all 12 cells on both stacks
    LTC6802_1_SetCellMonitoring(LTC6802_1_ALL_STACKS, 0x0FFF, false);
    
    // Set ADC mode to normal for balanced speed/accuracy
    LTC6802_1_SetADCMode(LTC6802_1_ADC_MODE_NORMAL, false);
    
    // Configure GPIO pins as inputs initially
    LTC6802_1_SetGPIO1(LTC6802_1_ALL_STACKS, true, false);
    
    // Enable temperature measurement
    LTC6802_1_SetPolling(true, false);
    
    // Enable voltage comparison for fault detection
    LTC6802_1_EnableVoltageComparison(LTC6802_1_ALL_STACKS, true, false);
    
    // Send all configuration changes to hardware
    LTC6802_1_SendConfig();
    
    nextState = bms_idle_state;
}

void BMS_Run_1ms(void) {
    // Always run the stateful driver state machine
    LTC6802_1_Run();
}

void BMS_Run_10ms(void) {
    /* This only happens during state transition
     * State transitions thus have priority over posting new events
     * State transitions always consist of an exit event to curState and entry event to nextState */
    if (nextState != curState) {
        bms_state_functions[curState](EXIT);
        prevState = curState;
        curState = nextState;
        bms_state_functions[curState](ENTRY);
    } else {
        bms_state_functions[curState](RUN);
    }
}

/******************************************************************************
 * State Functions
 *******************************************************************************/

static void bms_idle(BMS_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            break;
        case RUN:
            LTC6802_1_SetGPIO1(0, true, false);
            LTC6802_1_SetGPIO1(1, true, true);
            nextState = bms_voltage_state;
            break;
        case EXIT:
            break;
        default:
            break;
    }
}

static void bms_voltage(BMS_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            // Start new measurement cycle every 10ms if driver is ready
            if (LTC6802_1_StartCellVoltageADC() != LTC6802_1_ERROR_NONE) {
                // If error, move to error state
                nextState = bms_error_state;
            }
            break;
        case RUN:
            // If busy, just wait for next 10ms cycle
            if (!LTC6802_1_IsBusy()) {
                nextState = bms_temperature_state;
            }
            break;
        case EXIT:
            break;
        default:
            break;
    }
}

static void bms_temperature(BMS_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            // Driver completed voltage operation, now start temperature
            if (!LTC6802_1_StartTemperatureADC() == LTC6802_1_ERROR_NONE) {
                // If error, move to error state
                nextState = bms_error_state;
            }
            break;

        case RUN:
            // Check if voltage data is ready
            if (!LTC6802_1_IsBusy()) {
                nextState = bms_flag_state;
            }
            break;

        case EXIT:
            break;
        default:
            break;
    }
}

static void bms_flag(BMS_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            // Driver completed voltage operation, now start flag read
            if (!LTC6802_1_StartFlagRead() == LTC6802_1_ERROR_NONE) {
                // If error, move to error state
                nextState = bms_error_state;
            }
            break;

        case RUN:
            // Check if voltage data is ready
            if (!LTC6802_1_IsBusy()) {
                nextState = bms_balance_state;
            }
            break;

        case EXIT:
            break;
        default:
            break;
    }
}

static void bms_balance(BMS_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            // Start balancing operation
            if (balancingAllowed) {
                // If balancing is not active, start it
                if(!LTC6802_1_IsBalancingActive()){
                    LTC6802_1_StartCellBalancing();
                    SysTick_TimerStart(balancing_timer);
                }
            } else {
                BMS_ClearAllCellBalancing();
            }

        case RUN:
                if (SysTick_TimeOut(balancing_timer)){
                    BMS_ClearAllCellBalancing();
                }
                // always move out of this state
                nextState = bms_dataComplete_state;
            break;

        case EXIT:
            break;
        default:
            break;
    }
}

static void bms_dataComplete(BMS_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            break;
        case RUN:
            // Data is ready for BMS processing
            // Reset for next cycle
            LTC6802_1_SetGPIO1(0, false, false);
            LTC6802_1_SetGPIO1(1, false, true);
            nextState = bms_idle_state;
            break;
        case EXIT:
            break;
        default:
            break;
    }
}

static void bms_error(BMS_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            SysTick_TimerStart(error_timer);
            LTC6802_1_ClearError(0); // Clear error for stack 0
            LTC6802_1_ClearError(1); // Clear error for stack 1
            LTC6802_1_ResetStats();
            break;
        case RUN:
            // Stay in error state until cleared
            if (SysTick_TimeOut(error_timer)) {
                nextState = bms_idle_state;
            }
            break;
        case EXIT:
            // Clear error and return to idle
            break;
        default:
            break;
    }
}


uint16_t BMS_GetCellVoltage(uint8_t cellId) {
    // Direct pass-through to driver with staleness detection
    return LTC6802_1_GetCellVoltage(cellId);
}

float BMS_GetTemperatureVoltage(uint8_t tempId) {
    // Direct pass-through to driver with staleness detection
    return LTC6802_1_GetTemperatureVoltage(tempId);
}

void BMS_ClearAllCellBalancing(void) {
    // Direct pass-through to driver
    LTC6802_1_ClearAllCellBalancing();
}

void BMS_SetBalancingIsAllowed(bool allowed){
    balancingAllowed = allowed;
}

