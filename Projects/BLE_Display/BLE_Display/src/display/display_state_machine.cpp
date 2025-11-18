#include "display_state_machine.h"
#include "esp_log.h"
#include <lvgl.h>

// Screen includes
#include "screens/screen_logo.h"
#include "screens/screen_home.h"
#include "screens/screen_running.h"
#include "screens/screen_charging.h"

// CAN DBC includes
#include "../../../CAN/generated/dash_dbc.h"

static const char* TAG = "DISPLAY_SM";

// MCU vehicle state enum (matches MCU_App.X StateMachine order)
typedef enum {
    MCU_STATE_BOOT = 0,
    MCU_STATE_IDLE = 1,
    MCU_STATE_SILENT_WAKE = 2,
    MCU_STATE_RUNNING = 3,
    MCU_STATE_CHARGING = 4,
    MCU_STATE_GOING_TO_SLEEP = 5,
    MCU_STATE_SLEEP = 6,
    MCU_STATE_DIAG = 7
} MCU_VehicleState_E;

/******************************************************************************
 * State Machine
 *******************************************************************************/
#define DISPLAY_STATES(state)\
state(screen_welcome)\
state(screen_home)\
state(screen_running)\
state(screen_charging)\

#define STATE_FORM(WORD) WORD##_state,
#define FUNCTION_FORM(WORD) static void WORD(DISPLAY_entry_types_E entry_type);
#define FUNC_PTR_FORM(WORD) WORD,

typedef enum {
    DISPLAY_STATES(STATE_FORM)
    NUMBER_OF_DISPLAY_STATES
} DISPLAY_states_E;

typedef enum {
    ENTRY,
    EXIT,
    RUN,
    NONE
} DISPLAY_entry_types_E;

typedef void(*displayStatePtr)(DISPLAY_entry_types_E);

DISPLAY_STATES(FUNCTION_FORM)
static displayStatePtr display_state_functions[] = {DISPLAY_STATES(FUNC_PTR_FORM)};

static DISPLAY_states_E display_prevState = screen_welcome_state;
static DISPLAY_states_E display_curState = screen_welcome_state;
static DISPLAY_states_E display_nextState = screen_welcome_state;

/******************************************************************************
 * Helper Functions
 *******************************************************************************/

// Map MCU vehicle state to display screen state
static DISPLAY_states_E map_vehicle_state_to_screen(uint8_t vehicle_state) {
    switch (vehicle_state) {
        case MCU_STATE_BOOT:
            // Boot shows welcome screen
            return screen_welcome_state;

        case MCU_STATE_IDLE:
            // Idle shows home screen
            return screen_home_state;

        case MCU_STATE_RUNNING:
            // Running shows running screen
            return screen_running_state;

        case MCU_STATE_CHARGING:
            // Charging shows charging screen
            return screen_charging_state;

        default:
            ESP_LOGW(TAG, "Unknown vehicle state: %d, defaulting to home", vehicle_state);
            return screen_home_state;
    }
}

/******************************************************************************
 * Public Functions
 *******************************************************************************/

void DisplayStateMachine_Init(void) {
    ESP_LOGI(TAG, "Initializing display state machine");

    display_curState = screen_welcome_state;
    display_prevState = screen_welcome_state;
    display_nextState = screen_welcome_state;

    // Call ENTRY for initial state
    display_state_functions[display_curState](ENTRY);
}

void DisplayStateMachine_Run(void) {
    // Check CAN message for vehicle state and update display accordingly
    if (!CAN_mcu_status_checkDataIsStale()) {
        uint8_t vehicle_state = CAN_mcu_status_vehicleState_get();
        DISPLAY_states_E requested_screen = map_vehicle_state_to_screen(vehicle_state);

        // Request state transition if different from current
        if (requested_screen != display_curState && requested_screen != display_nextState) {
            ESP_LOGI(TAG, "CAN vehicle state %d -> requesting screen %d", vehicle_state, requested_screen);
            display_nextState = requested_screen;
        }
    }

    // Check for state transitions
    if (display_nextState != display_curState) {
        display_state_functions[display_curState](EXIT);
        display_prevState = display_curState;
        display_curState = display_nextState;
        display_state_functions[display_curState](ENTRY);
    }

    // Regular RUN call for current state
    display_state_functions[display_curState](RUN);
}

/******************************************************************************
 * State Functions
 *******************************************************************************/

void screen_welcome(DISPLAY_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            ESP_LOGI(TAG, "Entering WELCOME state");
            ScreenLogo_Create();
            break;

        case EXIT:
            ESP_LOGI(TAG, "Exiting WELCOME state");
            ScreenLogo_Destroy();
            break;

        case RUN:
            // TODO: Add auto-transition to HOME after delay or button press
            // For now, manually transition after some time
            // static uint32_t welcome_start_time = 0;
            // if (welcome_start_time == 0) {
            //     welcome_start_time = lv_tick_get();
            // }

            // // Auto-transition to HOME after 3 seconds
            // if (lv_tick_elaps(welcome_start_time) > 3000) {
            //     display_nextState = screen_home_state;
            //     welcome_start_time = 0;  // Reset for next time
            // }
            break;

        default:
            break;
    }
}

void screen_home(DISPLAY_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            ESP_LOGI(TAG, "Entering HOME state");
            ScreenHome_Create();
            break;

        case EXIT:
            ESP_LOGI(TAG, "Exiting HOME state");
            ScreenHome_Destroy();
            break;

        case RUN:
            ScreenHome_Update();
            break;

        default:
            break;
    }
}

void screen_running(DISPLAY_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            ESP_LOGI(TAG, "Entering RUNNING state");
            ScreenRunning_Create();
            break;

        case EXIT:
            ESP_LOGI(TAG, "Exiting RUNNING state");
            ScreenRunning_Destroy();
            break;

        case RUN:
            ScreenRunning_Update();
            break;

        default:
            break;
    }
}

void screen_charging(DISPLAY_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            ESP_LOGI(TAG, "Entering CHARGING state");
            ScreenCharging_Create();
            break;

        case EXIT:
            ESP_LOGI(TAG, "Exiting CHARGING state");
            ScreenCharging_Destroy();
            break;

        case RUN:
            ScreenCharging_Update();
            break;

        default:
            break;
    }
}
