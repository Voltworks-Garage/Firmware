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

// Special stack ID values
#define LTC6802_1_ALL_STACKS        0xFF   // Apply operation to all stacks

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

// Helper macros for auto-generating stack enum entries
// We use a simpler approach that's more compatible with different compilers

/**
 * @brief Auto-generated stack IDs based on LTC6802_1_NUM_STACKS
 * This enum provides type safety and readability for stack operations
 * 
 * @note Stack enum values are auto-generated using macros based on LTC6802_1_NUM_STACKS.
 *       Currently configured for 2 stacks, so LTC6802_1_STACK_0 and LTC6802_1_STACK_1 are available.
 *       To add support for more stacks, just increase LTC6802_1_NUM_STACKS and add corresponding
 *       enum entries below.
 * 
 * Usage examples:
 * @code
 *   // Set GPIO1 high on stack 0 only
 *   LTC6802_1_SetGPIO1(LTC6802_1_STACK_0, true, true);
 * 
 *   // Set GPIO2 low on all stacks
 *   LTC6802_1_SetGPIO2(LTC6802_1_ALL_STACKS, false, true);
 * 
 *   // Enable monitoring on specific cells for stack 1
 *   LTC6802_1_SetCellMonitoring(LTC6802_1_STACK_1, 0x0FFF, false);
 * 
 *   // Check if stack count is valid at compile time
 *   if (my_stack_id < LTC6802_1_STACK_COUNT) { ... }
 * @endcode
 */
typedef enum {
    // Auto-generated stack entries based on LTC6802_1_NUM_STACKS
#if LTC6802_1_NUM_STACKS > 0
    LTC6802_1_STACK_0 = 0,
#endif
#if LTC6802_1_NUM_STACKS > 1
    LTC6802_1_STACK_1 = 1,
#endif
#if LTC6802_1_NUM_STACKS > 2
    LTC6802_1_STACK_2 = 2,
#endif
#if LTC6802_1_NUM_STACKS > 3
    LTC6802_1_STACK_3 = 3,
#endif
#if LTC6802_1_NUM_STACKS > 4
    LTC6802_1_STACK_4 = 4,
#endif
#if LTC6802_1_NUM_STACKS > 5
    LTC6802_1_STACK_5 = 5,
#endif
#if LTC6802_1_NUM_STACKS > 6
    LTC6802_1_STACK_6 = 6,
#endif
#if LTC6802_1_NUM_STACKS > 7
    LTC6802_1_STACK_7 = 7,
#endif
    // Add more stacks as needed - automatically scales with LTC6802_1_NUM_STACKS
    LTC6802_1_STACK_COUNT = LTC6802_1_NUM_STACKS
} LTC6802_1_Stack_E;

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
 * @brief ADC conversion modes
 */
typedef enum {
    LTC6802_1_ADC_MODE_FAST = 0,    // Fast conversion (27kHz)
    LTC6802_1_ADC_MODE_NORMAL = 1,  // Normal conversion (7kHz)
    LTC6802_1_ADC_MODE_SLOW = 2     // Slow conversion (422Hz)
} LTC6802_1_ADC_Mode_E;

/**
 * @brief LTC6802-1 configuration structure matching actual hardware registers
 * Based on CFGR0-CFGR5 register layout from datasheet
 * 
 * Structure separates global settings (applied to all stacks) from 
 * per-stack settings (unique to each LTC6802-1 device)
 */
typedef struct {
    // === PER-STACK SETTINGS (unique to each LTC6802-1) ===
    
    // Cell discharge control (DCC bits) - 12 cells per LTC6802-1
    uint16_t discharge_cells[LTC6802_1_NUM_STACKS];  // Cells to discharge per stack (bit 0 = cell 1, etc.)
    
    // Cell monitoring enables (MC bits) - 12 cells per LTC6802-1  
    uint16_t monitor_cells[LTC6802_1_NUM_STACKS];    // Cells to monitor per stack (bit 0 = cell 1, etc.)
    
    // GPIO pin states (per stack)
    bool gpio1_state[LTC6802_1_NUM_STACKS];          // GPIO1 pin state/direction per stack
    bool gpio2_state[LTC6802_1_NUM_STACKS];          // GPIO2 pin state/direction per stack
    
    // === GLOBAL SETTINGS (same for all stacks) ===
    
    // Voltage thresholds (8-bit values each) - should be consistent across all cells
    uint8_t overvoltage_threshold;      // VOV[7:0] - Over-voltage threshold (global)
    uint8_t undervoltage_threshold;     // VUV[7:0] - Under-voltage threshold (global)
    
    // CFGR0 control bits (global settings)
    bool wdt_enable;                    // WDT - Watchdog timer enable (global)
    bool lvlpl_enable;                  // LVLPL - Level polling enable (global)
    bool cell10_enable;                 // CELL10 - 10th cell enable vs 12-cell mode (global)
    uint8_t cdc_mode;                   // CDC[2:0] - Cell discharge current/ADC mode (global)
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
 * @brief Write configuration to hardware
 * @return ERROR_BUSY if not idle, ERROR_NONE if started successfully
 */
LTC6802_1_Error_E LTC6802_1_WriteConfig(void);

/******************************************************************************
 * Configuration Helper Functions
 *******************************************************************************/

/**
 * @brief Get current configuration (copy of internal state)
 * @param config Pointer to structure to fill with current configuration
 */
void LTC6802_1_GetConfig(LTC6802_1_Config_S* config);

/**
 * @brief Set ADC conversion mode
 * @param mode ADC conversion mode
 * @param send_immediately True to send config immediately, false to update internal config only
 * @return ERROR_BUSY if not idle, ERROR_NONE if started successfully
 */
LTC6802_1_Error_E LTC6802_1_SetADCMode(LTC6802_1_ADC_Mode_E mode, bool send_immediately);

/**
 * @brief Set voltage thresholds
 * @param overvoltage_mv Overvoltage threshold in millivolts (0-6142mV)
 * @param undervoltage_mv Undervoltage threshold in millivolts (0-6142mV)
 * @param send_immediately True to send config immediately, false to update internal config only
 * @return ERROR_BUSY if not idle, ERROR_NONE if started successfully
 */
LTC6802_1_Error_E LTC6802_1_SetVoltageThresholds(uint16_t overvoltage_mv, uint16_t undervoltage_mv, bool send_immediately);

/**
 * @brief Enable/disable temperature measurement
 * @param enable True to enable, false to disable
 * @param send_immediately True to send config immediately, false to update internal config only
 * @return ERROR_BUSY if not idle, ERROR_NONE if started successfully
 */
LTC6802_1_Error_E LTC6802_1_EnableTemperature(bool enable, bool send_immediately);

/**
 * @brief Enable/disable voltage comparison for specific stack(s)
 * @param stack_id Stack ID (use LTC6802_1_Stack_E enum), or LTC6802_1_ALL_STACKS for all stacks
 * @param enable True to enable, false to disable
 * @param send_immediately True to send config immediately, false to update internal config only
 * @return ERROR_BUSY if not idle, ERROR_INVALID_STACK if stack_id invalid, ERROR_NONE if started successfully
 */
LTC6802_1_Error_E LTC6802_1_EnableVoltageComparison(uint8_t stack_id, bool enable, bool send_immediately);


/**
 * @brief Reset configuration to safe defaults
 * @param send_immediately True to send config immediately, false to update internal config only
 * @return ERROR_BUSY if not idle, ERROR_NONE if started successfully
 */
LTC6802_1_Error_E LTC6802_1_ResetConfigToDefaults(bool send_immediately);

/**
 * @brief Set GPIO1 pin state for a specific stack
 * @param stack_id Stack ID (use LTC6802_1_Stack_E enum), or LTC6802_1_ALL_STACKS for all stacks
 * @param state True for high/output, false for low/input
 * @param send_immediately True to send config immediately, false to update internal config only
 * @return ERROR_BUSY if not idle, ERROR_INVALID_STACK if stack_id invalid, ERROR_NONE if started successfully
 */
LTC6802_1_Error_E LTC6802_1_SetGPIO1(uint8_t stack_id, bool state, bool send_immediately);

/**
 * @brief Set GPIO2 pin state for a specific stack
 * @param stack_id Stack ID (use LTC6802_1_Stack_E enum), or LTC6802_1_ALL_STACKS for all stacks
 * @param state True for high/output, false for low/input
 * @param send_immediately True to send config immediately, false to update internal config only
 * @return ERROR_BUSY if not idle, ERROR_INVALID_STACK if stack_id invalid, ERROR_NONE if started successfully
 */
LTC6802_1_Error_E LTC6802_1_SetGPIO2(uint8_t stack_id, bool state, bool send_immediately);

/**
 * @brief Set cell monitoring enable mask for a specific stack
 * @param stack_id Stack ID (use LTC6802_1_Stack_E enum), or LTC6802_1_ALL_STACKS for all stacks
 * @param monitor_mask Bitmask of cells to monitor (bit 0 = cell 1, etc.)
 * @param send_immediately True to send config immediately, false to update internal config only
 * @return ERROR_BUSY if not idle, ERROR_INVALID_STACK if stack_id invalid, ERROR_NONE if started successfully
 */
LTC6802_1_Error_E LTC6802_1_SetCellMonitoring(uint8_t stack_id, uint16_t monitor_mask, bool send_immediately);

/**
 * @brief Set voltage thresholds (8-bit values)
 * @param overvoltage_threshold 8-bit over-voltage threshold
 * @param undervoltage_threshold 8-bit under-voltage threshold
 * @param send_immediately True to send config immediately, false to update internal config only
 * @return ERROR_BUSY if not idle, ERROR_NONE if started successfully
 */
LTC6802_1_Error_E LTC6802_1_SetVoltageThresholds8(uint8_t overvoltage_threshold, uint8_t undervoltage_threshold, bool send_immediately);

/**
 * @brief Send current configuration to hardware
 * Use this after making multiple config changes with send_immediately=false
 * @return ERROR_BUSY if not idle, ERROR_NONE if started successfully
 */
LTC6802_1_Error_E LTC6802_1_SendConfig(void);

/**
 * @brief Set cell balancing configuration and optionally write to hardware
 * @param cell_id Cell ID (0-23 for total cells across all stacks)
 * @param enable True to enable balancing, false to disable
 * @param send_immediately True to send config immediately, false to update internal config only
 * @return ERROR_BUSY if not idle, ERROR_NONE if started successfully
 */
LTC6802_1_Error_E LTC6802_1_SetCellBalancing(uint8_t cell_id, bool enable, bool send_immediately);

/**
 * @brief Clear all cell balancing and write to hardware
 * @return ERROR_BUSY if not idle, ERROR_NONE if started successfully
 */
LTC6802_1_Error_E LTC6802_1_ClearAllCellBalancing(void);

/**
 * @brief Example: Batch configure multiple settings efficiently
 * Shows how to use send_immediately=false for multiple changes
 * @return ERROR_BUSY if not idle, ERROR_NONE if started successfully
 */
LTC6802_1_Error_E LTC6802_1_BatchConfigExample(void);

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
 * @param stack_id Stack ID (use LTC6802_1_Stack_E enum)
 * @return Last error code
 */
LTC6802_1_Error_E LTC6802_1_GetLastError(uint8_t stack_id);

/**
 * @brief Clear error state for a specific stack
 * @param stack_id Stack ID (use LTC6802_1_Stack_E enum)
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