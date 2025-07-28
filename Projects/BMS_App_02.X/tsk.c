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
//#include "uart.h"
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
#include "mcc_generated_files/watchdog.h"
#include "../../Libraries/CommandService/commandService.h"

/******************************************************************************
 * Constants
 *******************************************************************************/

/******************************************************************************
 * Macros
 *******************************************************************************/
#define TSK_DEBUG_ENABLE 0
#if TSK_DEBUG_ENABLE
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
    BMS_Init();
    isoTP_init();
    DCDC_Init();
    CommandService_Init();
    WATCHDOG_TimerClear();
    WATCHDOG_TimerSoftwareEnable();

#if TSK_DEBUG_ENABLE
    Uart1Write("Hello World, Task Init Done.\n"); //hi
#endif
}

/**
 * Runs every 1ms
 */
void Tsk_1ms(void) {
    run_iso_tp_1ms();
    DCDC_Run_1ms();
    CommandService_Run();
    BMS_Run_1ms();
    
    CAN_populate_1ms();
    //CAN_send_1ms();
}

/**
 * Runs every 5ms
 */
void Tsk_5ms(void) {
    Nop();
}

/**
 * Runs every 10ms
 */
void Tsk_10ms(void) {
    EV_CHARGER_Run_10ms();
    BMS_Run_10ms();               // Non-blocking LTC6802-1 operations

    CAN_bms_status_M2_cpu_usage_percent_set(SysTick_GetCPUPercentage());
    CAN_bms_status_M2_cpu_peak_percent_set(SysTick_GetCPUPeak());
    CAN_populate_10ms();
    CAN_send_10ms();
}

/**
 * Runs every 100ms
 */
void Tsk_100ms(void) {
    WATCHDOG_TimerClear();
    DCDC_Run_100ms();
    IO_SET_DEBUG_LED_EN(TOGGLE); //Toggle Debug LED at 10Hz for scheduler running status

    // CAN_send_100ms();
}

/**
 * Runs every 1000ms
 */
void Tsk_1000ms(void) {
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
    static TaskType *tsk_configPtr; // Task pointer
    static uint8_t tsk_currentIndex = 0; // Task index
    const uint8_t NumTasks = Tsk_GetNumTasks(); // Number of tasks

    SysTick_Init(SystemClock);

    tsk_configPtr = Tsk_GetConfig(); // Get a pointer to the task configuration
    
    SysTick_Set(tsk_configPtr[0].LastTick);// Set the Tick to the first task to allow for the phase offset

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
            for (tsk_currentIndex = 0; tsk_currentIndex < NumTasks; tsk_currentIndex++) {

                if ((tick - tsk_configPtr[tsk_currentIndex].LastTick) >= tsk_configPtr[tsk_currentIndex].Interval) {
                    (*tsk_configPtr[tsk_currentIndex].Func)(); // Execute Task

                    tsk_configPtr[tsk_currentIndex].LastTick = tick; // Save last tick the task was ran.
                }
            }// end for
            StateMachine_Run();
            SysTick_CPUTimerEnd();
        }
        
    }// end while(1)
}


/*** End of File **************************************************************/


