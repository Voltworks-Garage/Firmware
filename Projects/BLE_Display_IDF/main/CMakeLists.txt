set(LGFX_ROOT ${CMAKE_CURRENT_LIST_DIR}/../../../Libraries/Drivers/LovyanGFX)

file(GLOB LGFX_SRCS
    ${LGFX_ROOT}/src/lgfx/Fonts/efont/*.c
    ${LGFX_ROOT}/src/lgfx/Fonts/IPA/*.c
    ${LGFX_ROOT}/src/lgfx/utility/*.c
    ${LGFX_ROOT}/src/lgfx/v1/*.cpp
    ${LGFX_ROOT}/src/lgfx/v1/misc/*.cpp
    ${LGFX_ROOT}/src/lgfx/v1/panel/*.cpp
    ${LGFX_ROOT}/src/lgfx/v1/platforms/esp32/*.cpp
    ${LGFX_ROOT}/src/lgfx/v1/platforms/esp32s3/*.cpp
    ${LGFX_ROOT}/src/lgfx/v1/touch/*.cpp
)

idf_component_register(
    SRCS
        "BLE_Display.cpp"
        "lcd_module.cpp"
        "can_module.c"
        ${LGFX_SRCS}
    INCLUDE_DIRS
        "."
        "${LGFX_ROOT}/src"
    REQUIRES
        driver
        esp_driver_twai
        esp_driver_spi
        esp_timer
        nvs_flash
        efuse
        esp_lcd
)

# Compile C files with C11 standard for bool and _Static_assert support
# Allow implicit conversions for LovyanGFX ESP-IDF v5+ compatibility
target_compile_options(${COMPONENT_LIB} PRIVATE
    $<$<COMPILE_LANGUAGE:C>:-std=gnu11>
    $<$<COMPILE_LANGUAGE:CXX>:-fpermissive>
)

# Remove -Werror for this component to allow conversions
target_compile_options(${COMPONENT_LIB} PRIVATE
    $<$<COMPILE_LANGUAGE:CXX>:-Wno-error>
)
