	.file "C:\\REPOS\\Voltworks_Garage\\Firmware\\Projects\\RTOS_DEV.X\\ParTest.c"
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
	.file 1 "ParTest.c"
	.loc 1 42 0
	.set ___PA___,1
	.loc 1 44 0
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
	.loc 1 48 0
	.set ___PA___,1
	mov	w8,[w15++]
.LCFI0:
	mov	w0,w8
	.loc 1 49 0
	cp0	w1
	.set ___BP___,50
	bra	z,.L3
	.loc 1 52 0
	rcall	_vPortEnterCritical
	.loc 1 53 0
	sub	w8,#1,[w15]
	.set ___BP___,29
	bra	z,.L6
	.set ___BP___,50
	bra	ltu,.L5
	sub	w8,#2,[w15]
	.set ___BP___,71
	bra	nz,.L4
	bra	.L13
.L5:
	.loc 1 55 0
	bset.b	_LATCbits,#4
	.loc 1 56 0
	bra	.L4
.L6:
	.loc 1 58 0
	bset.b	_LATCbits,#5
	.loc 1 59 0
	bra	.L4
.L13:
	.loc 1 61 0
	bset.b	_LATCbits,#6
.L4:
	.loc 1 66 0
	rcall	_vPortExitCritical
	bra	.L2
.L3:
	.loc 1 71 0
	rcall	_vPortEnterCritical
	.loc 1 72 0
	sub	w8,#1,[w15]
	.set ___BP___,29
	bra	z,.L11
	.set ___BP___,50
	bra	ltu,.L10
	sub	w8,#2,[w15]
	.set ___BP___,71
	bra	nz,.L9
	bra	.L14
.L10:
	.loc 1 74 0
	bclr.b	_LATCbits,#4
	.loc 1 75 0
	bra	.L9
.L11:
	.loc 1 77 0
	bclr.b	_LATCbits,#5
	.loc 1 78 0
	bra	.L9
.L14:
	.loc 1 80 0
	bclr.b	_LATCbits,#6
.L9:
	.loc 1 85 0
	rcall	_vPortExitCritical
.L2:
	.loc 1 87 0
	mov	[--w15],w8
	return	
	.set ___PA___,0
.LFE1:
	.size	_vParTestSetLED, .-_vParTestSetLED
	.section	.text.vParTestToggleLED,code
	.align	2
	.global	_vParTestToggleLED	; export
	.type	_vParTestToggleLED,@function
_vParTestToggleLED:
.LFB2:
	.loc 1 91 0
	.set ___PA___,1
	mov	w8,[w15++]
.LCFI1:
	mov	w0,w8
	.loc 1 93 0
	rcall	_vPortEnterCritical
	.loc 1 94 0
	sub	w8,#1,[w15]
	.set ___BP___,29
	bra	z,.L18
	.set ___BP___,50
	bra	ltu,.L17
	sub	w8,#2,[w15]
	.set ___BP___,71
	bra	nz,.L16
	bra	.L20
.L17:
	.loc 1 96 0
	mov	_LATCbits,w0
	lsr	w0,#4,w0
	com	w0,w0
	and	w0,#1,w0
	sl	w0,#4,w0
	mov	_LATCbits,w1
	bclr	w1,#4
	ior	w0,w1,w1
	mov	w1,_LATCbits
	.loc 1 97 0
	bra	.L16
.L18:
	.loc 1 99 0
	mov	_LATCbits,w0
	lsr	w0,#5,w0
	com	w0,w0
	and	w0,#1,w0
	sl	w0,#5,w0
	mov	_LATCbits,w1
	bclr	w1,#5
	ior	w0,w1,w1
	mov	w1,_LATCbits
	.loc 1 100 0
	bra	.L16
.L20:
	.loc 1 102 0
	mov	_LATCbits,w0
	lsr	w0,#6,w0
	com	w0,w0
	and	w0,#1,w0
	sl	w0,#6,w0
	mov	_LATCbits,w1
	bclr	w1,#6
	ior	w0,w1,w1
	mov	w1,_LATCbits
.L16:
	.loc 1 107 0
	rcall	_vPortExitCritical
	.loc 1 108 0
	mov	[--w15],w8
	return	
	.set ___PA___,0
.LFE2:
	.size	_vParTestToggleLED, .-_vParTestToggleLED
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
	.file 2 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\dsPIC33E\\h/p33EV128GM106.h"
	.file 3 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h"
	.section	.debug_info,info
	.4byte	0x36e
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.asciz	"GNU C 4.5.1 (XC16, Microchip v2.10) (B) Build date: Mar 27 2023"
	.byte	0x1
	.asciz	"ParTest.c"
	.asciz	"C:\\REPOS\\Voltworks_Garage\\Firmware\\Projects\\RTOS_DEV.X"
	.4byte	.Ltext0
	.4byte	.Letext0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.byte	0x8
	.byte	0x4
	.asciz	"long double"
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.asciz	"signed char"
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
	.byte	0x8
	.asciz	"unsigned char"
	.uleb128 0x3
	.asciz	"uint16_t"
	.byte	0x3
	.byte	0xc1
	.4byte	0xfd
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.asciz	"unsigned int"
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.asciz	"long unsigned int"
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.asciz	"long long unsigned int"
	.uleb128 0x4
	.asciz	"tagLATCBITS"
	.byte	0x2
	.byte	0x2
	.2byte	0x1f6b
	.4byte	0x283
	.uleb128 0x5
	.asciz	"LATC0"
	.byte	0x2
	.2byte	0x1f6c
	.4byte	0xed
	.byte	0x2
	.byte	0x1
	.byte	0xf
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"LATC1"
	.byte	0x2
	.2byte	0x1f6d
	.4byte	0xed
	.byte	0x2
	.byte	0x1
	.byte	0xe
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"LATC2"
	.byte	0x2
	.2byte	0x1f6e
	.4byte	0xed
	.byte	0x2
	.byte	0x1
	.byte	0xd
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"LATC3"
	.byte	0x2
	.2byte	0x1f6f
	.4byte	0xed
	.byte	0x2
	.byte	0x1
	.byte	0xc
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"LATC4"
	.byte	0x2
	.2byte	0x1f70
	.4byte	0xed
	.byte	0x2
	.byte	0x1
	.byte	0xb
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"LATC5"
	.byte	0x2
	.2byte	0x1f71
	.4byte	0xed
	.byte	0x2
	.byte	0x1
	.byte	0xa
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"LATC6"
	.byte	0x2
	.2byte	0x1f72
	.4byte	0xed
	.byte	0x2
	.byte	0x1
	.byte	0x9
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"LATC7"
	.byte	0x2
	.2byte	0x1f73
	.4byte	0xed
	.byte	0x2
	.byte	0x1
	.byte	0x8
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"LATC8"
	.byte	0x2
	.2byte	0x1f74
	.4byte	0xed
	.byte	0x2
	.byte	0x1
	.byte	0x7
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"LATC9"
	.byte	0x2
	.2byte	0x1f75
	.4byte	0xed
	.byte	0x2
	.byte	0x1
	.byte	0x6
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"LATC10"
	.byte	0x2
	.2byte	0x1f76
	.4byte	0xed
	.byte	0x2
	.byte	0x1
	.byte	0x5
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"LATC11"
	.byte	0x2
	.2byte	0x1f77
	.4byte	0xed
	.byte	0x2
	.byte	0x1
	.byte	0x4
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"LATC12"
	.byte	0x2
	.2byte	0x1f78
	.4byte	0xed
	.byte	0x2
	.byte	0x1
	.byte	0x3
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"LATC13"
	.byte	0x2
	.2byte	0x1f79
	.4byte	0xed
	.byte	0x2
	.byte	0x1
	.byte	0x2
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"LATC15"
	.byte	0x2
	.2byte	0x1f7b
	.4byte	0xed
	.byte	0x2
	.byte	0x1
	.byte	0x0
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.byte	0x0
	.uleb128 0x6
	.asciz	"LATCBITS"
	.byte	0x2
	.2byte	0x1f7c
	.4byte	0x13c
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.asciz	"short unsigned int"
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.asciz	"short int"
	.uleb128 0x7
	.byte	0x1
	.asciz	"vParTestInitialise"
	.byte	0x1
	.byte	0x29
	.byte	0x1
	.4byte	.LFB0
	.4byte	.LFE0
	.byte	0x1
	.byte	0x5f
	.uleb128 0x8
	.byte	0x1
	.asciz	"vParTestSetLED"
	.byte	0x1
	.byte	0x2f
	.byte	0x1
	.4byte	.LFB1
	.4byte	.LFE1
	.byte	0x1
	.byte	0x5f
	.4byte	0x31b
	.uleb128 0x9
	.asciz	"uxLED"
	.byte	0x1
	.byte	0x2f
	.4byte	0x294
	.byte	0x1
	.byte	0x58
	.uleb128 0x9
	.asciz	"xValue"
	.byte	0x1
	.byte	0x2f
	.4byte	0x2aa
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.uleb128 0x8
	.byte	0x1
	.asciz	"vParTestToggleLED"
	.byte	0x1
	.byte	0x5a
	.byte	0x1
	.4byte	.LFB2
	.4byte	.LFE2
	.byte	0x1
	.byte	0x5f
	.4byte	0x350
	.uleb128 0x9
	.asciz	"uxLED"
	.byte	0x1
	.byte	0x5a
	.4byte	0x294
	.byte	0x1
	.byte	0x58
	.byte	0x0
	.uleb128 0xa
	.4byte	.LASF0
	.byte	0x2
	.2byte	0x1f7d
	.4byte	0x35e
	.byte	0x1
	.byte	0x1
	.uleb128 0xb
	.4byte	0x283
	.uleb128 0xa
	.4byte	.LASF0
	.byte	0x2
	.2byte	0x1f7d
	.4byte	0x35e
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
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x5
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0xd
	.uleb128 0xb
	.uleb128 0xc
	.uleb128 0xb
	.uleb128 0x38
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x6
	.uleb128 0x16
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x7
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
	.uleb128 0x8
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
	.uleb128 0x9
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
	.uleb128 0xa
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
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
	.uleb128 0xb
	.uleb128 0x35
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.section	.debug_pubnames,info
	.4byte	0x4e
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x372
	.4byte	0x2b7
	.asciz	"vParTestInitialise"
	.4byte	0x2d9
	.asciz	"vParTestSetLED"
	.4byte	0x31b
	.asciz	"vParTestToggleLED"
	.4byte	0x0
	.section	.debug_pubtypes,info
	.4byte	0x38
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x372
	.4byte	0xed
	.asciz	"uint16_t"
	.4byte	0x13c
	.asciz	"tagLATCBITS"
	.4byte	0x283
	.asciz	"LATCBITS"
	.4byte	0x0
	.section	.debug_aranges,info
	.4byte	0x24
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0x0
	.2byte	0x0
	.2byte	0x0
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.4byte	0x0
	.4byte	0x0
	.section	.debug_str,info
.LASF0:
	.asciz	"LATCbits"
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
