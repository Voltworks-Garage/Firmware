#include <stdio.h>
#include <assert.h>
#include <string.h>
#include "can_iso_tp_lite.h"

extern void test_set_fake_frame(uint8_t frameType, const uint8_t *data, uint8_t len);

void test_single_frame_command() {
    isoTP_init();
    uint8_t payload[7] = { 0x0D, 0xAA, 0xBB };  // Tester Present command

    test_set_fake_frame(0x00, payload, 3);  // SINGLE frame

    assert(run_iso_tp_basic() == ISO_TP_TESTER_PRESENT);
    assert(isoTP_getCommand() == ISO_TP_TESTER_PRESENT);
    assert(get_payloadLength() == 3);
    assert(get_payload()[0] == 0x0D);
    printf("test_single_frame_command passed\n");
}

void test_payload_storage_across_frames() {
    isoTP_init();

    // FIRST frame: type=0x10, len=9, first byte = 0x0B (Reset command)
    uint8_t first[7] = { 0x0B, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06 };
    test_set_fake_frame(0x10, first, 7);
    run_iso_tp_basic();

    // CONSECUTIVE frame: type=0x21, 3 more bytes
    uint8_t next[3] = { 0x07, 0x08, 0x09 };
    test_set_fake_frame(0x21, next, 3);
    assert(run_iso_tp_basic() == ISO_TP_RESET);

    assert(get_payloadLength() == 9);
    const uint8_t *pl = get_payload();
    for (int i = 0; i < 9; i++) {
        assert(pl[i] == i + 0x0B);  // should be 0x0B to 0x13
    }

    printf("test_payload_storage_across_frames passed\n");
}

int main() {
    test_single_frame_command();
    test_payload_storage_across_frames();
    printf("✅ All ISO-TP unit tests passed\n");
    return 0;
}
