#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-EVAL_2.mk)" "nbproject/Makefile-local-EVAL_2.mk"
include nbproject/Makefile-local-EVAL_2.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=EVAL_2
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/E_MOTO.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/E_MOTO.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=-mafrlcsj
else
COMPARISON_BUILD=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=../../RTOS/framework/framework.c touchScreenService.c framework_taskRunner.c debuggerService.c movingAverage.c canService.c ../../Libraries/PIC33_plib/src/ADC.c ../../Libraries/PIC33_plib/src/init.c ../../Drivers/TFT_LCD/src/DISPLAY_INTERFACE.c ../../Drivers/TFT_LCD/src/TFT_LCD.c ../../Drivers/TFT_LCD/src/TFT_LCD_Q.c ../../Drivers/TFT_LCD/src/TOUCH_SCREEN.c ../../Libraries/PIC33_plib/src/pins.c ../../Drivers/PingSensor/ping.c ../../Libraries/PIC33_plib/src/i2c.c ../../Libraries/PIC33_plib/inc/buttons.c ../../Drivers/LED_16bit_shift/led_driver.c ../../Libraries/PIC33_plib/src/CAN.c main.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/_ext/1820936309/framework.o ${OBJECTDIR}/touchScreenService.o ${OBJECTDIR}/framework_taskRunner.o ${OBJECTDIR}/debuggerService.o ${OBJECTDIR}/movingAverage.o ${OBJECTDIR}/canService.o ${OBJECTDIR}/_ext/356824117/ADC.o ${OBJECTDIR}/_ext/356824117/init.o ${OBJECTDIR}/_ext/1927342817/DISPLAY_INTERFACE.o ${OBJECTDIR}/_ext/1927342817/TFT_LCD.o ${OBJECTDIR}/_ext/1927342817/TFT_LCD_Q.o ${OBJECTDIR}/_ext/1927342817/TOUCH_SCREEN.o ${OBJECTDIR}/_ext/356824117/pins.o ${OBJECTDIR}/_ext/899432208/ping.o ${OBJECTDIR}/_ext/356824117/i2c.o ${OBJECTDIR}/_ext/356814383/buttons.o ${OBJECTDIR}/_ext/982589299/led_driver.o ${OBJECTDIR}/_ext/356824117/CAN.o ${OBJECTDIR}/main.o
POSSIBLE_DEPFILES=${OBJECTDIR}/_ext/1820936309/framework.o.d ${OBJECTDIR}/touchScreenService.o.d ${OBJECTDIR}/framework_taskRunner.o.d ${OBJECTDIR}/debuggerService.o.d ${OBJECTDIR}/movingAverage.o.d ${OBJECTDIR}/canService.o.d ${OBJECTDIR}/_ext/356824117/ADC.o.d ${OBJECTDIR}/_ext/356824117/init.o.d ${OBJECTDIR}/_ext/1927342817/DISPLAY_INTERFACE.o.d ${OBJECTDIR}/_ext/1927342817/TFT_LCD.o.d ${OBJECTDIR}/_ext/1927342817/TFT_LCD_Q.o.d ${OBJECTDIR}/_ext/1927342817/TOUCH_SCREEN.o.d ${OBJECTDIR}/_ext/356824117/pins.o.d ${OBJECTDIR}/_ext/899432208/ping.o.d ${OBJECTDIR}/_ext/356824117/i2c.o.d ${OBJECTDIR}/_ext/356814383/buttons.o.d ${OBJECTDIR}/_ext/982589299/led_driver.o.d ${OBJECTDIR}/_ext/356824117/CAN.o.d ${OBJECTDIR}/main.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/1820936309/framework.o ${OBJECTDIR}/touchScreenService.o ${OBJECTDIR}/framework_taskRunner.o ${OBJECTDIR}/debuggerService.o ${OBJECTDIR}/movingAverage.o ${OBJECTDIR}/canService.o ${OBJECTDIR}/_ext/356824117/ADC.o ${OBJECTDIR}/_ext/356824117/init.o ${OBJECTDIR}/_ext/1927342817/DISPLAY_INTERFACE.o ${OBJECTDIR}/_ext/1927342817/TFT_LCD.o ${OBJECTDIR}/_ext/1927342817/TFT_LCD_Q.o ${OBJECTDIR}/_ext/1927342817/TOUCH_SCREEN.o ${OBJECTDIR}/_ext/356824117/pins.o ${OBJECTDIR}/_ext/899432208/ping.o ${OBJECTDIR}/_ext/356824117/i2c.o ${OBJECTDIR}/_ext/356814383/buttons.o ${OBJECTDIR}/_ext/982589299/led_driver.o ${OBJECTDIR}/_ext/356824117/CAN.o ${OBJECTDIR}/main.o

# Source Files
SOURCEFILES=../../RTOS/framework/framework.c touchScreenService.c framework_taskRunner.c debuggerService.c movingAverage.c canService.c ../../Libraries/PIC33_plib/src/ADC.c ../../Libraries/PIC33_plib/src/init.c ../../Drivers/TFT_LCD/src/DISPLAY_INTERFACE.c ../../Drivers/TFT_LCD/src/TFT_LCD.c ../../Drivers/TFT_LCD/src/TFT_LCD_Q.c ../../Drivers/TFT_LCD/src/TOUCH_SCREEN.c ../../Libraries/PIC33_plib/src/pins.c ../../Drivers/PingSensor/ping.c ../../Libraries/PIC33_plib/src/i2c.c ../../Libraries/PIC33_plib/inc/buttons.c ../../Drivers/LED_16bit_shift/led_driver.c ../../Libraries/PIC33_plib/src/CAN.c main.c



CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-EVAL_2.mk ${DISTDIR}/E_MOTO.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=33EP256MC506
MP_LINKER_FILE_OPTION=,--script=p33EP256MC506.gld
# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/1820936309/framework.o: ../../RTOS/framework/framework.c  .generated_files/flags/EVAL_2/e175b9e1b55a8407b4208bf5be564fedf720946f .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1820936309" 
	@${RM} ${OBJECTDIR}/_ext/1820936309/framework.o.d 
	@${RM} ${OBJECTDIR}/_ext/1820936309/framework.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../RTOS/framework/framework.c  -o ${OBJECTDIR}/_ext/1820936309/framework.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1820936309/framework.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/touchScreenService.o: touchScreenService.c  .generated_files/flags/EVAL_2/32fb775beb3ac83beb9a6ae10ea90d5086cc2d8d .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/touchScreenService.o.d 
	@${RM} ${OBJECTDIR}/touchScreenService.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  touchScreenService.c  -o ${OBJECTDIR}/touchScreenService.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/touchScreenService.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/framework_taskRunner.o: framework_taskRunner.c  .generated_files/flags/EVAL_2/9a3a33ccc53133fa53e191f605d4bf0fcff6460f .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/framework_taskRunner.o.d 
	@${RM} ${OBJECTDIR}/framework_taskRunner.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  framework_taskRunner.c  -o ${OBJECTDIR}/framework_taskRunner.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/framework_taskRunner.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/debuggerService.o: debuggerService.c  .generated_files/flags/EVAL_2/e867667304bdec1411cbb2cd622f4c45d5a19e66 .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/debuggerService.o.d 
	@${RM} ${OBJECTDIR}/debuggerService.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  debuggerService.c  -o ${OBJECTDIR}/debuggerService.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/debuggerService.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/movingAverage.o: movingAverage.c  .generated_files/flags/EVAL_2/ac2a487674b2661bf48b2ddf1ae7186b2a8bb03f .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/movingAverage.o.d 
	@${RM} ${OBJECTDIR}/movingAverage.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  movingAverage.c  -o ${OBJECTDIR}/movingAverage.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/movingAverage.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/canService.o: canService.c  .generated_files/flags/EVAL_2/5641782b44e6ddd19447cfed6973d6d972bef348 .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/canService.o.d 
	@${RM} ${OBJECTDIR}/canService.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  canService.c  -o ${OBJECTDIR}/canService.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/canService.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/356824117/ADC.o: ../../Libraries/PIC33_plib/src/ADC.c  .generated_files/flags/EVAL_2/4f54f5ff8296d4a666ef04614829aaa82d2a94e1 .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/ADC.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/ADC.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/ADC.c  -o ${OBJECTDIR}/_ext/356824117/ADC.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/ADC.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/356824117/init.o: ../../Libraries/PIC33_plib/src/init.c  .generated_files/flags/EVAL_2/47beaaf5a68b13d8426d427e93c984c59d14654a .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/init.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/init.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/init.c  -o ${OBJECTDIR}/_ext/356824117/init.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/init.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1927342817/DISPLAY_INTERFACE.o: ../../Drivers/TFT_LCD/src/DISPLAY_INTERFACE.c  .generated_files/flags/EVAL_2/d0cd425f5072b2ddb53e564785209fcf06db277d .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1927342817" 
	@${RM} ${OBJECTDIR}/_ext/1927342817/DISPLAY_INTERFACE.o.d 
	@${RM} ${OBJECTDIR}/_ext/1927342817/DISPLAY_INTERFACE.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Drivers/TFT_LCD/src/DISPLAY_INTERFACE.c  -o ${OBJECTDIR}/_ext/1927342817/DISPLAY_INTERFACE.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1927342817/DISPLAY_INTERFACE.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1927342817/TFT_LCD.o: ../../Drivers/TFT_LCD/src/TFT_LCD.c  .generated_files/flags/EVAL_2/bdd688841eb55b60119394a16c81772e7a795c96 .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1927342817" 
	@${RM} ${OBJECTDIR}/_ext/1927342817/TFT_LCD.o.d 
	@${RM} ${OBJECTDIR}/_ext/1927342817/TFT_LCD.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Drivers/TFT_LCD/src/TFT_LCD.c  -o ${OBJECTDIR}/_ext/1927342817/TFT_LCD.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1927342817/TFT_LCD.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1927342817/TFT_LCD_Q.o: ../../Drivers/TFT_LCD/src/TFT_LCD_Q.c  .generated_files/flags/EVAL_2/a7c36c69916436a8267242c192bccbaae7f4b1f3 .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1927342817" 
	@${RM} ${OBJECTDIR}/_ext/1927342817/TFT_LCD_Q.o.d 
	@${RM} ${OBJECTDIR}/_ext/1927342817/TFT_LCD_Q.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Drivers/TFT_LCD/src/TFT_LCD_Q.c  -o ${OBJECTDIR}/_ext/1927342817/TFT_LCD_Q.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1927342817/TFT_LCD_Q.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1927342817/TOUCH_SCREEN.o: ../../Drivers/TFT_LCD/src/TOUCH_SCREEN.c  .generated_files/flags/EVAL_2/df91769be1135341d440daff103b06217748be54 .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1927342817" 
	@${RM} ${OBJECTDIR}/_ext/1927342817/TOUCH_SCREEN.o.d 
	@${RM} ${OBJECTDIR}/_ext/1927342817/TOUCH_SCREEN.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Drivers/TFT_LCD/src/TOUCH_SCREEN.c  -o ${OBJECTDIR}/_ext/1927342817/TOUCH_SCREEN.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1927342817/TOUCH_SCREEN.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/356824117/pins.o: ../../Libraries/PIC33_plib/src/pins.c  .generated_files/flags/EVAL_2/5ad61f2c3bf0a769b84dcacfb422b4fafa1bcca9 .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/pins.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/pins.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/pins.c  -o ${OBJECTDIR}/_ext/356824117/pins.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/pins.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/899432208/ping.o: ../../Drivers/PingSensor/ping.c  .generated_files/flags/EVAL_2/3a55aaeed155c09650e043a4e78af17b5c7eec72 .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/899432208" 
	@${RM} ${OBJECTDIR}/_ext/899432208/ping.o.d 
	@${RM} ${OBJECTDIR}/_ext/899432208/ping.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Drivers/PingSensor/ping.c  -o ${OBJECTDIR}/_ext/899432208/ping.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/899432208/ping.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/356824117/i2c.o: ../../Libraries/PIC33_plib/src/i2c.c  .generated_files/flags/EVAL_2/8619e8368c7d9cb0464f521726b6181a2a864d60 .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/i2c.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/i2c.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/i2c.c  -o ${OBJECTDIR}/_ext/356824117/i2c.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/i2c.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/356814383/buttons.o: ../../Libraries/PIC33_plib/inc/buttons.c  .generated_files/flags/EVAL_2/660ee93dc08fcfb876c77738de813f11328cd0a4 .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356814383" 
	@${RM} ${OBJECTDIR}/_ext/356814383/buttons.o.d 
	@${RM} ${OBJECTDIR}/_ext/356814383/buttons.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/inc/buttons.c  -o ${OBJECTDIR}/_ext/356814383/buttons.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356814383/buttons.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/982589299/led_driver.o: ../../Drivers/LED_16bit_shift/led_driver.c  .generated_files/flags/EVAL_2/1460d19af9a76822d13bf6d42621e5863d124915 .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/982589299" 
	@${RM} ${OBJECTDIR}/_ext/982589299/led_driver.o.d 
	@${RM} ${OBJECTDIR}/_ext/982589299/led_driver.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Drivers/LED_16bit_shift/led_driver.c  -o ${OBJECTDIR}/_ext/982589299/led_driver.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/982589299/led_driver.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/356824117/CAN.o: ../../Libraries/PIC33_plib/src/CAN.c  .generated_files/flags/EVAL_2/240546a3aeaf26da78d63b0e95bc9f620548687c .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/CAN.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/CAN.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/CAN.c  -o ${OBJECTDIR}/_ext/356824117/CAN.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/CAN.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/main.o: main.c  .generated_files/flags/EVAL_2/3ecffbbf06699d81cb3ca56f45e32cb8b5fb4dfc .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/main.o.d 
	@${RM} ${OBJECTDIR}/main.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  main.c  -o ${OBJECTDIR}/main.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/main.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
else
${OBJECTDIR}/_ext/1820936309/framework.o: ../../RTOS/framework/framework.c  .generated_files/flags/EVAL_2/366375b13319570eab24ebcc544b1b30a58da959 .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1820936309" 
	@${RM} ${OBJECTDIR}/_ext/1820936309/framework.o.d 
	@${RM} ${OBJECTDIR}/_ext/1820936309/framework.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../RTOS/framework/framework.c  -o ${OBJECTDIR}/_ext/1820936309/framework.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1820936309/framework.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/touchScreenService.o: touchScreenService.c  .generated_files/flags/EVAL_2/bbfb375ffd870c2adfabe6d1b13b08169607d99e .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/touchScreenService.o.d 
	@${RM} ${OBJECTDIR}/touchScreenService.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  touchScreenService.c  -o ${OBJECTDIR}/touchScreenService.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/touchScreenService.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/framework_taskRunner.o: framework_taskRunner.c  .generated_files/flags/EVAL_2/29913582757c4002365d0ee8d240d2c1b22f7f24 .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/framework_taskRunner.o.d 
	@${RM} ${OBJECTDIR}/framework_taskRunner.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  framework_taskRunner.c  -o ${OBJECTDIR}/framework_taskRunner.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/framework_taskRunner.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/debuggerService.o: debuggerService.c  .generated_files/flags/EVAL_2/e2ed12cc511f00ca409465a5297bcee540acf776 .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/debuggerService.o.d 
	@${RM} ${OBJECTDIR}/debuggerService.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  debuggerService.c  -o ${OBJECTDIR}/debuggerService.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/debuggerService.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/movingAverage.o: movingAverage.c  .generated_files/flags/EVAL_2/40f70a8c07aeafa0d7f0706fa386f0664fdced2 .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/movingAverage.o.d 
	@${RM} ${OBJECTDIR}/movingAverage.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  movingAverage.c  -o ${OBJECTDIR}/movingAverage.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/movingAverage.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/canService.o: canService.c  .generated_files/flags/EVAL_2/ad9586c72353ae771f60561e2637d1c9e9a6ca84 .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/canService.o.d 
	@${RM} ${OBJECTDIR}/canService.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  canService.c  -o ${OBJECTDIR}/canService.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/canService.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/356824117/ADC.o: ../../Libraries/PIC33_plib/src/ADC.c  .generated_files/flags/EVAL_2/f90f79271de122e34eff2c8305b2c9cf68b7ca3e .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/ADC.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/ADC.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/ADC.c  -o ${OBJECTDIR}/_ext/356824117/ADC.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/ADC.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/356824117/init.o: ../../Libraries/PIC33_plib/src/init.c  .generated_files/flags/EVAL_2/3b5e1bae52e510a94331214f387d2c018f1d8f19 .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/init.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/init.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/init.c  -o ${OBJECTDIR}/_ext/356824117/init.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/init.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1927342817/DISPLAY_INTERFACE.o: ../../Drivers/TFT_LCD/src/DISPLAY_INTERFACE.c  .generated_files/flags/EVAL_2/b5e8b3d5afa7c6a397ce3c19ac84b9d1041774c5 .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1927342817" 
	@${RM} ${OBJECTDIR}/_ext/1927342817/DISPLAY_INTERFACE.o.d 
	@${RM} ${OBJECTDIR}/_ext/1927342817/DISPLAY_INTERFACE.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Drivers/TFT_LCD/src/DISPLAY_INTERFACE.c  -o ${OBJECTDIR}/_ext/1927342817/DISPLAY_INTERFACE.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1927342817/DISPLAY_INTERFACE.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1927342817/TFT_LCD.o: ../../Drivers/TFT_LCD/src/TFT_LCD.c  .generated_files/flags/EVAL_2/16b006a7df5023cfbc3bb5b9fa7069fe99210816 .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1927342817" 
	@${RM} ${OBJECTDIR}/_ext/1927342817/TFT_LCD.o.d 
	@${RM} ${OBJECTDIR}/_ext/1927342817/TFT_LCD.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Drivers/TFT_LCD/src/TFT_LCD.c  -o ${OBJECTDIR}/_ext/1927342817/TFT_LCD.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1927342817/TFT_LCD.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1927342817/TFT_LCD_Q.o: ../../Drivers/TFT_LCD/src/TFT_LCD_Q.c  .generated_files/flags/EVAL_2/66cd8ffed9cacbaeb3cd644a39ad918ed221ed75 .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1927342817" 
	@${RM} ${OBJECTDIR}/_ext/1927342817/TFT_LCD_Q.o.d 
	@${RM} ${OBJECTDIR}/_ext/1927342817/TFT_LCD_Q.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Drivers/TFT_LCD/src/TFT_LCD_Q.c  -o ${OBJECTDIR}/_ext/1927342817/TFT_LCD_Q.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1927342817/TFT_LCD_Q.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1927342817/TOUCH_SCREEN.o: ../../Drivers/TFT_LCD/src/TOUCH_SCREEN.c  .generated_files/flags/EVAL_2/2642af916b73af4814bed657331acedd3f071430 .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1927342817" 
	@${RM} ${OBJECTDIR}/_ext/1927342817/TOUCH_SCREEN.o.d 
	@${RM} ${OBJECTDIR}/_ext/1927342817/TOUCH_SCREEN.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Drivers/TFT_LCD/src/TOUCH_SCREEN.c  -o ${OBJECTDIR}/_ext/1927342817/TOUCH_SCREEN.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1927342817/TOUCH_SCREEN.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/356824117/pins.o: ../../Libraries/PIC33_plib/src/pins.c  .generated_files/flags/EVAL_2/2a5ed5eb82452fd7acc5e4673d1e52d49b5cbdc4 .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/pins.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/pins.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/pins.c  -o ${OBJECTDIR}/_ext/356824117/pins.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/pins.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/899432208/ping.o: ../../Drivers/PingSensor/ping.c  .generated_files/flags/EVAL_2/6203d16c0a25539e839d069511c36cc6c5a00642 .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/899432208" 
	@${RM} ${OBJECTDIR}/_ext/899432208/ping.o.d 
	@${RM} ${OBJECTDIR}/_ext/899432208/ping.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Drivers/PingSensor/ping.c  -o ${OBJECTDIR}/_ext/899432208/ping.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/899432208/ping.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/356824117/i2c.o: ../../Libraries/PIC33_plib/src/i2c.c  .generated_files/flags/EVAL_2/52d2671815d17bfe0836cc6fb41b4f1708129da0 .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/i2c.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/i2c.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/i2c.c  -o ${OBJECTDIR}/_ext/356824117/i2c.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/i2c.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/356814383/buttons.o: ../../Libraries/PIC33_plib/inc/buttons.c  .generated_files/flags/EVAL_2/50ca09f0c1a8dcf8c9b01128c1b069968c906a6e .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356814383" 
	@${RM} ${OBJECTDIR}/_ext/356814383/buttons.o.d 
	@${RM} ${OBJECTDIR}/_ext/356814383/buttons.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/inc/buttons.c  -o ${OBJECTDIR}/_ext/356814383/buttons.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356814383/buttons.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/982589299/led_driver.o: ../../Drivers/LED_16bit_shift/led_driver.c  .generated_files/flags/EVAL_2/1dcf7c3ae16741b5a9ce710b1249b83fc30e65fe .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/982589299" 
	@${RM} ${OBJECTDIR}/_ext/982589299/led_driver.o.d 
	@${RM} ${OBJECTDIR}/_ext/982589299/led_driver.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Drivers/LED_16bit_shift/led_driver.c  -o ${OBJECTDIR}/_ext/982589299/led_driver.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/982589299/led_driver.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/356824117/CAN.o: ../../Libraries/PIC33_plib/src/CAN.c  .generated_files/flags/EVAL_2/b49980cf066e1de4d79121d38bd5f65367486e52 .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/CAN.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/CAN.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/CAN.c  -o ${OBJECTDIR}/_ext/356824117/CAN.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/CAN.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/main.o: main.c  .generated_files/flags/EVAL_2/acdfb5cfd287f9f0bc9cdbc9140fdf41f14fcf57 .generated_files/flags/EVAL_2/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/main.o.d 
	@${RM} ${OBJECTDIR}/main.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  main.c  -o ${OBJECTDIR}/main.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/main.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../RTOS/framework" -I"../../Drivers/TFT_LCD/inc" -I"../../Drivers/TFT_LCD/src" -I"../../Drivers/PingSensor" -I"../../Libraries/Drivers/LED_16bit_shift" -DEVAL_2 -msmart-io=1 -Wall -msfr-warn=off   
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemblePreproc
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${DISTDIR}/E_MOTO.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o ${DISTDIR}/E_MOTO.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}      -mcpu=$(MP_PROCESSOR_OPTION)        -D__DEBUG=__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)   -mreserve=data@0x1000:0x101B -mreserve=data@0x101C:0x101D -mreserve=data@0x101E:0x101F -mreserve=data@0x1020:0x1021 -mreserve=data@0x1022:0x1023 -mreserve=data@0x1024:0x1027 -mreserve=data@0x1028:0x104F   -Wl,--local-stack,,--defsym=__MPLAB_BUILD=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,-D__DEBUG=__DEBUG,--defsym=__MPLAB_DEBUGGER_PK3=1,$(MP_LINKER_FILE_OPTION),--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--no-gc-sections,--fill-upper=0,--stackguard=16,--no-force-link,--smart-io,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--report-mem,--memorysummary,${DISTDIR}/memoryfile.xml$(MP_EXTRA_LD_POST)  
	
else
${DISTDIR}/E_MOTO.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o ${DISTDIR}/E_MOTO.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}      -mcpu=$(MP_PROCESSOR_OPTION)        -omf=elf -DXPRJ_EVAL_2=$(CND_CONF)    $(COMPARISON_BUILD)  -Wl,--local-stack,,--defsym=__MPLAB_BUILD=1,$(MP_LINKER_FILE_OPTION),--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--no-gc-sections,--fill-upper=0,--stackguard=16,--no-force-link,--smart-io,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--report-mem,--memorysummary,${DISTDIR}/memoryfile.xml$(MP_EXTRA_LD_POST)  
	${MP_CC_DIR}\\xc16-bin2hex ${DISTDIR}/E_MOTO.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} -a  -omf=elf   
	
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${OBJECTDIR}
	${RM} -r ${DISTDIR}
