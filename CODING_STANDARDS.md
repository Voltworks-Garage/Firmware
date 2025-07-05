# Voltworks Garage Firmware Coding Standards

## Overview
This document establishes naming conventions and coding standards for the Voltworks Garage electric vehicle firmware project, based on automotive industry best practices including MISRA-C and AUTOSAR guidelines.

## Table of Contents
1. [File Naming Conventions](#file-naming-conventions)
2. [Function Naming Conventions](#function-naming-conventions)
3. [Variable Naming Conventions](#variable-naming-conventions)
4. [Constant and Macro Naming](#constant-and-macro-naming)
5. [Type Definitions](#type-definitions)
6. [Module Organization](#module-organization)
7. [Header File Structure](#header-file-structure)
8. [Migration Guidelines](#migration-guidelines)

---

## File Naming Conventions

### Application Layer Files
- **Format**: PascalCase with descriptive names
- **Pattern**: `ModuleName.c` / `ModuleName.h`
- **Examples**: 
  - `HeatedGrips.c` / `HeatedGrips.h`
  - `StateMachine.c` / `StateMachine.h`
  - `SerialDebugger.c` / `SerialDebugger.h`

### Driver Layer Files
- **Format**: snake_case with hardware/function description
- **Pattern**: `hardware_function.c` / `hardware_function.h`
- **Examples**:
  - `ltc_6802.c` / `ltc_6802.h` (chip-specific)
  - `led_driver.c` / `led_driver.h`
  - `button.c` / `button.h`

### Service Layer Files
- **Format**: camelCase with Service suffix
- **Pattern**: `moduleService.c` / `moduleService.h`
- **Examples**:
  - `canService.c` / `canService.h`
  - `debuggerService.c` / `debuggerService.h`
  - `touchScreenService.c` / `touchScreenService.h`

### Generated Files
- **Format**: Follow generator conventions (MCC, DBC tools)
- **Pattern**: Keep as generated to avoid conflicts
- **Examples**:
  - `mcc_generated_files/` (Microchip MCC)
  - `dbc.c` / `dbc.h` (CAN DBC generated)

---

## Function Naming Conventions

### Public API Functions
- **Format**: `Module_Action_Timing()` for periodic functions
- **Pattern**: `ModuleName_ActionDescription_TimingMs()`
- **Examples**:
  - `HeatedGrips_Run_100ms()`
  - `BMS_Monitor_10ms()`
  - `CAN_Process_1ms()`

### Public API Functions (Non-periodic)
- **Format**: `Module_Action()`
- **Pattern**: `ModuleName_ActionDescription()`
- **Examples**:
  - `BMS_Init()`
  - `CAN_SendMessage()`
  - `IO_SetDebugLed()`

### Private Functions
- **Format**: `module_action()` (snake_case)
- **Pattern**: `moduleName_actionDescription()`
- **Examples**:
  - `heatedGrips_calculatePower()`
  - `bms_checkCellVoltage()`
  - `can_processRxMessage()`

### Hardware Abstraction Functions
- **Format**: `IO_OPERATION_SIGNAL()` for pin operations
- **Pattern**: `IO_[SET|GET|TOGGLE]_SIGNAL_NAME()`
- **Examples**:
  - `IO_SET_DEBUG_LED_EN()`
  - `IO_GET_SW_EN()`
  - `IO_TOGGLE_RELAY_CTRL()`

---

## Variable Naming Conventions

### Local Variables
- **Format**: camelCase
- **Pattern**: `descriptiveName`
- **Examples**:
  - `heatedGripsRun`
  - `canCounter`
  - `batteryVoltage`

### Static Variables
- **Format**: camelCase with module prefix
- **Pattern**: `moduleName_descriptiveName`
- **Examples**:
  - `heatedGrips_currentPower`
  - `bms_cellVoltages`
  - `can_txBuffer`

### Global Variables
- **Format**: PascalCase with g_ prefix
- **Pattern**: `g_ModuleName_DescriptiveName`
- **Examples**:
  - `g_System_OperationMode`
  - `g_BMS_BatteryState`
  - `g_CAN_NetworkStatus`

### Function Parameters
- **Format**: camelCase
- **Pattern**: `parameterName`
- **Examples**:
  - `targetTemperature`
  - `messageId`
  - `bufferSize`

---

## Constant and Macro Naming

### Constants
- **Format**: ALL_CAPS with underscores
- **Pattern**: `MODULE_CONSTANT_NAME`
- **Examples**:
  - `BMS_MAX_CELL_VOLTAGE`
  - `CAN_BAUD_125K`
  - `HEATED_GRIPS_MAX_POWER`

### Configuration Macros
- **Format**: ALL_CAPS with underscores
- **Pattern**: `MODULE_CONFIG_NAME`
- **Examples**:
  - `DEBUG_ENABLE`
  - `CAN_DEBUG_ENABLE`
  - `NUM_OF_ECAN_BUFFERS`

### Pin Definitions
- **Format**: ALL_CAPS with underscores
- **Pattern**: `PIN_FUNCTION_NAME`
- **Examples**:
  - `PIN_DEBUG_LED_EN`
  - `PIN_RELAY_CTRL`
  - `PIN_SW_EN`

---

## Type Definitions

### Enumerations
- **Format**: PascalCase with _E suffix
- **Pattern**: `TypeName_E`
- **Values**: ALL_CAPS with underscores
- **Examples**:
```c
typedef enum {
    BUTTON_NOT_PRESSED,
    BUTTON_PRESSED,
    BUTTON_HELD
} ButtonStatus_E;

typedef enum {
    BMS_STATE_IDLE,
    BMS_STATE_CHARGING,
    BMS_STATE_DISCHARGING,
    BMS_STATE_FAULT
} BmsState_E;
```

### Structures
- **Format**: PascalCase with _S suffix
- **Pattern**: `TypeName_S`
- **Members**: camelCase
- **Examples**:
```c
typedef struct {
    uint16_t windowSize;
    float alpha;
    float accum;
} MovingAverage_S;

typedef struct {
    uint32_t messageId;
    uint8_t data[8];
    uint8_t dataLength;
} CanMessage_S;
```

### Function Pointers
- **Format**: camelCase with _FPtr suffix
- **Pattern**: `functionName_FPtr`
- **Examples**:
```c
typedef void (*stateHandler_FPtr)(void);
typedef bool (*pinFunction_FPtr)(void);
```

---

## Module Organization

### Header File Structure
```c
#ifndef MODULE_NAME_H
#define MODULE_NAME_H

/* Includes */
#include <stdint.h>
#include <stdbool.h>

/* Constants */
#define MODULE_CONSTANT_NAME    (value)

/* Type Definitions */
typedef enum {
    // enumeration values
} ModuleEnum_E;

typedef struct {
    // structure members
} ModuleStruct_S;

/* Public Function Prototypes */
void ModuleName_Init(void);
void ModuleName_Run_TimingMs(void);

#endif /* MODULE_NAME_H */
```

### Source File Structure
```c
/* Includes */
#include "ModuleName.h"
#include "other_required_headers.h"

/* Private Constants */
#define PRIVATE_CONSTANT_NAME   (value)

/* Private Type Definitions */
typedef enum {
    // private enumerations
} PrivateEnum_E;

/* Private Variables */
static uint32_t moduleName_privateVariable;

/* Private Function Prototypes */
static void moduleName_privateFunction(void);

/* Public Function Implementations */
void ModuleName_Init(void)
{
    // implementation
}

/* Private Function Implementations */
static void moduleName_privateFunction(void)
{
    // implementation
}
```

---

## Header File Structure

### Include Guards
- **Format**: `#ifndef MODULE_NAME_H`
- **Pattern**: ALL_CAPS with underscores
- **Examples**:
  - `#ifndef HEATED_GRIPS_H`
  - `#ifndef CAN_SERVICE_H`
  - `#ifndef SERIAL_DEBUGGER_H`

### Include Order
1. Standard C library headers
2. Compiler-specific headers
3. Hardware abstraction headers
4. Application headers
5. Module-specific headers

---

## Migration Guidelines

### Phase 1: Critical Fixes (Immediate)
1. **Fix filename typos**: `debuggerSerivce.c` → `debuggerService.c`
2. **Fix include statements** that reference typo'd filenames
3. **Update build files** (Makefiles, project files)

### Phase 2: Service Layer Standardization
1. **Rename service files** to follow `moduleService.c` pattern
2. **Update function names** to follow `Module_Action()` pattern
3. **Standardize variable names** to camelCase

### Phase 3: Application Layer Standardization
1. **Standardize application module** function names
2. **Update variable naming** for consistency
3. **Standardize constant definitions**

### Phase 4: Driver Layer Standardization
1. **Review driver naming** for consistency
2. **Standardize hardware abstraction** function names
3. **Update type definitions** to follow new patterns

---

## Compliance Notes

### MISRA-C Compliance
- All naming conventions support MISRA-C:2012 guidelines
- Avoid reserved identifier patterns (leading underscores)
- Use descriptive names that enhance code readability

### AUTOSAR Compliance
- Function naming supports AUTOSAR module structure
- Type definitions follow AUTOSAR patterns
- Constants and macros follow AUTOSAR guidelines

### Safety Considerations
- **Avoid ambiguous abbreviations** that could cause misinterpretation
- **Use consistent naming** across safety-critical functions
- **Maintain clear module boundaries** through naming conventions

---

## Examples by Module Type

### BMS Module Example
```c
// File: BatteryManagement.h
#ifndef BATTERY_MANAGEMENT_H
#define BATTERY_MANAGEMENT_H

#define BMS_MAX_CELL_VOLTAGE    (4200U)  // mV
#define BMS_MIN_CELL_VOLTAGE    (3000U)  // mV

typedef enum {
    BMS_STATE_IDLE,
    BMS_STATE_CHARGING,
    BMS_STATE_DISCHARGING,
    BMS_STATE_FAULT
} BmsState_E;

void BatteryManagement_Init(void);
void BatteryManagement_Run_10ms(void);
BmsState_E BatteryManagement_GetState(void);

#endif /* BATTERY_MANAGEMENT_H */
```

### CAN Service Example
```c
// File: canService.h
#ifndef CAN_SERVICE_H
#define CAN_SERVICE_H

#define CAN_BAUD_125K          (125000U)
#define CAN_MAX_MESSAGE_SIZE   (8U)

typedef struct {
    uint32_t messageId;
    uint8_t data[CAN_MAX_MESSAGE_SIZE];
    uint8_t dataLength;
} CanMessage_S;

void CanService_Init(void);
void CanService_Process_1ms(void);
bool CanService_SendMessage(const CanMessage_S* message);

#endif /* CAN_SERVICE_H */
```

This document serves as the authoritative reference for all naming conventions in the Voltworks Garage firmware project. All new code should follow these conventions, and existing code should be migrated according to the phases outlined above.