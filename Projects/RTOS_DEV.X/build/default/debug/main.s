	.file "C:\\REPOS\\Voltworks_Garage\\Firmware\\Projects\\RTOS_DEV.X\\main.c"
	.section	.debug_abbrev,info
.Ldebug_abbrev0:
	.section	.debug_info,info
.Ldebug_info0:
	.section	.debug_line,info
.Ldebug_line0:
	.section	.text,code
.Ltext0:
	.section	.text.prvSetupHardware,code
	.align	2
	.type	_prvSetupHardware,@function
_prvSetupHardware:
.LFB6:
	.file 1 "main.c"
	.loc 1 163 0
	.set ___PA___,1
	.loc 1 164 0
	rcall	_vParTestInitialise
	.loc 1 165 0
	return	
	.set ___PA___,0
.LFE6:
	.size	_prvSetupHardware, .-_prvSetupHardware
	.section	.const,psv,page
.LC0:
	.asciz	"FAIL #1"
.LC1:
	.asciz	"FAIL #3"
.LC2:
	.asciz	"FAIL #4"
.LC3:
	.asciz	"%dns max jitter"
	.section	.text.vCheckTask,code
	.align	2
	.type	_vCheckTask,@function
_vCheckTask:
.LFB7:
	.loc 1 169 0
	.set ___PA___,1
	lnk	#2
.LCFI0:
	mov.d	w8,[w15++]
.LCFI1:
	mov.d	w10,[w15++]
.LCFI2:
	mov.d	w12,[w15++]
.LCFI3:
	.loc 1 185 0
	rcall	_xTaskGetTickCount
	mov	w0,[w15-14]
	.loc 1 181 0
	clr	w9
	.loc 1 197 0
	mov	#_cStringBuffer.9933,w8
	mov	#.LC0,w10
	.loc 1 203 0
	mov	#.LC1,w11
	.loc 1 216 0
	mov	#1096,w13
	mov	#.LC3,w12
.L10:
	.loc 1 190 0
	mov	#3000,w1
	sub	w15,#14,w0
	rcall	_xTaskDelayUntil
	.loc 1 194 0
	rcall	_xAreIntegerMathsTaskStillRunning
	sub	w0,#1,[w15]
	.set ___BP___,48
	bra	z,.L4
	.loc 1 197 0
	
	repeat	#8-1
	mov.b	[w10++],[w8++]
	
	sub	#8, w8
	sub	#8, w10
	.loc 1 196 0
	mov	#1,w9
.L4:
	.loc 1 200 0
	rcall	_xAreBlockTimeTestTasksStillRunning
	sub	w0,#1,[w15]
	.set ___BP___,48
	bra	z,.L5
	.loc 1 203 0
	
	repeat	#8-1
	mov.b	[w11++],[w8++]
	
	sub	#8, w8
	sub	#8, w11
	.loc 1 202 0
	mov	#1,w9
.L5:
	.loc 1 206 0
	rcall	_xAreBlockingQueuesStillRunning
	sub	w0,#1,[w15]
	.set ___BP___,48
	bra	z,.L6
	.loc 1 209 0
	mov	#.LC2,w0
	
	repeat	#8-1
	mov.b	[w0++],[w8++]
	
	sub	#8, w8
	.loc 1 208 0
	mov	#1,w9
	bra	.L10
.L6:
	.loc 1 212 0
	cp0	w9
	.set ___BP___,0
	bra	nz,.L10
	.loc 1 216 0
	mov	w13,w0
	add	_usMaxJitter,WREG
	mov	w0,w1
	sl	w1,#4,w0
	mov	w0,[w15++]
	mov	w12,[w15++]
	mov	w8,w0
.LCFI4:
	rcall	__sprintf_cdnopuxX
	sub	w15,#4,w15
	bra	.L10
.LFE7:
	.size	_vCheckTask, .-_vCheckTask
	.section	.const,psv,page
.LC4:
	.asciz	"Check"
	.section	.text.main,code
	.align	2
	.global	_main	; export
	.type	_main,@function
_main:
.LFB5:
	.loc 1 132 0
	.set ___PA___,1
	.loc 1 135 0
	rcall	_SYSTEM_Initialize
	.loc 1 138 0
	rcall	_prvSetupHardware
	.loc 1 141 0
	mov	#2,w0
	rcall	_vStartBlockingQueueTasks
	.loc 1 142 0
	clr	w0
	rcall	_vStartIntegerMathTasks
	.loc 1 143 0
	mov	#3,w0
	rcall	_vStartFlashCoRoutines
	.loc 1 144 0
	rcall	_vCreateBlockTimeTasks
	.loc 1 147 0
	clr	w5
	mov	#3,w4
	mov	w5,w3
	mov	#420,w2
	mov	#.LC4,w1
	mov	#handle(_vCheckTask),w0
	rcall	_xTaskCreate
	.loc 1 151 0
	mov	#20000,w0
	rcall	_vSetupTimerTest
	.loc 1 154 0
	rcall	_vTaskStartScheduler
	.loc 1 159 0
	clr	w0
	return	
	.set ___PA___,0
.LFE5:
	.size	_main, .-_main
	.section	.text.vApplicationIdleHook,code
	.align	2
	.global	_vApplicationIdleHook	; export
	.type	_vApplicationIdleHook,@function
_vApplicationIdleHook:
.LFB8:
	.loc 1 224 0
	.set ___PA___,1
	.loc 1 226 0
	rcall	_vCoRoutineSchedule
	.loc 1 227 0
	return	
	.set ___PA___,0
.LFE8:
	.size	_vApplicationIdleHook, .-_vApplicationIdleHook
	.section	.bss,bss
	.type	_cStringBuffer.9933,@object
	.size	_cStringBuffer.9933, 20
_cStringBuffer.9933:
	.skip	20
	.section	.debug_frame,info
.Lframe0:
	.4byte	.LECIE0-.LSCIE0
.LSCIE0:
	.4byte	0xffffffff
	.byte	0x1
	.byte	0
	.uleb128 0x1
	.sleb128 2
	.byte	0x25
	.byte	0x12
	.uleb128 0xf
	.sleb128 -2
	.byte	0x9
	.uleb128 0x25
	.uleb128 0xf
	.align	4
.LECIE0:
.LSFDE0:
	.4byte	.LEFDE0-.LASFDE0
.LASFDE0:
	.4byte	.Lframe0
	.4byte	.LFB6
	.4byte	.LFE6-.LFB6
	.align	4
.LEFDE0:
.LSFDE2:
	.4byte	.LEFDE2-.LASFDE2
.LASFDE2:
	.4byte	.Lframe0
	.4byte	.LFB7
	.4byte	.LFE7-.LFB7
	.byte	0x4
	.4byte	.LCFI0-.LFB7
	.byte	0x12
	.uleb128 0xe
	.sleb128 -3
	.byte	0x8e
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI3-.LCFI0
	.byte	0x8c
	.uleb128 0x8
	.byte	0x8a
	.uleb128 0x6
	.byte	0x88
	.uleb128 0x4
	.byte	0x4
	.4byte	.LCFI4-.LCFI3
	.byte	0x2e
	.uleb128 0x4
	.align	4
.LEFDE2:
.LSFDE4:
	.4byte	.LEFDE4-.LASFDE4
.LASFDE4:
	.4byte	.Lframe0
	.4byte	.LFB5
	.4byte	.LFE5-.LFB5
	.align	4
.LEFDE4:
.LSFDE6:
	.4byte	.LEFDE6-.LASFDE6
.LASFDE6:
	.4byte	.Lframe0
	.4byte	.LFB8
	.4byte	.LFE8-.LFB8
	.align	4
.LEFDE6:
	.section	.text,code
.Letext0:
	.file 2 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h"
	.file 3 "../../RTOS/FreeRTOS/Source/include/../../Source/portable/MPLAB/PIC24_dsPIC/portmacro.h"
	.file 4 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\dsPIC33E\\h/p33EV128GM106.h"
	.section	.debug_info,info
	.4byte	0x2d3
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.asciz	"GNU C 4.5.1 (XC16, Microchip v2.10) (B) Build date: Mar 27 2023"
	.byte	0x1
	.asciz	"main.c"
	.asciz	"C:\\REPOS\\Voltworks_Garage\\Firmware\\Projects\\RTOS_DEV.X"
	.4byte	.Ltext0
	.4byte	.Letext0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.byte	0x8
	.byte	0x4
	.asciz	"long double"
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.asciz	"unsigned int"
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.asciz	"int"
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.asciz	"long long int"
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.asciz	"char"
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.asciz	"double"
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.asciz	"signed char"
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.asciz	"long int"
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.asciz	"unsigned char"
	.uleb128 0x3
	.asciz	"uint16_t"
	.byte	0x2
	.byte	0xc1
	.4byte	0xa6
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.asciz	"long unsigned int"
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.asciz	"long long unsigned int"
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.asciz	"short unsigned int"
	.uleb128 0x4
	.byte	0x2
	.uleb128 0x3
	.asciz	"BaseType_t"
	.byte	0x3
	.byte	0x61
	.4byte	0x175
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.asciz	"short int"
	.uleb128 0x3
	.asciz	"UBaseType_t"
	.byte	0x3
	.byte	0x62
	.4byte	0x14b
	.uleb128 0x3
	.asciz	"TickType_t"
	.byte	0x3
	.byte	0x65
	.4byte	0x10c
	.uleb128 0x5
	.asciz	"prvSetupHardware"
	.byte	0x1
	.byte	0xa2
	.byte	0x1
	.4byte	.LFB6
	.4byte	.LFE6
	.byte	0x1
	.byte	0x5f
	.uleb128 0x6
	.asciz	"vCheckTask"
	.byte	0x1
	.byte	0xa8
	.byte	0x1
	.4byte	.LFB7
	.4byte	.LFE7
	.byte	0x1
	.byte	0x5f
	.4byte	0x258
	.uleb128 0x7
	.asciz	"pvParameters"
	.byte	0x1
	.byte	0xa8
	.4byte	0x161
	.byte	0x1
	.byte	0x50
	.uleb128 0x8
	.asciz	"xLastExecutionTime"
	.byte	0x1
	.byte	0xab
	.4byte	0x195
	.byte	0x2
	.byte	0x91
	.sleb128 -14
	.uleb128 0x9
	.4byte	.LASF0
	.byte	0x1
	.byte	0xae
	.4byte	0x14b
	.byte	0x1
	.byte	0x1
	.uleb128 0x8
	.asciz	"cStringBuffer"
	.byte	0x1
	.byte	0xb1
	.4byte	0x258
	.byte	0x5
	.byte	0x3
	.4byte	_cStringBuffer.9933
	.uleb128 0x8
	.asciz	"usErrorDetected"
	.byte	0x1
	.byte	0xb5
	.4byte	0x14b
	.byte	0x1
	.byte	0x59
	.byte	0x0
	.uleb128 0xa
	.4byte	0xce
	.4byte	0x268
	.uleb128 0xb
	.4byte	0xa6
	.byte	0x13
	.byte	0x0
	.uleb128 0xc
	.byte	0x1
	.asciz	"main"
	.byte	0x1
	.byte	0x83
	.byte	0x1
	.4byte	0xb6
	.4byte	.LFB5
	.4byte	.LFE5
	.byte	0x1
	.byte	0x5f
	.uleb128 0xd
	.byte	0x1
	.asciz	"vApplicationIdleHook"
	.byte	0x1
	.byte	0xdf
	.byte	0x1
	.4byte	.LFB8
	.4byte	.LFE8
	.byte	0x1
	.byte	0x5f
	.uleb128 0xe
	.asciz	"CORCON"
	.byte	0x4
	.byte	0xa3
	.4byte	0x2b4
	.byte	0x1
	.byte	0x1
	.uleb128 0xf
	.4byte	0x10c
	.uleb128 0xe
	.asciz	"CORCON"
	.byte	0x4
	.byte	0xa3
	.4byte	0x2b4
	.byte	0x1
	.byte	0x1
	.uleb128 0x9
	.4byte	.LASF0
	.byte	0x1
	.byte	0xae
	.4byte	0x14b
	.byte	0x1
	.byte	0x1
	.byte	0x0
	.section	.debug_abbrev,info
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0x8
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1b
	.uleb128 0x8
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x6
	.byte	0x0
	.byte	0x0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0x0
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x16
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x4
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x5
	.uleb128 0x2e
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x6
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x7
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x8
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x9
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0x0
	.byte	0x0
	.uleb128 0xa
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xb
	.uleb128 0x21
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0xc
	.uleb128 0x2e
	.byte	0x0
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0xd
	.uleb128 0x2e
	.byte	0x0
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0xe
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0x0
	.byte	0x0
	.uleb128 0xf
	.uleb128 0x35
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.section	.debug_pubnames,info
	.4byte	0x30
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x2d7
	.4byte	0x268
	.asciz	"main"
	.4byte	0x280
	.asciz	"vApplicationIdleHook"
	.4byte	0x0
	.section	.debug_pubtypes,info
	.4byte	0x49
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x2d7
	.4byte	0x10c
	.asciz	"uint16_t"
	.4byte	0x163
	.asciz	"BaseType_t"
	.4byte	0x182
	.asciz	"UBaseType_t"
	.4byte	0x195
	.asciz	"TickType_t"
	.4byte	0x0
	.section	.debug_aranges,info
	.4byte	0x34
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0x0
	.2byte	0x0
	.2byte	0x0
	.4byte	.LFB6
	.4byte	.LFE6-.LFB6
	.4byte	.LFB7
	.4byte	.LFE7-.LFB7
	.4byte	.LFB5
	.4byte	.LFE5-.LFB5
	.4byte	.LFB8
	.4byte	.LFE8-.LFB8
	.4byte	0x0
	.4byte	0x0
	.section	.debug_str,info
.LASF0:
	.asciz	"usMaxJitter"
	.section	.text,code



	.section __c30_info, info, bss
__large_data_scalar:

	.section __c30_signature, info, data
	.word 0x0001
	.word 0x0007
	.word 0x0000

; MCHP configuration words

	.set ___PA___,0
	.end
