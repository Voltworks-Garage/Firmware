/**
  System Traps Generated Driver File 

  @Company:
    Microchip Technology Inc.

  @File Name:
    traps.h

  @Summary:
    This is the generated driver implementation file for handling traps
    using PIC24 / dsPIC33 / PIC32MM MCUs

  @Description:
    This source file provides implementations for PIC24 / dsPIC33 / PIC32MM MCUs traps.
    Generation Information : 
        Product Revision  :  PIC24 / dsPIC33 / PIC32MM MCUs - 1.171.5
        Device            :  dsPIC33EP256MC506
    The generated drivers are tested against the following:
        Compiler          :  XC16 v2.10
        MPLAB             :  MPLAB X v6.05
*/
/*
    (c) 2020 Microchip Technology Inc. and its subsidiaries. You may use this
    software and any derivatives exclusively with Microchip products.

    THIS SOFTWARE IS SUPPLIED BY MICROCHIP "AS IS". NO WARRANTIES, WHETHER
    EXPRESS, IMPLIED OR STATUTORY, APPLY TO THIS SOFTWARE, INCLUDING ANY IMPLIED
    WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY, AND FITNESS FOR A
    PARTICULAR PURPOSE, OR ITS INTERACTION WITH MICROCHIP PRODUCTS, COMBINATION
    WITH ANY OTHER PRODUCTS, OR USE IN ANY APPLICATION.

    IN NO EVENT WILL MICROCHIP BE LIABLE FOR ANY INDIRECT, SPECIAL, PUNITIVE,
    INCIDENTAL OR CONSEQUENTIAL LOSS, DAMAGE, COST OR EXPENSE OF ANY KIND
    WHATSOEVER RELATED TO THE SOFTWARE, HOWEVER CAUSED, EVEN IF MICROCHIP HAS
    BEEN ADVISED OF THE POSSIBILITY OR THE DAMAGES ARE FORESEEABLE. TO THE
    FULLEST EXTENT ALLOWED BY LAW, MICROCHIP'S TOTAL LIABILITY ON ALL CLAIMS IN
    ANY WAY RELATED TO THIS SOFTWARE WILL NOT EXCEED THE AMOUNT OF FEES, IF ANY,
    THAT YOU HAVE PAID DIRECTLY TO MICROCHIP FOR THIS SOFTWARE.

    MICROCHIP PROVIDES THIS SOFTWARE CONDITIONALLY UPON YOUR ACCEPTANCE OF THESE
    TERMS.
*/

/**
    Section: Includes
*/
#include <xc.h>
#include <stdio.h>
#include "traps.h"

/* To identify the source of the trap, or the address of the source code causing the trap, please uncomment the
  following line. When the code is executed by uncommenting the below line, the trapSrcAddr variable will contain
  the address of the source code that, in the event that a trap occurs, is causing.*/

/* #define FIND_TRAP_SOURCE */

#ifdef FIND_TRAP_SOURCE
extern unsigned long trapSrcAddr;
void __attribute__((interrupt(preprologue( "rcall _where_was_i ")), no_auto_psv)) _DefaultInterrupt(void)
{
   fprintf(stderr, "Trap! @ 0x%8.8lx\n ", trapSrcAddr);
   while(1);
}
#else
#define ERROR_HANDLER __attribute__((weak, interrupt,no_auto_psv))
#define FAILSAFE_STACK_GUARDSIZE 8
#define FAILSAFE_STACK_SIZE 32

/**
 * a private place to store the error code if we run into a severe error
 */
static uint16_t TRAPS_error_code = -1;

/**
 * Halts 
 * 
 * @param code error code
 */
void __attribute__((weak)) TRAPS_halt_on_error(uint16_t code)
{
    TRAPS_error_code = code;
#ifdef __DEBUG    
    /* If we are in debug mode, cause a software breakpoint in the debugger */
    __builtin_software_breakpoint();
    while(1)
    {
    }
#else
    // Trigger software reset
    __asm__ volatile ("reset");
#endif
    
}

/**
 * Sets the stack pointer to a backup area of memory, in case we run into
 * a stack error (in which case we can't really trust the stack pointer)
 */
inline static void use_failsafe_stack(void)
{
    static uint8_t failsafe_stack[32];
    asm volatile (
        "   mov    %[pstack], W15\n"
        :
        : [pstack]"r"(failsafe_stack)
    );
/* Controls where the stack pointer limit is, relative to the end of the
 * failsafe stack
 */    
    SPLIM = (uint16_t)(((uint8_t *)failsafe_stack) + sizeof(failsafe_stack) 
            - FAILSAFE_STACK_GUARDSIZE);
}


/** Oscillator Fail Trap vector**/
void ERROR_HANDLER _OscillatorFail(void)
{
    INTCON1bits.OSCFAIL = 0;  //Clear the trap flag
    TRAPS_halt_on_error(TRAPS_OSC_FAIL);
}
/** Stack Error Trap Vector**/
void ERROR_HANDLER _StackError(void)
{
    /* We use a failsafe stack: the presence of a stack-pointer error
     * means that we cannot trust the stack to operate correctly unless
     * we set the stack pointer to a safe place.
     */
    use_failsafe_stack(); 
    INTCON1bits.STKERR = 0;  //Clear the trap flag
    TRAPS_halt_on_error(TRAPS_STACK_ERR);
}
/** Address error Trap vector**/
void ERROR_HANDLER _AddressError(void)
{
    INTCON1bits.ADDRERR = 0;  //Clear the trap flag
    TRAPS_halt_on_error(TRAPS_ADDRESS_ERR);
}
/** Math Error Trap vector**/
void ERROR_HANDLER _MathError(void)
{
    INTCON1bits.MATHERR = 0;  //Clear the trap flag
    TRAPS_halt_on_error(TRAPS_MATH_ERR);
}
/** DMAC Error Trap vector**/
void ERROR_HANDLER _DMACError(void)
{
    INTCON1bits.DMACERR = 0;  //Clear the trap flag
    TRAPS_halt_on_error(TRAPS_DMAC_ERR);
}
/** Generic Hard Trap vector**/
void ERROR_HANDLER _HardTrapError(void)
{
    INTCON4bits.SGHT = 0;  //Clear the trap flag
    TRAPS_halt_on_error(TRAPS_HARD_ERR);
}
/** Generic Soft Trap vector**/
void ERROR_HANDLER _SoftTrapError(void)
{
#ifdef _DAE
    if(INTCON3bits.DAE)
    {
      INTCON3bits.DAE = 0;  //Clear the trap flag
      TRAPS_halt_on_error(TRAPS_DAE_ERR);
    }

#endif
    if(INTCON3bits.DOOVR)
    {
      INTCON3bits.DOOVR = 0;  //Clear the trap flag
      TRAPS_halt_on_error(TRAPS_DOOVR_ERR);
    }

    while(1);
}
#endif


