	.file "C:\\REPOS\\Voltworks_Garage\\Firmware\\Projects\\RTOS_DEV.X\\mcc_generated_files\\system.c"
	.section	.debug_abbrev,info
.Ldebug_abbrev0:
	.section	.debug_info,info
.Ldebug_info0:
	.section	.debug_line,info
.Ldebug_line0:
	.section	.text,code
.Ltext0:
	.section	.text.SYSTEM_CORCONModeOperatingSet,code
	.align	2
	.type	_SYSTEM_CORCONModeOperatingSet,@function
_SYSTEM_CORCONModeOperatingSet:
.LFB1:
	.file 1 "mcc_generated_files/system.h"
	.loc 1 77 0
	.set ___PA___,1
	.loc 1 78 0
	mov	#242,w1
	mov	_CORCON,w2
	and	w1,w2,w1
	ior	w1,w0,w1
	mov	w1,_CORCON
	.loc 1 79 0
	return	
	.set ___PA___,0
.LFE1:
	.size	_SYSTEM_CORCONModeOperatingSet, .-_SYSTEM_CORCONModeOperatingSet
	.section	.text.INTERRUPT_GlobalEnable,code
	.align	2
	.type	_INTERRUPT_GlobalEnable,@function
_INTERRUPT_GlobalEnable:
.LFB5:
	.file 2 "mcc_generated_files/interrupt_manager.h"
	.loc 2 104 0
	.set ___PA___,1
	.loc 2 105 0
	bset	_INTCON2,#15
	nop
	nop	
	.loc 2 106 0
	return	
	.set ___PA___,0
.LFE5:
	.size	_INTERRUPT_GlobalEnable, .-_INTERRUPT_GlobalEnable
	.section	.text.SYSTEM_Initialize,code
	.align	2
	.global	_SYSTEM_Initialize	; export
	.type	_SYSTEM_Initialize,@function
_SYSTEM_Initialize:
.LFB8:
	.file 3 "mcc_generated_files/system.c"
	.loc 3 115 0
	.set ___PA___,1
	.loc 3 116 0
	rcall	_PIN_MANAGER_Initialize
	.loc 3 117 0
	rcall	_INTERRUPT_Initialize
	.loc 3 118 0
	rcall	_CLOCK_Initialize
	.loc 3 119 0
	rcall	_INTERRUPT_GlobalEnable
	.loc 3 120 0
	mov	#32,w0
	rcall	_SYSTEM_CORCONModeOperatingSet
	.loc 3 121 0
	return	
	.set ___PA___,0
.LFE8:
	.size	_SYSTEM_Initialize, .-_SYSTEM_Initialize
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
	.align	4
.LEFDE0:
.LSFDE2:
	.4byte	.LEFDE2-.LASFDE2
.LASFDE2:
	.4byte	.Lframe0
	.4byte	.LFB5
	.4byte	.LFE5-.LFB5
	.align	4
.LEFDE2:
.LSFDE4:
	.4byte	.LEFDE4-.LASFDE4
.LASFDE4:
	.4byte	.Lframe0
	.4byte	.LFB8
	.4byte	.LFE8-.LFB8
	.align	4
.LEFDE4:
	.section	.text,code
.Letext0:
	.file 4 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\dsPIC33E\\h/p33EV128GM106.h"
	.file 5 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h"
	.file 6 "mcc_generated_files/system_types.h"
	.section	.debug_info,info
	.4byte	0x4f8
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.asciz	"GNU C 4.5.1 (XC16, Microchip v2.10) (B) Build date: Mar 27 2023"
	.byte	0x1
	.asciz	"mcc_generated_files/system.c"
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
	.byte	0x5
	.byte	0xc1
	.4byte	0x110
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
	.byte	0x2
	.byte	0x4
	.2byte	0x15a7
	.4byte	0x180
	.uleb128 0x5
	.asciz	"VECNUM"
	.byte	0x4
	.2byte	0x15a8
	.4byte	0x100
	.byte	0x2
	.byte	0x8
	.byte	0x8
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"ILR"
	.byte	0x4
	.2byte	0x15a9
	.4byte	0x100
	.byte	0x2
	.byte	0x4
	.byte	0x4
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.byte	0x0
	.uleb128 0x4
	.byte	0x2
	.byte	0x4
	.2byte	0x15ab
	.4byte	0x286
	.uleb128 0x5
	.asciz	"VECNUM0"
	.byte	0x4
	.2byte	0x15ac
	.4byte	0x100
	.byte	0x2
	.byte	0x1
	.byte	0xf
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"VECNUM1"
	.byte	0x4
	.2byte	0x15ad
	.4byte	0x100
	.byte	0x2
	.byte	0x1
	.byte	0xe
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"VECNUM2"
	.byte	0x4
	.2byte	0x15ae
	.4byte	0x100
	.byte	0x2
	.byte	0x1
	.byte	0xd
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"VECNUM3"
	.byte	0x4
	.2byte	0x15af
	.4byte	0x100
	.byte	0x2
	.byte	0x1
	.byte	0xc
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"VECNUM4"
	.byte	0x4
	.2byte	0x15b0
	.4byte	0x100
	.byte	0x2
	.byte	0x1
	.byte	0xb
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"VECNUM5"
	.byte	0x4
	.2byte	0x15b1
	.4byte	0x100
	.byte	0x2
	.byte	0x1
	.byte	0xa
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"VECNUM6"
	.byte	0x4
	.2byte	0x15b2
	.4byte	0x100
	.byte	0x2
	.byte	0x1
	.byte	0x9
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"VECNUM7"
	.byte	0x4
	.2byte	0x15b3
	.4byte	0x100
	.byte	0x2
	.byte	0x1
	.byte	0x8
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"ILR0"
	.byte	0x4
	.2byte	0x15b4
	.4byte	0x100
	.byte	0x2
	.byte	0x1
	.byte	0x7
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"ILR1"
	.byte	0x4
	.2byte	0x15b5
	.4byte	0x100
	.byte	0x2
	.byte	0x1
	.byte	0x6
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"ILR2"
	.byte	0x4
	.2byte	0x15b6
	.4byte	0x100
	.byte	0x2
	.byte	0x1
	.byte	0x5
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"ILR3"
	.byte	0x4
	.2byte	0x15b7
	.4byte	0x100
	.byte	0x2
	.byte	0x1
	.byte	0x4
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.byte	0x0
	.uleb128 0x6
	.byte	0x2
	.byte	0x4
	.2byte	0x15a6
	.4byte	0x29a
	.uleb128 0x7
	.4byte	0x14f
	.uleb128 0x7
	.4byte	0x180
	.byte	0x0
	.uleb128 0x8
	.asciz	"tagINTTREGBITS"
	.byte	0x2
	.byte	0x4
	.2byte	0x15a5
	.4byte	0x2bb
	.uleb128 0x9
	.4byte	0x286
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.byte	0x0
	.uleb128 0xa
	.asciz	"INTTREGBITS"
	.byte	0x4
	.2byte	0x15ba
	.4byte	0x29a
	.uleb128 0xb
	.asciz	"tagCORCON_MODE_TYPE"
	.byte	0x2
	.byte	0x6
	.byte	0x3e
	.4byte	0x410
	.uleb128 0xc
	.asciz	"CORCON_MODE_PORVALUES"
	.sleb128 32
	.uleb128 0xc
	.asciz	"CORCON_MODE_ENABLEALLSATNORMAL_ROUNDBIASED"
	.sleb128 226
	.uleb128 0xc
	.asciz	"CORCON_MODE_ENABLEALLSATNORMAL_ROUNDUNBIASED"
	.sleb128 224
	.uleb128 0xc
	.asciz	"CORCON_MODE_DISABLEALLSAT_ROUNDBIASED"
	.sleb128 34
	.uleb128 0xc
	.asciz	"CORCON_MODE_DISABLEALLSAT_ROUNDUNBIASED"
	.sleb128 32
	.uleb128 0xc
	.asciz	"CORCON_MODE_ENABLEALLSATSUPER_ROUNDBIASED"
	.sleb128 242
	.uleb128 0xc
	.asciz	"CORCON_MODE_ENABLEALLSATSUPER_ROUNDUNBIASED"
	.sleb128 240
	.byte	0x0
	.uleb128 0x3
	.asciz	"SYSTEM_CORCON_MODES"
	.byte	0x6
	.byte	0x69
	.4byte	0x2cf
	.uleb128 0xd
	.asciz	"SYSTEM_CORCONModeOperatingSet"
	.byte	0x1
	.byte	0x4c
	.byte	0x1
	.4byte	.LFB1
	.4byte	.LFE1
	.byte	0x1
	.byte	0x5f
	.4byte	0x46f
	.uleb128 0xe
	.asciz	"modeValue"
	.byte	0x1
	.byte	0x4c
	.4byte	0x410
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0xf
	.asciz	"INTERRUPT_GlobalEnable"
	.byte	0x2
	.byte	0x67
	.byte	0x1
	.4byte	.LFB5
	.4byte	.LFE5
	.byte	0x1
	.byte	0x5f
	.uleb128 0x10
	.byte	0x1
	.asciz	"SYSTEM_Initialize"
	.byte	0x3
	.byte	0x72
	.byte	0x1
	.4byte	.LFB8
	.4byte	.LFE8
	.byte	0x1
	.byte	0x5f
	.uleb128 0x11
	.asciz	"CORCON"
	.byte	0x4
	.byte	0xa3
	.4byte	0x4c5
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	0x100
	.uleb128 0x13
	.4byte	.LASF0
	.byte	0x4
	.2byte	0x15bb
	.4byte	0x4d8
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	0x2bb
	.uleb128 0x11
	.asciz	"CORCON"
	.byte	0x4
	.byte	0xa3
	.4byte	0x4c5
	.byte	0x1
	.byte	0x1
	.uleb128 0x13
	.4byte	.LASF0
	.byte	0x4
	.2byte	0x15bb
	.4byte	0x4d8
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
	.uleb128 0x17
	.byte	0x1
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
	.uleb128 0x7
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x8
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
	.uleb128 0x9
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0xa
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
	.uleb128 0xb
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
	.uleb128 0xc
	.uleb128 0x28
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1c
	.uleb128 0xd
	.byte	0x0
	.byte	0x0
	.uleb128 0xd
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
	.uleb128 0xe
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
	.uleb128 0xf
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
	.uleb128 0x10
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
	.uleb128 0x11
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
	.uleb128 0x12
	.uleb128 0x35
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x13
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
	.byte	0x0
	.section	.debug_pubnames,info
	.4byte	0x24
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x4fc
	.4byte	0x494
	.asciz	"SYSTEM_Initialize"
	.4byte	0x0
	.section	.debug_pubtypes,info
	.4byte	0x6e
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x4fc
	.4byte	0x100
	.asciz	"uint16_t"
	.4byte	0x29a
	.asciz	"tagINTTREGBITS"
	.4byte	0x2bb
	.asciz	"INTTREGBITS"
	.4byte	0x2cf
	.asciz	"tagCORCON_MODE_TYPE"
	.4byte	0x410
	.asciz	"SYSTEM_CORCON_MODES"
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
	.4byte	.LFB5
	.4byte	.LFE5-.LFB5
	.4byte	.LFB8
	.4byte	.LFE8-.LFB8
	.4byte	0x0
	.4byte	0x0
	.section	.debug_str,info
.LASF0:
	.asciz	"INTTREGbits"
	.section	.text,code



	.section __c30_info, info, bss
__large_data_scalar:

	.section __c30_signature, info, data
	.word 0x0001
	.word 0x0007
	.word 0x0000

; MCHP configuration words
; Configuration word @ 0x000157c4
	.section	.config_CTXT2, code, address(0x157c4), keep
__config_CTXT2:
	.pword	65535
; Configuration word @ 0x000157c0
	.section	.config_ALTI2C1, code, address(0x157c0), keep
__config_ALTI2C1:
	.pword	65535
; Configuration word @ 0x000157bc
	.section	.config_DMTEN, code, address(0x157bc), keep
__config_DMTEN:
	.pword	65534
; Configuration word @ 0x000157b8
	.section	.config_DMTCNTH, code, address(0x157b8), keep
__config_DMTCNTH:
	.pword	0
; Configuration word @ 0x000157b4
	.section	.config_DMTCNTL, code, address(0x157b4), keep
__config_DMTCNTL:
	.pword	0
; Configuration word @ 0x000157b0
	.section	.config_DMTIVTH, code, address(0x157b0), keep
__config_DMTIVTH:
	.pword	0
; Configuration word @ 0x000157ac
	.section	.config_DMTIVTL, code, address(0x157ac), keep
__config_DMTIVTL:
	.pword	0
; Configuration word @ 0x000157a8
	.section	.config_ICS, code, address(0x157a8), keep
__config_ICS:
	.pword	65534
; Configuration word @ 0x000157a4
	.section	.config_BOREN0, code, address(0x157a4), keep
__config_BOREN0:
	.pword	65535
; Configuration word @ 0x000157a0
	.section	.config_WDTWIN, code, address(0x157a0), keep
__config_WDTWIN:
	.pword	65424
; Configuration word @ 0x0001579c
	.section	.config_PLLKEN, code, address(0x1579c), keep
__config_PLLKEN:
	.pword	65400
; Configuration word @ 0x00015798
	.section	.config_IESO, code, address(0x15798), keep
__config_IESO:
	.pword	65400
; Configuration word @ 0x00015790
	.section	.config_BSLIM, code, address(0x15790), keep
__config_BSLIM:
	.pword	65535
; Configuration word @ 0x00015780
	.section	.config_AIVTDIS, code, address(0x15780), keep
__config_AIVTDIS:
	.pword	65535

	.set ___PA___,0
	.end
