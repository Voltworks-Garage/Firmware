#include "tsk.h"					// For this modules definitions
#include "tsk_cfg.h"
#include "SysTick.h"
#include <xc.h>

void Tsk_init(void) {

}

void Tsk(void) {

}

void Tsk_10ms(void) {

}

void Tsk_100ms(void) {

}

void Tsk_1000ms(void) {
    _RA0 = _RA0 ? 0 : 1;
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

