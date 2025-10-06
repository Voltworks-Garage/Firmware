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
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/MCU_App.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/MCU_App.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
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
SOURCEFILES_QUOTED_IF_SPACED=../../Libraries/PIC33_plib/src/uart.c ../../Libraries/PIC33_plib/src/ADC.c ../../Libraries/PIC33_plib/src/pins.c ../../Libraries/PIC33_plib/src/OC.c ../../Libraries/PIC33_plib/src/CAN.c ../../Libraries/PIC33_plib/src/sleep.c ../../Libraries/Standard/movingAverage.c ../../Libraries/Standard/utils.c ../../Libraries/Drivers/ISO_TP_LITE/can_iso_tp_lite.c ../../Libraries/Drivers/Buttons/button.c ../../RTOS/Scheduler/SysTick.c ../../Libraries/CommandService/commandService.c ../../RTOS/Scheduler/cpu_usage.c ../../Libraries/Standard/movingAverageInt.c ../../Libraries/PIC33_plib/src/timer.c mcc_generated_files/boot/hardware_interrupt_table.S mcc_generated_files/boot/memory_partition.S mcc_generated_files/boot/application_header_not_blank.S mcc_generated_files/boot/user_interrupt_table.S mcc_generated_files/boot/interrupts.S mcc_generated_files/reset.c mcc_generated_files/interrupt_manager.c mcc_generated_files/clock.c mcc_generated_files/mcc.c mcc_generated_files/system.c mcc_generated_files/pin_manager.c mcc_generated_files/traps.c main.c tsk.c tsk_cfg.c SerialDebugger.c IO.c StateMachine.c LightsControl.c IgnitionControl.c HornControl.c j1772.c ../../CAN/generated/mcu_dbc.c HeatedGrips.c pinSetup.c canPopulate.c lvBattery.c tachometer.c ThrottleControl.c BatteryGauge.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/_ext/356824117/uart.o ${OBJECTDIR}/_ext/356824117/ADC.o ${OBJECTDIR}/_ext/356824117/pins.o ${OBJECTDIR}/_ext/356824117/OC.o ${OBJECTDIR}/_ext/356824117/CAN.o ${OBJECTDIR}/_ext/356824117/sleep.o ${OBJECTDIR}/_ext/1136797869/movingAverage.o ${OBJECTDIR}/_ext/1136797869/utils.o ${OBJECTDIR}/_ext/1750102429/can_iso_tp_lite.o ${OBJECTDIR}/_ext/1005132103/button.o ${OBJECTDIR}/_ext/1176946926/SysTick.o ${OBJECTDIR}/_ext/1983695616/commandService.o ${OBJECTDIR}/_ext/1176946926/cpu_usage.o ${OBJECTDIR}/_ext/1136797869/movingAverageInt.o ${OBJECTDIR}/_ext/356824117/timer.o ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o ${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o ${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o ${OBJECTDIR}/mcc_generated_files/reset.o ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o ${OBJECTDIR}/mcc_generated_files/clock.o ${OBJECTDIR}/mcc_generated_files/mcc.o ${OBJECTDIR}/mcc_generated_files/system.o ${OBJECTDIR}/mcc_generated_files/pin_manager.o ${OBJECTDIR}/mcc_generated_files/traps.o ${OBJECTDIR}/main.o ${OBJECTDIR}/tsk.o ${OBJECTDIR}/tsk_cfg.o ${OBJECTDIR}/SerialDebugger.o ${OBJECTDIR}/IO.o ${OBJECTDIR}/StateMachine.o ${OBJECTDIR}/LightsControl.o ${OBJECTDIR}/IgnitionControl.o ${OBJECTDIR}/HornControl.o ${OBJECTDIR}/j1772.o ${OBJECTDIR}/_ext/469142448/mcu_dbc.o ${OBJECTDIR}/HeatedGrips.o ${OBJECTDIR}/pinSetup.o ${OBJECTDIR}/canPopulate.o ${OBJECTDIR}/lvBattery.o ${OBJECTDIR}/tachometer.o ${OBJECTDIR}/ThrottleControl.o ${OBJECTDIR}/BatteryGauge.o
POSSIBLE_DEPFILES=${OBJECTDIR}/_ext/356824117/uart.o.d ${OBJECTDIR}/_ext/356824117/ADC.o.d ${OBJECTDIR}/_ext/356824117/pins.o.d ${OBJECTDIR}/_ext/356824117/OC.o.d ${OBJECTDIR}/_ext/356824117/CAN.o.d ${OBJECTDIR}/_ext/356824117/sleep.o.d ${OBJECTDIR}/_ext/1136797869/movingAverage.o.d ${OBJECTDIR}/_ext/1136797869/utils.o.d ${OBJECTDIR}/_ext/1750102429/can_iso_tp_lite.o.d ${OBJECTDIR}/_ext/1005132103/button.o.d ${OBJECTDIR}/_ext/1176946926/SysTick.o.d ${OBJECTDIR}/_ext/1983695616/commandService.o.d ${OBJECTDIR}/_ext/1176946926/cpu_usage.o.d ${OBJECTDIR}/_ext/1136797869/movingAverageInt.o.d ${OBJECTDIR}/_ext/356824117/timer.o.d ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o.d ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o.d ${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o.d ${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o.d ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o.d ${OBJECTDIR}/mcc_generated_files/reset.o.d ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o.d ${OBJECTDIR}/mcc_generated_files/clock.o.d ${OBJECTDIR}/mcc_generated_files/mcc.o.d ${OBJECTDIR}/mcc_generated_files/system.o.d ${OBJECTDIR}/mcc_generated_files/pin_manager.o.d ${OBJECTDIR}/mcc_generated_files/traps.o.d ${OBJECTDIR}/main.o.d ${OBJECTDIR}/tsk.o.d ${OBJECTDIR}/tsk_cfg.o.d ${OBJECTDIR}/SerialDebugger.o.d ${OBJECTDIR}/IO.o.d ${OBJECTDIR}/StateMachine.o.d ${OBJECTDIR}/LightsControl.o.d ${OBJECTDIR}/IgnitionControl.o.d ${OBJECTDIR}/HornControl.o.d ${OBJECTDIR}/j1772.o.d ${OBJECTDIR}/_ext/469142448/mcu_dbc.o.d ${OBJECTDIR}/HeatedGrips.o.d ${OBJECTDIR}/pinSetup.o.d ${OBJECTDIR}/canPopulate.o.d ${OBJECTDIR}/lvBattery.o.d ${OBJECTDIR}/tachometer.o.d ${OBJECTDIR}/ThrottleControl.o.d ${OBJECTDIR}/BatteryGauge.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/356824117/uart.o ${OBJECTDIR}/_ext/356824117/ADC.o ${OBJECTDIR}/_ext/356824117/pins.o ${OBJECTDIR}/_ext/356824117/OC.o ${OBJECTDIR}/_ext/356824117/CAN.o ${OBJECTDIR}/_ext/356824117/sleep.o ${OBJECTDIR}/_ext/1136797869/movingAverage.o ${OBJECTDIR}/_ext/1136797869/utils.o ${OBJECTDIR}/_ext/1750102429/can_iso_tp_lite.o ${OBJECTDIR}/_ext/1005132103/button.o ${OBJECTDIR}/_ext/1176946926/SysTick.o ${OBJECTDIR}/_ext/1983695616/commandService.o ${OBJECTDIR}/_ext/1176946926/cpu_usage.o ${OBJECTDIR}/_ext/1136797869/movingAverageInt.o ${OBJECTDIR}/_ext/356824117/timer.o ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o ${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o ${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o ${OBJECTDIR}/mcc_generated_files/reset.o ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o ${OBJECTDIR}/mcc_generated_files/clock.o ${OBJECTDIR}/mcc_generated_files/mcc.o ${OBJECTDIR}/mcc_generated_files/system.o ${OBJECTDIR}/mcc_generated_files/pin_manager.o ${OBJECTDIR}/mcc_generated_files/traps.o ${OBJECTDIR}/main.o ${OBJECTDIR}/tsk.o ${OBJECTDIR}/tsk_cfg.o ${OBJECTDIR}/SerialDebugger.o ${OBJECTDIR}/IO.o ${OBJECTDIR}/StateMachine.o ${OBJECTDIR}/LightsControl.o ${OBJECTDIR}/IgnitionControl.o ${OBJECTDIR}/HornControl.o ${OBJECTDIR}/j1772.o ${OBJECTDIR}/_ext/469142448/mcu_dbc.o ${OBJECTDIR}/HeatedGrips.o ${OBJECTDIR}/pinSetup.o ${OBJECTDIR}/canPopulate.o ${OBJECTDIR}/lvBattery.o ${OBJECTDIR}/tachometer.o ${OBJECTDIR}/ThrottleControl.o ${OBJECTDIR}/BatteryGauge.o

# Source Files
SOURCEFILES=../../Libraries/PIC33_plib/src/uart.c ../../Libraries/PIC33_plib/src/ADC.c ../../Libraries/PIC33_plib/src/pins.c ../../Libraries/PIC33_plib/src/OC.c ../../Libraries/PIC33_plib/src/CAN.c ../../Libraries/PIC33_plib/src/sleep.c ../../Libraries/Standard/movingAverage.c ../../Libraries/Standard/utils.c ../../Libraries/Drivers/ISO_TP_LITE/can_iso_tp_lite.c ../../Libraries/Drivers/Buttons/button.c ../../RTOS/Scheduler/SysTick.c ../../Libraries/CommandService/commandService.c ../../RTOS/Scheduler/cpu_usage.c ../../Libraries/Standard/movingAverageInt.c ../../Libraries/PIC33_plib/src/timer.c mcc_generated_files/boot/hardware_interrupt_table.S mcc_generated_files/boot/memory_partition.S mcc_generated_files/boot/application_header_not_blank.S mcc_generated_files/boot/user_interrupt_table.S mcc_generated_files/boot/interrupts.S mcc_generated_files/reset.c mcc_generated_files/interrupt_manager.c mcc_generated_files/clock.c mcc_generated_files/mcc.c mcc_generated_files/system.c mcc_generated_files/pin_manager.c mcc_generated_files/traps.c main.c tsk.c tsk_cfg.c SerialDebugger.c IO.c StateMachine.c LightsControl.c IgnitionControl.c HornControl.c j1772.c ../../CAN/generated/mcu_dbc.c HeatedGrips.c pinSetup.c canPopulate.c lvBattery.c tachometer.c ThrottleControl.c BatteryGauge.c



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
	${MAKE}  -f nbproject/Makefile-default.mk ${DISTDIR}/MCU_App.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=33EP512MU810
MP_LINKER_FILE_OPTION=,--script=p33EP512MU810.gld
# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/356824117/uart.o: ../../Libraries/PIC33_plib/src/uart.c  .generated_files/flags/default/ff5cc129242224c5f2a34a73be4329b1a24a1653 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/uart.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/uart.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/uart.c  -o ${OBJECTDIR}/_ext/356824117/uart.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/uart.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/ADC.o: ../../Libraries/PIC33_plib/src/ADC.c  .generated_files/flags/default/e22f0f8a543c38782f9084a8aeb641f3cb431a01 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/ADC.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/ADC.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/ADC.c  -o ${OBJECTDIR}/_ext/356824117/ADC.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/ADC.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/pins.o: ../../Libraries/PIC33_plib/src/pins.c  .generated_files/flags/default/f22d1f3172419bc790440076181d50962a1657f8 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/pins.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/pins.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/pins.c  -o ${OBJECTDIR}/_ext/356824117/pins.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/pins.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/OC.o: ../../Libraries/PIC33_plib/src/OC.c  .generated_files/flags/default/e14f235fd367ab2f6c45d8371f641e1a21f7b9a3 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/OC.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/OC.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/OC.c  -o ${OBJECTDIR}/_ext/356824117/OC.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/OC.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/CAN.o: ../../Libraries/PIC33_plib/src/CAN.c  .generated_files/flags/default/23938eabf005ac6d7ee9853cec110291af56c569 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/CAN.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/CAN.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/CAN.c  -o ${OBJECTDIR}/_ext/356824117/CAN.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/CAN.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/sleep.o: ../../Libraries/PIC33_plib/src/sleep.c  .generated_files/flags/default/bfd8614a9c51beddce757f98b47c9d9977882c52 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/sleep.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/sleep.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/sleep.c  -o ${OBJECTDIR}/_ext/356824117/sleep.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/sleep.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1136797869/movingAverage.o: ../../Libraries/Standard/movingAverage.c  .generated_files/flags/default/1370f98d546581deb3d4b57f6a54d9af2ff304f1 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1136797869" 
	@${RM} ${OBJECTDIR}/_ext/1136797869/movingAverage.o.d 
	@${RM} ${OBJECTDIR}/_ext/1136797869/movingAverage.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/Standard/movingAverage.c  -o ${OBJECTDIR}/_ext/1136797869/movingAverage.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1136797869/movingAverage.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1136797869/utils.o: ../../Libraries/Standard/utils.c  .generated_files/flags/default/326d07b087ce8f8e498d60e2cd015a5d47e06d4f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1136797869" 
	@${RM} ${OBJECTDIR}/_ext/1136797869/utils.o.d 
	@${RM} ${OBJECTDIR}/_ext/1136797869/utils.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/Standard/utils.c  -o ${OBJECTDIR}/_ext/1136797869/utils.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1136797869/utils.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1750102429/can_iso_tp_lite.o: ../../Libraries/Drivers/ISO_TP_LITE/can_iso_tp_lite.c  .generated_files/flags/default/632360169eba1ff0621453935db35c4bba26ad81 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1750102429" 
	@${RM} ${OBJECTDIR}/_ext/1750102429/can_iso_tp_lite.o.d 
	@${RM} ${OBJECTDIR}/_ext/1750102429/can_iso_tp_lite.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/Drivers/ISO_TP_LITE/can_iso_tp_lite.c  -o ${OBJECTDIR}/_ext/1750102429/can_iso_tp_lite.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1750102429/can_iso_tp_lite.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1005132103/button.o: ../../Libraries/Drivers/Buttons/button.c  .generated_files/flags/default/1dbbc7ef7ab17f368c47df84e67eb767a5974ec8 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1005132103" 
	@${RM} ${OBJECTDIR}/_ext/1005132103/button.o.d 
	@${RM} ${OBJECTDIR}/_ext/1005132103/button.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/Drivers/Buttons/button.c  -o ${OBJECTDIR}/_ext/1005132103/button.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1005132103/button.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1176946926/SysTick.o: ../../RTOS/Scheduler/SysTick.c  .generated_files/flags/default/7b3f3329db5579fc49b7a4d4322dcf7478f9f043 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1176946926" 
	@${RM} ${OBJECTDIR}/_ext/1176946926/SysTick.o.d 
	@${RM} ${OBJECTDIR}/_ext/1176946926/SysTick.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../RTOS/Scheduler/SysTick.c  -o ${OBJECTDIR}/_ext/1176946926/SysTick.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1176946926/SysTick.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1983695616/commandService.o: ../../Libraries/CommandService/commandService.c  .generated_files/flags/default/552caa61159ff14d59890f249f6c3436da6eb8f7 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1983695616" 
	@${RM} ${OBJECTDIR}/_ext/1983695616/commandService.o.d 
	@${RM} ${OBJECTDIR}/_ext/1983695616/commandService.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/CommandService/commandService.c  -o ${OBJECTDIR}/_ext/1983695616/commandService.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1983695616/commandService.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1176946926/cpu_usage.o: ../../RTOS/Scheduler/cpu_usage.c  .generated_files/flags/default/978850c55092dbb815de9663f2919e190763f873 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1176946926" 
	@${RM} ${OBJECTDIR}/_ext/1176946926/cpu_usage.o.d 
	@${RM} ${OBJECTDIR}/_ext/1176946926/cpu_usage.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../RTOS/Scheduler/cpu_usage.c  -o ${OBJECTDIR}/_ext/1176946926/cpu_usage.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1176946926/cpu_usage.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1136797869/movingAverageInt.o: ../../Libraries/Standard/movingAverageInt.c  .generated_files/flags/default/891d2a70dddddfb9ea889f9ca4f8947655b9e846 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1136797869" 
	@${RM} ${OBJECTDIR}/_ext/1136797869/movingAverageInt.o.d 
	@${RM} ${OBJECTDIR}/_ext/1136797869/movingAverageInt.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/Standard/movingAverageInt.c  -o ${OBJECTDIR}/_ext/1136797869/movingAverageInt.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1136797869/movingAverageInt.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/timer.o: ../../Libraries/PIC33_plib/src/timer.c  .generated_files/flags/default/18bbf5bfab2cf43588e5ba4391c42ec14a405b41 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/timer.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/timer.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/timer.c  -o ${OBJECTDIR}/_ext/356824117/timer.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/timer.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/reset.o: mcc_generated_files/reset.c  .generated_files/flags/default/5ebb549b7cb05d51cb2e95b370ab1f7cf3713d9c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/reset.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/reset.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/reset.c  -o ${OBJECTDIR}/mcc_generated_files/reset.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/reset.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/interrupt_manager.o: mcc_generated_files/interrupt_manager.c  .generated_files/flags/default/89bdb9294b852f88f7952fb48675edc9894e5257 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/interrupt_manager.c  -o ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/interrupt_manager.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/clock.o: mcc_generated_files/clock.c  .generated_files/flags/default/9f886d8bc7301aa56fa5fbf2f8906090c16e65fb .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/clock.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/clock.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/clock.c  -o ${OBJECTDIR}/mcc_generated_files/clock.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/clock.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/mcc.o: mcc_generated_files/mcc.c  .generated_files/flags/default/e1282e9f47e9b52689c926d7dd3be2e8acee23a5 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/mcc.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/mcc.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/mcc.c  -o ${OBJECTDIR}/mcc_generated_files/mcc.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/mcc.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/system.o: mcc_generated_files/system.c  .generated_files/flags/default/8e0d4569a540f0e3059b0b727d89bade5a0bb5c5 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/system.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/system.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/system.c  -o ${OBJECTDIR}/mcc_generated_files/system.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/system.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/pin_manager.o: mcc_generated_files/pin_manager.c  .generated_files/flags/default/e9bb4e22fca83fe7594921ed87f834f2de94d235 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/pin_manager.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/pin_manager.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/pin_manager.c  -o ${OBJECTDIR}/mcc_generated_files/pin_manager.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/pin_manager.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/traps.o: mcc_generated_files/traps.c  .generated_files/flags/default/eea2bb0abf8749888f9af6e15712e9733f84f2f9 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/traps.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/traps.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/traps.c  -o ${OBJECTDIR}/mcc_generated_files/traps.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/traps.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/main.o: main.c  .generated_files/flags/default/3dd4d61b8e3f239372450c6ccc37cfc2cf10f9b1 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/main.o.d 
	@${RM} ${OBJECTDIR}/main.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  main.c  -o ${OBJECTDIR}/main.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/main.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/tsk.o: tsk.c  .generated_files/flags/default/675c7198bc7d8e8362ea30446a4da0167ac5d88f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/tsk.o.d 
	@${RM} ${OBJECTDIR}/tsk.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  tsk.c  -o ${OBJECTDIR}/tsk.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/tsk.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/tsk_cfg.o: tsk_cfg.c  .generated_files/flags/default/360e6380c7998cc86eb349f6b8cb55940420bac .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/tsk_cfg.o.d 
	@${RM} ${OBJECTDIR}/tsk_cfg.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  tsk_cfg.c  -o ${OBJECTDIR}/tsk_cfg.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/tsk_cfg.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/SerialDebugger.o: SerialDebugger.c  .generated_files/flags/default/f4dbf31b2c23506de076c296133a60a8328cf964 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/SerialDebugger.o.d 
	@${RM} ${OBJECTDIR}/SerialDebugger.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  SerialDebugger.c  -o ${OBJECTDIR}/SerialDebugger.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/SerialDebugger.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/IO.o: IO.c  .generated_files/flags/default/46938f36b327693727b60297e78a0bb4bedd02cd .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/IO.o.d 
	@${RM} ${OBJECTDIR}/IO.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  IO.c  -o ${OBJECTDIR}/IO.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/IO.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/StateMachine.o: StateMachine.c  .generated_files/flags/default/2a54cd70392c9aaddd8847fd08ca18fcb942def2 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/StateMachine.o.d 
	@${RM} ${OBJECTDIR}/StateMachine.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  StateMachine.c  -o ${OBJECTDIR}/StateMachine.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/StateMachine.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/LightsControl.o: LightsControl.c  .generated_files/flags/default/e5c4f8fb609c966c3f2389b292ce5b096c4c8389 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/LightsControl.o.d 
	@${RM} ${OBJECTDIR}/LightsControl.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  LightsControl.c  -o ${OBJECTDIR}/LightsControl.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/LightsControl.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/IgnitionControl.o: IgnitionControl.c  .generated_files/flags/default/9d880e5e19e8b35be6a720c168441846919f8535 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/IgnitionControl.o.d 
	@${RM} ${OBJECTDIR}/IgnitionControl.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  IgnitionControl.c  -o ${OBJECTDIR}/IgnitionControl.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/IgnitionControl.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/HornControl.o: HornControl.c  .generated_files/flags/default/b98d28421d054af2a02c4712311660da47d001c9 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/HornControl.o.d 
	@${RM} ${OBJECTDIR}/HornControl.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  HornControl.c  -o ${OBJECTDIR}/HornControl.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/HornControl.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/j1772.o: j1772.c  .generated_files/flags/default/7b8481e03cce812c031ba3de49645055d0088322 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/j1772.o.d 
	@${RM} ${OBJECTDIR}/j1772.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  j1772.c  -o ${OBJECTDIR}/j1772.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/j1772.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/469142448/mcu_dbc.o: ../../CAN/generated/mcu_dbc.c  .generated_files/flags/default/a67ea23e7fcf206dc8306b5da0012e94bffbe830 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/469142448" 
	@${RM} ${OBJECTDIR}/_ext/469142448/mcu_dbc.o.d 
	@${RM} ${OBJECTDIR}/_ext/469142448/mcu_dbc.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../CAN/generated/mcu_dbc.c  -o ${OBJECTDIR}/_ext/469142448/mcu_dbc.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/469142448/mcu_dbc.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/HeatedGrips.o: HeatedGrips.c  .generated_files/flags/default/f15525fcf0efa9d89b8725bb145a5cd4d6ffe00e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/HeatedGrips.o.d 
	@${RM} ${OBJECTDIR}/HeatedGrips.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  HeatedGrips.c  -o ${OBJECTDIR}/HeatedGrips.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/HeatedGrips.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/pinSetup.o: pinSetup.c  .generated_files/flags/default/3a9a4714206ea1f91a80477ebf14288585556ee0 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/pinSetup.o.d 
	@${RM} ${OBJECTDIR}/pinSetup.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  pinSetup.c  -o ${OBJECTDIR}/pinSetup.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/pinSetup.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/canPopulate.o: canPopulate.c  .generated_files/flags/default/761e66fb68d414f80bc0eeffff78f78e813c8cc0 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/canPopulate.o.d 
	@${RM} ${OBJECTDIR}/canPopulate.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  canPopulate.c  -o ${OBJECTDIR}/canPopulate.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/canPopulate.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/lvBattery.o: lvBattery.c  .generated_files/flags/default/f22d8f8e88733356dfbf900003fb04288f2c2e5 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/lvBattery.o.d 
	@${RM} ${OBJECTDIR}/lvBattery.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  lvBattery.c  -o ${OBJECTDIR}/lvBattery.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/lvBattery.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/tachometer.o: tachometer.c  .generated_files/flags/default/d2ed536bbb5ccb9b63ae43869ab80215111cc20 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/tachometer.o.d 
	@${RM} ${OBJECTDIR}/tachometer.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  tachometer.c  -o ${OBJECTDIR}/tachometer.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/tachometer.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/ThrottleControl.o: ThrottleControl.c  .generated_files/flags/default/6178776ac8e17876f5af8d8c581bb0b750da9f49 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/ThrottleControl.o.d 
	@${RM} ${OBJECTDIR}/ThrottleControl.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ThrottleControl.c  -o ${OBJECTDIR}/ThrottleControl.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/ThrottleControl.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/BatteryGauge.o: BatteryGauge.c  .generated_files/flags/default/b18d8cf11bc9ffa043ce968173667701ab6b83f0 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/BatteryGauge.o.d 
	@${RM} ${OBJECTDIR}/BatteryGauge.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  BatteryGauge.c  -o ${OBJECTDIR}/BatteryGauge.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/BatteryGauge.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
else
${OBJECTDIR}/_ext/356824117/uart.o: ../../Libraries/PIC33_plib/src/uart.c  .generated_files/flags/default/95f37b0e6670d3fb49cbd5ba7c7feca97404819a .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/uart.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/uart.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/uart.c  -o ${OBJECTDIR}/_ext/356824117/uart.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/uart.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/ADC.o: ../../Libraries/PIC33_plib/src/ADC.c  .generated_files/flags/default/376d4acd6081c1e9f9915409f1426806512ebbe2 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/ADC.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/ADC.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/ADC.c  -o ${OBJECTDIR}/_ext/356824117/ADC.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/ADC.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/pins.o: ../../Libraries/PIC33_plib/src/pins.c  .generated_files/flags/default/69d98eecc43b7930320242920a339de82d942dd .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/pins.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/pins.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/pins.c  -o ${OBJECTDIR}/_ext/356824117/pins.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/pins.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/OC.o: ../../Libraries/PIC33_plib/src/OC.c  .generated_files/flags/default/ec3c19f99659a8108cff648d9fffb0b7f91aafe5 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/OC.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/OC.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/OC.c  -o ${OBJECTDIR}/_ext/356824117/OC.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/OC.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/CAN.o: ../../Libraries/PIC33_plib/src/CAN.c  .generated_files/flags/default/91d833061bc8421221256f762bbd53bdd2910665 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/CAN.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/CAN.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/CAN.c  -o ${OBJECTDIR}/_ext/356824117/CAN.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/CAN.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/sleep.o: ../../Libraries/PIC33_plib/src/sleep.c  .generated_files/flags/default/f3ce2e376791638d6070b1959e2aa2f25f23fe9d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/sleep.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/sleep.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/sleep.c  -o ${OBJECTDIR}/_ext/356824117/sleep.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/sleep.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1136797869/movingAverage.o: ../../Libraries/Standard/movingAverage.c  .generated_files/flags/default/505db23ffef54d211c90e0ba8166f9a634c951db .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1136797869" 
	@${RM} ${OBJECTDIR}/_ext/1136797869/movingAverage.o.d 
	@${RM} ${OBJECTDIR}/_ext/1136797869/movingAverage.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/Standard/movingAverage.c  -o ${OBJECTDIR}/_ext/1136797869/movingAverage.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1136797869/movingAverage.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1136797869/utils.o: ../../Libraries/Standard/utils.c  .generated_files/flags/default/b446fc250924fde598e0f02d12a9e29e34600641 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1136797869" 
	@${RM} ${OBJECTDIR}/_ext/1136797869/utils.o.d 
	@${RM} ${OBJECTDIR}/_ext/1136797869/utils.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/Standard/utils.c  -o ${OBJECTDIR}/_ext/1136797869/utils.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1136797869/utils.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1750102429/can_iso_tp_lite.o: ../../Libraries/Drivers/ISO_TP_LITE/can_iso_tp_lite.c  .generated_files/flags/default/bddad7b082a5059b44443ee3b6743ab0a678a490 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1750102429" 
	@${RM} ${OBJECTDIR}/_ext/1750102429/can_iso_tp_lite.o.d 
	@${RM} ${OBJECTDIR}/_ext/1750102429/can_iso_tp_lite.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/Drivers/ISO_TP_LITE/can_iso_tp_lite.c  -o ${OBJECTDIR}/_ext/1750102429/can_iso_tp_lite.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1750102429/can_iso_tp_lite.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1005132103/button.o: ../../Libraries/Drivers/Buttons/button.c  .generated_files/flags/default/82a9debce6b0b9a2dd89067c16b2a489eca3d6a1 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1005132103" 
	@${RM} ${OBJECTDIR}/_ext/1005132103/button.o.d 
	@${RM} ${OBJECTDIR}/_ext/1005132103/button.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/Drivers/Buttons/button.c  -o ${OBJECTDIR}/_ext/1005132103/button.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1005132103/button.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1176946926/SysTick.o: ../../RTOS/Scheduler/SysTick.c  .generated_files/flags/default/ee3e8404989b9f3b526baec5f57ec6282464f808 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1176946926" 
	@${RM} ${OBJECTDIR}/_ext/1176946926/SysTick.o.d 
	@${RM} ${OBJECTDIR}/_ext/1176946926/SysTick.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../RTOS/Scheduler/SysTick.c  -o ${OBJECTDIR}/_ext/1176946926/SysTick.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1176946926/SysTick.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1983695616/commandService.o: ../../Libraries/CommandService/commandService.c  .generated_files/flags/default/4bdf866277c7a99f0ec72a357ad75f501c700fa4 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1983695616" 
	@${RM} ${OBJECTDIR}/_ext/1983695616/commandService.o.d 
	@${RM} ${OBJECTDIR}/_ext/1983695616/commandService.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/CommandService/commandService.c  -o ${OBJECTDIR}/_ext/1983695616/commandService.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1983695616/commandService.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1176946926/cpu_usage.o: ../../RTOS/Scheduler/cpu_usage.c  .generated_files/flags/default/50727f9e6c6792b5735ee88fe88a0f4f749e323a .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1176946926" 
	@${RM} ${OBJECTDIR}/_ext/1176946926/cpu_usage.o.d 
	@${RM} ${OBJECTDIR}/_ext/1176946926/cpu_usage.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../RTOS/Scheduler/cpu_usage.c  -o ${OBJECTDIR}/_ext/1176946926/cpu_usage.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1176946926/cpu_usage.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1136797869/movingAverageInt.o: ../../Libraries/Standard/movingAverageInt.c  .generated_files/flags/default/d05ae0930d61203fa51ca8aba21f2254779d2a8e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1136797869" 
	@${RM} ${OBJECTDIR}/_ext/1136797869/movingAverageInt.o.d 
	@${RM} ${OBJECTDIR}/_ext/1136797869/movingAverageInt.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/Standard/movingAverageInt.c  -o ${OBJECTDIR}/_ext/1136797869/movingAverageInt.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1136797869/movingAverageInt.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/timer.o: ../../Libraries/PIC33_plib/src/timer.c  .generated_files/flags/default/9b542104491cddd90b89448ec8a3e447771ffbe1 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/timer.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/timer.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/timer.c  -o ${OBJECTDIR}/_ext/356824117/timer.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/timer.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/reset.o: mcc_generated_files/reset.c  .generated_files/flags/default/8fc326a9af7b33182d0435bc2dfe37d20919ff2d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/reset.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/reset.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/reset.c  -o ${OBJECTDIR}/mcc_generated_files/reset.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/reset.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/interrupt_manager.o: mcc_generated_files/interrupt_manager.c  .generated_files/flags/default/529114c2802f24e51f83a71a8db537192ecfc7e7 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/interrupt_manager.c  -o ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/interrupt_manager.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/clock.o: mcc_generated_files/clock.c  .generated_files/flags/default/318878bb438ae9a5746c74ffe3b116ca1ece7f51 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/clock.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/clock.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/clock.c  -o ${OBJECTDIR}/mcc_generated_files/clock.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/clock.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/mcc.o: mcc_generated_files/mcc.c  .generated_files/flags/default/908652c988d9d77bd9cf654c995d3aa45a7c717 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/mcc.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/mcc.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/mcc.c  -o ${OBJECTDIR}/mcc_generated_files/mcc.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/mcc.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/system.o: mcc_generated_files/system.c  .generated_files/flags/default/a4252d00a2a1ede4a13c434a5052b80b8ed17086 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/system.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/system.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/system.c  -o ${OBJECTDIR}/mcc_generated_files/system.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/system.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/pin_manager.o: mcc_generated_files/pin_manager.c  .generated_files/flags/default/dc83668bb934e373fdcf6b70744d43d04756ce43 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/pin_manager.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/pin_manager.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/pin_manager.c  -o ${OBJECTDIR}/mcc_generated_files/pin_manager.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/pin_manager.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/traps.o: mcc_generated_files/traps.c  .generated_files/flags/default/2c21f4c69eabc3fa9a456d53d7be2101723ea402 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/traps.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/traps.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/traps.c  -o ${OBJECTDIR}/mcc_generated_files/traps.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/traps.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/main.o: main.c  .generated_files/flags/default/42f48eca7748b31044615c8f808821359b677e10 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/main.o.d 
	@${RM} ${OBJECTDIR}/main.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  main.c  -o ${OBJECTDIR}/main.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/main.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/tsk.o: tsk.c  .generated_files/flags/default/a81c53b697cdcc27b6a3dd89eef2bde590593083 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/tsk.o.d 
	@${RM} ${OBJECTDIR}/tsk.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  tsk.c  -o ${OBJECTDIR}/tsk.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/tsk.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/tsk_cfg.o: tsk_cfg.c  .generated_files/flags/default/62c8c20ee8c1803b723be9054ec56e786b9b99ea .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/tsk_cfg.o.d 
	@${RM} ${OBJECTDIR}/tsk_cfg.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  tsk_cfg.c  -o ${OBJECTDIR}/tsk_cfg.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/tsk_cfg.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/SerialDebugger.o: SerialDebugger.c  .generated_files/flags/default/3fdb570702857a1f5b72e8fa3573da1cb93ef49a .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/SerialDebugger.o.d 
	@${RM} ${OBJECTDIR}/SerialDebugger.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  SerialDebugger.c  -o ${OBJECTDIR}/SerialDebugger.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/SerialDebugger.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/IO.o: IO.c  .generated_files/flags/default/28181d278dd819be720da0635321e6843ebf7923 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/IO.o.d 
	@${RM} ${OBJECTDIR}/IO.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  IO.c  -o ${OBJECTDIR}/IO.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/IO.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/StateMachine.o: StateMachine.c  .generated_files/flags/default/25e1eb80d4d1ce8c4397d18ab46f766a92046798 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/StateMachine.o.d 
	@${RM} ${OBJECTDIR}/StateMachine.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  StateMachine.c  -o ${OBJECTDIR}/StateMachine.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/StateMachine.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/LightsControl.o: LightsControl.c  .generated_files/flags/default/3980bc3f8d9301fdf7ec06bf8b9b2f1251a1403f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/LightsControl.o.d 
	@${RM} ${OBJECTDIR}/LightsControl.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  LightsControl.c  -o ${OBJECTDIR}/LightsControl.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/LightsControl.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/IgnitionControl.o: IgnitionControl.c  .generated_files/flags/default/9f14d9429de5b6a0ae8315049d23768fda30ff64 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/IgnitionControl.o.d 
	@${RM} ${OBJECTDIR}/IgnitionControl.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  IgnitionControl.c  -o ${OBJECTDIR}/IgnitionControl.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/IgnitionControl.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/HornControl.o: HornControl.c  .generated_files/flags/default/c383a60819ff3cf25d2f1d893d6aa2bb01c87e50 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/HornControl.o.d 
	@${RM} ${OBJECTDIR}/HornControl.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  HornControl.c  -o ${OBJECTDIR}/HornControl.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/HornControl.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/j1772.o: j1772.c  .generated_files/flags/default/6674ce9021aa0db913050443a81cdbb097767406 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/j1772.o.d 
	@${RM} ${OBJECTDIR}/j1772.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  j1772.c  -o ${OBJECTDIR}/j1772.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/j1772.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/469142448/mcu_dbc.o: ../../CAN/generated/mcu_dbc.c  .generated_files/flags/default/e95d7e1aa090d428cc28c7e2a0f33ba9292baa50 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/469142448" 
	@${RM} ${OBJECTDIR}/_ext/469142448/mcu_dbc.o.d 
	@${RM} ${OBJECTDIR}/_ext/469142448/mcu_dbc.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../CAN/generated/mcu_dbc.c  -o ${OBJECTDIR}/_ext/469142448/mcu_dbc.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/469142448/mcu_dbc.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/HeatedGrips.o: HeatedGrips.c  .generated_files/flags/default/4458640ef2831127e5fb943ee5c8163843b5729c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/HeatedGrips.o.d 
	@${RM} ${OBJECTDIR}/HeatedGrips.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  HeatedGrips.c  -o ${OBJECTDIR}/HeatedGrips.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/HeatedGrips.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/pinSetup.o: pinSetup.c  .generated_files/flags/default/97b756fb85bf157235858f4cd947ead6b0733b4f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/pinSetup.o.d 
	@${RM} ${OBJECTDIR}/pinSetup.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  pinSetup.c  -o ${OBJECTDIR}/pinSetup.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/pinSetup.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/canPopulate.o: canPopulate.c  .generated_files/flags/default/de538fc090e9e9431697afca524a3e42c82e8348 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/canPopulate.o.d 
	@${RM} ${OBJECTDIR}/canPopulate.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  canPopulate.c  -o ${OBJECTDIR}/canPopulate.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/canPopulate.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/lvBattery.o: lvBattery.c  .generated_files/flags/default/3c1d101175fc9daced3d9eb41da7465a75e0f304 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/lvBattery.o.d 
	@${RM} ${OBJECTDIR}/lvBattery.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  lvBattery.c  -o ${OBJECTDIR}/lvBattery.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/lvBattery.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/tachometer.o: tachometer.c  .generated_files/flags/default/9ce5b446c422d6c6b98707cc20f2be481efdf017 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/tachometer.o.d 
	@${RM} ${OBJECTDIR}/tachometer.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  tachometer.c  -o ${OBJECTDIR}/tachometer.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/tachometer.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/ThrottleControl.o: ThrottleControl.c  .generated_files/flags/default/6ef751c7b4b125247d0d58a8066c7db973c5debc .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/ThrottleControl.o.d 
	@${RM} ${OBJECTDIR}/ThrottleControl.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ThrottleControl.c  -o ${OBJECTDIR}/ThrottleControl.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/ThrottleControl.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/BatteryGauge.o: BatteryGauge.c  .generated_files/flags/default/e182f05aa0869f3f713f40b6e6703ca7f1c99eee .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/BatteryGauge.o.d 
	@${RM} ${OBJECTDIR}/BatteryGauge.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  BatteryGauge.c  -o ${OBJECTDIR}/BatteryGauge.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/BatteryGauge.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../Libraries/Drivers/Buttons" -I"../../Libraries/CommandService" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemblePreproc
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o: mcc_generated_files/boot/hardware_interrupt_table.S  .generated_files/flags/default/9e66af0a7a623e534b687db461fae4bee59b16e0 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/hardware_interrupt_table.S  -o ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o.d"  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o.asm.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o: mcc_generated_files/boot/memory_partition.S  .generated_files/flags/default/811146eb18b2eaac6b11429ce3e79bc1a1d3479f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/memory_partition.S  -o ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o.d"  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o.asm.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o: mcc_generated_files/boot/application_header_not_blank.S  .generated_files/flags/default/f1a49d541a73238965191bf09b8d87e19076b1ed .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/application_header_not_blank.S  -o ${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o.d"  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o.asm.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o: mcc_generated_files/boot/user_interrupt_table.S  .generated_files/flags/default/8ca83b7d88f09874304487dcdb08ba4067032331 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/user_interrupt_table.S  -o ${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o.d"  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o.asm.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/interrupts.o: mcc_generated_files/boot/interrupts.S  .generated_files/flags/default/3ee0aed1d703645257f2d5a723ae5ee7829ff8d9 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/interrupts.S  -o ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/interrupts.o.d"  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/interrupts.o.asm.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
else
${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o: mcc_generated_files/boot/hardware_interrupt_table.S  .generated_files/flags/default/783db9910427be2af6d11e32a30603e242b00e9e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/hardware_interrupt_table.S  -o ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o.d"  -omf=elf -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o.asm.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o: mcc_generated_files/boot/memory_partition.S  .generated_files/flags/default/87895126af1416a3080526bcd5e5323ccb6a3436 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/memory_partition.S  -o ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o.d"  -omf=elf -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o.asm.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o: mcc_generated_files/boot/application_header_not_blank.S  .generated_files/flags/default/7f1d81742f48981903da21da3a32b6364410f5d2 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/application_header_not_blank.S  -o ${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o.d"  -omf=elf -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o.asm.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o: mcc_generated_files/boot/user_interrupt_table.S  .generated_files/flags/default/cff3d1d33d3209763e29de0d11d4a6b27c5ce208 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/user_interrupt_table.S  -o ${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o.d"  -omf=elf -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o.asm.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/interrupts.o: mcc_generated_files/boot/interrupts.S  .generated_files/flags/default/b43c83d40d21ce726f4273b9450a4508e223988b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/interrupts.S  -o ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/interrupts.o.d"  -omf=elf -DXPRJ_default=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/interrupts.o.asm.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${DISTDIR}/MCU_App.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o ${DISTDIR}/MCU_App.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}      -mcpu=$(MP_PROCESSOR_OPTION)        -D__DEBUG=__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)      -Wl,--local-stack,,--defsym=__MPLAB_BUILD=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,-D__DEBUG=__DEBUG,,$(MP_LINKER_FILE_OPTION),--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--no-gc-sections,--fill-upper=0,--stackguard=16,--no-force-link,--smart-io,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--report-mem,--memorysummary,${DISTDIR}/memoryfile.xml$(MP_EXTRA_LD_POST)  -mdfp="${DFP_DIR}/xc16" 
	
else
${DISTDIR}/MCU_App.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o ${DISTDIR}/MCU_App.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}      -mcpu=$(MP_PROCESSOR_OPTION)        -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -Wl,--local-stack,,--defsym=__MPLAB_BUILD=1,$(MP_LINKER_FILE_OPTION),--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--no-gc-sections,--fill-upper=0,--stackguard=16,--no-force-link,--smart-io,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--report-mem,--memorysummary,${DISTDIR}/memoryfile.xml$(MP_EXTRA_LD_POST)  -mdfp="${DFP_DIR}/xc16" 
	${MP_CC_DIR}\\xc16-bin2hex ${DISTDIR}/MCU_App.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} -a  -omf=elf   -mdfp="${DFP_DIR}/xc16" 
	
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${OBJECTDIR}
	${RM} -r ${DISTDIR}

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(wildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
