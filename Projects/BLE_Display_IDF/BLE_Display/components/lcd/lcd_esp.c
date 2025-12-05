#include "lcd_esp.h"
#include "esp_log.h"
#include "driver/gpio.h"

// FreeRTOS
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

#include "esp_lcd_panel_io.h"
#include "esp_lcd_panel_ops.h"
#include "esp_lcd_hx8357d.h"
#include <string.h>

static const char *TAG = "LCD_Screen";

/* ----------------- Your pin mapping (as provided) ----------------- */
#define HX8357D_PIN_D0  GPIO_NUM_8
#define HX8357D_PIN_D1  GPIO_NUM_9
#define HX8357D_PIN_D2  GPIO_NUM_10
#define HX8357D_PIN_D3  GPIO_NUM_11
#define HX8357D_PIN_D4  GPIO_NUM_12
#define HX8357D_PIN_D5  GPIO_NUM_13
#define HX8357D_PIN_D6  GPIO_NUM_14
#define HX8357D_PIN_D7  GPIO_NUM_15

#define HX8357D_PIN_RST GPIO_NUM_38
#define HX8357D_PIN_RD  GPIO_NUM_39  // defined but unused by driver
#define HX8357D_PIN_WR  GPIO_NUM_40
#define HX8357D_PIN_DC  GPIO_NUM_41
#define HX8357D_PIN_CS  GPIO_NUM_42

/* Power and backlight control pins */
#define HX8357D_PIN_POWER     GPIO_NUM_46
#define HX8357D_PIN_BACKLIGHT GPIO_NUM_16

/* Resolution */
#define HX8357D_H_RES  320
#define HX8357D_V_RES  480

/* ----------------- Internal globals ----------------- */
static esp_lcd_i80_bus_handle_t s_i80_bus = NULL;
static esp_lcd_panel_io_handle_t s_io_handle = NULL;
static esp_lcd_panel_handle_t s_panel = NULL;

/* LVGL display pointer saved in user_ctx for use in DMA-complete callback */
static lv_display_t *s_lv_disp = NULL;

/* ----------------- DMA completion callback -----------------
   This is called by esp_lcd when a color transfer (DMA) completes.
   IMPORTANT: This callback runs in ISR context! Do not use ESP_LOGI or
   any blocking/lock-acquiring functions here.
   We receive the user_ctx we set in esp_lcd_panel_io_i80_config_t.user_ctx,
   which is a pointer to the LVGL lv_display_t* (s_lv_disp). We must call
   lv_display_flush_ready() to inform LVGL the flush is finished.
   Return value: ignored by esp_lcd_panel_io (we just return true).
------------------------------------------------------------------------- */
static bool hx_on_color_trans_done(esp_lcd_panel_io_handle_t panel_io,
                                   esp_lcd_panel_io_event_data_t *edata,
                                   void *user_ctx)
{
    (void)panel_io;
    (void)edata;
    lv_display_t *disp = (lv_display_t *)user_ctx;

    if (disp) {
        /* Notify LVGL that the flush (DMA write) is complete */
        lv_display_flush_ready(disp);
    }
    return false;
}

/* ----------------- Public API ----------------- */

esp_err_t hx8357d_init_panel(esp_lcd_panel_handle_t *out_panel, lv_display_t *lv_disp)
{
    esp_err_t ret;

    ESP_LOGI(TAG, "===================================");
    ESP_LOGI(TAG, "=== HX8357D Panel Initialization ===");
    ESP_LOGI(TAG, "===================================");

    if (s_panel) {
        ESP_LOGW(TAG, "Panel already initialized");
        if (out_panel) *out_panel = s_panel;
        return ESP_OK;
    }

    /* Configure power and backlight pins */
    ESP_LOGI(TAG, "Step 1: Configuring power and backlight pins...");
    gpio_set_direction(HX8357D_PIN_POWER, GPIO_MODE_OUTPUT);
    gpio_set_level(HX8357D_PIN_POWER, 1);  // Turn on power
    ESP_LOGI(TAG, "LCD power enabled");

    gpio_set_direction(HX8357D_PIN_BACKLIGHT, GPIO_MODE_OUTPUT);
    gpio_set_level(HX8357D_PIN_BACKLIGHT, 0);  // Start with backlight off
    ESP_LOGI(TAG, "Backlight configured (off)");

    gpio_set_direction(HX8357D_PIN_RD, GPIO_MODE_OUTPUT);
    gpio_set_level(HX8357D_PIN_RD, 1);  // Start with RD high

    s_lv_disp = lv_disp; // store for callback

    /* i80 bus configuration (8-bit) with max drive strength */
    ESP_LOGI(TAG, "Step 2: Creating i80 bus...");
    esp_lcd_i80_bus_config_t bus_cfg = {
        .clk_src = LCD_CLK_SRC_DEFAULT,
        .dc_gpio_num = HX8357D_PIN_DC,
        .wr_gpio_num = HX8357D_PIN_WR,
        .bus_width = 8,
        .data_gpio_nums = {
            HX8357D_PIN_D0, HX8357D_PIN_D1, HX8357D_PIN_D2, HX8357D_PIN_D3,
            HX8357D_PIN_D4, HX8357D_PIN_D5, HX8357D_PIN_D6, HX8357D_PIN_D7
        },
        .max_transfer_bytes = (480 * 32 * 2), // LVGL partial buffer (30,720 bytes, driver uses <=)
        .dma_burst_size = 64,  // Maximum for external peripherals (128 only works for internal SRAM)
    };

    ret = esp_lcd_new_i80_bus(&bus_cfg, &s_i80_bus);
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "esp_lcd_new_i80_bus failed: %s", esp_err_to_name(ret));
        return ret;
    }
    gpio_set_drive_capability(HX8357D_PIN_DC, GPIO_DRIVE_CAP_3);
    gpio_set_drive_capability(HX8357D_PIN_WR, GPIO_DRIVE_CAP_3);
    gpio_set_drive_capability(HX8357D_PIN_D0, GPIO_DRIVE_CAP_3);
    gpio_set_drive_capability(HX8357D_PIN_D1, GPIO_DRIVE_CAP_3);
    gpio_set_drive_capability(HX8357D_PIN_D2, GPIO_DRIVE_CAP_3);
    gpio_set_drive_capability(HX8357D_PIN_D3, GPIO_DRIVE_CAP_3);
    gpio_set_drive_capability(HX8357D_PIN_D4, GPIO_DRIVE_CAP_3);
    gpio_set_drive_capability(HX8357D_PIN_D5, GPIO_DRIVE_CAP_3);
    gpio_set_drive_capability(HX8357D_PIN_D6, GPIO_DRIVE_CAP_3);
    gpio_set_drive_capability(HX8357D_PIN_D7, GPIO_DRIVE_CAP_3);
    ESP_LOGI(TAG, "i80 bus created successfully (drive strength cannot be changed after initialization)");

    /* panel IO (i80) configuration with DMA completion callback */
    ESP_LOGI(TAG, "Step 3: Creating panel IO...");
    esp_lcd_panel_io_i80_config_t io_cfg = {
        .cs_gpio_num = HX8357D_PIN_CS,
        .pclk_hz = 20000000, // 20 MHz
        .trans_queue_depth = 128,
        .on_color_trans_done = hx_on_color_trans_done,
        .user_ctx = (void *)s_lv_disp, // user context passed to callback
        .lcd_cmd_bits = 8,
        .lcd_param_bits = 8,
        .dc_levels = {
            .dc_idle_level = 0,
            .dc_cmd_level = 0,
            .dc_dummy_level = 0,
            .dc_data_level = 1,
        },
        .flags = {
            .pclk_active_neg = 0,  // 0 = rising edge (default), 1 = falling edge
            .pclk_idle_low = 1,    // 0 = idle high, 1 = idle low
            .swap_color_bytes = 1, // Swap RGB565 byte order (try 0 if colors look wrong)
        },
    };

    ret = esp_lcd_new_panel_io_i80(s_i80_bus, &io_cfg, &s_io_handle);
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "esp_lcd_new_panel_io_i80 failed: %s", esp_err_to_name(ret));
        goto fail_bus;
    }
    gpio_set_drive_capability(HX8357D_PIN_CS, GPIO_DRIVE_CAP_3);
    ESP_LOGI(TAG, "Panel IO created successfully");

    /* Create HX8357D panel driver */
    ESP_LOGI(TAG, "Step 4: Creating HX8357D panel driver...");
    esp_lcd_panel_dev_config_t panel_dev_cfg = {
        .reset_gpio_num = HX8357D_PIN_RST,
        .rgb_ele_order = LCD_RGB_ELEMENT_ORDER_BGR, // BGR color order (change to RGB if colors are wrong)
        .bits_per_pixel = 16,
    };

    ret = esp_lcd_new_panel_hx8357d(s_io_handle, &panel_dev_cfg, &s_panel);
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "esp_lcd_new_panel_hx8357d failed: %s", esp_err_to_name(ret));
        goto fail_io;
    }
    ESP_LOGI(TAG, "HX8357D panel driver created successfully");

    /* Reset & init sequence */
    ESP_LOGI(TAG, "Step 5: Resetting panel...");
    ret = esp_lcd_panel_reset(s_panel);
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "esp_lcd_panel_reset failed: %s", esp_err_to_name(ret));
        goto fail_io;
    }
    ESP_LOGI(TAG, "Reset complete");

    ESP_LOGI(TAG, "Step 6: Initializing panel (sending HX8357D commands)...");
    ret = esp_lcd_panel_init(s_panel);
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "esp_lcd_panel_init failed: %s", esp_err_to_name(ret));
        goto fail_io;
    }

    ESP_LOGI(TAG, "Panel initialization complete");

    ESP_LOGI(TAG, "Step 7: Turning on display...");
    ret = esp_lcd_panel_disp_on_off(s_panel, true);
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "esp_lcd_panel_disp_on_off failed: %s", esp_err_to_name(ret));
        goto fail_io;
    }

    ESP_LOGI(TAG, "Display turned on");

    // // /* Turn on backlight after display is initialized */
    // ESP_LOGI(TAG, "Step 8: Enabling backlight...");
    // gpio_set_level(HX8357D_PIN_BACKLIGHT, 1);
    // ESP_LOGI(TAG, "Backlight enabled");

    ESP_LOGI(TAG, "===================================");
    ESP_LOGI(TAG, "=== HX8357D Init COMPLETE ===");
    ESP_LOGI(TAG, "===================================");

    if (out_panel) *out_panel = s_panel;
    return ESP_OK;

fail_io:
    if (s_io_handle) { esp_lcd_panel_io_del(s_io_handle); s_io_handle = NULL; }
fail_bus:
    if (s_i80_bus) { esp_lcd_del_i80_bus(s_i80_bus); s_i80_bus = NULL; }
    return ret;
}

esp_err_t hx8357d_deinit_panel(void)
{
    esp_err_t ret = ESP_OK;

    /* Turn off power and backlight first */
    ESP_LOGI(TAG, "Turning off power and backlight...");
    gpio_set_level(HX8357D_PIN_POWER, 0);
    gpio_set_level(HX8357D_PIN_BACKLIGHT, 0);

    if (s_panel) {
        ret = esp_lcd_panel_del(s_panel);
        if (ret != ESP_OK) ESP_LOGW(TAG, "esp_lcd_panel_del failed: %s", esp_err_to_name(ret));
        s_panel = NULL;
    }
    if (s_io_handle) {
        ret = esp_lcd_panel_io_del(s_io_handle);
        if (ret != ESP_OK) ESP_LOGW(TAG, "esp_lcd_panel_io_del failed: %s", esp_err_to_name(ret));
        s_io_handle = NULL;
    }
    if (s_i80_bus) {
        ret = esp_lcd_del_i80_bus(s_i80_bus);
        if (ret != ESP_OK) ESP_LOGW(TAG, "esp_lcd_del_i80_bus failed: %s", esp_err_to_name(ret));
        s_i80_bus = NULL;
    }

    s_lv_disp = NULL;
    ESP_LOGI(TAG, "Panel deinitialized");
    return ESP_OK;
}

esp_err_t hx8357d_set_backlight(uint8_t brightness_percent)
{
    if (brightness_percent > 100) brightness_percent = 100;

    // For simple on/off backlight control, just turn on if >0%, off if 0%
    if (brightness_percent == 0) {
        gpio_set_level(HX8357D_PIN_BACKLIGHT, 0);
    } else {
        gpio_set_level(HX8357D_PIN_BACKLIGHT, 1);
    }

    ESP_LOGI(TAG, "Backlight set to %d%%", brightness_percent);
    return ESP_OK;
}

esp_lcd_panel_handle_t hx8357d_get_panel(void)
{
    return s_panel;
}

esp_lcd_panel_io_handle_t hx8357d_get_io_handle(void)
{
    return s_io_handle;
}

/* LVGL v9 flush callback.
   LVGL will call this with an area and a pointer to RGB565 pixel data.
   We queue a DMA transfer via esp_lcd_panel_draw_bitmap(); the completion
   callback (hx_on_color_trans_done) will call lv_display_flush_ready().
*/
void hx8357d_lvgl_flush(lv_display_t *disp, const lv_area_t *area, uint8_t *color_p)
{

    if (!s_panel) {
        ESP_LOGW(TAG, "Flush called but panel is NULL!");
        if (disp) lv_display_flush_ready(disp);
        return;
    }

    int x1 = area->x1;
    int y1 = area->y1;
    int x2 = area->x2;
    int y2 = area->y2;

    // Calculate transfer size for debugging
    int width = x2 - x1 + 1;
    int height = y2 - y1 + 1;
    int transfer_bytes = width * height * 2;
    ESP_LOGI(TAG, "Flush area: (%d,%d)-(%d,%d) = %dx%d pixels = %d bytes",
             x1, y1, x2, y2, width, height, transfer_bytes);

    /* Enqueue DMA transfer to draw the rectangle.
       esp_lcd_panel_draw_bitmap queues the transfer and returns immediately. */
    esp_err_t err = esp_lcd_panel_draw_bitmap(s_panel, x1, y1, x2 + 1, y2 + 1, color_p);
    if (err != ESP_OK) {
        ESP_LOGE(TAG, "esp_lcd_panel_draw_bitmap failed: %s", esp_err_to_name(err));
        /* If enqueueing failed, notify LVGL so it can continue (prevents hang). */
        lv_display_flush_ready(disp);
        return;
    }
    ESP_LOGI(TAG, "FLUSH TRIGGERED");

    vTaskDelay(0);

    /* Do NOT call lv_display_flush_ready() here — wait until the DMA callback fires. */
}
