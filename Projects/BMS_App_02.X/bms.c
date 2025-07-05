/*
 * File:   LTC6802_.c
 * Author: zachleedogg
 *
 * Created on May 10, 2022, 9:14 PM
 */


#include "ltc_6802.h"
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
    static uint8_t state = 0;
    switch(state){
        case 0:
            LTC6802_StartAllTempADC();
            state++;
            break;
        case 1:
            if (LTC6802_check_ADC_status()){
                LTC6802_ReadAllTempADC();
                state++;
            }
            break;
        case 2:
            LTC6802_set_cell_discharge(3,0);
            LTC6802_writeConfig();
            LTC6802_StartAllCellADC();
            state++;
            break;
        case 3:
            if (LTC6802_check_ADC_status()){
                LTC6802_set_cell_discharge(3,0);
                LTC6802_writeConfig();
                LTC6802_ReadAllCellADC();
                state++;
            }
        default:
            state = 0;
            break;
    }
}

void BMS_Run_1000ms(void){
    ;
}