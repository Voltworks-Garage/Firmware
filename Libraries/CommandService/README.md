# Command Handler Library

A configurable bridge between ISO-TP commands and project-specific IO operations using function pointer arrays.

## Architecture

- **Core Library**: Contains generic command handlers (setDigitalOut, getPWM, getVoltage, etc.)
- **Project Config**: Simple arrays of function pointers that map to project-specific IO functions
- **No Circular Includes**: Config file is completely self-contained

## Usage

1. Include the library in your project
2. Create a `commandHandler_config.h` file in your project  
3. Define function pointer arrays mapping to your IO functions
4. Add `commandHandler_run()` to your task scheduler

## Example Configuration

```c
// commandHandler_config.h
#include "IO.h"

// Function pointer arrays
const setDigitalOutFunc_t setDigitalOutFunctions[] = {
    NULL,                    // Index 0 - reserved
    IO_SET_DEBUG_LED_EN,     // Index 1  
    IO_SET_DCDC_EN,          // Index 2
    NULL
};

const getVoltageFunc_t getVoltageFunctions[] = {
    NULL,                    // Index 0 - reserved
    IO_GET_HV_BUS_VOLTAGE,   // Index 1
    IO_GET_VBUS_VOLTAGE,     // Index 2
    NULL
};

// Command mapping
const commandMapEntry_S commandMap[] = {
    {0x01, CMD_TYPE_SET_DIGITAL_OUT, 0, 2, "Set Digital Out"},
    {0x20, CMD_TYPE_GET_VOLTAGE,     0, 1, "Get Voltage"}
};

const uint8_t commandMapSize = sizeof(commandMap) / sizeof(commandMapEntry_S);
```

## Command Protocol

Commands use a simple payload format:
- **Set Digital Out**: `[commandId, ioIndex, state]`
- **Get Voltage**: `[commandId, ioIndex]`
- **Set PWM**: `[commandId, ioIndex, duty]`

The `ioIndex` corresponds to the position in the function pointer arrays.

## Integration

Add to your task scheduler:

```c
#include "../../Libraries/CommandHandler/commandHandler.h"

void Tsk_init(void) {
    commandHandler_init();
}

void Tsk_10ms(void) {
    commandHandler_run();
}
```