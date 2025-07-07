/*
 * File:   LTC6802_.c
 * Author: zachleedogg
 *
 * Created on May 10, 2022, 9:14 PM
 */


#include "ltc6802.h"
#include <stdint.h>

void BMS_Init(void){
    LTC6802_Init();
    LTC6802_set_CDC(1);
    LTC6802_set_CELL10(0);
    LTC6802_set_LVPL(1);
    LTC6802_set_GPIO1(0,0);
    LTC6802_set_GPIO2(0,1);
    LTC6802_set_GPIO1(1,0);
    LTC6802_set_GPIO2(1,1);
//    LTC6802_set_cell_discharge(0);
//    LTC6802_set_MCI(0);
    LTC6802_set_VUV(2.3);
    LTC6802_set_VOV(4.2);
    LTC6802_writeConfig();
    LTC6802_writeConfig();
}

void BMS_Run_10ms(void){
    LTC6802_writeConfig();
    static uint8_t bms_currentState = 0;
    switch(bms_currentState){
        case 0:
            LTC6802_StartAllTempADC();
            bms_currentState++;
            break;
        case 1:
            if (LTC6802_check_ADC_status()){
                LTC6802_ReadAllTempADC();
                bms_currentState++;
            }
            break;
        case 2:
            LTC6802_set_cell_discharge(3,0);
            LTC6802_writeConfig();
            LTC6802_StartAllCellADC();
            bms_currentState++;
            break;
        case 3:
            if (LTC6802_check_ADC_status()){
                LTC6802_set_cell_discharge(3,0);
                LTC6802_writeConfig();
                LTC6802_ReadAllCellADC();
                bms_currentState++;
            }
        default:
            bms_currentState = 0;
            break;
    }
}

void BMS_Run_1000ms(void){
    ;
}