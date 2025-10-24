#include <bluefruit.h>
#include <string.h>

// Minimal Begode/Gotway (X-Way) emulation over BLE

// Device/GATT
static const char* BLE_DEVICE_NAME = "Zach's Moto (Begode)"; // "Begode" must be in the name for DarknessBot to work
BLEDis bledis;
BLEService begodeSvc(0xFFE0);       // HM-10-like service
BLECharacteristic begodeChr(0xFFE1);// RW/Notify characteristic

// Stream state
static bool begode_streaming = false;
static uint8_t begode_frame_seq = 0;   // 0x00 -> 0x04 -> 0x01 -> 0x07 -> repeat
static uint32_t lastFrameMs = 0;
static const uint32_t FRAME_INTERVAL_MS = 200; // ~5 Hz
static uint32_t begode_total_meters = 0;       // integrated distance

// Simple vehicle state (mocked). Replace with real sensor reads later.
struct VehicleState {
  float   speed_mps;            // meters per second
  uint8_t pwm_percent;          // 0..100
  uint8_t battery_percent;      // 0..100
  uint32_t battery_mv;          // millivolts (e.g., 58800 for 58.8 V)
  int16_t current_centi_amps;   // 0.01 A
};

static VehicleState readVehicleState() {
  VehicleState v{};
  static uint32_t t0 = millis();
  uint32_t t = millis() - t0;
  float phase = (t % 5000) / 5000.0f; // 0..1
  // Triangle wave between 13 m/s and 35 m/s
  float tri = (phase < 0.5f) ? (phase * 2.0f) : (1.0f - (phase - 0.5f) * 2.0f); // 0..1..0
  v.speed_mps = 1300.0f + tri * (3050.0f - 1300.0f); // 13..35 m/s
  v.pwm_percent = (uint8_t)min(100.0f, (v.speed_mps / 3500.0f) * 100.0f);
  v.battery_percent = 90;
  v.battery_mv = 58800; // 58.8V pack
  v.current_centi_amps = 650; // 6.50 A
  return v;
}

// Build and send Begode frames compatible with Wheellog's GotwayAdapter
static void begode_send_frame(const VehicleState& v) {
  static uint32_t last_ms = 0;
  uint32_t now = millis();
  if (last_ms == 0) last_ms = now;
  uint32_t dt_ms = now - last_ms;
  last_ms = now;

  // Integrate distance in meters from speed
  float dt_s = dt_ms / 1000.0f;
  float dist_m = v.speed_mps * dt_s;
  begode_total_meters += (uint32_t)(dist_m + 0.5f);

  uint8_t f[24] = {0};
  f[0] = 0x55; f[1] = 0xAA; // header

  uint8_t seq = begode_frame_seq & 0x03;
  if (seq == 0) {
    // Frame 0x00: live data (voltage, speed, distance, phase current, temperature)
    uint16_t voltage_centi = (uint16_t)(v.battery_mv / 10);        // 0.01 V
    // Send speed as raw m/s (integer) — app converts m/s -> km/h -> mph
    int16_t speed_raw_mps  = (int16_t)(v.speed_mps + 0.5f);
    uint32_t dist_total_m  = begode_total_meters;                  // meters
    int16_t phase_cA       = v.current_centi_amps;                 // 0.01 A
    int16_t temp_raw       = (int16_t)((42.0f - 36.53f) * 340.0f); // ~42 C (MPU6050 units)

    // Big-endian fields per Wheellog
    f[2]  = (uint8_t)(voltage_centi >> 8); f[3] = (uint8_t)(voltage_centi & 0xFF);
    f[4]  = (uint8_t)(speed_raw_mps >> 8); f[5] = (uint8_t)(speed_raw_mps & 0xFF);
    f[6]  = (uint8_t)(dist_total_m >> 24); f[7] = (uint8_t)(dist_total_m >> 16);
    f[8]  = (uint8_t)(dist_total_m >> 8);  f[9] = (uint8_t)(dist_total_m & 0xFF);
    f[10] = (uint8_t)(phase_cA >> 8);      f[11] = (uint8_t)(phase_cA & 0xFF);
    f[12] = (uint8_t)(temp_raw >> 8);      f[13] = (uint8_t)(temp_raw & 0xFF);
    // 14..17 unknown; demo values
    f[14] = 0x00; f[15] = 0x01; f[16] = 0xFF; f[17] = 0xF8;
    f[18] = 0x00; // type A
  } else if (seq == 1) {
    // Frame 0x04: totals/settings (total distance and flags)
    uint32_t total_m = begode_total_meters; // meters
    f[2] = (uint8_t)(total_m >> 24); f[3] = (uint8_t)(total_m >> 16);
    f[4] = (uint8_t)(total_m >> 8);  f[5] = (uint8_t)(total_m & 0xFF);
    // 6: packed settings (pedals/alarm/etc.), leave 0; 13 LED mode
    f[6] = 0x00; f[13] = 0x00;
    f[18] = 0x04; // type B
  } else if (seq == 2) {
    // Frame 0x01: voltage/limits (lets apps adopt trueVoltage and show voltage)
    uint16_t pwm_limit = 80;                                  // 80% limit (mock)
    uint16_t bat_dV    = (uint16_t)(v.battery_mv / 100);      // 0.1 V units
    f[2] = (uint8_t)(pwm_limit >> 8); f[3] = (uint8_t)(pwm_limit & 0xFF);
    f[6] = (uint8_t)(bat_dV >> 8);    f[7] = (uint8_t)(bat_dV & 0xFF);
    f[18] = 0x01;
  } else {
    // Frame 0x07: battery current and hardware PWM — unlocks Power/PWM
    int16_t batt_cA = v.current_centi_amps; // 0.01 A
    int16_t hw_pwm  = (int16_t)v.pwm_percent; // 0..100
    f[2] = (uint8_t)(batt_cA >> 8); f[3] = (uint8_t)(batt_cA & 0xFF);
    f[8] = (uint8_t)(hw_pwm >> 8);  f[9] = (uint8_t)(hw_pwm & 0xFF);
    f[18] = 0x07;
  }

  f[19] = 0x18;                // footer marker
  f[20] = 0x5A; f[21] = 0x5A; f[22] = 0x5A; f[23] = 0x5A; // trailer

  begodeChr.notify(f, sizeof(f));
  Serial.print("[EUC][TX] ");
  for (int j = 0; j < 24; j++) { if (f[j] < 16) Serial.print('0'); Serial.print(f[j], HEX); Serial.print(' ');} Serial.println();

  begode_frame_seq = (uint8_t)((begode_frame_seq + 1) & 0x03);
}

// Incoming writes
static void onBegodeWrite(uint16_t conn_hdl, BLECharacteristic* chr, uint8_t* data, uint16_t len) {
  (void)conn_hdl; (void)chr;
  Serial.print("[EUC][RX] ");
  for (uint16_t i = 0; i < len; i++) { if (data[i] < 16) Serial.print('0'); Serial.print(data[i], HEX); Serial.print(' ');} Serial.println();

  if (len == 1 && (data[0] == 'V' || data[0] == 'v')) {
    begode_streaming = true;
    Serial.println("[EUC] Start streaming (V)");
    VehicleState v = readVehicleState();
    begode_send_frame(v);                       // immediate data
    const char* fw = "GW2002001";              // firmware line
    begodeChr.notify((uint8_t*)fw, strlen(fw));
    uint8_t ack = 'V'; begodeChr.notify(&ack, 1); // echo
  } else if (len == 1 && (data[0] == 'N' || data[0] == 'n')) {
    const char* name = "NAME:X-WAY\r\n";
    begodeChr.notify((uint8_t*)name, strlen(name));
  }
}

static void setupBegodeService() {
  begodeSvc.begin();
  begodeChr.setProperties(CHR_PROPS_READ | CHR_PROPS_WRITE | CHR_PROPS_WRITE_WO_RESP | CHR_PROPS_NOTIFY | CHR_PROPS_INDICATE);
  begodeChr.setPermission(SECMODE_OPEN, SECMODE_OPEN);
  begodeChr.setMaxLen(32);
  begodeChr.setWriteCallback(onBegodeWrite);
  begodeChr.begin();
}

static void startAdvertising() {
  Bluefruit.Advertising.addFlags(BLE_GAP_ADV_FLAGS_LE_ONLY_GENERAL_DISC_MODE);
  Bluefruit.Advertising.addTxPower();
  Bluefruit.Advertising.addService(begodeSvc);
  Bluefruit.ScanResponse.addName();
  Bluefruit.Advertising.restartOnDisconnect(true);
  Bluefruit.Advertising.setInterval(32, 244);
  Bluefruit.Advertising.setFastTimeout(30);
  Bluefruit.Advertising.start(0);
}

void setup() {
  Serial.begin(115200);
  while (!Serial) { delay(10); }

  Bluefruit.begin();
  Bluefruit.setName(BLE_DEVICE_NAME);
  Bluefruit.setAppearance(0x0080); // Generic Computer
  Bluefruit.autoConnLed(true);

  // Device Info (optional, harmless)
  bledis.setManufacturer("Begode");
  bledis.setModel("X-Way");
  bledis.begin();

  // Connection logs + reset streaming on disconnect
  Bluefruit.Periph.setConnectCallback([](uint16_t conn_handle) {
    BLEConnection* conn = Bluefruit.Connection(conn_handle);
    char name[32] = {0};
    if (conn && conn->getPeerName(name, sizeof(name))) {
      Serial.print("[BLE] Connected: "); Serial.println(name);
    } else {
      Serial.println("[BLE] Connected: (unknown peer)");
    }
  });
  Bluefruit.Periph.setDisconnectCallback([](uint16_t, uint8_t reason) {
    begode_streaming = false; lastFrameMs = 0;
    Serial.print("[BLE] Disconnected, reason=0x"); if (reason < 16) Serial.print('0'); Serial.println(reason, HEX);
  });

  setupBegodeService();
  startAdvertising();
  Serial.println("[BLE] Advertising started");
}

void loop() {
  uint32_t now = millis();
  if (!Bluefruit.connected()) return;

  if (begode_streaming && (now - lastFrameMs >= FRAME_INTERVAL_MS)) {
    lastFrameMs = now;
    begode_send_frame(readVehicleState());
  }
}
