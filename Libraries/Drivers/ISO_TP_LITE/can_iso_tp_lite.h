/* 
 * File:   can_iso_tp.h
 * Author: kid group
 *
 * Created on April 19, 2022, 12:35 AM
 */

#ifndef CAN_ISO_TP_H
#define	CAN_ISO_TP_H

#include <stdint.h>

typedef enum {
    ISO_TP_NONE,
    ISO_TP_RESET,
    ISO_TP_SLEEP,
    ISO_TP_IO_CONTROL,
    ISO_TP_TESTER_PRESENT
} isoTP_command_E;

typedef struct isoTP_command_S{
    isoTP_command_E command;
    uint8_t * payload;
    uint8_t payloadLength;
} isoTP_command_S;

void isoTP_init(void);
void run_iso_tp_1ms(void);
isoTP_command_E isoTP_peekCommand(void);
isoTP_command_S isoTP_getCommand(void);
uint8_t isoTP_SendSingle(uint8_t* payload, uint8_t length);
uint8_t isoTP_SendData(uint8_t* payload, uint16_t length);
#endif	/* CAN_ISO_TP_H */

