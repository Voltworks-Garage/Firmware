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
#include "cpu_usage.h"

//Direct low level access
#include "pins.h"
#include "uart.h"
#include "sleep.h"


//Task Scheduler system control
#include "can_iso_tp_lite.h"
#include "canPopulate.h"
#include "pinSetup.h"
// #include "SerialDebugger.h"
#include "LightsControl.h"
#include "IgnitionControl.h"
#include "HornControl.h"
#include "HeatedGrips.h"
#include "j1772.h"
#include "IO.h"
#include "LvBattery.h"
#include "MCU_dbc.h"
#include "mcc_generated_files/watchdog.h"
#include "StateMachine.h"
#include "commandService.h"
#include "tachometer.h"

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
#include "lvBattery.h"

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
    PinSetup_Init(); //Pin setup should be first
    CAN_DBC_init(); //Init the CAN System Service
    CAN_timeStampFunc(SysTick_Get); // enable CAN message time-stamping
    StateMachine_Init(); //Init state machine
    CommandService_Init();
    WATCHDOG_TimerClear();
    WATCHDOG_TimerSoftwareEnable();
}

/**
 * Tsk is for continuously running tasks, will run when scheduler is Idle.
 */
void Tsk(void) {
    j1772Control_Run_cont();
}

/**
 * Runs every 10ms
 */
void Tsk_1ms(void) {
    run_iso_tp_1ms();
    CommandService_Run();

    IgnitionControl_Run_1ms();
   
    // Populate 1ms task CPU usage (will be available after CAN code regeneration)
    TaskType *tasks = Tsk_GetConfig();
    CAN_mcu_mcu_debug_task_1ms_cpu_percent_set(CPUUsage_GetTaskCPUPercent(&tasks[1]));
    CAN_mcu_mcu_debug_task_1ms_peak_cpu_percent_set(CPUUsage_GetTaskPeakCPU(&tasks[1]));
   
    CAN_populate_1ms();
    CAN_send_1ms();

    WATCHDOG_TimerClear();
}


/**
 * Runs every 10ms
 */
void Tsk_10ms(void) {
    CAN_mcu_mcu_debug_cpu_usage_percent_set(SysTick_GetCPUPercentage());
    CAN_mcu_mcu_debug_cpu_peak_percent_set(SysTick_GetCPUPeak());
    
    // Populate 10ms task CPU usage (will be available after CAN code regeneration)
    TaskType *tasks = Tsk_GetConfig();
    CAN_mcu_mcu_debug_task_10ms_cpu_percent_set(CPUUsage_GetTaskCPUPercent(&tasks[2]));
    CAN_mcu_mcu_debug_task_10ms_peak_cpu_percent_set(CPUUsage_GetTaskPeakCPU(&tasks[2]));
    
    IO_Efuse_Run_10ms(); //Run the Efuse System

    HornControl_Run_10ms(); //Run Horn. Horn is disabled if button is held for too long.
    LvBattery_Run_10ms();
    LightsControl_Run_10ms(); //Run the System Lights layer (Responds to button presses, controls, etc...)

    
    tachometer_run_10ms(); //Run the Tachometer
    
    CAN_populate_10ms();
    CAN_send_10ms();
}

/**
 * Runs every 100ms
 */
void Tsk_100ms(void) {
    HeatedGripControl_Run_100ms(); //Run Heated Grips. Currently activated by spare sw 2
    j1772Control_Run_100ms(); //Run j1772 Proximity and Pilot Signal Control.
    
    // Populate 100ms task CPU usage (will be available after CAN code regeneration)
    TaskType *tasks = Tsk_GetConfig();
    CAN_mcu_mcu_debug_task_100ms_cpu_percent_set(CPUUsage_GetTaskCPUPercent(&tasks[3]));
    CAN_mcu_mcu_debug_task_100ms_peak_cpu_percent_set(CPUUsage_GetTaskPeakCPU(&tasks[3]));
    
    CAN_populate_100ms();
    CAN_send_100ms();
}

/**
 * Runs every 1000ms
 */
void Tsk_1000ms(void) {
    IO_SET_DEBUG_LED_EN(TOGGLE); //Toggle Debug LED at 1Hz for scheduler running status

    // Populate 1000ms task CPU usage (will be available after CAN code regeneration)
    TaskType *tasks = Tsk_GetConfig();
    CAN_mcu_mcu_debug_task_1000ms_cpu_percent_set(CPUUsage_GetTaskCPUPercent(&tasks[4]));
    CAN_mcu_mcu_debug_task_1000ms_peak_cpu_percent_set(CPUUsage_GetTaskPeakCPU(&tasks[4]));

    CAN_populate_1000ms();
    CAN_send_1000ms();
}

//TODO: Delete this.
void Tsk_Sleep(void){
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

    Tsk_InitCPUMeasurement();
    CPUUsage_Init();

    tsk_configPtr = Tsk_GetConfig(); // Get a pointer to the task configuration
    
    SysTick_Set(tsk_configPtr[0].LastTick);// Set the Tick to the first task to allow for the phase offset

    Tsk_init();
    // The main while loop.  This while loop will run the program forever
    while (1) {
        
         // Get current system tick. If a single tick has occurred, run the tasks.
        tick = SysTick_Get();

        //Run the continuous taks
        Tsk();
        
        if (tick != lastTick){
            lastTick = tick;
            
            // Loop through all tasks. If the number of ticks since the last time the task was run is
            // greater than or equal to the task interval, execute the task.
            SysTick_CPUTimerStart();

            for (tsk_currentIndex = 0; tsk_currentIndex < NumTasks; tsk_currentIndex++) {

                if ((tick - tsk_configPtr[tsk_currentIndex].LastTick) >= tsk_configPtr[tsk_currentIndex].Interval) {
                    CPUUsage_StartTaskTiming(&tsk_configPtr[tsk_currentIndex]);
                    (*tsk_configPtr[tsk_currentIndex].Func)(); // Execute Task
                    CPUUsage_EndTaskTiming(&tsk_configPtr[tsk_currentIndex]);

                    tsk_configPtr[tsk_currentIndex].LastTick = tick; // Save last tick the task was ran.
                }
            }// end for
            
            StateMachine_Run();
            SysTick_CPUTimerEnd();

        }
        
    }// end while(1)
}


/*** End of File **************************************************************/


