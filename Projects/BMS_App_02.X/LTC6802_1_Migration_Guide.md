# LTC6802-1 Non-Blocking Driver Migration Guide

## Overview

This document provides guidance for migrating from the blocking LTC6802-2 driver to the new non-blocking LTC6802-1 driver. The new driver is designed to reduce CPU usage by using interrupt-driven SPI and a state machine approach.

## Key Differences

### LTC6802-2 vs LTC6802-1 Hardware Differences

| Feature | LTC6802-2 | LTC6802-1 |
|---------|-----------|-----------|
| Cell Inputs | 12 | 12 |
| Temperature Inputs | 3 | 2 |
| Voltage Resolution | 1.5mV | 1.5mV |
| Register Layout | Different | Different |
| Command Set | Slightly different | Updated commands |
| Data Packing | Cell data packed differently | More efficient packing |

### Software Architecture Differences

| Aspect | Old Driver (LTC6802-2) | New Driver (LTC6802-1) |
|--------|----------------------|------------------------|
| **Operation** | Blocking | Non-blocking |
| **SPI Method** | `spiTransfer()` | `spi1Write()` + interrupts |
| **CPU Usage** | High during operations | Low, distributed |
| **State Management** | None | State machine |
| **Error Handling** | Basic | Comprehensive with retries |
| **Callback Support** | None | Yes |
| **Statistics** | None | Built-in diagnostics |

## Migration Steps

### 1. Update SPI Library

The new driver requires buffered SPI support. The SPI library has been updated with:
- `spi1StartBufferedTransaction()` - Start non-blocking SPI transaction
- `spi1IsBufferedTransactionComplete()` - Check if transaction is complete
- `spi1GetBufferedTransactionResult()` - Get transaction result

**The SPI interrupt handler now manages receive buffers automatically.**

### 2. Replace Include Files

**Old:**
```c
#include "ltc_6802.h"
```

**New:**
```c
#include "ltc6802_1_nb.h"
```

### 2. Update Initialization

**Old:**
```c
void BMS_Init(void) {
    LTC6802_Init();
    // Immediate configuration
    LTC6802_set_CDC(1);
    LTC6802_set_LVPL(0);
    LTC6802_writeConfig();
}
```

**New:**
```c
void BMS_Init(void) {
    LTC6802_1_Init();
    LTC6802_1_RegisterCallback(BMS_LTC6802_Callback);
    
    // Set configuration
    LTC6802_1_Config_S config = {
        .adc_mode = 1,
        .temp_enable = 1,
        .discharge_cells = 0,
        .overvoltage_threshold = (uint16_t)(4.2f / LTC6802_1_VOLTAGE_SCALE_FACTOR),
        .undervoltage_threshold = (uint16_t)(2.5f / LTC6802_1_VOLTAGE_SCALE_FACTOR)
    };
    
    for (uint8_t i = 0; i < LTC6802_1_NUM_STACKS; i++) {
        LTC6802_1_SetConfig(i, &config);
    }
    
    // Start configuration write (non-blocking)
    LTC6802_1_WriteConfig(0xFF);
}
```

### 3. Update Main Loop

**Old:**
```c
void BMS_Run_10ms(void) {
    // Blocking operations
    LTC6802_StartAllCellADC();
    while(LTC6802_check_ADC_status() != 0) {
        // Wait for conversion
    }
    LTC6802_ReadAllCellADC();
    
    // Process data immediately
    for (uint8_t i = 0; i < 24; i++) {
        cell_voltages[i] = LTC6802_get_cell_voltage(i);
    }
}
```

**New:**
```c
void BMS_Run_10ms(void) {
    // Always run the state machine
    LTC6802_1_Run();
    
    // Start measurements if not busy
    if (!LTC6802_1_IsBusy() && need_measurement) {
        LTC6802_1_StartCellVoltageADC(0xFF);
        need_measurement = false;
    }
}

// Callback function handles completion
void BMS_LTC6802_Callback(LTC6802_1_Operation_E operation, 
                          LTC6802_1_Error_E error, 
                          uint8_t stack_id) {
    if (error != LTC6802_1_ERROR_NONE) {
        handle_ltc_error(error, stack_id);
        return;
    }
    
    switch (operation) {
        case LTC6802_1_OP_START_ADC_VOLTAGES:
            // ADC started, now read the data
            LTC6802_1_ReadCellVoltages(0xFF);
            break;
            
        case LTC6802_1_OP_READ_VOLTAGES:
            // Data is ready, process it
            process_voltage_data();
            break;
    }
}
```

### 4. Update Data Access

**Old:**
```c
float voltage = LTC6802_get_cell_voltage(cell_id);
float temp = LTC6802_get_temp_voltage(temp_id);
```

**New:**
```c
float voltage = LTC6802_1_GetCellVoltage(cell_id);
float temp = LTC6802_1_GetTemperatureVoltage(temp_id);
```

### 5. Update Cell Balancing

**Old:**
```c
LTC6802_set_cell_discharge(cell_id, 1);
LTC6802_writeConfig();
```

**New:**
```c
LTC6802_1_SetCellBalancing(cell_id, true);
// Configuration is automatically written asynchronously
```

## API Mapping

### Configuration Functions

| Old Function | New Function | Notes |
|--------------|--------------|-------|
| `LTC6802_set_CDC(uint8_t)` | Use config struct | Set `adc_mode` field |
| `LTC6802_set_LVPL(uint8_t)` | Use config struct | Set `temp_enable` field |
| `LTC6802_set_VUV(float)` | Use config struct | Set `undervoltage_threshold` |
| `LTC6802_set_VOV(float)` | Use config struct | Set `overvoltage_threshold` |
| `LTC6802_set_cell_discharge(uint8_t, uint8_t)` | `LTC6802_1_SetCellBalancing(uint8_t, bool)` | Simplified interface |
| `LTC6802_writeConfig(void)` | `LTC6802_1_WriteConfig(uint8_t)` | Non-blocking, supports addressing |

### ADC Functions

| Old Function | New Function | Notes |
|--------------|--------------|-------|
| `LTC6802_StartAllCellADC(void)` | `LTC6802_1_StartCellVoltageADC(0xFF)` | Non-blocking |
| `LTC6802_StartAllTempADC(void)` | `LTC6802_1_StartTempADC(0xFF)` | Non-blocking |
| `LTC6802_check_ADC_status(void)` | Handled internally | Automatic polling |
| `LTC6802_ReadAllCellADC(void)` | `LTC6802_1_ReadCellVoltages(0xFF)` | Non-blocking |
| `LTC6802_ReadAllTempADC(void)` | `LTC6802_1_ReadTemperatures(0xFF)` | Non-blocking |

### Data Access Functions

| Old Function | New Function | Notes |
|--------------|--------------|-------|
| `LTC6802_get_cell_voltage(uint8_t)` | `LTC6802_1_GetCellVoltage(uint8_t)` | Same interface |
| `LTC6802_get_temp_voltage(uint8_t)` | `LTC6802_1_GetTemperatureVoltage(uint8_t)` | Same interface |

## Performance Benefits

### CPU Usage Reduction

The new driver significantly reduces CPU usage:

- **Old driver**: ~65% CPU spike during BMS operations
- **New driver**: Estimated ~5-10% distributed CPU usage

### Real-time Improvements

- No blocking operations that delay other tasks
- Interrupt-driven SPI reduces polling overhead
- State machine allows precise timing control
- Better error handling and automatic retries

## Error Handling

The new driver provides comprehensive error handling:

```c
void handle_ltc_error(LTC6802_1_Error_E error, uint8_t stack_id) {
    switch (error) {
        case LTC6802_1_ERROR_SPI_TIMEOUT:
            printf("SPI timeout on stack %d\n", stack_id);
            break;
        case LTC6802_1_ERROR_CRC_FAIL:
            printf("CRC error on stack %d\n", stack_id);
            break;
        case LTC6802_1_ERROR_ADC_TIMEOUT:
            printf("ADC timeout on stack %d\n", stack_id);
            break;
        // Handle other errors...
    }
}
```

## Debugging and Diagnostics

The new driver includes built-in diagnostics:

```c
void print_ltc_diagnostics(void) {
    uint32_t total, failed, retries;
    LTC6802_1_GetStats(&total, &failed, &retries);
    
    printf("LTC6802-1 Stats:\n");
    printf("  Total transactions: %lu\n", total);
    printf("  Failed transactions: %lu\n", failed);
    printf("  Retry count: %lu\n", retries);
    printf("  Success rate: %.1f%%\n", 
           100.0f * (total - failed) / total);
    printf("  Current state: %d\n", LTC6802_1_GetState());
    printf("  Busy: %s\n", LTC6802_1_IsBusy() ? "Yes" : "No");
}
```

## Integration Example

See `ltc6802_1_example.c` for a complete integration example showing:

- Proper initialization sequence
- State machine integration
- Callback handling
- Error management
- Data processing
- Cell balancing logic

## Testing Recommendations

1. **Start with single stack**: Test with one LTC6802-1 first
2. **Monitor diagnostics**: Use the built-in statistics
3. **Validate timing**: Ensure operations complete within expected timeframes
4. **Test error conditions**: Verify error handling works correctly
5. **Load testing**: Confirm CPU usage reduction under full load

## Migration Checklist

- [ ] **Update SPI library** with buffered transaction support
- [ ] Replace header includes
- [ ] Update initialization code
- [ ] Implement callback function
- [ ] **Add `LTC6802_1_Run()` to 1ms task** (critical for performance)
- [ ] Update 10ms task to use non-blocking pattern
- [ ] Convert blocking calls to non-blocking equivalents
- [ ] Update configuration method
- [ ] Test with single stack
- [ ] Test with multiple stacks
- [ ] Validate cell voltage readings
- [ ] Validate temperature readings
- [ ] Test cell balancing functionality
- [ ] Verify error handling
- [ ] **Monitor CPU usage improvement** (should drop from 65% to ~5-10%)
- [ ] Update documentation

## Troubleshooting

### Common Issues

1. **"Always busy" error**: Make sure you're calling `LTC6802_1_Run()` regularly
2. **SPI timeouts**: Check SPI interrupt is enabled and working
3. **CRC errors**: Verify SPI timing and connections
4. **Missing callbacks**: Ensure callback function is registered
5. **Wrong voltages**: Check LTC6802-1 vs LTC6802-2 data format differences

### Debug Steps

1. Monitor the state machine with `LTC6802_1_GetState()`
2. Check statistics with `LTC6802_1_GetStats()`
3. Verify SPI interrupt is firing
4. Use oscilloscope to check SPI signals
5. Enable debug prints in the driver if needed