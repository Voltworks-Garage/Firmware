/**
 * @file ltc6802_1_example.h
 * @brief Example usage header for the non-blocking LTC6802-1 driver
 * 
 * @author Generated for Voltworks Garage
 * @date 2025
 */

#ifndef LTC6802_1_EXAMPLE_H
#define LTC6802_1_EXAMPLE_H

#include <stdint.h>
#include <stdbool.h>

/**
 * @brief Initialize the LTC6802-1 example module
 * Call this once during system initialization
 */
void LTC6802_Example_Init(void);

/**
 * @brief Run the example state machine
 * Call this regularly from your main loop or task scheduler
 */
void LTC6802_Example_Run(void);

/**
 * @brief Check if fresh measurement data is available
 * @return true if data is ready, false otherwise
 */
bool LTC6802_Example_IsReady(void);

/**
 * @brief Get cell voltage from last measurement
 * @param cell_id Cell ID (0 to 23)
 * @return Voltage in volts
 */
float LTC6802_Example_GetCellVoltage(uint8_t cell_id);

/**
 * @brief Get temperature from last measurement
 * @param temp_id Temperature sensor ID (0 to 3)
 * @return Temperature voltage in volts
 */
float LTC6802_Example_GetTemperature(uint8_t temp_id);

/**
 * @brief Enable/disable cell balancing for a specific cell
 * @param cell_id Cell ID (0 to 23)
 * @param enable true to enable balancing, false to disable
 */
void LTC6802_Example_EnableCellBalancing(uint8_t cell_id, bool enable);

/**
 * @brief Print diagnostic information
 */
void LTC6802_Example_PrintDiagnostics(void);

#endif // LTC6802_1_EXAMPLE_H