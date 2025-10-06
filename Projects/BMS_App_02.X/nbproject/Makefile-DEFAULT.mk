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
ifeq "$(wildcard nbproject/Makefile-local-DEFAULT.mk)" "nbproject/Makefile-local-DEFAULT.mk"
include nbproject/Makefile-local-DEFAULT.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=DEFAULT
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/BMS_App_02.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/BMS_App_02.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
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
SOURCEFILES_QUOTED_IF_SPACED=../../Libraries/PIC33_plib/src/ADC.c ../../Libraries/PIC33_plib/src/pins.c ../../Libraries/PIC33_plib/src/OC.c ../../Libraries/PIC33_plib/src/CAN.c ../../Libraries/PIC33_plib/src/sleep.c ../../Libraries/Standard/movingAverage.c ../../Libraries/PIC33_plib/src/spi.c ../../Libraries/Standard/utils.c ../../Libraries/Drivers/ISO_TP_LITE/can_iso_tp_lite.c ../../RTOS/Scheduler/SysTick.c ../../Libraries/Standard/ringBuffer.c ../../Libraries/PIC33_plib/src/ic.c ../../Libraries/CommandService/commandService.c ../../Libraries/Standard/NTC.c ../../Libraries/Standard/movingAverageInt.c ../../RTOS/Scheduler/cpu_usage.c ../../Libraries/PIC33_plib/src/timer.c mcc_generated_files/boot/user_interrupt_table.S mcc_generated_files/boot/hardware_interrupt_table.S mcc_generated_files/boot/interrupts.S mcc_generated_files/boot/memory_partition.S mcc_generated_files/boot/application_header_not_blank.S mcc_generated_files/reset.c mcc_generated_files/mcc.c mcc_generated_files/traps.c mcc_generated_files/system.c mcc_generated_files/interrupt_manager.c mcc_generated_files/pin_manager.c mcc_generated_files/clock.c mcc_generated_files/where_was_i.s main.c tsk.c tsk_cfg.c IO.c StateMachine.c pinSetup.c ../../CAN/generated/bms_dbc.c ltc6802.c can_populate.c ev_charger.c bms.c dcdc.c j1772.c ltc6802_1_nb.c contactorControl.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/_ext/356824117/ADC.o ${OBJECTDIR}/_ext/356824117/pins.o ${OBJECTDIR}/_ext/356824117/OC.o ${OBJECTDIR}/_ext/356824117/CAN.o ${OBJECTDIR}/_ext/356824117/sleep.o ${OBJECTDIR}/_ext/1136797869/movingAverage.o ${OBJECTDIR}/_ext/356824117/spi.o ${OBJECTDIR}/_ext/1136797869/utils.o ${OBJECTDIR}/_ext/1750102429/can_iso_tp_lite.o ${OBJECTDIR}/_ext/1176946926/SysTick.o ${OBJECTDIR}/_ext/1136797869/ringBuffer.o ${OBJECTDIR}/_ext/356824117/ic.o ${OBJECTDIR}/_ext/1983695616/commandService.o ${OBJECTDIR}/_ext/1136797869/NTC.o ${OBJECTDIR}/_ext/1136797869/movingAverageInt.o ${OBJECTDIR}/_ext/1176946926/cpu_usage.o ${OBJECTDIR}/_ext/356824117/timer.o ${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o ${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o ${OBJECTDIR}/mcc_generated_files/reset.o ${OBJECTDIR}/mcc_generated_files/mcc.o ${OBJECTDIR}/mcc_generated_files/traps.o ${OBJECTDIR}/mcc_generated_files/system.o ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o ${OBJECTDIR}/mcc_generated_files/pin_manager.o ${OBJECTDIR}/mcc_generated_files/clock.o ${OBJECTDIR}/mcc_generated_files/where_was_i.o ${OBJECTDIR}/main.o ${OBJECTDIR}/tsk.o ${OBJECTDIR}/tsk_cfg.o ${OBJECTDIR}/IO.o ${OBJECTDIR}/StateMachine.o ${OBJECTDIR}/pinSetup.o ${OBJECTDIR}/_ext/469142448/bms_dbc.o ${OBJECTDIR}/ltc6802.o ${OBJECTDIR}/can_populate.o ${OBJECTDIR}/ev_charger.o ${OBJECTDIR}/bms.o ${OBJECTDIR}/dcdc.o ${OBJECTDIR}/j1772.o ${OBJECTDIR}/ltc6802_1_nb.o ${OBJECTDIR}/contactorControl.o
POSSIBLE_DEPFILES=${OBJECTDIR}/_ext/356824117/ADC.o.d ${OBJECTDIR}/_ext/356824117/pins.o.d ${OBJECTDIR}/_ext/356824117/OC.o.d ${OBJECTDIR}/_ext/356824117/CAN.o.d ${OBJECTDIR}/_ext/356824117/sleep.o.d ${OBJECTDIR}/_ext/1136797869/movingAverage.o.d ${OBJECTDIR}/_ext/356824117/spi.o.d ${OBJECTDIR}/_ext/1136797869/utils.o.d ${OBJECTDIR}/_ext/1750102429/can_iso_tp_lite.o.d ${OBJECTDIR}/_ext/1176946926/SysTick.o.d ${OBJECTDIR}/_ext/1136797869/ringBuffer.o.d ${OBJECTDIR}/_ext/356824117/ic.o.d ${OBJECTDIR}/_ext/1983695616/commandService.o.d ${OBJECTDIR}/_ext/1136797869/NTC.o.d ${OBJECTDIR}/_ext/1136797869/movingAverageInt.o.d ${OBJECTDIR}/_ext/1176946926/cpu_usage.o.d ${OBJECTDIR}/_ext/356824117/timer.o.d ${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o.d ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o.d ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o.d ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o.d ${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o.d ${OBJECTDIR}/mcc_generated_files/reset.o.d ${OBJECTDIR}/mcc_generated_files/mcc.o.d ${OBJECTDIR}/mcc_generated_files/traps.o.d ${OBJECTDIR}/mcc_generated_files/system.o.d ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o.d ${OBJECTDIR}/mcc_generated_files/pin_manager.o.d ${OBJECTDIR}/mcc_generated_files/clock.o.d ${OBJECTDIR}/mcc_generated_files/where_was_i.o.d ${OBJECTDIR}/main.o.d ${OBJECTDIR}/tsk.o.d ${OBJECTDIR}/tsk_cfg.o.d ${OBJECTDIR}/IO.o.d ${OBJECTDIR}/StateMachine.o.d ${OBJECTDIR}/pinSetup.o.d ${OBJECTDIR}/_ext/469142448/bms_dbc.o.d ${OBJECTDIR}/ltc6802.o.d ${OBJECTDIR}/can_populate.o.d ${OBJECTDIR}/ev_charger.o.d ${OBJECTDIR}/bms.o.d ${OBJECTDIR}/dcdc.o.d ${OBJECTDIR}/j1772.o.d ${OBJECTDIR}/ltc6802_1_nb.o.d ${OBJECTDIR}/contactorControl.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/356824117/ADC.o ${OBJECTDIR}/_ext/356824117/pins.o ${OBJECTDIR}/_ext/356824117/OC.o ${OBJECTDIR}/_ext/356824117/CAN.o ${OBJECTDIR}/_ext/356824117/sleep.o ${OBJECTDIR}/_ext/1136797869/movingAverage.o ${OBJECTDIR}/_ext/356824117/spi.o ${OBJECTDIR}/_ext/1136797869/utils.o ${OBJECTDIR}/_ext/1750102429/can_iso_tp_lite.o ${OBJECTDIR}/_ext/1176946926/SysTick.o ${OBJECTDIR}/_ext/1136797869/ringBuffer.o ${OBJECTDIR}/_ext/356824117/ic.o ${OBJECTDIR}/_ext/1983695616/commandService.o ${OBJECTDIR}/_ext/1136797869/NTC.o ${OBJECTDIR}/_ext/1136797869/movingAverageInt.o ${OBJECTDIR}/_ext/1176946926/cpu_usage.o ${OBJECTDIR}/_ext/356824117/timer.o ${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o ${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o ${OBJECTDIR}/mcc_generated_files/reset.o ${OBJECTDIR}/mcc_generated_files/mcc.o ${OBJECTDIR}/mcc_generated_files/traps.o ${OBJECTDIR}/mcc_generated_files/system.o ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o ${OBJECTDIR}/mcc_generated_files/pin_manager.o ${OBJECTDIR}/mcc_generated_files/clock.o ${OBJECTDIR}/mcc_generated_files/where_was_i.o ${OBJECTDIR}/main.o ${OBJECTDIR}/tsk.o ${OBJECTDIR}/tsk_cfg.o ${OBJECTDIR}/IO.o ${OBJECTDIR}/StateMachine.o ${OBJECTDIR}/pinSetup.o ${OBJECTDIR}/_ext/469142448/bms_dbc.o ${OBJECTDIR}/ltc6802.o ${OBJECTDIR}/can_populate.o ${OBJECTDIR}/ev_charger.o ${OBJECTDIR}/bms.o ${OBJECTDIR}/dcdc.o ${OBJECTDIR}/j1772.o ${OBJECTDIR}/ltc6802_1_nb.o ${OBJECTDIR}/contactorControl.o

# Source Files
SOURCEFILES=../../Libraries/PIC33_plib/src/ADC.c ../../Libraries/PIC33_plib/src/pins.c ../../Libraries/PIC33_plib/src/OC.c ../../Libraries/PIC33_plib/src/CAN.c ../../Libraries/PIC33_plib/src/sleep.c ../../Libraries/Standard/movingAverage.c ../../Libraries/PIC33_plib/src/spi.c ../../Libraries/Standard/utils.c ../../Libraries/Drivers/ISO_TP_LITE/can_iso_tp_lite.c ../../RTOS/Scheduler/SysTick.c ../../Libraries/Standard/ringBuffer.c ../../Libraries/PIC33_plib/src/ic.c ../../Libraries/CommandService/commandService.c ../../Libraries/Standard/NTC.c ../../Libraries/Standard/movingAverageInt.c ../../RTOS/Scheduler/cpu_usage.c ../../Libraries/PIC33_plib/src/timer.c mcc_generated_files/boot/user_interrupt_table.S mcc_generated_files/boot/hardware_interrupt_table.S mcc_generated_files/boot/interrupts.S mcc_generated_files/boot/memory_partition.S mcc_generated_files/boot/application_header_not_blank.S mcc_generated_files/reset.c mcc_generated_files/mcc.c mcc_generated_files/traps.c mcc_generated_files/system.c mcc_generated_files/interrupt_manager.c mcc_generated_files/pin_manager.c mcc_generated_files/clock.c mcc_generated_files/where_was_i.s main.c tsk.c tsk_cfg.c IO.c StateMachine.c pinSetup.c ../../CAN/generated/bms_dbc.c ltc6802.c can_populate.c ev_charger.c bms.c dcdc.c j1772.c ltc6802_1_nb.c contactorControl.c



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
	${MAKE}  -f nbproject/Makefile-DEFAULT.mk ${DISTDIR}/BMS_App_02.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=33EP256MC506
MP_LINKER_FILE_OPTION=,--script=p33EP256MC506.gld
# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/356824117/ADC.o: ../../Libraries/PIC33_plib/src/ADC.c  .generated_files/flags/DEFAULT/f7a407f875a2163e60b26e9da4de6de902881ddf .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/ADC.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/ADC.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/ADC.c  -o ${OBJECTDIR}/_ext/356824117/ADC.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/ADC.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/pins.o: ../../Libraries/PIC33_plib/src/pins.c  .generated_files/flags/DEFAULT/10f7e3b5f939b24c302c6641b80341b5403bcd2d .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/pins.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/pins.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/pins.c  -o ${OBJECTDIR}/_ext/356824117/pins.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/pins.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/OC.o: ../../Libraries/PIC33_plib/src/OC.c  .generated_files/flags/DEFAULT/86d9947fc835ad7e8a254722cb15d95d93821f25 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/OC.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/OC.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/OC.c  -o ${OBJECTDIR}/_ext/356824117/OC.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/OC.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/CAN.o: ../../Libraries/PIC33_plib/src/CAN.c  .generated_files/flags/DEFAULT/3fa6e418479f06017a7233df2fdfe907678d9755 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/CAN.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/CAN.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/CAN.c  -o ${OBJECTDIR}/_ext/356824117/CAN.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/CAN.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/sleep.o: ../../Libraries/PIC33_plib/src/sleep.c  .generated_files/flags/DEFAULT/27ae2c1c0033d6719b813b099063f87178351900 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/sleep.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/sleep.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/sleep.c  -o ${OBJECTDIR}/_ext/356824117/sleep.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/sleep.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1136797869/movingAverage.o: ../../Libraries/Standard/movingAverage.c  .generated_files/flags/DEFAULT/1ad009b7eeb250781a10abe9b086a084601049d8 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1136797869" 
	@${RM} ${OBJECTDIR}/_ext/1136797869/movingAverage.o.d 
	@${RM} ${OBJECTDIR}/_ext/1136797869/movingAverage.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/Standard/movingAverage.c  -o ${OBJECTDIR}/_ext/1136797869/movingAverage.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1136797869/movingAverage.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/spi.o: ../../Libraries/PIC33_plib/src/spi.c  .generated_files/flags/DEFAULT/b133f9105a079b45e14c508c2248d7644c5ffaec .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/spi.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/spi.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/spi.c  -o ${OBJECTDIR}/_ext/356824117/spi.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/spi.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1136797869/utils.o: ../../Libraries/Standard/utils.c  .generated_files/flags/DEFAULT/55a73aa80dbfb364fa1edbbdb2f5f287743c9a28 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1136797869" 
	@${RM} ${OBJECTDIR}/_ext/1136797869/utils.o.d 
	@${RM} ${OBJECTDIR}/_ext/1136797869/utils.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/Standard/utils.c  -o ${OBJECTDIR}/_ext/1136797869/utils.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1136797869/utils.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1750102429/can_iso_tp_lite.o: ../../Libraries/Drivers/ISO_TP_LITE/can_iso_tp_lite.c  .generated_files/flags/DEFAULT/60ab4d08fd058c0a5eef4f1b948c7b8869a72414 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1750102429" 
	@${RM} ${OBJECTDIR}/_ext/1750102429/can_iso_tp_lite.o.d 
	@${RM} ${OBJECTDIR}/_ext/1750102429/can_iso_tp_lite.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/Drivers/ISO_TP_LITE/can_iso_tp_lite.c  -o ${OBJECTDIR}/_ext/1750102429/can_iso_tp_lite.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1750102429/can_iso_tp_lite.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1176946926/SysTick.o: ../../RTOS/Scheduler/SysTick.c  .generated_files/flags/DEFAULT/116f2bfc28d12aa822d489917095db99c44ddcbc .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1176946926" 
	@${RM} ${OBJECTDIR}/_ext/1176946926/SysTick.o.d 
	@${RM} ${OBJECTDIR}/_ext/1176946926/SysTick.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../RTOS/Scheduler/SysTick.c  -o ${OBJECTDIR}/_ext/1176946926/SysTick.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1176946926/SysTick.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1136797869/ringBuffer.o: ../../Libraries/Standard/ringBuffer.c  .generated_files/flags/DEFAULT/6d7157e7a9c9206ac857a8efbf0ce4f6e943ccdd .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1136797869" 
	@${RM} ${OBJECTDIR}/_ext/1136797869/ringBuffer.o.d 
	@${RM} ${OBJECTDIR}/_ext/1136797869/ringBuffer.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/Standard/ringBuffer.c  -o ${OBJECTDIR}/_ext/1136797869/ringBuffer.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1136797869/ringBuffer.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/ic.o: ../../Libraries/PIC33_plib/src/ic.c  .generated_files/flags/DEFAULT/3df0fba8fa7a97c60e8bd743e60a73e4391da3de .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/ic.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/ic.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/ic.c  -o ${OBJECTDIR}/_ext/356824117/ic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/ic.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1983695616/commandService.o: ../../Libraries/CommandService/commandService.c  .generated_files/flags/DEFAULT/741fd21152129b9c70bae256c39f74788dc4cca4 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1983695616" 
	@${RM} ${OBJECTDIR}/_ext/1983695616/commandService.o.d 
	@${RM} ${OBJECTDIR}/_ext/1983695616/commandService.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/CommandService/commandService.c  -o ${OBJECTDIR}/_ext/1983695616/commandService.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1983695616/commandService.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1136797869/NTC.o: ../../Libraries/Standard/NTC.c  .generated_files/flags/DEFAULT/d50efced6bd7754e18b0d100a04a456a19f6c65b .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1136797869" 
	@${RM} ${OBJECTDIR}/_ext/1136797869/NTC.o.d 
	@${RM} ${OBJECTDIR}/_ext/1136797869/NTC.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/Standard/NTC.c  -o ${OBJECTDIR}/_ext/1136797869/NTC.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1136797869/NTC.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1136797869/movingAverageInt.o: ../../Libraries/Standard/movingAverageInt.c  .generated_files/flags/DEFAULT/b34ec1ff11551e0fe28249af63de8d152d71f724 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1136797869" 
	@${RM} ${OBJECTDIR}/_ext/1136797869/movingAverageInt.o.d 
	@${RM} ${OBJECTDIR}/_ext/1136797869/movingAverageInt.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/Standard/movingAverageInt.c  -o ${OBJECTDIR}/_ext/1136797869/movingAverageInt.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1136797869/movingAverageInt.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1176946926/cpu_usage.o: ../../RTOS/Scheduler/cpu_usage.c  .generated_files/flags/DEFAULT/8113f410ae6cd685f8e1da9a172b0ef5a358daed .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1176946926" 
	@${RM} ${OBJECTDIR}/_ext/1176946926/cpu_usage.o.d 
	@${RM} ${OBJECTDIR}/_ext/1176946926/cpu_usage.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../RTOS/Scheduler/cpu_usage.c  -o ${OBJECTDIR}/_ext/1176946926/cpu_usage.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1176946926/cpu_usage.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/timer.o: ../../Libraries/PIC33_plib/src/timer.c  .generated_files/flags/DEFAULT/40b6a8c19a60a267e6cd8d68ce1afa4e9df95eed .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/timer.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/timer.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/timer.c  -o ${OBJECTDIR}/_ext/356824117/timer.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/timer.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/reset.o: mcc_generated_files/reset.c  .generated_files/flags/DEFAULT/dbadbd8127f22c2004c24158091951fbb77a32c .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/reset.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/reset.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/reset.c  -o ${OBJECTDIR}/mcc_generated_files/reset.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/reset.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/mcc.o: mcc_generated_files/mcc.c  .generated_files/flags/DEFAULT/a208686865b7b2c18e92f9311688e2f8dbc4b794 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/mcc.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/mcc.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/mcc.c  -o ${OBJECTDIR}/mcc_generated_files/mcc.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/mcc.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/traps.o: mcc_generated_files/traps.c  .generated_files/flags/DEFAULT/8a5dc0b20339b065e06c50f0eb419e480caa7dcc .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/traps.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/traps.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/traps.c  -o ${OBJECTDIR}/mcc_generated_files/traps.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/traps.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/system.o: mcc_generated_files/system.c  .generated_files/flags/DEFAULT/6bc88de8b49a62c05f5ab7c61fe31fece41cc70 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/system.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/system.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/system.c  -o ${OBJECTDIR}/mcc_generated_files/system.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/system.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/interrupt_manager.o: mcc_generated_files/interrupt_manager.c  .generated_files/flags/DEFAULT/5e1ec1d0640ae6abec212a0bb0a215694ca8ca28 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/interrupt_manager.c  -o ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/interrupt_manager.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/pin_manager.o: mcc_generated_files/pin_manager.c  .generated_files/flags/DEFAULT/dd5e8ff88e55cbd24f38fd50ab1c8855e529e668 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/pin_manager.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/pin_manager.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/pin_manager.c  -o ${OBJECTDIR}/mcc_generated_files/pin_manager.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/pin_manager.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/clock.o: mcc_generated_files/clock.c  .generated_files/flags/DEFAULT/5f94e424bcbb38050d1359c96757b13197915b51 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/clock.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/clock.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/clock.c  -o ${OBJECTDIR}/mcc_generated_files/clock.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/clock.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/main.o: main.c  .generated_files/flags/DEFAULT/1830c1e629950df904ccba4d04a6b38c368d6b0f .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/main.o.d 
	@${RM} ${OBJECTDIR}/main.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  main.c  -o ${OBJECTDIR}/main.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/main.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/tsk.o: tsk.c  .generated_files/flags/DEFAULT/e2613fb489eb620a2c42b7ae4f3af9ed87aa26e0 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/tsk.o.d 
	@${RM} ${OBJECTDIR}/tsk.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  tsk.c  -o ${OBJECTDIR}/tsk.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/tsk.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/tsk_cfg.o: tsk_cfg.c  .generated_files/flags/DEFAULT/f4af44b8475bff6591a387e614d7584f66445a08 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/tsk_cfg.o.d 
	@${RM} ${OBJECTDIR}/tsk_cfg.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  tsk_cfg.c  -o ${OBJECTDIR}/tsk_cfg.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/tsk_cfg.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/IO.o: IO.c  .generated_files/flags/DEFAULT/f286931476599804f6a7dc6bd66bbe7c11f98e8 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/IO.o.d 
	@${RM} ${OBJECTDIR}/IO.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  IO.c  -o ${OBJECTDIR}/IO.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/IO.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/StateMachine.o: StateMachine.c  .generated_files/flags/DEFAULT/645717d8305aa951534575389fbe851816f36d66 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/StateMachine.o.d 
	@${RM} ${OBJECTDIR}/StateMachine.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  StateMachine.c  -o ${OBJECTDIR}/StateMachine.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/StateMachine.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/pinSetup.o: pinSetup.c  .generated_files/flags/DEFAULT/9322c5773fb3f432cdf6f5234fa0ed9fe6e74034 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/pinSetup.o.d 
	@${RM} ${OBJECTDIR}/pinSetup.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  pinSetup.c  -o ${OBJECTDIR}/pinSetup.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/pinSetup.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/469142448/bms_dbc.o: ../../CAN/generated/bms_dbc.c  .generated_files/flags/DEFAULT/393a1a1f90b1d014c33889b4ed8b5276bf02dd9d .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/469142448" 
	@${RM} ${OBJECTDIR}/_ext/469142448/bms_dbc.o.d 
	@${RM} ${OBJECTDIR}/_ext/469142448/bms_dbc.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../CAN/generated/bms_dbc.c  -o ${OBJECTDIR}/_ext/469142448/bms_dbc.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/469142448/bms_dbc.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/ltc6802.o: ltc6802.c  .generated_files/flags/DEFAULT/abf3012c7cbdd31dbb359b40da4901278391cd1a .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/ltc6802.o.d 
	@${RM} ${OBJECTDIR}/ltc6802.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ltc6802.c  -o ${OBJECTDIR}/ltc6802.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/ltc6802.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/can_populate.o: can_populate.c  .generated_files/flags/DEFAULT/aaedd32a2cdf38c927a4dcf0fe442887bfc2e85c .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/can_populate.o.d 
	@${RM} ${OBJECTDIR}/can_populate.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  can_populate.c  -o ${OBJECTDIR}/can_populate.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/can_populate.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/ev_charger.o: ev_charger.c  .generated_files/flags/DEFAULT/ea2861612aa15f6e8baa0c871c2e53285841b07a .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/ev_charger.o.d 
	@${RM} ${OBJECTDIR}/ev_charger.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ev_charger.c  -o ${OBJECTDIR}/ev_charger.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/ev_charger.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/bms.o: bms.c  .generated_files/flags/DEFAULT/1e93e0a72e8f2086f4478eb8464e03be9350726f .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/bms.o.d 
	@${RM} ${OBJECTDIR}/bms.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  bms.c  -o ${OBJECTDIR}/bms.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/bms.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/dcdc.o: dcdc.c  .generated_files/flags/DEFAULT/5b0f3abe4233fd734e2be5fc5c5db5b48bf687c0 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/dcdc.o.d 
	@${RM} ${OBJECTDIR}/dcdc.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  dcdc.c  -o ${OBJECTDIR}/dcdc.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/dcdc.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/j1772.o: j1772.c  .generated_files/flags/DEFAULT/170a2b340b21bc329adc816df37ba7716501fea8 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/j1772.o.d 
	@${RM} ${OBJECTDIR}/j1772.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  j1772.c  -o ${OBJECTDIR}/j1772.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/j1772.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/ltc6802_1_nb.o: ltc6802_1_nb.c  .generated_files/flags/DEFAULT/9419a09b908ede3cfd9f3eaf49f6d58434cbe1d3 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/ltc6802_1_nb.o.d 
	@${RM} ${OBJECTDIR}/ltc6802_1_nb.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ltc6802_1_nb.c  -o ${OBJECTDIR}/ltc6802_1_nb.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/ltc6802_1_nb.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/contactorControl.o: contactorControl.c  .generated_files/flags/DEFAULT/7b8b40befac29aa5b6912a2119824d9bb6ac8034 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/contactorControl.o.d 
	@${RM} ${OBJECTDIR}/contactorControl.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  contactorControl.c  -o ${OBJECTDIR}/contactorControl.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/contactorControl.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
else
${OBJECTDIR}/_ext/356824117/ADC.o: ../../Libraries/PIC33_plib/src/ADC.c  .generated_files/flags/DEFAULT/6cd2ac5f08386d68c239f1090514af20dbc0c36 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/ADC.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/ADC.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/ADC.c  -o ${OBJECTDIR}/_ext/356824117/ADC.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/ADC.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/pins.o: ../../Libraries/PIC33_plib/src/pins.c  .generated_files/flags/DEFAULT/f808b363ff925f87b72808080ad4e9e45a2c4eba .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/pins.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/pins.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/pins.c  -o ${OBJECTDIR}/_ext/356824117/pins.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/pins.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/OC.o: ../../Libraries/PIC33_plib/src/OC.c  .generated_files/flags/DEFAULT/db8ec5a50873ffd9fce1f85a46439ff4dfd2a515 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/OC.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/OC.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/OC.c  -o ${OBJECTDIR}/_ext/356824117/OC.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/OC.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/CAN.o: ../../Libraries/PIC33_plib/src/CAN.c  .generated_files/flags/DEFAULT/eb9938e8fae6c48b575cae9ee101c9b1c36f6c94 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/CAN.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/CAN.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/CAN.c  -o ${OBJECTDIR}/_ext/356824117/CAN.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/CAN.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/sleep.o: ../../Libraries/PIC33_plib/src/sleep.c  .generated_files/flags/DEFAULT/b6ef46d069646dc722a5492ddb2513720e784254 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/sleep.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/sleep.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/sleep.c  -o ${OBJECTDIR}/_ext/356824117/sleep.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/sleep.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1136797869/movingAverage.o: ../../Libraries/Standard/movingAverage.c  .generated_files/flags/DEFAULT/5120c994f913e69f683aa0f9d943c0cd6d958627 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1136797869" 
	@${RM} ${OBJECTDIR}/_ext/1136797869/movingAverage.o.d 
	@${RM} ${OBJECTDIR}/_ext/1136797869/movingAverage.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/Standard/movingAverage.c  -o ${OBJECTDIR}/_ext/1136797869/movingAverage.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1136797869/movingAverage.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/spi.o: ../../Libraries/PIC33_plib/src/spi.c  .generated_files/flags/DEFAULT/2f828f7786d898d345dbaa225b4f50442e29b608 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/spi.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/spi.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/spi.c  -o ${OBJECTDIR}/_ext/356824117/spi.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/spi.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1136797869/utils.o: ../../Libraries/Standard/utils.c  .generated_files/flags/DEFAULT/2201a02f53d9ae8187ccb57a2cac046f573ba9d2 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1136797869" 
	@${RM} ${OBJECTDIR}/_ext/1136797869/utils.o.d 
	@${RM} ${OBJECTDIR}/_ext/1136797869/utils.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/Standard/utils.c  -o ${OBJECTDIR}/_ext/1136797869/utils.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1136797869/utils.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1750102429/can_iso_tp_lite.o: ../../Libraries/Drivers/ISO_TP_LITE/can_iso_tp_lite.c  .generated_files/flags/DEFAULT/c445d2bab72b9c7ab2e2ce60078c891f47ca588 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1750102429" 
	@${RM} ${OBJECTDIR}/_ext/1750102429/can_iso_tp_lite.o.d 
	@${RM} ${OBJECTDIR}/_ext/1750102429/can_iso_tp_lite.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/Drivers/ISO_TP_LITE/can_iso_tp_lite.c  -o ${OBJECTDIR}/_ext/1750102429/can_iso_tp_lite.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1750102429/can_iso_tp_lite.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1176946926/SysTick.o: ../../RTOS/Scheduler/SysTick.c  .generated_files/flags/DEFAULT/a57489df76f5a8ef5d87468edc3dbc8c5ea38b78 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1176946926" 
	@${RM} ${OBJECTDIR}/_ext/1176946926/SysTick.o.d 
	@${RM} ${OBJECTDIR}/_ext/1176946926/SysTick.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../RTOS/Scheduler/SysTick.c  -o ${OBJECTDIR}/_ext/1176946926/SysTick.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1176946926/SysTick.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1136797869/ringBuffer.o: ../../Libraries/Standard/ringBuffer.c  .generated_files/flags/DEFAULT/728080c6a672f0be8f19ee244bed22863e7f21e9 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1136797869" 
	@${RM} ${OBJECTDIR}/_ext/1136797869/ringBuffer.o.d 
	@${RM} ${OBJECTDIR}/_ext/1136797869/ringBuffer.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/Standard/ringBuffer.c  -o ${OBJECTDIR}/_ext/1136797869/ringBuffer.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1136797869/ringBuffer.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/ic.o: ../../Libraries/PIC33_plib/src/ic.c  .generated_files/flags/DEFAULT/4eadf9cffa49a461c4b93228340c1b14de658a06 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/ic.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/ic.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/ic.c  -o ${OBJECTDIR}/_ext/356824117/ic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/ic.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1983695616/commandService.o: ../../Libraries/CommandService/commandService.c  .generated_files/flags/DEFAULT/f94b815322f527108eebcaa67bac4c1cf3006362 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1983695616" 
	@${RM} ${OBJECTDIR}/_ext/1983695616/commandService.o.d 
	@${RM} ${OBJECTDIR}/_ext/1983695616/commandService.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/CommandService/commandService.c  -o ${OBJECTDIR}/_ext/1983695616/commandService.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1983695616/commandService.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1136797869/NTC.o: ../../Libraries/Standard/NTC.c  .generated_files/flags/DEFAULT/f53c1ae1986808cdf4b4ea80aefc1942e793a8fd .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1136797869" 
	@${RM} ${OBJECTDIR}/_ext/1136797869/NTC.o.d 
	@${RM} ${OBJECTDIR}/_ext/1136797869/NTC.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/Standard/NTC.c  -o ${OBJECTDIR}/_ext/1136797869/NTC.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1136797869/NTC.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1136797869/movingAverageInt.o: ../../Libraries/Standard/movingAverageInt.c  .generated_files/flags/DEFAULT/14e3572d191b5666a042c861204866652163aa55 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1136797869" 
	@${RM} ${OBJECTDIR}/_ext/1136797869/movingAverageInt.o.d 
	@${RM} ${OBJECTDIR}/_ext/1136797869/movingAverageInt.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/Standard/movingAverageInt.c  -o ${OBJECTDIR}/_ext/1136797869/movingAverageInt.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1136797869/movingAverageInt.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1176946926/cpu_usage.o: ../../RTOS/Scheduler/cpu_usage.c  .generated_files/flags/DEFAULT/31c10f347d88e22488089f962454c1420d578617 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1176946926" 
	@${RM} ${OBJECTDIR}/_ext/1176946926/cpu_usage.o.d 
	@${RM} ${OBJECTDIR}/_ext/1176946926/cpu_usage.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../RTOS/Scheduler/cpu_usage.c  -o ${OBJECTDIR}/_ext/1176946926/cpu_usage.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1176946926/cpu_usage.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/timer.o: ../../Libraries/PIC33_plib/src/timer.c  .generated_files/flags/DEFAULT/8e747492f243765f87b14c079709415efb278419 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/timer.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/timer.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/timer.c  -o ${OBJECTDIR}/_ext/356824117/timer.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/timer.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/reset.o: mcc_generated_files/reset.c  .generated_files/flags/DEFAULT/3bbd938e34c28e67854c3249ba80a5fb5808969b .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/reset.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/reset.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/reset.c  -o ${OBJECTDIR}/mcc_generated_files/reset.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/reset.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/mcc.o: mcc_generated_files/mcc.c  .generated_files/flags/DEFAULT/d68452afb88e553ff0afe12c5db79e8d4e5b9d37 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/mcc.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/mcc.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/mcc.c  -o ${OBJECTDIR}/mcc_generated_files/mcc.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/mcc.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/traps.o: mcc_generated_files/traps.c  .generated_files/flags/DEFAULT/8de5e68cbaf9c5479196c51c9f45b5396c979311 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/traps.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/traps.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/traps.c  -o ${OBJECTDIR}/mcc_generated_files/traps.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/traps.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/system.o: mcc_generated_files/system.c  .generated_files/flags/DEFAULT/8b1f2bf01954c4e0d338ab8fb03f353b924e621c .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/system.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/system.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/system.c  -o ${OBJECTDIR}/mcc_generated_files/system.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/system.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/interrupt_manager.o: mcc_generated_files/interrupt_manager.c  .generated_files/flags/DEFAULT/2d9c1705d7ba17e9eb616e8c7f8abaf47120f95c .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/interrupt_manager.c  -o ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/interrupt_manager.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/pin_manager.o: mcc_generated_files/pin_manager.c  .generated_files/flags/DEFAULT/f34991cc73d68e829e4a43656cf62e20efabac99 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/pin_manager.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/pin_manager.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/pin_manager.c  -o ${OBJECTDIR}/mcc_generated_files/pin_manager.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/pin_manager.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/clock.o: mcc_generated_files/clock.c  .generated_files/flags/DEFAULT/f4913a1ebb1d178c69bbab26b8f1a3b43cc4f669 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/clock.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/clock.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/clock.c  -o ${OBJECTDIR}/mcc_generated_files/clock.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/clock.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/main.o: main.c  .generated_files/flags/DEFAULT/9950ece1ff7c6f33a3ec63fc40dc2a3d0c5504bc .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/main.o.d 
	@${RM} ${OBJECTDIR}/main.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  main.c  -o ${OBJECTDIR}/main.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/main.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/tsk.o: tsk.c  .generated_files/flags/DEFAULT/e6ec689703bc77cca409e7d546858f6bd998b51e .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/tsk.o.d 
	@${RM} ${OBJECTDIR}/tsk.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  tsk.c  -o ${OBJECTDIR}/tsk.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/tsk.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/tsk_cfg.o: tsk_cfg.c  .generated_files/flags/DEFAULT/377c00bf9cb66646053fe18be28ccc16bf1b37bd .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/tsk_cfg.o.d 
	@${RM} ${OBJECTDIR}/tsk_cfg.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  tsk_cfg.c  -o ${OBJECTDIR}/tsk_cfg.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/tsk_cfg.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/IO.o: IO.c  .generated_files/flags/DEFAULT/623bce2f048c75bcfa6350347776028fa2c22f8d .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/IO.o.d 
	@${RM} ${OBJECTDIR}/IO.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  IO.c  -o ${OBJECTDIR}/IO.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/IO.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/StateMachine.o: StateMachine.c  .generated_files/flags/DEFAULT/9258eaca5e8fb564aaa57a6bab7097ef38757704 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/StateMachine.o.d 
	@${RM} ${OBJECTDIR}/StateMachine.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  StateMachine.c  -o ${OBJECTDIR}/StateMachine.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/StateMachine.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/pinSetup.o: pinSetup.c  .generated_files/flags/DEFAULT/98a0ee81133770cc75c36eb0b57c3b3407723c9d .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/pinSetup.o.d 
	@${RM} ${OBJECTDIR}/pinSetup.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  pinSetup.c  -o ${OBJECTDIR}/pinSetup.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/pinSetup.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/469142448/bms_dbc.o: ../../CAN/generated/bms_dbc.c  .generated_files/flags/DEFAULT/fa55c8db0087519b39237ce7e3c161120f312546 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/469142448" 
	@${RM} ${OBJECTDIR}/_ext/469142448/bms_dbc.o.d 
	@${RM} ${OBJECTDIR}/_ext/469142448/bms_dbc.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../CAN/generated/bms_dbc.c  -o ${OBJECTDIR}/_ext/469142448/bms_dbc.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/469142448/bms_dbc.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/ltc6802.o: ltc6802.c  .generated_files/flags/DEFAULT/bf56c967cd1def33454de3ce7972168a44059c2e .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/ltc6802.o.d 
	@${RM} ${OBJECTDIR}/ltc6802.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ltc6802.c  -o ${OBJECTDIR}/ltc6802.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/ltc6802.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/can_populate.o: can_populate.c  .generated_files/flags/DEFAULT/5ee0ae7b49a23d0f2b9af24e220c1dbdfa1e1154 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/can_populate.o.d 
	@${RM} ${OBJECTDIR}/can_populate.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  can_populate.c  -o ${OBJECTDIR}/can_populate.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/can_populate.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/ev_charger.o: ev_charger.c  .generated_files/flags/DEFAULT/cd50c51e4ae763e06627f701445f6cff8520f8b1 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/ev_charger.o.d 
	@${RM} ${OBJECTDIR}/ev_charger.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ev_charger.c  -o ${OBJECTDIR}/ev_charger.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/ev_charger.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/bms.o: bms.c  .generated_files/flags/DEFAULT/c1a48ca213aa87f41a84f638a7f2f6fa4cea56b4 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/bms.o.d 
	@${RM} ${OBJECTDIR}/bms.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  bms.c  -o ${OBJECTDIR}/bms.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/bms.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/dcdc.o: dcdc.c  .generated_files/flags/DEFAULT/62e8617301572e6a71d265ca7295e96e21f26161 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/dcdc.o.d 
	@${RM} ${OBJECTDIR}/dcdc.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  dcdc.c  -o ${OBJECTDIR}/dcdc.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/dcdc.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/j1772.o: j1772.c  .generated_files/flags/DEFAULT/57085dfdbeb84c58b13f46b797b6a09e620482f7 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/j1772.o.d 
	@${RM} ${OBJECTDIR}/j1772.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  j1772.c  -o ${OBJECTDIR}/j1772.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/j1772.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/ltc6802_1_nb.o: ltc6802_1_nb.c  .generated_files/flags/DEFAULT/d42ff1f7c7cb5116b32e3c30aff18f9acbc7ebb4 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/ltc6802_1_nb.o.d 
	@${RM} ${OBJECTDIR}/ltc6802_1_nb.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ltc6802_1_nb.c  -o ${OBJECTDIR}/ltc6802_1_nb.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/ltc6802_1_nb.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/contactorControl.o: contactorControl.c  .generated_files/flags/DEFAULT/b592d7750e98c234018dd372423cb845bfb74313 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/contactorControl.o.d 
	@${RM} ${OBJECTDIR}/contactorControl.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  contactorControl.c  -o ${OBJECTDIR}/contactorControl.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/contactorControl.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -O1 -I"mcc_generated_files" -I"mcc_generated_files/boot" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/ISO_TP_LITE" -I"../../RTOS/Scheduler" -I"../../CAN/generated" -I"." -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/mcc_generated_files/where_was_i.o: mcc_generated_files/where_was_i.s  .generated_files/flags/DEFAULT/42b3557ca86fa325052a25e621996198d50b5d3a .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/where_was_i.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/where_was_i.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/where_was_i.s  -o ${OBJECTDIR}/mcc_generated_files/where_was_i.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/where_was_i.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_PK3=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
else
${OBJECTDIR}/mcc_generated_files/where_was_i.o: mcc_generated_files/where_was_i.s  .generated_files/flags/DEFAULT/b8789c08036e6e89ef75d7a042169dd6a7c53e1b .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/where_was_i.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/where_was_i.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/where_was_i.s  -o ${OBJECTDIR}/mcc_generated_files/where_was_i.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/where_was_i.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemblePreproc
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o: mcc_generated_files/boot/user_interrupt_table.S  .generated_files/flags/DEFAULT/5c684c85095745c64b7d1e693c6ccf964a97093c .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/user_interrupt_table.S  -o ${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o.d"  -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o.asm.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_PK3=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o: mcc_generated_files/boot/hardware_interrupt_table.S  .generated_files/flags/DEFAULT/2935d235449ae31124d771922771a4fca7945468 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/hardware_interrupt_table.S  -o ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o.d"  -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o.asm.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_PK3=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/interrupts.o: mcc_generated_files/boot/interrupts.S  .generated_files/flags/DEFAULT/fafebe351ca83877719aef659d0276fa48f5e24e .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/interrupts.S  -o ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/interrupts.o.d"  -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/interrupts.o.asm.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_PK3=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o: mcc_generated_files/boot/memory_partition.S  .generated_files/flags/DEFAULT/6764da2145c2f809e835546e04fa7252bea8225f .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/memory_partition.S  -o ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o.d"  -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o.asm.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_PK3=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o: mcc_generated_files/boot/application_header_not_blank.S  .generated_files/flags/DEFAULT/85b7d0fb9bfd90c8804dc7f0a2f229222c8d624a .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/application_header_not_blank.S  -o ${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o.d"  -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o.asm.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_PK3=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
else
${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o: mcc_generated_files/boot/user_interrupt_table.S  .generated_files/flags/DEFAULT/be42e47decd0441d8f4f0054da8896ba0efcb9a3 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/user_interrupt_table.S  -o ${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o.d"  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/user_interrupt_table.o.asm.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o: mcc_generated_files/boot/hardware_interrupt_table.S  .generated_files/flags/DEFAULT/38b2852fa0981f59d94822a43a67a3e5358d5de4 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/hardware_interrupt_table.S  -o ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o.d"  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o.asm.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/interrupts.o: mcc_generated_files/boot/interrupts.S  .generated_files/flags/DEFAULT/d9e2f4bde55f953fe0c4b7b4054853307baaf2f7 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/interrupts.S  -o ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/interrupts.o.d"  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/interrupts.o.asm.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o: mcc_generated_files/boot/memory_partition.S  .generated_files/flags/DEFAULT/25ded5a79ced496d7af4014347476263d0f3bbb6 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/memory_partition.S  -o ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o.d"  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o.asm.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o: mcc_generated_files/boot/application_header_not_blank.S  .generated_files/flags/DEFAULT/a1e9004081f9ca938210de68e638c80263073935 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/application_header_not_blank.S  -o ${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o.d"  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/application_header_not_blank.o.asm.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${DISTDIR}/BMS_App_02.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o ${DISTDIR}/BMS_App_02.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}      -mcpu=$(MP_PROCESSOR_OPTION)        -D__DEBUG=__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)   -mreserve=data@0x1000:0x101B -mreserve=data@0x101C:0x101D -mreserve=data@0x101E:0x101F -mreserve=data@0x1020:0x1021 -mreserve=data@0x1022:0x1023 -mreserve=data@0x1024:0x1027 -mreserve=data@0x1028:0x104F   -Wl,--local-stack,,--defsym=__MPLAB_BUILD=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,-D__DEBUG=__DEBUG,--defsym=__MPLAB_DEBUGGER_PK3=1,$(MP_LINKER_FILE_OPTION),--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--no-gc-sections,--fill-upper=0,--stackguard=16,--no-force-link,--smart-io,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--report-mem,--memorysummary,${DISTDIR}/memoryfile.xml$(MP_EXTRA_LD_POST)  -mdfp="${DFP_DIR}/xc16" 
	
else
${DISTDIR}/BMS_App_02.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o ${DISTDIR}/BMS_App_02.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}      -mcpu=$(MP_PROCESSOR_OPTION)        -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -Wl,--local-stack,,--defsym=__MPLAB_BUILD=1,$(MP_LINKER_FILE_OPTION),--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--no-gc-sections,--fill-upper=0,--stackguard=16,--no-force-link,--smart-io,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--report-mem,--memorysummary,${DISTDIR}/memoryfile.xml$(MP_EXTRA_LD_POST)  -mdfp="${DFP_DIR}/xc16" 
	${MP_CC_DIR}\\xc16-bin2hex ${DISTDIR}/BMS_App_02.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} -a  -omf=elf   -mdfp="${DFP_DIR}/xc16" 
	
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
