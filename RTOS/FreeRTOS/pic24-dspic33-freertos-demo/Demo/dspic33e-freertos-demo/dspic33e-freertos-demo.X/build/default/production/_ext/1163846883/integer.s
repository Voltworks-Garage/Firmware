	.file "C:\\Users\\zachl\\Downloads\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo\\Demo\\dspic33e-freertos-demo\\dspic33e-freertos-demo.X\\..\\..\\Common\\Minimal\\integer.c"
	.section	.debug_abbrev,info
.Ldebug_abbrev0:
	.section	.debug_info,info
.Ldebug_info0:
	.section	.debug_line,info
.Ldebug_line0:
	.section	.text,code
.Ltext0:
	.section	.text.vCompeteingIntMathTask,code
	.align	2
	.type	_vCompeteingIntMathTask,@function
_vCompeteingIntMathTask:
.LFB1:
	.file 1 "../../Common/Minimal/integer.c"
	.loc 1 80 0
	.set ___PA___,1
	lnk	#4
.LCFI0:
	mov.d	w8,[w15++]
.LCFI1:
	mov.d	w10,[w15++]
.LCFI2:
	mov.d	w12,[w15++]
.LCFI3:
	mov	w0,w9
	.loc 1 84 0
	clr	w8
	.loc 1 98 0
	mov	#37959,w12
	mov	#3,w13
	.loc 1 114 0
	mov	#30491,w10
	mov	#65534,w11
	.loc 1 97 0
	mov	#123,w0
	mov	#0,w1
	mov	w0,[w15-16]
	mov	w1,[w15-14]
	.loc 1 98 0
	mov	[w15-16],w0
	mov	[w15-14],w1
	add	w12,w0,w0
	addc	w13,w1,w1
	mov	w0,[w15-16]
	mov	w1,[w15-14]
	.loc 1 108 0
	mov	[w15-16],w0
	mov	[w15-14],w1
	mov	#-3,w3
	mulw.ss	w1,w3,w2
	sub	w2,w0,w2
	mul.uu	w0,w3,w0
	add	w2,w1,w1
	mov	w0,[w15-16]
	mov	w1,[w15-14]
	.loc 1 109 0
	mov	[w15-16],w0
	mov	[w15-14],w1
	mov	#7,w2
	mov	#0,w3
	rcall	___divsi3
	mov.d	w0,w2
	.loc 1 114 0
	mov	w2,[w15-16]
	mov	w3,[w15-14]
	mov.d	w2,w0
	sub	w0,w10,[w15]
	subb	w1,w11,[w15]
	.set ___BP___,28
	bra	z,.L8
.L5:
	.loc 1 119 0
	mov	#1,w8
	.loc 1 97 0
	mov	#123,w0
	mov	#0,w1
	mov	w0,[w15-16]
	mov	w1,[w15-14]
	.loc 1 98 0
	mov	[w15-16],w0
	mov	[w15-14],w1
	add	w12,w0,w0
	addc	w13,w1,w1
	mov	w0,[w15-16]
	mov	w1,[w15-14]
	.loc 1 108 0
	mov	[w15-16],w0
	mov	[w15-14],w1
	mov	#-3,w3
	mulw.ss	w1,w3,w2
	sub	w2,w0,w2
	mul.uu	w0,w3,w0
	add	w2,w1,w1
	mov	w0,[w15-16]
	mov	w1,[w15-14]
	.loc 1 109 0
	mov	[w15-16],w0
	mov	[w15-14],w1
	mov	#7,w2
	mov	#0,w3
	rcall	___divsi3
	mov.d	w0,w2
	.loc 1 114 0
	mov	w2,[w15-16]
	mov	w3,[w15-14]
	mov.d	w2,w0
	sub	w0,w10,[w15]
	subb	w1,w11,[w15]
	.set ___BP___,72
	bra	nz,.L5
.L8:
	.loc 1 119 0
	cp0	w8
	.set ___BP___,0
	bra	nz,.L5
	.loc 1 124 0
	rcall	_vPortEnterCritical
	.loc 1 125 0
	mov	#1,w0
	mov	w0,[w9]
	.loc 1 126 0
	rcall	_vPortExitCritical
	.loc 1 97 0
	mov	#123,w0
	mov	#0,w1
	mov	w0,[w15-16]
	mov	w1,[w15-14]
	.loc 1 98 0
	mov	[w15-16],w0
	mov	[w15-14],w1
	add	w12,w0,w0
	addc	w13,w1,w1
	mov	w0,[w15-16]
	mov	w1,[w15-14]
	.loc 1 108 0
	mov	[w15-16],w0
	mov	[w15-14],w1
	mov	#-3,w3
	mulw.ss	w1,w3,w2
	sub	w2,w0,w2
	mul.uu	w0,w3,w0
	add	w2,w1,w1
	mov	w0,[w15-16]
	mov	w1,[w15-14]
	.loc 1 109 0
	mov	[w15-16],w0
	mov	[w15-14],w1
	mov	#7,w2
	mov	#0,w3
	rcall	___divsi3
	mov.d	w0,w2
	.loc 1 114 0
	mov	w2,[w15-16]
	mov	w3,[w15-14]
	mov.d	w2,w0
	sub	w0,w10,[w15]
	subb	w1,w11,[w15]
	.set ___BP___,72
	bra	nz,.L5
	bra	.L8
.LFE1:
	.size	_vCompeteingIntMathTask, .-_vCompeteingIntMathTask
	.section	.const,psv,page
.LC0:
	.asciz	"IntMath"
	.section	.text.vStartIntegerMathTasks,code
	.align	2
	.global	_vStartIntegerMathTasks	; export
	.type	_vStartIntegerMathTasks,@function
_vStartIntegerMathTasks:
.LFB0:
	.loc 1 69 0
	.set ___PA___,1
	.loc 1 74 0
	clr	w5
	mov	w0,w4
	mov	#_xTaskCheck,w3
	mov	#105,w2
	mov	#.LC0,w1
	mov	#handle(_vCompeteingIntMathTask),w0
	bra	_xTaskCreate
	.loc 1 76 0
	.set ___PA___,0
.LFE0:
	.size	_vStartIntegerMathTasks, .-_vStartIntegerMathTasks
	.section	.text.xAreIntegerMathsTaskStillRunning,code
	.align	2
	.global	_xAreIntegerMathsTaskStillRunning	; export
	.type	_xAreIntegerMathsTaskStillRunning,@function
_xAreIntegerMathsTaskStillRunning:
.LFB2:
	.loc 1 141 0
	.set ___PA___,1
	.loc 1 142 0
	mov	_xTaskCheck,w0
	btsc	w0,#15
	neg	w0,w0
	neg	w0,w0
	lsr	w0,#15,w0
	.loc 1 157 0
	clr	_xTaskCheck
	.loc 1 161 0
	return	
	.set ___PA___,0
.LFE2:
	.size	_xAreIntegerMathsTaskStillRunning, .-_xAreIntegerMathsTaskStillRunning
	.section	.nbss,bss,near
	.align	2
	.type	_xTaskCheck,@object
	.size	_xTaskCheck, 2
_xTaskCheck:
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
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.byte	0x4
	.4byte	.LCFI0-.LFB1
	.byte	0x12
	.uleb128 0xe
	.sleb128 -3
	.byte	0x8e
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI3-.LCFI0
	.byte	0x8c
	.uleb128 0x9
	.byte	0x8a
	.uleb128 0x7
	.byte	0x88
	.uleb128 0x5
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
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.align	4
.LEFDE4:
	.section	.text,code
.Letext0:
	.file 2 "../../../Source/include/../../Source/portable/MPLAB/PIC24_dsPIC/portmacro.h"
	.file 3 "../../../Source/include/task.h"
	.section	.debug_info,info
	.4byte	0x38a
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.asciz	"GNU C 4.5.1 (XC16, Microchip v2.10) (B) Build date: Mar 27 2023"
	.byte	0x1
	.asciz	"../../Common/Minimal/integer.c"
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
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.asciz	"long unsigned int"
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.asciz	"long long unsigned int"
	.uleb128 0x3
	.byte	0x2
	.uleb128 0x4
	.asciz	"BaseType_t"
	.byte	0x2
	.byte	0x61
	.4byte	0x1e0
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.asciz	"short int"
	.uleb128 0x4
	.asciz	"UBaseType_t"
	.byte	0x2
	.byte	0x62
	.4byte	0x133
	.uleb128 0x4
	.asciz	"TaskHandle_t"
	.byte	0x3
	.byte	0x57
	.4byte	0x214
	.uleb128 0x5
	.byte	0x2
	.4byte	0x21a
	.uleb128 0x6
	.asciz	"tskTaskControlBlock"
	.byte	0x1
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.asciz	"char"
	.uleb128 0x7
	.asciz	"vCompeteingIntMathTask"
	.byte	0x1
	.byte	0x4f
	.byte	0x1
	.4byte	.LFB1
	.4byte	.LFE1
	.byte	0x1
	.byte	0x5f
	.4byte	0x2b4
	.uleb128 0x8
	.asciz	"pvParameters"
	.byte	0x1
	.byte	0x4f
	.4byte	0x1cc
	.byte	0x1
	.byte	0x50
	.uleb128 0x9
	.asciz	"lValue"
	.byte	0x1
	.byte	0x53
	.4byte	0x2b4
	.byte	0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x9
	.asciz	"sError"
	.byte	0x1
	.byte	0x54
	.4byte	0x1e0
	.byte	0x1
	.byte	0x58
	.uleb128 0x9
	.asciz	"pxTaskHasExecuted"
	.byte	0x1
	.byte	0x55
	.4byte	0x2b9
	.byte	0x1
	.byte	0x59
	.byte	0x0
	.uleb128 0xa
	.4byte	0x160
	.uleb128 0x5
	.byte	0x2
	.4byte	0x2bf
	.uleb128 0xa
	.4byte	0x1ce
	.uleb128 0xb
	.byte	0x1
	.asciz	"vStartIntegerMathTasks"
	.byte	0x1
	.byte	0x44
	.byte	0x1
	.4byte	.LFB0
	.4byte	.LFE0
	.byte	0x1
	.byte	0x5f
	.4byte	0x310
	.uleb128 0x8
	.asciz	"uxPriority"
	.byte	0x1
	.byte	0x44
	.4byte	0x1ed
	.byte	0x1
	.byte	0x50
	.uleb128 0xc
	.asciz	"sTask"
	.byte	0x1
	.byte	0x46
	.4byte	0x1e0
	.byte	0x0
	.uleb128 0xd
	.byte	0x1
	.asciz	"xAreIntegerMathsTaskStillRunning"
	.byte	0x1
	.byte	0x8c
	.byte	0x1
	.4byte	0x1ce
	.4byte	.LFB2
	.4byte	.LFE2
	.byte	0x1
	.byte	0x5f
	.4byte	0x365
	.uleb128 0xc
	.asciz	"xReturn"
	.byte	0x1
	.byte	0x8e
	.4byte	0x1ce
	.uleb128 0xc
	.asciz	"sTask"
	.byte	0x1
	.byte	0x8f
	.4byte	0x1e0
	.byte	0x0
	.uleb128 0xe
	.4byte	0x1ce
	.4byte	0x375
	.uleb128 0xf
	.4byte	0x149
	.byte	0x0
	.byte	0x0
	.uleb128 0x9
	.asciz	"xTaskCheck"
	.byte	0x1
	.byte	0x40
	.4byte	0x365
	.byte	0x5
	.byte	0x3
	.4byte	_xTaskCheck
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
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x4
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
	.uleb128 0x8
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
	.uleb128 0x9
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
	.uleb128 0xa
	.uleb128 0x35
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xb
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
	.byte	0x0
	.byte	0x0
	.uleb128 0xd
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
	.byte	0x0
	.section	.debug_pubnames,info
	.4byte	0x4e
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x38e
	.4byte	0x2c4
	.asciz	"vStartIntegerMathTasks"
	.4byte	0x310
	.asciz	"xAreIntegerMathsTaskStillRunning"
	.4byte	0x0
	.section	.debug_pubtypes,info
	.4byte	0x3e
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x38e
	.4byte	0x1ce
	.asciz	"BaseType_t"
	.4byte	0x1ed
	.asciz	"UBaseType_t"
	.4byte	0x200
	.asciz	"TaskHandle_t"
	.4byte	0x0
	.section	.debug_aranges,info
	.4byte	0x2c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0x0
	.2byte	0x0
	.2byte	0x0
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.4byte	0x0
	.4byte	0x0
	.section	.debug_str,info
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
