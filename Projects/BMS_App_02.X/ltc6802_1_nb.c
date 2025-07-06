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

/******************************************************************************
 * Internal State Structure
 *******************************************************************************/
typedef struct {
    // State machine variables
    LTC6802_1_State_E state;
    LTC6802_1_Operation_E current_operation;
    uint8_t target_stack;
    uint8_t current_stack_index;
    uint32_t state_timestamp;
    uint8_t retry_count;
    
    // SPI transaction management
    uint8_t spi_tx_buffer[LTC6802_1_MAX_SPI_BUFFER];
    uint8_t spi_rx_buffer[LTC6802_1_MAX_SPI_BUFFER];
    uint8_t spi_tx_index;
    uint8_t spi_rx_index;
    bool spi_transaction_active;
    
    // Configuration data
    LTC6802_1_Config_S config[LTC6802_1_NUM_STACKS];
    uint8_t config_data[LTC6802_1_NUM_STACKS * LTC6802_1_CONFIG_REG_SIZE];
    
    // Measurement data
    uint8_t voltage_data[LTC6802_1_NUM_STACKS * LTC6802_1_VOLTAGE_REG_SIZE];
    uint8_t temp_data[LTC6802_1_NUM_STACKS * LTC6802_1_TEMP_REG_SIZE];
    
    // Error tracking
    LTC6802_1_Error_E last_error[LTC6802_1_NUM_STACKS];
    
    // Statistics
    uint32_t total_transactions;
    uint32_t failed_transactions;
    uint32_t total_retries;
    
    // Callback
    LTC6802_1_Callback_F completion_callback;
    
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
static LTC6802_1_Error_E ValidateCRC(const uint8_t* data, uint8_t len, uint8_t received_crc);
static void SetError(uint8_t stack_id, LTC6802_1_Error_E error);
static void CompleteOperation(LTC6802_1_Error_E error);
static bool IsTimeout(uint32_t start_time, uint32_t timeout_ms);
static void UpdateConfigData(uint8_t stack_id);
static uint8_t GetStackAddress(uint8_t stack_id);

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
    ltc_module.current_operation = LTC6802_1_OP_NONE;
    
    // Initialize default configuration for all stacks
    for (uint8_t i = 0; i < LTC6802_1_NUM_STACKS; i++) {
        ltc_module.config[i].adc_mode = 1;  // Normal ADC mode
        ltc_module.config[i].temp_enable = 1;  // Enable temperature measurement
        ltc_module.config[i].overvoltage_threshold = (uint16_t)(4.2f / LTC6802_1_VOLTAGE_SCALE_FACTOR);
        ltc_module.config[i].undervoltage_threshold = (uint16_t)(2.5f / LTC6802_1_VOLTAGE_SCALE_FACTOR);
    }
    
    return LTC6802_1_ERROR_NONE;
}

void LTC6802_1_RegisterCallback(LTC6802_1_Callback_F callback) {
    ltc_module.completion_callback = callback;
}

void LTC6802_1_Run(void) {
    // Check if SPI transaction is complete
    if (ltc_module.spi_transaction_active) {
        if (spi1IsBufferedTransactionComplete()) {
            // Transaction completed
            uint8_t bytes_transferred = spi1GetBufferedTransactionResult();
            ltc_module.spi_transaction_active = false;
            
            // Validate CRC if we received data
            if (ltc_module.spi_rx_index > 1) {
                uint8_t received_crc = ltc_module.spi_rx_buffer[ltc_module.spi_rx_index - 1];
                LTC6802_1_Error_E crc_result = ValidateCRC(ltc_module.spi_rx_buffer, 
                                                           ltc_module.spi_rx_index - 1, 
                                                           received_crc);
                if (crc_result != LTC6802_1_ERROR_NONE) {
                    SetError(ltc_module.current_stack_index, crc_result);
                    ltc_module.state = LTC6802_1_STATE_ERROR;
                }
            }
            
            // Reset CS line
            IO_SET_SPI_CS(HIGH);
        }
        
        // Check for SPI timeout
        else if (IsTimeout(ltc_module.state_timestamp, LTC6802_1_SPI_TIMEOUT_MS)) {
            SetError(ltc_module.current_stack_index, LTC6802_1_ERROR_SPI_TIMEOUT);
            ltc_module.state = LTC6802_1_STATE_ERROR;
            ltc_module.spi_transaction_active = false;
            IO_SET_SPI_CS(HIGH);
        }
    }
    
    // Process main state machine
    switch (ltc_module.state) {
        case LTC6802_1_STATE_IDLE:
            // Nothing to do in idle state
            break;
            
        case LTC6802_1_STATE_CONFIG_WRITE_WAIT:
            if (!ltc_module.spi_transaction_active) {
                // Configuration write completed, move to next stack or complete
                if (ltc_module.target_stack == 0xFF) {
                    // Broadcast operation
                    ltc_module.current_stack_index++;
                    if (ltc_module.current_stack_index >= LTC6802_1_NUM_STACKS) {
                        CompleteOperation(LTC6802_1_ERROR_NONE);
                    } else {
                        ltc_module.state = LTC6802_1_STATE_CONFIG_WRITE;
                    }
                } else {
                    // Single stack operation
                    CompleteOperation(LTC6802_1_ERROR_NONE);
                }
            }
            break;
            
        case LTC6802_1_STATE_ADC_START_WAIT:
            if (!ltc_module.spi_transaction_active) {
                // ADC start completed
                ltc_module.state = LTC6802_1_STATE_ADC_POLL;
                ltc_module.state_timestamp = SysTick_Get();
            }
            break;
            
        case LTC6802_1_STATE_ADC_POLL:
            // Wait for ADC conversion time before polling
            if (IsTimeout(ltc_module.state_timestamp, LTC6802_1_ADC_CONVERSION_TIME_MS)) {
                uint8_t stack_id = (ltc_module.target_stack == 0xFF) ? 0 : ltc_module.target_stack;
                LTC6802_1_Error_E error = StartSPITransaction(stack_id, LTC6802_1_CMD_PLADC, 
                                                             NULL, 0, true, 1);
                if (error == LTC6802_1_ERROR_NONE) {
                    ltc_module.state = LTC6802_1_STATE_ADC_POLL_WAIT;
                } else {
                    ltc_module.state = LTC6802_1_STATE_ERROR;
                }
            }
            break;
            
        case LTC6802_1_STATE_ADC_POLL_WAIT:
            if (!ltc_module.spi_transaction_active) {
                // Check ADC status (0 = conversion complete)
                if (ltc_module.spi_rx_buffer[0] == 0) {
                    // Conversion complete, proceed to read data
                    if (ltc_module.current_operation == LTC6802_1_OP_READ_VOLTAGES) {
                        ltc_module.state = LTC6802_1_STATE_VOLTAGE_READ;
                        ltc_module.current_stack_index = 0;
                    } else if (ltc_module.current_operation == LTC6802_1_OP_READ_TEMPERATURES) {
                        ltc_module.state = LTC6802_1_STATE_TEMP_READ;
                        ltc_module.current_stack_index = 0;
                    }
                } else {
                    // Still converting, poll again after delay
                    ltc_module.state = LTC6802_1_STATE_ADC_POLL;
                    ltc_module.state_timestamp = SysTick_Get();
                }
            }
            break;
            
        case LTC6802_1_STATE_VOLTAGE_READ_WAIT:
            if (!ltc_module.spi_transaction_active) {
                // Voltage read completed for current stack
                ltc_module.current_stack_index++;
                if ((ltc_module.target_stack != 0xFF && ltc_module.current_stack_index > ltc_module.target_stack) ||
                    (ltc_module.target_stack == 0xFF && ltc_module.current_stack_index >= LTC6802_1_NUM_STACKS)) {
                    CompleteOperation(LTC6802_1_ERROR_NONE);
                } else {
                    ltc_module.state = LTC6802_1_STATE_VOLTAGE_READ;
                }
            }
            break;
            
        case LTC6802_1_STATE_TEMP_READ_WAIT:
            if (!ltc_module.spi_transaction_active) {
                // Temperature read completed for current stack
                ltc_module.current_stack_index++;
                if ((ltc_module.target_stack != 0xFF && ltc_module.current_stack_index > ltc_module.target_stack) ||
                    (ltc_module.target_stack == 0xFF && ltc_module.current_stack_index >= LTC6802_1_NUM_STACKS)) {
                    CompleteOperation(LTC6802_1_ERROR_NONE);
                } else {
                    ltc_module.state = LTC6802_1_STATE_TEMP_READ;
                }
            }
            break;
            
        case LTC6802_1_STATE_CONFIG_WRITE:
            UpdateConfigData(ltc_module.current_stack_index);
            {
                LTC6802_1_Error_E error = StartSPITransaction(ltc_module.current_stack_index, 
                    LTC6802_1_CMD_WRCFG, 
                    &ltc_module.config_data[ltc_module.current_stack_index * LTC6802_1_CONFIG_REG_SIZE],
                    LTC6802_1_CONFIG_REG_SIZE, false, 0);
                if (error == LTC6802_1_ERROR_NONE) {
                    ltc_module.state = LTC6802_1_STATE_CONFIG_WRITE_WAIT;
                } else {
                    ltc_module.state = LTC6802_1_STATE_ERROR;
                }
            }
            break;
            
        case LTC6802_1_STATE_ADC_START:
            {
                uint8_t command = (ltc_module.current_operation == LTC6802_1_OP_START_ADC_VOLTAGES) ? 
                                 LTC6802_1_CMD_STCVDC : LTC6802_1_CMD_STTMPAD;
                uint8_t stack_id = (ltc_module.target_stack == 0xFF) ? 0 : ltc_module.target_stack;
                
                LTC6802_1_Error_E error = StartSPITransaction(stack_id, command, NULL, 0, false, 0);
                if (error == LTC6802_1_ERROR_NONE) {
                    ltc_module.state = LTC6802_1_STATE_ADC_START_WAIT;
                } else {
                    ltc_module.state = LTC6802_1_STATE_ERROR;
                }
            }
            break;
            
        case LTC6802_1_STATE_VOLTAGE_READ:
            {
                uint8_t stack_id = (ltc_module.target_stack == 0xFF) ? 
                                  ltc_module.current_stack_index : ltc_module.target_stack;
                uint8_t* data_ptr = &ltc_module.voltage_data[stack_id * LTC6802_1_VOLTAGE_REG_SIZE];
                
                LTC6802_1_Error_E error = StartSPITransaction(stack_id, LTC6802_1_CMD_RDCV, 
                                                             NULL, 0, true, LTC6802_1_VOLTAGE_REG_SIZE + 1);
                if (error == LTC6802_1_ERROR_NONE) {
                    ltc_module.state = LTC6802_1_STATE_VOLTAGE_READ_WAIT;
                } else {
                    ltc_module.state = LTC6802_1_STATE_ERROR;
                }
            }
            break;
            
        case LTC6802_1_STATE_TEMP_READ:
            {
                uint8_t stack_id = (ltc_module.target_stack == 0xFF) ? 
                                  ltc_module.current_stack_index : ltc_module.target_stack;
                uint8_t* data_ptr = &ltc_module.temp_data[stack_id * LTC6802_1_TEMP_REG_SIZE];
                
                LTC6802_1_Error_E error = StartSPITransaction(stack_id, LTC6802_1_CMD_RDTMP, 
                                                             NULL, 0, true, LTC6802_1_TEMP_REG_SIZE + 1);
                if (error == LTC6802_1_ERROR_NONE) {
                    ltc_module.state = LTC6802_1_STATE_TEMP_READ_WAIT;
                } else {
                    ltc_module.state = LTC6802_1_STATE_ERROR;
                }
            }
            break;
            
        case LTC6802_1_STATE_ERROR:
            // Handle error - retry if possible
            if (ltc_module.retry_count < LTC6802_1_MAX_RETRIES) {
                ltc_module.retry_count++;
                ltc_module.total_retries++;
                // Reset to appropriate state to retry
                switch (ltc_module.current_operation) {
                    case LTC6802_1_OP_WRITE_CONFIG:
                        ltc_module.state = LTC6802_1_STATE_CONFIG_WRITE;
                        break;
                    case LTC6802_1_OP_START_ADC_VOLTAGES:
                    case LTC6802_1_OP_START_ADC_TEMPERATURES:
                        ltc_module.state = LTC6802_1_STATE_ADC_START;
                        break;
                    case LTC6802_1_OP_READ_VOLTAGES:
                        ltc_module.state = LTC6802_1_STATE_VOLTAGE_READ;
                        break;
                    case LTC6802_1_OP_READ_TEMPERATURES:
                        ltc_module.state = LTC6802_1_STATE_TEMP_READ;
                        break;
                    default:
                        CompleteOperation(LTC6802_1_ERROR_MAX_RETRIES);
                        break;
                }
            } else {
                CompleteOperation(LTC6802_1_ERROR_MAX_RETRIES);
            }
            break;
            
        case LTC6802_1_STATE_COMPLETE:
            // Operation completed, return to idle
            ltc_module.state = LTC6802_1_STATE_IDLE;
            ltc_module.current_operation = LTC6802_1_OP_NONE;
            break;
    }
}

bool LTC6802_1_IsBusy(void) {
    return (ltc_module.state != LTC6802_1_STATE_IDLE);
}

LTC6802_1_State_E LTC6802_1_GetState(void) {
    return ltc_module.state;
}

LTC6802_1_Error_E LTC6802_1_SetConfig(uint8_t stack_id, const LTC6802_1_Config_S* config) {
    if (stack_id >= LTC6802_1_NUM_STACKS) {
        return LTC6802_1_ERROR_INVALID_STACK;
    }
    
    ltc_module.config[stack_id] = *config;
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_WriteConfig(uint8_t stack_id) {
    if (LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    if (stack_id != 0xFF && stack_id >= LTC6802_1_NUM_STACKS) {
        return LTC6802_1_ERROR_INVALID_STACK;
    }
    
    ltc_module.state = LTC6802_1_STATE_CONFIG_WRITE;
    ltc_module.current_operation = LTC6802_1_OP_WRITE_CONFIG;
    ltc_module.target_stack = stack_id;
    ltc_module.current_stack_index = (stack_id == 0xFF) ? 0 : stack_id;
    ltc_module.retry_count = 0;
    ltc_module.state_timestamp = SysTick_Get();
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_StartCellVoltageADC(uint8_t stack_id) {
    if (LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    if (stack_id != 0xFF && stack_id >= LTC6802_1_NUM_STACKS) {
        return LTC6802_1_ERROR_INVALID_STACK;
    }
    
    ltc_module.state = LTC6802_1_STATE_ADC_START;
    ltc_module.current_operation = LTC6802_1_OP_START_ADC_VOLTAGES;
    ltc_module.target_stack = stack_id;
    ltc_module.retry_count = 0;
    ltc_module.state_timestamp = SysTick_Get();
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_StartTempADC(uint8_t stack_id) {
    if (LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    if (stack_id != 0xFF && stack_id >= LTC6802_1_NUM_STACKS) {
        return LTC6802_1_ERROR_INVALID_STACK;
    }
    
    ltc_module.state = LTC6802_1_STATE_ADC_START;
    ltc_module.current_operation = LTC6802_1_OP_START_ADC_TEMPERATURES;
    ltc_module.target_stack = stack_id;
    ltc_module.retry_count = 0;
    ltc_module.state_timestamp = SysTick_Get();
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_ReadCellVoltages(uint8_t stack_id) {
    if (LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    if (stack_id != 0xFF && stack_id >= LTC6802_1_NUM_STACKS) {
        return LTC6802_1_ERROR_INVALID_STACK;
    }
    
    ltc_module.state = LTC6802_1_STATE_VOLTAGE_READ;
    ltc_module.current_operation = LTC6802_1_OP_READ_VOLTAGES;
    ltc_module.target_stack = stack_id;
    ltc_module.current_stack_index = (stack_id == 0xFF) ? 0 : stack_id;
    ltc_module.retry_count = 0;
    ltc_module.state_timestamp = SysTick_Get();
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_ReadTemperatures(uint8_t stack_id) {
    if (LTC6802_1_IsBusy()) {
        return LTC6802_1_ERROR_BUSY;
    }
    
    if (stack_id != 0xFF && stack_id >= LTC6802_1_NUM_STACKS) {
        return LTC6802_1_ERROR_INVALID_STACK;
    }
    
    ltc_module.state = LTC6802_1_STATE_TEMP_READ;
    ltc_module.current_operation = LTC6802_1_OP_READ_TEMPERATURES;
    ltc_module.target_stack = stack_id;
    ltc_module.current_stack_index = (stack_id == 0xFF) ? 0 : stack_id;
    ltc_module.retry_count = 0;
    ltc_module.state_timestamp = SysTick_Get();
    
    return LTC6802_1_ERROR_NONE;
}

float LTC6802_1_GetCellVoltage(uint8_t cell_id) {
    if (cell_id >= LTC6802_1_TOTAL_CELLS) {
        return 0.0f;
    }
    
    uint8_t stack_id = cell_id / LTC6802_1_CELLS_PER_STACK;
    uint8_t cell_in_stack = cell_id % LTC6802_1_CELLS_PER_STACK;
    
    // Extract 12-bit voltage value from voltage data
    uint8_t* stack_data = &ltc_module.voltage_data[stack_id * LTC6802_1_VOLTAGE_REG_SIZE];
    
    // LTC6802-1 packs voltage data differently than LTC6802-2
    // Each cell voltage is 12 bits, stored in 1.5 bytes
    uint16_t voltage_bits;
    if (cell_in_stack % 2 == 0) {
        // Even cell: bits are in byte N and lower 4 bits of byte N+1
        voltage_bits = stack_data[cell_in_stack * 3 / 2] | 
                      ((stack_data[cell_in_stack * 3 / 2 + 1] & 0x0F) << 8);
    } else {
        // Odd cell: bits are in upper 4 bits of byte N and byte N+1
        voltage_bits = ((stack_data[cell_in_stack * 3 / 2] & 0xF0) >> 4) |
                      (stack_data[cell_in_stack * 3 / 2 + 1] << 4);
    }
    
    return voltage_bits * LTC6802_1_VOLTAGE_SCALE_FACTOR;
}

float LTC6802_1_GetTemperatureVoltage(uint8_t temp_id) {
    if (temp_id >= LTC6802_1_TOTAL_TEMPS) {
        return 0.0f;
    }
    
    uint8_t stack_id = temp_id / LTC6802_1_TEMPS_PER_STACK;
    uint8_t temp_in_stack = temp_id % LTC6802_1_TEMPS_PER_STACK;
    
    // Extract temperature data (16-bit values)
    uint8_t* stack_data = &ltc_module.temp_data[stack_id * LTC6802_1_TEMP_REG_SIZE];
    uint16_t temp_bits = stack_data[temp_in_stack * 2] | 
                        (stack_data[temp_in_stack * 2 + 1] << 8);
    
    return temp_bits * LTC6802_1_VOLTAGE_SCALE_FACTOR;
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
}

LTC6802_1_Error_E LTC6802_1_SetCellBalancing(uint8_t cell_id, bool enable) {
    if (cell_id >= LTC6802_1_TOTAL_CELLS) {
        return LTC6802_1_ERROR_INVALID_STACK;
    }
    
    uint8_t stack_id = cell_id / LTC6802_1_CELLS_PER_STACK;
    uint8_t cell_in_stack = cell_id % LTC6802_1_CELLS_PER_STACK;
    
    if (enable) {
        ltc_module.config[stack_id].discharge_cells |= (1 << cell_in_stack);
    } else {
        ltc_module.config[stack_id].discharge_cells &= ~(1 << cell_in_stack);
    }
    
    return LTC6802_1_ERROR_NONE;
}

LTC6802_1_Error_E LTC6802_1_ClearAllCellBalancing(void) {
    for (uint8_t i = 0; i < LTC6802_1_NUM_STACKS; i++) {
        ltc_module.config[i].discharge_cells = 0;
    }
    return LTC6802_1_ERROR_NONE;
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
    
    ltc_module.total_transactions++;
    
    // Build SPI transaction buffer
    ltc_module.spi_tx_index = 0;
    
    // Add address byte if not broadcast
    if (stack_id != 0xFF) {
        ltc_module.spi_tx_buffer[ltc_module.spi_tx_index++] = LTC6802_1_ADDR_MASK | stack_id;
    }
    
    // Add command
    ltc_module.spi_tx_buffer[ltc_module.spi_tx_index++] = command;
    
    // Add data if provided
    if (tx_data && data_len > 0) {
        memcpy(&ltc_module.spi_tx_buffer[ltc_module.spi_tx_index], tx_data, data_len);
        ltc_module.spi_tx_index += data_len;
        
        // Add CRC for data
        uint8_t crc = crc8ccitt(tx_data, data_len);
        ltc_module.spi_tx_buffer[ltc_module.spi_tx_index++] = crc;
    }
    
    // Set up receive buffer if expecting response
    ltc_module.spi_rx_index = response_len;
    uint8_t* rx_buffer = expect_response ? ltc_module.spi_rx_buffer : NULL;
    
    // Start transaction
    ltc_module.state_timestamp = SysTick_Get();
    IO_SET_SPI_CS(LOW);
    
    // Use buffered SPI transaction
    uint8_t result = spi1StartBufferedTransaction(ltc_module.spi_tx_buffer, ltc_module.spi_tx_index, 
                                                 rx_buffer, response_len);
    
    if (result) {
        ltc_module.spi_transaction_active = true;
        return LTC6802_1_ERROR_NONE;
    } else {
        IO_SET_SPI_CS(HIGH);
        return LTC6802_1_ERROR_BUSY;
    }
}


static LTC6802_1_Error_E ValidateCRC(const uint8_t* data, uint8_t len, uint8_t received_crc) {
    uint8_t calculated_crc = crc8ccitt(data, len);
    return (calculated_crc == received_crc) ? LTC6802_1_ERROR_NONE : LTC6802_1_ERROR_CRC_FAIL;
}

static void SetError(uint8_t stack_id, LTC6802_1_Error_E error) {
    if (stack_id < LTC6802_1_NUM_STACKS) {
        ltc_module.last_error[stack_id] = error;
    }
    ltc_module.failed_transactions++;
}

static void CompleteOperation(LTC6802_1_Error_E error) {
    ltc_module.state = LTC6802_1_STATE_COMPLETE;
    
    if (ltc_module.completion_callback) {
        ltc_module.completion_callback(ltc_module.current_operation, error, ltc_module.target_stack);
    }
}

static bool IsTimeout(uint32_t start_time, uint32_t timeout_ms) {
    return (SysTick_Get() - start_time) >= timeout_ms;
}

static void UpdateConfigData(uint8_t stack_id) {
    if (stack_id >= LTC6802_1_NUM_STACKS) return;
    
    uint8_t* config_bytes = &ltc_module.config_data[stack_id * LTC6802_1_CONFIG_REG_SIZE];
    LTC6802_1_Config_S* config = &ltc_module.config[stack_id];
    
    // Clear configuration data
    memset(config_bytes, 0, LTC6802_1_CONFIG_REG_SIZE);
    
    // LTC6802-1 configuration register layout
    // Byte 0: ADC Mode [1:0], Temperature enable [2], Reserved [7:3]
    config_bytes[0] = (config->adc_mode & 0x03) | 
                     ((config->temp_enable & 0x01) << 2);
    
    // Bytes 1-2: Discharge cell control (12 bits)
    config_bytes[1] = config->discharge_cells & 0xFF;
    config_bytes[2] = (config->discharge_cells >> 8) & 0x0F;
    
    // Bytes 3-4: Under/Over voltage thresholds
    config_bytes[3] = config->undervoltage_threshold & 0xFF;
    config_bytes[4] = (config->undervoltage_threshold >> 8) & 0x0F;
    config_bytes[4] |= (config->overvoltage_threshold & 0x0F) << 4;
    config_bytes[5] = (config->overvoltage_threshold >> 4) & 0xFF;
}

static uint8_t GetStackAddress(uint8_t stack_id) {
    return stack_id; // Simple mapping for now
}