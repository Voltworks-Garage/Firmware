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
FINAL_IMAGE=${DISTDIR}/BMS_Bootloader_02.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/BMS_Bootloader_02.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
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
SOURCEFILES_QUOTED_IF_SPACED=../../Libraries/can_bootloader/can_tp.c ../../Libraries/can_bootloader/can_tp_phy_adaptor.c ../../Libraries/PIC33_plib/src/reset_control.c mcc_generated_files/boot/memory_partition.S mcc_generated_files/boot/boot_process.c mcc_generated_files/boot/interrupts.S mcc_generated_files/boot/boot_demo.c mcc_generated_files/boot/hardware_interrupt_table.S ../../Libraries/can_bootloader/com_adaptor_can.c mcc_generated_files/boot/boot_application_header.c mcc_generated_files/boot/boot_verify_not_blank.c mcc_generated_files/memory/flash.s mcc_generated_files/pin_manager.c mcc_generated_files/traps.c mcc_generated_files/mcc.c mcc_generated_files/clock.c mcc_generated_files/reset.c mcc_generated_files/system.c mcc_generated_files/interrupt_manager.c mcc_generated_files/dma.c mcc_generated_files/tmr1.c mcc_generated_files/can1.c mcc_generated_files/uart1.c main.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/_ext/2049467722/can_tp.o ${OBJECTDIR}/_ext/2049467722/can_tp_phy_adaptor.o ${OBJECTDIR}/_ext/356824117/reset_control.o ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o ${OBJECTDIR}/mcc_generated_files/boot/boot_process.o ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o ${OBJECTDIR}/mcc_generated_files/boot/boot_demo.o ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o ${OBJECTDIR}/_ext/2049467722/com_adaptor_can.o ${OBJECTDIR}/mcc_generated_files/boot/boot_application_header.o ${OBJECTDIR}/mcc_generated_files/boot/boot_verify_not_blank.o ${OBJECTDIR}/mcc_generated_files/memory/flash.o ${OBJECTDIR}/mcc_generated_files/pin_manager.o ${OBJECTDIR}/mcc_generated_files/traps.o ${OBJECTDIR}/mcc_generated_files/mcc.o ${OBJECTDIR}/mcc_generated_files/clock.o ${OBJECTDIR}/mcc_generated_files/reset.o ${OBJECTDIR}/mcc_generated_files/system.o ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o ${OBJECTDIR}/mcc_generated_files/dma.o ${OBJECTDIR}/mcc_generated_files/tmr1.o ${OBJECTDIR}/mcc_generated_files/can1.o ${OBJECTDIR}/mcc_generated_files/uart1.o ${OBJECTDIR}/main.o
POSSIBLE_DEPFILES=${OBJECTDIR}/_ext/2049467722/can_tp.o.d ${OBJECTDIR}/_ext/2049467722/can_tp_phy_adaptor.o.d ${OBJECTDIR}/_ext/356824117/reset_control.o.d ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o.d ${OBJECTDIR}/mcc_generated_files/boot/boot_process.o.d ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o.d ${OBJECTDIR}/mcc_generated_files/boot/boot_demo.o.d ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o.d ${OBJECTDIR}/_ext/2049467722/com_adaptor_can.o.d ${OBJECTDIR}/mcc_generated_files/boot/boot_application_header.o.d ${OBJECTDIR}/mcc_generated_files/boot/boot_verify_not_blank.o.d ${OBJECTDIR}/mcc_generated_files/memory/flash.o.d ${OBJECTDIR}/mcc_generated_files/pin_manager.o.d ${OBJECTDIR}/mcc_generated_files/traps.o.d ${OBJECTDIR}/mcc_generated_files/mcc.o.d ${OBJECTDIR}/mcc_generated_files/clock.o.d ${OBJECTDIR}/mcc_generated_files/reset.o.d ${OBJECTDIR}/mcc_generated_files/system.o.d ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o.d ${OBJECTDIR}/mcc_generated_files/dma.o.d ${OBJECTDIR}/mcc_generated_files/tmr1.o.d ${OBJECTDIR}/mcc_generated_files/can1.o.d ${OBJECTDIR}/mcc_generated_files/uart1.o.d ${OBJECTDIR}/main.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/2049467722/can_tp.o ${OBJECTDIR}/_ext/2049467722/can_tp_phy_adaptor.o ${OBJECTDIR}/_ext/356824117/reset_control.o ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o ${OBJECTDIR}/mcc_generated_files/boot/boot_process.o ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o ${OBJECTDIR}/mcc_generated_files/boot/boot_demo.o ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o ${OBJECTDIR}/_ext/2049467722/com_adaptor_can.o ${OBJECTDIR}/mcc_generated_files/boot/boot_application_header.o ${OBJECTDIR}/mcc_generated_files/boot/boot_verify_not_blank.o ${OBJECTDIR}/mcc_generated_files/memory/flash.o ${OBJECTDIR}/mcc_generated_files/pin_manager.o ${OBJECTDIR}/mcc_generated_files/traps.o ${OBJECTDIR}/mcc_generated_files/mcc.o ${OBJECTDIR}/mcc_generated_files/clock.o ${OBJECTDIR}/mcc_generated_files/reset.o ${OBJECTDIR}/mcc_generated_files/system.o ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o ${OBJECTDIR}/mcc_generated_files/dma.o ${OBJECTDIR}/mcc_generated_files/tmr1.o ${OBJECTDIR}/mcc_generated_files/can1.o ${OBJECTDIR}/mcc_generated_files/uart1.o ${OBJECTDIR}/main.o

# Source Files
SOURCEFILES=../../Libraries/can_bootloader/can_tp.c ../../Libraries/can_bootloader/can_tp_phy_adaptor.c ../../Libraries/PIC33_plib/src/reset_control.c mcc_generated_files/boot/memory_partition.S mcc_generated_files/boot/boot_process.c mcc_generated_files/boot/interrupts.S mcc_generated_files/boot/boot_demo.c mcc_generated_files/boot/hardware_interrupt_table.S ../../Libraries/can_bootloader/com_adaptor_can.c mcc_generated_files/boot/boot_application_header.c mcc_generated_files/boot/boot_verify_not_blank.c mcc_generated_files/memory/flash.s mcc_generated_files/pin_manager.c mcc_generated_files/traps.c mcc_generated_files/mcc.c mcc_generated_files/clock.c mcc_generated_files/reset.c mcc_generated_files/system.c mcc_generated_files/interrupt_manager.c mcc_generated_files/dma.c mcc_generated_files/tmr1.c mcc_generated_files/can1.c mcc_generated_files/uart1.c main.c



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
	${MAKE}  -f nbproject/Makefile-DEFAULT.mk ${DISTDIR}/BMS_Bootloader_02.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=33EP256MC506
MP_LINKER_FILE_OPTION=,--script=p33EP256MC506.gld
# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/2049467722/can_tp.o: ../../Libraries/can_bootloader/can_tp.c  .generated_files/flags/DEFAULT/e0c159a5fcda3e583b713adf9989703fcecda7cf .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/2049467722" 
	@${RM} ${OBJECTDIR}/_ext/2049467722/can_tp.o.d 
	@${RM} ${OBJECTDIR}/_ext/2049467722/can_tp.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/can_bootloader/can_tp.c  -o ${OBJECTDIR}/_ext/2049467722/can_tp.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/2049467722/can_tp.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/2049467722/can_tp_phy_adaptor.o: ../../Libraries/can_bootloader/can_tp_phy_adaptor.c  .generated_files/flags/DEFAULT/9a997ed0f28a458f0292544e83d77ebe1b441f13 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/2049467722" 
	@${RM} ${OBJECTDIR}/_ext/2049467722/can_tp_phy_adaptor.o.d 
	@${RM} ${OBJECTDIR}/_ext/2049467722/can_tp_phy_adaptor.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/can_bootloader/can_tp_phy_adaptor.c  -o ${OBJECTDIR}/_ext/2049467722/can_tp_phy_adaptor.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/2049467722/can_tp_phy_adaptor.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/reset_control.o: ../../Libraries/PIC33_plib/src/reset_control.c  .generated_files/flags/DEFAULT/ab7aa1e385056d1821b17bbce8dbd611812edc7 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/reset_control.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/reset_control.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/reset_control.c  -o ${OBJECTDIR}/_ext/356824117/reset_control.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/reset_control.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/boot_process.o: mcc_generated_files/boot/boot_process.c  .generated_files/flags/DEFAULT/df65a03a6a1a2ebe1f038b24853f4296b8bc5a2f .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_process.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_process.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/boot/boot_process.c  -o ${OBJECTDIR}/mcc_generated_files/boot/boot_process.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/boot_process.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/boot_demo.o: mcc_generated_files/boot/boot_demo.c  .generated_files/flags/DEFAULT/8cadc550dc4285ccdf049d01bf0de1d2bdc683fe .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_demo.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_demo.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/boot/boot_demo.c  -o ${OBJECTDIR}/mcc_generated_files/boot/boot_demo.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/boot_demo.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/2049467722/com_adaptor_can.o: ../../Libraries/can_bootloader/com_adaptor_can.c  .generated_files/flags/DEFAULT/1726eea9acda41d4b745c5ed5d58dba440284a85 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/2049467722" 
	@${RM} ${OBJECTDIR}/_ext/2049467722/com_adaptor_can.o.d 
	@${RM} ${OBJECTDIR}/_ext/2049467722/com_adaptor_can.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/can_bootloader/com_adaptor_can.c  -o ${OBJECTDIR}/_ext/2049467722/com_adaptor_can.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/2049467722/com_adaptor_can.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/boot_application_header.o: mcc_generated_files/boot/boot_application_header.c  .generated_files/flags/DEFAULT/9263ef86448be31bff7eaf9e77f8e5b58f83e161 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_application_header.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_application_header.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/boot/boot_application_header.c  -o ${OBJECTDIR}/mcc_generated_files/boot/boot_application_header.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/boot_application_header.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/boot_verify_not_blank.o: mcc_generated_files/boot/boot_verify_not_blank.c  .generated_files/flags/DEFAULT/cc757dd1f56bf4e0a9c98c87de5e8cfd106e5634 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_verify_not_blank.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_verify_not_blank.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/boot/boot_verify_not_blank.c  -o ${OBJECTDIR}/mcc_generated_files/boot/boot_verify_not_blank.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/boot_verify_not_blank.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/pin_manager.o: mcc_generated_files/pin_manager.c  .generated_files/flags/DEFAULT/5e21c03e5a8ac603845d8b7eb9abbe3176eb2d6b .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/pin_manager.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/pin_manager.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/pin_manager.c  -o ${OBJECTDIR}/mcc_generated_files/pin_manager.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/pin_manager.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/traps.o: mcc_generated_files/traps.c  .generated_files/flags/DEFAULT/fac2ebf1adb9926d10f7ba34e6db7bddd56ef4ae .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/traps.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/traps.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/traps.c  -o ${OBJECTDIR}/mcc_generated_files/traps.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/traps.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/mcc.o: mcc_generated_files/mcc.c  .generated_files/flags/DEFAULT/9f7de681d67f375d9dbe74b2f988c47f8b22e49c .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/mcc.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/mcc.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/mcc.c  -o ${OBJECTDIR}/mcc_generated_files/mcc.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/mcc.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/clock.o: mcc_generated_files/clock.c  .generated_files/flags/DEFAULT/4a91e0e05206eecdec96f4fd9198642e701c0a58 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/clock.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/clock.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/clock.c  -o ${OBJECTDIR}/mcc_generated_files/clock.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/clock.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/reset.o: mcc_generated_files/reset.c  .generated_files/flags/DEFAULT/dc7a7a54641b9ca5cdad95c002b02c0abcec8b3a .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/reset.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/reset.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/reset.c  -o ${OBJECTDIR}/mcc_generated_files/reset.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/reset.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/system.o: mcc_generated_files/system.c  .generated_files/flags/DEFAULT/303291935e6847fae6d5ed05be1a45e4f103fd33 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/system.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/system.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/system.c  -o ${OBJECTDIR}/mcc_generated_files/system.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/system.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/interrupt_manager.o: mcc_generated_files/interrupt_manager.c  .generated_files/flags/DEFAULT/9400222ce6ad6cff9c6770febb84506ad3bbc6ec .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/interrupt_manager.c  -o ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/interrupt_manager.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/dma.o: mcc_generated_files/dma.c  .generated_files/flags/DEFAULT/d684316cc20776b05a2047a74d6eb6231d8c1ab4 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/dma.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/dma.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/dma.c  -o ${OBJECTDIR}/mcc_generated_files/dma.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/dma.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/tmr1.o: mcc_generated_files/tmr1.c  .generated_files/flags/DEFAULT/8bf43d8fc87b4f487ccb3e0509d4664c40bfd64d .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/tmr1.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/tmr1.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/tmr1.c  -o ${OBJECTDIR}/mcc_generated_files/tmr1.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/tmr1.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/can1.o: mcc_generated_files/can1.c  .generated_files/flags/DEFAULT/fc025e37b7d7800d81c434556a1034ae86c7268d .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/can1.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/can1.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/can1.c  -o ${OBJECTDIR}/mcc_generated_files/can1.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/can1.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/uart1.o: mcc_generated_files/uart1.c  .generated_files/flags/DEFAULT/74c3bb4e4681e71260ef8b6bb82de04cbfd9ce0f .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/uart1.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/uart1.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/uart1.c  -o ${OBJECTDIR}/mcc_generated_files/uart1.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/uart1.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/main.o: main.c  .generated_files/flags/DEFAULT/9a27e61052ef7c3cbd260737587bcf3821b37ea0 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/main.o.d 
	@${RM} ${OBJECTDIR}/main.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  main.c  -o ${OBJECTDIR}/main.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/main.o.d"      -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -mno-eds-warn  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
else
${OBJECTDIR}/_ext/2049467722/can_tp.o: ../../Libraries/can_bootloader/can_tp.c  .generated_files/flags/DEFAULT/1bf64e0df99f23708885517b3d8106971d80b75e .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/2049467722" 
	@${RM} ${OBJECTDIR}/_ext/2049467722/can_tp.o.d 
	@${RM} ${OBJECTDIR}/_ext/2049467722/can_tp.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/can_bootloader/can_tp.c  -o ${OBJECTDIR}/_ext/2049467722/can_tp.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/2049467722/can_tp.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/2049467722/can_tp_phy_adaptor.o: ../../Libraries/can_bootloader/can_tp_phy_adaptor.c  .generated_files/flags/DEFAULT/92075c107e57990d2bbb31f4a41ec0a027c97728 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/2049467722" 
	@${RM} ${OBJECTDIR}/_ext/2049467722/can_tp_phy_adaptor.o.d 
	@${RM} ${OBJECTDIR}/_ext/2049467722/can_tp_phy_adaptor.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/can_bootloader/can_tp_phy_adaptor.c  -o ${OBJECTDIR}/_ext/2049467722/can_tp_phy_adaptor.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/2049467722/can_tp_phy_adaptor.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/356824117/reset_control.o: ../../Libraries/PIC33_plib/src/reset_control.c  .generated_files/flags/DEFAULT/f448005f1e752a0d6a2ba2453afa198026adc69c .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/356824117" 
	@${RM} ${OBJECTDIR}/_ext/356824117/reset_control.o.d 
	@${RM} ${OBJECTDIR}/_ext/356824117/reset_control.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/PIC33_plib/src/reset_control.c  -o ${OBJECTDIR}/_ext/356824117/reset_control.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/356824117/reset_control.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/boot_process.o: mcc_generated_files/boot/boot_process.c  .generated_files/flags/DEFAULT/2e492f19e45c1731e3b3099d1aa9bbb936530706 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_process.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_process.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/boot/boot_process.c  -o ${OBJECTDIR}/mcc_generated_files/boot/boot_process.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/boot_process.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/boot_demo.o: mcc_generated_files/boot/boot_demo.c  .generated_files/flags/DEFAULT/5a12b574685e799dd4412124f838cf7247fb0e9 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_demo.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_demo.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/boot/boot_demo.c  -o ${OBJECTDIR}/mcc_generated_files/boot/boot_demo.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/boot_demo.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/2049467722/com_adaptor_can.o: ../../Libraries/can_bootloader/com_adaptor_can.c  .generated_files/flags/DEFAULT/6d6c04cc16fc89348a70ce246ec7170b3107f1aa .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/2049467722" 
	@${RM} ${OBJECTDIR}/_ext/2049467722/com_adaptor_can.o.d 
	@${RM} ${OBJECTDIR}/_ext/2049467722/com_adaptor_can.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../../Libraries/can_bootloader/com_adaptor_can.c  -o ${OBJECTDIR}/_ext/2049467722/com_adaptor_can.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/2049467722/com_adaptor_can.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/boot_application_header.o: mcc_generated_files/boot/boot_application_header.c  .generated_files/flags/DEFAULT/2c0f2b131905fb8d89b239bec9c84c652efd9fd0 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_application_header.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_application_header.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/boot/boot_application_header.c  -o ${OBJECTDIR}/mcc_generated_files/boot/boot_application_header.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/boot_application_header.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/boot_verify_not_blank.o: mcc_generated_files/boot/boot_verify_not_blank.c  .generated_files/flags/DEFAULT/e13ec1517542d4797073a3793398efebff0ebd30 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_verify_not_blank.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/boot_verify_not_blank.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/boot/boot_verify_not_blank.c  -o ${OBJECTDIR}/mcc_generated_files/boot/boot_verify_not_blank.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/boot_verify_not_blank.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/pin_manager.o: mcc_generated_files/pin_manager.c  .generated_files/flags/DEFAULT/ff4dd39573de698c40e5a17557dca9f6ce3a40bf .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/pin_manager.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/pin_manager.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/pin_manager.c  -o ${OBJECTDIR}/mcc_generated_files/pin_manager.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/pin_manager.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/traps.o: mcc_generated_files/traps.c  .generated_files/flags/DEFAULT/49fe273a1402e3012ad1b829c6127488cae43deb .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/traps.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/traps.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/traps.c  -o ${OBJECTDIR}/mcc_generated_files/traps.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/traps.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/mcc.o: mcc_generated_files/mcc.c  .generated_files/flags/DEFAULT/9d9aae22e4853ce36d1cb6099f32b3ebb9719d36 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/mcc.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/mcc.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/mcc.c  -o ${OBJECTDIR}/mcc_generated_files/mcc.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/mcc.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/clock.o: mcc_generated_files/clock.c  .generated_files/flags/DEFAULT/b5d5309809073f51148a874940c8f81d29037025 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/clock.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/clock.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/clock.c  -o ${OBJECTDIR}/mcc_generated_files/clock.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/clock.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/reset.o: mcc_generated_files/reset.c  .generated_files/flags/DEFAULT/3d64196aa8c2a82ca0b91cf4523be408ad6fcb8d .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/reset.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/reset.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/reset.c  -o ${OBJECTDIR}/mcc_generated_files/reset.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/reset.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/system.o: mcc_generated_files/system.c  .generated_files/flags/DEFAULT/5ea912932c97daa4000704073bd88612d329c3bd .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/system.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/system.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/system.c  -o ${OBJECTDIR}/mcc_generated_files/system.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/system.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/interrupt_manager.o: mcc_generated_files/interrupt_manager.c  .generated_files/flags/DEFAULT/57f1536e6a45f3b2ec1035f2a91bfef11b9d2366 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/interrupt_manager.c  -o ${OBJECTDIR}/mcc_generated_files/interrupt_manager.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/interrupt_manager.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/dma.o: mcc_generated_files/dma.c  .generated_files/flags/DEFAULT/b587917f91c3d0e475dca047b39c04ef0db91c33 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/dma.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/dma.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/dma.c  -o ${OBJECTDIR}/mcc_generated_files/dma.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/dma.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/tmr1.o: mcc_generated_files/tmr1.c  .generated_files/flags/DEFAULT/7e498df5cce316fc2c41396ffc1aecd7e463d277 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/tmr1.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/tmr1.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/tmr1.c  -o ${OBJECTDIR}/mcc_generated_files/tmr1.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/tmr1.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/can1.o: mcc_generated_files/can1.c  .generated_files/flags/DEFAULT/45bbf60e094b1b43350b4c816a18c8974bc311fe .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/can1.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/can1.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/can1.c  -o ${OBJECTDIR}/mcc_generated_files/can1.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/can1.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/uart1.o: mcc_generated_files/uart1.c  .generated_files/flags/DEFAULT/b8bd89ba5109214af6cfb932463abf82c3f29b9f .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/uart1.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/uart1.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  mcc_generated_files/uart1.c  -o ${OBJECTDIR}/mcc_generated_files/uart1.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/uart1.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/main.o: main.c  .generated_files/flags/DEFAULT/bdad5a7bd49e1024d3d192fea81e53726f7006a5 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/main.o.d 
	@${RM} ${OBJECTDIR}/main.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  main.c  -o ${OBJECTDIR}/main.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/main.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -ffunction-sections -O0 -I"." -I"../../RTOS/Scheduler" -I"../../Libraries/PIC33_plib/inc" -I"../../Libraries/PIC33_plib/src" -I"../../CAN/generated" -I"../../Libraries/Standard" -I"../../Libraries/can_bootloader" -DDEBUG_502 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/mcc_generated_files/memory/flash.o: mcc_generated_files/memory/flash.s  .generated_files/flags/DEFAULT/d9772c9205439f189f5eb73a5d92cedc55ac9a5e .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/memory" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/memory/flash.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/memory/flash.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/memory/flash.s  -o ${OBJECTDIR}/mcc_generated_files/memory/flash.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/memory/flash.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_PK3=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
else
${OBJECTDIR}/mcc_generated_files/memory/flash.o: mcc_generated_files/memory/flash.s  .generated_files/flags/DEFAULT/f665c2f4111a44ed0f7918a12df13a722b3dfc69 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/memory" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/memory/flash.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/memory/flash.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/memory/flash.s  -o ${OBJECTDIR}/mcc_generated_files/memory/flash.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/memory/flash.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemblePreproc
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o: mcc_generated_files/boot/memory_partition.S  .generated_files/flags/DEFAULT/288dcee35893e1d3e16b9577cfde6a13d6f41b97 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/memory_partition.S  -o ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o.d"  -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o.asm.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_PK3=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/interrupts.o: mcc_generated_files/boot/interrupts.S  .generated_files/flags/DEFAULT/138afd33e5085d2720afa2f93d24c6313a977ce4 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/interrupts.S  -o ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/interrupts.o.d"  -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/interrupts.o.asm.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_PK3=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o: mcc_generated_files/boot/hardware_interrupt_table.S  .generated_files/flags/DEFAULT/51fd4e3014fbcd0038a9fb75eba80b0e02859359 .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/hardware_interrupt_table.S  -o ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o.d"  -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o.asm.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_PK3=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
else
${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o: mcc_generated_files/boot/memory_partition.S  .generated_files/flags/DEFAULT/76ae97fd4ed0ff945ab9be53c926e1fc5cb7fafa .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/memory_partition.S  -o ${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o.d"  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/memory_partition.o.asm.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/interrupts.o: mcc_generated_files/boot/interrupts.S  .generated_files/flags/DEFAULT/ebc9dceecc9ef07989f813370eac36b235dce90a .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/interrupts.S  -o ${OBJECTDIR}/mcc_generated_files/boot/interrupts.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/interrupts.o.d"  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/interrupts.o.asm.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o: mcc_generated_files/boot/hardware_interrupt_table.S  .generated_files/flags/DEFAULT/3bfbae4bcfca39b2cb9dab34086313b5eb68f63a .generated_files/flags/DEFAULT/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/mcc_generated_files/boot" 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o.d 
	@${RM} ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  mcc_generated_files/boot/hardware_interrupt_table.S  -o ${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o.d"  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    -Wa,-MD,"${OBJECTDIR}/mcc_generated_files/boot/hardware_interrupt_table.o.asm.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${DISTDIR}/BMS_Bootloader_02.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o ${DISTDIR}/BMS_Bootloader_02.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}      -mcpu=$(MP_PROCESSOR_OPTION)        -D__DEBUG=__DEBUG -D__MPLAB_DEBUGGER_PK3=1  -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)   -mreserve=data@0x1000:0x101B -mreserve=data@0x101C:0x101D -mreserve=data@0x101E:0x101F -mreserve=data@0x1020:0x1021 -mreserve=data@0x1022:0x1023 -mreserve=data@0x1024:0x1027 -mreserve=data@0x1028:0x104F   -Wl,--local-stack,,--defsym=__MPLAB_BUILD=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,-D__DEBUG=__DEBUG,--defsym=__MPLAB_DEBUGGER_PK3=1,$(MP_LINKER_FILE_OPTION),--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--gc-sections,--fill-upper=0,--stackguard=16,--no-force-link,--smart-io,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--report-mem,--memorysummary,${DISTDIR}/memoryfile.xml$(MP_EXTRA_LD_POST)  -mdfp="${DFP_DIR}/xc16" 
	
else
${DISTDIR}/BMS_Bootloader_02.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o ${DISTDIR}/BMS_Bootloader_02.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}      -mcpu=$(MP_PROCESSOR_OPTION)        -omf=elf -DXPRJ_DEFAULT=$(CND_CONF)    $(COMPARISON_BUILD)  -Wl,--local-stack,,--defsym=__MPLAB_BUILD=1,$(MP_LINKER_FILE_OPTION),--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--gc-sections,--fill-upper=0,--stackguard=16,--no-force-link,--smart-io,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--report-mem,--memorysummary,${DISTDIR}/memoryfile.xml$(MP_EXTRA_LD_POST)  -mdfp="${DFP_DIR}/xc16" 
	${MP_CC_DIR}\\xc16-bin2hex ${DISTDIR}/BMS_Bootloader_02.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} -a  -omf=elf   -mdfp="${DFP_DIR}/xc16" 
	
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
