# LCD Component

This component provides the display subsystem for the BLE Display project, integrating LVGL with the HX8357D LCD controller hardware.

## Architecture

The LCD component is organized into distinct layers:

### Current Structure
```
lcd/
├── display.c/h              - LVGL integration and management
├── lcd_esp.c/h              - HX8357D hardware driver
└── touch.c/h                - Touch controller driver
```

### Responsibilities

**display.c** - LVGL Manager Layer
- Initializes LVGL framework
- Manages frame buffers (double-buffered, PSRAM-backed)
- Runs LVGL task (tick updates, timer handler, rendering)
- Integrates touch input device
- Provides application-facing API

**lcd_esp.c** - Hardware Driver Layer
- Initializes HX8357D LCD controller via i80 parallel bus
- Configures ESP32-S3 GPIO, DMA, and bus interfaces
- Handles low-level pixel transfers
- Manages power and backlight control
- Provides flush callback for LVGL

**touch.c** - Touch Input Layer
- Interfaces with resistive touch controller
- Provides coordinate reading API

---

## TODO: Component Refactoring

### Phase 1: File Renaming

**Goal:** Make file names reflect their actual responsibilities

- [ ] Rename `display.c` → `lvgl_display_manager.c`
- [ ] Rename `display.h` → `lvgl_display_manager.h`
- [ ] Rename `lcd_esp.c` → `lcd_driver.c`
- [ ] Rename `lcd_esp.h` → `lcd_driver.h`
- [ ] Update all `#include` statements across the codebase
- [ ] Update `CMakeLists.txt` to reflect new filenames

**Rationale:**
- `display.c` is too generic; doesn't convey LVGL-specific responsibility
- `lcd_esp.c` doesn't indicate HX8357D hardware specificity
- New names clearly communicate layer boundaries

---

### Phase 2: Remove LVGL Dependency from LCD Driver

**Goal:** Make `lcd_driver.c` hardware-only, with no LVGL dependencies

Current problems:
- `lcd_driver.c` includes `lvgl.h` and uses LVGL types (`lv_display_t`, `lv_area_t`)
- Function `hx8357d_lvgl_flush()` is LVGL-specific
- Callback `hx_on_color_trans_done()` directly calls `lv_display_flush_ready()`
- Driver is tightly coupled to LVGL, making it non-reusable

#### Tasks:

- [ ] **Remove LVGL includes from `lcd_driver.h` and `lcd_driver.c`**
  - Remove `#include "lvgl.h"`

- [ ] **Create generic callback typedef for DMA completion**
  ```c
  // In lcd_driver.h
  typedef void (*lcd_dma_done_callback_t)(void *user_data);
  ```

- [ ] **Refactor `hx8357d_init_panel()` signature**
  - Remove `lv_display_t *lv_disp` parameter
  - Add callback registration function:
    ```c
    esp_err_t lcd_driver_register_dma_callback(
        lcd_dma_done_callback_t callback,
        void *user_data
    );
    ```

- [ ] **Replace `hx8357d_lvgl_flush()` with generic flush function**
  - New signature:
    ```c
    esp_err_t lcd_driver_draw_bitmap(
        int x1, int y1, int x2, int y2,
        const uint8_t *color_data
    );
    ```
  - No LVGL types in parameters
  - Returns error codes instead of calling LVGL callbacks

- [ ] **Refactor `hx_on_color_trans_done()` to be generic**
  - Remove direct `lv_display_flush_ready()` call
  - Invoke registered callback pointer with user data
  - Example:
    ```c
    static bool lcd_on_dma_done(esp_lcd_panel_io_handle_t panel_io,
                                 esp_lcd_panel_io_event_data_t *edata,
                                 void *user_ctx)
    {
        lcd_callback_context_t *ctx = (lcd_callback_context_t *)user_ctx;
        if (ctx && ctx->callback) {
            ctx->callback(ctx->user_data);
        }
        return false;
    }
    ```

- [ ] **Update `lvgl_display_manager.c` to use new driver API**
  - Implement LVGL-specific wrapper for flush callback
  - Register wrapper with driver via `lcd_driver_register_dma_callback()`
  - Adapt `hx8357d_lvgl_flush()` to call `lcd_driver_draw_bitmap()`

- [ ] **Update CMakeLists.txt dependencies**
  - Remove `lvgl` from `lcd_driver` REQUIRES
  - Keep `lvgl` only in `lvgl_display_manager` layer

---

### Phase 3: Remove HX8357D-Specific Naming from Driver API

**Goal:** Create a generic LCD driver API that could support multiple controllers

Current problems:
- Public API uses `hx8357d_*` prefixes, tying interface to specific hardware
- If switching to different LCD (ST7789, ILI9341), would need API changes
- Internal implementation can stay HX8357D-specific, but interface should be generic

#### Tasks:

- [ ] **Rename public API functions** (use `lcd_driver_` prefix):
  ```c
  // Old names → New names
  hx8357d_init_panel()      → lcd_driver_init()
  hx8357d_deinit_panel()    → lcd_driver_deinit()
  hx8357d_set_backlight()   → lcd_driver_set_backlight()
  hx8357d_get_panel()       → lcd_driver_get_panel()
  hx8357d_get_io_handle()   → lcd_driver_get_io_handle()
  hx8357d_lvgl_flush()      → lcd_driver_draw_bitmap() (after Phase 2)
  ```

- [ ] **Keep internal functions HX8357D-specific** (static functions):
  ```c
  // These can stay as-is (static, not in header):
  static bool hx8357d_on_dma_done(...)
  static void hx8357d_send_init_sequence(...)
  ```

- [ ] **Update all call sites** across the codebase:
  - Search for `hx8357d_` function calls
  - Replace with new `lcd_driver_` equivalents

- [ ] **Add conditional compilation support** (future-proofing):
  ```c
  // In lcd_driver.c
  #ifdef LCD_CONTROLLER_HX8357D
      #include "esp_lcd_hx8357d.h"
      // HX8357D-specific implementation
  #elif defined(LCD_CONTROLLER_ST7789)
      #include "esp_lcd_st7789.h"
      // ST7789-specific implementation
  #endif
  ```

- [ ] **Update documentation** to reflect generic API

---

## Benefits of This Refactoring

1. **Clear Separation of Concerns**
   - LVGL layer only in `lvgl_display_manager.c`
   - Hardware layer only in `lcd_driver.c`
   - Touch layer only in `touch.c`

2. **Reusability**
   - `lcd_driver.c` can be used in non-LVGL projects
   - Easy to swap LCD controllers without changing higher layers

3. **Maintainability**
   - File names clearly indicate responsibilities
   - Generic APIs make code easier to understand
   - Reduced coupling between layers

4. **Testability**
   - Hardware driver can be unit tested independently
   - LVGL integration can be mocked/stubbed

5. **Portability**
   - Adding new LCD controller = new `lcd_driver_xxx.c` implementation
   - Application code remains unchanged

---

## Migration Notes

After refactoring, the call flow will be:

```
Application (main.c)
    ↓
lvgl_display_manager.c
    - Initialize LVGL
    - Allocate frame buffers
    - Register flush callback wrapper
    - Start LVGL task
    ↓
    Calls: lcd_driver_init()
           lcd_driver_register_dma_callback(lvgl_flush_done, lv_disp)
    ↓
lcd_driver.c (generic API)
    - Initialize i80 bus
    - Initialize HX8357D controller (internal)
    - Configure DMA with generic callback
    ↓
    On DMA complete:
        generic_callback(user_data) → lvgl_flush_done() → lv_display_flush_ready()
```

---

## Testing Plan

1. **Phase 1 Testing** (File Renaming)
   - Verify project builds successfully
   - No functional changes expected

2. **Phase 2 Testing** (Remove LVGL Dependency)
   - Verify display still renders correctly
   - Check DMA callbacks fire properly
   - Test touch input still works
   - Verify no LVGL symbols in `lcd_driver` object file

3. **Phase 3 Testing** (Generic API)
   - Verify all renamed functions work correctly
   - No functional changes expected
   - Confirm API is controller-agnostic

---

## Future Enhancements

After refactoring:
- [ ] Add support for multiple LCD controllers (ST7789, ILI9341)
- [ ] Implement PWM-based backlight dimming (not just on/off)
- [ ] Add rotation support in driver layer
- [ ] Performance profiling of DMA transfer rates
- [ ] Power management integration (sleep/wake)
