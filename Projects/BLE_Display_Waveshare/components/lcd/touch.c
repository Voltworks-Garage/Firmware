#include "touch.h"
#include "esp_log.h"
#include "driver/i2c_master.h"
#include "driver/gpio.h"
#include "esp_lcd_panel_io.h"
#include "esp_lcd_touch_gt911.h"

static const char *TAG = "TOUCH";

/* I2C Configuration for GT911 */
#define I2C_MASTER_SCL_IO           9       // GPIO for I2C master clock
#define I2C_MASTER_SDA_IO           8       // GPIO for I2C master data
#define I2C_MASTER_NUM              0       // I2C port number
#define I2C_MASTER_FREQ_HZ          400000  // I2C master clock frequency (400 kHz)
#define I2C_MASTER_TIMEOUT_MS       1000

/* GT911 Touch Configuration */
#define TOUCH_MAX_X                 1024
#define TOUCH_MAX_Y                 600
#define GPIO_TOUCH_RESET            (-1)    // -1 if not used
#define GPIO_TOUCH_INT              (-1)    // -1 if not used

/* CH422G GPIO expander for touch reset control */
#define GPIO_EXPANDER_ADDR          0x24
#define GPIO_EXPANDER_IO_ADDR       0x38
#define GPIO_IO_4                   4

/* Static handles */
static i2c_master_bus_handle_t s_i2c_bus_handle = NULL;
static i2c_master_dev_handle_t s_i2c_dev_handle = NULL;
static esp_lcd_panel_io_handle_t s_touch_io = NULL;
static esp_lcd_touch_handle_t s_touch_handle = NULL;

/**
 * @brief Initialize I2C master bus for GT911 touch controller
 */
static esp_err_t i2c_master_init(void)
{
    ESP_LOGI(TAG, "Initializing I2C master");

    i2c_master_bus_config_t i2c_bus_config = {
        .clk_source = I2C_CLK_SRC_DEFAULT,
        .i2c_port = I2C_MASTER_NUM,
        .scl_io_num = I2C_MASTER_SCL_IO,
        .sda_io_num = I2C_MASTER_SDA_IO,
        .glitch_ignore_cnt = 7,
        .flags.enable_internal_pullup = true,
    };

    esp_err_t ret = i2c_new_master_bus(&i2c_bus_config, &s_i2c_bus_handle);
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "I2C master bus creation failed: %s", esp_err_to_name(ret));
        return ret;
    }

    /* Create I2C device handle for GPIO expander */
    i2c_device_config_t dev_cfg = {
        .dev_addr_length = I2C_ADDR_BIT_LEN_7,
        .device_address = GPIO_EXPANDER_ADDR,
        .scl_speed_hz = I2C_MASTER_FREQ_HZ,
    };

    ret = i2c_master_bus_add_device(s_i2c_bus_handle, &dev_cfg, &s_i2c_dev_handle);
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "Failed to add I2C device: %s", esp_err_to_name(ret));
        return ret;
    }

    ESP_LOGI(TAG, "I2C master initialized (SDA: GPIO%d, SCL: GPIO%d, %d Hz)",
             I2C_MASTER_SDA_IO, I2C_MASTER_SCL_IO, I2C_MASTER_FREQ_HZ);

    return ESP_OK;
}

/**
 * @brief Initialize GPIO for touch reset (via CH422G GPIO expander)
 */
static void gpio_init(void)
{
    gpio_config_t io_conf = {
        .intr_type = GPIO_INTR_DISABLE,
        .pin_bit_mask = (1ULL << GPIO_IO_4),
        .mode = GPIO_MODE_OUTPUT,
    };
    gpio_config(&io_conf);
}

/**
 * @brief Reset the GT911 touch controller via CH422G GPIO expander
 */
static void touch_reset_sequence(void)
{
    ESP_LOGI(TAG, "Resetting touch controller");

    /* Configure CH422G to output mode */
    uint8_t write_buf = 0x01;
    i2c_master_transmit(s_i2c_dev_handle, &write_buf, 1, I2C_MASTER_TIMEOUT_MS);

    /* Create temporary device handle for GPIO expander IO address */
    i2c_master_dev_handle_t io_dev_handle;
    i2c_device_config_t io_dev_cfg = {
        .dev_addr_length = I2C_ADDR_BIT_LEN_7,
        .device_address = GPIO_EXPANDER_IO_ADDR,
        .scl_speed_hz = I2C_MASTER_FREQ_HZ,
    };
    i2c_master_bus_add_device(s_i2c_bus_handle, &io_dev_cfg, &io_dev_handle);

    /* Reset sequence for GT911 */
    write_buf = 0x2C;
    i2c_master_transmit(io_dev_handle, &write_buf, 1, I2C_MASTER_TIMEOUT_MS);
    esp_rom_delay_us(100 * 1000);

    gpio_set_level(GPIO_IO_4, 0);
    esp_rom_delay_us(100 * 1000);

    write_buf = 0x2E;
    i2c_master_transmit(io_dev_handle, &write_buf, 1, I2C_MASTER_TIMEOUT_MS);
    esp_rom_delay_us(200 * 1000);

    /* Clean up temporary device handle */
    i2c_master_bus_rm_device(io_dev_handle);

    ESP_LOGI(TAG, "Touch controller reset complete");
}

/**
 * @brief Initialize GT911 capacitive touch controller
 */
esp_err_t Touch_Init(void)
{
    esp_err_t ret;

    ESP_LOGI(TAG, "===================================");
    ESP_LOGI(TAG, "=== GT911 Touch Initialization ===");
    ESP_LOGI(TAG, "===================================");

    /* Initialize I2C bus */
    ret = i2c_master_init();
    if (ret != ESP_OK) {
        return ret;
    }

    /* Initialize GPIO for touch reset */
    gpio_init();

    /* Reset touch controller */
    touch_reset_sequence();

    /* Create I2C panel IO for GT911 */
    esp_lcd_panel_io_i2c_config_t tp_io_config = ESP_LCD_TOUCH_IO_I2C_GT911_CONFIG();
    tp_io_config.scl_speed_hz = I2C_MASTER_FREQ_HZ;
    ret = esp_lcd_new_panel_io_i2c(s_i2c_bus_handle, &tp_io_config, &s_touch_io);
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "Failed to create panel IO for GT911: %s", esp_err_to_name(ret));
        return ret;
    }

    /* Create GT911 touch controller */
    esp_lcd_touch_config_t tp_cfg = {
        .x_max = TOUCH_MAX_X,
        .y_max = TOUCH_MAX_Y,
        .rst_gpio_num = GPIO_TOUCH_RESET,
        .int_gpio_num = GPIO_TOUCH_INT,
        .levels = {
            .reset = 0,
            .interrupt = 0,
        },
        .flags = {
            .swap_xy = 0,
            .mirror_x = 0,
            .mirror_y = 0,
        },
    };

    ret = esp_lcd_touch_new_i2c_gt911(s_touch_io, &tp_cfg, &s_touch_handle);
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "Failed to create GT911 touch controller: %s", esp_err_to_name(ret));
        return ret;
    }

    ESP_LOGI(TAG, "GT911 touch controller initialized (max: %dx%d)", TOUCH_MAX_X, TOUCH_MAX_Y);
    ESP_LOGI(TAG, "===================================");
    ESP_LOGI(TAG, "=== Touch Init COMPLETE ===");
    ESP_LOGI(TAG, "===================================");

    return ESP_OK;
}

/**
 * @brief Deinitialize touch controller
 */
esp_err_t Touch_DeInit(void)
{
    if (s_touch_handle) {
        esp_lcd_touch_del(s_touch_handle);
        s_touch_handle = NULL;
    }

    if (s_touch_io) {
        esp_lcd_panel_io_del(s_touch_io);
        s_touch_io = NULL;
    }

    if (s_i2c_dev_handle) {
        i2c_master_bus_rm_device(s_i2c_dev_handle);
        s_i2c_dev_handle = NULL;
    }

    if (s_i2c_bus_handle) {
        i2c_del_master_bus(s_i2c_bus_handle);
        s_i2c_bus_handle = NULL;
    }

    ESP_LOGI(TAG, "Touch controller deinitialized");
    return ESP_OK;
}

/**
 * @brief Get current touch coordinates
 *
 * @param x Pointer to store X coordinate
 * @param y Pointer to store Y coordinate
 * @return true if touch is pressed, false otherwise
 */
bool Touch_GetXY(uint16_t *x, uint16_t *y)
{
    if (!s_touch_handle || !x || !y) {
        return false;
    }

    uint16_t touch_x, touch_y;
    uint8_t touch_cnt = 0;

    /* Read touch data from GT911 */
    esp_lcd_touch_read_data(s_touch_handle);

    /* Get touch coordinates */
    bool pressed = esp_lcd_touch_get_coordinates(s_touch_handle, &touch_x, &touch_y, NULL, &touch_cnt, 1);

    if (pressed && touch_cnt > 0) {
        *x = touch_x;
        *y = touch_y;
        return true;
    }

    return false;
}

/**
 * @brief Get touch panel handle (for use with lvgl_port)
 *
 * @return Touch panel handle or NULL if not initialized
 */
esp_lcd_touch_handle_t Touch_GetHandle(void)
{
    return s_touch_handle;
}
