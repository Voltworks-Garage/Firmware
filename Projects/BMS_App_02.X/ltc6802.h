/* 
 * File:   
 * Author: 
 * Comments:
 * Revision history: 
 */

// This is a guard condition so that contents of this file are not included
// more than once.  
#ifndef LTC6802_H
#define	LTC6802_H

#include <stdint.h>

void LTC6802_Init(void);

void LTC6802_set_CDC(uint8_t cdc);
void LTC6802_set_CELL10(uint8_t cell10);
void LTC6802_set_LVPL(uint8_t lvpl);
void LTC6802_set_GPIO1(uint8_t chipAddress, uint8_t gpio1);
void LTC6802_set_GPIO2(uint8_t chipAddress, uint8_t gpio2);
void LTC6802_set_cell_discharge(uint8_t cell, uint8_t value);
void LTC6802_set_MCI(uint8_t cell);
void LTC6802_set_VUV(float underVoltage);
void LTC6802_set_VOV(float overVoltage);

void LTC6802_writeConfig(void);
void LTC6802_StartAllCellADC(void);
void LTC6802_StartAllTempADC(void);
uint8_t LTC6802_check_ADC_status(void);
uint8_t LTC6802_ReadAllCellADC(void);
uint8_t LTC6802_ReadAllTempADC(void);
float LTC6802_get_cell_voltage(uint8_t cell);
float LTC6802_get_temp_voltage(uint8_t temp);


uint8_t LTC6802_AddressReadCommand(uint8_t address, uint8_t command, uint8_t len, uint8_t * recieveData);
void LTC6802_AddressWriteCommand(uint8_t address, uint8_t command, uint8_t len, uint8_t * transmitData);

#endif	/* LTC6802_H */

