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


// Public API Functions
void CommandService_Init(void);
void CommandService_Run(void);
void CommandService_SendResponse(uint8_t responseCode, uint8_t* data, uint8_t dataLength);

#endif /* COMMAND_SERVICE_H */