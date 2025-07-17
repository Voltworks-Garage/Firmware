/*
 * File:   spi.c
 * Author: Zach Levenberg
 *
 * Created on February 10, 2016, 10:23 PM
 */

#include "spi.h"
#include "stddef.h"

/*Output PPS registers*/
#define RP20_SPI_PPS    _RP20R
#define RP35_SPI_PPS    _RP35R
#define RP36_SPI_PPS    _RP36R
#define RP37_SPI_PPS    _RP37R
#define RP38_SPI_PPS    _RP38R
#define RP39_SPI_PPS    _RP39R
#define RP40_SPI_PPS    _RP40R
#define RP41_SPI_PPS    _RP41R
#define RP42_SPI_PPS    _RP42R
#define RP43_SPI_PPS    _RP43R

/*Output PPS functions*/
#define SCK2 0x09
#define SDO2 0x08

#define  SEC_PRESCAL_1_1        0b111  /* Secondary Prescale 1:1   */
#define  SEC_PRESCAL_2_1        0b110  /* Secondary Prescale 2:1   */
#define  SEC_PRESCAL_3_1        0b101  /* Secondary Prescale 2:1   */
#define  SEC_PRESCAL_4_1        0b100  /* Secondary Prescale 4:1   */
#define  SEC_PRESCAL_5_1        0b011  /* Secondary Prescale 5:1   */
#define  SEC_PRESCAL_6_1        0b010  /* Secondary Prescale 6:1   */
#define  SEC_PRESCAL_7_1        0b001  /* Secondary Prescale 7:1   */
#define  SEC_PRESCAL_8_1        0b000  /* Secondary Prescale 8:1   */

#define  PRI_PRESCAL_1_1        0b11  /* Primary Prescale 1:1     */
#define  PRI_PRESCAL_4_1        0b10  /* Primary Prescale 4:1     */
#define  PRI_PRESCAL_16_1       0b01  /* Primary Prescale 16:1    */
#define  PRI_PRESCAL_64_1       0b00  /* Primary Prescale 64:1    */


static const uint8_t ppsOut[2] = {SCK2, SDO2};

static volatile uint8_t spi1Status = 1;
static volatile uint8_t spi2Status = 0;

// Buffered transaction support for SPI1
#define SPI1_BUFFER_SIZE 64
static uint8_t spi1_tx_buffer[SPI1_BUFFER_SIZE];
static uint8_t* spi1_rx_buffer_ptr = NULL;
static volatile uint8_t spi1_tx_index = 0;
static volatile uint8_t spi1_rx_index = 0;
static volatile uint8_t spi1_tx_length = 0;
static volatile uint8_t spi1_rx_length = 0;
static volatile uint8_t spi1_transaction_active = 0;
static volatile uint8_t spi1_transaction_complete = 1;

void spi1Init(void) {

    IFS0bits.SPI1IF = 0; // Clear the Interrupt flag
    IEC0bits.SPI1IE = 0; // Disable the interrupt

    SPI1CON1bits.DISSCK = 0; // Internal serial clock is enabled
    SPI1CON1bits.DISSDO = 0; // SDOx pin is controlled by the module
    SPI1CON1bits.MODE16 = 0; // Communication is word-wide (8 bits)
    SPI1CON1bits.MSTEN = 1; // Master mode enabled
    SPI1CON1bits.SMP = 0; // Input data is sampled at the middle of data output time
    SPI1CON1bits.CKE = 1; // Serial output data changes on transition from
    // active clock state to idle clock state
    SPI1CON1bits.CKP = 0; // Idle state for clock is a low level;

    SPI1CON2bits.SPIBEN = 1; /*Enable FIFO transmit buffer*/
    SPI1STATbits.SISEL = 0b001; /*interrupt on last bit out of shift register and FIFO empty*/

    /*11 = Primary prescale 1:1
      10 = Primary prescale 4:1
      01 = Primary prescale 16:1
      00 = Primary prescale 64:1*/
    SPI1CON1bits.PPRE = 0b01;

    /*111 = Secondary prescale 1:1
      110 = Secondary prescale 2:1
      101 = Secondary prescale 3:1
      100 = Secondary prescale 4:1
      011 = Secondary prescale 5:1
      010 = Secondary prescale 6:1
      001 = Secondary prescale 7:1
      000 = Secondary prescale 8:1*/
    SPI1CON1bits.SPRE = 0b100;


    IPC2bits.SPI1EIP = 1; //priority 5

    SPI1STATbits.SPIEN = 1; // Enable SPI module
    IEC0bits.SPI1IE = 1; // Enable the interrupt

}

uint8_t spi2Init(spi_pin_number CLK, spi_pin_number D_OUT) {

    //check duplicate pins
    if (CLK == D_OUT) {
        return 1;
    }

    //CLOCK and D_OUT
    spi_pin_number curPin[] = {CLK, D_OUT};

    int i = 0;
    for (i = 0; i < 2; i++) {
        switch (curPin[i]) {
            case RP20_SPI:
                RP20_SPI_PPS = ppsOut[i];
                break;
            case RP35_SPI:
                RP35_SPI_PPS = ppsOut[i];
                break;
            case RP36_SPI:
                RP36_SPI_PPS = ppsOut[i];
                break;
            case RP37_SPI:
                RP37_SPI_PPS = ppsOut[i];
                break;
            case RP38_SPI:
                RP38_SPI_PPS = ppsOut[i];
                break;
            case RP39_SPI:
                RP39_SPI_PPS = ppsOut[i];
                break;
            case RP40_SPI:
                RP40_SPI_PPS = ppsOut[i];
                break;
            case RP41_SPI:
                RP41_SPI_PPS = ppsOut[i];
                break;
            case RP42_SPI:
                RP42_SPI_PPS = ppsOut[i];
                break;
            case RP43_SPI:
                RP43_SPI_PPS = ppsOut[i];
                break;
            default:
                return 1;
                break;
        }
    }

    _SPI2IF = 0; // Clear the Interrupt flag
    _SPI2IE = 0; // Disable the interrupt

// This is hardcoding what was in the switch statement above. remove it.
//    _RP42R = 0x09; //pin 42 clock out
//    _RP43R = 0x08; //Dout to 43

    SPI2CON1bits.DISSCK = 0; /*clock enabled*/
    SPI2CON1bits.DISSDO = 0; /*Data out enabled*/
    SPI2CON1bits.MODE16 = 1; /*16 bit mode*/
    SPI2CON1bits.CKE = 1; /*data out changes on falling edge*/
    SPI2CON1bits.CKP = 0; /*active high clock*/
    SPI2CON1bits.MSTEN = 1; /*master mode enable*/

    SPI2STATbits.SPIEN = 1; /*Enable SPI module*/
    SPI2STATbits.SISEL = 0b101; /*interupt on last bit out*/

    _SPI2IF = 0; // Clear the Interrupt flag
    _SPI2IE = 1; // Enable the interrupt
    _SPI2IP = 5; // Set SPI2 interrupt priority

    return 0;
}

uint8_t spiTransfer(uint8_t byte) {
    spi1Status = 0;
    SPI1BUF = byte;
    while (!spi1Status) {
        ;
    }
    return (uint8_t) SPI1BUF;
}

void spi1Write(uint16_t input) {
    SPI1BUF = input;
}

uint8_t spi1Ready(void) {
    if(spi1Status == 1){
        spi1Status = 0;
        return 1;
    }
    return 0;;
}

void spi2Write(uint16_t input) {
    SPI2BUF = input;
}

uint8_t spi2Ready(void) {
    return spi2Status;
}

void __attribute__((__interrupt__, auto_psv)) _SPI1Interrupt(void) {
    _SPI1IF = 0; /* Clear the Interrupt flag*/
    
    // Handle buffered transactions
    if (spi1_transaction_active) {
        // Read all available bytes from RX FIFO
        while (!SPI1STATbits.SRXMPT && spi1_rx_index < spi1_rx_length) {
            if (spi1_rx_buffer_ptr == NULL ){
                volatile uint8_t dummy = (uint8_t)SPI1BUF;
                (void)dummy; // Suppress warning
            } else {
                spi1_rx_buffer_ptr[spi1_rx_index] = (uint8_t)SPI1BUF;
            }
            spi1_rx_index++;
        }
        
        // Fill TX FIFO with up to 4 bytes at once
        uint8_t max_tx_buf_index = 0;

        // while (!SPI1STATbits.SPITBF && (spi1_tx_index < spi1_tx_length)) {
        while (!SPI1STATbits.SPITBF && (max_tx_buf_index++ < 3) && (spi1_tx_index < spi1_tx_length)) {
            // Send actual data
            SPI1BUF = spi1_tx_buffer[spi1_tx_index];
            spi1_tx_index++;
        }
        
        // Check if transaction is complete
        if (spi1_tx_index >= spi1_tx_length && spi1_rx_index >= spi1_rx_length) {
            // Clear any remaining RX data if buffer is full or not needed
            while (!SPI1STATbits.SRXMPT) {
                volatile uint8_t dummy = (uint8_t)SPI1BUF;
                (void)dummy; // Suppress warning
            }
            spi1_transaction_active = 0;
            spi1_transaction_complete = 1;
        }
    } else {
        // Legacy mode for simple transfers
        spi1Status = 1;
        // Clear RX buffer
        while (!SPI1STATbits.SRXMPT) {
            volatile uint8_t dummy = (uint8_t)SPI1BUF;
            (void)dummy; // Suppress warning
        }
    }
}

void __attribute__((__interrupt__, auto_psv)) _SPI2Interrupt(void) {
    _SPI2IF = 0; /* Clear the Interrupt flag*/
    spi2Status = 1;
    uint16_t temp = SPI2BUF; /*clear input buffer because it just always fills up*/
    temp = 0; /*Suppress Warning*/
}

/******************************************************************************
 * Buffered Transaction Functions
 *******************************************************************************/

uint8_t spi1StartBufferedTransaction(const uint8_t* tx_buffer, uint8_t tx_length, 
                                    uint8_t* rx_buffer, uint8_t rx_length) {
    // Check if SPI is busy
    if (spi1_transaction_active) {
        return 0; // Busy
    } else {
        spi1ResetBufferedTransaction(); // Reset state before starting new transaction
    }
    
    // Validate parameters
    if (tx_buffer == NULL && tx_length > 0) {
        return 0; // Invalid parameters
    }
    
    if (tx_length > SPI1_BUFFER_SIZE) {
        return 0; // TX buffer too large
    }
    
    // Copy transmit data to internal buffer
    if (tx_buffer != NULL && tx_length > 0) {
        for (uint8_t i = 0; i < tx_length; i++) {
            spi1_tx_buffer[i] = tx_buffer[i];
        }
    }

    if (tx_length < rx_length){
        for (uint8_t i = tx_length; i < rx_length; i++) {
            spi1_tx_buffer[i] = 0xFF; // Fill remaining with dummy bytes
        }
        tx_length = rx_length;
    } else {
        rx_length = tx_length; // Ensure RX length matches TX length to avoid overflow
    }
    
    
    // Set up transaction parameters
    SPI1STATbits.SPIROV = 0; // Clear overflow flag
    spi1_tx_length = tx_length;
    spi1_rx_length = rx_length;
    spi1_rx_buffer_ptr = rx_buffer;
    spi1_tx_index = 0;
    spi1_rx_index = 0;
    spi1_transaction_complete = 0;
    
    // Start transaction
    spi1_transaction_active = 1;
    
    // Fill TX FIFO with up to 4 bytes to start transaction
    // While there are still bytes to send or if we need to send dummy bytes
    uint8_t max_tx_buf_index = 0;
    // while (!SPI1STATbits.SPITBF && (spi1_tx_index < spi1_tx_length)){
    while (!SPI1STATbits.SPITBF && (max_tx_buf_index++ < 3) && (spi1_tx_index < spi1_tx_length)){
        if (spi1_tx_index < spi1_tx_length) {
            // Send actual data
            SPI1BUF = spi1_tx_buffer[spi1_tx_index];
            spi1_tx_index++;
        }
    }
    
    return 1; // Success
}

uint8_t spi1IsBufferedTransactionComplete(void) {
    return spi1_transaction_complete;
}

uint8_t spi1GetBufferedTransactionResult(void) {
    if (spi1_transaction_complete) {
        spi1_transaction_complete = 0; // Clear flag
        return spi1_tx_index;
    }
    return 0;
}

void spi1ResetBufferedTransaction(void) {
    // Disable interrupts during reset to prevent race conditions
    uint8_t old_ie = IEC0bits.SPI1IE;
    IEC0bits.SPI1IE = 0;

    SPI1STATbits.SPIROV = 0; // Clear overflow flag
    
    // Reset all state variables
    spi1_transaction_active = 0;
    spi1_transaction_complete = 1;
    spi1_tx_index = 0;
    spi1_rx_index = 0;
    spi1_tx_length = 0;
    spi1_rx_length = 0;
    spi1_rx_buffer_ptr = NULL;
    
    // Clear SPI FIFOs
    while (!SPI1STATbits.SRXMPT) {
        volatile uint8_t dummy = (uint8_t)SPI1BUF;
        (void)dummy; // Suppress warning
    }
    
    // Clear any SPI error flags
    SPI1STATbits.SPIROV = 0; // Clear overflow flag
    
    // Clear interrupt flag
    IFS0bits.SPI1IF = 0;
    
    // Restore interrupt enable
    IEC0bits.SPI1IE = old_ie;
}

void spi1GetDebugState(uint8_t* tx_idx, uint8_t* rx_idx, uint8_t* tx_len, uint8_t* rx_len) {
    if (tx_idx) *tx_idx = spi1_tx_index;
    if (rx_idx) *rx_idx = spi1_rx_index;
    if (tx_len) *tx_len = spi1_tx_length;
    if (rx_len) *rx_len = spi1_rx_length;
}

