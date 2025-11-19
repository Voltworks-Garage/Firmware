// /**
//  * @file ota_module.h
//  * @brief WiFi OTA Update Module using ElegantOTA
//  *
//  * Connects to WiFi and runs OTA server continuously.
//  * Browse to http://<device-ip>/update to upload firmware.
//  */

// #ifndef OTA_MODULE_H
// #define OTA_MODULE_H

// #ifdef __cplusplus
// extern "C" {
// #endif

// // Initialize and start OTA (connects WiFi, starts server)
// // Credentials are hardcoded - edit ota_module.cpp to change
// void OTA_Init(void);

// // Must be called in loop() to handle web requests
// void OTA_Loop(void);

// #ifdef __cplusplus
// }
// #endif

// #endif // OTA_MODULE_H
