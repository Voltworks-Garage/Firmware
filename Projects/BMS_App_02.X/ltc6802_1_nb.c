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

/**
 * @brief Operation states for non-blocking state machine
 * Each state reflects the actual operation being performed
 */
typedef enum {
    LTC6802_1_STATE_IDLE = 0,
    LTC6802_1_STATE_ADC_CELL_START_READ,
    LTC6802_1_STATE_ADC_CELL_WAITING,
    LTC6802_1_STATE_ADC_CELL_READ,
    LTC6802_1_STATE_ADC_CELL_READ_WAITING,
    LTC6802_1_STATE_TEMP_START_READ,
    LTC6802_1_STATE_TEMP_WAITING,
    LTC6802_1_STATE_TEMP_READ,
    LTC6802_1_STATE_TEMP_READ_WAITING,
    LTC6802_1_STATE_CONFIG_WRITE,
    LTC6802_1_STATE_CONFIG_WAIT,
    LTC6802_1_STATE_CONFIG_READBACK,
    LTC6802_1_STATE_CONFIG_READBACK_WAIT,
    LTC6802_1_STATE_DISCHARGE_WRITE,
    LTC6802_1_STATE_DISCHARGE_WAIT,
    LTC6802_1_STATE_DISCHARGE_READBACK,
    LTC6802_1_STATE_DISCHARGE_READBACK_WAIT,
    LTC6802_1_STATE_FAULTED
} LTC6802_1_State_E;

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
    // State machine variables
    LTC6802_1_State_E state;
    uint8_t current_stack_index;
    uint32_t state_timestamp;
    uint8_t retry_count;
    
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
    
    // Measurement data and timestamps
    uint16_t voltage_data[LTC6802_1_TOTAL_CELLS];
    uint16_t temp_data[LTC6802_1_TOTAL_TEMPS];
    uint32_t voltage_data_timestamp;
    uint32_t temp_data_timestamp;
    bool voltage_data_valid;
    bool temp_data_valid;
    
    // Additional temperature register data
    uint8_t rev_number[LTC6802_1_NUM_STACKS];
    bool thsd_flag[LTC6802_1_NUM_STACKS];
    
    // Calculated voltage values
    float stack_voltage[LTC6802_1_NUM_STACKS];
    float pack_voltage;
    
    // Error tracking
    LTC6802_1_Error_E last_error[LTC6802_1_NUM_STACKS];
    
    // Statistics
    uint32_t total_transactions;
    uint32_t failed_transactions;
    uint32_t total_retries;
    
} LTC6802_1_Module_S;

/******************************************************************************
 * Static Variables
 *******************************************************************************/
static LTC6802_1_Module_S ltc_module;

/******************************************************************************
 * Internal Function Prototypes
 *******************************************************************************/
static LTC6802_1_Error_E StartSPITransaction(uint8_t command, 
                                            const uint8_t* tx_data, uint8_t data_len,
                                            bool expect_response, uint8_t response_len);
static bool IsTimeout(uint32_t start_time, uint32_t timeout_ms);
static bool IsDataStale(uint32_t timestamp);
static void SetError(uint8_t stack_id, LTC6802_1_Error_E error);
static void TransitionToIdle(void);
static void TransitionToFaulted(LTC6802_1_Error_E error);
static void ProcessVoltageData(void);
static void ProcessTemperatureData(void);
static void ProcessConfigData(void);
static void BuildConfigData(void);
static void CalculateStackVoltages(void);
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
    ltc_module.state = LTC6802_1_STATE_IDLE;
    
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
        else if (IsTimeout(ltc_module.state_timestamp, LTC6802_1_SPI_TIMEOUT_MS)) {
            
            SetError(0, LTC6802_1_ERROR_SPI_TIMEOUT);  // Set error for stack 0 as representative error
            TransitionToFaulted(LTC6802_1_ERROR_SPI_TIMEOUT);
            ltc_module.spi_transaction_active = false;
            IO_SET_SPI_CS(HIGH);
            
            // Reset the SPI buffered transaction state machine to recover from stuck state
            spi1ResetBufferedTransaction();
        }
        
        return; // Wait for SPI transaction to complete
    }
    
    // Process main state machine
    switch (ltc_module.state) {
        case LTC6802_1_STATE_IDLE:
            // Nothing to do in idle state
            break;
            
        case LTC6802_1_STATE_ADC_CELL_START_READ:
            // Start cell voltage ADC for entire daisy chain
            if (StartSPITransaction(LTC6802_1_CMD_STCVAD, 
                                   NULL, 0, false, 0) == LTC6802_1_ERROR_NONE) {
                ltc_module.state = LTC6802_1_STATE_ADC_CELL_WAITING;
                ltc_module.state_timestamp = SysTick_Get();
            } else {
                TransitionToFaulted(LTC6802_1_ERROR_SPI_TIMEOUT);
            }
            break;
            
        case LTC6802_1_STATE_ADC_CELL_WAITING:
            // Wait for ADC conversion to complete
            if (IO_GET_SPI_SDI() == HIGH) { // Check if conversion is complete
                ltc_module.state = LTC6802_1_STATE_ADC_CELL_READ;
                ltc_module.state_timestamp = SysTick_Get();
            }
            break;
            
        case LTC6802_1_STATE_ADC_CELL_READ:
            // Read cell voltage data from entire daisy chain in single transaction
            if (StartSPITransaction(LTC6802_1_CMD_RDCV, // Read Cell Voltages
                                   NULL, // No TX data, just read
                                   0, // No TX data length
                                   true, // Expect response
                                   LTC6802_1_NUM_STACKS * (LTC6802_1_VOLTAGE_REG_SIZE + LTC6802_1_PEC_SIZE) // Length of response data
                                ) == LTC6802_1_ERROR_NONE) {
                ltc_module.state_timestamp = SysTick_Get();
                ltc_module.state = LTC6802_1_STATE_ADC_CELL_READ_WAITING;

            } else {
                TransitionToFaulted(LTC6802_1_ERROR_SPI_TIMEOUT);
            }
            break;

        case LTC6802_1_STATE_ADC_CELL_READ_WAITING:
            // Process data from entire daisy chain and complete
            ProcessVoltageData();
            ltc_module.voltage_data_timestamp = SysTick_Get();
            TransitionToIdle();
            break;

            
        case LTC6802_1_STATE_TEMP_START_READ:
            // Start temperature ADC for entire daisy chain
            if (StartSPITransaction(LTC6802_1_CMD_STTMPAD, 
                                   NULL, 0, false, 0) == LTC6802_1_ERROR_NONE) {
                ltc_module.state = LTC6802_1_STATE_TEMP_WAITING;
                ltc_module.state_timestamp = SysTick_Get();
            } else {
                TransitionToFaulted(LTC6802_1_ERROR_SPI_TIMEOUT);
            }
            break;
            
        case LTC6802_1_STATE_TEMP_WAITING:
            // Wait for ADC conversion to complete
            if (IO_GET_SPI_SDI() == HIGH) { // Check if conversion is complete
                ltc_module.state = LTC6802_1_STATE_TEMP_READ;
                ltc_module.state_timestamp = SysTick_Get();
            }
            break;
            
        case LTC6802_1_STATE_TEMP_READ:
            // Read temperature data from entire daisy chain in single transaction
            if (StartSPITransaction(LTC6802_1_CMD_RDTMP, // Read Temperature
                                   NULL, // No TX data, just read
                                   0, // No TX data length
                                   true, // Expect response
                                   LTC6802_1_NUM_STACKS * (LTC6802_1_TEMP_REG_SIZE + LTC6802_1_PEC_SIZE)// Length of response data
                                ) == LTC6802_1_ERROR_NONE) {
                ltc_module.state_timestamp = SysTick_Get();
                ltc_module.state = LTC6802_1_STATE_TEMP_READ_WAITING;
            } else {
                TransitionToFaulted(LTC6802_1_ERROR_SPI_TIMEOUT);
            }
            break;

        case LTC6802_1_STATE_TEMP_READ_WAITING:
            // Process data from entire daisy chain and complete
            if (IsTimeout(ltc_module.state_timestamp, LTC6802_1_ADC_CONVERSION_TIME_MS)) {
                ProcessTemperatureData();
                ltc_module.temp_data_timestamp = SysTick_Get();
                TransitionToIdle();
            }
            break;

        case LTC6802_1_STATE_CONFIG_WRITE:
            // Write configuration to entire daisy chain in single transaction
            if (StartSPITransaction(LTC6802_1_CMD_WRCFG, // Write Configuration
                                   ltc_module.config_data, // Pointer to config data
                                   LTC6802_1_NUM_STACKS * LTC6802_1_CONFIG_REG_SIZE, // Length of config data
                                   false, // No response expected
                                   0 // No response length
                                ) == LTC6802_1_ERROR_NONE) {
                ltc_module.state = LTC6802_1_STATE_CONFIG_WAIT;
                ltc_module.state_timestamp = SysTick_Get();
                ltc_module.debug_failure_point = 1; // Config write started
            } else {
                TransitionToFaulted(LTC6802_1_ERROR_SPI_TIMEOUT);
            }
            break;
            
        case LTC6802_1_STATE_CONFIG_WAIT:
            // Configuration write completed, move to readback
            ltc_module.state = LTC6802_1_STATE_CONFIG_READBACK;
            ltc_module.state_timestamp = SysTick_Get();
            break;
            
        case LTC6802_1_STATE_CONFIG_READBACK:
            // Read back configuration from entire daisy chain in single transaction
            if (StartSPITransaction(LTC6802_1_CMD_RDCFG, // Read Configuration
                                   NULL, // No TX data, just read
                                   0, // No TX data length
                                   true, // Expect response
                                   LTC6802_1_NUM_STACKS * (LTC6802_1_CONFIG_REG_SIZE + LTC6802_1_PEC_SIZE) // Length of response data
                                ) == LTC6802_1_ERROR_NONE) {
                ltc_module.state = LTC6802_1_STATE_CONFIG_READBACK_WAIT;
                ltc_module.state_timestamp = SysTick_Get();
                ltc_module.debug_failure_point = 2; // Config write started
            } else {
                TransitionToFaulted(LTC6802_1_ERROR_SPI_TIMEOUT);
            }
            break;
            
        case LTC6802_1_STATE_CONFIG_READBACK_WAIT:
            // Configuration readback completed for entire daisy chain
            // Validate that readback matches what we wrote
            ProcessConfigData();

            TransitionToIdle();
            break;
            
        case LTC6802_1_STATE_DISCHARGE_WRITE:
            // Write discharge configuration to entire daisy chain in single transaction
            if (StartSPITransaction(LTC6802_1_CMD_WRCFG, 
                                   ltc_module.config_data, 
                                   LTC6802_1_NUM_STACKS * LTC6802_1_CONFIG_REG_SIZE, 
                                   false, 0) == LTC6802_1_ERROR_NONE) {
                ltc_module.state = LTC6802_1_STATE_DISCHARGE_WAIT;
                ltc_module.state_timestamp = SysTick_Get();
            } else {
                TransitionToFaulted(LTC6802_1_ERROR_SPI_TIMEOUT);
            }
            break;
            
        case LTC6802_1_STATE_DISCHARGE_WAIT:
            // Discharge write completed, move to readback
            ltc_module.state = LTC6802_1_STATE_DISCHARGE_READBACK;
            ltc_module.state_timestamp = SysTick_Get();
            break;
            
        case LTC6802_1_STATE_DISCHARGE_READBACK:
            // Read back configuration from entire daisy chain in single transaction
            if (StartSPITransaction(LTC6802_1_CMD_RDCFG, 
                                   NULL, 0, true, 
                                   LTC6802_1_NUM_STACKS * LTC6802_1_CONFIG_REG_SIZE + 1) == LTC6802_1_ERROR_NONE) {
                ltc_module.state = LTC6802_1_STATE_DISCHARGE_READBACK_WAIT;
                ltc_module.state_timestamp = SysTick_Get();
            } else {
                TransitionToFaulted(LTC6802_1_ERROR_SPI_TIMEOUT);
            }
            break;
            
        case LTC6802_1_STATE_DISCHARGE_READBACK_WAIT:
            // Discharge readback completed for entire daisy chain
            TransitionToIdle();
            break;
            
        case LTC6802_1_STATE_FAULTED:
            // Stay in faulted state until explicit reset
//            TransitionToIdle();
            break;
            
        default:
            TransitionToFaulted(LTC6802_1_ERROR_MAX_RETRIES);
            break;
    }
}

bool LTC6802_1_IsBusy(void) {
    return (ltc_module.state != LTC6802_1_STATE_IDLE);
}

LTC6802_1_Error_E LTC6802_1_StartCellVoltageADC(void) {
    if (LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    // Start cell voltage ADC and read sequence
    ltc_module.state = LTC6802_1_STATE_ADC_CELL_START_READ;
    ltc_module.retry_count = 0;
    ltc_module.state_timestamp = SysTick_Get();
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_StartTemperatureADC(void) {
    if (LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    // Start temperature ADC and read sequence
    ltc_module.state = LTC6802_1_STATE_TEMP_START_READ;
    ltc_module.retry_count = 0;
    ltc_module.state_timestamp = SysTick_Get();
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_WriteConfig(void) {
    if (LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    // Build config data
    BuildConfigData();
    
    // Start configuration write sequence
    ltc_module.state = LTC6802_1_STATE_CONFIG_WRITE;
    ltc_module.current_stack_index = 0;
    ltc_module.retry_count = 0;
    ltc_module.state_timestamp = SysTick_Get();
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_SetCellBalancing(uint8_t cell_id, bool enable, bool send_immediately) {
    if (send_immediately && LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    if (cell_id >= LTC6802_1_TOTAL_CELLS) {
        return LTC6802_1_ERROR_INVALID_STACK; // Reuse for invalid parameter
    }
    
    // Convert global cell ID to stack and local cell ID
    // Each stack handles 12 cells (0-11), so we need to map:
    // Global cells 0-11 → Stack 0, local cells 0-11
    // Global cells 12-23 → Stack 1, local cells 0-11
    uint8_t stack_id = cell_id / LTC6802_1_CELLS_PER_STACK;       // Which stack (0 or 1)
    uint8_t local_cell_id = cell_id % LTC6802_1_CELLS_PER_STACK;  // Cell within stack (0-11)
    
    // Set or clear the bit for this cell in the appropriate stack
    if (enable) {
        ltc_module.config.discharge_cells[stack_id] |= (1U << local_cell_id);
    } else {
        ltc_module.config.discharge_cells[stack_id] &= ~(1U << local_cell_id);
    }
    
    if (send_immediately) {
        BuildConfigData();
        
        // Start discharge configuration write sequence
        ltc_module.state = LTC6802_1_STATE_DISCHARGE_WRITE;
        ltc_module.retry_count = 0;
        ltc_module.state_timestamp = SysTick_Get();
    }
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_ClearAllCellBalancing(void) {
    if (LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    // Clear all cell balancing for all stacks
    for (uint8_t i = 0; i < LTC6802_1_NUM_STACKS; i++) {
        ltc_module.config.discharge_cells[i] = 0;
    }
    BuildConfigData();
    
    // Start discharge configuration write sequence
    ltc_module.state = LTC6802_1_STATE_DISCHARGE_WRITE;
    ltc_module.retry_count = 0;
    ltc_module.state_timestamp = SysTick_Get();
    
    return LTC6802_1_ERROR_NONE;
}

uint16_t LTC6802_1_GetCellVoltage(uint8_t cell_id) {
    if (cell_id >= LTC6802_1_TOTAL_CELLS) {
        return LTC6802_1_INVALID_DATA;
    }
    
    if (!ltc_module.voltage_data_valid || IsDataStale(ltc_module.voltage_data_timestamp)) {
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
    
    if (!ltc_module.temp_data_valid || IsDataStale(ltc_module.temp_data_timestamp)) {
        return LTC6802_1_INVALID_DATA;
    }
    
    // Check for PEC validation failure marker
    if (ltc_module.temp_data[temp_id] == 0xFFFF) {
        return LTC6802_1_INVALID_DATA;
    }
    
    return (float)ltc_module.temp_data[temp_id] * LTC6802_1_VOLTAGE_SCALE_FACTOR;
}

LTC6802_1_Error_E LTC6802_1_GetLastError(uint8_t stack_id) {
    if (stack_id >= LTC6802_1_NUM_STACKS) {
        return LTC6802_1_ERROR_INVALID_STACK;
    }
    
    return ltc_module.last_error[stack_id];
}

void LTC6802_1_ClearError(uint8_t stack_id) {
    if (stack_id < LTC6802_1_NUM_STACKS) {
        ltc_module.last_error[stack_id] = LTC6802_1_ERROR_NONE;
    }
    
    // If all errors cleared, exit faulted state
    if (ltc_module.state == LTC6802_1_STATE_FAULTED) {
        bool all_clear = true;
        for (uint8_t i = 0; i < LTC6802_1_NUM_STACKS; i++) {
            if (ltc_module.last_error[i] != LTC6802_1_ERROR_NONE) {
                all_clear = false;
                break;
            }
        }
        if (all_clear) {
            TransitionToIdle();
        }
    }
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
    ltc_module.state_timestamp = SysTick_Get();
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
        return LTC6802_1_ERROR_SPI_TIMEOUT;
    }
}

static bool IsTimeout(uint32_t start_time, uint32_t timeout_ms) {
    return (SysTick_Get() - start_time) >= timeout_ms;
}

static bool IsDataStale(uint32_t timestamp) {
    return IsTimeout(timestamp, LTC6802_1_DATA_STALE_TIME_MS);
}

static void SetError(uint8_t stack_id, LTC6802_1_Error_E error) {
    if (stack_id < LTC6802_1_NUM_STACKS) {
        ltc_module.last_error[stack_id] = error;
    }
}

static void TransitionToIdle(void) {
    ltc_module.state = LTC6802_1_STATE_IDLE;
    ltc_module.retry_count = 0;
}

static void TransitionToFaulted(LTC6802_1_Error_E error) {
    ltc_module.state = LTC6802_1_STATE_FAULTED;
    SetError(0, error);  // Set error for stack 0 as representative error
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
            for (cell_index; cell_index < LTC6802_1_CELLS_PER_STACK * (stack + 1); cell_index++) {
                ltc_module.voltage_data[cell_index] = 0xFFFF; // Invalid marker
                ltc_module.voltage_data_valid = false; // Mark voltage data as invalid
            }
            // Set error for this stack
            SetError(stack, LTC6802_1_ERROR_CRC_FAIL);

            static uint8_t ticker = 0;
            CAN_bms_debug_float1_set(ticker++);

        }
    }
    
    // Calculate stack and pack voltages
    CalculateStackVoltages();
}

static void CalculateStackVoltages(void) {
    // Calculate stack voltages and pack voltage using integer arithmetic

    // if (ltc_module.voltage_data_valid == false) {
    //     CAN_bms_debug_bool0_set(1);
    //     // If voltage data is invalid, set all voltages to 0
    //     for (uint8_t stack = 0; stack < LTC6802_1_NUM_STACKS; stack++) {
    //         ltc_module.stack_voltage[stack] = 0.0f;
    //     }
    //     ltc_module.pack_voltage = 0.0f;
    //     return;
    // }

    uint32_t pack_voltage_raw = 0;
    
    for (uint8_t stack = 0; stack < LTC6802_1_NUM_STACKS; stack++) {
        uint32_t stack_voltage_raw = 0;
        
        // Sum all valid cell voltages for this stack (raw ADC counts)
        for (uint8_t cell = 0; cell < LTC6802_1_CELLS_PER_STACK; cell++) {
            uint8_t cell_index = stack * LTC6802_1_CELLS_PER_STACK + cell;
            stack_voltage_raw += ltc_module.voltage_data[cell_index];
        }
        
        // Apply scaling factor at the end and store result
        ltc_module.stack_voltage[stack] = (float)stack_voltage_raw * LTC6802_1_VOLTAGE_SCALE_FACTOR;
        
        // Add this stack's raw voltage to total pack voltage
        pack_voltage_raw += stack_voltage_raw;
    }
    
    // Apply scaling factor to pack voltage at the end
    ltc_module.pack_voltage = (float)pack_voltage_raw * LTC6802_1_VOLTAGE_SCALE_FACTOR;
    
}

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
            SetError(stack, LTC6802_1_ERROR_CRC_FAIL);
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
            SetError(stack, LTC6802_1_ERROR_CRC_FAIL);
            TransitionToFaulted(LTC6802_1_ERROR_CRC_FAIL);
            return;
        }
        
        // PEC valid - now compare readback data with what we wrote
        config_valid = (memcmp(&ltc_module.spi_rx_buffer[readback_start+1], 
                              &ltc_module.config_data[written_start+1], 
                              LTC6802_1_CONFIG_REG_SIZE -1) == 0);
        
        if (!config_valid) {
            // Configuration mismatch - hardware didn't accept our config
            ltc_module.debug_failure_point = 2; // Config data mismatch
            SetError(stack, LTC6802_1_ERROR_CRC_FAIL);
            // For safety, transition to faulted state if any config mismatch
            TransitionToFaulted(LTC6802_1_ERROR_CRC_FAIL);
            return;
        }

    }
    
    // All PEC and config validation passed - hardware config is correct
    ltc_module.debug_failure_point = 0; // Success
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

/******************************************************************************
 * Configuration Helper Function Implementations  
 *******************************************************************************/

void LTC6802_1_GetConfig(LTC6802_1_Config_S* config) {
    if (config) {
        *config = ltc_module.config;
    }
}

LTC6802_1_Error_E LTC6802_1_SetCDCMode(uint8_t cdc_mode) {
    if (LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    // CDC mode is 3 bits (0-7)
    ltc_module.config.cdc_mode = cdc_mode & 0x07;
    BuildConfigData();
    
    // Start config write sequence
    ltc_module.state = LTC6802_1_STATE_CONFIG_WRITE;
    ltc_module.retry_count = 0;
    ltc_module.state_timestamp = SysTick_Get();
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_SetVoltageThresholds8(uint8_t overvoltage_threshold, uint8_t undervoltage_threshold, bool send_immediately) {
    if (send_immediately && LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    // Set 8-bit thresholds directly (no conversion needed)
    ltc_module.config.overvoltage_threshold = overvoltage_threshold;
    ltc_module.config.undervoltage_threshold = undervoltage_threshold;
    
    if (send_immediately) {
        BuildConfigData();
        
        // Start config write sequence
        ltc_module.state = LTC6802_1_STATE_CONFIG_WRITE;
        ltc_module.current_stack_index = 0;
        ltc_module.retry_count = 0;
        ltc_module.state_timestamp = SysTick_Get();
    }
    
    return LTC6802_1_ERROR_NONE;
}



LTC6802_1_Error_E LTC6802_1_ResetConfigToDefaults(bool send_immediately) {
    if (send_immediately && LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
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
    
    if (send_immediately) {
        BuildConfigData();
        
        // Start config write sequence
        ltc_module.state = LTC6802_1_STATE_CONFIG_WRITE;
        ltc_module.current_stack_index = 0;
        ltc_module.retry_count = 0;
        ltc_module.state_timestamp = SysTick_Get();
    }
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_SetGPIO1(uint8_t stack_id, bool state, bool send_immediately) {
    if (send_immediately && LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
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
    
    if (send_immediately) {
        BuildConfigData();
        
        // Start config write sequence
        ltc_module.state = LTC6802_1_STATE_CONFIG_WRITE;
        ltc_module.current_stack_index = 0;
        ltc_module.retry_count = 0;
        ltc_module.state_timestamp = SysTick_Get();
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
//        ltc_module.state = LTC6802_1_STATE_CONFIG_WRITE;
//        ltc_module.current_stack_index = 0;
//        ltc_module.retry_count = 0;
//        ltc_module.state_timestamp = SysTick_Get();
//    }
//    
//    return LTC6802_1_ERROR_NONE;
//}

LTC6802_1_Error_E LTC6802_1_SetCellMonitoring(uint8_t stack_id, uint16_t monitor_mask, bool send_immediately) {
    if (send_immediately && LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
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
    
    if (send_immediately) {
        BuildConfigData();
        
        // Start config write sequence
        ltc_module.state = LTC6802_1_STATE_CONFIG_WRITE;
        ltc_module.current_stack_index = 0;
        ltc_module.retry_count = 0;
        ltc_module.state_timestamp = SysTick_Get();
    }
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_SendConfig(void) {
    if (LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    BuildConfigData();
    
    // Start config write sequence
    ltc_module.state = LTC6802_1_STATE_CONFIG_WRITE;
    ltc_module.retry_count = 0;
    ltc_module.state_timestamp = SysTick_Get();
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_SetADCMode(LTC6802_1_ADC_Mode_E mode, bool send_immediately) {
    if (send_immediately && LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    // Set CDC mode based on ADC mode (maps to CDC[2:0] bits)
    ltc_module.config.cdc_mode = (uint8_t)mode;
    
    if (send_immediately) {
        BuildConfigData();
        
        // Start config write sequence
        ltc_module.state = LTC6802_1_STATE_CONFIG_WRITE;
        ltc_module.current_stack_index = 0;
        ltc_module.retry_count = 0;
        ltc_module.state_timestamp = SysTick_Get();
    }
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_SetVoltageThresholds(uint16_t overvoltage_mv, uint16_t undervoltage_mv, bool send_immediately) {
    if (send_immediately && LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    // Convert millivolts to 8-bit threshold values
    // LTC6802-1 uses different scaling than stated 1.5mV per LSB
    // These are 8-bit values, so scale appropriately
    ltc_module.config.overvoltage_threshold = (uint8_t)((overvoltage_mv * 255) / 6000);   // Scale to 8-bit for ~6V max
    ltc_module.config.undervoltage_threshold = (uint8_t)((undervoltage_mv * 255) / 6000); // Scale to 8-bit for ~6V max
    
    if (send_immediately) {
        BuildConfigData();
        
        // Start config write sequence
        ltc_module.state = LTC6802_1_STATE_CONFIG_WRITE;
        ltc_module.current_stack_index = 0;
        ltc_module.retry_count = 0;
        ltc_module.state_timestamp = SysTick_Get();
    }
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_EnableTemperature(bool enable, bool send_immediately) {
    if (send_immediately && LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    // Temperature measurement is controlled by LVLPL bit in CFGR0
    // When LVLPL=1, level polling is enabled (includes temperature)
    ltc_module.config.lvlpl_enable = enable;
    
    if (send_immediately) {
        BuildConfigData();
        
        // Start config write sequence
        ltc_module.state = LTC6802_1_STATE_CONFIG_WRITE;
        ltc_module.current_stack_index = 0;
        ltc_module.retry_count = 0;
        ltc_module.state_timestamp = SysTick_Get();
    }
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_EnableVoltageComparison(uint8_t stack_id, bool enable, bool send_immediately) {
    if (send_immediately && LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
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
    
    if (send_immediately) {
        BuildConfigData();
        
        // Start config write sequence
        ltc_module.state = LTC6802_1_STATE_CONFIG_WRITE;
        ltc_module.current_stack_index = 0;
        ltc_module.retry_count = 0;
        ltc_module.state_timestamp = SysTick_Get();
    }
    
    return LTC6802_1_ERROR_NONE;
}


/******************************************************************************
 * Data Access Function Implementations
 *******************************************************************************/

float LTC6802_1_GetStackVoltage(uint8_t stack_id) {
    if (stack_id >= LTC6802_1_NUM_STACKS) {
        return LTC6802_1_INVALID_DATA;
    }

        if (!ltc_module.voltage_data_valid){
            return LTC6802_1_INVALID_DATA;
        }
        if(IsDataStale(ltc_module.voltage_data_timestamp)) {
            return LTC6802_1_INVALID_DATA;
        }

        return ltc_module.stack_voltage[stack_id];

}

float LTC6802_1_GetPackVoltage(void) {
    if (!ltc_module.voltage_data_valid){
        return LTC6802_1_INVALID_DATA;
    }
    if(IsDataStale(ltc_module.voltage_data_timestamp)) {
        return LTC6802_1_INVALID_DATA;
    }
    return ltc_module.pack_voltage;// return ltc_module.pack_voltage;
}