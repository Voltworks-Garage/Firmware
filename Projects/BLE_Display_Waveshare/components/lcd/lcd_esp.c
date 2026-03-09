#include "lcd_esp.h"
#include "lvgl_port.h"
#include "esp_log.h"
#include "driver/gpio.h"
#include "driver/i2c_master.h"
#include "esp_lcd_panel_io.h"
#include "esp_lcd_panel_ops.h"
#include "esp_lcd_panel_rgb.h"

static const char *TAG = "RGB_LCD";

/* I2C Configuration for backlight control (CH422G GPIO expander) */
#define I2C_MASTER_NUM              0
#define I2C_MASTER_TIMEOUT_MS       1000
#define GPIO_EXPANDER_ADDR          0x24
#define GPIO_EXPANDER_IO_ADDR       0x38

/* RGB LCD Configuration for 1024x600 */
#define LCD_H_RES                   1024
#define LCD_V_RES                   600
#define LCD_PIXEL_CLOCK_HZ          (16 * 1000 * 1000)  // 16 MHz: ~18fps, shorter ISR duty cycle, wider DMA margins

/* RGB LCD GPIO Pin Mapping (16-bit parallel interface) */
#define LCD_PIN_VSYNC               GPIO_NUM_3
#define LCD_PIN_HSYNC               GPIO_NUM_46
#define LCD_PIN_DE                  GPIO_NUM_5
#define LCD_PIN_PCLK                GPIO_NUM_7
#define LCD_PIN_DISP                (-1)  // -1 if not used

/* 16-bit RGB data pins */
#define LCD_PIN_DATA0               GPIO_NUM_14
#define LCD_PIN_DATA1               GPIO_NUM_38
#define LCD_PIN_DATA2               GPIO_NUM_18
#define LCD_PIN_DATA3               GPIO_NUM_17
#define LCD_PIN_DATA4               GPIO_NUM_10
#define LCD_PIN_DATA5               GPIO_NUM_39
#define LCD_PIN_DATA6               GPIO_NUM_0
#define LCD_PIN_DATA7               GPIO_NUM_45
#define LCD_PIN_DATA8               GPIO_NUM_48
#define LCD_PIN_DATA9               GPIO_NUM_47
#define LCD_PIN_DATA10              GPIO_NUM_21
#define LCD_PIN_DATA11              GPIO_NUM_1
#define LCD_PIN_DATA12              GPIO_NUM_2
#define LCD_PIN_DATA13              GPIO_NUM_42
#define LCD_PIN_DATA14              GPIO_NUM_41
#define LCD_PIN_DATA15              GPIO_NUM_40

/* Timing parameters for 1024x600 @ 21MHz pixel clock */
#define LCD_HSYNC_BACK_PORCH        145
#define LCD_HSYNC_FRONT_PORCH       170
#define LCD_HSYNC_PULSE_WIDTH       30
#define LCD_VSYNC_BACK_PORCH        23
#define LCD_VSYNC_FRONT_PORCH       12
#define LCD_VSYNC_PULSE_WIDTH       2

/* Bounce buffer configuration
 * Required when framebuffers are in PSRAM to prevent DMA underflow.
 * Keep small (x10) so each ISR memcpy is short (~256us) and doesn't
 * block UART/other ISRs. Use lower pixel clock to widen DMA margins.
 */
#define LCD_RGB_BOUNCE_BUFFER_SIZE  (LCD_H_RES * 1)

/* Static handles */
static esp_lcd_panel_handle_t s_panel = NULL;
static i2c_master_bus_handle_t s_i2c_bus_handle = NULL;
static i2c_master_dev_handle_t s_i2c_dev_handle = NULL;

/**
 * @brief Initialize RGB LCD panel
 */
esp_err_t rgb_lcd_init_panel(esp_lcd_panel_handle_t *out_panel)
{
    esp_err_t ret;

    ESP_LOGI(TAG, "===================================");
    ESP_LOGI(TAG, "=== RGB LCD Panel Initialization ===");
    ESP_LOGI(TAG, "===================================");

    if (s_panel) {
        ESP_LOGW(TAG, "Panel already initialized");
        if (out_panel) *out_panel = s_panel;
        return ESP_OK;
    }

    /* CRITICAL: Reclaim JTAG pins (GPIO 39-42) for RGB LCD data lines */
    ESP_LOGI(TAG, "Reclaiming JTAG pins for RGB LCD use");
    gpio_reset_pin(GPIO_NUM_39);  // DATA5 (was MTCK)
    gpio_reset_pin(GPIO_NUM_40);  // DATA15 (was MTDO)
    gpio_reset_pin(GPIO_NUM_41);  // DATA14 (was MTDI)
    gpio_reset_pin(GPIO_NUM_42);  // DATA13 (was MTMS)

    /* Configure RGB panel */
    ESP_LOGI(TAG, "Step 1: Creating RGB LCD panel (%dx%d @ %d Hz)",
             LCD_H_RES, LCD_V_RES, LCD_PIXEL_CLOCK_HZ);

    esp_lcd_rgb_panel_config_t panel_config = {
        .clk_src = LCD_CLK_SRC_DEFAULT,
        .timings = {
            .pclk_hz = LCD_PIXEL_CLOCK_HZ,
            .h_res = LCD_H_RES,
            .v_res = LCD_V_RES,
            .hsync_back_porch = LCD_HSYNC_BACK_PORCH,
            .hsync_front_porch = LCD_HSYNC_FRONT_PORCH,
            .hsync_pulse_width = LCD_HSYNC_PULSE_WIDTH,
            .vsync_back_porch = LCD_VSYNC_BACK_PORCH,
            .vsync_front_porch = LCD_VSYNC_FRONT_PORCH,
            .vsync_pulse_width = LCD_VSYNC_PULSE_WIDTH,
            .flags = {
                .pclk_active_neg = 1,  // Active low pixel clock
            },
        },
        .data_width = 16,  // 16-bit RGB565
        .bits_per_pixel = 16,
        .dma_burst_size = 64,  // Optimal burst size for performance
        .num_fbs = 2,  // From lvgl_port.h (1 for partial buffer mode)
        // .bounce_buffer_size_px = LCD_RGB_BOUNCE_BUFFER_SIZE,
        .hsync_gpio_num = LCD_PIN_HSYNC,
        .vsync_gpio_num = LCD_PIN_VSYNC,
        .de_gpio_num = LCD_PIN_DE,
        .pclk_gpio_num = LCD_PIN_PCLK,
        .disp_gpio_num = LCD_PIN_DISP,
        .data_gpio_nums = {
            LCD_PIN_DATA0,  LCD_PIN_DATA1,  LCD_PIN_DATA2,  LCD_PIN_DATA3,
            LCD_PIN_DATA4,  LCD_PIN_DATA5,  LCD_PIN_DATA6,  LCD_PIN_DATA7,
            LCD_PIN_DATA8,  LCD_PIN_DATA9,  LCD_PIN_DATA10, LCD_PIN_DATA11,
            LCD_PIN_DATA12, LCD_PIN_DATA13, LCD_PIN_DATA14, LCD_PIN_DATA15,
        },
        .flags = {
            .fb_in_psram = 1,           // Use PSRAM for framebuffers
            // .refresh_on_demand = true, // Let LVGL control when to refresh
            // .bb_invalidate_cache = 1,   // Free cache after bounce buffer fill (safe with double-buffering)
        },
    };

    ret = esp_lcd_new_rgb_panel(&panel_config, &s_panel);
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "Failed to create RGB panel: %s", esp_err_to_name(ret));
        return ret;
    }
    ESP_LOGI(TAG, "RGB panel created successfully");

    /* Initialize the panel */
    ESP_LOGI(TAG, "Step 2: Initializing RGB panel");
    ret = esp_lcd_panel_reset(s_panel);
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "Failed to reset RGB panel: %s", esp_err_to_name(ret));
        goto fail_panel;
    }
    ret = esp_lcd_panel_init(s_panel);
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "Failed to initialize RGB panel: %s", esp_err_to_name(ret));
        goto fail_panel;
    }

    ret =    esp_lcd_rgb_panel_restart(s_panel);
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "Failed to restart RGB panel: %s", esp_err_to_name(ret));
        goto fail_panel;
    }


    ESP_LOGI(TAG, "Panel initialization complete");

    ESP_LOGI(TAG, "===================================");
    ESP_LOGI(TAG, "=== RGB LCD Init COMPLETE ===");
    ESP_LOGI(TAG, "===================================");

    if (out_panel) *out_panel = s_panel;
    return ESP_OK;

fail_panel:
    if (s_panel) {
        esp_lcd_panel_del(s_panel);
        s_panel = NULL;
    }
    return ret;
}

/**
 * @brief Deinitialize RGB LCD panel
 */
esp_err_t rgb_lcd_deinit_panel(void)
{
    if (s_panel) {
        esp_lcd_panel_del(s_panel);
        s_panel = NULL;
    }

    ESP_LOGI(TAG, "RGB LCD panel deinitialized");
    return ESP_OK;
}

/**
 * @brief Set backlight brightness via I2C (CH422G GPIO expander)
 *
 * Note: The Waveshare demo uses simple on/off control via I2C.
 * For PWM brightness control, you would need to implement additional logic.
 *
 * Assumes I2C bus 0 has been initialized by the touch controller
 */
esp_err_t rgb_lcd_set_backlight(uint8_t brightness_percent)
{
    esp_err_t ret;
    uint8_t write_buf;

    /* Get the I2C master bus handle from bus port 0 */
    if (!s_i2c_bus_handle) {
        ret = i2c_master_get_bus_handle(I2C_MASTER_NUM, &s_i2c_bus_handle);
        if (ret != ESP_OK) {
            ESP_LOGE(TAG, "I2C bus %d not initialized: %s", I2C_MASTER_NUM, esp_err_to_name(ret));
            return ret;
        }
    }

    /* Create or reuse device handle for GPIO expander */
    if (!s_i2c_dev_handle) {
        i2c_device_config_t dev_cfg = {
            .dev_addr_length = I2C_ADDR_BIT_LEN_7,
            .device_address = GPIO_EXPANDER_ADDR,
            .scl_speed_hz = 400000,
        };
        ret = i2c_master_bus_add_device(s_i2c_bus_handle, &dev_cfg, &s_i2c_dev_handle);
        if (ret != ESP_OK) {
            ESP_LOGE(TAG, "Failed to add I2C device: %s", esp_err_to_name(ret));
            return ret;
        }
    }

    /* Configure CH422G to output mode */
    write_buf = 0x01;
    ret = i2c_master_transmit(s_i2c_dev_handle, &write_buf, 1, I2C_MASTER_TIMEOUT_MS);
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "Failed to configure GPIO expander: %s", esp_err_to_name(ret));
        return ret;
    }

    /* Create temporary device handle for IO address */
    i2c_master_dev_handle_t io_dev_handle;
    i2c_device_config_t io_dev_cfg = {
        .dev_addr_length = I2C_ADDR_BIT_LEN_7,
        .device_address = GPIO_EXPANDER_IO_ADDR,
        .scl_speed_hz = 400000,
    };
    ret = i2c_master_bus_add_device(s_i2c_bus_handle, &io_dev_cfg, &io_dev_handle);
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "Failed to add IO device: %s", esp_err_to_name(ret));
        return ret;
    }

    if (brightness_percent > 0) {
        /* Turn on backlight by pulling pin high */
        write_buf = 0x1E;
    } else {
        /* Turn off backlight by pulling pin low */
        write_buf = 0x1A;
    }

    ret = i2c_master_transmit(io_dev_handle, &write_buf, 1, I2C_MASTER_TIMEOUT_MS);

    /* Clean up temporary device handle */
    i2c_master_bus_rm_device(io_dev_handle);

    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "Failed to set backlight: %s", esp_err_to_name(ret));
        return ret;
    }

    ESP_LOGI(TAG, "Backlight set to %d%%", brightness_percent);
    return ESP_OK;
}

/**
 * @brief Turn display on or off
 */
esp_err_t rgb_lcd_display_on_off(bool on)
{
    if (!s_panel) {
        ESP_LOGW(TAG, "Panel not initialized");
        return ESP_ERR_INVALID_STATE;
    }

    return esp_lcd_panel_disp_on_off(s_panel, on);
}
