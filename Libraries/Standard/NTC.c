/******************************************************************************
 * NTC Thermistor Library Implementation
 * 
 * Description: Library for converting voltage readings to temperature using
 *              NTC thermistors with voltage divider circuits.
 *              Supports multiple NTC instances using macros.
 * 
 * Author: Generated with Claude Code
 * Date: 2025-07-19
 *******************************************************************************/

#include "NTC.h"
#include <math.h>

/******************************************************************************
 * Private Constants
 *******************************************************************************/

// Temperature conversion constants
#define KELVIN_OFFSET           273.15f
#define TEMP_25C_KELVIN         298.15f

// Predefined NTC configurations (without pull-up resistor)
static const NTC_Config_S NTC_PREDEFINED_CONFIGS[] = {
    // B57355V5104F360: EPCOS/TDK 100kΩ, B25/85=4350K
    [NTC_TYPE_B57355V5104F360] = {
        .r25 = 100000.0f,       // 100kΩ at 25°C
        .beta = 4350.0f,        // B25/85 = 4350K
        .r_pullup = 0.0f,       // Will be set by user
        .temp_min = -55.0f,     // Minimum operating temperature
        .temp_max = 125.0f      // Maximum operating temperature
    }
};

/******************************************************************************
 * Public Function Implementations
 *******************************************************************************/

NTC_Config_S NTC_GetPredefinedConfig(NTC_Type_E type, float r_pullup) {
    NTC_Config_S config;
    
    if (type < (sizeof(NTC_PREDEFINED_CONFIGS) / sizeof(NTC_PREDEFINED_CONFIGS[0])) && r_pullup > 0.0f) {
        // Copy predefined configuration
        config = NTC_PREDEFINED_CONFIGS[type];
        
        // Set the pull-up resistor value
        config.r_pullup = r_pullup;
    } else {
        // Return invalid configuration
        config.r25 = 0.0f;
        config.beta = 0.0f;
        config.r_pullup = 0.0f;
        config.temp_min = 0.0f;
        config.temp_max = 0.0f;
    }
    
    return config;
}

float NTC_VoltageToTemperature(const NTC_Config_S* ntc, float voltage_measured, float vcc_supply) {
    if (ntc == NULL) {
        return NTC_ERROR_INVALID_PARAMS;
    }
    
    // Validate NTC configuration
    if (ntc->r25 <= 0.0f || ntc->beta <= 0.0f || ntc->r_pullup <= 0.0f) {
        return NTC_ERROR_INVALID_PARAMS;
    }
    
    if (voltage_measured < 0.0f || vcc_supply <= 0.0f || voltage_measured >= vcc_supply) {
        return NTC_ERROR_INVALID_VOLTAGE;
    }
    
    // Convert voltage to NTC resistance
    float r_ntc = NTC_VoltageToResistance(voltage_measured, vcc_supply, ntc->r_pullup);
    if (r_ntc < 0.0f) {
        return NTC_ERROR_INVALID_VOLTAGE;
    }
    
    // Convert resistance to temperature
    float temperature = NTC_ResistanceToTemperature(r_ntc, ntc->r25, ntc->beta);
    
    return temperature;
}

float NTC_TemperatureToVoltage(const NTC_Config_S* ntc, float temperature_celsius, float vcc_supply) {
    if (ntc == NULL) {
        return NTC_ERROR_INVALID_PARAMS;
    }
    
    // Validate NTC configuration
    if (ntc->r25 <= 0.0f || ntc->beta <= 0.0f || ntc->r_pullup <= 0.0f) {
        return NTC_ERROR_INVALID_PARAMS;
    }
    
    if (vcc_supply <= 0.0f) {
        return NTC_ERROR_INVALID_VOLTAGE;
    }
    
    // Convert temperature to resistance using inverse Beta equation
    float temp_kelvin = temperature_celsius + KELVIN_OFFSET;
    float r_ntc = ntc->r25 * expf(ntc->beta * ((1.0f / temp_kelvin) - (1.0f / TEMP_25C_KELVIN)));
    
    // Convert resistance to voltage using voltage divider equation
    float voltage = vcc_supply * r_ntc / (ntc->r_pullup + r_ntc);
    
    return voltage;
}

float NTC_VoltageToResistance(float voltage_measured, float vcc_supply, float r_pullup) {
    if (voltage_measured < 0.0f || vcc_supply <= 0.0f || 
        voltage_measured >= vcc_supply || r_pullup <= 0.0f) {
        return NTC_ERROR_INVALID_VOLTAGE;
    }
    
    // Voltage divider equation: V_ntc = Vcc * R_ntc / (R_pullup + R_ntc)
    // Solving for R_ntc: R_ntc = R_pullup * V_ntc / (Vcc - V_ntc)
    float r_ntc = r_pullup * voltage_measured / (vcc_supply - voltage_measured);
    
    return r_ntc;
}

float NTC_ResistanceToTemperature(float resistance_ntc, float r25, float beta) {
    if (resistance_ntc <= 0.0f || r25 <= 0.0f || beta <= 0.0f) {
        return NTC_ERROR_INVALID_PARAMS;
    }
    
    // Beta equation: 1/T = 1/T0 + (1/B) * ln(R/R0)
    // Where T0 = 298.15K (25°C), R0 = resistance at 25°C
    float temp_kelvin = 1.0f / ((1.0f / TEMP_25C_KELVIN) + (1.0f / beta) * logf(resistance_ntc / r25));
    float temp_celsius = temp_kelvin - KELVIN_OFFSET;
    
    return temp_celsius;
}

bool NTC_IsTemperatureValid(const NTC_Config_S* ntc, float temperature) {
    if (ntc == NULL) {
        return false;
    }
    
    // Validate NTC configuration
    if (ntc->r25 <= 0.0f || ntc->beta <= 0.0f || ntc->r_pullup <= 0.0f) {
        return false;
    }
    
    return (temperature >= ntc->temp_min && temperature <= ntc->temp_max);
}

float NTC_GetResistanceAtTemperature(const NTC_Config_S* ntc, float temperature_celsius) {
    if (ntc == NULL) {
        return NTC_ERROR_INVALID_PARAMS;
    }
    
    // Validate NTC configuration
    if (ntc->r25 <= 0.0f || ntc->beta <= 0.0f) {
        return NTC_ERROR_INVALID_PARAMS;
    }
    
    // Convert temperature to resistance using inverse Beta equation
    float temp_kelvin = temperature_celsius + KELVIN_OFFSET;
    float r_ntc = ntc->r25 * expf(ntc->beta * ((1.0f / temp_kelvin) - (1.0f / TEMP_25C_KELVIN)));
    
    return r_ntc;
}