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
 * @brief Check if fresh BMS data is available
 * @return true if new data is ready
 */
bool BMS_IsDataReady(void);

/**
 * @brief Get cell voltage (replacement for LTC6802_get_cell_voltage)
 * @param cell_id Cell ID (0-23)
 * @return Voltage in volts
 */
float BMS_GetCellVoltage(uint8_t cell_id);

/**
 * @brief Get temperature voltage (replacement for LTC6802_get_temp_voltage)
 * @param temp_id Temperature ID (0-3)  
 * @return Temperature voltage in volts
 */
float BMS_GetTemperatureVoltage(uint8_t temp_id);

/**
 * @brief Enable cell balancing (replacement for LTC6802_set_cell_discharge)
 * @param cell_id Cell ID (0-23)
 * @param enable true to enable, false to disable
 * @param send_immediately true to send config immediately, false to update internal config only
 */
void BMS_SetCellBalancing(uint8_t cell_id, bool enable, bool send_immediately);

/**
 * @brief Disable all cell balancing
 */
void BMS_ClearAllCellBalancing(void);

#endif // BMS_H