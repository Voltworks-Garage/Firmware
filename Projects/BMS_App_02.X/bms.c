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
#include "bms_dbc.h"

/******************************************************************************
 * defines
 *******************************************************************************/
#define BMS_MAX_CHARGE_VOLTAGE_ALLOWED (LTC6802_1_TOTAL_CELLS * 4.2f)
#define BMS_MAX_CHARGE_CURRENT_ALLOWED (30)

/******************************************************************************
 * State Machine Definition
 *******************************************************************************/
#define BMS_STATES(state)\
state(bms_init) /* initialization state */ \
state(bms_running) /* main operation state */ \
state(bms_error) /* error handling state */

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
static BMS_states_E nextState = bms_init_state;

/******************************************************************************
 * Internal Variables
 *******************************************************************************/
static bool bms_balancingAllowed = false;
NEW_TIMER(error_timer, 3000); // 3000ms timer for BMS error operation
NEW_TIMER(balancing_timer, 1000); // 1000ms timer for balancing operations
NEW_TIMER(led_timer, 500);
static uint32_t bms_voltageTargetmV = BMS_MAX_CHARGE_VOLTAGE_ALLOWED * 1000;
static uint32_t bms_currentTargetmA = BMS_MAX_CHARGE_CURRENT_ALLOWED * 1000;
static uint16_t bms_highestCellVoltagemV = 0;
static uint16_t bms_lowestCellVoltagemV = 0;

// BMS voltage calculation variables
static float bms_stackVoltage[LTC6802_1_NUM_STACKS] = {0.0f};
static float bms_packVoltage = 0.0f;

/******************************************************************************
 * Private Function Prototypes
 *******************************************************************************/
static void bms_taperCurrentCommandForBalancing(void);
static uint8_t bms_calculateCellsToBalance(uint8_t* cells_to_balance);
static void bms_calculateStackVoltages(void);


/******************************************************************************
 * Public Function Implementations
 *******************************************************************************/

void BMS_Init(void) {
    // Initialize the stateful LTC6802-1 driver
    LTC6802_1_Init();
    
    // Configure for BMS operation with safe defaults
    
    // Reset to safe defaults first
    LTC6802_1_ResetConfigToDefaults();
    
    // Set voltage thresholds for safe BMS operation
    // 4.2V overvoltage, 2.5V undervoltage (converted to millivolts)
    LTC6802_1_SetVoltageThresholds(4200, 2500);
    
    // Enable monitoring for all 12 cells on both stacks
    LTC6802_1_SetCellMonitoring(LTC6802_1_ALL_STACKS, 0x0FFF);
    
    // Set ADC mode to normal for balanced speed/accuracy
    LTC6802_1_SetADCMode(LTC6802_1_ADC_MODE_NORMAL);
    
    // Configure GPIO pins as inputs initially
    LTC6802_1_SetGPIO1(LTC6802_1_ALL_STACKS, true);
    
    // Enable temperature measurement
    LTC6802_1_SetPolling(true);
    
    // Enable voltage comparison for fault detection
    LTC6802_1_EnableVoltageComparison(LTC6802_1_ALL_STACKS, true);
    
    // Configuration will be sent automatically by autonomous driver
    
    nextState = bms_init_state;
}

void BMS_Run_1ms(void) {
    // Always run the stateful driver state machine
    LTC6802_1_Run();
}

void BMS_Run_10ms(void) {

    // If we are getting a charge request, that means we are in a charging state. (negative logic)
    if (CAN_bms_charger_request_start_charge_not_request_get()){
        bms_balancingAllowed = false;
    } else {
        bms_balancingAllowed = true;
    }

    CAN_bms_ltc_debug_M2_max_charge_current_allowed_mA_set(bms_currentTargetmA);
    CAN_bms_ltc_debug_M3_max_charge_voltage_allowed_mV_set(bms_voltageTargetmV);
    

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

static void bms_init(BMS_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            // Start the autonomous LTC driver
            LTC6802_1_Resume();
            break;
        case RUN:
            // Move to running state immediately
            nextState = bms_running_state;
            break;
        case EXIT:
            break;
        default:
            break;
    }
}

static void bms_running(BMS_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            SysTick_TimerStart(led_timer);
            break;
        case RUN:
            // Main BMS operation - process available data
            
            // Calculate stack and pack voltages from individual cell data
            bms_calculateStackVoltages();
            
            // Handle balancing decisions
            if (bms_balancingAllowed) {
                // Calculate which cells need balancing
                static uint8_t cells_to_balance[MAX_BALANCE_CELLS];
                uint8_t num_cells = bms_calculateCellsToBalance(cells_to_balance);
                
                if (num_cells > 0) {
                    // If balancing is not active, start it with current decisions
                    if(!LTC6802_1_IsBalancingActive()){
                        // Set which cells to balance in the driver and start balancing
                        LTC6802_1_SetCellsToBalance(cells_to_balance, num_cells);
                        LTC6802_1_StartCellBalancing();
                        SysTick_TimerStart(balancing_timer);
                    }
                }

                // If a cell is over the balance threshold, start to taper the current
                bms_taperCurrentCommandForBalancing();
            } else {
                BMS_ClearAllCellBalancing();
            }

            // Handle balancing timeout
            if (SysTick_TimeOut(balancing_timer)){
                BMS_ClearAllCellBalancing();
            }
            
            // Toggle GPIO for debugging/indication
            if(SysTick_TimeOut(led_timer)){
                static bool led = false;
                LTC6802_1_SetGPIO1(0, led);
                LTC6802_1_SetGPIO1(1, !led);
                led = !led;
                SysTick_TimerStart(led_timer);
            }
            
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
            // Halt LTC driver and reset
            LTC6802_1_Halt();
            SysTick_TimerStart(error_timer);
            LTC6802_1_ClearError(0); // Clear error for stack 0
            LTC6802_1_ClearError(1); // Clear error for stack 1
            LTC6802_1_ResetStats();
            break;
        case RUN:
            // Stay in error state until cleared
            if (SysTick_TimeOut(error_timer)) {
                nextState = bms_init_state;  // Return to init to restart
            }
            break;
        case EXIT:
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
    bms_balancingAllowed = allowed;
}


static uint8_t bms_calculateCellsToBalance(uint8_t* cells_to_balance) {
    uint8_t i, j;
    uint16_t cell_voltage;
    uint16_t top_voltages[MAX_BALANCE_CELLS] = {0};
    uint8_t top_indices[MAX_BALANCE_CELLS] = {0};
    uint16_t min_voltage = 0xFFFF;
    uint16_t max_voltage = 0;
    uint8_t num_cells_to_balance = 0;
    
    // Find min and max voltages
    for (i = 0; i < LTC6802_1_TOTAL_CELLS; i++) {
        cell_voltage = LTC6802_1_GetCellVoltage(i);
        if (cell_voltage != 0) {  // 0 indicates invalid data from LTC driver
            if (cell_voltage < min_voltage) {
                min_voltage = cell_voltage;
                bms_lowestCellVoltagemV = cell_voltage;
            }
            if (cell_voltage > max_voltage) {
                max_voltage = cell_voltage;
                bms_highestCellVoltagemV = cell_voltage;
            }
        }
    }

    // Check if all cells are below the minimum threshold for balancing
    if (max_voltage < MINIMUM_BALANCE_VOLTAGE_MV){
        return 0;  // No balancing needed
    }
    
    // Check if all cells are within threshold
    if ((max_voltage - min_voltage) <= BALANCE_VOLTAGE_THRESHOLD_MV) {
        return 0;  // No balancing needed
    }
    
    // Find the highest voltage cells that need balancing
    uint16_t balance_threshold = min_voltage + BALANCE_VOLTAGE_THRESHOLD_MV;
    
    for (i = 0; i < LTC6802_1_TOTAL_CELLS; i++) {
        cell_voltage = LTC6802_1_GetCellVoltage(i);
        if (cell_voltage != 0 && cell_voltage > balance_threshold && cell_voltage > MINIMUM_BALANCE_VOLTAGE_MV) {
            // Insert into sorted top list
            if (cell_voltage > top_voltages[MAX_BALANCE_CELLS-1]) {
                j = MAX_BALANCE_CELLS - 1;
                while (j > 0 && cell_voltage > top_voltages[j-1]) {
                    top_voltages[j] = top_voltages[j-1];
                    top_indices[j] = top_indices[j-1];
                    j--;
                }
                top_voltages[j] = cell_voltage;
                top_indices[j] = i;
            }
        }
    }
    
    // Count valid entries and copy to output array
    for (i = 0; i < MAX_BALANCE_CELLS; i++) {
        if (top_voltages[i] > 0) {
            cells_to_balance[num_cells_to_balance] = top_indices[i];
            num_cells_to_balance++;
        }
    }
    
    return num_cells_to_balance;
}

static void bms_taperCurrentCommandForBalancing(void){

    // Check if the highest cell is within balancing range
    if (bms_highestCellVoltagemV > MINIMUM_BALANCE_VOLTAGE_MV){
        
        // Find the greatest cell delta.
        uint16_t cell_delta = bms_highestCellVoltagemV - bms_lowestCellVoltagemV;

        // As the cell_delta increases, decrease the charge current.
        if (cell_delta <= 50) {
            bms_currentTargetmA = 5000;
        } else if (cell_delta <= 100) {
            bms_currentTargetmA = 2000;
        } else if (cell_delta <= 200) {
            bms_currentTargetmA = 500;
        } else {
            bms_currentTargetmA = 100;
        }   

        // As the charge voltage approaches full, decrease the charge current .
        uint16_t cellVoltageRemaining = 4200 - bms_highestCellVoltagemV;
        if (cellVoltageRemaining <= 50) {
            bms_currentTargetmA = bms_currentTargetmA / 10;  // 0.1 multiplier
        } else if (cellVoltageRemaining <= 100) {
            bms_currentTargetmA = bms_currentTargetmA / 4;  // 0.25 multiplier
        } else if (cellVoltageRemaining <= 200) {
            bms_currentTargetmA = bms_currentTargetmA / 2;  // 0.5 multiplier
        }

        // Round up to nearest 100mA because that is the minimum resolution of the charger.
        bms_currentTargetmA = ((bms_currentTargetmA + 99) / 100) * 100;
    }
}

static void bms_calculateStackVoltages(void) {
    // Calculate stack voltages and pack voltage using integer arithmetic
    uint32_t pack_voltage_raw = 0;
    
    for (uint8_t stack = 0; stack < LTC6802_1_NUM_STACKS; stack++) {
        uint32_t stack_voltage_raw = 0;
        
        // Sum all valid cell voltages for this stack (raw ADC counts)
        for (uint8_t cell = 0; cell < LTC6802_1_CELLS_PER_STACK; cell++) {
            uint8_t cell_index = stack * LTC6802_1_CELLS_PER_STACK + cell;
            uint16_t cell_voltage = LTC6802_1_GetCellVoltage(cell_index);
            
            // Only add if we got valid data (not 0)
            if (cell_voltage != 0) {
                stack_voltage_raw += cell_voltage;
            }
        }
        
        // Convert to volts and store result
        bms_stackVoltage[stack] = (float)stack_voltage_raw / 1000.0f; // Convert mV to V
        
        // Add this stack's raw voltage to total pack voltage
        pack_voltage_raw += stack_voltage_raw;
    }
    
    // Convert pack voltage to volts
    bms_packVoltage = (float)pack_voltage_raw / 1000.0f; // Convert mV to V
}

float BMS_GetStackVoltage(uint8_t stack_id) {
    if (stack_id >= LTC6802_1_NUM_STACKS) {
        return 0.0f;
    }
    return bms_stackVoltage[stack_id];
}

float BMS_GetPackVoltage(void) {
    return bms_packVoltage;
}

