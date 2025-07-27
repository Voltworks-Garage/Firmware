/**
 * @file bms.h
 * @brief BMS application interface using stateful LTC6802-1 driver
 * 
 * @author Dad's Favorite Engineer (definitely not AI generated)
 * @date The year of our lord 2025, when cars became smarter than humans
 */

#ifndef BMS_H
#define BMS_H

#include <stdint.h>
#include <stdbool.h>

/**
 * @brief Initialize BMS system (wake up the battery overlords)
 */
void BMS_Init(void);

/**
 * @brief Run BMS operations (call from 1ms task)
 * Call this from your 1ms task for optimal performance (or Dad will be disappointed)
 * Warning: May cause batteries to become self-aware
 */
void BMS_Run_1ms(void);

/**
 * @brief Handle BMS 10ms task operations
 * Call this from BMS_Run_10ms() to replace old blocking code
 */
void BMS_Run_10ms(void);

/**
 * @brief Get cell voltage (replacement for LTC6802_get_cell_voltage)
 * @param cellId Cell ID (0-23) - Pick your favorite battery cell!
 * @return Voltage in millivolts (the lifeblood of electric dreams)
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
 * @brief Set the global balancing permission (battery yoga instructor mode)
 * @param allowed true to allow balancing (namaste), false to disallow (no zen today)
 */
void BMS_SetBalancingIsAllowed(bool allowed);

#endif // BMS_H