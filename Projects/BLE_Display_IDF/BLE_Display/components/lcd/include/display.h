#ifndef DISPLAY_H
#define DISPLAY_H

#include "stdint.h"

#ifdef __cplusplus
extern "C" {
#endif

/**
 * @brief UI update callback function type
 *
 * This callback is invoked periodically by the display task to update UI state.
 * The UI layer should register its update function using Display_RegisterUICallback().
 */
typedef void (*Display_UICallback_t)(void);

/**
 * Initialize the display subsystem
 * - Initializes LVGL
 * - Creates display with double buffering
 * - Initializes HX8357D LCD panel
 * - Starts LVGL tick and update tasks
 */
void Display_Init(void);

/**
 * @brief Register a UI update callback
 *
 * The registered callback will be invoked periodically by the LVGL task
 * to allow the UI layer to update its state machine and screen content.
 *
 * @param callback Function pointer to UI update callback (can be NULL to unregister)
 */
void Display_RegisterUICallback(Display_UICallback_t callback);

void Display_SetBrightness(uint8_t brightness_percent);

#ifdef __cplusplus
}
#endif

#endif // DISPLAY_H
