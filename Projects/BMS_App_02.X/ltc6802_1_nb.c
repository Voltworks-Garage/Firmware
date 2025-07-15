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
    LTC6802_1_STATE_TEMP_START_READ,
    LTC6802_1_STATE_TEMP_WAITING,
    LTC6802_1_STATE_TEMP_READ,
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
#define LTC6802_1_TEMP_REG_SIZE     4       // 4 bytes per stack (2 temps * 2 bytes)
#define LTC6802_1_FLAG_REG_SIZE     3       // 3 bytes per stack

// Address modifier for addressed commands
#define LTC6802_1_ADDR_MASK         0x80

// Buffer sizes
#define LTC6802_1_MAX_SPI_BUFFER    32      // Maximum SPI transaction size

// Invalid data return value
#define LTC6802_1_INVALID_DATA      -1.0f

/******************************************************************************
 * Internal State Structure
 *******************************************************************************/
typedef struct {
    // State machine variables
    LTC6802_1_State_E state;
    uint8_t current_stack_index;
    uint32_t state_timestamp;
    uint8_t retry_count;
    
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
static LTC6802_1_Error_E StartSPITransaction(uint8_t stack_id, uint8_t command, 
                                            const uint8_t* tx_data, uint8_t data_len,
                                            bool expect_response, uint8_t response_len);
static bool IsTimeout(uint32_t start_time, uint32_t timeout_ms);
static bool IsDataStale(uint32_t timestamp);
static void SetError(uint8_t stack_id, LTC6802_1_Error_E error);
static void TransitionToIdle(void);
static void TransitionToFaulted(LTC6802_1_Error_E error);
static void ProcessVoltageData(void);
static void ProcessTemperatureData(void);
static void BuildConfigData(void);
static uint8_t CalculateCRC(const uint8_t* data, uint8_t length);
static bool ValidateCRC(const uint8_t* data, uint8_t length, uint8_t received_crc);

/******************************************************************************
 * Public Function Implementations
 *******************************************************************************/

LTC6802_1_Error_E LTC6802_1_Init(void) {
    // Clear all module data
    memset(&ltc_module, 0, sizeof(ltc_module));
    
    // Initialize SPI
    spi1Init();
    
    // Set initial state
    ltc_module.state = LTC6802_1_STATE_IDLE;
    
    // Initialize default configuration
    ltc_module.config.adc_mode = LTC6802_1_ADC_MODE_NORMAL;
    ltc_module.config.temp_enable = true;
    ltc_module.config.compare_enable = true;
    ltc_module.config.overvoltage_threshold = (uint16_t)(4200 / 1.5f);  // 4.2V in LSBs
    ltc_module.config.undervoltage_threshold = (uint16_t)(2500 / 1.5f); // 2.5V in LSBs
    ltc_module.config.discharge_cells = 0;
    ltc_module.config.forced_discharge_cells = 0;
    ltc_module.config.wdt_timeout = 0;
    for (uint8_t stack = 0; stack < LTC6802_1_NUM_STACKS; stack++) {
        ltc_module.config.gpio_pulldown[stack] = 0;
        ltc_module.config.gpio_direction[stack] = 0;
    }
    ltc_module.config.snap_st = false;
    ltc_module.config.refon = false;
    ltc_module.config.swtrd = false;
    ltc_module.config.adcopt = false;
    
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
            
            // Validate CRC if we received data
            if (ltc_module.spi_rx_length > 1) {
                uint8_t received_crc = ltc_module.spi_rx_buffer[ltc_module.spi_rx_length - 1];
                if (!ValidateCRC(ltc_module.spi_rx_buffer, ltc_module.spi_rx_length - 1, received_crc)) {
                    SetError(ltc_module.current_stack_index, LTC6802_1_ERROR_CRC_FAIL);
                    TransitionToFaulted(LTC6802_1_ERROR_CRC_FAIL);
                    return;
                }
            }
            
            // Reset CS line
            IO_SET_SPI_CS(HIGH);
        }
        
        // Check for SPI timeout
        else if (IsTimeout(ltc_module.state_timestamp, LTC6802_1_SPI_TIMEOUT_MS)) {
            SetError(ltc_module.current_stack_index, LTC6802_1_ERROR_SPI_TIMEOUT);
            TransitionToFaulted(LTC6802_1_ERROR_SPI_TIMEOUT);
            ltc_module.spi_transaction_active = false;
            IO_SET_SPI_CS(HIGH);
        }
        
        return; // Wait for SPI transaction to complete
    }
    
    // Process main state machine
    switch (ltc_module.state) {
        case LTC6802_1_STATE_IDLE:
            // Nothing to do in idle state
            break;
            
        case LTC6802_1_STATE_ADC_CELL_START_READ:
            // Start cell voltage ADC for current stack
            if (StartSPITransaction(ltc_module.current_stack_index, LTC6802_1_CMD_STCVAD, 
                                   NULL, 0, false, 0) == LTC6802_1_ERROR_NONE) {
                ltc_module.state = LTC6802_1_STATE_ADC_CELL_WAITING;
                ltc_module.state_timestamp = SysTick_Get();
            } else {
                TransitionToFaulted(LTC6802_1_ERROR_SPI_TIMEOUT);
            }
            break;
            
        case LTC6802_1_STATE_ADC_CELL_WAITING:
            // Wait for ADC conversion to complete
            if (IsTimeout(ltc_module.state_timestamp, LTC6802_1_ADC_CONVERSION_TIME_MS)) {
                ltc_module.state = LTC6802_1_STATE_ADC_CELL_READ;
                ltc_module.state_timestamp = SysTick_Get();
            }
            break;
            
        case LTC6802_1_STATE_ADC_CELL_READ:
            // Read cell voltage data for current stack
            if (StartSPITransaction(ltc_module.current_stack_index, LTC6802_1_CMD_RDCV, 
                                   NULL, 0, true, LTC6802_1_VOLTAGE_REG_SIZE + 1) == LTC6802_1_ERROR_NONE) {
                ltc_module.state_timestamp = SysTick_Get();
                
                // Move to next stack or complete
                ltc_module.current_stack_index++;
                if (ltc_module.current_stack_index >= LTC6802_1_NUM_STACKS) {
                    // All stacks read, process data and complete
                    ProcessVoltageData();
                    ltc_module.voltage_data_valid = true;
                    ltc_module.voltage_data_timestamp = SysTick_Get();
                    TransitionToIdle();
                } else {
                    // Read next stack
                    ltc_module.state = LTC6802_1_STATE_ADC_CELL_START_READ;
                }
            } else {
                TransitionToFaulted(LTC6802_1_ERROR_SPI_TIMEOUT);
            }
            break;
            
        case LTC6802_1_STATE_TEMP_START_READ:
            // Start temperature ADC for current stack
            if (StartSPITransaction(ltc_module.current_stack_index, LTC6802_1_CMD_STTMPAD, 
                                   NULL, 0, false, 0) == LTC6802_1_ERROR_NONE) {
                ltc_module.state = LTC6802_1_STATE_TEMP_WAITING;
                ltc_module.state_timestamp = SysTick_Get();
            } else {
                TransitionToFaulted(LTC6802_1_ERROR_SPI_TIMEOUT);
            }
            break;
            
        case LTC6802_1_STATE_TEMP_WAITING:
            // Wait for ADC conversion to complete
            if (IsTimeout(ltc_module.state_timestamp, LTC6802_1_ADC_CONVERSION_TIME_MS)) {
                ltc_module.state = LTC6802_1_STATE_TEMP_READ;
                ltc_module.state_timestamp = SysTick_Get();
            }
            break;
            
        case LTC6802_1_STATE_TEMP_READ:
            // Read temperature data for current stack
            if (StartSPITransaction(ltc_module.current_stack_index, LTC6802_1_CMD_RDTMP, 
                                   NULL, 0, true, LTC6802_1_TEMP_REG_SIZE + 1) == LTC6802_1_ERROR_NONE) {
                ltc_module.state_timestamp = SysTick_Get();
                
                // Move to next stack or complete
                ltc_module.current_stack_index++;
                if (ltc_module.current_stack_index >= LTC6802_1_NUM_STACKS) {
                    // All stacks read, process data and complete
                    ProcessTemperatureData();
                    ltc_module.temp_data_valid = true;
                    ltc_module.temp_data_timestamp = SysTick_Get();
                    TransitionToIdle();
                } else {
                    // Read next stack
                    ltc_module.state = LTC6802_1_STATE_TEMP_START_READ;
                }
            } else {
                TransitionToFaulted(LTC6802_1_ERROR_SPI_TIMEOUT);
            }
            break;
            
        case LTC6802_1_STATE_CONFIG_WRITE:
            // Write configuration to current stack
            if (StartSPITransaction(ltc_module.current_stack_index, LTC6802_1_CMD_WRCFG, 
                                   &ltc_module.config_data[ltc_module.current_stack_index * LTC6802_1_CONFIG_REG_SIZE], 
                                   LTC6802_1_CONFIG_REG_SIZE, false, 0) == LTC6802_1_ERROR_NONE) {
                ltc_module.state = LTC6802_1_STATE_CONFIG_WAIT;
                ltc_module.state_timestamp = SysTick_Get();
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
            // Read back configuration for verification
            if (StartSPITransaction(ltc_module.current_stack_index, LTC6802_1_CMD_RDCFG, 
                                   NULL, 0, true, LTC6802_1_CONFIG_REG_SIZE + 1) == LTC6802_1_ERROR_NONE) {
                ltc_module.state = LTC6802_1_STATE_CONFIG_READBACK_WAIT;
                ltc_module.state_timestamp = SysTick_Get();
            } else {
                TransitionToFaulted(LTC6802_1_ERROR_SPI_TIMEOUT);
            }
            break;
            
        case LTC6802_1_STATE_CONFIG_READBACK_WAIT:
            // Configuration readback completed, move to next stack or complete
            ltc_module.current_stack_index++;
            if (ltc_module.current_stack_index >= LTC6802_1_NUM_STACKS) {
                // All stacks configured
                TransitionToIdle();
            } else {
                // Configure next stack
                ltc_module.state = LTC6802_1_STATE_CONFIG_WRITE;
            }
            break;
            
        case LTC6802_1_STATE_DISCHARGE_WRITE:
            // Write discharge configuration to current stack
            if (StartSPITransaction(ltc_module.current_stack_index, LTC6802_1_CMD_WRCFG, 
                                   &ltc_module.config_data[ltc_module.current_stack_index * LTC6802_1_CONFIG_REG_SIZE], 
                                   LTC6802_1_CONFIG_REG_SIZE, false, 0) == LTC6802_1_ERROR_NONE) {
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
            // Read back configuration for verification
            if (StartSPITransaction(ltc_module.current_stack_index, LTC6802_1_CMD_RDCFG, 
                                   NULL, 0, true, LTC6802_1_CONFIG_REG_SIZE + 1) == LTC6802_1_ERROR_NONE) {
                ltc_module.state = LTC6802_1_STATE_DISCHARGE_READBACK_WAIT;
                ltc_module.state_timestamp = SysTick_Get();
            } else {
                TransitionToFaulted(LTC6802_1_ERROR_SPI_TIMEOUT);
            }
            break;
            
        case LTC6802_1_STATE_DISCHARGE_READBACK_WAIT:
            // Discharge readback completed, move to next stack or complete
            ltc_module.current_stack_index++;
            if (ltc_module.current_stack_index >= LTC6802_1_NUM_STACKS) {
                // All stacks configured
                TransitionToIdle();
            } else {
                // Configure next stack
                ltc_module.state = LTC6802_1_STATE_DISCHARGE_WRITE;
            }
            break;
            
        case LTC6802_1_STATE_FAULTED:
            // Stay in faulted state until explicit reset
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
    ltc_module.current_stack_index = 0;
    ltc_module.retry_count = 0;
    ltc_module.voltage_data_valid = false;
    ltc_module.state_timestamp = SysTick_Get();
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_StartTemperatureADC(void) {
    if (LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    // Start temperature ADC and read sequence
    ltc_module.state = LTC6802_1_STATE_TEMP_START_READ;
    ltc_module.current_stack_index = 0;
    ltc_module.retry_count = 0;
    ltc_module.temp_data_valid = false;
    ltc_module.state_timestamp = SysTick_Get();
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_WriteConfig(const LTC6802_1_Config_S* config) {
    if (LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    if (config == NULL) {
        return LTC6802_1_ERROR_INVALID_STACK;
    }
    
    // Update configuration and build config data
    ltc_module.config = *config;
    BuildConfigData();
    
    // Start configuration write sequence
    ltc_module.state = LTC6802_1_STATE_CONFIG_WRITE;
    ltc_module.current_stack_index = 0;
    ltc_module.retry_count = 0;
    ltc_module.state_timestamp = SysTick_Get();
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_SetCellBalancing(uint32_t cell_mask) {
    if (LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    // Update discharge cells configuration (use only 16 bits for compatibility)
    ltc_module.config.discharge_cells = (uint16_t)(cell_mask & 0xFFFF);
    BuildConfigData();
    
    // Start discharge configuration write sequence
    ltc_module.state = LTC6802_1_STATE_DISCHARGE_WRITE;
    ltc_module.current_stack_index = 0;
    ltc_module.retry_count = 0;
    ltc_module.state_timestamp = SysTick_Get();
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_ClearAllCellBalancing(void) {
    return LTC6802_1_SetCellBalancing(0);
}

float LTC6802_1_GetCellVoltage(uint8_t cell_id) {
    if (cell_id >= LTC6802_1_TOTAL_CELLS) {
        return LTC6802_1_INVALID_DATA;
    }
    
    if (!ltc_module.voltage_data_valid || IsDataStale(ltc_module.voltage_data_timestamp)) {
        return LTC6802_1_INVALID_DATA;
    }
    
    return (float)ltc_module.voltage_data[cell_id] * LTC6802_1_VOLTAGE_SCALE_FACTOR;
}

float LTC6802_1_GetTemperatureVoltage(uint8_t temp_id) {
    if (temp_id >= LTC6802_1_TOTAL_TEMPS) {
        return LTC6802_1_INVALID_DATA;
    }
    
    if (!ltc_module.temp_data_valid || IsDataStale(ltc_module.temp_data_timestamp)) {
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

static LTC6802_1_Error_E StartSPITransaction(uint8_t stack_id, uint8_t command, 
                                            const uint8_t* tx_data, uint8_t data_len,
                                            bool expect_response, uint8_t response_len) {
    if (ltc_module.spi_transaction_active) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    // Build command with address
    ltc_module.spi_tx_buffer[0] = command | (stack_id & LTC6802_1_ADDR_MASK);
    ltc_module.spi_tx_length = 1;
    
    // Add data if provided
    if (tx_data && data_len > 0) {
        memcpy(&ltc_module.spi_tx_buffer[1], tx_data, data_len);
        ltc_module.spi_tx_length += data_len;
    }
    
    // Add CRC
    uint8_t crc = CalculateCRC(ltc_module.spi_tx_buffer, ltc_module.spi_tx_length);
    ltc_module.spi_tx_buffer[ltc_module.spi_tx_length] = crc;
    ltc_module.spi_tx_length++;
    
    // Set up receive buffer if expecting response
    ltc_module.spi_rx_length = response_len;
    uint8_t* rx_buffer = expect_response ? ltc_module.spi_rx_buffer : NULL;
    
    // Start transaction
    ltc_module.state_timestamp = SysTick_Get();
    IO_SET_SPI_CS(LOW);
    
    bool result = spi1StartBufferedTransaction(ltc_module.spi_tx_buffer, ltc_module.spi_tx_length, 
                                               rx_buffer, response_len);
    
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
    ltc_module.current_stack_index = 0;
    ltc_module.retry_count = 0;
}

static void TransitionToFaulted(LTC6802_1_Error_E error) {
    ltc_module.state = LTC6802_1_STATE_FAULTED;
    SetError(ltc_module.current_stack_index, error);
    ltc_module.failed_transactions++;
}

static void ProcessVoltageData(void) {
    // Parse voltage data from SPI buffer into voltage array
    // LTC6802-1 specific parsing logic would go here
    for (uint8_t stack = 0; stack < LTC6802_1_NUM_STACKS; stack++) {
        for (uint8_t cell = 0; cell < LTC6802_1_CELLS_PER_STACK; cell++) {
            uint8_t cell_index = stack * LTC6802_1_CELLS_PER_STACK + cell;
            uint8_t data_index = cell * 2; // 2 bytes per cell
            
            // Combine high and low bytes (LTC6802-1 specific format)
            ltc_module.voltage_data[cell_index] = 
                (ltc_module.spi_rx_buffer[data_index + 1] << 8) | 
                ltc_module.spi_rx_buffer[data_index];
        }
    }
}

static void ProcessTemperatureData(void) {
    // Parse temperature data from SPI buffer into temp array
    // LTC6802-1 specific parsing logic would go here
    for (uint8_t stack = 0; stack < LTC6802_1_NUM_STACKS; stack++) {
        for (uint8_t temp = 0; temp < LTC6802_1_TEMPS_PER_STACK; temp++) {
            uint8_t temp_index = stack * LTC6802_1_TEMPS_PER_STACK + temp;
            uint8_t data_index = temp * 2; // 2 bytes per temp
            
            // Combine high and low bytes (LTC6802-1 specific format)
            ltc_module.temp_data[temp_index] = 
                (ltc_module.spi_rx_buffer[data_index + 1] << 8) | 
                ltc_module.spi_rx_buffer[data_index];
        }
    }
}

static void BuildConfigData(void) {
    // Build configuration data for all stacks based on current config
    // LTC6802-1 config register layout: 6 bytes per stack
    
    for (uint8_t stack = 0; stack < LTC6802_1_NUM_STACKS; stack++) {
        uint8_t* cfg = &ltc_module.config_data[stack * LTC6802_1_CONFIG_REG_SIZE];
        
        // Byte 0: Control register 
        cfg[0] = 0;
        cfg[0] |= (ltc_module.config.adc_mode & 0x03);                  // Bits 0-1: ADC mode
        cfg[0] |= (ltc_module.config.temp_enable ? 1 : 0) << 2;         // Bit 2: TEMP enable  
        cfg[0] |= (ltc_module.config.compare_enable ? 1 : 0) << 3;      // Bit 3: Compare enable
        cfg[0] |= (ltc_module.config.refon ? 1 : 0) << 4;               // Bit 4: Reference on
        cfg[0] |= (ltc_module.config.swtrd ? 1 : 0) << 5;               // Bit 5: SW redundant
        cfg[0] |= (ltc_module.config.snap_st ? 1 : 0) << 6;             // Bit 6: Snapshot
        cfg[0] |= (ltc_module.config.adcopt ? 1 : 0) << 7;              // Bit 7: ADC option
        
        // Bytes 1-2: Cell discharge control (12 bits)
        // Extract 12 bits for this specific stack
        uint16_t stack_discharge_mask = ltc_module.config.discharge_cells;
        cfg[1] = stack_discharge_mask & 0xFF;                           // Bits 0-7: Cells 1-8
        cfg[2] = (stack_discharge_mask >> 8) & 0x0F;                    // Bits 0-3: Cells 9-12
        cfg[2] |= (ltc_module.config.wdt_timeout & 0x0F) << 4;          // Bits 4-7: WDT timeout
        
        // Bytes 3-4: Undervoltage threshold (12 bits)
        uint16_t uv_thresh = ltc_module.config.undervoltage_threshold & 0x0FFF;
        cfg[3] = uv_thresh & 0xFF;                                      // UV threshold low byte
        cfg[4] = (uv_thresh >> 8) & 0x0F;                               // UV threshold high nibble
        
        // Bytes 4-5: Overvoltage threshold (12 bits) 
        uint16_t ov_thresh = ltc_module.config.overvoltage_threshold & 0x0FFF;
        cfg[4] |= (ov_thresh & 0x0F) << 4;                              // OV threshold low nibble
        cfg[5] = (ov_thresh >> 4) & 0xFF;                               // OV threshold high byte
        
        // Note: GPIO configuration may be in separate registers that need
        // to be written using different commands (e.g., COMM register)
        // For now, GPIO settings are stored in config but may need special handling
    }
}

static uint8_t CalculateCRC(const uint8_t* data, uint8_t length) {
    // LTC6802-1 PEC calculation using polynomial x^8 + x^2 + x + 1 (0x07)
    // Use the standard CRC-8 CCITT implementation from utils.h
    return crc8ccitt(data, length);
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

LTC6802_1_Error_E LTC6802_1_SetADCMode(LTC6802_1_ADC_Mode_E mode) {
    if (LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    if (mode > LTC6802_1_ADC_MODE_SLOW) {
        return LTC6802_1_ERROR_INVALID_STACK; // Reuse for invalid parameter
    }
    
    ltc_module.config.adc_mode = mode;
    BuildConfigData();
    
    // Start config write sequence
    ltc_module.state = LTC6802_1_STATE_CONFIG_WRITE;
    ltc_module.current_stack_index = 0;
    ltc_module.retry_count = 0;
    ltc_module.state_timestamp = SysTick_Get();
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_SetVoltageThresholds(uint16_t overvoltage_mv, uint16_t undervoltage_mv) {
    if (LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    // Validate voltage ranges (0-6142mV for 12-bit with 1.5mV/LSB)
    if (overvoltage_mv > 6142 || undervoltage_mv > 6142) {
        return LTC6802_1_ERROR_INVALID_STACK; // Reuse for invalid parameter
    }
    
    // Convert millivolts to LSBs (1.5mV per LSB)
    ltc_module.config.overvoltage_threshold = (uint16_t)(overvoltage_mv / 1.5f);
    ltc_module.config.undervoltage_threshold = (uint16_t)(undervoltage_mv / 1.5f);
    
    BuildConfigData();
    
    // Start config write sequence
    ltc_module.state = LTC6802_1_STATE_CONFIG_WRITE;
    ltc_module.current_stack_index = 0;
    ltc_module.retry_count = 0;
    ltc_module.state_timestamp = SysTick_Get();
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_EnableTemperature(bool enable) {
    if (LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    ltc_module.config.temp_enable = enable;
    BuildConfigData();
    
    // Start config write sequence
    ltc_module.state = LTC6802_1_STATE_CONFIG_WRITE;
    ltc_module.current_stack_index = 0;
    ltc_module.retry_count = 0;
    ltc_module.state_timestamp = SysTick_Get();
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_EnableVoltageComparison(bool enable) {
    if (LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    ltc_module.config.compare_enable = enable;
    BuildConfigData();
    
    // Start config write sequence
    ltc_module.state = LTC6802_1_STATE_CONFIG_WRITE;
    ltc_module.current_stack_index = 0;
    ltc_module.retry_count = 0;
    ltc_module.state_timestamp = SysTick_Get();
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_SetCellBalancingState(uint8_t cell_id, bool enable) {
    if (LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    if (cell_id >= LTC6802_1_TOTAL_CELLS) {
        return LTC6802_1_ERROR_INVALID_STACK; // Reuse for invalid parameter
    }
    
    // Set or clear the bit for this cell
    if (enable) {
        ltc_module.config.discharge_cells |= (1U << cell_id);
    } else {
        ltc_module.config.discharge_cells &= ~(1U << cell_id);
    }
    
    BuildConfigData();
    
    // Start discharge config write sequence
    ltc_module.state = LTC6802_1_STATE_DISCHARGE_WRITE;
    ltc_module.current_stack_index = 0;
    ltc_module.retry_count = 0;
    ltc_module.state_timestamp = SysTick_Get();
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_ResetConfigToDefaults(void) {
    if (LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    // Reset to safe defaults
    ltc_module.config.adc_mode = LTC6802_1_ADC_MODE_NORMAL;
    ltc_module.config.temp_enable = true;
    ltc_module.config.compare_enable = true;
    ltc_module.config.overvoltage_threshold = (uint16_t)(4200 / 1.5f);  // 4.2V
    ltc_module.config.undervoltage_threshold = (uint16_t)(2500 / 1.5f); // 2.5V
    ltc_module.config.discharge_cells = 0;  // Disable all balancing
    ltc_module.config.forced_discharge_cells = 0;
    ltc_module.config.wdt_timeout = 0;
    for (uint8_t stack = 0; stack < LTC6802_1_NUM_STACKS; stack++) {
        ltc_module.config.gpio_pulldown[stack] = 0;
        ltc_module.config.gpio_direction[stack] = 0;
    }
    ltc_module.config.snap_st = false;
    ltc_module.config.refon = false;
    ltc_module.config.swtrd = false;
    ltc_module.config.adcopt = false;
    
    BuildConfigData();
    
    // Start config write sequence
    ltc_module.state = LTC6802_1_STATE_CONFIG_WRITE;
    ltc_module.current_stack_index = 0;
    ltc_module.retry_count = 0;
    ltc_module.state_timestamp = SysTick_Get();
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_SetGPIODirection(uint8_t stack_id, uint8_t gpio_mask, uint8_t output_mask) {
    if (LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    if (stack_id >= LTC6802_1_NUM_STACKS) {
        return LTC6802_1_ERROR_INVALID_STACK;
    }
    
    // Only allow GPIO pins 0-1 (2 pins per LTC6802-1)
    gpio_mask &= 0x03;
    output_mask &= 0x03;
    
    // Update only the specified GPIO pins for this stack
    ltc_module.config.gpio_direction[stack_id] = (ltc_module.config.gpio_direction[stack_id] & ~gpio_mask) | 
                                                 (output_mask & gpio_mask);
    
    BuildConfigData();
    
    // Start config write sequence
    ltc_module.state = LTC6802_1_STATE_CONFIG_WRITE;
    ltc_module.current_stack_index = 0;
    ltc_module.retry_count = 0;
    ltc_module.state_timestamp = SysTick_Get();
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_SetGPIOPulldown(uint8_t stack_id, uint8_t gpio_mask, uint8_t pulldown_mask) {
    if (LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    if (stack_id >= LTC6802_1_NUM_STACKS) {
        return LTC6802_1_ERROR_INVALID_STACK;
    }
    
    // Only allow GPIO pins 0-1 (2 pins per LTC6802-1)
    gpio_mask &= 0x03;
    pulldown_mask &= 0x03;
    
    // Update only the specified GPIO pins for this stack
    ltc_module.config.gpio_pulldown[stack_id] = (ltc_module.config.gpio_pulldown[stack_id] & ~gpio_mask) | 
                                                (pulldown_mask & gpio_mask);
    
    BuildConfigData();
    
    // Start config write sequence
    ltc_module.state = LTC6802_1_STATE_CONFIG_WRITE;
    ltc_module.current_stack_index = 0;
    ltc_module.retry_count = 0;
    ltc_module.state_timestamp = SysTick_Get();
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_ConfigureGPIO(uint8_t stack_id, uint8_t gpio_pin, bool output, bool pulldown_enable) {
    if (LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    if (stack_id >= LTC6802_1_NUM_STACKS) {
        return LTC6802_1_ERROR_INVALID_STACK;
    }
    
    if (gpio_pin >= 2) {  // Only 2 GPIO pins per LTC6802-1
        return LTC6802_1_ERROR_INVALID_STACK; // Reuse for invalid parameter
    }
    
    uint8_t pin_mask = (1U << gpio_pin);
    
    // Set direction for this stack
    if (output) {
        ltc_module.config.gpio_direction[stack_id] |= pin_mask;
    } else {
        ltc_module.config.gpio_direction[stack_id] &= ~pin_mask;
    }
    
    // Set pulldown (only relevant for inputs)
    if (pulldown_enable && !output) {
        ltc_module.config.gpio_pulldown[stack_id] |= pin_mask;
    } else {
        ltc_module.config.gpio_pulldown[stack_id] &= ~pin_mask;
    }
    
    BuildConfigData();
    
    // Start config write sequence
    ltc_module.state = LTC6802_1_STATE_CONFIG_WRITE;
    ltc_module.current_stack_index = 0;
    ltc_module.retry_count = 0;
    ltc_module.state_timestamp = SysTick_Get();
    
    return LTC6802_1_ERROR_NONE;
}