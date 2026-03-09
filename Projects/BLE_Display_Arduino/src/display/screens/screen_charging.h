#ifndef SCREEN_CHARGING_H
#define SCREEN_CHARGING_H

#include <lvgl.h>

#ifdef __cplusplus
extern "C" {
#endif

// Create the charging screen
void ScreenCharging_Create(void);

// Destroy the charging screen and clean up resources
void ScreenCharging_Destroy(void);

// Update charging screen with current data
void ScreenCharging_Update(void);

#ifdef __cplusplus
}
#endif

#endif // SCREEN_CHARGING_H
