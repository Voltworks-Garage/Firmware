# SPI Chip Select (CS) Pin Architecture

## Overview

The CS pin management in the non-blocking LTC6802-1 driver follows a **layered approach** where different layers handle CS control appropriately.

## Architecture Layers

### 1. **Hardware Layer - PIC33 SPI Module**
- **SPI1 Hardware**: Has built-in SS (Slave Select) pin support
- **Not Used**: We don't use hardware SS in master mode
- **Reason**: Need precise protocol-level control for LTC6802

### 2. **SPI Library Layer** (`spi.c/.h`)
- **Responsibility**: Byte-level SPI transactions
- **CS Handling**: **None** - CS is protocol-specific
- **Interface**: `spi1StartBufferedTransaction()` handles only data transfer
- **Philosophy**: Keep SPI library generic for multiple protocols

### 3. **Protocol Layer - LTC6802 Driver** (`ltc6802_1_nb.c`)
- **Responsibility**: LTC6802 protocol implementation
- **CS Handling**: **Full Control** - Asserts/deasserts CS around transactions
- **Timing**: CS remains asserted for entire multi-byte transaction
- **Philosophy**: Protocol layer knows when CS should be active

## CS Pin Control Flow

```
LTC6802 Transaction Sequence:
┌─────────────────────────────────────────────────────────────┐
│ 1. LTC6802_1_Run() calls StartSPITransaction()             │
│ 2. StartSPITransaction() asserts CS: IO_SET_SPI_CS(LOW)    │
│ 3. StartSPITransaction() calls spi1StartBufferedTransaction()│
│ 4. SPI interrupt handles byte-by-byte transfer             │
│ 5. LTC6802_1_Run() polls spi1IsBufferedTransactionComplete()│
│ 6. When complete, deasserts CS: IO_SET_SPI_CS(HIGH)        │
└─────────────────────────────────────────────────────────────┘
```

## Code Example

### LTC6802 Driver (Protocol Layer)
```c
// In ltc6802_1_nb.c - StartSPITransaction()
static LTC6802_1_Error_E StartSPITransaction(...) {
    // Protocol layer asserts CS
    IO_SET_SPI_CS(LOW);
    
    // Start buffered transaction (CS remains asserted)
    uint8_t result = spi1StartBufferedTransaction(tx_buffer, tx_len, rx_buffer, rx_len);
    
    return result ? LTC6802_1_ERROR_NONE : LTC6802_1_ERROR_BUSY;
}

// In ltc6802_1_nb.c - LTC6802_1_Run()
void LTC6802_1_Run(void) {
    if (ltc_module.spi_transaction_active) {
        if (spi1IsBufferedTransactionComplete()) {
            // Transaction done, protocol layer deasserts CS
            IO_SET_SPI_CS(HIGH);
            ltc_module.spi_transaction_active = false;
            // Process received data...
        }
    }
}
```

### SPI Library (Transport Layer)
```c
// In spi.c - No CS control, just data transfer
uint8_t spi1StartBufferedTransaction(const uint8_t* tx_buffer, uint8_t tx_length, 
                                    uint8_t* rx_buffer, uint8_t rx_length) {
    // No CS control - handled by calling protocol
    // Just manage the data transfer
    if (spi1_transaction_active) return 0;
    
    // Set up buffers and start transfer
    // ...
    SPI1BUF = spi1_tx_buffer[0];  // Start first byte
    return 1;
}
```

## Why This Architecture?

### ✅ **Advantages:**

1. **Protocol Flexibility**: Different protocols need different CS timing
   - LTC6802: CS active for entire transaction
   - SD Card: CS active per command
   - Generic SPI: Variable timing

2. **Clean Separation**: SPI library doesn't need to know about specific protocols

3. **Precise Timing**: Protocol layer has exact control over CS timing

4. **Reusable SPI Library**: Same SPI functions work for multiple protocols

### ⚠️ **Important Notes:**

1. **CS Must Stay Asserted**: For LTC6802, CS must remain LOW during entire transaction
2. **No SPI Sharing**: Only one protocol can use SPI at a time
3. **Timeout Handling**: If SPI times out, CS must be deasserted to reset state

## CS Pin Configuration

### Hardware Setup
```c
// In IO.h or pins.h
#define IO_SET_SPI_CS(state)  LATBbits.LATB2 = state  // Example pin

// In pinSetup.c
void PinSetup_Init(void) {
    TRISBbits.TRISB2 = 0;  // CS pin as output
    LATBbits.LATB2 = 1;    // CS idle high (inactive)
}
```

### Multiple CS Pins (Future)
If you need multiple SPI devices:
```c
// Different CS pins for different devices
#define IO_SET_LTC6802_CS(state)   LATBbits.LATB2 = state
#define IO_SET_EEPROM_CS(state)    LATBbits.LATB3 = state
#define IO_SET_SD_CARD_CS(state)   LATBbits.LATB4 = state
```

## Error Handling

### SPI Timeout with CS
```c
void LTC6802_1_Run(void) {
    if (ltc_module.spi_transaction_active) {
        if (spi1IsBufferedTransactionComplete()) {
            IO_SET_SPI_CS(HIGH);  // Normal completion
            // ...
        }
        else if (IsTimeout(ltc_module.state_timestamp, LTC6802_1_SPI_TIMEOUT_MS)) {
            IO_SET_SPI_CS(HIGH);  // Timeout - must deassert CS
            ltc_module.spi_transaction_active = false;
            SetError(ltc_module.current_stack_index, LTC6802_1_ERROR_SPI_TIMEOUT);
        }
    }
}
```

## Summary

The **CS pin is properly handled at the protocol layer (LTC6802 driver)** where it belongs. The SPI library focuses purely on data transfer, while the LTC6802 driver manages the protocol-specific CS timing requirements.

This architecture provides:
- ✅ Proper CS timing for LTC6802 protocol
- ✅ Clean separation of concerns
- ✅ Reusable SPI library
- ✅ Precise error handling with CS cleanup