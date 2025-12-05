#pragma once
#ifndef HX8357D_PANEL_H
#define HX8357D_PANEL_H

#include "esp_err.h"
#include "esp_lcd_types.h"
#include "lvgl.h"
#include "stdint.h"

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Initialize HX8357D panel (8-bit i80) using the configured default pins.
 * Pass an optional pointer to receive the created esp_lcd_panel_handle_t.
 *
 * The function also stores the lv_display_t* passed to the panel IO layer so
 * DMA-complete callbacks can call lv_display_flush_ready().
 *
 * @param out_panel Optional pointer to receive the created panel handle
 * @param lv_disp Pointer to the LVGL display (lv_display_t*) that will receive flush-ready events.
 *                Pass NULL if you won't use LVGL integration.
 * @return ESP_OK on success
 */
esp_err_t hx8357d_init_panel(esp_lcd_panel_handle_t *out_panel, lv_display_t *lv_disp);

/** Deinitialize panel and release resources. */
esp_err_t hx8357d_deinit_panel(void);

/** Set backlight brightness (0-100%) */
esp_err_t hx8357d_set_backlight(uint8_t brightness_percent);

/**
 * LVGL v9 flush callback (use with lv_display_set_flush_cb):
 *   void (*flush_cb)(lv_display_t *disp, const lv_area_t *area, uint8_t *color_p)
 *
 * Call this from your LVGL display registration:
 *   lv_display_set_flush_cb(disp, hx8357d_lvgl_flush);
 */
void hx8357d_lvgl_flush(lv_display_t *disp, const lv_area_t *area, uint8_t *color_p);

/** Return the global panel handle (NULL if not initialized) */
esp_lcd_panel_handle_t hx8357d_get_panel(void);

/** Return the global IO handle (NULL if not initialized) - for debugging */
esp_lcd_panel_io_handle_t hx8357d_get_io_handle(void);

#ifdef __cplusplus
}
#endif

#endif // HX8357D_PANEL_H
