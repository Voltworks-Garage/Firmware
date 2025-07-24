/**
 * @file bms.h
 * @brief BMS application interface using stateful LTC6802-1 driver
 * 
 * @author Generated for Voltworks Garage
 * @date 2025
 */

#ifndef BMS_H
#define BMS_H

#include <stdint.h>
#include <stdbool.h>

/**
 * @brief Initialize BMS system
 */
void BMS_Init(void);

/**
 * @brief Run BMS operations (call from 1ms task)
 * Call this from your 1ms task for optimal performance
 */
void BMS_Run_1ms(void);

/**
 * @brief Handle BMS 10ms task operations
 * Call this from BMS_Run_10ms() to replace old blocking code
 */
void BMS_Run_10ms(void);

/**
 * @brief Get cell voltage (replacement for LTC6802_get_cell_voltage)
 * @param cellId Cell ID (0-23)
 * @return Voltage in millivolts
 */
uint16_t BMS_GetCellVoltage(uint8_t cellId);

/**
 * @brief Get temperature voltage (replacement for LTC6802_get_temp_voltage)
 * @param tempId Temperature ID (0-3)  
 * @return Temperature voltage in volts
 */
float BMS_GetTemperatureVoltage(uint8_t tempId);

/**
 * @brief Disable all cell balancing
 */
void BMS_ClearAllCellBalancing(void);

/**
 * @brief Set the global balancing permission
 * @param allowed true to allow balancing, false to disallow
 */
void BMS_SetBalancingIsAllowed(bool allowed);

#endif // BMS_H