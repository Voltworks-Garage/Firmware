/******************************************************************************
 * NTC Thermistor Library
 * 
 * Description: Library for converting voltage readings to temperature using
 *              NTC thermistors with voltage divider circuits.
 *              Supports multiple NTC instances using macros.
 * 
 * Author: Generated with Claude Code
 * Date: 2025-07-19
 *******************************************************************************/

#ifndef NTC_H
#define NTC_H

#include <stdint.h>
#include <stdbool.h>

/******************************************************************************
 * Constants and Definitions
 *******************************************************************************/

// Error codes for NTC conversions
#define NTC_ERROR_INVALID_VOLTAGE   -999.0f
#define NTC_ERROR_INVALID_PARAMS    -998.0f

// Common NTC thermistor types
typedef enum {
    NTC_TYPE_B57355V5104F360,   // EPCOS/TDK 100kΩ, B25/85=4350K
    NTC_TYPE_CUSTOM             // User-defined parameters
} NTC_Type_E;

// NTC thermistor configuration structure
typedef struct {
    float r25;                  // Resistance at 25°C (Ohms)
    float beta;                 // Beta coefficient (K)
    float r_pullup;             // Pull-up resistor value (Ohms)
    float temp_min;             // Minimum valid temperature (°C)
    float temp_max;             // Maximum valid temperature (°C)
} NTC_Config_S;

/******************************************************************************
 * Macro Definitions for Multiple NTC Instances
 *******************************************************************************/

/**
 * @brief Create and initialize an NTC instance with predefined type
 * @param name Variable name for the NTC instance
 * @param type Predefined NTC thermistor type (NTC_TYPE_B57355V5104F360, etc.)
 * @param pullup Pull-up resistor value in Ohms
 * 
 * Usage: NTC_INIT(my_ntc, NTC_TYPE_B57355V5104F360, 100000.0f);
 */
#define NTC_INIT(name, type, pullup) \
    NTC_Config_S name = NTC_GetPredefinedConfig(type, pullup)

/**
 * @brief Create and initialize a custom NTC instance
 * @param name Variable name for the NTC instance
 * @param r25_val Resistance at 25°C (Ohms)
 * @param beta_val Beta coefficient (K)
 * @param pullup_val Pull-up resistor value (Ohms)
 * @param temp_min_val Minimum valid temperature (°C)
 * @param temp_max_val Maximum valid temperature (°C)
 * 
 * Usage: NTC_INIT_CUSTOM(my_ntc, 10000.0f, 3950.0f, 10000.0f, -40.0f, 85.0f);
 */
#define NTC_INIT_CUSTOM(name, r25_val, beta_val, pullup_val, temp_min_val, temp_max_val) \
    NTC_Config_S name = { \
        .r25 = r25_val, \
        .beta = beta_val, \
        .r_pullup = pullup_val, \
        .temp_min = temp_min_val, \
        .temp_max = temp_max_val \
    }

/******************************************************************************
 * Public Function Declarations
 *******************************************************************************/

/**
 * @brief Get predefined NTC configuration
 * @param type Predefined NTC thermistor type
 * @param r_pullup Pull-up resistor value in Ohms
 * @return NTC configuration structure
 */
NTC_Config_S NTC_GetPredefinedConfig(NTC_Type_E type, float r_pullup);

/**
 * @brief Convert voltage reading to temperature
 * @param ntc Pointer to NTC configuration structure
 * @param voltage_measured Measured voltage across NTC thermistor (V)
 * @param vcc_supply Supply voltage for voltage divider (V)
 * @return Temperature in Celsius, or negative error code if invalid
 */
float NTC_VoltageToTemperature(const NTC_Config_S* ntc, float voltage_measured, float vcc_supply);

/**
 * @brief Convert temperature to expected voltage reading
 * @param ntc Pointer to NTC configuration structure
 * @param temperature_celsius Temperature in Celsius
 * @param vcc_supply Supply voltage for voltage divider (V)
 * @return Expected voltage across NTC thermistor (V)
 */
float NTC_TemperatureToVoltage(const NTC_Config_S* ntc, float temperature_celsius, float vcc_supply);

/**
 * @brief Convert voltage to NTC resistance
 * @param voltage_measured Measured voltage across NTC thermistor (V)
 * @param vcc_supply Supply voltage for voltage divider (V)
 * @param r_pullup Pull-up resistor value (Ohms)
 * @return NTC resistance in Ohms, or negative value if invalid
 */
float NTC_VoltageToResistance(float voltage_measured, float vcc_supply, float r_pullup);

/**
 * @brief Convert NTC resistance to temperature using Beta equation
 * @param resistance_ntc NTC resistance in Ohms
 * @param r25 Resistance at 25°C (Ohms)
 * @param beta Beta coefficient (K)
 * @return Temperature in Celsius
 */
float NTC_ResistanceToTemperature(float resistance_ntc, float r25, float beta);

/**
 * @brief Check if temperature reading is within valid range
 * @param ntc Pointer to NTC configuration structure
 * @param temperature Temperature in Celsius
 * @return true if temperature is valid, false otherwise
 */
bool NTC_IsTemperatureValid(const NTC_Config_S* ntc, float temperature);

/**
 * @brief Get NTC resistance value at specific temperature
 * @param ntc Pointer to NTC configuration structure
 * @param temperature_celsius Temperature in Celsius
 * @return NTC resistance in Ohms
 */
float NTC_GetResistanceAtTemperature(const NTC_Config_S* ntc, float temperature_celsius);

#endif // NTC_H