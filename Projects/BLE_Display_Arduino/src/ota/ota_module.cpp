// /**
//  * @file ota_module.cpp
//  * @brief WiFi OTA using ElegantOTA library
//  */

// #include "ota_module.h"

// #include <WiFi.h>
// #include <WebServer.h>
// #include <ElegantOTA.h>
// #include "esp_log.h"

// static const char* TAG = "OTA";

// // ============================================================================
// // WiFi Credentials - EDIT THESE
// // ============================================================================
// #define WIFI_SSID "Bill Wi The Science Fi 2.4G"
// #define WIFI_PASS "cheechandbiebs69"
// // ============================================================================

// static WebServer server(80);

// void OTA_Init(void) {
//     ESP_LOGI(TAG, "Connecting to WiFi: %s", WIFI_SSID);

//     WiFi.begin(WIFI_SSID, WIFI_PASS);

//     int timeout = 30;
//     while (WiFi.status() != WL_CONNECTED && timeout > 0) {
//         delay(1000);
//         ESP_LOGI(TAG, "Connecting... (%d)", 30 - timeout);
//         timeout--;
//     }

//     if (WiFi.status() != WL_CONNECTED) {
//         ESP_LOGE(TAG, "WiFi connection failed!");
//         return;
//     }

//     ESP_LOGI(TAG, "WiFi connected. IP: %s", WiFi.localIP().toString().c_str());

//     // Root page with link to update
//     server.on("/", []() {
//         server.send(200, "text/html",
//             "<h1>BLE Display</h1>"
//             "<p><a href='/update'>Firmware Update</a></p>");
//     });

//     ElegantOTA.begin(&server);
//     server.begin();

//     ESP_LOGI(TAG, "OTA ready at http://%s/update", WiFi.localIP().toString().c_str());
// }

// void OTA_Loop(void) {
//     server.handleClient();
//     ElegantOTA.loop();
// }
