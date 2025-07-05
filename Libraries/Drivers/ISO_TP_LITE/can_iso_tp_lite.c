#include "can_iso_tp_lite.h"
#include "can_iso_tp_lite_config.h"
#include "./mcc_generated_files/boot/boot_config.h"
#include "ringBuffer.h"

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

#define BLOCK_SIZE 0
#define SEPARATION_TIME 1

frametype_E currentFrameType = SINGLE;
uint16_t payloadIndex = 0;
uint8_t payloadMessage[64];
uint8_t consecutiveFrame_SN = 0;
uint16_t timeoutCounter = 0;
#define ISO_TP_TIMOUT 10
static isoTP_command_S currentCommand={
    .command = ISO_TP_NONE,
    .payload = payloadMessage,
    .payloadLength = 0,
};

#define MESSAGE_BUFFER_SIZE 8
uint8_t actionBufferIndex = 0;
uint8_t actionBufferPointer = 0;
uint8_t(*actionBuffer[MESSAGE_BUFFER_SIZE])(void);

uint8_t get_frame_payload(void);
uint8_t set_flow_control(void);
void decode_message(void);
void actionBufferPush(void * message);
uint8_t actionBufferPop(void);
uint8_t isoTP_Reset(void);
uint8_t isoTP_Sleep(void);
uint8_t isoTP_TesterPresent(void);

void isoTP_init(void){
    currentFrameType = SINGLE;
    currentCommand.payloadLength = 0;
    payloadIndex = 0;
    consecutiveFrame_SN = 0;
    currentCommand.command = ISO_TP_NONE;
    timeoutCounter = 0;

    actionBufferIndex = 0;
    actionBufferPointer = 0;
}

void run_iso_tp_1ms(void) {
    uint8_t messageComplete = 0;
    
    if (timeoutCounter++ > ISO_TP_TIMOUT) {
        isoTP_init();
    }

    if (CAN_boot_host_checkDataIsFresh()) {
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

uint8_t set_app_size_response_1(void) {
    CAN_boot_response_type_set(0);
    CAN_boot_response_code_set(FIRST);
    CAN_boot_response_byte1_set(0x14);
    CAN_boot_response_byte2_set(0x0B);
    CAN_boot_response_byte3_set(0x08);
    CAN_boot_response_byte4_set(0x00);
    CAN_boot_response_byte5_set(0x00);
    CAN_boot_response_byte6_set(0x00);
    CAN_boot_response_byte7_set(0x00);
    CAN_boot_response_dlc_set(8);
    CAN_boot_response_send();
    currentCommand.command = ISO_TP_NONE;
    return currentCommand.command;
}

uint8_t set_app_size_response_2(void) {
    CAN_boot_response_type_set(1);
    CAN_boot_response_code_set(CONSECUTIVE);
    CAN_boot_response_byte1_set(0x00);
    CAN_boot_response_byte2_set(0x00);
    CAN_boot_response_byte3_set(0x00);
    CAN_boot_response_byte4_set(0x00);
    CAN_boot_response_byte5_set(0x00);
    CAN_boot_response_byte6_set(0x01);
    CAN_boot_response_byte7_set(0x00);
    CAN_boot_response_send();
    currentCommand.command = ISO_TP_NONE;
    return currentCommand.command;
}

uint8_t set_app_size_response_3(void) {
    CAN_boot_response_type_set(2);
    CAN_boot_response_code_set(CONSECUTIVE);
    CAN_boot_response_byte1_set(BOOT_CONFIG_PROGRAMMABLE_ADDRESS_LOW >> 8);
    CAN_boot_response_byte2_set(BOOT_CONFIG_PROGRAMMABLE_ADDRESS_LOW & 0xFF);
    CAN_boot_response_byte3_set(0x00);
    CAN_boot_response_byte4_set(BOOT_CONFIG_PROGRAMMABLE_ADDRESS_HIGH & 0xFF);
    CAN_boot_response_byte5_set(BOOT_CONFIG_PROGRAMMABLE_ADDRESS_HIGH >> 8 & 0xFF);
    CAN_boot_response_byte6_set(BOOT_CONFIG_PROGRAMMABLE_ADDRESS_HIGH >> 16 & 0xFF);
    CAN_boot_response_byte7_set(BOOT_CONFIG_PROGRAMMABLE_ADDRESS_HIGH >> 24 & 0xFF);
    CAN_boot_response_send();
    currentCommand.command = ISO_TP_NONE;
    return currentCommand.command;
}

uint8_t isoTP_Reset(void) {
    currentCommand.command = ISO_TP_RESET;
    asm ("reset");
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
    CAN_boot_response_send();
    currentCommand.command = ISO_TP_IO_CONTROL;
    return currentCommand.command;
}

uint8_t isoTP_TesterPresent(void) {
    CAN_boot_response_type_set(7);
    CAN_boot_response_code_set(SINGLE);
    CAN_boot_response_byte1_set(0x0A);
    CAN_boot_response_byte2_set(0x0B);
    CAN_boot_response_byte3_set(0x0C);
    CAN_boot_response_byte4_set(0x0D);
    CAN_boot_response_byte5_set(0x0E);
    CAN_boot_response_byte6_set(0x0F);
    CAN_boot_response_byte7_set(0x0F);
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
            actionBufferPush(set_app_size_response_1);
            actionBufferPush(set_app_size_response_2);
            actionBufferPush(set_app_size_response_3);
            actionBufferPush(isoTP_Reset);
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
