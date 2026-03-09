#ifndef SCREEN_RUNNING_H
#define SCREEN_RUNNING_H

#ifdef __cplusplus
extern "C" {
#endif

// Create the running/active screen
void ScreenRunning_Create(void);

// Destroy the running screen and clean up resources
void ScreenRunning_Destroy(void);

// Update running screen with current data
void ScreenRunning_Update(void);

#ifdef __cplusplus
}
#endif

#endif // SCREEN_RUNNING_H
