#ifndef SCREEN_LOGO_H
#define SCREEN_LOGO_H

#include <lvgl.h>

#ifdef __cplusplus
extern "C" {
#endif

// Create the logo landing screen
void ScreenLogo_Create(void);

// Destroy the logo screen and clean up resources
void ScreenLogo_Destroy(void);

#ifdef __cplusplus
}
#endif

#endif // SCREEN_LOGO_H
