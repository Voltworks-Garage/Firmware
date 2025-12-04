#ifndef DISPLAY_STATE_MACHINE_H
#define DISPLAY_STATE_MACHINE_H

#ifdef __cplusplus
extern "C" {
#endif

// Screen state enumeration
typedef enum {
    SCREEN_WELCOME,   // Welcome/logo screen
    SCREEN_HOME,      // Home/idle screen
    SCREEN_RUNNING,   // Active riding screen
    SCREEN_CHARGING,  // Charging status screen
    SCREEN_COUNT      // Total number of screens (keep last)
} ScreenState_t;

// Initialize the display state machine
void DisplayStateMachine_Init(void);

// Run the state machine (call periodically)
void DisplayStateMachine_Run(void);

#ifdef __cplusplus
}
#endif

#endif // DISPLAY_STATE_MACHINE_H
