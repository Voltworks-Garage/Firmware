	.file "C:\\REPOS\\Voltworks_Garage\\Firmware\\Projects\\RTOS_DEV.X\\mcc_generated_files\\reset.c"
	.section	.debug_abbrev,info
.Ldebug_abbrev0:
	.section	.debug_info,info
.Ldebug_info0:
	.section	.debug_line,info
.Ldebug_line0:
	.section	.text,code
.Ltext0:
	.section	.text.RESET_CauseFromTrap,code
	.align	2
	.type	_RESET_CauseFromTrap,@function
_RESET_CauseFromTrap:
.LFB2:
	.file 1 "mcc_generated_files/reset.c"
	.loc 1 106 0
	.set ___PA___,1
	.loc 1 105 0
	lsr	w0,#15,w0
	.loc 1 113 0
	return	
	.set ___PA___,0
.LFE2:
	.size	_RESET_CauseFromTrap, .-_RESET_CauseFromTrap
	.section	.text.RESET_CauseFromIllegalOpcode,code
	.align	2
	.type	_RESET_CauseFromIllegalOpcode,@function
_RESET_CauseFromIllegalOpcode:
.LFB3:
	.loc 1 116 0
	.set ___PA___,1
	.loc 1 115 0
	mov	#16384,w1
	and	w0,w1,w0
	neg	w0,w0
	lsr	w0,#15,w0
	.loc 1 123 0
	return	
	.set ___PA___,0
.LFE3:
	.size	_RESET_CauseFromIllegalOpcode, .-_RESET_CauseFromIllegalOpcode
	.section	.text.RESET_CauseFromConfigurationMismatch,code
	.align	2
	.type	_RESET_CauseFromConfigurationMismatch,@function
_RESET_CauseFromConfigurationMismatch:
.LFB4:
	.loc 1 126 0
	.set ___PA___,1
	.loc 1 125 0
	lsr	w0,#9,w0
	and	w0,#1,w0
	.loc 1 133 0
	return	
	.set ___PA___,0
.LFE4:
	.size	_RESET_CauseFromConfigurationMismatch, .-_RESET_CauseFromConfigurationMismatch
	.section	.text.RESET_CauseFromExternal,code
	.align	2
	.type	_RESET_CauseFromExternal,@function
_RESET_CauseFromExternal:
.LFB5:
	.loc 1 136 0
	.set ___PA___,1
	.loc 1 135 0
	lsr	w0,#7,w0
	and	w0,#1,w0
	.loc 1 143 0
	return	
	.set ___PA___,0
.LFE5:
	.size	_RESET_CauseFromExternal, .-_RESET_CauseFromExternal
	.section	.text.RESET_CauseFromSoftware,code
	.align	2
	.type	_RESET_CauseFromSoftware,@function
_RESET_CauseFromSoftware:
.LFB6:
	.loc 1 146 0
	.set ___PA___,1
	.loc 1 145 0
	lsr	w0,#6,w0
	and	w0,#1,w0
	.loc 1 153 0
	return	
	.set ___PA___,0
.LFE6:
	.size	_RESET_CauseFromSoftware, .-_RESET_CauseFromSoftware
	.section	.text.RESET_CauseFromWatchdogTimer,code
	.align	2
	.type	_RESET_CauseFromWatchdogTimer,@function
_RESET_CauseFromWatchdogTimer:
.LFB7:
	.loc 1 156 0
	.set ___PA___,1
	.loc 1 155 0
	lsr	w0,#4,w0
	and	w0,#1,w0
	.loc 1 163 0
	return	
	.set ___PA___,0
.LFE7:
	.size	_RESET_CauseFromWatchdogTimer, .-_RESET_CauseFromWatchdogTimer
	.section	.text.RESET_CauseClear,code
	.align	2
	.type	_RESET_CauseClear,@function
_RESET_CauseClear:
.LFB8:
	.loc 1 166 0
	.set ___PA___,1
	.loc 1 167 0
	com	w0,w0
	and	_RCON,WREG
	mov	w0,_RCON
	.loc 1 168 0
	return	
	.set ___PA___,0
.LFE8:
	.size	_RESET_CauseClear, .-_RESET_CauseClear
	.section	.text.RESET_GetCause,code
	.align	2
	.global	_RESET_GetCause	; export
	.type	_RESET_GetCause,@function
_RESET_GetCause:
.LFB0:
	.loc 1 66 0
	.set ___PA___,1
	.loc 1 67 0
	mov	_RCON,w0
	.loc 1 68 0
	return	
	.set ___PA___,0
.LFE0:
	.size	_RESET_GetCause, .-_RESET_GetCause
	.section	.text.RESET_CauseHandler,code
	.align	2
	.weak	_RESET_CauseHandler
	.type	_RESET_CauseHandler,@function
_RESET_CauseHandler:
.LFB1:
	.loc 1 71 0
	.set ___PA___,1
	mov	w8,[w15++]
.LCFI0:
	.loc 1 72 0
	rcall	_RESET_GetCause
	mov	w0,w8
	.loc 1 73 0
	mov	w8,w0
	rcall	_RESET_CauseFromTrap
	cp0.b	w0
	.set ___BP___,71
	bra	z,.L10
	.loc 1 75 0
	mov	#-32768,w0
	rcall	_RESET_CauseClear
.L10:
	.loc 1 78 0
	mov	w8,w0
	rcall	_RESET_CauseFromIllegalOpcode
	cp0.b	w0
	.set ___BP___,71
	bra	z,.L11
	.loc 1 80 0
	mov	#16384,w0
	rcall	_RESET_CauseClear
.L11:
	.loc 1 83 0
	mov	w8,w0
	rcall	_RESET_CauseFromConfigurationMismatch
	cp0.b	w0
	.set ___BP___,71
	bra	z,.L12
	.loc 1 85 0
	mov	#512,w0
	rcall	_RESET_CauseClear
.L12:
	.loc 1 88 0
	mov	w8,w0
	rcall	_RESET_CauseFromExternal
	cp0.b	w0
	.set ___BP___,71
	bra	z,.L13
	.loc 1 90 0
	mov	#128,w0
	rcall	_RESET_CauseClear
.L13:
	.loc 1 93 0
	mov	w8,w0
	rcall	_RESET_CauseFromSoftware
	cp0.b	w0
	.set ___BP___,71
	bra	z,.L14
	.loc 1 95 0
	mov	#64,w0
	rcall	_RESET_CauseClear
.L14:
	.loc 1 98 0
	mov	w8,w0
	rcall	_RESET_CauseFromWatchdogTimer
	cp0.b	w0
	.set ___BP___,61
	bra	z,.L9
	.loc 1 100 0
	mov	#16,w0
	rcall	_RESET_CauseClear
.L9:
	.loc 1 103 0
	mov	[--w15],w8
	return	
	.set ___PA___,0
.LFE1:
	.size	_RESET_CauseHandler, .-_RESET_CauseHandler
	.section	.text.RESET_CauseClearAll,code
	.align	2
	.global	_RESET_CauseClearAll	; export
	.type	_RESET_CauseClearAll,@function
_RESET_CauseClearAll:
.LFB9:
	.loc 1 171 0
	.set ___PA___,1
	.loc 1 172 0
	clr	_RCON
	.loc 1 173 0
	return	
	.set ___PA___,0
.LFE9:
	.size	_RESET_CauseClearAll, .-_RESET_CauseClearAll
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
	.align	4
.LEFDE0:
.LSFDE2:
	.4byte	.LEFDE2-.LASFDE2
.LASFDE2:
	.4byte	.Lframe0
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.align	4
.LEFDE2:
.LSFDE4:
	.4byte	.LEFDE4-.LASFDE4
.LASFDE4:
	.4byte	.Lframe0
	.4byte	.LFB4
	.4byte	.LFE4-.LFB4
	.align	4
.LEFDE4:
.LSFDE6:
	.4byte	.LEFDE6-.LASFDE6
.LASFDE6:
	.4byte	.Lframe0
	.4byte	.LFB5
	.4byte	.LFE5-.LFB5
	.align	4
.LEFDE6:
.LSFDE8:
	.4byte	.LEFDE8-.LASFDE8
.LASFDE8:
	.4byte	.Lframe0
	.4byte	.LFB6
	.4byte	.LFE6-.LFB6
	.align	4
.LEFDE8:
.LSFDE10:
	.4byte	.LEFDE10-.LASFDE10
.LASFDE10:
	.4byte	.Lframe0
	.4byte	.LFB7
	.4byte	.LFE7-.LFB7
	.align	4
.LEFDE10:
.LSFDE12:
	.4byte	.LEFDE12-.LASFDE12
.LASFDE12:
	.4byte	.Lframe0
	.4byte	.LFB8
	.4byte	.LFE8-.LFB8
	.align	4
.LEFDE12:
.LSFDE14:
	.4byte	.LEFDE14-.LASFDE14
.LASFDE14:
	.4byte	.Lframe0
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.align	4
.LEFDE14:
.LSFDE16:
	.4byte	.LEFDE16-.LASFDE16
.LASFDE16:
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
.LEFDE16:
.LSFDE18:
	.4byte	.LEFDE18-.LASFDE18
.LASFDE18:
	.4byte	.Lframe0
	.4byte	.LFB9
	.4byte	.LFE9-.LFB9
	.align	4
.LEFDE18:
	.section	.text,code
.Letext0:
	.file 2 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h"
	.file 3 "mcc_generated_files/reset_types.h"
	.file 4 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\dsPIC33E\\h/p33EV128GM106.h"
	.section	.debug_info,info
	.4byte	0x485
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.asciz	"GNU C 4.5.1 (XC16, Microchip v2.10) (B) Build date: Mar 27 2023"
	.byte	0x1
	.asciz	"mcc_generated_files/reset.c"
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
	.byte	0x2
	.byte	0xc1
	.4byte	0x10f
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
	.asciz	"tagRESET_MASKS"
	.byte	0x2
	.byte	0x3
	.byte	0x4d
	.4byte	0x1d9
	.uleb128 0x5
	.asciz	"RESET_MASK_WDTO"
	.sleb128 16
	.uleb128 0x5
	.asciz	"RESET_MASK_SWR"
	.sleb128 64
	.uleb128 0x5
	.asciz	"RESET_MASK_EXTR"
	.sleb128 128
	.uleb128 0x5
	.asciz	"RESET_MASK_CM"
	.sleb128 512
	.uleb128 0x5
	.asciz	"RESET_MASK_IOPUWR"
	.sleb128 16384
	.uleb128 0x5
	.asciz	"RESET_MASK_TRAPR"
	.sleb128 32768
	.byte	0x0
	.uleb128 0x3
	.asciz	"RESET_MASKS"
	.byte	0x3
	.byte	0x55
	.4byte	0x14e
	.uleb128 0x6
	.asciz	"RESET_CauseFromTrap"
	.byte	0x1
	.byte	0x69
	.byte	0x1
	.4byte	0x22f
	.4byte	.LFB2
	.4byte	.LFE2
	.byte	0x1
	.byte	0x5f
	.4byte	0x22f
	.uleb128 0x7
	.4byte	.LASF0
	.byte	0x1
	.byte	0x69
	.4byte	0xff
	.byte	0x1
	.byte	0x50
	.uleb128 0x8
	.4byte	.LASF1
	.byte	0x1
	.byte	0x6b
	.4byte	0x22f
	.byte	0x0
	.uleb128 0x2
	.byte	0x1
	.byte	0x2
	.asciz	"_Bool"
	.uleb128 0x6
	.asciz	"RESET_CauseFromIllegalOpcode"
	.byte	0x1
	.byte	0x73
	.byte	0x1
	.4byte	0x22f
	.4byte	.LFB3
	.4byte	.LFE3
	.byte	0x1
	.byte	0x5f
	.4byte	0x284
	.uleb128 0x7
	.4byte	.LASF0
	.byte	0x1
	.byte	0x73
	.4byte	0xff
	.byte	0x1
	.byte	0x50
	.uleb128 0x8
	.4byte	.LASF1
	.byte	0x1
	.byte	0x75
	.4byte	0x22f
	.byte	0x0
	.uleb128 0x6
	.asciz	"RESET_CauseFromConfigurationMismatch"
	.byte	0x1
	.byte	0x7d
	.byte	0x1
	.4byte	0x22f
	.4byte	.LFB4
	.4byte	.LFE4
	.byte	0x1
	.byte	0x5f
	.4byte	0x2d8
	.uleb128 0x7
	.4byte	.LASF0
	.byte	0x1
	.byte	0x7d
	.4byte	0xff
	.byte	0x1
	.byte	0x50
	.uleb128 0x8
	.4byte	.LASF1
	.byte	0x1
	.byte	0x7f
	.4byte	0x22f
	.byte	0x0
	.uleb128 0x6
	.asciz	"RESET_CauseFromExternal"
	.byte	0x1
	.byte	0x87
	.byte	0x1
	.4byte	0x22f
	.4byte	.LFB5
	.4byte	.LFE5
	.byte	0x1
	.byte	0x5f
	.4byte	0x31f
	.uleb128 0x7
	.4byte	.LASF0
	.byte	0x1
	.byte	0x87
	.4byte	0xff
	.byte	0x1
	.byte	0x50
	.uleb128 0x8
	.4byte	.LASF1
	.byte	0x1
	.byte	0x89
	.4byte	0x22f
	.byte	0x0
	.uleb128 0x6
	.asciz	"RESET_CauseFromSoftware"
	.byte	0x1
	.byte	0x91
	.byte	0x1
	.4byte	0x22f
	.4byte	.LFB6
	.4byte	.LFE6
	.byte	0x1
	.byte	0x5f
	.4byte	0x366
	.uleb128 0x7
	.4byte	.LASF0
	.byte	0x1
	.byte	0x91
	.4byte	0xff
	.byte	0x1
	.byte	0x50
	.uleb128 0x8
	.4byte	.LASF1
	.byte	0x1
	.byte	0x93
	.4byte	0x22f
	.byte	0x0
	.uleb128 0x6
	.asciz	"RESET_CauseFromWatchdogTimer"
	.byte	0x1
	.byte	0x9b
	.byte	0x1
	.4byte	0x22f
	.4byte	.LFB7
	.4byte	.LFE7
	.byte	0x1
	.byte	0x5f
	.4byte	0x3b2
	.uleb128 0x7
	.4byte	.LASF0
	.byte	0x1
	.byte	0x9b
	.4byte	0xff
	.byte	0x1
	.byte	0x50
	.uleb128 0x8
	.4byte	.LASF1
	.byte	0x1
	.byte	0x9d
	.4byte	0x22f
	.byte	0x0
	.uleb128 0x9
	.asciz	"RESET_CauseClear"
	.byte	0x1
	.byte	0xa5
	.byte	0x1
	.4byte	.LFB8
	.4byte	.LFE8
	.byte	0x1
	.byte	0x5f
	.4byte	0x3ed
	.uleb128 0xa
	.asciz	"resetFlagMask"
	.byte	0x1
	.byte	0xa5
	.4byte	0x1d9
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0xb
	.byte	0x1
	.asciz	"RESET_GetCause"
	.byte	0x1
	.byte	0x41
	.byte	0x1
	.4byte	0xff
	.4byte	.LFB0
	.4byte	.LFE0
	.byte	0x1
	.byte	0x5f
	.uleb128 0xc
	.byte	0x1
	.asciz	"RESET_CauseHandler"
	.byte	0x1
	.byte	0x46
	.byte	0x1
	.4byte	.LFB1
	.4byte	.LFE1
	.byte	0x1
	.byte	0x5f
	.4byte	0x443
	.uleb128 0xd
	.4byte	.LASF0
	.byte	0x1
	.byte	0x48
	.4byte	0xff
	.byte	0x1
	.byte	0x58
	.byte	0x0
	.uleb128 0xe
	.byte	0x1
	.asciz	"RESET_CauseClearAll"
	.byte	0x1
	.byte	0xaa
	.4byte	.LFB9
	.4byte	.LFE9
	.byte	0x1
	.byte	0x5f
	.uleb128 0xf
	.asciz	"RCON"
	.byte	0x4
	.2byte	0x111c
	.4byte	0x474
	.byte	0x1
	.byte	0x1
	.uleb128 0x10
	.4byte	0xff
	.uleb128 0xf
	.asciz	"RCON"
	.byte	0x4
	.2byte	0x111c
	.4byte	0x474
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
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
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
	.uleb128 0x5
	.uleb128 0x28
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1c
	.uleb128 0xd
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
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x9
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
	.uleb128 0xa
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
	.uleb128 0xe
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
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
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
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0x0
	.byte	0x0
	.uleb128 0x10
	.uleb128 0x35
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.section	.debug_pubnames,info
	.4byte	0x50
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x489
	.4byte	0x3ed
	.asciz	"RESET_GetCause"
	.4byte	0x40f
	.asciz	"RESET_CauseHandler"
	.4byte	0x443
	.asciz	"RESET_CauseClearAll"
	.4byte	0x0
	.section	.debug_pubtypes,info
	.4byte	0x3e
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x489
	.4byte	0xff
	.asciz	"uint16_t"
	.4byte	0x14e
	.asciz	"tagRESET_MASKS"
	.4byte	0x1d9
	.asciz	"RESET_MASKS"
	.4byte	0x0
	.section	.debug_aranges,info
	.4byte	0x34
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0x0
	.2byte	0x0
	.2byte	0x0
	.4byte	.LFB8
	.4byte	.LFE8-.LFB8
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.4byte	.LFB9
	.4byte	.LFE9-.LFB9
	.4byte	0x0
	.4byte	0x0
	.section	.debug_str,info
.LASF0:
	.asciz	"resetCause"
.LASF1:
	.asciz	"resetStatus"
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
