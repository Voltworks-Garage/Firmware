// #include "lcd_esp.h"
// #include "esp_log.h"
// #include "driver/gpio.h"
// #include "esp_lcd_panel_io.h"
// #include "esp_lcd_panel_io_i80.h"
// #include "esp_lcd_i80.h"
// #include "esp_lcd_panel_ili9341.h" // used as a generic panel wrapper
// #include <string.h>

// static const char *TAG = "hx8357d_panel";

// /* ----------------- Your pin mapping (as provided) ----------------- */
// #define HX8357D_PIN_D0  GPIO_NUM_8
// #define HX8357D_PIN_D1  GPIO_NUM_9
// #define HX8357D_PIN_D2  GPIO_NUM_10
// #define HX8357D_PIN_D3  GPIO_NUM_11
// #define HX8357D_PIN_D4  GPIO_NUM_12
// #define HX8357D_PIN_D5  GPIO_NUM_13
// #define HX8357D_PIN_D6  GPIO_NUM_14
// #define HX8357D_PIN_D7  GPIO_NUM_15

// #define HX8357D_PIN_RST GPIO_NUM_38
// #define HX8357D_PIN_RD  GPIO_NUM_39  // defined but unused by driver
// #define HX8357D_PIN_WR  GPIO_NUM_40
// #define HX8357D_PIN_DC  GPIO_NUM_41
// #define HX8357D_PIN_CS  GPIO_NUM_42

// /* Resolution */
// #define HX8357D_H_RES  320
// #define HX8357D_V_RES  480

// /* ----------------- Internal globals ----------------- */
// static esp_lcd_i80_bus_handle_t s_i80_bus = NULL;
// static esp_lcd_panel_io_handle_t s_io_handle = NULL;
// static esp_lcd_panel_handle_t s_panel = NULL;

// /* LVGL display pointer saved in user_ctx for use in DMA-complete callback */
// static lv_display_t *s_lv_disp = NULL;

// /* Simple helper to send command + params via panel IO */
// static esp_err_t hx_send_cmd(const uint8_t cmd, const uint8_t *data, size_t len)
// {
//     if (s_io_handle == NULL) return ESP_ERR_INVALID_STATE;
//     return esp_lcd_panel_io_tx_param(s_io_handle, cmd, data, len);
// }

// /* Example gamma & power tables -- replace with vendor values if available */
// static const uint8_t hx_gamma_pos[] = {0x00,0x03,0x09,0x09,0x08,0x16,0x12,0x3C,0x78,0x4B,0x0A};
// static const uint8_t hx_gamma_neg[] = {0x00,0x16,0x1A,0x0F,0x17,0x32,0x2C,0x75,0x77,0x4C,0x0A};

// /* ----------------- DMA completion callback -----------------
//    This is called by esp_lcd when a color transfer (DMA) completes.
//    We receive the user_ctx we set in esp_lcd_panel_io_i80_config_t.user_ctx,
//    which is a pointer to the LVGL lv_display_t* (s_lv_disp). We must call
//    lv_display_flush_ready() to inform LVGL the flush is finished.
//    Return value: ignored by esp_lcd_panel_io (we just return true).
// ------------------------------------------------------------------------- */
// static bool hx_on_color_trans_done(esp_lcd_panel_io_handle_t panel_io,
//                                    esp_lcd_panel_io_event_data_t *edata,
//                                    void *user_ctx)
// {
//     (void)panel_io;
//     (void)edata;
//     lv_display_t *disp = (lv_display_t *)user_ctx;
//     if (disp) {
//         /* Notify LVGL that the flush (DMA write) is complete */
//         lv_display_flush_ready(disp);
//     }
//     return true;
// }

// /* ----------------- Public API ----------------- */

// esp_err_t hx8357d_init_panel(esp_lcd_panel_handle_t *out_panel, lv_display_t *lv_disp)
// {
//     esp_err_t ret;

//     if (s_panel) {
//         ESP_LOGW(TAG, "Panel already initialized");
//         if (out_panel) *out_panel = s_panel;
//         return ESP_OK;
//     }

//     s_lv_disp = lv_disp; // store for callback

//     /* i80 bus configuration (8-bit) */
//     esp_lcd_i80_bus_config_t bus_cfg = {
//         .clk_src = LCD_CLK_SRC_PLL160M,
//         .dc_gpio_num = HX8357D_PIN_DC,
//         .wr_gpio_num = HX8357D_PIN_WR,
//         .bus_width = 8,
//         .data_gpio_nums = {
//             (int)HX8357D_PIN_D0, (int)HX8357D_PIN_D1, (int)HX8357D_PIN_D2, (int)HX8357D_PIN_D3,
//             (int)HX8357D_PIN_D4, (int)HX8357D_PIN_D5, (int)HX8357D_PIN_D6, (int)HX8357D_PIN_D7
//         },
//         .max_transfer_bytes = HX8357D_H_RES * 40 * 2, // tile height 40 lines default (bytes)
//     };

//     ret = esp_lcd_new_i80_bus(&bus_cfg, &s_i80_bus);
//     if (ret != ESP_OK) {
//         ESP_LOGE(TAG, "esp_lcd_new_i80_bus failed: %s", esp_err_to_name(ret));
//         return ret;
//     }

//     /* panel IO (i80) configuration with DMA completion callback */
//     esp_lcd_panel_io_i80_config_t io_cfg = {
//         .cs_gpio_num = HX8357D_PIN_CS,
//         .pclk_hz = 26000000, // 26 MHz (tune if needed)
//         .trans_queue_depth = 10,
//         .on_color_trans_done = hx_on_color_trans_done,
//         .user_ctx = (void *)s_lv_disp, // user context passed to callback
//         .lcd_cmd_bits = 8,
//         .lcd_param_bits = 8,
//     };

//     ret = esp_lcd_new_panel_io_i80(s_i80_bus, &io_cfg, &s_io_handle);
//     if (ret != ESP_OK) {
//         ESP_LOGE(TAG, "esp_lcd_new_panel_io_i80 failed: %s", esp_err_to_name(ret));
//         goto fail_bus;
//     }

//     /* Create a generic panel handle (using ILI9341 panel wrapper) */
//     esp_lcd_panel_dev_config_t panel_dev_cfg = {
//         .reset_gpio_num = HX8357D_PIN_RST,
//         .rgb_ele_order = ESP_LCD_COLOR_SPACE_BGR, // defaulting to BGR - change to RGB if needed
//         .rgb_order = LCD_RGB_ORDER_RGB,
//         .bits_per_pixel = 16,
//     };

//     ret = esp_lcd_new_panel_ili9341(s_io_handle, &panel_dev_cfg, &s_panel);
//     if (ret != ESP_OK) {
//         ESP_LOGE(TAG, "esp_lcd_new_panel_ili9341 failed: %s", esp_err_to_name(ret));
//         goto fail_io;
//     }

//     /* Reset & init sequence (example) */
//     ESP_LOGI(TAG, "HX8357D: Resetting panel...");
//     esp_lcd_panel_reset(s_panel);
//     vTaskDelay(pdMS_TO_TICKS(120));

//     ESP_LOGI(TAG, "HX8357D: Sending init sequence...");
//     hx_send_cmd(0x01, NULL, 0); // Software reset
//     vTaskDelay(pdMS_TO_TICKS(150));

//     // Power / VCOM / drive settings (example values)
//     hx_send_cmd(0xC1, (const uint8_t[]){0x41}, 1);                // VCOM
//     hx_send_cmd(0xC5, (const uint8_t[]){0x0E}, 1);                // VCOM amplitude
//     hx_send_cmd(0xD0, (const uint8_t[]){0x07, 0x42, 0x1D}, 3);    // Power ctrl 1
//     hx_send_cmd(0xD1, (const uint8_t[]){0x00, 0x0A, 0x00}, 3);    // Power ctrl 2

//     // Gamma
//     hx_send_cmd(0xE9, hx_gamma_pos, sizeof(hx_gamma_pos));
//     hx_send_cmd(0xEA, hx_gamma_neg, sizeof(hx_gamma_neg));

//     // Memory access control: default orientation, BGR ordering
//     // MADCTL value 0x60 used previously: keep using panel_dev_cfg rgb_ele_order for BGR
//     hx_send_cmd(0x36, (const uint8_t[]){0x60}, 1);

//     // Interface pixel format: 16bpp (RGB565)
//     hx_send_cmd(0x3A, (const uint8_t[]){0x55}, 1);

//     // Sleep out and display on
//     hx_send_cmd(0x11, NULL, 0);
//     vTaskDelay(pdMS_TO_TICKS(120));
//     hx_send_cmd(0x29, NULL, 0);
//     vTaskDelay(pdMS_TO_TICKS(20));

//     ESP_LOGI(TAG, "HX8357D init complete");

//     if (out_panel) *out_panel = s_panel;
//     return ESP_OK;

// fail_io:
//     if (s_io_handle) { esp_lcd_panel_io_del(s_io_handle); s_io_handle = NULL; }
// fail_bus:
//     if (s_i80_bus) { esp_lcd_del_i80_bus(s_i80_bus); s_i80_bus = NULL; }
//     return ret;
// }

// esp_err_t hx8357d_deinit_panel(void)
// {
//     esp_err_t ret = ESP_OK;
//     if (s_panel) {
//         ret = esp_lcd_panel_del(s_panel);
//         if (ret != ESP_OK) ESP_LOGW(TAG, "esp_lcd_panel_del failed: %s", esp_err_to_name(ret));
//         s_panel = NULL;
//     }
//     if (s_io_handle) {
//         ret = esp_lcd_panel_io_del(s_io_handle);
//         if (ret != ESP_OK) ESP_LOGW(TAG, "esp_lcd_panel_io_del failed: %s", esp_err_to_name(ret));
//         s_io_handle = NULL;
//     }
//     if (s_i80_bus) {
//         ret = esp_lcd_del_i80_bus(s_i80_bus);
//         if (ret != ESP_OK) ESP_LOGW(TAG, "esp_lcd_del_i80_bus failed: %s", esp_err_to_name(ret));
//         s_i80_bus = NULL;
//     }
//     s_lv_disp = NULL;
//     return ESP_OK;
// }

// esp_lcd_panel_handle_t hx8357d_get_panel(void)
// {
//     return s_panel;
// }

// /* LVGL v9 flush callback.
//    LVGL will call this with an area and a pointer to RGB565 pixel data.
//    We queue a DMA transfer via esp_lcd_panel_draw_bitmap(); the completion
//    callback (hx_on_color_trans_done) will call lv_display_flush_ready().
// */
// void hx8357d_lvgl_flush(lv_display_t *disp, const lv_area_t *area, uint8_t *color_p)
// {
//     if (!s_panel) {
//         if (disp) lv_display_flush_ready(disp);
//         return;
//     }

//     int x1 = area->x1;
//     int y1 = area->y1;
//     int x2 = area->x2;
//     int y2 = area->y2;

//     /* Enqueue DMA transfer to draw the rectangle.
//        esp_lcd_panel_draw_bitmap queues the transfer and returns immediately. */
//     esp_err_t err = esp_lcd_panel_draw_bitmap(s_panel, x1, y1, x2 + 1, y2 + 1, color_p);
//     if (err != ESP_OK) {
//         ESP_LOGE(TAG, "esp_lcd_panel_draw_bitmap failed: %s", esp_err_to_name(err));
//         /* If enqueueing failed, notify LVGL so it can continue (prevents hang). */
//         lv_display_flush_ready(disp);
//         return;
//     }

//     /* Do NOT call lv_display_flush_ready() here — wait until the DMA callback fires. */
// }
