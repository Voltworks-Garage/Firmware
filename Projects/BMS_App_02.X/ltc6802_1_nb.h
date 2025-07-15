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
 * @brief ADC conversion modes
 */
typedef enum {
    LTC6802_1_ADC_MODE_FAST = 0,    // Fast conversion (27kHz)
    LTC6802_1_ADC_MODE_NORMAL = 1,  // Normal conversion (7kHz)
    LTC6802_1_ADC_MODE_SLOW = 2     // Slow conversion (422Hz)
} LTC6802_1_ADC_Mode_E;

/**
 * @brief Comprehensive configuration structure for LTC6802-1
 * Covers all configuration register bitfields
 */
typedef struct {
    // Cell discharge control (12 bits per stack)
    uint16_t discharge_cells;           // Cells to discharge (bit 0 = cell 1, etc.)
    uint16_t forced_discharge_cells;    // Forced discharge override
    
    // ADC configuration
    LTC6802_1_ADC_Mode_E adc_mode;     // ADC conversion speed
    bool temp_enable;                   // Enable temperature measurement
    bool compare_enable;                // Enable voltage comparison
    
    // Voltage thresholds (12-bit values, 1.5mV per LSB)
    uint16_t overvoltage_threshold;     // OV threshold (0-4095 = 0-6.14V)
    uint16_t undervoltage_threshold;    // UV threshold (0-4095 = 0-6.14V)
    
    // Timeout configuration  
    uint8_t wdt_timeout;                // Watchdog timeout setting (0-15)
    
    // GPIO configuration (2 pins per LTC6802-1, per stack)
    uint8_t gpio_pulldown[LTC6802_1_NUM_STACKS];  // GPIO pulldown enables (bits 0-1)
    uint8_t gpio_direction[LTC6802_1_NUM_STACKS]; // GPIO direction control (bits 0-1)
    
    // Advanced settings
    bool snap_st;                       // Snapshot mode
    bool refon;                         // Reference always on
    bool swtrd;                         // Switch redundant measurement
    bool adcopt;                        // ADC mode option
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
 * @return ERROR_BUSY if not idle, ERROR_NONE if started successfully
 */
LTC6802_1_Error_E LTC6802_1_SetADCMode(LTC6802_1_ADC_Mode_E mode);

/**
 * @brief Set voltage thresholds
 * @param overvoltage_mv Overvoltage threshold in millivolts (0-6142mV)
 * @param undervoltage_mv Undervoltage threshold in millivolts (0-6142mV)
 * @return ERROR_BUSY if not idle, ERROR_NONE if started successfully
 */
LTC6802_1_Error_E LTC6802_1_SetVoltageThresholds(uint16_t overvoltage_mv, uint16_t undervoltage_mv);

/**
 * @brief Enable/disable temperature measurement
 * @param enable True to enable, false to disable
 * @return ERROR_BUSY if not idle, ERROR_NONE if started successfully
 */
LTC6802_1_Error_E LTC6802_1_EnableTemperature(bool enable);

/**
 * @brief Enable/disable voltage comparison
 * @param enable True to enable, false to disable  
 * @return ERROR_BUSY if not idle, ERROR_NONE if started successfully
 */
LTC6802_1_Error_E LTC6802_1_EnableVoltageComparison(bool enable);

/**
 * @brief Set individual cell balancing (discharge) state
 * @param cell_id Cell ID (0-11 for first stack, 12-23 for second stack, etc.)
 * @param enable True to enable balancing, false to disable
 * @return ERROR_BUSY if not idle, ERROR_NONE if started successfully
 */
LTC6802_1_Error_E LTC6802_1_SetCellBalancingState(uint8_t cell_id, bool enable);

/**
 * @brief Reset configuration to safe defaults
 * @return ERROR_BUSY if not idle, ERROR_NONE if started successfully
 */
LTC6802_1_Error_E LTC6802_1_ResetConfigToDefaults(void);

/**
 * @brief Set GPIO pin direction (input/output) for stack
 * @param stack_id Stack ID (0 to LTC6802_1_NUM_STACKS-1)
 * @param gpio_mask Bitmask for GPIO pins (bit 0 = GPIO1, bit 1 = GPIO2)
 * @param output_mask Bitmask where 1 = output, 0 = input
 * @return ERROR_BUSY if not idle, ERROR_NONE if started successfully
 */
LTC6802_1_Error_E LTC6802_1_SetGPIODirection(uint8_t stack_id, uint8_t gpio_mask, uint8_t output_mask);

/**
 * @brief Set GPIO pulldown enable/disable for stack
 * @param stack_id Stack ID (0 to LTC6802_1_NUM_STACKS-1)
 * @param gpio_mask Bitmask for GPIO pins to configure (bit 0 = GPIO1, bit 1 = GPIO2)
 * @param pulldown_mask Bitmask where 1 = enable pulldown, 0 = disable
 * @return ERROR_BUSY if not idle, ERROR_NONE if started successfully  
 */
LTC6802_1_Error_E LTC6802_1_SetGPIOPulldown(uint8_t stack_id, uint8_t gpio_mask, uint8_t pulldown_mask);

/**
 * @brief Configure a single GPIO pin on a specific stack
 * @param stack_id Stack ID (0 to LTC6802_1_NUM_STACKS-1)
 * @param gpio_pin GPIO pin number (0 = GPIO1, 1 = GPIO2)
 * @param output True for output, false for input
 * @param pulldown_enable True to enable pulldown (input mode only)
 * @return ERROR_BUSY if not idle, ERROR_NONE if started successfully
 */
LTC6802_1_Error_E LTC6802_1_ConfigureGPIO(uint8_t stack_id, uint8_t gpio_pin, bool output, bool pulldown_enable);

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