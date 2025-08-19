#include "can_iso_tp_lite.h"
#include "can_iso_tp_lite_config.h"
#include "./mcc_generated_files/boot/boot_config.h"
#include "ringBuffer.h"
#include <stddef.h>

typedef enum {
    SINGLE,
    FIRST,
    CONSECUTIVE,
    FLOW_CONTROL
} frametype_E;

typedef enum {
    CONTINUE_TO_SEND,
    WAIT,
    OVERFLOW_ABORT
} flowcontrol_E;

typedef enum {
    TX_IDLE,
    TX_WAIT_FLOW_CONTROL,
    TX_SENDING_CONSECUTIVE
} tx_state_E;

#define BLOCK_SIZE 0
#define SEPARATION_TIME 1

frametype_E currentFrameType = SINGLE;
uint16_t payloadIndex = 0;
uint8_t payloadMessage[64];
uint8_t consecutiveFrame_SN = 0;
uint16_t timeoutCounter = 0;
#define ISO_TP_TIMOUT 10

static tx_state_E txState = TX_IDLE;
static uint8_t* txPayload = NULL;
static uint16_t txLength = 0;
static uint16_t txBytesSent = 0;
static uint8_t txSequenceNumber = 1;
static uint8_t txBlockSize = 0;
static uint8_t txSeparationTime = 0;
static uint8_t txFramesInBlock = 0;
static uint16_t txSeparationCounter = 0;
static bool resetAfterTransmission = false;
static isoTP_command_S currentCommand={
    .command = ISO_TP_NONE,
    .payload = payloadMessage,
    .payloadLength = 0,
};

#define MESSAGE_BUFFER_SIZE 8
uint8_t actionBufferIndex = 0;
uint8_t actionBufferPointer = 0;
uint8_t(*actionBuffer[MESSAGE_BUFFER_SIZE])(void);


// Application size response payload for 0x0B command
static const uint8_t appSizeResponse[20] = {
    0x0B,  // Response command ID
    0x08,  // From response_1: byte3
    0x00,  // From response_1: byte4
    0x00,  // From response_1: byte5
    0x00,  // From response_1: byte6
    0x00,  // From response_1: byte7
    0x00,  // From response_2: byte1
    0x00,  // From response_2: byte2
    0x00,  // From response_2: byte3
    0x00,  // From response_2: byte4
    0x00,  // From response_2: byte5
    0x01,  // From response_2: byte6
    0x00,  // From response_2: byte7
    (uint8_t)(BOOT_CONFIG_PROGRAMMABLE_ADDRESS_LOW >> 8),       // From response_3: byte1
    (uint8_t)(BOOT_CONFIG_PROGRAMMABLE_ADDRESS_LOW & 0xFF),    // From response_3: byte2
    0x00,  // From response_3: byte3
    (uint8_t)(BOOT_CONFIG_PROGRAMMABLE_ADDRESS_HIGH & 0xFF),         // From response_3: byte4
    (uint8_t)((BOOT_CONFIG_PROGRAMMABLE_ADDRESS_HIGH >> 8) & 0xFF),  // From response_3: byte5
    (uint8_t)((BOOT_CONFIG_PROGRAMMABLE_ADDRESS_HIGH >> 16) & 0xFF), // From response_3: byte6
    (uint8_t)((BOOT_CONFIG_PROGRAMMABLE_ADDRESS_HIGH >> 24) & 0xFF)  // From response_3: byte7
};

uint8_t get_frame_payload(void);
uint8_t set_flow_control(void);
void decode_message(void);
void actionBufferPush(void * message);
uint8_t actionBufferPop(void);
uint8_t isoTP_Reset(void);
uint8_t isoTP_Sleep(void);
uint8_t isoTP_TesterPresent(void);
void handle_flow_control(void);
uint8_t send_consecutive_frame(void);
void reset_transmission_state(void);
uint8_t dummy_action(void);

void isoTP_init(void){
    currentFrameType = SINGLE;
    currentCommand.payloadLength = 0;
    payloadIndex = 0;
    consecutiveFrame_SN = 0;
    currentCommand.command = ISO_TP_NONE;
    timeoutCounter = 0;

    actionBufferIndex = 0;
    actionBufferPointer = 0;
    
    reset_transmission_state();
}

void run_iso_tp_1ms(void) {
    uint8_t messageComplete = 0;
    
    if (timeoutCounter++ > ISO_TP_TIMOUT) {
        isoTP_init();
    }
    
    if (txState == TX_SENDING_CONSECUTIVE) {
        if (txSeparationCounter > 0) {
            txSeparationCounter--;
        } else {
            actionBufferPush(send_consecutive_frame);
        }
    }

    if (CAN_boot_host_checkDataIsUnread()) {
        timeoutCounter = 0;
        //Switch statement based on bits 7...4 of the first byte in the CAN message
        uint16_t code = CAN_boot_host_code_get();
        switch (code) {
            case SINGLE:
                currentFrameType = SINGLE;
                //payload side here is from the 3...0 bits of the first byte.
                currentCommand.payloadLength = CAN_boot_host_type_get();
                if (currentCommand.payloadLength == 0) {
                    break;
                }
                payloadIndex = 0;
                messageComplete = get_frame_payload();
                break;
            case FIRST:
                currentFrameType = FIRST;
                currentCommand.payloadLength = (CAN_boot_host_type_get() << 8) | CAN_boot_host_getBytesFp[0]();
                if (currentCommand.payloadLength == 0) {
                    break;
                }
                payloadIndex = 0;
                consecutiveFrame_SN = 1;
                messageComplete = get_frame_payload();
                actionBufferPush(set_flow_control);
                break;
            case CONSECUTIVE:
                currentFrameType = CONSECUTIVE;
                if (consecutiveFrame_SN != CAN_boot_host_type_get()) {
                    consecutiveFrame_SN = 0;
                    break;
                }
                consecutiveFrame_SN++;
                if (consecutiveFrame_SN > 15) {
                    consecutiveFrame_SN = 0;
                }
                messageComplete = get_frame_payload();
                break;
            case FLOW_CONTROL:
                if (txState == TX_WAIT_FLOW_CONTROL) {
                    handle_flow_control();
                }
                break;
            default:
                break;
        }
        if (messageComplete) {
            decode_message();
        }
    }
    //If there is anything in the payload buffer, send it.
    actionBufferPop();
}

isoTP_command_E isoTP_peekCommand(void) {
    return currentCommand.command;
}

isoTP_command_S isoTP_getCommand(void) {
    isoTP_command_S thisCommand = currentCommand;
    currentCommand.command = ISO_TP_NONE;
    return thisCommand;
}

uint8_t set_flow_control(void) {
    CAN_boot_response_type_set(0);
    CAN_boot_response_code_set(FLOW_CONTROL);
    CAN_boot_response_byte1_set(BLOCK_SIZE);
    CAN_boot_response_byte2_set(SEPARATION_TIME);
    CAN_boot_response_byte3_set(0x55);
    CAN_boot_response_byte4_set(0x55);
    CAN_boot_response_byte5_set(0x55);
    CAN_boot_response_byte6_set(0x55);
    CAN_boot_response_byte7_set(0x55);
    CAN_boot_response_dlc_set(3);
    CAN_boot_response_send();
    currentCommand.command = ISO_TP_NONE;
    return currentCommand.command;
}


uint8_t dummy_action(void) {
    // This function does nothing, used as a placeholder
    return 0;
}

uint8_t isoTP_Reset(void) {
    currentCommand.command = ISO_TP_RESET;
    //asm ("reset");
    return currentCommand.command;
}

uint8_t isoTP_Sleep(void) {
    currentCommand.command = ISO_TP_SLEEP;
    return currentCommand.command;
}

uint8_t isoTP_IOControl(void) {
    CAN_boot_response_type_set(7);
    CAN_boot_response_code_set(SINGLE);
    CAN_boot_response_byte1_set(0x00);
    CAN_boot_response_byte2_set(0x01);
    CAN_boot_response_byte3_set(0x02);
    CAN_boot_response_byte4_set(0x03);
    CAN_boot_response_byte5_set(0x04);
    CAN_boot_response_byte6_set(0x05);
    CAN_boot_response_byte7_set(0x06);
    CAN_boot_response_dlc_set(8);
    CAN_boot_response_send();
    currentCommand.command = ISO_TP_IO_CONTROL;
    return currentCommand.command;
}

uint8_t isoTP_TesterPresent(void) {
    CAN_boot_response_type_set(2);
    CAN_boot_response_code_set(SINGLE);
    CAN_boot_response_byte1_set(0x7E);
    CAN_boot_response_byte2_set(0x00);
    CAN_boot_response_byte3_set(0x55);
    CAN_boot_response_byte4_set(0x55);
    CAN_boot_response_byte5_set(0x55);
    CAN_boot_response_byte6_set(0x55);
    CAN_boot_response_byte7_set(0x55);
    CAN_boot_response_dlc_set(3);
    CAN_boot_response_send();
    currentCommand.command = ISO_TP_TESTER_PRESENT;
    return currentCommand.command;
}

uint8_t get_frame_payload(void) {
    uint8_t byteIndex = 0;
    uint8_t payloadMaxSizeBytes = 7;
    if (currentFrameType == FIRST) {
        payloadMaxSizeBytes = 6;
        byteIndex = 1;
    }
    while (payloadIndex < currentCommand.payloadLength) {
        payloadMessage[payloadIndex++] = CAN_boot_host_getBytesFp[byteIndex++]();
        if (byteIndex >= payloadMaxSizeBytes) {
            break;
        }
    }
    if (payloadIndex == currentCommand.payloadLength) {
        return 1;
    }
    return 0;
}

void decode_message(void) {
    
    switch(payloadMessage[0]){
        case 0x0A:
            actionBufferPush(isoTP_Sleep);
            break;
        case 0x0B:
            if (currentFrameType == SINGLE) {
                actionBufferPush(isoTP_Reset);
            } else {
            isoTP_SendData((uint8_t*)appSizeResponse, sizeof(appSizeResponse));
            resetAfterTransmission = true;
            }
            break;
        case 0x0C:
            actionBufferPush(isoTP_IOControl);
            break;
        case 0x0D:
            actionBufferPush(isoTP_TesterPresent);
            break;
    }
}

void actionBufferPush(void * message) {
    actionBuffer[actionBufferPointer++] = message;
    if (actionBufferPointer > MESSAGE_BUFFER_SIZE - 1) {
        actionBufferPointer = 0;
    }
}

uint8_t actionBufferPop(void) {
    uint8_t returnVal = 0;
    if (actionBufferPointer != actionBufferIndex) {
        returnVal = actionBuffer[actionBufferIndex++]();
    }
    if (actionBufferIndex > MESSAGE_BUFFER_SIZE - 1) {
        actionBufferIndex = 0;
    }

    return returnVal;
}

uint8_t isoTP_SendSingle(uint8_t* payload, uint8_t length) {
    if (length == 0 || length > 7 || payload == NULL) {
        return 0;
    }
    
    CAN_boot_response_type_set(length);
    CAN_boot_response_code_set(SINGLE);
    
    for (uint8_t i = 0; i < length && i < 7; i++) {
        switch(i) {
            case 0: CAN_boot_response_byte1_set(payload[i]); break;
            case 1: CAN_boot_response_byte2_set(payload[i]); break;
            case 2: CAN_boot_response_byte3_set(payload[i]); break;
            case 3: CAN_boot_response_byte4_set(payload[i]); break;
            case 4: CAN_boot_response_byte5_set(payload[i]); break;
            case 5: CAN_boot_response_byte6_set(payload[i]); break;
            case 6: CAN_boot_response_byte7_set(payload[i]); break;
        }
    }
    
    for (uint8_t i = length; i < 7; i++) {
        switch(i) {
            case 0: CAN_boot_response_byte1_set(0x55); break;
            case 1: CAN_boot_response_byte2_set(0x55); break;
            case 2: CAN_boot_response_byte3_set(0x55); break;
            case 3: CAN_boot_response_byte4_set(0x55); break;
            case 4: CAN_boot_response_byte5_set(0x55); break;
            case 5: CAN_boot_response_byte6_set(0x55); break;
            case 6: CAN_boot_response_byte7_set(0x55); break;
        }
    }
    
    CAN_boot_response_dlc_set(length + 1);
    CAN_boot_response_send();
    
    return 1;
}

uint8_t isoTP_SendData(uint8_t* payload, uint16_t length) {
    if (length == 0 || payload == NULL || txState != TX_IDLE) {
        return 0;
    }
    
    if (length <= 7) {
        return isoTP_SendSingle(payload, length);
    }
    
    txPayload = payload;
    txLength = length;
    txBytesSent = 0;
    txSequenceNumber = 1;
    txFramesInBlock = 0;
    
    CAN_boot_response_type_set((length >> 8) & 0x0F);
    CAN_boot_response_code_set(FIRST);
    CAN_boot_response_byte1_set(length & 0xFF);
    
    for (uint8_t i = 0; i < 6 && txBytesSent < length; i++, txBytesSent++) {
        switch(i) {
            case 0: CAN_boot_response_byte2_set(payload[txBytesSent]); break;
            case 1: CAN_boot_response_byte3_set(payload[txBytesSent]); break;
            case 2: CAN_boot_response_byte4_set(payload[txBytesSent]); break;
            case 3: CAN_boot_response_byte5_set(payload[txBytesSent]); break;
            case 4: CAN_boot_response_byte6_set(payload[txBytesSent]); break;
            case 5: CAN_boot_response_byte7_set(payload[txBytesSent]); break;
        }
    }
    
    CAN_boot_response_dlc_set(8);
    CAN_boot_response_send();
    
    txState = TX_WAIT_FLOW_CONTROL;
    
    return 1;
}

void reset_transmission_state(void) {
    txState = TX_IDLE;
    txPayload = NULL;
    txLength = 0;
    txBytesSent = 0;
    txSequenceNumber = 1;
    txBlockSize = 0;
    txSeparationTime = 0;
    txFramesInBlock = 0;
    txSeparationCounter = 0;
    resetAfterTransmission = false;
}

void handle_flow_control(void) {
    uint8_t flowStatus = CAN_boot_host_type_get();
    
    switch(flowStatus) {
        case CONTINUE_TO_SEND:
            txBlockSize = CAN_boot_host_getBytesFp[0]();
            txSeparationTime = CAN_boot_host_getBytesFp[1]();
            txFramesInBlock = 0;
            
            if (txSeparationTime > 0 && txSeparationTime <= 0x7F) {
                txSeparationCounter = txSeparationTime;
            } else {
                txSeparationCounter = 0;
            }
            
            txState = TX_SENDING_CONSECUTIVE;
            
            if (txSeparationCounter == 0) {
                actionBufferPush(send_consecutive_frame);
            }
            break;
            
        case WAIT:
            break;
            
        case OVERFLOW_ABORT:
        default:
            reset_transmission_state();
            break;
    }
}

uint8_t send_consecutive_frame(void) {
    if (txState != TX_SENDING_CONSECUTIVE || txBytesSent > txLength) {
        reset_transmission_state();
        return 0;
    }
    
    CAN_boot_response_type_set(txSequenceNumber);
    CAN_boot_response_code_set(CONSECUTIVE);
    
    uint8_t bytesThisFrame = 0;
    for (uint8_t i = 0; i < 7 && txBytesSent < txLength; i++, txBytesSent++, bytesThisFrame++) {
        switch(i) {
            case 0: CAN_boot_response_byte1_set(txPayload[txBytesSent]); break;
            case 1: CAN_boot_response_byte2_set(txPayload[txBytesSent]); break;
            case 2: CAN_boot_response_byte3_set(txPayload[txBytesSent]); break;
            case 3: CAN_boot_response_byte4_set(txPayload[txBytesSent]); break;
            case 4: CAN_boot_response_byte5_set(txPayload[txBytesSent]); break;
            case 5: CAN_boot_response_byte6_set(txPayload[txBytesSent]); break;
            case 6: CAN_boot_response_byte7_set(txPayload[txBytesSent]); break;
        }
    }
    
    for (uint8_t i = bytesThisFrame; i < 7; i++) {
        switch(i) {
            case 0: CAN_boot_response_byte1_set(0x55); break;
            case 1: CAN_boot_response_byte2_set(0x55); break;
            case 2: CAN_boot_response_byte3_set(0x55); break;
            case 3: CAN_boot_response_byte4_set(0x55); break;
            case 4: CAN_boot_response_byte5_set(0x55); break;
            case 5: CAN_boot_response_byte6_set(0x55); break;
            case 6: CAN_boot_response_byte7_set(0x55); break;
        }
    }
    
    CAN_boot_response_dlc_set(8);
    CAN_boot_response_send();
    
    txSequenceNumber++;
    if (txSequenceNumber > 15) {
        txSequenceNumber = 0;
    }
    
    txFramesInBlock++;
    
    if (txBytesSent >= txLength) {

        
        // Check if we need to reset after transmission is complete
        if (resetAfterTransmission) {
            resetAfterTransmission = false;
            actionBufferPush(isoTP_Reset);
        }

        reset_transmission_state();
        
        return 1;
    }
    
    if (txBlockSize > 0 && txFramesInBlock >= txBlockSize) {
        txState = TX_WAIT_FLOW_CONTROL;
        return 1;
    }
    
    if (txSeparationTime > 0 && txSeparationTime <= 0x7F) {
        txSeparationCounter = txSeparationTime;
    } else {
        actionBufferPush(send_consecutive_frame);
    }
    
    return 1;
}
