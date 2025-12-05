#ifndef SCREEN_HOME_H
#define SCREEN_HOME_H

#ifdef __cplusplus
extern "C" {
#endif

// Create the home/idle screen
void ScreenHome_Create(void);

// Destroy the home screen and clean up resources
void ScreenHome_Destroy(void);

// Update home screen with current data
void ScreenHome_Update(void);

#ifdef __cplusplus
}
#endif

#endif // SCREEN_HOME_H
