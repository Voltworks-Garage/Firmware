/**
  Generated main.c file from MPLAB Code Configurator

  @Company
    Microchip Technology Inc.
 */

#include <xc.h>
#include "system.h"
#include "mcc_generated_files/clock.h"
#include "tsk.h"

/**
  @Summary
    This is the generated main.c using PIC24 / dsPIC33 / PIC32MM MCUs.

  @Description
    This source file provides main entry point for system initialization and application code development.
    Generation Information :
        Product Revision  :  PIC24 / dsPIC33 / PIC32MM MCUs - 1.171.1
        Device            :  dsPIC33EP256MC506
    The generated drivers are tested against the following:
        Compiler          :  XC16 v1.70
        MPLAB 	          :  MPLAB X v5.50
 */
int main(void) {
    
    SYSTEM_Initialize();

    Tsk_Run(CLOCK_SystemFrequencyGet());

    while (1) {
    }

    return (0);
}

