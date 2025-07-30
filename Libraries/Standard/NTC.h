/******************************************************************************
 * NTC Thermistor Library
 * 
 * Description: Simple lookup table based NTC temperature conversion
 *              for NTC_TYPE_B57355V5104F360
 * 
 * Author: Generated with Claude Code
 * Date: 2025-07-29
 *******************************************************************************/

#ifndef NTC_H
#define NTC_H

#include <stdint.h>

/******************************************************************************
 * Macro Definition
 *******************************************************************************/

 // Common NTC thermistor types
typedef enum {
    NTC_TYPE_B57355V5104F360,   // EPCOS/TDK 100kΩ, B25/85=4260K
    NTC_TYPE_CUSTOM             // User-defined parameters
} NTC_Type_E;

/**
 * @brief Declare an NTC instance
 * @param name Instance name
 * @param pullup_resistance Pull-up resistor value in Ohms
 * @param vcc_voltage Supply voltage in Volts
 * 
 * Usage: 
 * NEW_NTC(temp_sensor, 100000.0f, 3.3f, NTC_TYPE_B57355V5104F360);
 * float temp = NTC_GetTemperature(temp_sensor, get_sensor_voltage());
 */
#define NEW_NTC(name, pullup_resistance, vcc_voltage, type) \
    static float name##_GetTemperature(float voltage) { \
        uint32_t resistance = (pullup_resistance * voltage) / (vcc_voltage - voltage); \
        return NTC_ResistanceToTemperature(resistance, type); \
    } \

/**
 * @brief Get temperature from NTC instance
 * @param name NTC instance name (must be previously declared)
 * @param value Voltage Reading of the NTC
 * @return Temperature in Celsius
 */
#define NTC_GetTemperature(name,value) name##_GetTemperature(value)



/******************************************************************************
 * Function Declaration
 *******************************************************************************/

/**
 * @brief Convert resistance to temperature for NTC
 * @param resistance_ohms NTC resistance in Ohms
 * @param ntc_type a NTC_Type_E
 * @return Temperature in Celsius
 */
float NTC_ResistanceToTemperature(uint32_t resistance_ohms, NTC_Type_E ntc_type);

#endif // NTC_H