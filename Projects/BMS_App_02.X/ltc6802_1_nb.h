/**
 * @file ltc6802_1_nb.h
 * @brief Non-blocking LTC6802-1 Battery Monitor Driver with Stateful API
 * 
 * This module provides non-blocking, interrupt-driven communication with 
 * LTC6802-1 battery monitoring ICs using a stateful request/response API.
 * 
 * Key features:
 * - Pure stateful design (state IS the operation)
 * - Simple start/read pattern with automatic busy rejection
 * - Built-in data staleness detection
 * - No callbacks - direct function calls in 1ms loop
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
#define LTC6802_1_DATA_STALE_TIME_MS       1000 // Data considered stale after 1 second

// Voltage scaling for LTC6802-1 (1.5mV per LSB)
#define LTC6802_1_VOLTAGE_SCALE_FACTOR     0.0015f

/******************************************************************************
 * Type Definitions
 *******************************************************************************/

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

/******************************************************************************
 * Public Function Declarations
 *******************************************************************************/

/**
 * @brief Initialize the LTC6802-1 module
 * @return Error code
 */
LTC6802_1_Error_E LTC6802_1_Init(void);

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

/******************************************************************************
 * Stateful API Functions
 *******************************************************************************/

/**
 * @brief Start cell voltage ADC conversion and read sequence
 * @return ERROR_BUSY if not idle, ERROR_NONE if started successfully
 */
LTC6802_1_Error_E LTC6802_1_StartCellVoltageADC(void);

/**
 * @brief Start temperature ADC conversion and read sequence
 * @return ERROR_BUSY if not idle, ERROR_NONE if started successfully
 */
LTC6802_1_Error_E LTC6802_1_StartTemperatureADC(void);

/**
 * @brief Set and write configuration to hardware
 * @param config Configuration structure (applied to all stacks)
 * @return ERROR_BUSY if not idle, ERROR_NONE if started successfully
 */
LTC6802_1_Error_E LTC6802_1_WriteConfig(const LTC6802_1_Config_S* config);

/**
 * @brief Set cell balancing configuration and write to hardware
 * @param cell_mask Bitmask of cells to enable balancing (bit 0 = cell 0, etc.)
 * @return ERROR_BUSY if not idle, ERROR_NONE if started successfully
 */
LTC6802_1_Error_E LTC6802_1_SetCellBalancing(uint32_t cell_mask);

/**
 * @brief Clear all cell balancing and write to hardware
 * @return ERROR_BUSY if not idle, ERROR_NONE if started successfully
 */
LTC6802_1_Error_E LTC6802_1_ClearAllCellBalancing(void);

/******************************************************************************
 * Data Access Functions
 *******************************************************************************/

/**
 * @brief Get cell voltage from last successful read operation
 * @param cell_id Cell ID (0 to LTC6802_1_TOTAL_CELLS-1)
 * @return Voltage in volts, or -1.0 if invalid cell_id or data stale
 */
float LTC6802_1_GetCellVoltage(uint8_t cell_id);

/**
 * @brief Get temperature from last successful read operation
 * @param temp_id Temperature sensor ID (0 to LTC6802_1_TOTAL_TEMPS-1)
 * @return Voltage in volts (needs external conversion), or -1.0 if invalid temp_id or data stale
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