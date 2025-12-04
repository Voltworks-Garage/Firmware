#ifndef DISPLAY_H
#define DISPLAY_H

#include "lvgl.h"

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Initialize the display subsystem
 * - Initializes LVGL
 * - Creates display with double buffering
 * - Initializes HX8357D LCD panel
 * - Starts LVGL tick and update tasks
 */
void Display_Init(void);

/**
 * Get the LVGL display object
 * Used for creating UI elements on the display
 * @return Pointer to LVGL display, or NULL if not initialized
 */
lv_display_t* Display_GetLVGL(void);

#ifdef __cplusplus
}
#endif

#endif // DISPLAY_H
