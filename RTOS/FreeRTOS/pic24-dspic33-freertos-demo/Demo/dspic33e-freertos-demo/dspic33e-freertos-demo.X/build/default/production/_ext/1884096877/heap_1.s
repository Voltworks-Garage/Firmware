	.file "C:\\Users\\zachl\\Downloads\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo\\Demo\\dspic33e-freertos-demo\\dspic33e-freertos-demo.X\\..\\..\\..\\Source\\portable\\MemMang\\heap_1.c"
	.section	.debug_abbrev,info
.Ldebug_abbrev0:
	.section	.debug_info,info
.Ldebug_info0:
	.section	.debug_line,info
.Ldebug_line0:
	.section	.text,code
.Ltext0:
	.section	.text.pvPortMalloc,code
	.align	2
	.global	_pvPortMalloc	; export
	.type	_pvPortMalloc,@function
_pvPortMalloc:
.LFB0:
	.file 1 "../../../Source/portable/MemMang/heap_1.c"
	.loc 1 72 0
	.set ___PA___,1
	mov.d	w8,[w15++]
.LCFI0:
	mov	w0,w9
	.loc 1 79 0
	btst	w9,#0
	.set ___BP___,50
	bra	z,.L2
	.loc 1 82 0
	mov	w9,w0
	bclr	w0,#0
	inc2	w0,w0
	sub	w9,w0,[w15]
	.set ___BP___,50
	bra	geu,.L5
	mov	w0,w9
.L2:
	.loc 1 94 0
	rcall	_vTaskSuspendAll
	.loc 1 96 0
	cp0	_pucAlignedHeap.17022
	.set ___BP___,15
	bra	z,.L10
.L3:
	.loc 1 73 0
	clr	w8
	.loc 1 103 0
	cp0	w9
	.set ___BP___,10
	bra	nz,.L11
.L4:
	.loc 1 115 0
	rcall	_xTaskResumeAll
	.loc 1 127 0
	mov	w8,w0
	mov.d	[--w15],w8
	return	
.L12:
	.set ___PA___,0
.L5:
	.loc 1 88 0
	clr	w9
	.loc 1 94 0
	rcall	_vTaskSuspendAll
	.loc 1 96 0
	cp0	_pucAlignedHeap.17022
	.set ___BP___,85
	bra	nz,.L3
.L10:
	.loc 1 99 0
	mov	#_ucHeap+1,w0
	bclr	w0,#0
	mov	w0,_pucAlignedHeap.17022
	.loc 1 73 0
	clr	w8
	.loc 1 103 0
	cp0	w9
	.set ___BP___,90
	bra	z,.L4
.L11:
	.loc 1 104 0
	mov	_xNextFreeByte,w0
	add	w9,w0,w1
	.loc 1 103 0
	mov	#5117,w2
	sub	w1,w2,[w15]
	.set ___BP___,90
	bra	gtu,.L4
	.loc 1 104 0
	sub	w0,w1,[w15]
	.set ___BP___,39
	bra	geu,.L4
	.loc 1 109 0
	add	_pucAlignedHeap.17022,WREG
	mov	w0,w8
	.loc 1 110 0
	mov	w1,_xNextFreeByte
	.loc 1 115 0
	rcall	_xTaskResumeAll
	.loc 1 127 0
	mov	w8,w0
	mov.d	[--w15],w8
	return	
	bra	.L12
.LFE0:
	.size	_pvPortMalloc, .-_pvPortMalloc
	.section	.text.vPortFree,code
	.align	2
	.global	_vPortFree	; export
	.type	_vPortFree,@function
_vPortFree:
.LFB1:
	.loc 1 131 0
	.set ___PA___,1
	.loc 1 139 0
	return	
	.set ___PA___,0
.LFE1:
	.size	_vPortFree, .-_vPortFree
	.section	.text.vPortInitialiseBlocks,code
	.align	2
	.global	_vPortInitialiseBlocks	; export
	.type	_vPortInitialiseBlocks,@function
_vPortInitialiseBlocks:
.LFB2:
	.loc 1 143 0
	.set ___PA___,1
	.loc 1 145 0
	clr	_xNextFreeByte
	.loc 1 146 0
	return	
	.set ___PA___,0
.LFE2:
	.size	_vPortInitialiseBlocks, .-_vPortInitialiseBlocks
	.section	.text.xPortGetFreeHeapSize,code
	.align	2
	.global	_xPortGetFreeHeapSize	; export
	.type	_xPortGetFreeHeapSize,@function
_xPortGetFreeHeapSize:
.LFB3:
	.loc 1 150 0
	.set ___PA___,1
	.loc 1 151 0
	mov	_xNextFreeByte,w0
	mov	#5118,w1
	sub	w1,w0,w0
	.loc 1 152 0
	return	
	.set ___PA___,0
.LFE3:
	.size	_xPortGetFreeHeapSize, .-_xPortGetFreeHeapSize
	.section	.nbss,bss,near
	.align	2
	.type	_xNextFreeByte,@object
	.size	_xNextFreeByte, 2
_xNextFreeByte:
	.skip	2
	.section	.bss,bss
	.type	_ucHeap,@object
	.size	_ucHeap, 5120
_ucHeap:
	.skip	5120
	.section	.nbss,bss,near
	.align	2
	.type	_pucAlignedHeap.17022,@object
	.size	_pucAlignedHeap.17022, 2
_pucAlignedHeap.17022:
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
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.byte	0x4
	.4byte	.LCFI0-.LFB0
	.byte	0x13
	.sleb128 -4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE0:
.LSFDE2:
	.4byte	.LEFDE2-.LASFDE2
.LASFDE2:
	.4byte	.Lframe0
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
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
	.section	.debug_info,info
	.4byte	0x33d
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.asciz	"GNU C 4.5.1 (XC16, Microchip v2.10) (B) Build date: Mar 27 2023"
	.byte	0x1
	.asciz	"../../../Source/portable/MemMang/heap_1.c"
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
	.uleb128 0x3
	.asciz	"size_t"
	.byte	0x2
	.byte	0xdd
	.4byte	0x162
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
	.uleb128 0x3
	.asciz	"uint8_t"
	.byte	0x2
	.byte	0xbb
	.4byte	0x1b4
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.asciz	"unsigned char"
	.uleb128 0x3
	.asciz	"uint16_t"
	.byte	0x2
	.byte	0xc1
	.4byte	0x162
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
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.asciz	"short int"
	.uleb128 0x5
	.byte	0x2
	.4byte	0x1a5
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.asciz	"char"
	.uleb128 0x6
	.byte	0x1
	.asciz	"pvPortMalloc"
	.byte	0x1
	.byte	0x47
	.byte	0x1
	.4byte	0x204
	.4byte	.LFB0
	.4byte	.LFE0
	.byte	0x1
	.byte	0x5f
	.4byte	0x289
	.uleb128 0x7
	.asciz	"xWantedSize"
	.byte	0x1
	.byte	0x47
	.4byte	0x154
	.byte	0x1
	.byte	0x59
	.uleb128 0x8
	.asciz	"pvReturn"
	.byte	0x1
	.byte	0x49
	.4byte	0x204
	.byte	0x1
	.byte	0x58
	.uleb128 0x8
	.asciz	"pucAlignedHeap"
	.byte	0x1
	.byte	0x4a
	.4byte	0x213
	.byte	0x5
	.byte	0x3
	.4byte	_pucAlignedHeap.17022
	.byte	0x0
	.uleb128 0x9
	.byte	0x1
	.asciz	"vPortFree"
	.byte	0x1
	.byte	0x82
	.byte	0x1
	.4byte	.LFB1
	.4byte	.LFE1
	.byte	0x1
	.byte	0x5f
	.4byte	0x2b3
	.uleb128 0x7
	.asciz	"pv"
	.byte	0x1
	.byte	0x82
	.4byte	0x204
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0xa
	.byte	0x1
	.asciz	"vPortInitialiseBlocks"
	.byte	0x1
	.byte	0x8e
	.byte	0x1
	.4byte	.LFB2
	.4byte	.LFE2
	.byte	0x1
	.byte	0x5f
	.uleb128 0xb
	.byte	0x1
	.asciz	"xPortGetFreeHeapSize"
	.byte	0x1
	.byte	0x95
	.byte	0x1
	.4byte	0x154
	.4byte	.LFB3
	.4byte	.LFE3
	.byte	0x1
	.byte	0x5f
	.uleb128 0xc
	.4byte	0x1a5
	.4byte	0x311
	.uleb128 0xd
	.4byte	0x162
	.2byte	0x13ff
	.byte	0x0
	.uleb128 0x8
	.asciz	"ucHeap"
	.byte	0x1
	.byte	0x3f
	.4byte	0x300
	.byte	0x5
	.byte	0x3
	.4byte	_ucHeap
	.uleb128 0x8
	.asciz	"xNextFreeByte"
	.byte	0x1
	.byte	0x43
	.4byte	0x154
	.byte	0x5
	.byte	0x3
	.4byte	_xNextFreeByte
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
	.uleb128 0xa
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
	.uleb128 0xb
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
	.uleb128 0xc
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xd
	.uleb128 0x21
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0x5
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.section	.debug_pubnames,info
	.4byte	0x60
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x341
	.4byte	0x221
	.asciz	"pvPortMalloc"
	.4byte	0x289
	.asciz	"vPortFree"
	.4byte	0x2b3
	.asciz	"vPortInitialiseBlocks"
	.4byte	0x2d8
	.asciz	"xPortGetFreeHeapSize"
	.4byte	0x0
	.section	.debug_pubtypes,info
	.4byte	0x32
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x341
	.4byte	0x154
	.asciz	"size_t"
	.4byte	0x1a5
	.asciz	"uint8_t"
	.4byte	0x1c5
	.asciz	"uint16_t"
	.4byte	0x0
	.section	.debug_aranges,info
	.4byte	0x2c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0x0
	.2byte	0x0
	.2byte	0x0
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
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
