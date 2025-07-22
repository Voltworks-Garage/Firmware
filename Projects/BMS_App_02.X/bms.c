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
state(idle) /* init state for startup code */ \
state(voltage)\
state(temperature)\
state(balance)\
state(data_complete)\
state(error)

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

typedef void(*bmsStatePtr)(BMS_entry_types_E);

/******************************************************************************
 * State Variables
 *******************************************************************************/
BMS_STATES(FUNCTION_FORM)
static bmsStatePtr bms_state_functions[] = {BMS_STATES(FUNC_PTR_FORM)};

static BMS_states_E prevState = 0;
static BMS_states_E curState = 0;
static BMS_states_E nextState = idle_state;

/******************************************************************************
 * Internal Variables
 *******************************************************************************/
static uint32_t balancing_mask = 0;
NEW_TIMER(error_timer, 3000); // 3000ms timer for BMS error operations

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
    
    nextState = idle_state;
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

void idle(BMS_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            break;
        case RUN:
            LTC6802_1_SetGPIO1(0, true, false);
            LTC6802_1_SetGPIO1(1, true, true);
            nextState = voltage_state;
            break;
        case EXIT:
            break;
        default:
            break;
    }
}

void voltage(BMS_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            // Start new measurement cycle every 10ms if driver is ready
            if (LTC6802_1_StartCellVoltageADC() != LTC6802_1_ERROR_NONE) {
                // If error, move to error state
                nextState = error_state;
            }
            break;
        case RUN:
            // If busy, just wait for next 10ms cycle
            if (!LTC6802_1_IsBusy()) {
                nextState = temperature_state;
            }
            break;
        case EXIT:
            break;
        default:
            break;
    }
}

void temperature(BMS_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            // Driver completed voltage operation, now start temperature
            if (!LTC6802_1_StartTemperatureADC() == LTC6802_1_ERROR_NONE) {
                // If error, move to error state
                nextState = error_state;
            }
            break;
        case RUN:
            // Check if voltage data is ready
            if (!LTC6802_1_IsBusy()) {
                nextState = balance_state;
            }
            break;
        case EXIT:
            break;
        default:
            break;
    }
}

void balance(BMS_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            break;
        case RUN:
            // Check if temperature data is ready
            if (!LTC6802_1_IsBusy()) {
                // Both voltage and temperature data are now available
                nextState = data_complete_state;
            }
            break;
        case EXIT:
            break;
        default:
            break;
    }
}

void data_complete(BMS_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            break;
        case RUN:
            // Data is ready for BMS processing
            // Reset for next cycle
            LTC6802_1_SetGPIO1(0, false, false);
            LTC6802_1_SetGPIO1(1, false, true);
            nextState = idle_state;
            break;
        case EXIT:
            break;
        default:
            break;
    }
}

void error(BMS_entry_types_E entry_type) {
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
                nextState = idle_state;
            }
            break;
        case EXIT:
            // Clear error and return to idle
            break;
        default:
            break;
    }
}


bool BMS_IsDataReady(void) {
    return (curState == data_complete_state);
}

uint16_t BMS_GetCellVoltage(uint8_t cell_id) {
    // Direct pass-through to driver with staleness detection
    return LTC6802_1_GetCellVoltage(cell_id);
}

float BMS_GetTemperatureVoltage(uint8_t temp_id) {
    // Direct pass-through to driver with staleness detection
    return LTC6802_1_GetTemperatureVoltage(temp_id);
}

void BMS_SetCellBalancing(uint8_t cell_id, bool enable, bool send_immediately) {
    if (cell_id >= LTC6802_1_TOTAL_CELLS) {
        return;
    }
    
    // Update local balancing mask
    if (enable) {
        balancing_mask |= (1UL << cell_id);
    } else {
        balancing_mask &= ~(1UL << cell_id);
    }
    
    // Apply to driver (non-blocking) using new API
    LTC6802_1_SetCellBalancing(cell_id, enable, send_immediately);
}

void BMS_ClearAllCellBalancing(void) {
    balancing_mask = 0;
    LTC6802_1_ClearAllCellBalancing();
}

