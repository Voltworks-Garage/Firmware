/** 
 * @file tsk.h
 * @brief This module contains continuous tasks.
 *
 *  This is the header file for the definition for tasks that are continuous
 *  and should be ran as often as possible.
 */


/******************************************************************************
 * Includes
 *******************************************************************************/
// For this modules definitions
#include "tsk.h"					
#include "tsk_cfg.h"
#include "SysTick.h"
#include "movingAverage.h"

//Direct low level access
#include "uart.h"
#include "sleep.h"


//Task Scheduler system control
#include "pinSetup.h"
#include "StateMachine.h"
#include "SerialDebugger.h"
#include "IO.h"
#include "bms_dbc.h"
#include "can_iso_tp_lite.h"
#include "can_populate.h"
#include "ev_charger.h"
#include "bms.h"
#include "dcdc.h"

/******************************************************************************
 * Constants
 *******************************************************************************/

/******************************************************************************
 * Macros
 *******************************************************************************/
#define DEBUG 0
#if DEBUG
#include <stdio.h>
#include "uart.h"

static uint8_t debugEnable = 1;
#define tskService_print(...) if(debugEnable){char tempArray[125]={};sprintf(tempArray,__VA_ARGS__);Uart1Write(tempArray);}
#else
#define tskService_print(...)
#endif
/******************************************************************************
 * Configuration
 *******************************************************************************/

/******************************************************************************
 * Typedefs
 *******************************************************************************/

/******************************************************************************
 * Variable Declarations
 *******************************************************************************/

NEW_LOW_PASS_FILTER(CPU_usage, 100, 1000);

/******************************************************************************
 * Function Prototypes
 *******************************************************************************/

void Tsk_init(void);

/******************************************************************************
 * Function Declarations
 *******************************************************************************/

/**
 * Tsk_init is only run once ever (until a power on reset) so put pin and module stuff here
 */
void Tsk_init(void) {

    /*Init each module once*/
    PinSetup_Init(); // Pin setup should be first
    CAN_DBC_init(); // Initialize the CAN mailboxes
    StateMachine_Init();
    IO_SET_DEBUG_LED_EN(HIGH);
    BMS_init();

#if DEBUG
    Uart1Write("Hello World, Task Init Done.\n"); //hi
#endif
}

/**
 * Runs every 1ms
 */
void Tsk_1ms(void) {
    ClrWdt(); 
    run_iso_tp_basic();
    DCDC_run_1ms();
    
    CAN_populate_1ms();
}

/**
 * Runs every 5ms
 */
void Tsk_5ms(void) {
    StateMachine_Run();
}

/**
 * Runs every 10ms
 */
void Tsk_10ms(void) {
    EV_CHARGER_Run_10ms();
    BMS_run_10ms();
    
    CAN_bms_debug_CPU_USAGE_set(getLowPassFilter(CPU_usage));
    CAN_populate_10ms();
    CAN_send_10ms();
}

/**
 * Runs every 100ms
 */
void Tsk_100ms(void) {
    DCDC_run_100ms();
    IO_SET_DEBUG_LED_EN(TOGGLE); //Toggle Debug LED at 10Hz for scheduler running status
}

/**
 * Runs every 1000ms
 */
void Tsk_1000ms(void) {
    BMS_run_1000ms();
    CAN_populate_1000ms();
    CAN_send_1000ms();
}

/**
 * Tsk Halt will stop the system tick, put any sleep related code here.
 * The service that calls Tsk_Sleep must be damn sure it is allowed to call
 * this function, also, the caller must subsequently call Tsk_Resume to start
 * the scheduler back up again.
 */
void Tsk_Sleep(void) {
    Nop();
}

/**
 * Tsk Run should be called from Main, once entered, it will never return....
 * @param SystemClock: clock speed in Hz i.e. 120,000,000 = 120MHz.
 */
void Tsk_Run(uint32_t SystemClock) {

    static uint32_t tick = 0; // System tick
    static uint32_t lastTick = 0; //System last tick
    static TaskType *Task_ptr; // Task pointer
    static uint8_t TaskIndex = 0; // Task index
    const uint8_t NumTasks = Tsk_GetNumTasks(); // Number of tasks
    SysTick_Timer_S CPU_Timer;

    SysTick_Init(SystemClock);

    Task_ptr = Tsk_GetConfig(); // Get a pointer to the task configuration

    Tsk_init();
    // The main while loop.  This while loop will run the program forever
    while (1) {
        
         // Get current system tick. If a single tick has occurred, run the tasks.
        tick = SysTick_Get();
        
        if (tick != lastTick){
            lastTick = tick;
            
            // Loop through all tasks. If the number of ticks since the last time the task was run is
            // greater than or equal to the task interval, execute the task.
            SysTick_CPUTimerStart();
            for (TaskIndex = 0; TaskIndex < NumTasks; TaskIndex++) {

                if ((tick - Task_ptr[TaskIndex].LastTick) >= Task_ptr[TaskIndex].Interval) {
                    (*Task_ptr[TaskIndex].Func)(); // Execute Task

                    Task_ptr[TaskIndex].LastTick = tick; // Save last tick the task was ran.
                }
            }// end for
            uint32_t CPU_percentage = SysTick_CPUTimerEnd();
            takeLowPassFilter(CPU_usage, CPU_percentage);
        }
        
    }// end while(1)
}


/*** End of File **************************************************************/


