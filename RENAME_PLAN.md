# Voltworks Garage Firmware Rename Plan

## Overview
This document outlines the systematic approach to fixing typos and standardizing naming conventions across the Voltworks Garage firmware codebase. The plan is organized by priority to minimize disruption while ensuring consistency.

## Priority Levels

### 🔴 **CRITICAL (Phase 1)** - Fix Immediately
These are actual typos that cause inconsistency between .c and .h files and can cause confusion.

### 🟡 **HIGH (Phase 2)** - Standardize Active Projects
Focus on currently active projects (not legacy code) to establish consistent patterns.

### 🟢 **MEDIUM (Phase 3)** - Legacy Code Cleanup
Clean up legacy code to match new standards.

### 🔵 **LOW (Phase 4)** - Optional Improvements
Nice-to-have improvements that enhance consistency but don't affect functionality.

---

## 🔴 CRITICAL - Phase 1: Fix Filename Typos

### **Priority: IMMEDIATE**
**Impact**: These typos cause inconsistency between .c and .h files and must be fixed first.

#### Active Projects (Non-Legacy):
1. **BMS_App_02.X**
   - `debuggerSerivce.c` → `debuggerService.c`

2. **BMS_Bootloader_02.X**
   - `debuggerSerivce.c` → `debuggerService.c`

3. **EMOTO_Bootloader.X**
   - `debuggerSerivce.c` → `debuggerService.c`

4. **E_MOTO.X**
   - `canSerivce.c` → `canService.c`
   - `debuggerSerivce.c` → `debuggerService.c`
   - `touchScreenSerivce.c` → `touchScreenService.c`

5. **MCU_App.X**
   - `debuggerSerivce.c` → `debuggerService.c`
   - `templateSerivce.c` → `templateService.c`

6. **MCU_Bootloader.X**
   - `debuggerSerivce.c` → `debuggerService.c`

#### Files to Update After Rename:
For each renamed file, update:
- **Include statements** in other .c files
- **Makefile references**
- **Project file references** (.xml, .mk files)
- **Any build scripts**

### **Expected Impact**: 
- ✅ Fixes 9 critical typos in active projects
- ✅ Establishes consistency between .c and .h files
- ✅ Prevents future confusion and build issues

---

## 🟡 HIGH - Phase 2: Standardize Active Projects

### **Priority: HIGH**
**Impact**: Standardizes naming in currently active projects for consistency.

#### Function Name Standardization
Focus on public API functions in active projects:

1. **BMS_App_02.X**
   - Review `bms.c` functions for `BMS_Action_Timing()` pattern
   - Review `ltc_6802.c` functions for `LTC6802_Action()` pattern
   - Review `j1772.c` functions for `J1772_Action()` pattern

2. **MCU_App.X**
   - Review `HeatedGrips.c` functions for `HeatedGrips_Action_Timing()` pattern
   - Review `HornControl.c` functions for `HornControl_Action()` pattern
   - Review `LightsControl.c` functions for `LightsControl_Action()` pattern

3. **E_MOTO.X**
   - Review service functions for `Service_Action()` pattern
   - Review framework functions for consistency

#### Variable Name Standardization
Focus on global and static variables:

1. **Consistent camelCase** for local variables
2. **Module prefix** for static variables
3. **g_ prefix** for global variables (if any)

### **Expected Impact**:
- ✅ Establishes consistent patterns in active projects
- ✅ Makes code more readable and maintainable
- ✅ Provides template for future development

---

## 🟢 MEDIUM - Phase 3: Legacy Code Cleanup

### **Priority: MEDIUM**
**Impact**: Cleans up legacy code to match new standards.

#### Legacy Projects to Update:
1. **OLD_LEGACY_STUFF/BMS_App.X**
   - `debuggerSerivce.c` → `debuggerService.c`

2. **OLD_LEGACY_STUFF/BMS_Bootloader.X**
   - `debuggerSerivce.c` → `debuggerService.c`

3. **OLD_LEGACY_STUFF/Framework**
   - `debuggerSerivce.c` → `debuggerService.c`
   - `templateSerivce.c` → `templateService.c`

4. **OLD_LEGACY_STUFF/IC_Controller_Bringup**
   - `debuggerSerivce.c` → `debuggerService.c`

5. **OLD_LEGACY_STUFF/IC_TEST_PERIPHERALS**
   - `debuggerSerivce.c` → `debuggerService.c`

#### Decision Point:
**Consider whether legacy code should be:**
- ❓ **Kept and updated** (if still referenced)
- ❓ **Archived** (if no longer used)
- ❓ **Removed** (if completely obsolete)

### **Expected Impact**:
- ✅ Removes confusion between legacy and current code
- ✅ Maintains consistency across entire codebase
- ✅ Easier to find and reference code

---

## 🔵 LOW - Phase 4: Optional Improvements

### **Priority: LOW**
**Impact**: Nice-to-have improvements that enhance consistency.

#### Library and Driver Standardization:
1. **Libraries/Drivers/** - Consider standardizing to snake_case
2. **PIC33_plib/** - Keep as-is (hardware abstraction)
3. **Standard/** - Review for consistency

#### Constant and Macro Standardization:
1. **Review #define naming** across all files
2. **Standardize ALL_CAPS** with underscores
3. **Add module prefixes** to constants

#### Type Definition Standardization:
1. **Add _E suffix** to all enums
2. **Add _S suffix** to all structs
3. **Add _FPtr suffix** to function pointers

### **Expected Impact**:
- ✅ Complete consistency across entire codebase
- ✅ Follows automotive industry standards
- ✅ Easier maintenance and development

---

## Implementation Strategy

### Phase 1 Execution Steps:
1. **Backup current project** (create git branch or zip)
2. **Rename files** one project at a time
3. **Update includes** in affected files
4. **Update build files** (Makefiles, project files)
5. **Test build** after each project
6. **Verify functionality** if possible

### Phase 2 Execution Steps:
1. **Sample key files** to understand current function naming
2. **Create function rename mapping** for each module
3. **Update function names** systematically
4. **Update all callers** of renamed functions
5. **Test build** and functionality

### Phase 3 & 4 Execution Steps:
1. **Evaluate legacy code** usage and necessity
2. **Apply same patterns** as active projects
3. **Consider consolidation** opportunities
4. **Document** any deviations from standard

---

## Risk Assessment

### **Low Risk** 🟢
- Filename typo fixes (Phase 1)
- Variable name standardization
- Constant/macro standardization

### **Medium Risk** 🟡
- Function name changes in active projects
- Build file updates
- Include path updates

### **High Risk** 🔴
- Changes to generated code
- Changes to hardware abstraction layer
- Changes to interrupt handlers

---

## Verification Checklist

### After Each Phase:
- [ ] All projects compile successfully
- [ ] No broken includes or missing references
- [ ] Build files updated correctly
- [ ] Functionality testing (if possible)
- [ ] Documentation updated

### Final Verification:
- [ ] All typos fixed
- [ ] Naming conventions consistent
- [ ] Build system works correctly
- [ ] Code follows CODING_STANDARDS.md
- [ ] Legacy code status documented

---

## Tools and Scripts

### Recommended Tools:
1. **Text Editor with Regex**: For batch find/replace
2. **grep/ripgrep**: For finding all references
3. **IDE Refactoring Tools**: For safe renaming
4. **Build Verification**: After each change

### Potential Scripts:
1. **rename_files.sh**: Batch file renaming
2. **update_includes.sh**: Update include statements
3. **verify_build.sh**: Automated build verification

---

## Timeline Estimate

### Phase 1: 2-4 hours
- File renames: 1 hour
- Include updates: 1 hour
- Build verification: 1-2 hours

### Phase 2: 4-8 hours
- Function analysis: 2 hours
- Function renames: 2-4 hours
- Testing: 1-2 hours

### Phase 3: 2-4 hours
- Legacy evaluation: 1 hour
- Legacy cleanup: 1-2 hours
- Verification: 1 hour

### Phase 4: 4-6 hours
- Complete standardization: 3-4 hours
- Final verification: 1-2 hours

**Total Estimated Time: 12-22 hours**

---

## Success Criteria

### Phase 1 Complete:
- ✅ No filename typos remain
- ✅ All .c files match corresponding .h files
- ✅ All projects build successfully

### Phase 2 Complete:
- ✅ Active projects follow consistent naming
- ✅ Public APIs use standard patterns
- ✅ Variables follow camelCase convention

### Phase 3 Complete:
- ✅ Legacy code cleaned up or documented
- ✅ No inconsistencies between legacy and current

### Phase 4 Complete:
- ✅ Entire codebase follows CODING_STANDARDS.md
- ✅ Ready for future development
- ✅ Maintainable and professional codebase

This plan provides a systematic approach to improving code quality while minimizing risk and maintaining project functionality.