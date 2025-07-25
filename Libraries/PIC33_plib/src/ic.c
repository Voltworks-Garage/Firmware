/**
 * @file ic.c
 * @brief Input Capture module implementation for PIC33 microcontrollers
 * 
 * Provides a flexible, configurable interface for Input Capture modules
 * with support for multiple timer sources including Timer4, runtime
 * mode switching, and proper data management.
 * 
 * @author Redesigned for Voltworks Garage
 * @date 2025
 */

#include "ic.h"
#include <xc.h>
#include <stddef.h>

/******************************************************************************
 * Private Constants
 *******************************************************************************/
#define IC_MAX_CAPTURE_BUFFER_SIZE  8
#define IC_INTERRUPT_PRIORITY_MIN   1
#define IC_INTERRUPT_PRIORITY_MAX   7

/******************************************************************************
 * Private Type Definitions
 *******************************************************************************/

/**
 * @brief Internal module state structure
 */
typedef struct {
    bool isInitialized;
    bool isEnabled;
    IC_Config_S config;
    IC_CaptureData_S captureBuffer[IC_MAX_CAPTURE_BUFFER_SIZE];
    uint8_t bufferHead;
    uint8_t bufferTail;
    uint8_t bufferCount;
    bool dataReady;
    bool bufferOverflow;
    uint16_t pendingHighDuration;
    uint16_t pendingLowDuration;
    bool expectingHighDuration;
} IC_ModuleState_S;

/******************************************************************************
 * Private Variables
 *******************************************************************************/
static IC_ModuleState_S icModules[IC_MODULE_COUNT];

/******************************************************************************
 * Private Function Prototypes
 *******************************************************************************/
static IC_Result_E ic_validateModule(IC_Module_E module);
static IC_Result_E ic_validateConfig(const IC_Config_S* config);
static IC_Result_E ic_configureHardware(IC_Module_E module, const IC_Config_S* config);
static IC_Result_E ic_enableModule(IC_Module_E module);
static IC_Result_E ic_disableModule(IC_Module_E module);
static void ic_addCaptureValue(IC_Module_E module, uint16_t duration, bool isHighDuration);
static void ic_calculateFrequencyAndDuty(IC_Module_E module, IC_CaptureData_S* data);
static void ic_clearBuffer(IC_Module_E module);

/******************************************************************************
 * Public Function Implementations
 *******************************************************************************/

IC_Result_E IC_Init(IC_Module_E module, const IC_Config_S* config) {
    IC_Result_E result;
    
    // Validate parameters
    result = ic_validateModule(module);
    if (result != IC_RESULT_SUCCESS) {
        return result;
    }
    
    if (config == NULL) {
        return IC_RESULT_ERROR_NULL_POINTER;
    }
    
    result = ic_validateConfig(config);
    if (result != IC_RESULT_SUCCESS) {
        return result;
    }
    
    // Check if module is already initialized
    if (icModules[module].isInitialized) {
        return IC_RESULT_ERROR_MODULE_IN_USE;
    }
    
    // Initialize module state
    icModules[module].config = *config;
    icModules[module].isInitialized = true;
    icModules[module].isEnabled = false;
    ic_clearBuffer(module);
    
    // Configure hardware
    result = ic_configureHardware(module, config);
    if (result != IC_RESULT_SUCCESS) {
        icModules[module].isInitialized = false;
        return result;
    }
    
    // Enable interrupts if requested
    if (config->enableInterrupt) {
        result = ic_enableModule(module);
        if (result != IC_RESULT_SUCCESS) {
            icModules[module].isInitialized = false;
            return result;
        }
    }
    
    return IC_RESULT_SUCCESS;
}

IC_Result_E IC_Deinit(IC_Module_E module) {
    IC_Result_E result;
    
    result = ic_validateModule(module);
    if (result != IC_RESULT_SUCCESS) {
        return result;
    }
    
    if (!icModules[module].isInitialized) {
        return IC_RESULT_ERROR_MODULE_NOT_INITIALIZED;
    }
    
    // Disable module
    ic_disableModule(module);
    
    // Clear state
    icModules[module].isInitialized = false;
    icModules[module].isEnabled = false;
    ic_clearBuffer(module);
    
    return IC_RESULT_SUCCESS;
}

IC_Result_E IC_SetConfig(IC_Module_E module, const IC_Config_S* config) {
    IC_Result_E result;
    
    result = ic_validateModule(module);
    if (result != IC_RESULT_SUCCESS) {
        return result;
    }
    
    if (config == NULL) {
        return IC_RESULT_ERROR_NULL_POINTER;
    }
    
    result = ic_validateConfig(config);
    if (result != IC_RESULT_SUCCESS) {
        return result;
    }
    
    if (!icModules[module].isInitialized) {
        return IC_RESULT_ERROR_MODULE_NOT_INITIALIZED;
    }
    
    // Update configuration
    icModules[module].config = *config;
    
    // Reconfigure hardware
    return ic_configureHardware(module, config);
}

IC_Result_E IC_Enable(IC_Module_E module) {
    IC_Result_E result;
    
    result = ic_validateModule(module);
    if (result != IC_RESULT_SUCCESS) {
        return result;
    }
    
    if (!icModules[module].isInitialized) {
        return IC_RESULT_ERROR_MODULE_NOT_INITIALIZED;
    }
    
    return ic_enableModule(module);
}

IC_Result_E IC_Disable(IC_Module_E module) {
    IC_Result_E result;
    
    result = ic_validateModule(module);
    if (result != IC_RESULT_SUCCESS) {
        return result;
    }
    
    if (!icModules[module].isInitialized) {
        return IC_RESULT_ERROR_MODULE_NOT_INITIALIZED;
    }
    
    return ic_disableModule(module);
}

IC_Result_E IC_SetCaptureMode(IC_Module_E module, IC_CaptureMode_E mode) {
    IC_Result_E result;
    
    result = ic_validateModule(module);
    if (result != IC_RESULT_SUCCESS) {
        return result;
    }
    
    if (!icModules[module].isInitialized) {
        return IC_RESULT_ERROR_MODULE_NOT_INITIALIZED;
    }
    
    // Update configuration
    icModules[module].config.captureMode = mode;
    
    // Apply to hardware
    switch (module) {
        case IC_MODULE_1:
            IC1CON1bits.ICM = mode;
            break;
        case IC_MODULE_2:
            IC2CON1bits.ICM = mode;
            break;
        case IC_MODULE_3:
            IC3CON1bits.ICM = mode;
            break;
        case IC_MODULE_4:
            IC4CON1bits.ICM = mode;
            break;
        default:
            return IC_RESULT_ERROR_INVALID_MODULE;
    }
    
    return IC_RESULT_SUCCESS;
}

IC_Result_E IC_SetTimerSource(IC_Module_E module, IC_TimerSource_E source) {
    IC_Result_E result;
    
    result = ic_validateModule(module);
    if (result != IC_RESULT_SUCCESS) {
        return result;
    }
    
    if (!icModules[module].isInitialized) {
        return IC_RESULT_ERROR_MODULE_NOT_INITIALIZED;
    }
    
    // Update configuration
    icModules[module].config.timerSource = source;
    
    // Apply to hardware
    switch (module) {
        case IC_MODULE_1:
            IC1CON1bits.ICTSEL = source;
            break;
        case IC_MODULE_2:
            IC2CON1bits.ICTSEL = source;
            break;
        case IC_MODULE_3:
            IC3CON1bits.ICTSEL = source;
            break;
        case IC_MODULE_4:
            IC4CON1bits.ICTSEL = source;
            break;
        default:
            return IC_RESULT_ERROR_INVALID_MODULE;
    }
    
    return IC_RESULT_SUCCESS;
}

IC_Result_E IC_SetTriggerMode(IC_Module_E module, IC_TriggerMode_E triggerMode) {
    IC_Result_E result;
    
    result = ic_validateModule(module);
    if (result != IC_RESULT_SUCCESS) {
        return result;
    }
    
    if (!icModules[module].isInitialized) {
        return IC_RESULT_ERROR_MODULE_NOT_INITIALIZED;
    }
    
    // Update configuration
    icModules[module].config.triggerMode = triggerMode;
    
    // Apply to hardware
    switch (module) {
        case IC_MODULE_1:
            IC1CON2bits.ICTRIG = triggerMode;
            break;
        case IC_MODULE_2:
            IC2CON2bits.ICTRIG = triggerMode;
            break;
        case IC_MODULE_3:
            IC3CON2bits.ICTRIG = triggerMode;
            break;
        case IC_MODULE_4:
            IC4CON2bits.ICTRIG = triggerMode;
            break;
        default:
            return IC_RESULT_ERROR_INVALID_MODULE;
    }
    
    return IC_RESULT_SUCCESS;
}

bool IC_IsDataReady(IC_Module_E module) {
    if (ic_validateModule(module) != IC_RESULT_SUCCESS) {
        return false;
    }
    
    if (!icModules[module].isInitialized) {
        return false;
    }
    
    return icModules[module].dataReady && (icModules[module].bufferCount > 0);
}

IC_Result_E IC_GetCaptureData(IC_Module_E module, IC_CaptureData_S* data) {
    IC_Result_E result;
    
    result = ic_validateModule(module);
    if (result != IC_RESULT_SUCCESS) {
        return result;
    }
    
    if (data == NULL) {
        return IC_RESULT_ERROR_NULL_POINTER;
    }
    
    if (!icModules[module].isInitialized) {
        return IC_RESULT_ERROR_MODULE_NOT_INITIALIZED;
    }
    
    if (icModules[module].bufferCount == 0) {
        return IC_RESULT_ERROR_NO_DATA;
    }
    
    // Get data from buffer
    *data = icModules[module].captureBuffer[icModules[module].bufferTail];
    icModules[module].bufferTail = (icModules[module].bufferTail + 1) % IC_MAX_CAPTURE_BUFFER_SIZE;
    icModules[module].bufferCount--;
    
    // Update data ready flag
    icModules[module].dataReady = (icModules[module].bufferCount > 0);
    
    return IC_RESULT_SUCCESS;
}

IC_Result_E IC_GetCaptureDataArray(IC_Module_E module, IC_CaptureData_S* dataArray, 
                                   uint8_t maxCount, uint8_t* actualCount) {
    IC_Result_E result;
    uint8_t i;
    
    result = ic_validateModule(module);
    if (result != IC_RESULT_SUCCESS) {
        return result;
    }
    
    if (dataArray == NULL || actualCount == NULL) {
        return IC_RESULT_ERROR_NULL_POINTER;
    }
    
    if (!icModules[module].isInitialized) {
        return IC_RESULT_ERROR_MODULE_NOT_INITIALIZED;
    }
    
    *actualCount = 0;
    
    // Get up to maxCount data entries
    for (i = 0; i < maxCount && icModules[module].bufferCount > 0; i++) {
        dataArray[i] = icModules[module].captureBuffer[icModules[module].bufferTail];
        icModules[module].bufferTail = (icModules[module].bufferTail + 1) % IC_MAX_CAPTURE_BUFFER_SIZE;
        icModules[module].bufferCount--;
        (*actualCount)++;
    }
    
    // Update data ready flag
    icModules[module].dataReady = (icModules[module].bufferCount > 0);
    
    return (*actualCount > 0) ? IC_RESULT_SUCCESS : IC_RESULT_ERROR_NO_DATA;
}

IC_Result_E IC_ClearData(IC_Module_E module) {
    IC_Result_E result;
    
    result = ic_validateModule(module);
    if (result != IC_RESULT_SUCCESS) {
        return result;
    }
    
    if (!icModules[module].isInitialized) {
        return IC_RESULT_ERROR_MODULE_NOT_INITIALIZED;
    }
    
    ic_clearBuffer(module);
    
    return IC_RESULT_SUCCESS;
}

IC_Result_E IC_GetStatus(IC_Module_E module, bool* isInitialized, bool* isEnabled) {
    IC_Result_E result;
    
    result = ic_validateModule(module);
    if (result != IC_RESULT_SUCCESS) {
        return result;
    }
    
    if (isInitialized == NULL || isEnabled == NULL) {
        return IC_RESULT_ERROR_NULL_POINTER;
    }
    
    *isInitialized = icModules[module].isInitialized;
    *isEnabled = icModules[module].isEnabled;
    
    return IC_RESULT_SUCCESS;
}

bool IC_HasBufferOverflow(IC_Module_E module) {
    if (ic_validateModule(module) != IC_RESULT_SUCCESS) {
        return false;
    }
    
    if (!icModules[module].isInitialized) {
        return false;
    }
    
    return icModules[module].bufferOverflow;
}

IC_Result_E IC_ClearBufferOverflow(IC_Module_E module) {
    IC_Result_E result;
    
    result = ic_validateModule(module);
    if (result != IC_RESULT_SUCCESS) {
        return result;
    }
    
    if (!icModules[module].isInitialized) {
        return IC_RESULT_ERROR_MODULE_NOT_INITIALIZED;
    }
    
    icModules[module].bufferOverflow = false;
    
    return IC_RESULT_SUCCESS;
}

/******************************************************************************
 * Private Function Implementations
 *******************************************************************************/

static IC_Result_E ic_validateModule(IC_Module_E module) {
    if (module >= IC_MODULE_COUNT) {
        return IC_RESULT_ERROR_INVALID_MODULE;
    }
    return IC_RESULT_SUCCESS;
}

static IC_Result_E ic_validateConfig(const IC_Config_S* config) {
    if (config->interruptPriority < IC_INTERRUPT_PRIORITY_MIN || 
        config->interruptPriority > IC_INTERRUPT_PRIORITY_MAX) {
        return IC_RESULT_ERROR_INVALID_CONFIG;
    }
    return IC_RESULT_SUCCESS;
}

static IC_Result_E ic_configureHardware(IC_Module_E module, const IC_Config_S* config) {
    switch (module) {
        case IC_MODULE_1:
            _IC1R = config->inputPin;
            IC1CON1bits.ICTSEL = config->timerSource;
            IC1CON1bits.ICM = config->captureMode;
            IC1CON2bits.SYNCSEL = 0b00000;
            IC1CON2bits.ICTRIG = config->triggerMode;
            IC1CON2bits.TRIGSTAT = 0;
            _IC1IP = config->interruptPriority;
            break;
            
        case IC_MODULE_2:
            _IC2R = config->inputPin;
            IC2CON1bits.ICTSEL = config->timerSource;
            IC2CON1bits.ICM = config->captureMode;
            IC2CON2bits.SYNCSEL = 0b00000;
            IC2CON2bits.ICTRIG = config->triggerMode;
            IC2CON2bits.TRIGSTAT = 0;
            _IC2IP = config->interruptPriority;
            break;
            
        case IC_MODULE_3:
            _IC3R = config->inputPin;
            IC3CON1bits.ICTSEL = config->timerSource;
            IC3CON1bits.ICM = config->captureMode;
            IC3CON2bits.SYNCSEL = 0b00000;
            IC3CON2bits.ICTRIG = config->triggerMode;
            IC3CON2bits.TRIGSTAT = 0;
            _IC3IP = config->interruptPriority;
            break;
            
        case IC_MODULE_4:
            _IC4R = config->inputPin;
            IC4CON1bits.ICTSEL = config->timerSource;
            IC4CON1bits.ICM = config->captureMode;
            IC4CON2bits.SYNCSEL = 0b00000;
            IC4CON2bits.ICTRIG = config->triggerMode;
            IC4CON2bits.TRIGSTAT = 0;
            _IC4IP = config->interruptPriority;
            break;
            
        default:
            return IC_RESULT_ERROR_INVALID_MODULE;
    }
    
    return IC_RESULT_SUCCESS;
}

static IC_Result_E ic_enableModule(IC_Module_E module) {
    // Read current PIN state to determine starting expectation
    PINS_State_E pinState = PINS_read(icModules[module].config.digitalPin);
    icModules[module].expectingHighDuration = (pinState == LOW);  // If pin is LOW, expect HIGH duration next
    
    switch (module) {
        case IC_MODULE_1:
            _IC1IE = 1;
            break;
        case IC_MODULE_2:
            _IC2IE = 1;
            break;
        case IC_MODULE_3:
            _IC3IE = 1;
            break;
        case IC_MODULE_4:
            _IC4IE = 1;
            break;
        default:
            return IC_RESULT_ERROR_INVALID_MODULE;
    }
    
    icModules[module].isEnabled = true;
    return IC_RESULT_SUCCESS;
}

static IC_Result_E ic_disableModule(IC_Module_E module) {
    switch (module) {
        case IC_MODULE_1:
            _IC1IE = 0;
            IC1CON1bits.ICM = IC_CAPTURE_MODE_DISABLED;
            break;
        case IC_MODULE_2:
            _IC2IE = 0;
            IC2CON1bits.ICM = IC_CAPTURE_MODE_DISABLED;
            break;
        case IC_MODULE_3:
            _IC3IE = 0;
            IC3CON1bits.ICM = IC_CAPTURE_MODE_DISABLED;
            break;
        case IC_MODULE_4:
            _IC4IE = 0;
            IC4CON1bits.ICM = IC_CAPTURE_MODE_DISABLED;
            break;
        default:
            return IC_RESULT_ERROR_INVALID_MODULE;
    }
    
    icModules[module].isEnabled = false;
    return IC_RESULT_SUCCESS;
}

static void ic_addCaptureValue(IC_Module_E module, uint16_t duration, bool isHighDuration) {
    if (isHighDuration) {
        icModules[module].pendingHighDuration = duration;
    } else {
        icModules[module].pendingLowDuration = duration;
        
        // We have both high and low durations - create complete capture data
        IC_CaptureData_S captureData;
        captureData.highDuration = icModules[module].pendingHighDuration;
        captureData.lowDuration = icModules[module].pendingLowDuration;
        
        // Calculate frequency and duty cycle
        ic_calculateFrequencyAndDuty(module, &captureData);
        
        // Always write to buffer, even if full (overwrite oldest data)
        icModules[module].captureBuffer[icModules[module].bufferHead] = captureData;
        icModules[module].bufferHead = (icModules[module].bufferHead + 1) % IC_MAX_CAPTURE_BUFFER_SIZE;
        
        if (icModules[module].bufferCount < IC_MAX_CAPTURE_BUFFER_SIZE) {
            icModules[module].bufferCount++;
        } else {
            // Buffer is full - set overflow flag and advance tail to maintain circular buffer
            icModules[module].bufferOverflow = true;
            icModules[module].bufferTail = (icModules[module].bufferTail + 1) % IC_MAX_CAPTURE_BUFFER_SIZE;
        }
        
        icModules[module].dataReady = true;
    }
}

static void ic_calculateFrequencyAndDuty(IC_Module_E module, IC_CaptureData_S* data) {
    uint32_t totalPeriod = data->highDuration + data->lowDuration;
    
    if (totalPeriod > 0 && icModules[module].config.clockFrequency > 0) {
        // Calculate frequency: frequency = clockFrequency / totalPeriod
        data->frequency = icModules[module].config.clockFrequency / totalPeriod;
        
        // Calculate duty cycle: dutyCycle = (highDuration * 10000) / totalPeriod for 0.01% resolution
        data->dutyCycle = ((uint32_t)data->highDuration * 10000) / totalPeriod;
        
        data->isValid = true;
    } else {
        data->frequency = 0;
        data->dutyCycle = 0;
        data->isValid = false;
    }
}

static void ic_clearBuffer(IC_Module_E module) {
    icModules[module].bufferHead = 0;
    icModules[module].bufferTail = 0;
    icModules[module].bufferCount = 0;
    icModules[module].dataReady = false;
    icModules[module].bufferOverflow = false;
    icModules[module].pendingHighDuration = 0;
    icModules[module].pendingLowDuration = 0;
    // expectingHighDuration will be set based on actual pin reading in ic_enableModule
}

/******************************************************************************
 * Interrupt Service Routines
 *******************************************************************************/

void __attribute__((__interrupt__, auto_psv)) _IC1Interrupt(void) {
    _IC1IF = 0;  // Clear interrupt flag
    
    // Read capture value - IC buffer is automatically cleared on read
    uint16_t duration = IC1BUF;
    
    // Read current pin state to determine what duration we just measured
    // If pin is HIGH now, we just finished measuring a LOW duration
    // If pin is LOW now, we just finished measuring a HIGH duration
    PINS_State_E pinState = PINS_read(icModules[IC_MODULE_1].config.digitalPin);
    bool isHighDuration = (pinState == LOW);  // Inverted logic
    
    ic_addCaptureValue(IC_MODULE_1, duration, isHighDuration);
}

void __attribute__((__interrupt__, auto_psv)) _IC2Interrupt(void) {
    _IC2IF = 0;  // Clear interrupt flag
    
    // Read capture value - IC buffer is automatically cleared on read
    uint16_t duration = IC2BUF;
    
    // Read current pin state to determine what duration we just measured
    PINS_State_E pinState = PINS_read(icModules[IC_MODULE_2].config.digitalPin);
    bool isHighDuration = (pinState == LOW);  // Inverted logic
    
    ic_addCaptureValue(IC_MODULE_2, duration, isHighDuration);
}

void __attribute__((__interrupt__, auto_psv)) _IC3Interrupt(void) {
    _IC3IF = 0;  // Clear interrupt flag
    
    // Read capture value - IC buffer is automatically cleared on read
    uint16_t duration = IC3BUF;
    
    // Read current pin state to determine what duration we just measured
    PINS_State_E pinState = PINS_read(icModules[IC_MODULE_3].config.digitalPin);
    bool isHighDuration = (pinState == LOW);  // Inverted logic
    
    ic_addCaptureValue(IC_MODULE_3, duration, isHighDuration);
}

void __attribute__((__interrupt__, auto_psv)) _IC4Interrupt(void) {
    _IC4IF = 0;  // Clear interrupt flag
    
    // Read capture value - IC buffer is automatically cleared on read
    uint16_t duration = IC4BUF;
    
    // Read current pin state to determine what duration we just measured
    PINS_State_E pinState = PINS_read(icModules[IC_MODULE_4].config.digitalPin);
    bool isHighDuration = (pinState == LOW);  // Inverted logic
    
    ic_addCaptureValue(IC_MODULE_4, duration, isHighDuration);
}