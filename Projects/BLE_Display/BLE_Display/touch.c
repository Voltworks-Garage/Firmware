#include "touch.h"
#include "src/msg/messaging.h"
#include "driver/gpio.h"
#include "esp_adc/adc_continuous.h"
#include "esp_log.h"


#include "../../../Libraries/Standard/movingAverage.h"

static const char *TAG = "TOUCH";

#define X_PLUS GPIO_NUM_4
#define X_MINUS GPIO_NUM_5
#define Y_PLUS GPIO_NUM_6
#define Y_MINUS GPIO_NUM_7

/* Replace these with the ADC channel constants for GPIO4..7 if you want exact ones */
#define X_ADC_PLUS ADC_CHANNEL_3
#define Y_ADC_PLUS ADC_CHANNEL_5

/* Example: we'll treat these as ADC_UNIT_1 channels */
#define ADC_UNIT ADC_UNIT_1

/*height and width in ADC ticks*/
#define HEIGHT_LOWER 650
#define HEIGHT_UPPER 3600
#define WIDTH_LOWER 450
#define WIDTH_UPPER 3800

#define NO_TOUCH_THRESHOLD 4000


void setXpins(void);
void setYpins(void);
uint16_t map(uint16_t x, uint16_t in_min, uint16_t in_max, uint16_t out_min, uint16_t out_max);


NEW_LOW_PASS_FILTER(x_reading_filter, 1000.0f, 10000.0f); // 100 Hz cutoff, 10000 Hz sample rate
NEW_LOW_PASS_FILTER(y_reading_filter, 1000.0f, 10000.0f); // 100 Hz cutoff, 10000 Hz sample rate

static bool x_y_toggle = false;

static adc_continuous_handle_t adc_handle = NULL;
static adc_continuous_config_t dig_cfg;
static adc_continuous_handle_cfg_t cfg = {
    .max_store_buf_size = 4096,
    .conv_frame_size = 1024,
};
static adc_digi_pattern_config_t adc_patterns[] = {
    { .atten = ADC_ATTEN_DB_11, .channel = X_ADC_PLUS, .unit = ADC_UNIT, .bit_width = SOC_ADC_DIGI_MAX_BITWIDTH },
    { .atten = ADC_ATTEN_DB_11, .channel = Y_ADC_PLUS, .unit = ADC_UNIT, .bit_width = SOC_ADC_DIGI_MAX_BITWIDTH },
};


static void adc_continuous_init(void)
{

    ESP_ERROR_CHECK(adc_continuous_new_handle(&cfg, &adc_handle));

    dig_cfg = (adc_continuous_config_t){
        .sample_freq_hz = 10 * 1000,                 // 10 kHz overall
        .conv_mode = ADC_CONV_SINGLE_UNIT_1,         // ADC1
        .format = ADC_DIGI_OUTPUT_FORMAT_TYPE2,
        .adc_pattern = adc_patterns,
        .pattern_num = sizeof(adc_patterns) / sizeof(adc_patterns[0]),
    };

    ESP_ERROR_CHECK(adc_continuous_config(adc_handle, &dig_cfg));
}

void Touch_Init(void) {
    adc_continuous_init();
    adc_continuous_start(adc_handle);
}

void Touch_DeInit(void) {

}

void Touch_Run_1ms(void) {

    uint8_t result[1024];
    uint32_t ret_num = 0;

    esp_err_t ret = adc_continuous_read(adc_handle, result, sizeof(result), &ret_num, 0);

    if (ret == ESP_OK) {
        for (int i = 0; i < ret_num; i += sizeof(adc_digi_output_data_t)) {
            adc_digi_output_data_t *sample = (adc_digi_output_data_t *)&result[i];
            if(x_y_toggle) {
                // Process Y reading
                if (sample->type2.channel != Y_ADC_PLUS) {
                    continue; // Skip if not Y channel
                }
                takeLowPassFilter(y_reading_filter, sample->type2.data);
                // ESP_LOGI(TAG, "Y Reading: %d", y_reading);
            } else {
                // Process X reading
                if (sample->type2.channel != X_ADC_PLUS) {
                    continue; // Skip if not X channel
                }
                takeLowPassFilter(x_reading_filter, sample->type2.data);
                // ESP_LOGI(TAG, "X Reading: %d", x_reading);
            }
            // printf("ADC%d_CH%d = %d\n",
            //     sample->type2.unit + 1,
            //     sample->type2.channel,
            //     sample->type2.data);
        }
        
        //Toggle pins for next reading
        if (x_y_toggle) {
            setYpins();
        } else
        {
            setXpins();
        }
        x_y_toggle = !x_y_toggle;
    }




}

void Touch_Run_10ms(void) {
    // uint16_t x, y;
    // bool touched = Touch_GetXY(&x, &y);
}

bool Touch_GetXY(uint16_t* x, uint16_t* y) {
    uint16_t x_val, y_val;
    if (x != NULL) {
        x_val = getLowPassFilter(x_reading_filter);
        *x = map(x_val, WIDTH_LOWER, WIDTH_UPPER, 0, 480);
    } else {
        return false;
    }
    if (y != NULL) {
        y_val = getLowPassFilter(y_reading_filter);
        *y = map(y_val, HEIGHT_LOWER, HEIGHT_UPPER, 0, 320);
    } else {
        return false;
    }

    if (x_val > WIDTH_UPPER || x_val < WIDTH_LOWER || y_val > HEIGHT_UPPER || y_val < HEIGHT_LOWER) {
        // Out of bounds - no touch
        return false;
    }
    return true;
}

void setXpins(void) {

    // Configure pins as ADC
    gpio_reset_pin(Y_PLUS);

    // Set X pins to output
    gpio_set_direction(X_PLUS, GPIO_MODE_OUTPUT);
    gpio_set_direction(X_MINUS, GPIO_MODE_OUTPUT);
    gpio_set_level(X_PLUS, 0);
    gpio_set_level(X_MINUS, 1);

    // Set extra Y pin to input pullup
    gpio_set_direction(Y_MINUS, GPIO_MODE_INPUT);
    gpio_set_pull_mode(Y_MINUS, GPIO_PULLUP_ONLY);

}

void setYpins(void) {
    // Configure pins as ADC
    gpio_reset_pin(X_PLUS);

    // Set Y pins to output
    gpio_set_direction(Y_PLUS, GPIO_MODE_OUTPUT);
    gpio_set_direction(Y_MINUS, GPIO_MODE_OUTPUT);
    gpio_set_level(Y_PLUS, 1);
    gpio_set_level(Y_MINUS, 0);

    // Set extra X pin to input pullup
    gpio_set_direction(X_MINUS, GPIO_MODE_INPUT);
    gpio_set_pull_mode(X_MINUS, GPIO_PULLUP_ONLY);
}

uint16_t map(uint16_t x, uint16_t in_min, uint16_t in_max, uint16_t out_min, uint16_t out_max) {
    return (uint16_t)((uint32_t)(x - in_min) * (uint32_t)(out_max - out_min) / (in_max - in_min) + out_min);
}