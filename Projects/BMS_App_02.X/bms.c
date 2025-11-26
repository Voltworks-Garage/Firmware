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

// Cell voltage safety thresholds
#define CELL_VOLTAGE_CRITICAL_MAX_MV 4250    // Critical Maximum cell voltage (4.25V)
#define CELL_VOLTAGE_MAX_MV 4200 // Maximum cell voltage (4.20V)
#define CELL_VOLTAGE_MIN_MV 3000    // Minimum safe cell voltage (3.00V)
#define CELL_VOLTAGE_CRITICAL_MIN_MV 2500 // Critical Minimum cell voltage (2.50V)

#define CHARGE_COMPLETION_VOLTAGE_DELTA_MV 5 // 5mV delta for charge completion

/******************************************************************************
 * State Machine Definition
 *******************************************************************************/
#define BMS_STATES(state)\
state(bms_init) /* initialization state */ \
state(bms_monitoring) /* main operation state */ \
state(bms_charging) /* balancing state */ \
state(bms_charge_complete) /* charge complete state */ \
state(bms_error) /* error handling state */ \

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
static bool bms_chargingAllowed = true;
static bool bms_dischargeAllowed = true;
static bool bms_lowVoltageWarning = false;
static uint32_t bms_maxDischargeCurrentAllowedmA = 60 * 1000; // 60A default
static uint32_t bms_maxChargeCurrentAllowedmA = BMS_MAX_CHARGE_CURRENT_ALLOWED * 1000;

static uint32_t bms_voltageTargetmV = BMS_MAX_CHARGE_VOLTAGE_ALLOWED * 1000;


NEW_TIMER(error_timer, 3000); // 3000ms timer for BMS error operation
NEW_TIMER(balancing_timer, 10000); // 10 second timer for balancing operations
NEW_TIMER(measuring_timer, 2000); // 1 second timer to measure relaxed voltages
NEW_TIMER(led_timer, 500);

static uint16_t bms_highestCellVoltagemV = 0;
static uint16_t bms_lowestCellVoltagemV = 0;
static uint16_t cells_to_balance[MAX_BALANCE_CELLS];
static uint16_t num_cells_to_balance = 0;
static uint16_t balancing_state = 0;


// Balancing current states for really out of balance cells
typedef enum {
    BALANCING_CURRENT_RAMP,
    BALANCING_CURRENT_NOMINAL,
    BALANCING_CURRENT_TAPERED,
    BALANCING_CURRENT_OFF,
} balancing_state_t;
static balancing_state_t balancing_current_state = BALANCING_CURRENT_RAMP;

// BMS voltage calculation variables
static uint16_t bms_cell_voltages[LTC6802_1_TOTAL_CELLS] = {0};
static float bms_stackVoltage[LTC6802_1_NUM_STACKS] = {0.0f};
static float bms_packVoltage = 0.0f;
static bool bms_cellVoltageError = false;

/******************************************************************************
 * Private Function Prototypes
 *******************************************************************************/
static void bms_taperCurrentCommandForBalancing(void);
static void bms_getCellVoltages(void);
static uint16_t bms_calculateCellsToBalance(void);
static void bms_calculateStackVoltages(void);
static void bms_CheckCellVoltageThresholds(void);
static void bms_runMonitoringSequence(void);
static void bms_runBalancingSequence(void);
static bool bms_checkChargingCompletion(void);
static void bms_setCANBalancingStatusMessages(void);
void bms_ClearAllCellBalancing(void);


/******************************************************************************
 * State Machine Public Function Implementations
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
    
    // Initialize state machine variables
    curState = bms_init_state;
    nextState = bms_init_state;
    prevState = bms_init_state;
    bms_state_functions[curState](ENTRY);
}

void BMS_Run_1ms(void) {
    // Always run the stateful driver state machine
    LTC6802_1_Run();
}

void BMS_Run_10ms(void) {

    // If the EV_Charger Fets are on, we are in a charging state. Allow balancing.
    if (CAN_bms_power_systems_EV_charger_state_get()){
        bms_balancingAllowed = true;
    } else {
        bms_balancingAllowed = false;
    }

    CAN_bms_status_max_charge_current_mA_set(bms_maxChargeCurrentAllowedmA);
    CAN_bms_status_max_charge_voltage_mV_set(bms_voltageTargetmV);

    CAN_bms_status_discharge_allowed_set(BMS_GetDischargingAllowed());
    CAN_bms_status_charge_allowed_set(BMS_GetChargingAllowed());

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
            nextState = bms_monitoring_state;
            break;
        case EXIT:
            balancing_current_state = BALANCING_CURRENT_RAMP;
            break;
        default:
            break;
    }
}

static void bms_monitoring(BMS_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            SysTick_TimerStart(led_timer);
            bms_ClearAllCellBalancing();
            break;
        case RUN:
            
            bms_runMonitoringSequence();

            if (bms_balancingAllowed) {
                nextState = bms_charging_state;
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
            bms_ClearAllCellBalancing();
            break;
        default:
            break;
    }
}

static void bms_charging(BMS_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            // Start balancing process
            SysTick_TimerStart(led_timer);
            bms_ClearAllCellBalancing();
            break;
        case RUN:
            // Handle balancing decisions
            bms_runBalancingSequence();

            // Update which cells are balancing
            bms_setCANBalancingStatusMessages();

            if (!bms_balancingAllowed) {
                nextState = bms_monitoring_state;
                break;
            }

            if (bms_checkChargingCompletion()) {
                nextState = bms_charge_complete_state;
                break;
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
            // Stop balancing process
            bms_ClearAllCellBalancing();
            bms_setCANBalancingStatusMessages();
            break;
        default:
            break;
    }
}

static void bms_charge_complete(BMS_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            // Indicate charge complete
            SysTick_TimerStart(led_timer);
            CAN_bms_status_charge_complete_set(1);
            break;
        case RUN:

            bms_runMonitoringSequence();

            // Stay in this state until charging is disabled
            if (!bms_balancingAllowed) {
                nextState = bms_monitoring_state;
            }

            // If cells drop below threshold, resume charging
            if (!bms_checkChargingCompletion()) {
                nextState = bms_charging_state;
                break;
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
            CAN_bms_status_charge_complete_set(0);
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
            LTC6802_1_ClearError(); // Clear all errors
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

static uint16_t bms_calculateCellsToBalance(void) {
    uint16_t i, j;
    uint16_t cell_voltage;
    uint16_t top_voltages[MAX_BALANCE_CELLS] = {0};
    uint16_t top_indices[MAX_BALANCE_CELLS] = {0};

    uint16_t cell_delta = 0;
    
    cell_delta = bms_highestCellVoltagemV - bms_lowestCellVoltagemV;

    // Check if all cells are below the minimum threshold for balancing
    if (bms_highestCellVoltagemV < (MINIMUM_BALANCE_VOLTAGE_MV - cell_delta)){
        return 0;  // No balancing needed
    }
    
    // Check if all cells are within threshold
    if (cell_delta <= BALANCE_VOLTAGE_THRESHOLD_MV) {
        return 0;  // No balancing needed
    }
    
    // Find the highest voltage cells that need balancing
    uint16_t balance_threshold = bms_lowestCellVoltagemV + BALANCE_VOLTAGE_THRESHOLD_MV;

    for (uint16_t i = 0; i < LTC6802_1_TOTAL_CELLS; i++) {
        cell_voltage = bms_cell_voltages[i];
        if (cell_voltage != 0 && cell_voltage > balance_threshold && cell_voltage > (MINIMUM_BALANCE_VOLTAGE_MV - cell_delta)) {
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
    
    num_cells_to_balance = 0;
    // Count valid entries and copy to output array
    for (i = 0; i < MAX_BALANCE_CELLS; i++) {
        if (top_voltages[i] > 0) {
            cells_to_balance[num_cells_to_balance] = top_indices[i];
            num_cells_to_balance++;
        }
    }
    
    return num_cells_to_balance;
}

void bms_ClearAllCellBalancing(void) {
    // Direct pass-through to driver
    LTC6802_1_ClearAllCellBalancing();
    num_cells_to_balance = 0;
}

static void bms_runMonitoringSequence(void){

    // Always refresh cell voltages
    bms_getCellVoltages();

    //Check min/max voltages for all cells.
    bms_CheckCellVoltageThresholds();

    // Calculate stack and pack voltages from individual cell data
    bms_calculateStackVoltages();
}

static void bms_runBalancingSequence(void){

    switch (balancing_state) {
        case 0:
            // If balancing is not active, start it with current decisions
            if(!LTC6802_1_IsBalancingActive()){

                //refresh cell voltages
                bms_getCellVoltages();

                //Check min/max voltages for all cells.
                bms_CheckCellVoltageThresholds();
                
                // Calculate stack and pack voltages from individual cell data
                bms_calculateStackVoltages();

                // Calculate which cells need balancing
                bms_calculateCellsToBalance();

                // If a cell is over the balance threshold, start to taper the current
                bms_taperCurrentCommandForBalancing();

                // Start balancing with the selected cells
                LTC6802_1_StartCellBalancing(cells_to_balance, num_cells_to_balance);
                SysTick_TimerStart(balancing_timer);
                balancing_state++;
            } else {
                // If balancing is already active, just clear it. We shouldn't be here.
                bms_ClearAllCellBalancing();
            }
            break;
        case 1:
            // After balancing, take a measurement break to allow voltages to settle
            if (SysTick_TimeOut(balancing_timer)){
                bms_ClearAllCellBalancing();
                SysTick_TimerStart(measuring_timer);
                balancing_state++;
            }
            break;
        case 2:
            // After measurement settling, go back an calculate cells to balance
            if (SysTick_TimeOut(measuring_timer)){
                balancing_state = 0;
            }
            break;
        default:
            break;
    }

}

static bool bms_checkChargingCompletion(void){
    bool packIsCharged = false;
    // Check if the pack is fully charged
    bool delta_within_limit = (bms_highestCellVoltagemV - bms_lowestCellVoltagemV) <= CHARGE_COMPLETION_VOLTAGE_DELTA_MV;
    bool at_target_voltage = bms_highestCellVoltagemV >= (CELL_VOLTAGE_MAX_MV - CHARGE_COMPLETION_VOLTAGE_DELTA_MV);
    bool current_tapered = CAN_bms_power_systems_EV_charger_current_get() <= 400; // 400mA threshold

    if (delta_within_limit && at_target_voltage && current_tapered) {
        packIsCharged = true;
    }
    return packIsCharged;
}

static void bms_setCANBalancingStatusMessages(void){
    CAN_bms_status_is_balancing_set(bms_balancingAllowed);
    for (uint8_t i = 0; i < 5; i++) {
        uint8_t cell_id = i < num_cells_to_balance ? (cells_to_balance[i]+1) : 0x00;
        switch (i) {
            case 0:
                CAN_bms_status_cell_A_balancing_set(cell_id);
                break;
            case 1:
                CAN_bms_status_cell_B_balancing_set(cell_id);
                break;
            case 2:
                CAN_bms_status_cell_C_balancing_set(cell_id);
                break;
            case 3:
                CAN_bms_status_cell_D_balancing_set(cell_id);
                break;
            case 4:
                CAN_bms_status_cell_E_balancing_set(cell_id);
                break;
            default:
                break;
        }
    }
}

static void bms_taperCurrentCommandForBalancing(void){

    static uint8_t cell_charge_voltage_hysterisis = 0; //100mV hyst

    static const uint16_t ramp_timer = 10000; //10 seconds to ramp up current

    // Check if the highest cell is within balancing range
    if (bms_highestCellVoltagemV > (MINIMUM_BALANCE_VOLTAGE_MV - cell_charge_voltage_hysterisis)){
        cell_charge_voltage_hysterisis = 100;
        
        // Find the greatest cell delta.
        uint16_t cell_delta = bms_highestCellVoltagemV - bms_lowestCellVoltagemV;

        switch (balancing_current_state)
        {
            case BALANCING_CURRENT_RAMP:
                // Ramp up to nominal balancing current
                bms_maxChargeCurrentAllowedmA = 0;
                balancing_current_state = BALANCING_CURRENT_NOMINAL;
                break;

            case BALANCING_CURRENT_NOMINAL:
                // if outside of normal range, taper the current
                if (cell_delta >= 10) {
                    balancing_current_state = BALANCING_CURRENT_TAPERED;
                    break;
                }
                // max current allowed in this state
                bms_maxChargeCurrentAllowedmA = BMS_MAX_CHARGE_CURRENT_ALLOWED * 1000;
                break;

            case BALANCING_CURRENT_TAPERED:
                // If we get back to nominal delta, go back to nominal current
                if (cell_delta < 10) {
                    balancing_current_state = BALANCING_CURRENT_NOMINAL;
                    break;

                // If the delta is really high and highest cell is full, turn off charging to avoid overcharging, and just balance passively  
                } else if (cell_delta >= 50 && bms_highestCellVoltagemV >= CELL_VOLTAGE_MAX_MV) {
                    balancing_current_state = BALANCING_CURRENT_OFF;
                    bms_maxChargeCurrentAllowedmA = 0;  // Stop charging to allow passive balancing
                    break;
                }

                // As the cell_delta increases, decrease the charge current.
                if (cell_delta <= 20) {
                    bms_maxChargeCurrentAllowedmA = 5000;
                } else if (cell_delta <= 30) {
                    bms_maxChargeCurrentAllowedmA = 2000;
                } else if (cell_delta <= 40) {
                    bms_maxChargeCurrentAllowedmA = 1000;
                } else {
                    bms_maxChargeCurrentAllowedmA = 500;
                }   

                // As the charge voltage approaches full, decrease the charge current .
                uint16_t cellVoltageRemaining = 4200 - bms_highestCellVoltagemV;
                if (bms_highestCellVoltagemV > 4200) { //handle overcharge case
                    cellVoltageRemaining = 0;
                }
                
                if (cellVoltageRemaining == 0) {
                    bms_maxChargeCurrentAllowedmA = 0;  // Stop charging at or above target voltage
                } else if (cellVoltageRemaining <= 25) {
                    bms_maxChargeCurrentAllowedmA = bms_maxChargeCurrentAllowedmA / 10;  // 0.1 multiplier
                } else if (cellVoltageRemaining <= 50) {
                    bms_maxChargeCurrentAllowedmA = bms_maxChargeCurrentAllowedmA / 4;  // 0.25 multiplier
                } else if (cellVoltageRemaining <= 75) {
                    bms_maxChargeCurrentAllowedmA = bms_maxChargeCurrentAllowedmA / 2;  // 0.5 multiplier
                }

                // Round down to nearest 100mA because that is the minimum resolution of the charger.
                bms_maxChargeCurrentAllowedmA = (bms_maxChargeCurrentAllowedmA / 100) * 100;
                /* code */
                break;

            case BALANCING_CURRENT_OFF:
                bms_maxChargeCurrentAllowedmA = 0;  // Stop charging to allow passive balancing


                if (cell_delta < 10 && bms_highestCellVoltagemV < (CELL_VOLTAGE_MAX_MV-20)) {
                    balancing_current_state = BALANCING_CURRENT_TAPERED;
                } else if (bms_highestCellVoltagemV < MINIMUM_BALANCE_VOLTAGE_MV) {
                    balancing_current_state = BALANCING_CURRENT_NOMINAL;
                }
                /* code */
                break;

            default:
                break;
        }


    } else {
        cell_charge_voltage_hysterisis = 0;
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
            uint16_t cell_voltage = bms_cell_voltages[cell_index];
            
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

static void bms_CheckCellVoltageThresholds(void) {
    uint16_t cell_voltage;
    uint16_t min_voltage = 0xFFFF;
    uint16_t max_voltage = 0;

    bool cellVoltageError = false;
    bool dischargeError = false;
    bool chargeError = false;

    // Find min and max voltages
    for (uint16_t i = 0; i < LTC6802_1_TOTAL_CELLS; i++) {
        cell_voltage = bms_cell_voltages[i];
        if ( cell_voltage == 0 ){
            cellVoltageError |= true;
            continue;
        }
        if (cell_voltage < min_voltage) {
            min_voltage = cell_voltage;
            bms_lowestCellVoltagemV = cell_voltage;
        }
        if (cell_voltage > max_voltage) {
            max_voltage = cell_voltage;
            bms_highestCellVoltagemV = cell_voltage;
        }
    }

    if (bms_lowestCellVoltagemV < CELL_VOLTAGE_CRITICAL_MIN_MV) {
        // Critical low voltage - disable all charging and discharging
        dischargeError = true;
        chargeError = true;
        bms_lowVoltageWarning = true;
    } else if (bms_lowestCellVoltagemV < CELL_VOLTAGE_MIN_MV) {
        // Low voltage warning - disable discharging
        dischargeError = true;
        bms_lowVoltageWarning = true;
    } else {
        bms_lowVoltageWarning = false;
    }

    if (bms_highestCellVoltagemV > CELL_VOLTAGE_MAX_MV) {
        // High voltage - disable charging
        chargeError = true;
    }
    
    bms_cellVoltageError = cellVoltageError;
    bms_dischargeAllowed = !dischargeError;
    bms_chargingAllowed = !chargeError;

}

void bms_getCellVoltages(void) {
    for (uint16_t i = 0; i < LTC6802_1_TOTAL_CELLS; i++) {
        bms_cell_voltages[i] = LTC6802_1_GetCellVoltage(i);
    }
}


/******************************************************************************
 * Public Function Implementations
 *******************************************************************************/

float BMS_GetStackVoltage(uint8_t stack_id) {
    if (stack_id >= LTC6802_1_NUM_STACKS) {
        return 0.0f;
    }
    return bms_stackVoltage[stack_id];
}

float BMS_GetPackVoltage(void) {
    return bms_packVoltage;
}

uint16_t BMS_GetCellVoltage(uint8_t cellId) {
    // Direct pass-through to driver with staleness detection
    return bms_cell_voltages[cellId];
}

float BMS_GetTemperatureVoltage(uint8_t tempId) {
    // Direct pass-through to driver with staleness detection
    return LTC6802_1_GetTemperatureVoltage(tempId);
}

bool BMS_GetChargingAllowed(void) {
    return bms_chargingAllowed && !bms_cellVoltageError;
}

bool BMS_GetDischargingAllowed(void) {
    return bms_dischargeAllowed && !bms_cellVoltageError;
}
