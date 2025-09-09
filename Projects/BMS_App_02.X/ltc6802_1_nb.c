/**
 * @file ltc6802_1_nb.c
 * @brief Non-blocking LTC6802-1 Battery Monitor Driver Implementation
 * 
 * @author Generated for Voltworks Garage
 * @date 2025
 */

#include "ltc6802_1_nb.h"
#include "spi.h"
#include "IO.h"
#include "utils.h"
#include "SysTick.h"
#include "bms_dbc.h"
#include <string.h>

/******************************************************************************
 * Internal Type Definitions
 *******************************************************************************/

/******************************************************************************
 * State Machine Definition
 *******************************************************************************/
#define LTC6802_1_STATES(state)\
state(idle) /* init state for startup code */ \
state(config_write)\
state(config_readback)\
state(cell_read)\
state(cell_data)\
state(temp_read)\
state(temp_data)\
state(flag_data)\
state(faulted)\
state(halted)\

/*Creates an enum of states suffixed with _state*/
#define STATE_FORM(WORD) WORD##_state,
#define FUNCTION_FORM(WORD) static void WORD(LTC6802_1_entry_types_E entry_type);
#define FUNC_PTR_FORM(WORD) WORD,

/**
 * @brief Operation states for non-blocking state machine using ENTRY/EXIT/RUN paradigm
 */
typedef enum {
    LTC6802_1_STATES(STATE_FORM)
    NUMBER_OF_LTC6802_1_STATES
} LTC6802_1_State_E;

typedef enum {
    ENTRY,
    EXIT,
    RUN
} LTC6802_1_entry_types_E;

typedef void(*ltcStatePtr)(LTC6802_1_entry_types_E);

/******************************************************************************
 * LTC6802-1 Command Definitions
 *******************************************************************************/
// Configuration Commands
#define LTC6802_1_CMD_WRCFG         0x01    // Write Configuration
#define LTC6802_1_CMD_RDCFG         0x02    // Read Configuration

// Cell Voltage Commands  
#define LTC6802_1_CMD_RDCV          0x04    // Read Cell Voltages
#define LTC6802_1_CMD_STCVAD        0x10    // Start Cell Voltage ADC
#define LTC6802_1_CMD_STCVDC        0x60    // Start Cell Voltage ADC with Discharge

// Temperature Commands
#define LTC6802_1_CMD_RDTMP         0x08    // Read Temperature
#define LTC6802_1_CMD_STTMPAD       0x30    // Start Temperature ADC

// Status Commands
#define LTC6802_1_CMD_RDFLG         0x06    // Read Flags
#define LTC6802_1_CMD_PLADC         0x40    // Poll ADC Status

// Register Sizes for LTC6802-1
#define LTC6802_1_CONFIG_REG_SIZE   6       // 6 bytes per stack
#define LTC6802_1_VOLTAGE_REG_SIZE  18      // 18 bytes per stack (12 cells * 1.5 bytes)
#define LTC6802_1_TEMP_REG_SIZE     5       // 5 bytes per stack (TMPR0-TMPR4)
#define LTC6802_1_FLAG_REG_SIZE     3       // 3 bytes per stack
#define LTC6802_1_PEC_SIZE          1       // 1 byte PEC for each register read/write

// Address modifier for addressed commands
#define LTC6802_1_ADDR_MASK         0x80

// Buffer sizes
#define LTC6802_1_MAX_SPI_BUFFER    64      // Maximum SPI transaction size

// Invalid data return value
#define LTC6802_1_INVALID_DATA      0



/******************************************************************************
 * Internal State Structure
 *******************************************************************************/
typedef struct {
    // State machine variables - using new paradigm
    LTC6802_1_State_E prevState;
    LTC6802_1_State_E curState;
    LTC6802_1_State_E nextState;
    // SPI timeout timer removed - now using NEW_TIMER system
    
    // Debug information
    LTC6802_1_State_E last_successful_state;
    uint8_t debug_failure_point;
    
    // SPI transaction management
    uint8_t spi_tx_buffer[LTC6802_1_MAX_SPI_BUFFER];
    uint8_t spi_rx_buffer[LTC6802_1_MAX_SPI_BUFFER];
    uint8_t spi_tx_length;
    uint8_t spi_rx_length;
    bool spi_transaction_active;
    
    // Configuration data
    LTC6802_1_Config_S config;
    uint8_t config_data[LTC6802_1_NUM_STACKS * LTC6802_1_CONFIG_REG_SIZE];
    uint8_t config_data_saved[LTC6802_1_NUM_STACKS * LTC6802_1_CONFIG_REG_SIZE];
    
    // Measurement data (staleness tracked by NEW_TIMER system)
    uint16_t voltage_data[LTC6802_1_TOTAL_CELLS];
    uint16_t temp_data[LTC6802_1_TOTAL_TEMPS];
    bool voltage_data_valid;
    bool temp_data_valid;
    
    // Additional temperature register data
    uint8_t rev_number[LTC6802_1_NUM_STACKS];
    bool thsd_flag[LTC6802_1_NUM_STACKS];
    
    // Calculated voltage values removed - now handled by BMS layer
    
    // Simple error logging
    LTC6802_1_Error_Entry_S error_buffer[16];
    
    uint8_t error_write_index;
    uint16_t total_error_count;
    
    // Statistics
    uint32_t total_transactions;
    uint32_t failed_transactions;
    uint32_t total_retries;
    
    // Cell balancing data
    uint16_t min_voltage;
    uint16_t min_cell_number;
    uint16_t max_voltage;
    uint16_t max_cell_number;
    uint16_t cells_to_balance[MAX_BALANCE_CELLS];
    uint16_t num_cells_to_balance;
    bool balancing_active;
    
} LTC6802_1_Module_S;

/******************************************************************************
 * State Functions and Variables
 *******************************************************************************/
LTC6802_1_STATES(FUNCTION_FORM)
static ltcStatePtr ltc6802_1_state_functions[] = {LTC6802_1_STATES(FUNC_PTR_FORM)};

/******************************************************************************
 * Static Variables
 *******************************************************************************/
static LTC6802_1_Module_S ltc_module;

// SPI timeout timer
NEW_TIMER(ltc6802_spiTimer, 2);
// ADC Conversion Timer
NEW_TIMER(adc_conversion_timer,13*LTC6802_1_CELLS_PER_STACK);
NEW_TIMER(temp_conversion_timer,13*LTC6802_1_TEMPS_PER_STACK);
// Data staleness timers
NEW_TIMER(voltage_data_timer, LTC6802_1_DATA_STALE_TIME_MS);
NEW_TIMER(temp_data_timer, LTC6802_1_DATA_STALE_TIME_MS);


/******************************************************************************
 * Internal Function Prototypes
 *******************************************************************************/
static LTC6802_1_Error_E StartSPITransaction(uint8_t command, 
                                            const uint8_t* tx_data, uint8_t data_len,
                                            bool expect_response, uint8_t response_len);
static void TransitionToIdle(void);
static void TransitionToFaulted(LTC6802_1_Error_E error);

// Simplified error handling functions
static void LogError(LTC6802_1_Error_E error_type);
static void ProcessVoltageData(void);
static void ProcessTemperatureData(void);
static void ProcessFlagData(void);
static void ProcessConfigData(void);
static void BuildConfigData(void);
static void SaveConfigMSG(void);
// CalculateStackVoltages moved to BMS layer
static uint8_t CalculateCRC(const uint8_t* data, uint8_t length);
static bool ValidateCRC(const uint8_t* data, uint8_t length, uint8_t received_crc);

/******************************************************************************
 * Public Function Implementations
 *******************************************************************************/

LTC6802_1_Error_E LTC6802_1_Init(void) {
    // Clear all module data
    memset(&ltc_module, 0, sizeof(ltc_module));
    
    // Initialize SPI
    IO_SET_SPI_CS(HIGH);
    spi1Init();
    
    // Set initial state
    ltc_module.nextState = idle_state;
    ltc_module.curState = idle_state;
    ltc_module.prevState = idle_state;
    
    // Initialize default configuration
    for (uint8_t i = 0; i < LTC6802_1_NUM_STACKS; i++) {
        ltc_module.config.discharge_cells[i] = 0;                       // No cell balancing initially
        ltc_module.config.monitor_cells[i] = 0x0FFF;                    // Monitor all 12 cells per stack
        ltc_module.config.gpio1_state[i] = true;              // GPIO1 as open drain input/high per stack
        ltc_module.config.gpio2_state[i] = false;              // GPIO2 unused and is input/low per stack
    }
    
    // Global settings (same for all stacks)
    ltc_module.config.overvoltage_threshold = 0xFF;                    // Max threshold initially
    ltc_module.config.undervoltage_threshold = 0x00;                   // Min threshold initially
    ltc_module.config.wdt_enable = false;                              // Watchdog disabled
    ltc_module.config.lvlpl_enable = false;                            // Level polling disabled
    ltc_module.config.cell10_enable = false;                           // 10th cell disabled
    ltc_module.config.cdc_mode = 0;                                     // Default CDC mode
    
    // Build initial config data
    BuildConfigData();
    
    return LTC6802_1_ERROR_NONE;
}

void LTC6802_1_Run(void) {

    // Check if SPI transaction is complete
    if (ltc_module.spi_transaction_active) {
        if (spi1IsBufferedTransactionComplete()) {
            // Transaction completed
            (void)spi1GetBufferedTransactionResult();  // Consume result to clear status
            ltc_module.spi_transaction_active = false;
            
            // Reset CS line
            IO_SET_SPI_CS(HIGH);
        }
        
        // Check for SPI timeout
        else if (SysTick_TimeOut(ltc6802_spiTimer)) {
            
            LogError(LTC6802_1_ERROR_SPI_TIMEOUT);
            ltc_module.spi_transaction_active = false;
            IO_SET_SPI_CS(HIGH);
            uint8_t tx_index, rx_index;
            // Get current transaction indices
            spi1GetTransactionIndices(&tx_index, &rx_index);
            CAN_bms_debug_word1_set(tx_index);
            CAN_bms_debug_byte1_set(rx_index);
            
            // Reset the SPI buffered transaction state machine to recover from stuck state
            spi1ResetBufferedTransaction();
        }
        
        return; // Wait for SPI transaction to complete
    }

    /* This only happens during state transition
     * State transitions thus have priority over posting new events
     * State transitions always consist of an exit event to curState and entry event to nextState */
    if (ltc_module.nextState != ltc_module.curState) {
        ltc6802_1_state_functions[ltc_module.curState](EXIT);
        ltc_module.prevState = ltc_module.curState;
        ltc_module.curState = ltc_module.nextState;
        ltc6802_1_state_functions[ltc_module.curState](ENTRY);
    } else {
        ltc6802_1_state_functions[ltc_module.curState](RUN);
    }
}

/******************************************************************************
 * State Functions Implementation - using ENTRY/EXIT/RUN paradigm
 *******************************************************************************/

void idle(LTC6802_1_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            break;
        case RUN:
            // Nothing to do in idle state
            ltc_module.nextState = cell_read_state;
            break;
        case EXIT:
            break;
        default:
            break;
    }
}

void config_write(LTC6802_1_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            // Build fresh configuration data right before sending
            BuildConfigData();
            
            // Write configuration to entire daisy chain
            if (StartSPITransaction(LTC6802_1_CMD_WRCFG,
                                   ltc_module.config_data, // Configuration data
                                   LTC6802_1_NUM_STACKS * LTC6802_1_CONFIG_REG_SIZE, // Data length
                                   false, // No response expected
                                   0) != LTC6802_1_ERROR_NONE) {
                ltc_module.nextState = faulted_state;
            }
            // save this message in case config data gets changed between states.
            SaveConfigMSG();
            break;
        case RUN:
            // Configuration write completed, move to readback
            ltc_module.nextState = config_readback_state;
            SysTick_TimerStart(ltc6802_spiTimer);
            break;
        case EXIT:
            break;
        default:
            break;
    }
}

void config_readback(LTC6802_1_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            // Read back configuration from entire daisy chain to verify
            if (StartSPITransaction(LTC6802_1_CMD_RDCFG,
                                   NULL, // No TX data, just read
                                   0, // No TX data length
                                   true, // Expect response
                                   LTC6802_1_NUM_STACKS * (LTC6802_1_CONFIG_REG_SIZE + LTC6802_1_PEC_SIZE) // Length of response data
                                ) != LTC6802_1_ERROR_NONE) {
                ltc_module.nextState = faulted_state;
            }
            break;
        case RUN:
            // Configuration readback completed, restart autonomous cycle
            ProcessConfigData();
            ltc_module.nextState = cell_read_state;
            break;
        case EXIT:
            break;
        default:
            break;
    }
}

void cell_read(LTC6802_1_entry_types_E entry_type) {
    uint8_t command = LTC6802_1_CMD_STCVAD;
    if(ltc_module.balancing_active) {
        command = LTC6802_1_CMD_STCVDC; // Use discharge command if balancing is active
    }
    switch (entry_type) {
        case ENTRY:
            // Start cell voltage ADC for entire daisy chain
            if (StartSPITransaction(command, // Start Cell Voltage ADC
                                   NULL, // No TX data, just start
                                   0, // No TX data length
                                   false, // No response expected
                                   0 // No response length
                                ) != LTC6802_1_ERROR_NONE) {
                ltc_module.nextState = faulted_state;
            }
            SysTick_TimerStart(adc_conversion_timer);
            break;
        case RUN:
            // Wait for ADC conversion to complete
            //if (IO_GET_SPI_SDI() == HIGH) { // Check if conversion is complete
            if ( SysTick_TimeOut(adc_conversion_timer)) {// Check if conversion is complete
                ltc_module.nextState = cell_data_state;
            }
            break;
        case EXIT:
            break;
        default:
            break;
    }
}

void cell_data(LTC6802_1_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            // Read cell voltage data from entire daisy chain in single transaction
            if (StartSPITransaction(LTC6802_1_CMD_RDCV, // Read Cell Voltages
                                   NULL, // No TX data, just read
                                   0, // No TX data length
                                   true, // Expect response
                                   LTC6802_1_NUM_STACKS * (LTC6802_1_VOLTAGE_REG_SIZE + LTC6802_1_PEC_SIZE) // Length of response data
                                ) != LTC6802_1_ERROR_NONE) {
                ltc_module.nextState = faulted_state;
            }
            break;
        case RUN:
            // Process data from entire daisy chain and continue to temperature
            ProcessVoltageData();
            SysTick_TimerStart(voltage_data_timer);
            ltc_module.nextState = temp_read_state;
            break;
        case EXIT:
            break;
        default:
            break;
    }
}

void temp_read(LTC6802_1_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            // Start temperature ADC for entire daisy chain
            if (StartSPITransaction(LTC6802_1_CMD_STTMPAD, // Start Temperature ADC
                                   NULL, // No TX data, just start
                                   0, // No TX data length
                                   false, // No response expected
                                   0    // No response length
                                ) != LTC6802_1_ERROR_NONE) {
                ltc_module.nextState = faulted_state;
            }
            SysTick_TimerStart(temp_conversion_timer);
            break;
        case RUN:
            // Wait for ADC conversion to complete
            // if (IO_GET_SPI_SDI() == HIGH) { // Check if conversion is complete
            if ( SysTick_TimeOut(temp_conversion_timer)) {// Check if conversion is complete
                ltc_module.nextState = temp_data_state;
            }
            break;
        case EXIT:
            break;
        default:
            break;
    }
}

void temp_data(LTC6802_1_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            // Read temperature data from entire daisy chain in single transaction
            if (StartSPITransaction(LTC6802_1_CMD_RDTMP, // Read Temperature
                                   NULL, // No TX data, just read
                                   0, // No TX data length
                                   true, // Expect response
                                   LTC6802_1_NUM_STACKS * (LTC6802_1_TEMP_REG_SIZE + LTC6802_1_PEC_SIZE) // Length of response data
                                ) != LTC6802_1_ERROR_NONE) {
                ltc_module.nextState = faulted_state;
            }
            break;
        case RUN:
            // Process data from entire daisy chain and continue to flags
            ProcessTemperatureData();
            SysTick_TimerStart(temp_data_timer);
            ltc_module.nextState = flag_data_state;
            break;
        case EXIT:
            break;
        default:
            break;
    }
}

void flag_data(LTC6802_1_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            // Read flag data from entire daisy chain in single transaction
            if (StartSPITransaction(LTC6802_1_CMD_RDFLG, // Read Flags
                                   NULL, // No TX data, just read
                                   0, // No TX data length
                                   true, // Expect response
                                   LTC6802_1_NUM_STACKS * (LTC6802_1_FLAG_REG_SIZE + LTC6802_1_PEC_SIZE) // Length of response data
                                ) != LTC6802_1_ERROR_NONE) {
                ltc_module.nextState = faulted_state;
            }
            break;
        case RUN:
            // Process flag data from entire daisy chain and continue to config write
            ProcessFlagData();
            ltc_module.nextState = config_write_state;
            break;
        case EXIT:
            break;
        default:
            break;
    }
}

void faulted(LTC6802_1_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            break;
        case RUN:
            // Stay in faulted state until explicit reset
            // Could add timeout recovery logic here if desired
            LTC6802_1_Resume();
            break;
        case EXIT:
            break;
        default:
            break;
    }
}

void halted(LTC6802_1_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            break;
        case RUN:
            // Stay halted until explicitly resumed
            break;
        case EXIT:
            break;
        default:
            break;
    }
}

bool LTC6802_1_IsBusy(void) {
    return (ltc_module.curState != idle_state && ltc_module.curState != halted_state);
}

LTC6802_1_Error_E LTC6802_1_Halt(void) {
    // Transition to halted state from any state (except faulted)
    if (ltc_module.curState != faulted_state) {
        ltc_module.nextState = halted_state;
    }
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_Resume(void) {
    // Resume autonomous operation by starting measurement cycle
    if (ltc_module.curState == halted_state) {
        ltc_module.nextState = cell_read_state;
        SysTick_TimerStart(ltc6802_spiTimer);
        return LTC6802_1_ERROR_NONE;
    } else if (ltc_module.curState == idle_state) {
        // If idle, start autonomous cycle
        ltc_module.nextState = cell_read_state;
        SysTick_TimerStart(ltc6802_spiTimer);
        return LTC6802_1_ERROR_NONE;
    } else {
        // Already running
        return LTC6802_1_ERROR_ALREADY_RUNNING;
    }
}



LTC6802_1_Error_E LTC6802_1_StartCellBalancing(const uint16_t* cells_to_balance, uint16_t num_cells) {
    // Validate inputs
    if (num_cells > MAX_BALANCE_CELLS) {
        num_cells = MAX_BALANCE_CELLS; // Limit to maximum
    }
    
    // Copy the cell list to internal storage
    ltc_module.num_cells_to_balance = num_cells;
    for (uint16_t i = 0; i < num_cells; i++) {
        ltc_module.cells_to_balance[i] = cells_to_balance[i];
    }
    
    // Clear all discharge cells first
    for (uint16_t i = 0; i < LTC6802_1_NUM_STACKS; i++) {
        ltc_module.config.discharge_cells[i] = 0;
    }
    
    // Set balancing for cells identified in cells_to_balance array
    for (uint16_t i = 0; i < ltc_module.num_cells_to_balance; i++) {
        uint16_t cell_id = ltc_module.cells_to_balance[i];
        
        if (cell_id >= LTC6802_1_TOTAL_CELLS) {
            continue; // Skip invalid cell IDs
        }
        
        // Convert global cell ID to stack and local cell ID
        // Each stack handles 12 cells (0-11), so we need to map:
        // Global cells 0-11 → Stack 0, local cells 0-11
        // Global cells 12-23 → Stack 1, local cells 0-11
        uint16_t stack_id = cell_id / LTC6802_1_CELLS_PER_STACK;       // Which stack (0 or 1)
        uint16_t local_cell_id = cell_id % LTC6802_1_CELLS_PER_STACK;  // Cell within stack (0-11)
        
        // Set the bit for this cell in the appropriate stack
        ltc_module.config.discharge_cells[stack_id] |= (1U << local_cell_id);
    }

    return LTC6802_1_ERROR_NONE;
}

bool LTC6802_1_IsBalancingActive(void) {
    return ltc_module.balancing_active;
}

LTC6802_1_Error_E LTC6802_1_ClearAllCellBalancing(void) {
    // Clear all cell balancing for all stacks
    for (uint8_t i = 0; i < LTC6802_1_NUM_STACKS; i++) {
        ltc_module.config.discharge_cells[i] = 0;
    }
    
    return LTC6802_1_ERROR_NONE;
}

uint16_t LTC6802_1_GetCellVoltage(uint8_t cell_id) {
    if (cell_id >= LTC6802_1_TOTAL_CELLS) {
        return LTC6802_1_INVALID_DATA;
    }
    
    if (!ltc_module.voltage_data_valid || SysTick_TimeOut(voltage_data_timer)) {
        return LTC6802_1_INVALID_DATA;
    }
    
    // Check for PEC validation failure marker
    if (ltc_module.voltage_data[cell_id] == 0xFFFF) {
        return LTC6802_1_INVALID_DATA;
    }
    
    // Convert ADC reading to mV using integer math: ADC * 1.5 = ADC * 3 / 2
    // Use bit shifting for division by 2 (faster than regular division)
    uint16_t adc_x3 = ltc_module.voltage_data[cell_id] + (ltc_module.voltage_data[cell_id] << 1);
    return adc_x3 >> 1;  // Divide by 2
}

float LTC6802_1_GetTemperatureVoltage(uint8_t temp_id) {
    if (temp_id >= LTC6802_1_TOTAL_TEMPS) {
        return LTC6802_1_INVALID_DATA;
    }
    
    if (!ltc_module.temp_data_valid || SysTick_TimeOut(temp_data_timer)) {
        return LTC6802_1_INVALID_DATA;
    }
    
    // Check for PEC validation failure marker
    if (ltc_module.temp_data[temp_id] == 0xFFFF) {
        return LTC6802_1_INVALID_DATA;
    }
    
    return (float)ltc_module.temp_data[temp_id] * LTC6802_1_VOLTAGE_SCALE_FACTOR;
}

LTC6802_1_Error_Entry_S LTC6802_1_GetLastError(void) {
    LTC6802_1_Error_Entry_S empty_error = {LTC6802_1_ERROR_NONE, 0, 0};
    
    // Return empty error if no errors logged
    if (ltc_module.total_error_count == 0) {
        return empty_error;
    }
    
    // Get last error from circular buffer
    uint8_t last_index = (ltc_module.error_write_index - 1 + 16) % 16;
    return ltc_module.error_buffer[last_index];
}

void LTC6802_1_ClearError(void) {
    // Use the main clear function
    LTC6802_1_ClearAllErrors();
}

void LTC6802_1_GetStats(uint32_t* total_transactions, 
                       uint32_t* failed_transactions, 
                       uint32_t* retry_count) {
    if (total_transactions) *total_transactions = ltc_module.total_transactions;
    if (failed_transactions) *failed_transactions = ltc_module.failed_transactions;
    if (retry_count) *retry_count = ltc_module.total_retries;
}

void LTC6802_1_ResetStats(void) {
    ltc_module.total_transactions = 0;
    ltc_module.failed_transactions = 0;
    ltc_module.total_retries = 0;
}

/******************************************************************************
 * Internal Function Implementations
 *******************************************************************************/

static LTC6802_1_Error_E StartSPITransaction(uint8_t command, 
                                            const uint8_t* tx_data, uint8_t data_len,
                                            bool expect_response, uint8_t response_len) {
    if (ltc_module.spi_transaction_active) {
        LogError(LTC6802_1_ERROR_BUSY);
        return LTC6802_1_ERROR_BUSY;
    }
    
    // Build command (no addressing in LTC6802-1 daisy chain)
    ltc_module.spi_tx_buffer[0] = command;
    ltc_module.spi_tx_length = 1;
    
    // Add data if provided
    if (tx_data != NULL && data_len > 0) {
        memcpy(&ltc_module.spi_tx_buffer[1], tx_data, data_len);
        ltc_module.spi_tx_length += data_len;
    }
    
    // No CRC needed for outgoing data - LTC6802-1 only sends PEC on responses
    
    // Set up receive buffer if expecting response
    ltc_module.spi_rx_length = response_len + 1; // Include CMD byte
    uint8_t* rx_buffer = expect_response ? ltc_module.spi_rx_buffer : NULL;
    
    // Start transaction
    SysTick_TimerStart(ltc6802_spiTimer);
    IO_SET_SPI_CS(LOW);
    
    bool result = spi1StartBufferedTransaction(ltc_module.spi_tx_buffer, ltc_module.spi_tx_length, 
                                               rx_buffer, ltc_module.spi_rx_length);
    
    if (result) {
        ltc_module.spi_transaction_active = true;
        ltc_module.total_transactions++;
        return LTC6802_1_ERROR_NONE;
    } else {
        IO_SET_SPI_CS(HIGH);
        ltc_module.failed_transactions++;
        LogError(LTC6802_1_ERROR_SPI_BUSY);
        return LTC6802_1_ERROR_SPI_BUSY;
    }
}



static void TransitionToIdle(void) {
    ltc_module.nextState = idle_state;
}

static void TransitionToFaulted(LTC6802_1_Error_E error) {
    ltc_module.nextState = faulted_state;
    // Error already handled by HandleError function
    ltc_module.failed_transactions++;
}

static void ProcessVoltageData(void) {
    // Parse voltage data from SPI buffer into voltage array
    // 
    // CRITICAL: For daisy chain reads, data comes out in reverse order:
    // - First 18 bytes received are from Stack 0 (bottom of chain), then PEC byte
    // - Next 18 bytes received are from Stack 1 (top of chain), then PEC byte
    // 
    // Received data: [Stack0_18bytes][Stack0_PEC][Stack1_18bytes][Stack1_PEC] (38 bytes total)
    
    uint8_t stack, cell_index = 0, data_index = 0;
    uint8_t stack_data_start, pec_byte;
    bool pec_valid;

    ltc_module.voltage_data_valid = true; // Mark voltage data as valid, gets set to false if any stack fails PEC

    for (stack = 0; stack < LTC6802_1_NUM_STACKS; stack++) {
        // Calculate start of this stack's data block
        stack_data_start = stack * (LTC6802_1_VOLTAGE_REG_SIZE + LTC6802_1_PEC_SIZE) + 1; // +1 for CMD byte
        data_index = 0;
        
        // Extract PEC byte for this stack (comes after the 18 data bytes)
        pec_byte = ltc_module.spi_rx_buffer[stack_data_start + LTC6802_1_VOLTAGE_REG_SIZE];
        
        // Validate PEC for this stack's data
        pec_valid = ValidateCRC(&ltc_module.spi_rx_buffer[stack_data_start], 
                               LTC6802_1_VOLTAGE_REG_SIZE, pec_byte);
        
        if (pec_valid) {
            // PEC valid - process cell data for this stack
            // LTC6802-1 packs 12-bit voltages into 1.5 bytes each (18 bytes total for 12 cells)
            
            //cell_index does not reset here, it continues from last stack
            while (cell_index < LTC6802_1_CELLS_PER_STACK * (stack + 1)) {
                uint16_t c0_low = 0, c0_high = 0, c1_low = 0, c1_high = 0;

                // full byte is data LSB
                c0_low = ltc_module.spi_rx_buffer[stack_data_start + data_index] & 0x00FF;
                data_index++;
                
                // first 4 bits are data MSB
                c0_high = ltc_module.spi_rx_buffer[stack_data_start + data_index] & 0x000F;
                ltc_module.voltage_data[cell_index] = (c0_high << 8) | c0_low;
                cell_index++;
                
                // second 4 bits are data LSB
                c1_low = ltc_module.spi_rx_buffer[stack_data_start + data_index] & 0x00F0;
                data_index++;
                
                // full byte is data MSF
                c1_high = ltc_module.spi_rx_buffer[stack_data_start + data_index] & 0x00FF;
                ltc_module.voltage_data[cell_index] = (c1_high << 4) | (c1_low >> 4);
                data_index++;
                cell_index++;
            }
        } else {
            // PEC failed - mark cells for this stack as invalid
            for (; cell_index < LTC6802_1_CELLS_PER_STACK * (stack + 1); cell_index++) {
                ltc_module.voltage_data[cell_index] = 0xFFFF; // Invalid marker
                ltc_module.voltage_data_valid = false; // Mark voltage data as invalid
            }
            // Set error for this stack
            LogError(LTC6802_1_ERROR_CRC_FAIL);

        }
    }
    
    // Voltage calculations moved to BMS layer
}

// CalculateStackVoltages function moved to BMS layer


static void ProcessTemperatureData(void) {
    // Parse temperature data from SPI buffer into temp array
    // 
    // CRITICAL: For daisy chain reads, data comes out in reverse order:
    // - First 5 bytes received are from Stack 0 (bottom of chain), then PEC byte
    // - Next 5 bytes received are from Stack 1 (top of chain), then PEC byte
    // 
    // Received data: [Stack0_5bytes][Stack0_PEC][Stack1_5bytes][Stack1_PEC] (12 bytes total)

    uint8_t stack, temp_index = 0;
    uint8_t stack_data_start, pec_byte;
    bool pec_valid;

    ltc_module.temp_data_valid = true; // Mark temperature data as valid, gets set to false if any stack fails PEC
    
    for (stack = 0; stack < LTC6802_1_NUM_STACKS; stack++) {
        // Calculate start of this stack's data block
        stack_data_start = stack * (LTC6802_1_TEMP_REG_SIZE + LTC6802_1_PEC_SIZE) + 1; // +1 for CMD byte
        
        // Extract PEC byte for this stack (comes after the 5 data bytes)
        pec_byte = ltc_module.spi_rx_buffer[stack_data_start + LTC6802_1_TEMP_REG_SIZE];
        
        // Validate PEC for this stack's data
        pec_valid = ValidateCRC(&ltc_module.spi_rx_buffer[stack_data_start], 
                               LTC6802_1_TEMP_REG_SIZE, pec_byte);
        
        if (pec_valid) {
            // PEC valid - process temperature data for this stack
            // Extract temperature data according to register layout:
            // TMPR0: ETMP1[7:0]
            // TMPR1: ETMP1[11:8] | ETMP2[3:0]
            // TMPR2: ETMP2[11:4]
            // TMPR3: ITMP[7:0]
            // TMPR4: ITMP[11:8] | THSD | REV[2:0]
            
            uint16_t tmpr0 = ltc_module.spi_rx_buffer[stack_data_start + 0];
            uint16_t tmpr1 = ltc_module.spi_rx_buffer[stack_data_start + 1];
            uint16_t tmpr2 = ltc_module.spi_rx_buffer[stack_data_start + 2];
            uint16_t tmpr3 = ltc_module.spi_rx_buffer[stack_data_start + 3];
            uint16_t tmpr4 = ltc_module.spi_rx_buffer[stack_data_start + 4];
            
            // Extract ETMP1 (12-bit)
            uint16_t etmp1 = tmpr0 | ((tmpr1 & 0x000F) << 8);
            temp_index = stack * LTC6802_1_TEMPS_PER_STACK + 0;
            ltc_module.temp_data[temp_index] = etmp1;
            
            // Extract ETMP2 (12-bit)
            uint16_t etmp2 = ((tmpr1 & 0x00F0) >> 4) | (tmpr2 << 4);
            temp_index = stack * LTC6802_1_TEMPS_PER_STACK + 1;
            ltc_module.temp_data[temp_index] = etmp2;
            
            // Extract ITMP (12-bit)
            uint16_t itmp = tmpr3 | ((tmpr4 & 0x000F) << 8);
            temp_index = stack * LTC6802_1_TEMPS_PER_STACK + 2;
            ltc_module.temp_data[temp_index] = itmp;
            
            // Extract REV number (3-bit)
            ltc_module.rev_number[stack] = tmpr4 & 0x0007;
            
            // Extract THSD flag (1-bit)
            ltc_module.thsd_flag[stack] = (tmpr4 & 0x0008) != 0;
            
        } else {
            // PEC failed - mark temperature sensors for this stack as invalid
            for (uint8_t temp = 0; temp < LTC6802_1_TEMPS_PER_STACK; temp++) {
                temp_index = stack * LTC6802_1_TEMPS_PER_STACK + temp;
                ltc_module.temp_data[temp_index] = 0xFFFF; // Invalid marker
            }
            // Mark REV and THSD as invalid
            ltc_module.rev_number[stack] = 0xFF;
            ltc_module.thsd_flag[stack] = false;
            // Mark temperature data as invalid
            ltc_module.temp_data_valid = false;
            // Set error for this stack
            LogError(LTC6802_1_ERROR_CRC_FAIL);
        }
    }
}

static void ProcessFlagData(void) {
    // Parse flag data from SPI buffer
    // 
    // CRITICAL: For daisy chain reads, data comes out in reverse order:
    // - First 3 bytes received are from Stack 0 (bottom of chain), then PEC byte
    // - Next 3 bytes received are from Stack 1 (top of chain), then PEC byte
    // 
    // Received data: [Stack0_3bytes][Stack0_PEC][Stack1_3bytes][Stack1_PEC] (8 bytes total)
    
    uint8_t stack;
    uint8_t stack_data_start, pec_byte;
    bool pec_valid;
    
    for (stack = 0; stack < LTC6802_1_NUM_STACKS; stack++) {
        // Calculate start of this stack's data block
        stack_data_start = stack * (LTC6802_1_FLAG_REG_SIZE + LTC6802_1_PEC_SIZE) + 1; // +1 for CMD byte
        
        // Extract PEC byte for this stack (comes after the 3 data bytes)
        pec_byte = ltc_module.spi_rx_buffer[stack_data_start + LTC6802_1_FLAG_REG_SIZE];
        
        // Validate PEC for this stack's data
        pec_valid = ValidateCRC(&ltc_module.spi_rx_buffer[stack_data_start], 
                               LTC6802_1_FLAG_REG_SIZE, pec_byte);
        
        if (pec_valid) {
            // PEC valid - process flag data for this stack
            // LTC6802-1 flag register layout: FLGR0, FLGR1, FLGR2 (3 bytes per stack)
            // For now, we just store the raw flag data in the module
            // TODO: Add flag data storage to ltc_module structure if needed
            
        } else {
            // PEC failed - flag data corrupted
            // Set error for this stack
            LogError(LTC6802_1_ERROR_CRC_FAIL);
        }
    }
}

static void ProcessConfigData(void) {
    // Process configuration readback data and validate against written values
    // 
    // For daisy chain config reads, data comes out in normal order:
    // - First 6 bytes received are from Stack 0 (bottom of chain), then PEC byte
    // - Next 6 bytes received are from Stack 1 (top of chain), then PEC byte
    // 
    // Received data: [Stack0_6bytes][Stack0_PEC][Stack1_6bytes][Stack1_PEC] (14 bytes total)
    
    uint8_t stack;
    uint8_t readback_start, written_start, pec_byte;
    bool pec_valid, config_valid;
    
    for (stack = 0; stack < LTC6802_1_NUM_STACKS; stack++) {
        // Calculate data positions (accounting for PEC bytes)
        readback_start = stack * (LTC6802_1_CONFIG_REG_SIZE + LTC6802_1_PEC_SIZE) + 1; // +1 for CMD byte
        written_start = (LTC6802_1_NUM_STACKS - 1 - stack) * LTC6802_1_CONFIG_REG_SIZE; //config is stored top stack-down
        
        // Extract and validate PEC byte for this stack
        pec_byte = ltc_module.spi_rx_buffer[readback_start + LTC6802_1_CONFIG_REG_SIZE];
        pec_valid = ValidateCRC(&ltc_module.spi_rx_buffer[readback_start], 
                               LTC6802_1_CONFIG_REG_SIZE, pec_byte);
        
        if (!pec_valid) {
            // PEC failed - configuration data corrupted
            ltc_module.debug_failure_point = 1; // PEC validation failed
            LogError(LTC6802_1_ERROR_CRC_FAIL);
            return;
        }
        
        // PEC valid - now compare readback data with what we wrote
        config_valid = (memcmp(&ltc_module.spi_rx_buffer[readback_start+1], 
                              &ltc_module.config_data_saved[written_start+1], 
                              LTC6802_1_CONFIG_REG_SIZE -1) == 0);
        
        if (!config_valid) {
            // Configuration mismatch - hardware didn't accept our config
            ltc_module.debug_failure_point = 2; // Config data mismatch
            LogError(LTC6802_1_ERROR_CONFIG_MISMATCH);
            return;
        }

    }
    
    // All PEC and config validation passed - hardware config is correct
    // Check if any cells are discharging
    bool anyCellsDischarging = false;
    for (uint8_t i = 0; i < LTC6802_1_NUM_STACKS; i++) {
        // Check if any cells are discharging
        anyCellsDischarging = anyCellsDischarging || ltc_module.config.discharge_cells[i];
    }
    ltc_module.balancing_active = anyCellsDischarging;
}

static void BuildConfigData(void) {
    // Build configuration data for daisy chain transmission
    // LTC6802-1 config register layout: CFGR0-CFGR5 (6 bytes per stack)
    //
    // CRITICAL: For daisy chain writes, data must be ordered for shift register:
    // - First 6 bytes sent go to the TOP of the chain (highest numbered stack)
    // - Last 6 bytes sent go to the BOTTOM of the chain (lowest numbered stack)
    // 
    // So for 2 stacks: Send [Stack1_Config][Stack0_Config] (12 bytes total)
    
    for (uint8_t i = 0; i < LTC6802_1_NUM_STACKS; i++) {
        // Calculate actual stack number (reverse order for daisy chain)
        uint8_t stack = (LTC6802_1_NUM_STACKS - 1) - i;
        
        // Calculate buffer position (forward order for transmission)
        uint8_t* cfg = &ltc_module.config_data[i * LTC6802_1_CONFIG_REG_SIZE];
        
        // CFGR0: WDT | GPIO2 | GPIO1 | LVLPL | CELL10 | CDC[2] | CDC[1] | CDC[0]
        cfg[0] = 0;
        cfg[0] |= (ltc_module.config.cdc_mode & 0x07);                  // Bits 0-2: CDC[2:0] (global)
        cfg[0] |= (ltc_module.config.cell10_enable ? 1 : 0) << 3;       // Bit 3: CELL10 (global)
        cfg[0] |= (ltc_module.config.lvlpl_enable ? 1 : 0) << 4;        // Bit 4: LVLPL (global)
        cfg[0] |= (ltc_module.config.gpio1_state[stack] ? 1 : 0) << 5;  // Bit 5: GPIO1 (per-stack)
        cfg[0] |= (ltc_module.config.gpio2_state[stack] ? 1 : 0) << 6;  // Bit 6: GPIO2 (per-stack)
        cfg[0] |= (ltc_module.config.wdt_enable ? 1 : 0) << 7;          // Bit 7: WDT (global)
        
        // CFGR1: DCC8 | DCC7 | DCC6 | DCC5 | DCC4 | DCC3 | DCC2 | DCC1
        uint16_t discharge_mask = ltc_module.config.discharge_cells[stack];
        cfg[1] = discharge_mask & 0xFF;                                 // DCC1-DCC8 (cells 1-8)
        
        // CFGR2: MC4I | MC3I | MC2I | MC1I | DCC12 | DCC11 | DCC10 | DCC9
        cfg[2] = (discharge_mask >> 8) & 0x0F;                          // DCC9-DCC12 (cells 9-12)
        uint16_t monitor_mask = ltc_module.config.monitor_cells[stack];  // Per-stack monitoring
        cfg[2] |= (monitor_mask & 0x0F) << 4;                           // MC1I-MC4I (cells 1-4)
        
        // CFGR3: MC12I | MC11I | MC10I | MC9I | MC8I | MC7I | MC6I | MC5I
        cfg[3] = (monitor_mask >> 4) & 0xFF;                            // MC5I-MC12I (cells 5-12)
        
        // CFGR4: VUV[7:0] - Under-voltage threshold (8-bit)
        cfg[4] = ltc_module.config.undervoltage_threshold;
        
        // CFGR5: VOV[7:0] - Over-voltage threshold (8-bit)
        cfg[5] = ltc_module.config.overvoltage_threshold;
    }
    
    // Result: config_data now contains [Stack1_Config][Stack0_Config] 
    // which is correct for daisy chain transmission
}

static uint8_t CalculateCRC(const uint8_t* data, uint8_t length) {
    // LTC6802-1 PEC calculation using polynomial x^8 + x^2 + x + 1 (0x07)
    // Standard CRC-8 implementation with zero initialization
    uint8_t pec = 0x00; // Standard initialization for CRC-8
    uint8_t i, j;
    
    for (i = 0; i < length; i++) {
        pec ^= data[i];
        for (j = 0; j < 8; j++) {
            if (pec & 0x80) {
                pec = (pec << 1) ^ 0x07; // Polynomial x^8 + x^2 + x + 1
            } else {
                pec <<= 1;
            }
        }
    }
    
    return pec;
}

static bool ValidateCRC(const uint8_t* data, uint8_t length, uint8_t received_crc) {
    uint8_t calculated_crc = CalculateCRC(data, length);
    return (calculated_crc == received_crc);
}

static void SaveConfigMSG(void){
    memcpy(ltc_module.config_data_saved,
        ltc_module.config_data,
        LTC6802_1_NUM_STACKS * LTC6802_1_CONFIG_REG_SIZE
    );
}

/******************************************************************************
 * Configuration Helper Function Implementations  
 *******************************************************************************/

void LTC6802_1_GetConfig(LTC6802_1_Config_S* config) {
    if (config) {
        *config = ltc_module.config;
    }
}

LTC6802_1_Error_E LTC6802_1_SetCDCMode(uint8_t cdc_mode) {
    // CDC mode is 3 bits (0-7)
    ltc_module.config.cdc_mode = cdc_mode & 0x07;
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_SetVoltageThresholds8(uint8_t overvoltage_threshold, uint8_t undervoltage_threshold) {
    // Set 8-bit thresholds directly (no conversion needed)
    ltc_module.config.overvoltage_threshold = overvoltage_threshold;
    ltc_module.config.undervoltage_threshold = undervoltage_threshold;
    
    return LTC6802_1_ERROR_NONE;
}



LTC6802_1_Error_E LTC6802_1_ResetConfigToDefaults(void) {
    // Reset to safe defaults using hardware-accurate structure
    for (uint8_t i = 0; i < LTC6802_1_NUM_STACKS; i++) {
        ltc_module.config.discharge_cells[i] = 0;              // No cell balancing initially
        ltc_module.config.monitor_cells[i] = 0x0FFF;           // Monitor all 12 cells per stack (bits 0-11)
        ltc_module.config.gpio1_state[i] = true;              // GPIO1 as open drain input/high per stack
        ltc_module.config.gpio2_state[i] = false;              // GPIO2 unused and is input/low per stack
    }
    
    // Global settings (same for all stacks)
    ltc_module.config.overvoltage_threshold = 200;            // Example: 8-bit threshold value
    ltc_module.config.undervoltage_threshold = 150;           // Example: 8-bit threshold value
    ltc_module.config.wdt_enable = false;                     // Watchdog disabled for safety
    ltc_module.config.lvlpl_enable = true;                    // Enable level polling for normal operation
    ltc_module.config.cell10_enable = false;                  // Disable 10th cell (using 12-cell config)
    ltc_module.config.cdc_mode = 1;                          // Normal CDC mode (typically 1 for normal discharge)
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_SetGPIO1(uint8_t stack_id, bool state) {
    // Validate stack_id (LTC6802_1_ALL_STACKS means all stacks)
    if (stack_id != LTC6802_1_ALL_STACKS && stack_id >= LTC6802_1_NUM_STACKS) {
        return LTC6802_1_ERROR_INVALID_STACK;
    }
    
    // Set GPIO1 state for specified stack(s)
    if (stack_id == LTC6802_1_ALL_STACKS) {
        // Set for all stacks
        for (uint8_t i = 0; i < LTC6802_1_NUM_STACKS; i++) {
            ltc_module.config.gpio1_state[i] = !state; //Hardware signal is inverse
        }
    } else {
        // Set for specific stack
        ltc_module.config.gpio1_state[stack_id] = !state; //Hardware signal is inverse
    }
    
    return LTC6802_1_ERROR_NONE;
}

//LTC6802_1_Error_E LTC6802_1_SetGPIO2(uint8_t stack_id, bool state, bool send_immediately) {
//    if (send_immediately && LTC6802_1_IsBusy()) {
//        return LTC6802_1_ERROR_BUSY;
//    }
//    
//    // Validate stack_id (LTC6802_1_ALL_STACKS means all stacks)
//    if (stack_id != LTC6802_1_ALL_STACKS && stack_id >= LTC6802_1_NUM_STACKS) {
//        return LTC6802_1_ERROR_INVALID_STACK;
//    }
//    
//    // Set GPIO2 state for specified stack(s)
//    if (stack_id == LTC6802_1_ALL_STACKS) {
//        // Set for all stacks
//        for (uint8_t i = 0; i < LTC6802_1_NUM_STACKS; i++) {
//            ltc_module.config.gpio2_state[i] = state;
//        }
//    } else {
//        // Set for specific stack
//        ltc_module.config.gpio2_state[stack_id] = state;
//    }
//    
//    if (send_immediately) {
//        BuildConfigData();
//        
//        // Start config write sequence
//        ltc_module.nextState = config_write_state;
//        ltc_module.retry_count = 0;
//        SysTick_TimerStart(ltc6802_spiTimer);
//    }
//    
//    return LTC6802_1_ERROR_NONE;
//}

LTC6802_1_Error_E LTC6802_1_SetCellMonitoring(uint8_t stack_id, uint16_t monitor_mask) {
    // Validate stack_id (LTC6802_1_ALL_STACKS means all stacks)
    if (stack_id != LTC6802_1_ALL_STACKS && stack_id >= LTC6802_1_NUM_STACKS) {
        return LTC6802_1_ERROR_INVALID_STACK;
    }
    
    // Only allow 12 cells (bits 0-11)
    uint16_t masked_monitor = monitor_mask & 0x0FFF;
    
    // Set cell monitoring for specified stack(s)
    if (stack_id == LTC6802_1_ALL_STACKS) {
        // Set for all stacks
        for (uint8_t i = 0; i < LTC6802_1_NUM_STACKS; i++) {
            ltc_module.config.monitor_cells[i] = masked_monitor;
        }
    } else {
        // Set for specific stack
        ltc_module.config.monitor_cells[stack_id] = masked_monitor;
    }
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_SetADCMode(LTC6802_1_ADC_Mode_E mode) {
    // Set CDC mode based on ADC mode (maps to CDC[2:0] bits)
    ltc_module.config.cdc_mode = (uint8_t)mode;
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_SetVoltageThresholds(uint16_t overvoltage_mv, uint16_t undervoltage_mv) {
    // Convert millivolts to 8-bit threshold values
    // LTC6802-1 uses different scaling than stated 1.5mV per LSB
    // These are 8-bit values, so scale appropriately
    ltc_module.config.overvoltage_threshold = (uint8_t)((overvoltage_mv * 255) / 6000);   // Scale to 8-bit for ~6V max
    ltc_module.config.undervoltage_threshold = (uint8_t)((undervoltage_mv * 255) / 6000); // Scale to 8-bit for ~6V max
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_SetPolling(bool enable) {
    // When LVLPL=1, level polling is enabled, when LVLPL=0, toggle polling is enabled
    ltc_module.config.lvlpl_enable = enable;
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_EnableVoltageComparison(uint8_t stack_id, bool enable) {
    // Validate stack_id (LTC6802_1_ALL_STACKS means all stacks)
    if (stack_id != LTC6802_1_ALL_STACKS && stack_id >= LTC6802_1_NUM_STACKS) {
        return LTC6802_1_ERROR_INVALID_STACK;
    }
    
    // Voltage comparison is controlled by monitoring configuration
    // When enabled, monitor all cells; when disabled, monitor none
    uint16_t monitor_value = enable ? 0x0FFF : 0x0000;
    
    // Set voltage comparison for specified stack(s)
    if (stack_id == LTC6802_1_ALL_STACKS) {
        // Set for all stacks
        for (uint8_t i = 0; i < LTC6802_1_NUM_STACKS; i++) {
            ltc_module.config.monitor_cells[i] = monitor_value;
        }
    } else {
        // Set for specific stack
        ltc_module.config.monitor_cells[stack_id] = monitor_value;
    }
    
    return LTC6802_1_ERROR_NONE;
}

/******************************************************************************
 * Simplified Error Handling Implementation
 *******************************************************************************/

static void LogError(LTC6802_1_Error_E error_type) {
    // Log error to circular buffer
    ltc_module.error_buffer[ltc_module.error_write_index].error_type = error_type;
    ltc_module.error_buffer[ltc_module.error_write_index].state_when_occurred = (uint8_t)ltc_module.curState;
    ltc_module.error_buffer[ltc_module.error_write_index].timestamp = SysTick_Get();
    
    // Advance circular buffer index
    ltc_module.error_write_index = (ltc_module.error_write_index + 1) % 16;
    
    // Increment total error count
    ltc_module.total_error_count++;
    
    // Transition to faulted state
    TransitionToFaulted(error_type);
}

uint8_t LTC6802_1_GetRecentErrors(LTC6802_1_Error_Entry_S* output, uint8_t max_count) {
    if (!output || max_count == 0) {
        return 0;
    }
    
    uint8_t count = (max_count > 16) ? 16 : max_count;
    uint8_t start_index = ltc_module.error_write_index;
    
    // Copy most recent errors (working backwards from write index)
    for (uint8_t i = 0; i < count; i++) {
        uint8_t src_index = (start_index - 1 - i + 16) % 16;
        output[i] = ltc_module.error_buffer[src_index];
        
        // Stop if we hit an empty slot (error_type == 0)
        if (ltc_module.error_buffer[src_index].error_type == LTC6802_1_ERROR_NONE) {
            return i;
        }
    }
    
    return count;
}

uint16_t LTC6802_1_GetTotalErrorCount(void) {
    return ltc_module.total_error_count;
}

void LTC6802_1_ClearAllErrors(void) {
    // Clear error buffer
    memset(ltc_module.error_buffer, 0, sizeof(ltc_module.error_buffer));
    ltc_module.error_write_index = 0;
    ltc_module.total_error_count = 0;
    
    // Exit faulted state if currently faulted
    if (ltc_module.curState == faulted_state) {
        TransitionToIdle();
    }
}

uint8_t LTC6802_1_GetState(void) {
    return (uint8_t)ltc_module.curState;
}
