	.file "C:\\Users\\zachl\\Downloads\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo\\Demo\\dspic33e-freertos-demo\\dspic33e-freertos-demo.X\\..\\ParTest\\ParTest.c"
	.section	.debug_abbrev,info
.Ldebug_abbrev0:
	.section	.debug_info,info
.Ldebug_info0:
	.section	.debug_line,info
.Ldebug_line0:
	.section	.text,code
.Ltext0:
	.section	.text.vParTestInitialise,code
	.align	2
	.global	_vParTestInitialise	; export
	.type	_vParTestInitialise,@function
_vParTestInitialise:
.LFB0:
	.file 1 "../ParTest/ParTest.c"
	.loc 1 43 0
	.set ___PA___,1
	.loc 1 51 0
	clr	_TRISA
	.loc 1 52 0
	clr	_PORTA
	.loc 1 53 0
	clr	_uxOutput
	.loc 1 54 0
	return	
	.set ___PA___,0
.LFE0:
	.size	_vParTestInitialise, .-_vParTestInitialise
	.section	.text.vParTestSetLED,code
	.align	2
	.global	_vParTestSetLED	; export
	.type	_vParTestSetLED,@function
_vParTestSetLED:
.LFB1:
	.loc 1 58 0
	.set ___PA___,1
	mov	w8,[w15++]
.LCFI0:
	.loc 1 62 0
	mov	#1,w8
	sl	w8,w0,w8
	.loc 1 64 0
	cp0	w1
	.set ___BP___,39
	bra	nz,.L8
	.loc 1 77 0
	rcall	_vPortEnterCritical
	.loc 1 79 0
	com	w8,w8
	mov	_uxOutput,w0
	and	w0,w8,w8
	mov	w8,_uxOutput
	.loc 1 80 0
	mov	w8,_PORTA
	.loc 1 82 0
	rcall	_vPortExitCritical
	.loc 1 84 0
	mov	[--w15],w8
	return	
.L9:
	.set ___PA___,0
.L8:
	.loc 1 67 0
	rcall	_vPortEnterCritical
	.loc 1 69 0
	mov	_uxOutput,w1
	ior	w1,w8,w0
	mov	w0,_uxOutput
	.loc 1 70 0
	mov	w0,_PORTA
	.loc 1 72 0
	rcall	_vPortExitCritical
	.loc 1 84 0
	mov	[--w15],w8
	return	
	bra	.L9
.LFE1:
	.size	_vParTestSetLED, .-_vParTestSetLED
	.section	.text.vParTestToggleLED,code
	.align	2
	.global	_vParTestToggleLED	; export
	.type	_vParTestToggleLED,@function
_vParTestToggleLED:
.LFB2:
	.loc 1 88 0
	.set ___PA___,1
	mov	w8,[w15++]
.LCFI1:
	.loc 1 91 0
	mov	#1,w8
	sl	w8,w0,w8
	.loc 1 92 0
	rcall	_vPortEnterCritical
	.loc 1 96 0
	mov	_uxOutput,w1
	and	w8,w1,w0
	.set ___BP___,39
	bra	nz,.L15
	.loc 1 103 0
	ior	w1,w8,w1
	mov	w1,_uxOutput
	.loc 1 104 0
	mov	w1,_PORTA
	.loc 1 107 0
	rcall	_vPortExitCritical
	.loc 1 108 0
	mov	[--w15],w8
	return	
.L16:
	.set ___PA___,0
.L15:
	.loc 1 98 0
	com	w8,w8
	and	w8,w1,w1
	mov	w1,_uxOutput
	.loc 1 99 0
	mov	w1,_PORTA
	.loc 1 107 0
	rcall	_vPortExitCritical
	.loc 1 108 0
	mov	[--w15],w8
	return	
	bra	.L16
.LFE2:
	.size	_vParTestToggleLED, .-_vParTestToggleLED
	.section	.nbss,bss,near
	.type	_uxOutput,@object
	.size	_uxOutput, 2
	.global	_uxOutput
	.align	2
_uxOutput:	.space	2
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
	.align	4
.LEFDE0:
.LSFDE2:
	.4byte	.LEFDE2-.LASFDE2
.LASFDE2:
	.4byte	.Lframe0
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.byte	0x4
	.4byte	.LCFI0-.LFB1
	.byte	0x13
	.sleb128 -3
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE2:
.LSFDE4:
	.4byte	.LEFDE4-.LASFDE4
.LASFDE4:
	.4byte	.Lframe0
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.byte	0x4
	.4byte	.LCFI1-.LFB2
	.byte	0x13
	.sleb128 -3
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE4:
	.section	.text,code
.Letext0:
	.file 2 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33E-GM-GP-MC-GU-MU_DFP/1.5.258/xc16/bin/..\\support\\dsPIC33E\\h/p33EP512MU810.h"
	.file 3 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h"
	.section	.debug_info,info
	.4byte	0x2f3
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.asciz	"GNU C 4.5.1 (XC16, Microchip v2.10) (B) Build date: Mar 27 2023"
	.byte	0x1
	.asciz	"../ParTest/ParTest.c"
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
	.byte	0x1
	.byte	0x6
	.asciz	"signed char"
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
	.byte	0x8
	.asciz	"unsigned char"
	.uleb128 0x3
	.asciz	"uint16_t"
	.byte	0x3
	.byte	0xc1
	.4byte	0x13f
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
	.byte	0x5
	.asciz	"short int"
	.uleb128 0x4
	.byte	0x1
	.asciz	"vParTestInitialise"
	.byte	0x1
	.byte	0x2a
	.byte	0x1
	.4byte	.LFB0
	.4byte	.LFE0
	.byte	0x1
	.byte	0x5f
	.uleb128 0x5
	.byte	0x1
	.asciz	"vParTestSetLED"
	.byte	0x1
	.byte	0x39
	.byte	0x1
	.4byte	.LFB1
	.4byte	.LFE1
	.byte	0x1
	.byte	0x5f
	.4byte	0x250
	.uleb128 0x6
	.asciz	"uxLED"
	.byte	0x1
	.byte	0x39
	.4byte	0x129
	.byte	0x1
	.byte	0x50
	.uleb128 0x6
	.asciz	"xValue"
	.byte	0x1
	.byte	0x39
	.4byte	0x1d2
	.byte	0x1
	.byte	0x51
	.uleb128 0x7
	.4byte	.LASF0
	.byte	0x1
	.byte	0x3b
	.4byte	0x129
	.byte	0x1
	.byte	0x58
	.byte	0x0
	.uleb128 0x5
	.byte	0x1
	.asciz	"vParTestToggleLED"
	.byte	0x1
	.byte	0x57
	.byte	0x1
	.4byte	.LFB2
	.4byte	.LFE2
	.byte	0x1
	.byte	0x5f
	.4byte	0x292
	.uleb128 0x6
	.asciz	"uxLED"
	.byte	0x1
	.byte	0x57
	.4byte	0x129
	.byte	0x1
	.byte	0x50
	.uleb128 0x7
	.4byte	.LASF0
	.byte	0x1
	.byte	0x59
	.4byte	0x129
	.byte	0x1
	.byte	0x58
	.byte	0x0
	.uleb128 0x8
	.asciz	"TRISA"
	.byte	0x2
	.2byte	0x3cee
	.4byte	0x2a2
	.byte	0x1
	.byte	0x1
	.uleb128 0x9
	.4byte	0x193
	.uleb128 0x8
	.asciz	"PORTA"
	.byte	0x2
	.2byte	0x3d02
	.4byte	0x2a2
	.byte	0x1
	.byte	0x1
	.uleb128 0xa
	.4byte	.LASF1
	.byte	0x1
	.byte	0x24
	.4byte	0x129
	.byte	0x1
	.byte	0x1
	.uleb128 0x8
	.asciz	"TRISA"
	.byte	0x2
	.2byte	0x3cee
	.4byte	0x2a2
	.byte	0x1
	.byte	0x1
	.uleb128 0x8
	.asciz	"PORTA"
	.byte	0x2
	.2byte	0x3d02
	.4byte	0x2a2
	.byte	0x1
	.byte	0x1
	.uleb128 0xb
	.4byte	.LASF1
	.byte	0x1
	.byte	0x24
	.4byte	0x129
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_uxOutput
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
	.uleb128 0x5
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
	.uleb128 0x6
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
	.uleb128 0x7
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
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0x0
	.byte	0x0
	.uleb128 0x9
	.uleb128 0x35
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xa
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
	.uleb128 0xb
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
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.section	.debug_pubnames,info
	.4byte	0x5b
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x2f7
	.4byte	0x1df
	.asciz	"vParTestInitialise"
	.4byte	0x201
	.asciz	"vParTestSetLED"
	.4byte	0x250
	.asciz	"vParTestToggleLED"
	.4byte	0x2e4
	.asciz	"uxOutput"
	.4byte	0x0
	.section	.debug_pubtypes,info
	.4byte	0x1b
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x2f7
	.4byte	0x193
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
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.4byte	0x0
	.4byte	0x0
	.section	.debug_str,info
.LASF1:
	.asciz	"uxOutput"
.LASF0:
	.asciz	"uxLEDBit"
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
