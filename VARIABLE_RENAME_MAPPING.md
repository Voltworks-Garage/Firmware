# Variable Rename Mapping - Variable Standardization

## Overview
This document provides systematic mapping for standardizing variable names across active projects to follow automotive naming conventions established in CODING_STANDARDS.md.

## Strategy & Priority Order
🔴 **Critical** - Safety-critical variables (battery, charging, vehicle control)
🟡 **Important** - State variables and module-specific variables
🟢 **Standard** - General code quality improvements

---

## Variable Naming Standards Summary

### **Established Conventions:**
- **Static Variables**: `moduleName_variablePurpose` (camelCase with module prefix)
- **Local Variables**: `variablePurpose` (camelCase, descriptive)
- **Global Variables**: `g_ModuleName_VariablePurpose` (minimize usage)
- **Constants**: `MODULE_CONSTANT_NAME` (ALL_CAPS with underscores)
- **Function Parameters**: `parameterPurpose` (camelCase, descriptive)

---

## 🔴 CRITICAL - Safety-Critical Variables

### **BMS_App_02.X Priority Variables**

#### **BMS Module (bms.c)**
| Current Name | New Name | Type | Priority | Risk |
|-------------|----------|------|----------|------|
| `state` | `bms_currentState` | static | 🔴 Critical | Low |
| `temp` | `bms_temperature` | local | 🔴 Critical | Low |
| `val` | `voltageReading` | local | 🔴 Critical | Low |

#### **LTC6802 Module (ltc_6802.c)**
| Current Name | New Name | Type | Priority | Risk |
|-------------|----------|------|----------|------|
| `config_data[6]` | `ltc_configData[6]` | static | 🔴 Critical | Medium |
| `flag_data` | `ltc_statusFlags` | static | 🔴 Critical | Medium |
| `cellVoltage` | `ltc_cellVoltage` | local | 🔴 Critical | Low |
| `temperature` | `ltc_temperatureData` | local | 🔴 Critical | Low |
| `address` | `chipAddress` | parameter | 🔴 Critical | Low |

#### **J1772 Module (j1772.c)**
| Current Name | New Name | Type | Priority | Risk |
|-------------|----------|------|----------|------|
| `proximity` | `j1772_proximityState` | static | 🔴 Critical | Low |
| `state` | `j1772_currentState` | static | 🔴 Critical | Low |
| `pilotVoltagePeak` | `j1772_pilotVoltagePeak` | static | 🔴 Critical | Low |
| `currentProxAve` | `j1772_proximityAverage` | static | 🔴 Critical | Low |
| `j1772run` | `j1772_isRunning` | static | 🔴 Critical | Low |

---

### **MCU_App.X Priority Variables**

#### **LV Battery Module (lvBattery.c)**
| Current Name | New Name | Type | Priority | Risk |
|-------------|----------|------|----------|------|
| `lvBattery_run` | `lvBatt_isRunning` | static | 🔴 Critical | Low |
| `state` | `lvBatt_currentState` | local | 🔴 Critical | Low |
| `voltage` | `batteryVoltage` | local | 🔴 Critical | Low |

#### **Ignition Control Module (IgnitionControl.c)**
| Current Name | New Name | Type | Priority | Risk |
|-------------|----------|------|----------|------|
| `killButton` | `ignition_killButton` | static | 🔴 Critical | Low |
| `ignitionButton` | `ignition_startButton` | static | 🔴 Critical | Low |
| `state` | `ignition_currentState` | local | 🔴 Critical | Low |

#### **Heated Grips Module (HeatedGrips.c)**
| Current Name | New Name | Type | Priority | Risk |
|-------------|----------|------|----------|------|
| `heatedGripsRun` | `hgrip_isRunning` | static | 🔴 Critical | Low |
| `state` | `hgrip_currentState` | local | 🔴 Critical | Low |
| `temperature` | `hgrip_targetTemperature` | local | 🔴 Critical | Low |

---

## 🟡 IMPORTANT - State and Control Variables

### **State Machine Variables**

#### **StateMachine.c (BMS_App_02.X & MCU_App.X)**
| Current Name | New Name | Type | Priority | Risk |
|-------------|----------|------|----------|------|
| `curState` | `stateMachine_currentState` | static | 🟡 Important | Low |
| `prevState` | `stateMachine_previousState` | static | 🟡 Important | Low |
| `nextState` | `stateMachine_nextState` | local | 🟡 Important | Low |

### **Task/Scheduler Variables**

#### **tsk.c Files**
| Current Name | New Name | Type | Priority | Risk |
|-------------|----------|------|----------|------|
| `counter_led` | `task_ledCounter` | static | 🟡 Important | Low |
| `counter_can` | `task_canCounter` | static | 🟡 Important | Low |
| `debugEnable` | `task_debugEnabled` | static | 🟡 Important | Low |

---

## 🟢 STANDARD - Code Quality Variables

### **Generic Names to Fix**

#### **Common Patterns Across Projects**
| Current Pattern | New Pattern | Example | Priority |
|----------------|-------------|---------|----------|
| `temp` | `descriptiveName` | `tempReading` → `sensorTemperature` | 🟢 Standard |
| `val`/`value` | `descriptiveName` | `val` → `adcReading` | 🟢 Standard |
| `data` | `descriptiveName` | `data` → `rxBuffer` | 🟢 Standard |
| `i`/`x`/`y` | Keep for short loops | Loop counters OK | 🟢 Standard |

### **Buffer and Array Names**

#### **Common Buffer Variables**
| Current Name | New Name | Type | Priority | Risk |
|-------------|----------|------|----------|------|
| `rxBuffer` | `can_rxBuffer` | static | 🟢 Standard | Low |
| `txBuffer` | `can_txBuffer` | static | 🟢 Standard | Low |
| `ThisTXBuffer` | `can_currentTxBuffer` | local | 🟢 Standard | Low |
| `bootByte[]` | `boot_dataBuffer[]` | static | 🟢 Standard | Low |
| `dummyByte[]` | `comm_dummyBuffer[]` | static | 🟢 Standard | Low |

---

## Constants and Macros to Standardize

### **🔴 Critical Constants**

#### **Safety-Critical Values**
| Current Name | New Name | Priority | Risk |
|-------------|----------|----------|------|
| `DEBUG` | `BMS_DEBUG_ENABLE` | 🔴 Critical | Low |
| `CAN_DEBUG` | `CAN_DEBUG_ENABLE` | 🔴 Critical | Low |

#### **Well-Named Constants (Keep As-Is)**
- `PROX_DISCONNECT_UPPER`
- `LV_BATTERY_CHARGE_FULL_LEVEL`
- `KILL_SWITCH_DEBOUNCE_TIME`
- `NUM_OF_ECAN_BUFFERS`

---

## Implementation Strategy

### **Phase 3A: Critical Safety Variables (BMS_App_02.X)**
**Execution Order:**
1. **J1772 Module** (5 variables - charging safety)
2. **BMS Module** (3 variables - battery management)
3. **LTC6802 Module** (5 variables - cell monitoring)

**Risk Assessment:** Low-Medium (LTC6802 has more complex dependencies)

### **Phase 3B: Critical Control Variables (MCU_App.X)**
**Execution Order:**
1. **LV Battery Module** (3 variables - power management)
2. **Ignition Control** (3 variables - vehicle control)
3. **Heated Grips** (3 variables - comfort system)

**Risk Assessment:** Low (simpler dependencies)

### **Phase 3C: State and Task Variables**
**Execution Order:**
1. **StateMachine modules** (3 variables each)
2. **Task scheduler variables** (3 variables)

**Risk Assessment:** Low (well-isolated variables)

### **Phase 3D: Code Quality Variables**
**Execution Order:**
1. **Generic name replacements** (temp, val, data)
2. **Buffer name standardization**
3. **Constant standardization**

**Risk Assessment:** Very Low (cosmetic improvements)

---

## Search and Replace Strategy

### **Step-by-Step Process:**
1. **Find all occurrences** of the variable
2. **Verify context** to ensure correct replacement
3. **Update declarations** first
4. **Update all usages** systematically
5. **Test build** after each module

### **Example Commands:**
```bash
# Find all occurrences
grep -r "proximity" Projects/BMS_App_02.X/ --include="*.c" --include="*.h"

# Replace (with verification)
sed -i 's/\bproximity\b/j1772_proximityState/g' Projects/BMS_App_02.X/j1772.c
sed -i 's/\bproximity\b/j1772_proximityState/g' Projects/BMS_App_02.X/j1772.h
```

---

## Files Requiring Updates

### **High Priority Files:**

**BMS_App_02.X:**
- `j1772.c` / `j1772.h` - 5 critical variables
- `bms.c` / `bms.h` - 3 critical variables
- `ltc_6802.c` / `ltc_6802.h` - 5 critical variables

**MCU_App.X:**
- `lvBattery.c` / `lvBattery.h` - 3 critical variables
- `IgnitionControl.c` / `IgnitionControl.h` - 3 critical variables
- `HeatedGrips.c` / `HeatedGrips.h` - 3 critical variables

**Shared:**
- `StateMachine.c` (both projects) - 3 variables each
- `tsk.c` (both projects) - 3 variables each

---

## Testing Strategy

### **After Each Module:**
1. **Build verification** - Ensure no compilation errors
2. **Variable scope check** - Ensure no naming conflicts
3. **Functionality test** - If possible, verify operation

### **Risk Mitigation:**
1. **Start with lowest risk** (static variables first)
2. **One module at a time** to isolate issues
3. **Test builds frequently** to catch problems early
4. **Keep backup** of working state

---

## Success Criteria

### **Phase 3A Complete:**
- ✅ All BMS safety variables follow `module_variablePurpose` pattern
- ✅ J1772 charging variables clearly identified
- ✅ LTC6802 battery monitoring variables standardized
- ✅ BMS_App_02.X builds successfully

### **Phase 3B Complete:**
- ✅ All MCU control variables follow standard pattern
- ✅ Vehicle control variables clearly identified
- ✅ Power management variables standardized
- ✅ MCU_App.X builds successfully

### **Phase 3C Complete:**
- ✅ State machine variables consistent across projects
- ✅ Task scheduler variables standardized
- ✅ All state variables clearly identified

### **Phase 3D Complete:**
- ✅ No generic variable names remain
- ✅ All buffers have descriptive names
- ✅ Constants follow MODULE_CONSTANT pattern
- ✅ Professional automotive variable naming achieved

This systematic approach ensures safety-critical variables are handled first with minimal risk, while progressively improving code quality throughout the entire codebase.