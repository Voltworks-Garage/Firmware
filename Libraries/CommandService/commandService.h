/* 
 * File:   commandService.h
 * Author: Claude/Voltworks
 * 
 * Command Service - Core Interface
 * 
 * This service provides a configurable bridge between ISO-TP commands
 * and project-specific IO operations. Each project implements its own
 * commandService_config.h with function pointer arrays.
 *
 * Created: 2025-07-06
 */

#ifndef COMMAND_SERVICE_H
#define COMMAND_SERVICE_H

#include <stdint.h>

typedef enum {
    COMMAND_SERVICE_TYPE_NONE = 0,
    COMMAND_SERVICE_TYPE_IO_CONTROL,
    COMMAND_SERVICE_TYPE_RESET,
    COMMAND_SERVICE_TYPE_SLEEP,
    COMMAND_SERVICE_TYPE_TESTER_PRESENT,
    COMMAND_SERVICE_TYPE_MAX
} CommandService_Type_E;

// Public API Functions
void CommandService_Init(void);
void CommandService_Run(void);
void CommandService_SendResponse(uint8_t responseCode, uint8_t* data, uint8_t dataLength);
CommandService_Type_E CommandService_GetEvent(void);

#endif /* COMMAND_SERVICE_H */