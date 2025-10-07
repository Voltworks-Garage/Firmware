	.file "C:\\Users\\zachl\\Downloads\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo\\Demo\\dspic33e-freertos-demo\\dspic33e-freertos-demo.X\\..\\..\\Common\\Minimal\\comtest.c"
	.section	.debug_abbrev,info
.Ldebug_abbrev0:
	.section	.debug_info,info
.Ldebug_info0:
	.section	.debug_line,info
.Ldebug_line0:
	.section	.text,code
.Ltext0:
	.section	.text.vComRxTask,code
	.align	2
	.type	_vComRxTask,@function
_vComRxTask:
.LFB2:
	.file 1 "../../Common/Minimal/comtest.c"
	.loc 1 172 0
	.set ___PA___,1
	lnk	#2
.LCFI0:
	mov.d	w8,[w15++]
.LCFI1:
	mov.d	w10,[w15++]
.LCFI2:
	.loc 1 174 0
	clr	w11
	.loc 1 183 0
	mov.b	#89,w9
	.loc 1 212 0
	mov.b	#88,w10
.L15:
	.loc 1 183 0
	mov.b	#65,w8
.L5:
	.loc 1 187 0
	setm	w2
	sub	w15,#10,w1
	clr	w0
	rcall	_xSerialGetChar
	cp0	w0
	.set ___BP___,50
	bra	z,.L3
	.loc 1 192 0
	mov.b	[w15-10],w0
	sub.b	w0,w8,[w15]
	.set ___BP___,4
	bra	nz,.L4
	.loc 1 194 0
	inc	_uxBaseLED,WREG
	rcall	_vParTestToggleLED
.L3:
	.loc 1 183 0
	inc.b	w8,w8
	sub.b	w8,w9,[w15]
	.set ___BP___,95
	bra	nz,.L5
	.loc 1 205 0
	inc	_uxBaseLED,WREG
	clr	w1
	rcall	_vParTestSetLED
	.loc 1 229 0
	sub	w11,#1,[w15]
	.set ___BP___,73
	bra	gt,.L15
	.loc 1 237 0
	inc	_uxRxLoops
	.loc 1 183 0
	mov.b	#65,w8
	bra	.L5
.L4:
	.loc 1 205 0
	inc	_uxBaseLED,WREG
	clr	w1
	rcall	_vParTestSetLED
	.loc 1 212 0
	mov.b	[w15-10],w0
	sub.b	w0,w10,[w15]
	.set ___BP___,9
	bra	z,.L7
.L11:
	.loc 1 215 0
	setm	w2
	sub	w15,#10,w1
	clr	w0
	rcall	_xSerialGetChar
	.loc 1 212 0
	mov.b	[w15-10],w0
	sub.b	w0,w10,[w15]
	.set ___BP___,91
	bra	nz,.L11
.L7:
	.loc 1 222 0
	inc	w11,w11
	.loc 1 183 0
	mov.b	#65,w8
	bra	.L5
.LFE2:
	.size	_vComRxTask, .-_vComRxTask
	.section	.text.vComTxTask,code
	.align	2
	.type	_vComTxTask,@function
_vComTxTask:
.LFB1:
	.loc 1 130 0
	.set ___PA___,1
	mov.d	w8,[w15++]
.LCFI3:
	mov	w10,[w15++]
.LCFI4:
	.loc 1 141 0
	mov.b	#65,w8
	mov.b	#88,w9
	.loc 1 158 0
	mov	#150,w10
.L25:
	.loc 1 141 0
	sub.b	w8,w9,[w15]
	.set ___BP___,4
	bra	gt,.L27
.L21:
	.loc 1 143 0
	clr	w2
	mov.b	w8,w1
	mov	w2,w0
	rcall	_xSerialPutChar
	sub	w0,#1,[w15]
	.set ___BP___,13
	bra	z,.L28
	.loc 1 141 0
	inc.b	w8,w8
.L29:
	sub.b	w8,w9,[w15]
	.set ___BP___,96
	bra	le,.L21
.L27:
	.loc 1 150 0
	clr	w1
	mov	_uxBaseLED,w0
	rcall	_vParTestSetLED
	.loc 1 155 0
	rcall	_xTaskGetTickCount
	add	w0,#3,w0
	.loc 1 158 0
	repeat	#__TARGET_DIVIDE_CYCLES
	div.uw	w0,w10
	exch	w0,w1
	.loc 1 161 0
	mov	#49,w1
	sub	w0,w1,[w15]
	.set ___BP___,50
	bra	gtu,.L22
	.loc 1 163 0
	mov	#50,w0
.L22:
	.loc 1 166 0
	rcall	_vTaskDelay
	.loc 1 141 0
	mov.b	#65,w8
	bra	.L25
.L28:
	.loc 1 145 0
	mov	_uxBaseLED,w0
	rcall	_vParTestToggleLED
	.loc 1 141 0
	inc.b	w8,w8
	bra	.L29
.LFE1:
	.size	_vComTxTask, .-_vComTxTask
	.section	.const,psv,page
.LC0:
	.asciz	"COMTx"
.LC1:
	.asciz	"COMRx"
	.section	.text.vAltStartComTestTasks,code
	.align	2
	.global	_vAltStartComTestTasks	; export
	.type	_vAltStartComTestTasks,@function
_vAltStartComTestTasks:
.LFB0:
	.loc 1 118 0
	.set ___PA___,1
	mov	w8,[w15++]
.LCFI5:
	mov	w0,w8
	mov.d	w2,w4
	.loc 1 120 0
	mov	w1,_uxBaseLED
	.loc 1 121 0
	mov	#24,w2
	mov.d	w4,w0
	rcall	_xSerialPortInitMinimal
	.loc 1 124 0
	clr	w5
	dec	w8,w4
	mov	w5,w3
	mov	#105,w2
	mov	#.LC0,w1
	mov	#handle(_vComTxTask),w0
	rcall	_xTaskCreate
	.loc 1 125 0
	clr	w5
	mov	w8,w4
	mov	w5,w3
	mov	#105,w2
	mov	#.LC1,w1
	mov	#handle(_vComRxTask),w0
	rcall	_xTaskCreate
	.loc 1 126 0
	mov	[--w15],w8
	return	
	.set ___PA___,0
.LFE0:
	.size	_vAltStartComTestTasks, .-_vAltStartComTestTasks
	.section	.text.xAreComTestTasksStillRunning,code
	.align	2
	.global	_xAreComTestTasksStillRunning	; export
	.type	_xAreComTestTasksStillRunning,@function
_xAreComTestTasksStillRunning:
.LFB3:
	.loc 1 245 0
	.set ___PA___,1
	.loc 1 251 0
	mov	_uxRxLoops,w0
	.loc 1 262 0
	clr	_uxRxLoops
	.loc 1 253 0
	btsc	w0,#15
	neg	w0,w0
	neg	w0,w0
	lsr	w0,#15,w0
	.loc 1 265 0
	return	
	.set ___PA___,0
.LFE3:
	.size	_xAreComTestTasksStillRunning, .-_xAreComTestTasksStillRunning
	.section	.nbss,bss,near
	.align	2
	.type	_uxRxLoops,@object
	.size	_uxRxLoops, 2
_uxRxLoops:
	.skip	2
	.align	2
	.type	_uxBaseLED,@object
	.size	_uxBaseLED, 2
_uxBaseLED:
	.skip	2
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
	.byte	0x12
	.uleb128 0xe
	.sleb128 -3
	.byte	0x8e
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI2-.LCFI0
	.byte	0x8a
	.uleb128 0x6
	.byte	0x88
	.uleb128 0x4
	.align	4
.LEFDE0:
.LSFDE2:
	.4byte	.LEFDE2-.LASFDE2
.LASFDE2:
	.4byte	.Lframe0
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.byte	0x4
	.4byte	.LCFI3-.LFB1
	.byte	0x13
	.sleb128 -4
	.byte	0x4
	.4byte	.LCFI4-.LCFI3
	.byte	0x13
	.sleb128 -5
	.byte	0x8a
	.uleb128 0x4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE2:
.LSFDE4:
	.4byte	.LEFDE4-.LASFDE4
.LASFDE4:
	.4byte	.Lframe0
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.byte	0x4
	.4byte	.LCFI5-.LFB0
	.byte	0x13
	.sleb128 -3
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE4:
.LSFDE6:
	.4byte	.LEFDE6-.LASFDE6
.LASFDE6:
	.4byte	.Lframe0
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.align	4
.LEFDE6:
	.section	.text,code
.Letext0:
	.file 2 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h"
	.file 3 "../../../Source/include/../../Source/portable/MPLAB/PIC24_dsPIC/portmacro.h"
	.file 4 "../../../Source/include/task.h"
	.file 5 "../../Common/include/serial.h"
	.section	.debug_info,info
	.4byte	0x445
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.asciz	"GNU C 4.5.1 (XC16, Microchip v2.10) (B) Build date: Mar 27 2023"
	.byte	0x1
	.asciz	"../../Common/Minimal/comtest.c"
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
	.asciz	"short unsigned int"
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.asciz	"unsigned int"
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.asciz	"int"
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.asciz	"long int"
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.asciz	"long long int"
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.asciz	"signed char"
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.asciz	"unsigned char"
	.uleb128 0x3
	.asciz	"uint16_t"
	.byte	0x2
	.byte	0xc1
	.4byte	0x149
	.uleb128 0x3
	.asciz	"uint32_t"
	.byte	0x2
	.byte	0xcd
	.4byte	0x1bd
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
	.4byte	0x200
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.asciz	"short int"
	.uleb128 0x3
	.asciz	"UBaseType_t"
	.byte	0x3
	.byte	0x62
	.4byte	0x133
	.uleb128 0x3
	.asciz	"TickType_t"
	.byte	0x3
	.byte	0x65
	.4byte	0x19d
	.uleb128 0x5
	.4byte	0x20d
	.uleb128 0x3
	.asciz	"TaskHandle_t"
	.byte	0x4
	.byte	0x57
	.4byte	0x24b
	.uleb128 0x6
	.byte	0x2
	.4byte	0x251
	.uleb128 0x7
	.asciz	"tskTaskControlBlock"
	.byte	0x1
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.asciz	"char"
	.uleb128 0x3
	.asciz	"xComPortHandle"
	.byte	0x5
	.byte	0x1e
	.4byte	0x1ec
	.uleb128 0x8
	.asciz	"vComRxTask"
	.byte	0x1
	.byte	0xab
	.byte	0x1
	.4byte	.LFB2
	.4byte	.LFE2
	.byte	0x1
	.byte	0x5f
	.4byte	0x30a
	.uleb128 0x9
	.4byte	.LASF0
	.byte	0x1
	.byte	0xab
	.4byte	0x1ec
	.byte	0x1
	.byte	0x50
	.uleb128 0xa
	.asciz	"cExpectedByte"
	.byte	0x1
	.byte	0xad
	.4byte	0x17d
	.byte	0x1
	.byte	0x58
	.uleb128 0xa
	.asciz	"cByteRxed"
	.byte	0x1
	.byte	0xad
	.4byte	0x17d
	.byte	0x2
	.byte	0x91
	.sleb128 -10
	.uleb128 0xb
	.asciz	"xResyncRequired"
	.byte	0x1
	.byte	0xae
	.4byte	0x1ee
	.uleb128 0xa
	.asciz	"xErrorOccurred"
	.byte	0x1
	.byte	0xae
	.4byte	0x1ee
	.byte	0x1
	.byte	0x5b
	.byte	0x0
	.uleb128 0x8
	.asciz	"vComTxTask"
	.byte	0x1
	.byte	0x81
	.byte	0x1
	.4byte	.LFB1
	.4byte	.LFE1
	.byte	0x1
	.byte	0x5f
	.4byte	0x35d
	.uleb128 0x9
	.4byte	.LASF0
	.byte	0x1
	.byte	0x81
	.4byte	0x1ec
	.byte	0x1
	.byte	0x50
	.uleb128 0xa
	.asciz	"cByteToSend"
	.byte	0x1
	.byte	0x83
	.4byte	0x267
	.byte	0x1
	.byte	0x58
	.uleb128 0xb
	.asciz	"xTimeToWait"
	.byte	0x1
	.byte	0x84
	.4byte	0x220
	.byte	0x0
	.uleb128 0xc
	.byte	0x1
	.asciz	"vAltStartComTestTasks"
	.byte	0x1
	.byte	0x73
	.byte	0x1
	.4byte	.LFB0
	.4byte	.LFE0
	.byte	0x1
	.byte	0x5f
	.4byte	0x3c3
	.uleb128 0xd
	.asciz	"uxPriority"
	.byte	0x1
	.byte	0x73
	.4byte	0x20d
	.byte	0x1
	.byte	0x58
	.uleb128 0xd
	.asciz	"ulBaudRate"
	.byte	0x1
	.byte	0x74
	.4byte	0x1ad
	.byte	0x6
	.byte	0x54
	.byte	0x93
	.uleb128 0x2
	.byte	0x55
	.byte	0x93
	.uleb128 0x2
	.uleb128 0xd
	.asciz	"uxLED"
	.byte	0x1
	.byte	0x75
	.4byte	0x20d
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.uleb128 0xe
	.byte	0x1
	.asciz	"xAreComTestTasksStillRunning"
	.byte	0x1
	.byte	0xf4
	.byte	0x1
	.4byte	0x1ee
	.4byte	.LFB3
	.4byte	.LFE3
	.byte	0x1
	.byte	0x5f
	.4byte	0x407
	.uleb128 0xb
	.asciz	"xReturn"
	.byte	0x1
	.byte	0xf6
	.4byte	0x1ee
	.byte	0x0
	.uleb128 0xf
	.asciz	"xPort"
	.byte	0x1
	.byte	0x5f
	.4byte	0x415
	.byte	0x0
	.uleb128 0x10
	.4byte	0x26f
	.uleb128 0xa
	.asciz	"uxBaseLED"
	.byte	0x1
	.byte	0x6a
	.4byte	0x20d
	.byte	0x5
	.byte	0x3
	.4byte	_uxBaseLED
	.uleb128 0xa
	.asciz	"uxRxLoops"
	.byte	0x1
	.byte	0x6f
	.4byte	0x232
	.byte	0x5
	.byte	0x3
	.4byte	_uxRxLoops
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
	.uleb128 0x35
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x7
	.uleb128 0x13
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0x0
	.byte	0x0
	.uleb128 0x8
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
	.uleb128 0x9
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
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
	.uleb128 0xa
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
	.uleb128 0xb
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
	.byte	0x0
	.byte	0x0
	.uleb128 0xc
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
	.uleb128 0xd
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
	.uleb128 0xe
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
	.uleb128 0xf
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
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x10
	.uleb128 0x26
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.section	.debug_pubnames,info
	.4byte	0x49
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x449
	.4byte	0x35d
	.asciz	"vAltStartComTestTasks"
	.4byte	0x3c3
	.asciz	"xAreComTestTasksStillRunning"
	.4byte	0x0
	.section	.debug_pubtypes,info
	.4byte	0x7a
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x449
	.4byte	0x19d
	.asciz	"uint16_t"
	.4byte	0x1ad
	.asciz	"uint32_t"
	.4byte	0x1ee
	.asciz	"BaseType_t"
	.4byte	0x20d
	.asciz	"UBaseType_t"
	.4byte	0x220
	.asciz	"TickType_t"
	.4byte	0x237
	.asciz	"TaskHandle_t"
	.4byte	0x26f
	.asciz	"xComPortHandle"
	.4byte	0x0
	.section	.debug_aranges,info
	.4byte	0x34
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0x0
	.2byte	0x0
	.2byte	0x0
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.4byte	0x0
	.4byte	0x0
	.section	.debug_str,info
.LASF0:
	.asciz	"pvParameters"
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
