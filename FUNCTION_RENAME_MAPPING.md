# Function Rename Mapping - Phase 2 Standardization

## Overview
This document provides the systematic mapping for standardizing function names across active projects according to automotive naming conventions.

## Priority Order
🔴 **Critical** - Safety-critical functions (BMS, Battery, Charging)
🟡 **Important** - Control functions  
🟢 **Standard** - Service/debug functions

---

## 🔴 CRITICAL - BMS_App_02.X Safety Functions

### **BMS Module (bms.c/bms.h)**
| Current Name | New Name | Priority | Risk |
|-------------|----------|----------|------|
| `BMS_init()` | `BMS_Init()` | 🔴 Critical | Low |
| `BMS_run_10ms()` | `BMS_Run_10ms()` | 🔴 Critical | Low |
| `BMS_run_1000ms()` | `BMS_Run_1000ms()` | 🔴 Critical | Low |

### **LTC6802 Module (ltc_6802.c/ltc_6802.h)**
| Current Name | New Name | Priority | Risk |
|-------------|----------|----------|------|
| `LTC6802_init()` | `LTC6802_Init()` | 🔴 Critical | Low |
| `LTC6802_startCellVoltageADC()` | `LTC6802_StartCellVoltageADC()` | 🔴 Critical | Medium |
| `LTC6802_startTempADC()` | `LTC6802_StartTempADC()` | 🔴 Critical | Medium |
| `LTC6802_readCellVoltages()` | `LTC6802_ReadCellVoltages()` | 🔴 Critical | Medium |
| `LTC6802_readTemperatures()` | `LTC6802_ReadTemperatures()` | 🔴 Critical | Medium |
| `LTC6802_readConfig()` | `LTC6802_ReadConfig()` | 🔴 Critical | Medium |
| `LTC6802_writeConfig()` | `LTC6802_WriteConfig()` | 🔴 Critical | Medium |
| `LTC6802_setCellBalancing()` | `LTC6802_SetCellBalancing()` | 🔴 Critical | Medium |
| `LTC6802_clearCellBalancing()` | `LTC6802_ClearCellBalancing()` | 🔴 Critical | Medium |

### **J1772 Module (j1772.c/j1772.h)**
| Current Name | New Name | Priority | Risk |
|-------------|----------|----------|------|
| `j1772getProxState()` | `J1772_GetProxState()` | 🔴 Critical | Low |
| `j1772getPilotCurrent()` | `J1772_GetPilotCurrent()` | 🔴 Critical | Low |
| `j1772getVoltage()` | `J1772_GetVoltage()` | 🔴 Critical | Low |
| `j1772getCurrentLimit()` | `J1772_GetCurrentLimit()` | 🔴 Critical | Low |
| `j1772getState()` | `J1772_GetState()` | 🔴 Critical | Low |

---

## 🟡 IMPORTANT - MCU_App.X Control Functions

### **LV Battery Module (lvBattery.c/lvBattery.h)**
| Current Name | New Name | Priority | Risk |
|-------------|----------|----------|------|
| `lvBattery_Init()` | `LvBattery_Init()` | 🟡 Important | Low |
| `lvBattery_Run_10ms()` | `LvBattery_Run_10ms()` | 🟡 Important | Low |
| `lvBattery_Halt()` | `LvBattery_Halt()` | 🟡 Important | Low |
| `lvBattery_GetState()` | `LvBattery_GetState()` | 🟡 Important | Low |

### **Ignition Control Module (IgnitionControl.c/IgnitionControl.h)**
| Current Name | New Name | Priority | Risk |
|-------------|----------|----------|------|
| `IgnitionControl_getKillStatus()` | `IgnitionControl_GetKillStatus()` | 🟡 Important | Low |
| `IgnitionControl_getIgnitionStatus()` | `IgnitionControl_GetIgnitionStatus()` | 🟡 Important | Low |

---

## 🟢 STANDARD - E_MOTO.X Service Functions

### **Service Functions (main.c and service files)**
| Current Name | New Name | Priority | Risk |
|-------------|----------|----------|------|
| `canService()` | `CanService()` | 🟢 Standard | Low |
| `debuggerService()` | `DebuggerService()` | 🟢 Standard | Low |
| `touchScreenService()` | `TouchScreenService()` | 🟢 Standard | Low |

### **Debug Functions**
| Current Name | New Name | Priority | Risk |
|-------------|----------|----------|------|
| `touchScreenDebug()` | `TouchScreen_Debug()` | 🟢 Standard | Low |
| `debug_Debug()` | `Debugger_Debug()` | 🟢 Standard | Low |
| `can_Debug()` | `Can_Debug()` | 🟢 Standard | Low |

---

## Functions to Keep (Already Correct)

### **Excellent Examples - DO NOT CHANGE:**
- `HeatedGripControl_Init()`, `HeatedGripControl_Run_100ms()`, `HeatedGripControl_Halt()`
- `HornControl_Init()`, `HornControl_Run_10ms()`, `HornControl_Halt()`
- `LightsControl_Init()`, `LightsControl_Run_100ms()`, `LightsControl_Halt()`
- `IgnitionControl_Init()`, `IgnitionControl_Run_10ms()`, `IgnitionControl_Halt()`
- `StateMachine_Init()`, `StateMachine_Run()`
- `DCDC_init()`, `DCDC_run_1ms()`, `DCDC_run_100ms()`, `DCDC_halt()`, `DCDC_run()`

---

## Implementation Strategy

### **Phase 2A: Critical Safety Functions (BMS_App_02.X)**
**Execution Order:**
1. **BMS module** (3 functions - lowest risk)
2. **J1772 module** (5 functions - charging safety)
3. **LTC6802 module** (9 functions - highest impact but manageable)

**Risk Mitigation:**
- Start with simple function renames (BMS module)
- Test build after each module
- LTC6802 has most function calls - requires careful verification

### **Phase 2B: Control Functions (MCU_App.X)**
**Execution Order:**
1. **LV Battery module** (4 functions)
2. **Ignition Control getters** (2 functions)

### **Phase 2C: Service Functions (E_MOTO.X)**
**Execution Order:**
1. **Main service functions** (3 functions)
2. **Debug functions** (3 functions)

---

## File Impact Analysis

### **Files That Will Need Updates:**

**BMS_App_02.X:**
- `main.c` - Calls BMS_init(), BMS_run_*()
- `bms.c` - Function definitions
- `bms.h` - Function declarations
- `ltc_6802.c` - Function definitions
- `ltc_6802.h` - Function declarations
- `j1772.c` - Function definitions
- `j1772.h` - Function declarations
- Any other files calling these functions

**MCU_App.X:**
- `main.c` - Calls lvBattery functions
- `lvBattery.c` - Function definitions
- `lvBattery.h` - Function declarations
- `IgnitionControl.c` - Function definitions
- `IgnitionControl.h` - Function declarations

**E_MOTO.X:**
- `main.c` - Calls service functions
- `canService.c` - Function definitions
- `debuggerService.c` - Function definitions
- `touchScreenService.c` - Function definitions
- Corresponding .h files

---

## Search and Replace Commands

### **BMS Module Example:**
```bash
# Find all occurrences
grep -r "BMS_init" Projects/BMS_App_02.X/
grep -r "BMS_run_10ms" Projects/BMS_App_02.X/
grep -r "BMS_run_1000ms" Projects/BMS_App_02.X/

# Replace (example for BMS_init)
sed -i 's/BMS_init(/BMS_Init(/g' Projects/BMS_App_02.X/*.c Projects/BMS_App_02.X/*.h
```

### **LTC6802 Module Example:**
```bash
# Find all occurrences of each function
grep -r "LTC6802_init" Projects/BMS_App_02.X/
# ... repeat for each function

# Batch replace
sed -i 's/LTC6802_init(/LTC6802_Init(/g' Projects/BMS_App_02.X/*.c Projects/BMS_App_02.X/*.h
sed -i 's/LTC6802_startCellVoltageADC(/LTC6802_StartCellVoltageADC(/g' Projects/BMS_App_02.X/*.c Projects/BMS_App_02.X/*.h
# ... continue for each function
```

---

## Testing Strategy

### **After Each Module:**
1. **Build the project** to verify no compilation errors
2. **Check for missed references** using grep
3. **Verify function calls** are updated correctly
4. **Test functionality** if possible

### **Final Verification:**
1. **All projects build successfully**
2. **No old function names remain** in active code
3. **Function calls match declarations**
4. **Generated code still works** (CAN DBC functions)

---

## Rollback Plan

### **If Issues Occur:**
1. **Use git** to revert changes (if version controlled)
2. **Manual revert** using reverse sed commands
3. **Restore from backup** if major issues

### **Backup Strategy:**
1. **Create backup** of each project before starting
2. **Test each module** before proceeding to next
3. **Document any custom changes** needed

---

## Success Criteria

### **Phase 2A Complete:**
- ✅ All BMS safety functions follow `Module_Action()` pattern
- ✅ All J1772 functions follow `J1772_Action()` pattern  
- ✅ All LTC6802 functions follow `LTC6802_Action()` pattern
- ✅ BMS_App_02.X builds successfully

### **Phase 2B Complete:**
- ✅ LV Battery functions follow `LvBattery_Action()` pattern
- ✅ Ignition Control getters follow `Module_GetAction()` pattern
- ✅ MCU_App.X builds successfully

### **Phase 2C Complete:**
- ✅ All service functions follow `Service()` pattern
- ✅ All debug functions follow `Module_Debug()` pattern
- ✅ E_MOTO.X builds successfully

### **Phase 2 Overall Complete:**
- ✅ All active projects follow automotive naming standards
- ✅ Function naming is consistent across projects
- ✅ Code is ready for professional development
- ✅ Future development follows established patterns

This systematic approach ensures safety-critical functions are handled first with minimal risk, while progressively standardizing the entire codebase.