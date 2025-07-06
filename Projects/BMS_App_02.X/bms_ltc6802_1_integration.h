/**
 * @file bms_ltc6802_1_integration.h
 * @brief Integration header for LTC6802-1 in BMS application
 * 
 * @author Generated for Voltworks Garage
 * @date 2025
 */

#ifndef BMS_LTC6802_1_INTEGRATION_H
#define BMS_LTC6802_1_INTEGRATION_H

#include <stdint.h>
#include <stdbool.h>

/**
 * @brief Initialize LTC6802-1 for BMS use
 * Call this from BMS_Init()
 */
void BMS_LTC6802_Init(void);

/**
 * @brief Run LTC6802-1 operations (call from 1ms task)
 * Call this from your 1ms task for optimal performance
 */
void BMS_LTC6802_Run_1ms(void);

/**
 * @brief Handle LTC6802-1 in BMS 10ms task
 * Call this from BMS_Run_10ms() to replace old blocking code
 */
void BMS_LTC6802_Run_10ms(void);

/**
 * @brief Check if fresh LTC6802-1 data is available
 * @return true if new data is ready
 */
bool BMS_LTC6802_IsDataReady(void);

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
 */
void BMS_SetCellBalancing(uint8_t cell_id, bool enable);

/**
 * @brief Disable all cell balancing
 */
void BMS_ClearAllCellBalancing(void);

#endif // BMS_LTC6802_1_INTEGRATION_H