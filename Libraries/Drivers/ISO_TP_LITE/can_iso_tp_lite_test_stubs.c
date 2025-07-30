#include <stdint.h>
#include <string.h>

// Fake CAN input frame
static uint8_t fakeFrame[8] = {0};
static uint8_t fakeFrameLen = 0;
static uint8_t fakeFrameType = 0x00;
static uint8_t byteReadIndex = 0;

uint8_t CAN_boot_host_checkDataIsUnread(void) {
    return 1;  // always say data is unread
}

uint16_t CAN_boot_host_code_get(void) {
    return fakeFrameType >> 4;
}

uint8_t CAN_boot_host_type_get(void) {
    return fakeFrameType & 0x0F;
}

uint8_t CAN_boot_host_getByte0(void) { return fakeFrame[0]; }
uint8_t CAN_boot_host_getByte1(void) { return fakeFrame[1]; }
uint8_t CAN_boot_host_getByte2(void) { return fakeFrame[2]; }
uint8_t CAN_boot_host_getByte3(void) { return fakeFrame[3]; }
uint8_t CAN_boot_host_getByte4(void) { return fakeFrame[4]; }
uint8_t CAN_boot_host_getByte5(void) { return fakeFrame[5]; }
uint8_t CAN_boot_host_getByte6(void) { return fakeFrame[6]; }

uint8_t (*CAN_boot_host_getBytesFp[7])(void) = {
    CAN_boot_host_getByte0,
    CAN_boot_host_getByte1,
    CAN_boot_host_getByte2,
    CAN_boot_host_getByte3,
    CAN_boot_host_getByte4,
    CAN_boot_host_getByte5,
    CAN_boot_host_getByte6
};

// Helper to inject test frame
void test_set_fake_frame(uint8_t frameType, const uint8_t *data, uint8_t len) {
    fakeFrameType = frameType;
    fakeFrameLen = len > 7 ? 7 : len;
    memcpy(fakeFrame, data, fakeFrameLen);
    byteReadIndex = 0;
}

// Stubbed CAN response functions
void CAN_boot_response_type_set(uint8_t x) {}
void CAN_boot_response_code_set(uint8_t x) {}
void CAN_boot_response_byte1_set(uint8_t x) {}
void CAN_boot_response_byte2_set(uint8_t x) {}
void CAN_boot_response_byte3_set(uint8_t x) {}
void CAN_boot_response_byte4_set(uint8_t x) {}
void CAN_boot_response_byte5_set(uint8_t x) {}
void CAN_boot_response_byte6_set(uint8_t x) {}
void CAN_boot_response_byte7_set(uint8_t x) {}
void CAN_boot_response_dlc_set(uint8_t x) {}
void CAN_boot_response_send(void) {}
