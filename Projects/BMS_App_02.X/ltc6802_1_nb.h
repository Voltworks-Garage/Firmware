/**
 * @file ltc6802_1_nb.h
 * @brief Non-blocking LTC6802-1 Battery Monitor Driver with Interrupt-Driven SPI
 * 
 * This module provides non-blocking, interrupt-driven communication with 
 * LTC6802-1 battery monitoring ICs. Uses state machine approach for
 * asynchronous operations to reduce CPU usage.
 * 
 * Key differences from LTC6802-2:
 * - LTC6802-1 has different register layout and command set
 * - Non-blocking SPI operations using interrupts
 * - State machine for managing async operations
 * - Improved error handling and retry logic
 * 
 * @author Generated for Voltworks Garage
 * @date 2025
 */

#ifndef LTC6802_1_NB_H
#define LTC6802_1_NB_H

#include <stdint.h>
#include <stdbool.h>

/******************************************************************************
 * Configuration Constants
 *******************************************************************************/
#define LTC6802_1_NUM_STACKS        2      // Number of LTC6802-1 devices
#define LTC6802_1_CELLS_PER_STACK   12     // Cells per LTC6802-1
#define LTC6802_1_TOTAL_CELLS       (LTC6802_1_NUM_STACKS * LTC6802_1_CELLS_PER_STACK)
#define LTC6802_1_TEMPS_PER_STACK   2      // Temperature sensors per stack
#define LTC6802_1_TOTAL_TEMPS       (LTC6802_1_NUM_STACKS * LTC6802_1_TEMPS_PER_STACK)

// Timing Constants
#define LTC6802_1_ADC_CONVERSION_TIME_MS    3   // Max ADC conversion time
#define LTC6802_1_MAX_RETRIES              3   // Max retry attempts
#define LTC6802_1_SPI_TIMEOUT_MS           10  // SPI operation timeout

// Voltage scaling for LTC6802-1 (1.5mV per LSB)
#define LTC6802_1_VOLTAGE_SCALE_FACTOR     0.0015f

/******************************************************************************
 * Type Definitions
 *******************************************************************************/

/**
 * @brief Operation states for non-blocking state machine
 */
typedef enum {
    LTC6802_1_STATE_IDLE = 0,
    LTC6802_1_STATE_CONFIG_WRITE,
    LTC6802_1_STATE_CONFIG_WRITE_WAIT,
    LTC6802_1_STATE_ADC_START,
    LTC6802_1_STATE_ADC_START_WAIT,
    LTC6802_1_STATE_ADC_POLL,
    LTC6802_1_STATE_ADC_POLL_WAIT,
    LTC6802_1_STATE_VOLTAGE_READ,
    LTC6802_1_STATE_VOLTAGE_READ_WAIT,
    LTC6802_1_STATE_TEMP_READ,
    LTC6802_1_STATE_TEMP_READ_WAIT,
    LTC6802_1_STATE_ERROR,
    LTC6802_1_STATE_COMPLETE
} LTC6802_1_State_E;

/**
 * @brief Operation types
 */
typedef enum {
    LTC6802_1_OP_NONE = 0,
    LTC6802_1_OP_READ_VOLTAGES,
    LTC6802_1_OP_READ_TEMPERATURES,
    LTC6802_1_OP_WRITE_CONFIG,
    LTC6802_1_OP_START_ADC_VOLTAGES,
    LTC6802_1_OP_START_ADC_TEMPERATURES
} LTC6802_1_Operation_E;

/**
 * @brief Error codes
 */
typedef enum {
    LTC6802_1_ERROR_NONE = 0,
    LTC6802_1_ERROR_SPI_TIMEOUT,
    LTC6802_1_ERROR_CRC_FAIL,
    LTC6802_1_ERROR_ADC_TIMEOUT,
    LTC6802_1_ERROR_INVALID_STACK,
    LTC6802_1_ERROR_BUSY,
    LTC6802_1_ERROR_MAX_RETRIES
} LTC6802_1_Error_E;

/**
 * @brief Configuration structure for LTC6802-1
 */
typedef struct {
    uint8_t discharge_cells;        // Cell discharge enable bits (bits 0-11)
    uint8_t forced_cells;          // Forced discharge cells (bits 0-11) 
    uint8_t adc_mode;              // ADC mode (00=fast, 01=normal, 10=slow)
    uint8_t temp_enable;           // Temperature measurement enable
    uint16_t overvoltage_threshold; // Overvoltage threshold (12-bit)
    uint16_t undervoltage_threshold; // Undervoltage threshold (12-bit)
} LTC6802_1_Config_S;

/**
 * @brief Status callback function type
 * @param operation The operation that completed
 * @param error Error code (LTC6802_1_ERROR_NONE if successful)
 * @param stack_id Stack that completed (0xFF for broadcast operations)
 */
typedef void (*LTC6802_1_Callback_F)(LTC6802_1_Operation_E operation, 
                                     LTC6802_1_Error_E error, 
                                     uint8_t stack_id);

/******************************************************************************
 * Public Function Declarations
 *******************************************************************************/

/**
 * @brief Initialize the LTC6802-1 module
 * @return Error code
 */
LTC6802_1_Error_E LTC6802_1_Init(void);

/**
 * @brief Register callback for operation completion
 * @param callback Function to call when operations complete
 */
void LTC6802_1_RegisterCallback(LTC6802_1_Callback_F callback);

/**
 * @brief Run the state machine (call from main loop or timer)
 * This function must be called regularly to process async operations
 */
void LTC6802_1_Run(void);

/**
 * @brief Check if module is busy with an operation
 * @return true if busy, false if idle
 */
bool LTC6802_1_IsBusy(void);

/**
 * @brief Get current state for debugging
 * @return Current state
 */
LTC6802_1_State_E LTC6802_1_GetState(void);

/******************************************************************************
 * Configuration Functions
 *******************************************************************************/

/**
 * @brief Set configuration for a specific stack (non-blocking)
 * @param stack_id Stack ID (0 to LTC6802_1_NUM_STACKS-1)
 * @param config Configuration structure
 * @return Error code
 */
LTC6802_1_Error_E LTC6802_1_SetConfig(uint8_t stack_id, const LTC6802_1_Config_S* config);

/**
 * @brief Write configuration to hardware (non-blocking)
 * @param stack_id Stack ID (0xFF for broadcast to all stacks)
 * @return Error code
 */
LTC6802_1_Error_E LTC6802_1_WriteConfig(uint8_t stack_id);

/******************************************************************************
 * ADC Control Functions
 *******************************************************************************/

/**
 * @brief Start cell voltage ADC conversion (non-blocking)
 * @param stack_id Stack ID (0xFF for broadcast to all stacks)
 * @return Error code
 */
LTC6802_1_Error_E LTC6802_1_StartCellVoltageADC(uint8_t stack_id);

/**
 * @brief Start temperature ADC conversion (non-blocking)
 * @param stack_id Stack ID (0xFF for broadcast to all stacks)
 * @return Error code
 */
LTC6802_1_Error_E LTC6802_1_StartTempADC(uint8_t stack_id);

/**
 * @brief Read cell voltages (non-blocking)
 * Data will be available via callback when complete
 * @param stack_id Stack ID (0xFF for all stacks)
 * @return Error code
 */
LTC6802_1_Error_E LTC6802_1_ReadCellVoltages(uint8_t stack_id);

/**
 * @brief Read temperatures (non-blocking)  
 * Data will be available via callback when complete
 * @param stack_id Stack ID (0xFF for all stacks)
 * @return Error code
 */
LTC6802_1_Error_E LTC6802_1_ReadTemperatures(uint8_t stack_id);

/******************************************************************************
 * Data Access Functions (Blocking - for immediate data access)
 *******************************************************************************/

/**
 * @brief Get cell voltage from last read operation
 * @param cell_id Cell ID (0 to LTC6802_1_TOTAL_CELLS-1)
 * @return Voltage in volts, or 0.0 if invalid cell_id
 */
float LTC6802_1_GetCellVoltage(uint8_t cell_id);

/**
 * @brief Get temperature from last read operation
 * @param temp_id Temperature sensor ID (0 to LTC6802_1_TOTAL_TEMPS-1)
 * @return Voltage in volts (needs external conversion), or 0.0 if invalid temp_id
 */
float LTC6802_1_GetTemperatureVoltage(uint8_t temp_id);

/**
 * @brief Get last error for a specific stack
 * @param stack_id Stack ID (0 to LTC6802_1_NUM_STACKS-1)
 * @return Last error code
 */
LTC6802_1_Error_E LTC6802_1_GetLastError(uint8_t stack_id);

/**
 * @brief Clear error state for a specific stack
 * @param stack_id Stack ID (0 to LTC6802_1_NUM_STACKS-1)
 */
void LTC6802_1_ClearError(uint8_t stack_id);

/******************************************************************************
 * Cell Balancing Functions
 *******************************************************************************/

/**
 * @brief Enable cell balancing for specific cell
 * @param cell_id Cell ID (0 to LTC6802_1_TOTAL_CELLS-1) 
 * @param enable true to enable balancing, false to disable
 * @return Error code
 */
LTC6802_1_Error_E LTC6802_1_SetCellBalancing(uint8_t cell_id, bool enable);

/**
 * @brief Disable all cell balancing
 * @return Error code
 */
LTC6802_1_Error_E LTC6802_1_ClearAllCellBalancing(void);

/******************************************************************************
 * Diagnostic Functions
 *******************************************************************************/

/**
 * @brief Get communication statistics
 * @param total_transactions Pointer to store total transaction count
 * @param failed_transactions Pointer to store failed transaction count
 * @param retry_count Pointer to store total retry count
 */
void LTC6802_1_GetStats(uint32_t* total_transactions, 
                       uint32_t* failed_transactions, 
                       uint32_t* retry_count);

/**
 * @brief Reset communication statistics
 */
void LTC6802_1_ResetStats(void);

#endif // LTC6802_1_NB_H