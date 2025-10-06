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
ifeq "$(wildcard nbproject/Makefile-local-DEBUG.mk)" "nbproject/Makefile-local-DEBUG.mk"
include nbproject/Makefile-local-DEBUG.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=DEBUG
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/MCU_Bootloader.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/MCU_Bootloader.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
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
SOURCEFILES_QUOTED_IF_SPACED=../../Libraries/can_bootloader/can_tp.c ../../Libraries/can_bootloader/can_tp_phy_adaptor.c ../../Libraries/PIC33_plib/src/reset_control.c mcc_generated_files/boot/memory_partition.S mcc_generated_files/boot/boot_process.c mcc_generated_files/boot/interrupts.S mcc_generated_files/boot/boot_demo.c mcc_generated_files/boot/boot_verify_not_blank.c mcc_generated_files/boot/hardware_interrupt_table.S ../../Libraries/can_bootloader/com_adaptor_can.c mcc_generated_files/boot/boot_application_header.c mcc_generated_files/memory/flash.s mcc_generated_files/pin_manager.c mcc_generated_files/traps.c mcc_generated_files/mcc.c mcc_generated_files/clock.c mcc_generated_files/reset.c mcc_generated_files/system.c mcc_generated_files/interrupt_manager.c mcc_generated_files/dma.c mcc_generated_files/tmr1.c mcc_generated_files/can1.c mcc_generated_files/uart1.c main.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/_ext/2049467722/can_tp.o ${OBJECTDIR}/_ext/2049467722/can_tp_phy_adaptor.o ${OBJECTDIR}/_ext/356824117/reset_control.o ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o ${OBJECTDIR}/mcc_generated_files/boot/boot_process.o ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o ${OBJECTDIR}/mcc_generated_files/boot/boot_demo.o ${OBJECTDIR}/mcc_generated_files/boot/boot_verify_not_blank.o ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o ${OBJECTDIR}/_ext/2049467722/com_adaptor_can.o ${OBJECTDIR}/mcc_generated_files/boot/boot_application_header.o ${OBJECTDIR}/mcc_generated_files/memory/flash.o ${OBJECTDIR}/mcc_generated_files/pin_manager.o ${OBJECTDIR}/mcc_generated_files/traps.o ${OBJECTDIR}/mcc_generated_files/mcc.o ${OBJECTDIR}/mcc_generated_files/clock.o ${OBJECTDIR}/mcc_generated_files/reset.o ${OBJECTDIR}/mcc_generated_files/system.o ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o ${OBJECTDIR}/mcc_generated_files/dma.o ${OBJECTDIR}/mcc_generated_files/tmr1.o ${OBJECTDIR}/mcc_generated_files/can1.o ${OBJECTDIR}/mcc_generated_files/uart1.o ${OBJECTDIR}/main.o
POSSIBLE_DEPFILES=${OBJECTDIR}/_ext/2049467722/can_tp.o.d ${OBJECTDIR}/_ext/2049467722/can_tp_phy_adaptor.o.d ${OBJECTDIR}/_ext/356824117/reset_control.o.d ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o.d ${OBJECTDIR}/mcc_generated_files/boot/boot_process.o.d ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o.d ${OBJECTDIR}/mcc_generated_files/boot/boot_demo.o.d ${OBJECTDIR}/mcc_generated_files/boot/boot_verify_not_blank.o.d ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o.d ${OBJECTDIR}/_ext/2049467722/com_adaptor_can.o.d ${OBJECTDIR}/mcc_generated_files/boot/boot_application_header.o.d ${OBJECTDIR}/mcc_generated_files/memory/flash.o.d ${OBJECTDIR}/mcc_generated_files/pin_manager.o.d ${OBJECTDIR}/mcc_generated_files/traps.o.d ${OBJECTDIR}/mcc_generated_files/mcc.o.d ${OBJECTDIR}/mcc_generated_files/clock.o.d ${OBJECTDIR}/mcc_generated_files/reset.o.d ${OBJECTDIR}/mcc_generated_files/system.o.d ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o.d ${OBJECTDIR}/mcc_generated_files/dma.o.d ${OBJECTDIR}/mcc_generated_files/tmr1.o.d ${OBJECTDIR}/mcc_generated_files/can1.o.d ${OBJECTDIR}/mcc_generated_files/uart1.o.d ${OBJECTDIR}/main.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/2049467722/can_tp.o ${OBJECTDIR}/_ext/2049467722/can_tp_phy_adaptor.o ${OBJECTDIR}/_ext/356824117/reset_control.o ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o ${OBJECTDIR}/mcc_generated_files/boot/boot_process.o ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o ${OBJECTDIR}/mcc_generated_files/boot/boot_demo.o ${OBJECTDIR}/mcc_generated_files/boot/boot_verify_not_blank.o ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o ${OBJECTDIR}/_ext/2049467722/com_adaptor_can.o ${OBJECTDIR}/mcc_generated_files/boot/boot_application_header.o ${OBJECTDIR}/mcc_generated_files/memory/flash.o ${OBJECTDIR}/mcc_generated_files/pin_manager.o ${OBJECTDIR}/mcc_generated_files/traps.o ${OBJECTDIR}/mcc_generated_files/mcc.o ${OBJECTDIR}/mcc_generated_files/clock.o ${OBJECTDIR}/mcc_generated_files/reset.o ${OBJECTDIR}/mcc_generated_files/system.o ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o ${OBJECTDIR}/mcc_generated_files/dma.o ${OBJECTDIR}/mcc_generated_files/tmr1.o ${OBJECTDIR}/mcc_generated_files/can1.o ${OBJECTDIR}/mcc_generated_files/uart1.o ${OBJECTDIR}/main.o

# Source Files
SOURCEFILES=../../Libraries/can_bootloader/can_tp.c ../../Libraries/can_bootloader/can_tp_phy_adaptor.c ../../Libraries/PIC33_plib/src/reset_control.c mcc_generated_files/boot/memory_partition.S mcc_generated_files/boot/boot_process.c mcc_generated_files/boot/interrupts.S mcc_generated_files/boot/boot_demo.c mcc_generated_files/boot/boot_verify_not_blank.c mcc_generated_files/boot/hardware_interrupt_table.S ../../Libraries/can_bootloader/com_adaptor_can.c mcc_generated_files/boot/boot_application_header.c mcc_generated_files/memory/flash.s mcc_generated_files/pin_manager.c mcc_generated_files/traps.c mcc_generated_files/mcc.c mcc_generated_files/clock.c mcc_generated_files/reset.c mcc_generated_files/system.c mcc_generated_files/interrupt_manager.c mcc_generated_files/dma.c mcc_generated_files/tmr1.c mcc_generated_files/can1.c mcc_generated_files/uart1.c main.c



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
	${MAKE}  -f nbproject/Makefile-DEBUG.mk ${DISTDIR}/MCU_Bootloader.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=33EP512MU810
MP_LINKER_FILE_OPTION=,--script=p33EP512MU810.gld
# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/2049467722/can_tp.o: ../../Libraries/can_bootloader/can_tp.c  .generated_files/flags/DEBUG/6106f1a7d7eb4bd16a30c4ef0cdaf8bb098a30c9 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/2049467722" 
	@${RM} ${OBJECTDIR}/_ext/2049467722/can_tp.o.d 
	@${RM} ${OBJECTDIR}/_ext/2049467722/can_tp.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/can_bootloader/can_tp.c  -o ${OBJECTDIR}/_ext/2049467722/can_tp.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/2049467722/can_tp.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/2049467722/can_tp_phy_adaptor.o: ../../Libraries/can_bootloader/can_tp_phy_adaptor.c  .generated_files/flags/DEBUG/61c1fe7fb96bc061cb3ea5a652aef5f954ab3edd .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/2049467722" 
	@${RM} ${OBJECTDIR}/_ext/2049467722/can_tp_phy_adaptor.o.d 
	@${RM} ${OBJECTDIR}/_ext/2049467722/can_tp_phy_adaptor.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/can_bootloader/can_tp_phy_adaptor.c  -o ${OBJECTDIR}/_ext/2049467722/can_tp_phy_adaptor.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/2049467722/can_tp_phy_adaptor.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/reset_control.o: ../../Libraries/PIC33_plib/src/reset_control.c  .generated_files/flags/DEBUG/48d716194574294d5cd31d6b0fa0b72007037a0 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/reset_control.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/reset_control.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/reset_control.c  -o ${OBJECTDIR}/_ext/356824117/reset_control.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/reset_control.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/boot_process.o: mcc_generated_files/boot/boot_process.c  .generated_files/flags/DEBUG/c9d8bcb66727741957615ebb38f3eacfa7154c .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_process.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_process.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/boot/boot_process.c  -o ${OBJECTDIR}/mcc_generated_files/boot/boot_process.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/boot_process.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/boot_demo.o: mcc_generated_files/boot/boot_demo.c  .generated_files/flags/DEBUG/310fdee6df392f211aab62468b1d548526edb661 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_demo.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_demo.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/boot/boot_demo.c  -o ${OBJECTDIR}/mcc_generated_files/boot/boot_demo.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/boot_demo.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/boot_verify_not_blank.o: mcc_generated_files/boot/boot_verify_not_blank.c  .generated_files/flags/DEBUG/d956a250bc88a527bb33bec54ce0b8e8fec15cdd .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_verify_not_blank.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_verify_not_blank.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/boot/boot_verify_not_blank.c  -o ${OBJECTDIR}/mcc_generated_files/boot/boot_verify_not_blank.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/boot_verify_not_blank.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/2049467722/com_adaptor_can.o: ../../Libraries/can_bootloader/com_adaptor_can.c  .generated_files/flags/DEBUG/f778fb1bde896d43023e7bf1ee8502755a471f5e .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/2049467722" 
	@${RM} ${OBJECTDIR}/_ext/2049467722/com_adaptor_can.o.d 
	@${RM} ${OBJECTDIR}/_ext/2049467722/com_adaptor_can.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/can_bootloader/com_adaptor_can.c  -o ${OBJECTDIR}/_ext/2049467722/com_adaptor_can.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/2049467722/com_adaptor_can.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/boot_application_header.o: mcc_generated_files/boot/boot_application_header.c  .generated_files/flags/DEBUG/fab4c6bc9fc14c921ef5981816f57afd057ce27 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_application_header.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_application_header.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/boot/boot_application_header.c  -o ${OBJECTDIR}/mcc_generated_files/boot/boot_application_header.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/boot_application_header.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/pin_manager.o: mcc_generated_files/pin_manager.c  .generated_files/flags/DEBUG/a48a3bcde9f72676943b3b70b208e6e4863df3c .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/pin_manager.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/pin_manager.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/pin_manager.c  -o ${OBJECTDIR}/mcc_generated_files/pin_manager.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/pin_manager.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/traps.o: mcc_generated_files/traps.c  .generated_files/flags/DEBUG/8abb0123a1268fc636a24c62556b0af2f4d8a2d4 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/traps.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/traps.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/traps.c  -o ${OBJECTDIR}/mcc_generated_files/traps.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/traps.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/mcc.o: mcc_generated_files/mcc.c  .generated_files/flags/DEBUG/80ff064cd3875dae19af8b78ecd2c0a4f9f86655 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/mcc.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/mcc.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/mcc.c  -o ${OBJECTDIR}/mcc_generated_files/mcc.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/mcc.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/clock.o: mcc_generated_files/clock.c  .generated_files/flags/DEBUG/c1cfd45ca77d75c3aca782a6c1bca9eab577591c .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/clock.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/clock.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/clock.c  -o ${OBJECTDIR}/mcc_generated_files/clock.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/clock.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/reset.o: mcc_generated_files/reset.c  .generated_files/flags/DEBUG/8eb2bb8f27487f846b56639dd67932b25b34f8ad .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/reset.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/reset.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/reset.c  -o ${OBJECTDIR}/mcc_generated_files/reset.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/reset.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/system.o: mcc_generated_files/system.c  .generated_files/flags/DEBUG/6646d15801c84f20910d1de9dd2514ecc0bbe08b .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/system.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/system.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/system.c  -o ${OBJECTDIR}/mcc_generated_files/system.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/system.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/interrupt_manager.o: mcc_generated_files/interrupt_manager.c  .generated_files/flags/DEBUG/d543476b3affa8d6a65db452f785268522a3520c .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/interrupt_manager.c  -o ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/interrupt_manager.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/dma.o: mcc_generated_files/dma.c  .generated_files/flags/DEBUG/3480481b8862272ac2654e8508bf9c9f0e469fcc .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/dma.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/dma.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/dma.c  -o ${OBJECTDIR}/mcc_generated_files/dma.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/dma.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/tmr1.o: mcc_generated_files/tmr1.c  .generated_files/flags/DEBUG/906ca1bd094e7041ec598c86bc43908573d058b5 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/tmr1.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/tmr1.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/tmr1.c  -o ${OBJECTDIR}/mcc_generated_files/tmr1.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/tmr1.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/can1.o: mcc_generated_files/can1.c  .generated_files/flags/DEBUG/8c906ce8f1ff3e9e224d3d5067ab27cb4633eef5 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/can1.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/can1.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/can1.c  -o ${OBJECTDIR}/mcc_generated_files/can1.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/can1.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/uart1.o: mcc_generated_files/uart1.c  .generated_files/flags/DEBUG/ef7db5a7e63464b9edddaecd9c4ca56abf29eeef .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/uart1.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/uart1.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/uart1.c  -o ${OBJECTDIR}/mcc_generated_files/uart1.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/uart1.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/main.o: main.c  .generated_files/flags/DEBUG/c696a87763b0c76e5a8e747784c96a4166365e2a .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/main.o.d 
	@${RM} ${OBJECTDIR}/main.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  main.c  -o ${OBJECTDIR}/main.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/main.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
else
${OBJECTDIR}/_ext/2049467722/can_tp.o: ../../Libraries/can_bootloader/can_tp.c  .generated_files/flags/DEBUG/cfc9a3c765662a5a2ad5e47348ec4ba20b80e537 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/2049467722" 
	@${RM} ${OBJECTDIR}/_ext/2049467722/can_tp.o.d 
	@${RM} ${OBJECTDIR}/_ext/2049467722/can_tp.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/can_bootloader/can_tp.c  -o ${OBJECTDIR}/_ext/2049467722/can_tp.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/2049467722/can_tp.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/2049467722/can_tp_phy_adaptor.o: ../../Libraries/can_bootloader/can_tp_phy_adaptor.c  .generated_files/flags/DEBUG/fe49421c8baabb0a22349333d7fe9e3d2f41af13 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/2049467722" 
	@${RM} ${OBJECTDIR}/_ext/2049467722/can_tp_phy_adaptor.o.d 
	@${RM} ${OBJECTDIR}/_ext/2049467722/can_tp_phy_adaptor.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/can_bootloader/can_tp_phy_adaptor.c  -o ${OBJECTDIR}/_ext/2049467722/can_tp_phy_adaptor.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/2049467722/can_tp_phy_adaptor.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/reset_control.o: ../../Libraries/PIC33_plib/src/reset_control.c  .generated_files/flags/DEBUG/dc254df529358a3106c2815bfd5ee7c22b486451 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/reset_control.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/reset_control.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/reset_control.c  -o ${OBJECTDIR}/_ext/356824117/reset_control.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/reset_control.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/boot_process.o: mcc_generated_files/boot/boot_process.c  .generated_files/flags/DEBUG/1f144f93956bcafb8a5971e2612beb65868dfda9 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_process.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_process.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/boot/boot_process.c  -o ${OBJECTDIR}/mcc_generated_files/boot/boot_process.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/boot_process.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/boot_demo.o: mcc_generated_files/boot/boot_demo.c  .generated_files/flags/DEBUG/5517e5ddc35378320611fd3d3fa1f4f975b59108 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_demo.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_demo.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/boot/boot_demo.c  -o ${OBJECTDIR}/mcc_generated_files/boot/boot_demo.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/boot_demo.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/boot_verify_not_blank.o: mcc_generated_files/boot/boot_verify_not_blank.c  .generated_files/flags/DEBUG/8c5b61dfaedb1d40e0d614724495c7e768f8995d .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_verify_not_blank.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_verify_not_blank.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/boot/boot_verify_not_blank.c  -o ${OBJECTDIR}/mcc_generated_files/boot/boot_verify_not_blank.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/boot_verify_not_blank.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/2049467722/com_adaptor_can.o: ../../Libraries/can_bootloader/com_adaptor_can.c  .generated_files/flags/DEBUG/e042b24f9f07872f5ffeebf8b57600d960ab1d63 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/2049467722" 
	@${RM} ${OBJECTDIR}/_ext/2049467722/com_adaptor_can.o.d 
	@${RM} ${OBJECTDIR}/_ext/2049467722/com_adaptor_can.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/can_bootloader/com_adaptor_can.c  -o ${OBJECTDIR}/_ext/2049467722/com_adaptor_can.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/2049467722/com_adaptor_can.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/boot_application_header.o: mcc_generated_files/boot/boot_application_header.c  .generated_files/flags/DEBUG/93f974b4e1eec6fb7264156db4c74117bf370143 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_application_header.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_application_header.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/boot/boot_application_header.c  -o ${OBJECTDIR}/mcc_generated_files/boot/boot_application_header.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/boot_application_header.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/pin_manager.o: mcc_generated_files/pin_manager.c  .generated_files/flags/DEBUG/5ebf8128c311c30e700f79cd2762f201203fbf94 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/pin_manager.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/pin_manager.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/pin_manager.c  -o ${OBJECTDIR}/mcc_generated_files/pin_manager.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/pin_manager.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/traps.o: mcc_generated_files/traps.c  .generated_files/flags/DEBUG/ca833ff43be5614d6bc522ebb902be405d7bed69 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/traps.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/traps.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/traps.c  -o ${OBJECTDIR}/mcc_generated_files/traps.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/traps.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/mcc.o: mcc_generated_files/mcc.c  .generated_files/flags/DEBUG/a71c167116457ca5f69b8190bcec5e9b8783a391 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/mcc.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/mcc.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/mcc.c  -o ${OBJECTDIR}/mcc_generated_files/mcc.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/mcc.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/clock.o: mcc_generated_files/clock.c  .generated_files/flags/DEBUG/b7281225f21cf5bdb80c829a4e89d3c1960eeda9 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/clock.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/clock.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/clock.c  -o ${OBJECTDIR}/mcc_generated_files/clock.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/clock.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/reset.o: mcc_generated_files/reset.c  .generated_files/flags/DEBUG/40479fbca9c7aeb9ca2708367602ee4431d04d49 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/reset.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/reset.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/reset.c  -o ${OBJECTDIR}/mcc_generated_files/reset.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/reset.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/system.o: mcc_generated_files/system.c  .generated_files/flags/DEBUG/f373c80cad326289f2ff2d02babab854039a639b .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/system.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/system.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/system.c  -o ${OBJECTDIR}/mcc_generated_files/system.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/system.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/interrupt_manager.o: mcc_generated_files/interrupt_manager.c  .generated_files/flags/DEBUG/f995e2c14d4c2949b00cc8560c4829110385bca5 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/interrupt_manager.c  -o ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/interrupt_manager.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/dma.o: mcc_generated_files/dma.c  .generated_files/flags/DEBUG/39c952825e8137a00695f7384075e36652f2b848 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/dma.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/dma.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/dma.c  -o ${OBJECTDIR}/mcc_generated_files/dma.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/dma.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/tmr1.o: mcc_generated_files/tmr1.c  .generated_files/flags/DEBUG/12858a6bb5adcc2a9624a80c27c834a1be8611ff .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/tmr1.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/tmr1.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/tmr1.c  -o ${OBJECTDIR}/mcc_generated_files/tmr1.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/tmr1.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/can1.o: mcc_generated_files/can1.c  .generated_files/flags/DEBUG/723a4ce7d3864bf793e3314b1e7b82ef30d38fcf .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/can1.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/can1.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/can1.c  -o ${OBJECTDIR}/mcc_generated_files/can1.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/can1.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/uart1.o: mcc_generated_files/uart1.c  .generated_files/flags/DEBUG/83752c77e5f959e15c1ab7e7cb7f299ffd9c7a51 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/uart1.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/uart1.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/uart1.c  -o ${OBJECTDIR}/mcc_generated_files/uart1.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/uart1.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/main.o: main.c  .generated_files/flags/DEBUG/87a76a2a6c296ed33408cb35e8b294691b6d3ce9 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/main.o.d 
	@${RM} ${OBJECTDIR}/main.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  main.c  -o ${OBJECTDIR}/main.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/main.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/Drivers/TFT_LCD/inc" -I"../../Libraries/Drivers/TFT_LCD/src" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/mcc_generated_files/memory/flash.o: mcc_generated_files/memory/flash.s  .generated_files/flags/DEBUG/7fdb0142dd71844d21838dac4e233fda80475b3c .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/memory" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/memory/flash.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/memory/flash.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/memory/flash.s  -o ${OBJECTDIR}/mcc_generated_files/memory/flash.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/memory/flash.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_PK3=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
else
${OBJECTDIR}/mcc_generated_files/memory/flash.o: mcc_generated_files/memory/flash.s  .generated_files/flags/DEBUG/e4ccefc126f1a651ecfab9e4f3f2e86bc985f1b9 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/memory" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/memory/flash.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/memory/flash.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/memory/flash.s  -o ${OBJECTDIR}/mcc_generated_files/memory/flash.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/memory/flash.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemblePreproc
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o: mcc_generated_files/boot/memory_partition.S  .generated_files/flags/DEBUG/12cac786a7ed06ad07623f71ca9137c28dc24d43 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/memory_partition.S  -o ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o.d"  -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o.asm.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_PK3=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/interrupts.o: mcc_generated_files/boot/interrupts.S  .generated_files/flags/DEBUG/bbcb120bcf943a14ec2a54d57634e90531d0d743 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/interrupts.S  -o ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/interrupts.o.d"  -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/interrupts.o.asm.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_PK3=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o: mcc_generated_files/boot/hardware_interrupt_table.S  .generated_files/flags/DEBUG/509f2120479d1cb0f4b15593fec403179e5e7706 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/hardware_interrupt_table.S  -o ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o.d"  -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o.asm.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_PK3=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
else
${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o: mcc_generated_files/boot/memory_partition.S  .generated_files/flags/DEBUG/340192011135b4099a7558b21a2f01d8d9fcd9ef .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/memory_partition.S  -o ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o.d"  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o.asm.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/interrupts.o: mcc_generated_files/boot/interrupts.S  .generated_files/flags/DEBUG/f6cb53ff28ad48ceda0ed866faf30bd8803b364 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/interrupts.S  -o ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/interrupts.o.d"  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/interrupts.o.asm.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o: mcc_generated_files/boot/hardware_interrupt_table.S  .generated_files/flags/DEBUG/496402839bed223a633af6da2efe5500a645ec45 .generated_files/flags/DEBUG/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/hardware_interrupt_table.S  -o ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o.d"  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o.asm.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${DISTDIR}/MCU_Bootloader.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o ${DISTDIR}/MCU_Bootloader.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}      -mcpu=$(MP_PROCESSOR_OPTION)        -D__DEBUG=__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)   -mreserve=data@0x1000:0x101B -mreserve=data@0x101C:0x101D -mreserve=data@0x101E:0x101F -mreserve=data@0x1020:0x1021 -mreserve=data@0x1022:0x1023 -mreserve=data@0x1024:0x1027 -mreserve=data@0x1028:0x104F   -Wl,--local-stack,,--defsym=__MPLAB_BUILD=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,-D__DEBUG=__DEBUG,--defsym=__MPLAB_DEBUGGER_PK3=1,$(MP_LINKER_FILE_OPTION),--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--gc-sections,--fill-upper=0,--stackguard=16,--no-force-link,--smart-io,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--report-mem,--memorysummary,${DISTDIR}/memoryfile.xml$(MP_EXTRA_LD_POST)  -mdfp="${DFP_DIR}/xc16" 
	
else
${DISTDIR}/MCU_Bootloader.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o ${DISTDIR}/MCU_Bootloader.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}      -mcpu=$(MP_PROCESSOR_OPTION)        -omf=elf -DXPRJ_DEBUG=$(CND_CONF)    $(COMPARISON_BUILD)  -Wl,--local-stack,,--defsym=__MPLAB_BUILD=1,$(MP_LINKER_FILE_OPTION),--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--gc-sections,--fill-upper=0,--stackguard=16,--no-force-link,--smart-io,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--report-mem,--memorysummary,${DISTDIR}/memoryfile.xml$(MP_EXTRA_LD_POST)  -mdfp="${DFP_DIR}/xc16" 
	${MP_CC_DIR}\\xc16-bin2hex ${DISTDIR}/MCU_Bootloader.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} -a  -omf=elf   -mdfp="${DFP_DIR}/xc16" 
	
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
