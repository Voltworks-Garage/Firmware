/**
 * @file ic.h
 * @brief Input Capture module interface for PIC33 microcontrollers
 * 
 * Provides a flexible, configurable interface for Input Capture modules
 * with support for multiple timer sources including Timer4, runtime
 * mode switching, and proper data management.
 * 
 * @author Redesigned for Voltworks Garage
 * @date 2025
 */

#ifndef IC_H
#define IC_H

#include <stdint.h>
#include <stdbool.h>
#include "pps.h"
#include "pins.h"

/******************************************************************************
 * Type Definitions
 *******************************************************************************/

/**
 * @brief Available Input Capture modules
 */
typedef enum {
    IC_MODULE_1,
    IC_MODULE_2,
    IC_MODULE_3,
    IC_MODULE_4,
    IC_MODULE_COUNT
} IC_Module_E;

/**
 * @brief Timer source options for Input Capture
 */
typedef enum {
    IC_TIMER_SOURCE_TIMER4 = 0b000,        /**< Timer4 clock source */
    IC_TIMER_SOURCE_TIMER5 = 0b001,        /**< Timer5 clock source */
    IC_TIMER_SOURCE_TIMER2 = 0b010,        /**< Timer2 clock source */
    IC_TIMER_SOURCE_TIMER3 = 0b011,        /**< Timer3 clock source */
    IC_TIMER_SOURCE_PERIPHERAL = 0b111     /**< Peripheral clock source */
} IC_TimerSource_E;

/**
 * @brief Input Capture modes
 */
typedef enum {
    IC_CAPTURE_MODE_DISABLED = 0b000,      /**< Input Capture disabled */
    IC_CAPTURE_MODE_EVERY_EDGE = 0b001,    /**< Capture on every edge */
    IC_CAPTURE_MODE_EVERY_FALLING = 0b010, /**< Capture on every falling edge */
    IC_CAPTURE_MODE_EVERY_RISING = 0b011,  /**< Capture on every rising edge */
    IC_CAPTURE_MODE_4TH_RISING = 0b100,    /**< Capture on every 4th rising edge */
    IC_CAPTURE_MODE_16TH_RISING = 0b101    /**< Capture on every 16th rising edge */
} IC_CaptureMode_E;

/**
 * @brief Timer trigger modes
 */
typedef enum {
    IC_TRIGGER_NONE = 0b00,                /**< No trigger, timer runs continuously */
    IC_TRIGGER_INPUT_CAPTURE = 0b01,       /**< Timer triggered by input capture event */
    IC_TRIGGER_TIMER2 = 0b10,              /**< Timer triggered by Timer2 */
    IC_TRIGGER_TIMER3 = 0b11               /**< Timer triggered by Timer3 */
} IC_TriggerMode_E;

/**
 * @brief Function return codes
 */
typedef enum {
    IC_RESULT_SUCCESS = 0,
    IC_RESULT_ERROR_INVALID_MODULE,
    IC_RESULT_ERROR_MODULE_IN_USE,
    IC_RESULT_ERROR_NULL_POINTER,
    IC_RESULT_ERROR_INVALID_CONFIG,
    IC_RESULT_ERROR_MODULE_NOT_INITIALIZED,
    IC_RESULT_ERROR_NO_DATA
} IC_Result_E;

/**
 * @brief Input Capture data structure for PWM measurements
 */
typedef struct {
    uint16_t highDuration;                 /**< Duration of HIGH pulse in timer ticks */
    uint16_t lowDuration;                  /**< Duration of LOW pulse in timer ticks */
    uint32_t frequency;                  /**< Calculated frequency in Hz (integer) */
    uint16_t dutyCycle;             /**< Calculated duty cycle in % (0-10000 for 0.01% resolution) */
    bool isValid;                          /**< True when data is valid */
} IC_CaptureData_S;

/**
 * @brief Input Capture configuration structure
 */
typedef struct {
    pps_input_pin_t inputPin;              /**< Input pin assignment */
    gpio_pin_t digitalPin;                 /**< Digital pin for reading pin state */
    IC_TimerSource_E timerSource;          /**< Timer source selection */
    IC_CaptureMode_E captureMode;          /**< Capture mode */
    IC_TriggerMode_E triggerMode;          /**< Timer trigger mode */
    uint8_t interruptPriority;             /**< Interrupt priority (1-7) */
    bool enableInterrupt;                  /**< Enable interrupt */
    uint32_t clockFrequency;               /**< Timer clock frequency in Hz */
} IC_Config_S;

/******************************************************************************
 * Public Function Prototypes
 *******************************************************************************/

/**
 * @brief Initialize an Input Capture module
 * @param module Input Capture module to initialize
 * @param config Configuration structure
 * @return IC_Result_E success or error code
 */
IC_Result_E IC_Init(IC_Module_E module, const IC_Config_S* config);

/**
 * @brief Deinitialize an Input Capture module
 * @param module Input Capture module to deinitialize
 * @return IC_Result_E success or error code
 */
IC_Result_E IC_Deinit(IC_Module_E module);

/**
 * @brief Update configuration of an Input Capture module
 * @param module Input Capture module
 * @param config New configuration structure
 * @return IC_Result_E success or error code
 */
IC_Result_E IC_SetConfig(IC_Module_E module, const IC_Config_S* config);

/**
 * @brief Enable an Input Capture module
 * @param module Input Capture module
 * @return IC_Result_E success or error code
 */
IC_Result_E IC_Enable(IC_Module_E module);

/**
 * @brief Disable an Input Capture module
 * @param module Input Capture module
 * @return IC_Result_E success or error code
 */
IC_Result_E IC_Disable(IC_Module_E module);

/**
 * @brief Change capture mode at runtime
 * @param module Input Capture module
 * @param mode New capture mode
 * @return IC_Result_E success or error code
 */
IC_Result_E IC_SetCaptureMode(IC_Module_E module, IC_CaptureMode_E mode);

/**
 * @brief Change timer source at runtime
 * @param module Input Capture module
 * @param source New timer source
 * @return IC_Result_E success or error code
 */
IC_Result_E IC_SetTimerSource(IC_Module_E module, IC_TimerSource_E source);

/**
 * @brief Change trigger mode at runtime
 * @param module Input Capture module
 * @param triggerMode New trigger mode
 * @return IC_Result_E success or error code
 */
IC_Result_E IC_SetTriggerMode(IC_Module_E module, IC_TriggerMode_E triggerMode);

/**
 * @brief Check if capture data is available
 * @param module Input Capture module
 * @return true if data is ready, false otherwise
 */
bool IC_IsDataReady(IC_Module_E module);

/**
 * @brief Get PWM capture data from Input Capture module
 * @param module Input Capture module
 * @param data Pointer to store capture data
 * @return IC_Result_E success or error code
 */
IC_Result_E IC_GetCaptureData(IC_Module_E module, IC_CaptureData_S* data);

/**
 * @brief Get multiple PWM capture data entries
 * @param module Input Capture module
 * @param dataArray Array to store capture data
 * @param maxCount Maximum number of entries to retrieve
 * @param actualCount Pointer to store actual number of entries retrieved
 * @return IC_Result_E success or error code
 */
IC_Result_E IC_GetCaptureDataArray(IC_Module_E module, IC_CaptureData_S* dataArray, 
                                   uint8_t maxCount, uint8_t* actualCount);

/**
 * @brief Clear captured data for a module
 * @param module Input Capture module
 * @return IC_Result_E success or error code
 */
IC_Result_E IC_ClearData(IC_Module_E module);

/**
 * @brief Get module status information
 * @param module Input Capture module  
 * @param isInitialized Pointer to store initialization status
 * @param isEnabled Pointer to store enable status
 * @return IC_Result_E success or error code
 */
IC_Result_E IC_GetStatus(IC_Module_E module, bool* isInitialized, bool* isEnabled);

/**
 * @brief Check if buffer overflow has occurred
 * @param module Input Capture module
 * @return true if buffer overflow occurred, false otherwise
 */
bool IC_HasBufferOverflow(IC_Module_E module);

/**
 * @brief Clear buffer overflow flag
 * @param module Input Capture module
 * @return IC_Result_E success or error code
 */
IC_Result_E IC_ClearBufferOverflow(IC_Module_E module);


#endif /* IC_H */