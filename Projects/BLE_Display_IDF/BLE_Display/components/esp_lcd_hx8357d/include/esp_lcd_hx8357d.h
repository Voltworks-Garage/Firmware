/*
 * SPDX-FileCopyrightText: 2025 Voltworks Garage
 *
 * SPDX-License-Identifier: Apache-2.0
 */

/**
 * @file
 * @brief ESP LCD: HX8357D
 */

#pragma once

#include "esp_lcd_panel_vendor.h"

#ifdef __cplusplus
extern "C" {
#endif

/**
 * @brief LCD panel initialization commands for HX8357D
 *
 */
typedef struct {
    int cmd;                    /*<! The specific LCD command */
    const void *data;           /*<! Buffer that holds the command specific data */
    size_t data_bytes;          /*<! Size of `data` in memory, in bytes */
    unsigned int delay_ms;      /*<! Delay in milliseconds after this command */
} hx8357d_lcd_init_cmd_t;

/**
 * @brief LCD panel vendor configuration for HX8357D
 *
 * @note  This structure needs to be passed to the `vendor_config` field in `esp_lcd_panel_dev_config_t`.
 *
 */
typedef struct {
    const hx8357d_lcd_init_cmd_t *init_cmds;     /*!< Pointer to initialization commands array. Set to NULL if using default commands.
                                                  *   The array should be declared as `static const` and positioned outside the function.
                                                  */
    uint16_t init_cmds_size;                     /*<! Number of commands in above array */
} hx8357d_vendor_config_t;

/**
 * @brief Create LCD panel for model HX8357D
 *
 * @note  Vendor specific initialization can be different between manufacturers, should consult the LCD supplier for initialization sequence code.
 *
 * @param[in] io LCD panel IO handle
 * @param[in] panel_dev_config general panel device configuration
 * @param[out] ret_panel Returned LCD panel handle
 * @return
 *          - ESP_ERR_INVALID_ARG   if parameter is invalid
 *          - ESP_ERR_NO_MEM        if out of memory
 *          - ESP_OK                on success
 */
esp_err_t esp_lcd_new_panel_hx8357d(const esp_lcd_panel_io_handle_t io, const esp_lcd_panel_dev_config_t *panel_dev_config, esp_lcd_panel_handle_t *ret_panel);

#ifdef __cplusplus
}
#endif
