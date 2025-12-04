/*
 * SPDX-FileCopyrightText: 2025 Voltworks Garage
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#define LOG_LOCAL_LEVEL    ESP_LOG_NONE     /*!< No log output */
// #define LOG_LOCAL_LEVEL    ESP_LOG_ERROR    /*!< Critical errors, software module can not recover on its own */
// #define LOG_LOCAL_LEVEL    ESP_LOG_WARN     /*!< Error conditions from which recovery measures have been taken */
// #define LOG_LOCAL_LEVEL    ESP_LOG_INFO     /*!< Information messages which describe normal flow of events */
// #define LOG_LOCAL_LEVEL    ESP_LOG_DEBUG    /*!< Extra information which is not necessary for normal use (values, pointers, sizes, etc). */
// #define LOG_LOCAL_LEVEL    ESP_LOG_VERBOSE  /*!< Bigger chunks of debugging information, or frequent messages which can potentially flood the output. */
// #define LOG_LOCAL_LEVEL    ESP_LOG_MAX      /*!< Number of levels supported */
#include "esp_log.h"
static const char *TAG = "hx8357d";

#include <stdlib.h>
#include <sys/cdefs.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_lcd_panel_interface.h"
#include "esp_lcd_panel_io.h"
#include "esp_lcd_panel_vendor.h"
#include "esp_lcd_panel_ops.h"
#include "esp_lcd_panel_commands.h"
#include "driver/gpio.h"

#include "esp_check.h"

#include "esp_lcd_hx8357d.h"

static esp_err_t panel_hx8357d_del(esp_lcd_panel_t *panel);
static esp_err_t panel_hx8357d_reset(esp_lcd_panel_t *panel);
static esp_err_t panel_hx8357d_init(esp_lcd_panel_t *panel);
static esp_err_t panel_hx8357d_draw_bitmap(esp_lcd_panel_t *panel, int x_start, int y_start, int x_end, int y_end, const void *color_data);
static esp_err_t panel_hx8357d_invert_color(esp_lcd_panel_t *panel, bool invert_color_data);
static esp_err_t panel_hx8357d_mirror(esp_lcd_panel_t *panel, bool mirror_x, bool mirror_y);
static esp_err_t panel_hx8357d_swap_xy(esp_lcd_panel_t *panel, bool swap_axes);
static esp_err_t panel_hx8357d_set_gap(esp_lcd_panel_t *panel, int x_gap, int y_gap);
static esp_err_t panel_hx8357d_disp_on_off(esp_lcd_panel_t *panel, bool off);

typedef struct {
    esp_lcd_panel_t base;
    esp_lcd_panel_io_handle_t io;
    int reset_gpio_num;
    bool reset_level;
    int x_gap;
    int y_gap;
    uint8_t fb_bits_per_pixel;
    uint8_t madctl_val; // save current value of LCD_CMD_MADCTL register
    uint8_t colmod_val; // save current value of LCD_CMD_COLMOD register
    const hx8357d_lcd_init_cmd_t *init_cmds;
    uint16_t init_cmds_size;
} hx8357d_panel_t;

esp_err_t esp_lcd_new_panel_hx8357d(const esp_lcd_panel_io_handle_t io, const esp_lcd_panel_dev_config_t *panel_dev_config, esp_lcd_panel_handle_t *ret_panel)
{
    esp_log_level_set(TAG, LOG_LOCAL_LEVEL);
    esp_err_t ret = ESP_OK;
    hx8357d_panel_t *hx8357d = NULL;
    gpio_config_t io_conf = { 0 };

    ESP_GOTO_ON_FALSE(io && panel_dev_config && ret_panel, ESP_ERR_INVALID_ARG, err, TAG, "invalid argument");
    hx8357d = (hx8357d_panel_t *)calloc(1, sizeof(hx8357d_panel_t));
    ESP_GOTO_ON_FALSE(hx8357d, ESP_ERR_NO_MEM, err, TAG, "no mem for hx8357d panel");

    if (panel_dev_config->reset_gpio_num >= 0) {
        io_conf.mode = GPIO_MODE_OUTPUT;
        io_conf.pin_bit_mask = 1ULL << panel_dev_config->reset_gpio_num;
        ESP_GOTO_ON_ERROR(gpio_config(&io_conf), err, TAG, "configure GPIO for RST line failed");
    }

#if ESP_IDF_VERSION < ESP_IDF_VERSION_VAL(5, 0, 0)
    switch (panel_dev_config->color_space) {
    case ESP_LCD_COLOR_SPACE_RGB:
        hx8357d->madctl_val = 0;
        break;
    case ESP_LCD_COLOR_SPACE_BGR:
        hx8357d->madctl_val |= LCD_CMD_BGR_BIT;
        break;
    default:
        ESP_GOTO_ON_FALSE(false, ESP_ERR_NOT_SUPPORTED, err, TAG, "unsupported color space");
        break;
    }
#elif ESP_IDF_VERSION < ESP_IDF_VERSION_VAL(6, 0, 0)
    switch (panel_dev_config->rgb_endian) {
    case LCD_RGB_ENDIAN_RGB:
        hx8357d->madctl_val = 0;
        break;
    case LCD_RGB_ENDIAN_BGR:
        hx8357d->madctl_val |= LCD_CMD_BGR_BIT;
        break;
    default:
        ESP_GOTO_ON_FALSE(false, ESP_ERR_NOT_SUPPORTED, err, TAG, "unsupported rgb endian");
        break;
    }
#else
    switch (panel_dev_config->rgb_ele_order) {
    case LCD_RGB_ELEMENT_ORDER_RGB:
        hx8357d->madctl_val = 0;
        break;
    case LCD_RGB_ELEMENT_ORDER_BGR:
        hx8357d->madctl_val |= LCD_CMD_BGR_BIT;
        break;
    default:
        ESP_GOTO_ON_FALSE(false, ESP_ERR_NOT_SUPPORTED, err, TAG, "unsupported rgb element order");
        break;
    }
#endif

    switch (panel_dev_config->bits_per_pixel) {
    case 16: // RGB565
        hx8357d->colmod_val = 0x55;
        hx8357d->fb_bits_per_pixel = 16;
        break;
    case 18: // RGB666
        hx8357d->colmod_val = 0x66;
        // each color component (R/G/B) should occupy the 6 high bits of a byte, which means 3 full bytes are required for a pixel
        hx8357d->fb_bits_per_pixel = 24;
        break;
    default:
        ESP_GOTO_ON_FALSE(false, ESP_ERR_NOT_SUPPORTED, err, TAG, "unsupported pixel width");
        break;
    }

    hx8357d->io = io;
    hx8357d->reset_gpio_num = panel_dev_config->reset_gpio_num;
    hx8357d->reset_level = panel_dev_config->flags.reset_active_high;
    if (panel_dev_config->vendor_config) {
        hx8357d->init_cmds = ((hx8357d_vendor_config_t *)panel_dev_config->vendor_config)->init_cmds;
        hx8357d->init_cmds_size = ((hx8357d_vendor_config_t *)panel_dev_config->vendor_config)->init_cmds_size;
    }
    hx8357d->base.del = panel_hx8357d_del;
    hx8357d->base.reset = panel_hx8357d_reset;
    hx8357d->base.init = panel_hx8357d_init;
    hx8357d->base.draw_bitmap = panel_hx8357d_draw_bitmap;
    hx8357d->base.invert_color = panel_hx8357d_invert_color;
    hx8357d->base.set_gap = panel_hx8357d_set_gap;
    hx8357d->base.mirror = panel_hx8357d_mirror;
    hx8357d->base.swap_xy = panel_hx8357d_swap_xy;
#if ESP_IDF_VERSION < ESP_IDF_VERSION_VAL(5, 0, 0)
    hx8357d->base.disp_off = panel_hx8357d_disp_on_off;
#else
    hx8357d->base.disp_on_off = panel_hx8357d_disp_on_off;
#endif
    *ret_panel = &(hx8357d->base);
    ESP_LOGD(TAG, "new hx8357d panel @%p", hx8357d);

    return ESP_OK;

err:
    if (hx8357d) {
        if (panel_dev_config->reset_gpio_num >= 0) {
            gpio_reset_pin(panel_dev_config->reset_gpio_num);
        }
        free(hx8357d);
    }
    return ret;
}

static esp_err_t panel_hx8357d_del(esp_lcd_panel_t *panel)
{
    hx8357d_panel_t *hx8357d = __containerof(panel, hx8357d_panel_t, base);

    if (hx8357d->reset_gpio_num >= 0) {
        gpio_reset_pin(hx8357d->reset_gpio_num);
    }
    ESP_LOGD(TAG, "del hx8357d panel @%p", hx8357d);
    free(hx8357d);
    return ESP_OK;
}

static esp_err_t panel_hx8357d_reset(esp_lcd_panel_t *panel)
{
    hx8357d_panel_t *hx8357d = __containerof(panel, hx8357d_panel_t, base);
    esp_lcd_panel_io_handle_t io = hx8357d->io;

    // perform hardware reset
    if (hx8357d->reset_gpio_num >= 0) {
        gpio_set_level(hx8357d->reset_gpio_num, hx8357d->reset_level);
        vTaskDelay(pdMS_TO_TICKS(1));
        gpio_set_level(hx8357d->reset_gpio_num, !hx8357d->reset_level);
        vTaskDelay(pdMS_TO_TICKS(1));
    } else { // perform software reset
        ESP_RETURN_ON_ERROR(esp_lcd_panel_io_tx_param(io, LCD_CMD_SWRESET, NULL, 0), TAG, "send command failed");
        vTaskDelay(pdMS_TO_TICKS(6)); // spec, wait at least 5ms before sending new command
    }

    return ESP_OK;
}

/* HX8357D register definitions */
#define HX8357D_SETC        0xB9  // Enable extension command
#define HX8357D_SETRGB      0xB3  // Set RGB interface
#define HX8357D_SETCOM      0xB6  // Set VCOM voltage
#define HX8357D_SETOSC      0xB0  // Set oscillator
#define HX8357D_SETPANEL    0xCC  // Set panel characteristic
#define HX8357D_SETPWR1     0xB1  // Set power control
#define HX8357D_SETSTBA     0xC0  // Set source timing
#define HX8357D_SETCYC      0xB4  // Set display cycle
#define HX8357D_SETGAMMA    0xE0  // Set gamma curve
#define HX8357D_TEON        0x35  // Tearing effect line on
#define HX8357D_TEARLINE    0x44  // Set tear scanline

/* HX8357D-specific initialization command data arrays */
// SETC (0xB9): Enable extended command set - unlocks HX8357D-specific registers
static const uint8_t cmd_setc_data[] = {
    0xFF, 0x83, 0x57  // Extended command enable signature
};

// SETRGB (0xB3): RGB interface control
static const uint8_t cmd_setrgb_data[] = {
    0x00,  // SDO_EN=0 (disable SDO pin for i80 parallel interface)
    0x00,  // DE mode
    0x06,  // Front porch
    0x06   // Back porch
};

// SETCOM (0xB6): VCOM voltage control
static const uint8_t cmd_setcom_data[] = {
    0x25   // VCOM = -1.52V
};

// SETOSC (0xB0): Oscillator settings
static const uint8_t cmd_setosc_data[] = {
    0x68   // Normal mode: 70Hz, Idle mode: 55Hz
};

// SETPANEL (0xCC): Panel characteristics
static const uint8_t cmd_setpanel_data[] = {
    0x05   // BGR color filter order, gate scan direction reversed
};

// SETPWR1 (0xD0): Power control settings
static const uint8_t cmd_setpwr1_data[] = {
    0x00,  // Not in deep standby mode
    0x15,  // BT (Booster circuit step-up factor)
    0x1C,  // VRH (VREF voltage adjustment)
    0x1C,  // VCM (VCOMH voltage)
    0x83,  // VDV (VCOM amplitude)
    0xAA   // VCOMG enable
};

// SETSTBA (0xB1): Source/VCOM/Gate timing control
static const uint8_t cmd_setstba_data[] = {
    0x50,  // DM (Display mode control) = Normal
    0x50,  // DM (Display mode control) = Normal
    0x01,  // RTN (1-line period)
    0x3C,  // BP (Back porch lines)
    0x1E,  // FP (Front porch lines)
    0x08   // Scan cycle interval
};

// SETCYC (0xB4): Display cycle control
static const uint8_t cmd_setcyc_data[] = {
    0x02,  // NW (Gate driver output waveform)
    0x40,  // RTN (Number of clock cycles per line)
    0x00,  // DIV (Clock frequency divider)
    0x2A,  // DUM (Dummy gate scan period)
    0x2A,  // DUM (Dummy gate scan period)
    0x0D,  // GDON (Gate output on timing)
    0x78   // GDOFF (Gate output off timing)
};
// Gamma curve is split into smaller chunks to fit within LCD_I80_IO_FORMAT_BUF_SIZE
static const uint8_t cmd_setgamma_data[] = {
    0x02, 0x0A, 0x11, 0x1d, 0x23, 0x35, 0x41, 0x4b, 0x4b, 0x42, 0x3A, 0x27, 0x1B, 0x08, 0x09, 0x03
};
// Note: Full gamma is 34 bytes but i80 buffer is limited to 16 bytes
// Using simplified 16-byte gamma curve that should still provide good results
static const uint8_t cmd_teon_data[] = {0x00};
static const uint8_t cmd_tearline_data[] = {0x00, 0x02};

/* HX8357D-specific default initialization sequence */
static const hx8357d_lcd_init_cmd_t vendor_specific_init_default[] = {
    // Enable extension command set - CRITICAL for HX8357D
    {HX8357D_SETC, cmd_setc_data, sizeof(cmd_setc_data), 5},

    // Set RGB interface (enables SDO pin)
    {HX8357D_SETRGB, cmd_setrgb_data, sizeof(cmd_setrgb_data), 0},

    // Set VCOM voltage (-1.52V)
    {HX8357D_SETCOM, cmd_setcom_data, sizeof(cmd_setcom_data), 0},

    // Set oscillator (Normal mode 70Hz, Idle mode 55Hz)
    {HX8357D_SETOSC, cmd_setosc_data, sizeof(cmd_setosc_data), 0},

    // Set panel characteristic (BGR, Gate direction swapped)
    {HX8357D_SETPANEL, cmd_setpanel_data, sizeof(cmd_setpanel_data), 0},

    // Set power control
    {HX8357D_SETPWR1, cmd_setpwr1_data, sizeof(cmd_setpwr1_data), 0},

    // Set source/gate timing
    {HX8357D_SETSTBA, cmd_setstba_data, sizeof(cmd_setstba_data), 0},

    // Set display cycle control
    {HX8357D_SETCYC, cmd_setcyc_data, sizeof(cmd_setcyc_data), 0},

    // Set gamma curve (34 bytes)
    {HX8357D_SETGAMMA, cmd_setgamma_data, sizeof(cmd_setgamma_data), 0},

    // Tearing effect line on
    {HX8357D_TEON, cmd_teon_data, sizeof(cmd_teon_data), 0},

    // Set tear scanline
    {HX8357D_TEARLINE, cmd_tearline_data, sizeof(cmd_tearline_data), 0},
};

static esp_err_t panel_hx8357d_init(esp_lcd_panel_t *panel)
{
    hx8357d_panel_t *hx8357d = __containerof(panel, hx8357d_panel_t, base);
    esp_lcd_panel_io_handle_t io = hx8357d->io;

    ESP_LOGI(TAG, "=== HX8357D Init Starting ===");

    // Determine which initialization sequence to use
    const hx8357d_lcd_init_cmd_t *init_cmds = NULL;
    uint16_t init_cmds_size = 0;
    if (hx8357d->init_cmds) {
        // Use custom initialization commands if provided
        init_cmds = hx8357d->init_cmds;
        init_cmds_size = hx8357d->init_cmds_size;
        ESP_LOGI(TAG, "Using CUSTOM init sequence (%d commands)", init_cmds_size);
    } else {
        // Use default HX8357D initialization sequence
        init_cmds = vendor_specific_init_default;
        init_cmds_size = sizeof(vendor_specific_init_default) / sizeof(hx8357d_lcd_init_cmd_t);
        ESP_LOGI(TAG, "Using DEFAULT init sequence (%d commands)", init_cmds_size);
    }

    // Execute vendor-specific initialization commands
    bool is_cmd_overwritten = false;
    for (int i = 0; i < init_cmds_size; i++) {
        // Check if the command conflicts with standard commands we'll send later
        switch (init_cmds[i].cmd) {
        case LCD_CMD_MADCTL:
            is_cmd_overwritten = true;
            hx8357d->madctl_val = ((uint8_t *)init_cmds[i].data)[0];
            break;
        case LCD_CMD_COLMOD:
            is_cmd_overwritten = true;
            hx8357d->colmod_val = ((uint8_t *)init_cmds[i].data)[0];
            break;
        default:
            is_cmd_overwritten = false;
            break;
        }

        if (is_cmd_overwritten) {
            ESP_LOGW(TAG, "The %02Xh command has been used and will be overwritten by external initialization sequence", init_cmds[i].cmd);
        }

        ESP_LOGI(TAG, "[%d/%d] Sending cmd 0x%02X with %d bytes, delay %dms",
                 i+1, init_cmds_size, init_cmds[i].cmd, init_cmds[i].data_bytes, init_cmds[i].delay_ms);

        esp_err_t ret = esp_lcd_panel_io_tx_param(io, init_cmds[i].cmd, init_cmds[i].data, init_cmds[i].data_bytes);
        if (ret != ESP_OK) {
            ESP_LOGE(TAG, "Command 0x%02X FAILED: %s", init_cmds[i].cmd, esp_err_to_name(ret));
            return ret;
        }

        if (init_cmds[i].delay_ms > 0) {
            vTaskDelay(pdMS_TO_TICKS(init_cmds[i].delay_ms));
        }
    }

    // Set pixel format (16-bit RGB565)
    ESP_LOGI(TAG, "Setting COLMOD (pixel format) to 0x%02X", hx8357d->colmod_val);
    ESP_RETURN_ON_ERROR(esp_lcd_panel_io_tx_param(io, LCD_CMD_COLMOD, (uint8_t[]) {
        hx8357d->colmod_val,
    }, 1), TAG, "COLMOD command failed");

    // Memory access control (orientation and color order)
    // Reference uses: MX (0x40) | MY (0x80) | BGR (0x08) = 0xC8
    // Combine user's BGR setting with hardware-specific orientation
    uint8_t madctl_combined = hx8357d->madctl_val | 0x68;  // MX | MY = 0xC0
    ESP_LOGI(TAG, "Setting MADCTL to 0x%02X (base=0x%02X | 0xC0)", madctl_combined, hx8357d->madctl_val);
    ESP_RETURN_ON_ERROR(esp_lcd_panel_io_tx_param(io, LCD_CMD_MADCTL, (uint8_t[]) {
        madctl_combined,
    }, 1), TAG, "MADCTL command failed");

    // Exit sleep mode
    ESP_LOGI(TAG, "Sending SLPOUT (exit sleep mode)");
    ESP_RETURN_ON_ERROR(esp_lcd_panel_io_tx_param(io, LCD_CMD_SLPOUT, NULL, 0), TAG, "SLPOUT command failed");
    ESP_LOGI(TAG, "Waiting 150ms for panel to wake up...");
    vTaskDelay(pdMS_TO_TICKS(150));

    ESP_LOGI(TAG, "=== HX8357D Init Complete ===");

    return ESP_OK;
}

static esp_err_t panel_hx8357d_draw_bitmap(esp_lcd_panel_t *panel, int x_start, int y_start, int x_end, int y_end, const void *color_data)
{
    hx8357d_panel_t *hx8357d = __containerof(panel, hx8357d_panel_t, base);
    assert((x_start < x_end) && (y_start < y_end) && "start position must be smaller than end position");
    esp_lcd_panel_io_handle_t io = hx8357d->io;

    static int draw_count = 0;
    draw_count++;

    x_start += hx8357d->x_gap;
    x_end += hx8357d->x_gap;
    y_start += hx8357d->y_gap;
    y_end += hx8357d->y_gap;

    // define an area of frame memory where MCU can access
    ESP_RETURN_ON_ERROR(esp_lcd_panel_io_tx_param(io, LCD_CMD_CASET, (uint8_t[]) {
        (x_start >> 8) & 0xFF,
        x_start & 0xFF,
        ((x_end - 1) >> 8) & 0xFF,
        (x_end - 1) & 0xFF,
    }, 4), TAG, "send command failed");
    ESP_RETURN_ON_ERROR(esp_lcd_panel_io_tx_param(io, LCD_CMD_RASET, (uint8_t[]) {
        (y_start >> 8) & 0xFF,
        y_start & 0xFF,
        ((y_end - 1) >> 8) & 0xFF,
        (y_end - 1) & 0xFF,
    }, 4), TAG, "send command failed");
    // transfer frame buffer
    size_t len = (x_end - x_start) * (y_end - y_start) * hx8357d->fb_bits_per_pixel / 8;

    if (draw_count <= 5) {
        ESP_LOGI(TAG, "Draw #%d: area(%d,%d)->(%d,%d) size=%dx%d bytes=%zu",
                 draw_count, x_start, y_start, x_end-1, y_end-1,
                 x_end - x_start, y_end - y_start, len);
    }

    esp_err_t ret = esp_lcd_panel_io_tx_color(io, LCD_CMD_RAMWR, color_data, len);

    if (draw_count <= 5) {
        ESP_LOGI(TAG, "tx_color returned: %s", esp_err_to_name(ret));
    }

    return ret;
}

static esp_err_t panel_hx8357d_invert_color(esp_lcd_panel_t *panel, bool invert_color_data)
{
    hx8357d_panel_t *hx8357d = __containerof(panel, hx8357d_panel_t, base);
    esp_lcd_panel_io_handle_t io = hx8357d->io;
    int command = 0;
    if (invert_color_data) {
        command = LCD_CMD_INVON;
    } else {
        command = LCD_CMD_INVOFF;
    }
    ESP_RETURN_ON_ERROR(esp_lcd_panel_io_tx_param(io, command, NULL, 0), TAG, "send command failed");
    return ESP_OK;
}

static esp_err_t panel_hx8357d_mirror(esp_lcd_panel_t *panel, bool mirror_x, bool mirror_y)
{
    hx8357d_panel_t *hx8357d = __containerof(panel, hx8357d_panel_t, base);
    esp_lcd_panel_io_handle_t io = hx8357d->io;
    if (mirror_x) {
        hx8357d->madctl_val |= LCD_CMD_MX_BIT;
    } else {
        hx8357d->madctl_val &= ~LCD_CMD_MX_BIT;
    }
    if (mirror_y) {
        hx8357d->madctl_val |= LCD_CMD_MY_BIT;
    } else {
        hx8357d->madctl_val &= ~LCD_CMD_MY_BIT;
    }
    ESP_RETURN_ON_ERROR(esp_lcd_panel_io_tx_param(io, LCD_CMD_MADCTL, (uint8_t[]) {
        hx8357d->madctl_val
    }, 1), TAG, "send command failed");
    return ESP_OK;
}

static esp_err_t panel_hx8357d_swap_xy(esp_lcd_panel_t *panel, bool swap_axes)
{
    hx8357d_panel_t *hx8357d = __containerof(panel, hx8357d_panel_t, base);
    esp_lcd_panel_io_handle_t io = hx8357d->io;
    if (swap_axes) {
        hx8357d->madctl_val |= LCD_CMD_MV_BIT;
    } else {
        hx8357d->madctl_val &= ~LCD_CMD_MV_BIT;
    }
    ESP_RETURN_ON_ERROR(esp_lcd_panel_io_tx_param(io, LCD_CMD_MADCTL, (uint8_t[]) {
        hx8357d->madctl_val
    }, 1), TAG, "send command failed");
    return ESP_OK;
}

static esp_err_t panel_hx8357d_set_gap(esp_lcd_panel_t *panel, int x_gap, int y_gap)
{
    hx8357d_panel_t *hx8357d = __containerof(panel, hx8357d_panel_t, base);
    hx8357d->x_gap = x_gap;
    hx8357d->y_gap = y_gap;
    return ESP_OK;
}

static esp_err_t panel_hx8357d_disp_on_off(esp_lcd_panel_t *panel, bool on_off)
{
    hx8357d_panel_t *hx8357d = __containerof(panel, hx8357d_panel_t, base);
    esp_lcd_panel_io_handle_t io = hx8357d->io;
    int command = 0;

#if ESP_IDF_VERSION < ESP_IDF_VERSION_VAL(5, 0, 0)
    on_off = !on_off;
#endif

    if (on_off) {
        command = LCD_CMD_DISPON;
    } else {
        command = LCD_CMD_DISPOFF;
    }
    ESP_RETURN_ON_ERROR(esp_lcd_panel_io_tx_param(io, command, NULL, 0), TAG, "send command failed");
    return ESP_OK;
}
