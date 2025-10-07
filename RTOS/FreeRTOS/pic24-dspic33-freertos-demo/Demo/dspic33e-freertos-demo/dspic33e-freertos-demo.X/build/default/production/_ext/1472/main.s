	.file "C:\\Users\\zachl\\Downloads\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo\\Demo\\dspic33e-freertos-demo\\dspic33e-freertos-demo.X\\..\\main.c"
	.section	.debug_abbrev,info
.Ldebug_abbrev0:
	.section	.debug_info,info
.Ldebug_info0:
	.section	.debug_line,info
.Ldebug_line0:
	.section	.text,code
.Ltext0:
	.section	.const,psv,page
.LC0:
	.asciz	"FAIL #1"
.LC1:
	.asciz	"FAIL #2"
.LC2:
	.asciz	"FAIL #3"
.LC3:
	.asciz	"FAIL #4"
.LC4:
	.asciz	"%dns max jitter"
	.section	.text.vCheckTask,code
	.align	2
	.type	_vCheckTask,@function
_vCheckTask:
.LFB2:
	.file 1 "../main.c"
	.loc 1 174 0
	.set ___PA___,1
	add	w15,#8,w15
.LCFI0:
	mov.d	w8,[w15++]
.LCFI1:
	mov.d	w10,[w15++]
.LCFI2:
	mov	w14,[w15++]
.LCFI3:
	.loc 1 188 0
	clr	w0
	mov	w0,[w15-14]
	mov	#_cStringBuffer.17197,w0
	mov	w0,[w15-12]
	.loc 1 195 0
	rcall	_xTaskGetTickCount
	sub	w15,#16,w14
	mov	w0,[w14++]
	.loc 1 191 0
	clr	w8
	mov	#.LC4,w11
	.loc 1 232 0
	mov	#40,w10
	mov	#15536,w9
.L7:
	.loc 1 200 0
	mov	#3000,w1
	sub	w15,#16,w0
	rcall	_xTaskDelayUntil
	.loc 1 204 0
	rcall	_xAreIntegerMathsTaskStillRunning
	sub	w0,#1,[w15]
	.set ___BP___,48
	bra	z,.L2
	.loc 1 207 0
	mov	#_cStringBuffer.17197,w0
	mov	#.LC0,w1
	
	repeat	#8-1
	mov.b	[w1++],[w0++]
		
	.loc 1 206 0
	mov	#1,w8
.L2:
	.loc 1 210 0
	rcall	_xAreComTestTasksStillRunning
	sub	w0,#1,[w15]
	.set ___BP___,48
	bra	z,.L3
	.loc 1 213 0
	mov	#_cStringBuffer.17197,w0
	mov	#.LC1,w1
	
	repeat	#8-1
	mov.b	[w1++],[w0++]
		
	.loc 1 212 0
	mov	#1,w8
.L3:
	.loc 1 216 0
	rcall	_xAreBlockTimeTestTasksStillRunning
	sub	w0,#1,[w15]
	.set ___BP___,48
	bra	z,.L4
	.loc 1 219 0
	mov	#_cStringBuffer.17197,w0
	mov	#.LC2,w1
	
	repeat	#8-1
	mov.b	[w1++],[w0++]
		
	.loc 1 218 0
	mov	#1,w8
.L4:
	.loc 1 222 0
	rcall	_xAreBlockingQueuesStillRunning
	sub	w0,#1,[w15]
	.set ___BP___,48
	bra	z,.L5
	.loc 1 225 0
	mov	#_cStringBuffer.17197,w0
	mov	#.LC3,w1
	
	repeat	#8-1
	mov.b	[w1++],[w0++]
		
	.loc 1 224 0
	mov	#1,w8
	.loc 1 236 0
	clr	w3
	setm	w2
	mov	w14,w1
	mov	_xLCDQueue,w0
	rcall	_xQueueGenericSend
	.loc 1 237 0
	bra	.L7
.L5:
	.loc 1 228 0
	cp0	w8
	.set ___BP___,40
	bra	nz,.L8
	.loc 1 232 0
	mov	_usMaxJitter,w0
	mulw.ss	w0,w10,w0
	add	w0,w9,[w15++]
.LCFI4:
	mov	w11,[w15++]
.LCFI5:
	mov	#_cStringBuffer.17197,w0
.LCFI6:
	rcall	__sprintf_cdnopuxX
	sub	w15,#4,w15
.LCFI7:
	.loc 1 236 0
	clr	w3
	setm	w2
	mov	w14,w1
	mov	_xLCDQueue,w0
.LCFI8:
	rcall	_xQueueGenericSend
	bra	.L7
.L8:
	.loc 1 228 0
	mov	w0,w8
	.loc 1 236 0
	clr	w3
	setm	w2
	mov	w14,w1
	mov	_xLCDQueue,w0
	rcall	_xQueueGenericSend
	bra	.L7
.LFE2:
	.size	_vCheckTask, .-_vCheckTask
	.section	.const,psv,page
.LC5:
	.asciz	"Check"
	.section	.text.main,code
	.align	2
	.global	_main	; export
	.type	_main,@function
_main:
.LFB0:
	.loc 1 137 0
	.set ___PA___,1
.LBB4:
.LBB5:
	.loc 1 169 0
	rcall	_vParTestInitialise
.LBE5:
.LBE4:
	.loc 1 142 0
	mov	#2,w0
	rcall	_vStartBlockingQueueTasks
	.loc 1 143 0
	clr	w0
	rcall	_vStartIntegerMathTasks
	.loc 1 144 0
	mov	#5,w0
	rcall	_vStartFlashCoRoutines
	.loc 1 145 0
	mov	#6,w1
	mov	#19200,w2
	mov	#0,w3
	mov	#2,w0
	rcall	_vAltStartComTestTasks
	.loc 1 146 0
	rcall	_vCreateBlockTimeTasks
	.loc 1 149 0
	clr	w5
	mov	#3,w4
	mov	w5,w3
	mov	#420,w2
	mov	#.LC5,w1
	mov	#handle(_vCheckTask),w0
	rcall	_xTaskCreate
	.loc 1 153 0
	rcall	_xStartLCDTask
	mov	w0,_xLCDQueue
	.loc 1 156 0
	mov	#20000,w0
	rcall	_vSetupTimerTest
	.loc 1 159 0
	rcall	_vTaskStartScheduler
	.loc 1 164 0
	retlw	#0,w0
	.set ___PA___,0
.LFE0:
	.size	_main, .-_main
	.section	.text.vApplicationIdleHook,code
	.align	2
	.global	_vApplicationIdleHook	; export
	.type	_vApplicationIdleHook,@function
_vApplicationIdleHook:
.LFB3:
	.loc 1 242 0
	.set ___PA___,1
	.loc 1 244 0
	bra	_vCoRoutineSchedule
	.loc 1 245 0
	.set ___PA___,0
.LFE3:
	.size	_vApplicationIdleHook, .-_vApplicationIdleHook
	.section	.nbss,bss,near
	.align	2
	.type	_xLCDQueue,@object
	.size	_xLCDQueue, 2
_xLCDQueue:
	.skip	2
	.section	.bss,bss
	.type	_cStringBuffer.17197,@object
	.size	_cStringBuffer.17197, 20
_cStringBuffer.17197:
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
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.byte	0x4
	.4byte	.LCFI0-.LFB2
	.byte	0x13
	.sleb128 -6
	.byte	0x4
	.4byte	.LCFI1-.LCFI0
	.byte	0x13
	.sleb128 -8
	.byte	0x4
	.4byte	.LCFI2-.LCFI1
	.byte	0x13
	.sleb128 -10
	.byte	0x4
	.4byte	.LCFI3-.LCFI2
	.byte	0x13
	.sleb128 -11
	.byte	0x8e
	.uleb128 0xa
	.byte	0x8a
	.uleb128 0x8
	.byte	0x88
	.uleb128 0x6
	.byte	0x4
	.4byte	.LCFI4-.LCFI3
	.byte	0x13
	.sleb128 -12
	.byte	0x4
	.4byte	.LCFI5-.LCFI4
	.byte	0x13
	.sleb128 -13
	.byte	0x4
	.4byte	.LCFI6-.LCFI5
	.byte	0x2e
	.uleb128 0x4
	.byte	0x4
	.4byte	.LCFI7-.LCFI6
	.byte	0x13
	.sleb128 -11
	.byte	0x4
	.4byte	.LCFI8-.LCFI7
	.byte	0x2e
	.uleb128 0x0
	.align	4
.LEFDE0:
.LSFDE2:
	.4byte	.LEFDE2-.LASFDE2
.LASFDE2:
	.4byte	.Lframe0
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.align	4
.LEFDE2:
.LSFDE4:
	.4byte	.LEFDE4-.LASFDE4
.LASFDE4:
	.4byte	.Lframe0
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.align	4
.LEFDE4:
	.section	.text,code
.Letext0:
	.file 2 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h"
	.file 3 "../../../Source/include/../../Source/portable/MPLAB/PIC24_dsPIC/portmacro.h"
	.file 4 "../../../Source/include/queue.h"
	.file 5 "../lcd.h"
	.section	.debug_info,info
	.4byte	0x3d6
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.asciz	"GNU C 4.5.1 (XC16, Microchip v2.10) (B) Build date: Mar 27 2023"
	.byte	0x1
	.asciz	"../main.c"
	.ascii	"C:\\Users\\zachl\\Downloads\\pic24-dspic33-freertos-demo-main\\pic24"
	.ascii	"-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo\\Demo\\dspi"
	.asciz	"c33e-freertos-demo\\dspic33e-freertos-demo.X"
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
	.byte	0x2
	.byte	0x7
	.asciz	"short unsigned int"
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
	.4byte	0x11e
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.asciz	"long unsigned int"
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.asciz	"long long unsigned int"
	.uleb128 0x4
	.byte	0x2
	.uleb128 0x3
	.asciz	"BaseType_t"
	.byte	0x3
	.byte	0x61
	.4byte	0x1ed
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.asciz	"short int"
	.uleb128 0x3
	.asciz	"UBaseType_t"
	.byte	0x3
	.byte	0x62
	.4byte	0x158
	.uleb128 0x3
	.asciz	"TickType_t"
	.byte	0x3
	.byte	0x65
	.4byte	0x19a
	.uleb128 0x3
	.asciz	"QueueHandle_t"
	.byte	0x4
	.byte	0x33
	.4byte	0x234
	.uleb128 0x5
	.byte	0x2
	.4byte	0x23a
	.uleb128 0x6
	.asciz	"QueueDefinition"
	.byte	0x1
	.uleb128 0x7
	.byte	0x4
	.byte	0x5
	.byte	0x4d
	.4byte	0x283
	.uleb128 0x8
	.asciz	"xMinDisplayTime"
	.byte	0x5
	.byte	0x51
	.4byte	0x20d
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x8
	.asciz	"pcMessage"
	.byte	0x5
	.byte	0x54
	.4byte	0x283
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	0x146
	.uleb128 0x3
	.asciz	"xLCDMessage"
	.byte	0x5
	.byte	0x56
	.4byte	0x24c
	.uleb128 0x9
	.asciz	"prvSetupHardware"
	.byte	0x1
	.byte	0xa7
	.byte	0x1
	.byte	0x1
	.uleb128 0xa
	.asciz	"vCheckTask"
	.byte	0x1
	.byte	0xad
	.byte	0x1
	.4byte	.LFB2
	.4byte	.LFE2
	.byte	0x1
	.byte	0x5f
	.4byte	0x357
	.uleb128 0xb
	.asciz	"pvParameters"
	.byte	0x1
	.byte	0xad
	.4byte	0x1d9
	.byte	0x1
	.byte	0x50
	.uleb128 0xc
	.asciz	"xLastExecutionTime"
	.byte	0x1
	.byte	0xb0
	.4byte	0x20d
	.byte	0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0xd
	.4byte	.LASF0
	.byte	0x1
	.byte	0xb3
	.4byte	0x158
	.byte	0x1
	.byte	0x1
	.uleb128 0xc
	.asciz	"cStringBuffer"
	.byte	0x1
	.byte	0xb6
	.4byte	0x357
	.byte	0x5
	.byte	0x3
	.4byte	_cStringBuffer.17197
	.uleb128 0xc
	.asciz	"xMessage"
	.byte	0x1
	.byte	0xbc
	.4byte	0x289
	.byte	0x2
	.byte	0x91
	.sleb128 -14
	.uleb128 0xc
	.asciz	"usErrorDetected"
	.byte	0x1
	.byte	0xbf
	.4byte	0x158
	.byte	0x1
	.byte	0x58
	.byte	0x0
	.uleb128 0xe
	.4byte	0x146
	.4byte	0x367
	.uleb128 0xf
	.4byte	0x11e
	.byte	0x13
	.byte	0x0
	.uleb128 0x10
	.byte	0x1
	.asciz	"main"
	.byte	0x1
	.byte	0x88
	.byte	0x1
	.4byte	0x12e
	.4byte	.LFB0
	.4byte	.LFE0
	.byte	0x1
	.byte	0x5f
	.4byte	0x391
	.uleb128 0x11
	.4byte	0x29c
	.4byte	.LBB4
	.4byte	.LBE4
	.byte	0x0
	.uleb128 0x12
	.byte	0x1
	.asciz	"vApplicationIdleHook"
	.byte	0x1
	.byte	0xf1
	.byte	0x1
	.4byte	.LFB3
	.4byte	.LFE3
	.byte	0x1
	.byte	0x5f
	.uleb128 0xc
	.asciz	"xLCDQueue"
	.byte	0x1
	.byte	0x81
	.4byte	0x21f
	.byte	0x5
	.byte	0x3
	.4byte	_xLCDQueue
	.uleb128 0xd
	.4byte	.LASF0
	.byte	0x1
	.byte	0xb3
	.4byte	0x158
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
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x6
	.uleb128 0x13
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0x0
	.byte	0x0
	.uleb128 0x7
	.uleb128 0x13
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x8
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x9
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
	.uleb128 0x20
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0xa
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
	.uleb128 0xb
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
	.uleb128 0xc
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
	.uleb128 0xd
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
	.uleb128 0xe
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xf
	.uleb128 0x21
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x10
	.uleb128 0x2e
	.byte	0x1
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
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x11
	.uleb128 0x1d
	.byte	0x0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.byte	0x0
	.byte	0x0
	.uleb128 0x12
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
	.byte	0x0
	.section	.debug_pubnames,info
	.4byte	0x30
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x3da
	.4byte	0x367
	.asciz	"main"
	.4byte	0x391
	.asciz	"vApplicationIdleHook"
	.4byte	0x0
	.section	.debug_pubtypes,info
	.4byte	0x6b
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x3da
	.4byte	0x19a
	.asciz	"uint16_t"
	.4byte	0x1db
	.asciz	"BaseType_t"
	.4byte	0x1fa
	.asciz	"UBaseType_t"
	.4byte	0x20d
	.asciz	"TickType_t"
	.4byte	0x21f
	.asciz	"QueueHandle_t"
	.4byte	0x289
	.asciz	"xLCDMessage"
	.4byte	0x0
	.section	.debug_aranges,info
	.4byte	0x2c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0x0
	.2byte	0x0
	.2byte	0x0
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
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
; Configuration word @ 0x00f8000a
	.section	.config_FWDTEN, code, address(0xf8000a), keep
__config_FWDTEN:
	.pword	16777087

	.set ___PA___,0
	.end
