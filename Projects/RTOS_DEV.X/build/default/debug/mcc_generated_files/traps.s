	.file "C:\\REPOS\\Voltworks_Garage\\Firmware\\Projects\\RTOS_DEV.X\\mcc_generated_files\\traps.c"
	.section	.debug_abbrev,info
.Ldebug_abbrev0:
	.section	.debug_info,info
.Ldebug_info0:
	.section	.debug_line,info
.Ldebug_line0:
	.section	.text,code
.Ltext0:
	.section	.text.use_failsafe_stack,code
	.align	2
	.type	_use_failsafe_stack,@function
_use_failsafe_stack:
.LFB1:
	.file 1 "mcc_generated_files/traps.c"
	.loc 1 101 0
	.set ___PA___,0
	.loc 1 103 0
	mov	#_failsafe_stack.9397,w0
; 103 "mcc_generated_files/traps.c" 1
		mov    w0, W15
	
	.loc 1 111 0
	mov	#_failsafe_stack.9397+24,w0
	mov	w0,_SPLIM
	.loc 1 113 0
	return	
	.set ___PA___,0
.LFE1:
	.size	_use_failsafe_stack, .-_use_failsafe_stack
	.section	.text.TRAPS_halt_on_error,code
	.align	2
	.weak	_TRAPS_halt_on_error
	.type	_TRAPS_halt_on_error,@function
_TRAPS_halt_on_error:
.LFB0:
	.loc 1 81 0
	.set ___PA___,1
	.loc 1 82 0
	mov	w0,_TRAPS_error_code
	.loc 1 85 0
	.pword 0xda4000
.L3:
	bra	.L3
.LFE0:
	.size	_TRAPS_halt_on_error, .-_TRAPS_halt_on_error
	.section	.isr.text._OscillatorFail,keep,code,keep
	.align	2
	.weak	__OscillatorFail
	.type	__OscillatorFail,@function
__OscillatorFail:
	.section	.isr.text._OscillatorFail,keep,code,keep
.LFB2:
	.section	.isr.text._OscillatorFail,keep,code,keep
	.loc 1 118 0
	.set ___PA___,1
	push	_RCOUNT
.LCFI0:
	mov.d	w0,[w15++]
.LCFI1:
	mov.d	w2,[w15++]
.LCFI2:
	mov.d	w4,[w15++]
.LCFI3:
	mov.d	w6,[w15++]
.LCFI4:
	.section	.isr.text._OscillatorFail,keep,code,keep
	.loc 1 119 0
	bclr.b	_INTCON1bits,#1
	.section	.isr.text._OscillatorFail,keep,code,keep
	.loc 1 120 0
	clr	w0
	rcall	_TRAPS_halt_on_error
	.section	.isr.text._OscillatorFail,keep,code,keep
	.loc 1 121 0
	mov.d	[--w15],w6
	mov.d	[--w15],w4
	mov.d	[--w15],w2
	mov.d	[--w15],w0
	pop	_RCOUNT
	retfie	
	.set ___PA___,0
.LFE2:
	.size	__OscillatorFail, .-__OscillatorFail
	.section	.isr.text._StackError,keep,code,keep
	.align	2
	.weak	__StackError
	.type	__StackError,@function
__StackError:
	.section	.isr.text._StackError,keep,code,keep
.LFB3:
	.section	.isr.text._StackError,keep,code,keep
	.loc 1 124 0
	.set ___PA___,1
	push	_RCOUNT
.LCFI5:
	mov.d	w0,[w15++]
.LCFI6:
	mov.d	w2,[w15++]
.LCFI7:
	mov.d	w4,[w15++]
.LCFI8:
	mov.d	w6,[w15++]
.LCFI9:
	.section	.isr.text._StackError,keep,code,keep
	.loc 1 129 0
	rcall	_use_failsafe_stack
	.section	.isr.text._StackError,keep,code,keep
	.loc 1 130 0
	bclr.b	_INTCON1bits,#2
	.section	.isr.text._StackError,keep,code,keep
	.loc 1 131 0
	mov	#1,w0
	rcall	_TRAPS_halt_on_error
	.section	.isr.text._StackError,keep,code,keep
	.loc 1 132 0
	mov.d	[--w15],w6
	mov.d	[--w15],w4
	mov.d	[--w15],w2
	mov.d	[--w15],w0
	pop	_RCOUNT
	retfie	
	.set ___PA___,0
.LFE3:
	.size	__StackError, .-__StackError
	.section	.isr.text._AddressError,keep,code,keep
	.align	2
	.weak	__AddressError
	.type	__AddressError,@function
__AddressError:
	.section	.isr.text._AddressError,keep,code,keep
.LFB4:
	.section	.isr.text._AddressError,keep,code,keep
	.loc 1 135 0
	.set ___PA___,1
	push	_RCOUNT
.LCFI10:
	mov.d	w0,[w15++]
.LCFI11:
	mov.d	w2,[w15++]
.LCFI12:
	mov.d	w4,[w15++]
.LCFI13:
	mov.d	w6,[w15++]
.LCFI14:
	.section	.isr.text._AddressError,keep,code,keep
	.loc 1 136 0
	bclr.b	_INTCON1bits,#3
	.section	.isr.text._AddressError,keep,code,keep
	.loc 1 137 0
	mov	#2,w0
	rcall	_TRAPS_halt_on_error
	.section	.isr.text._AddressError,keep,code,keep
	.loc 1 138 0
	mov.d	[--w15],w6
	mov.d	[--w15],w4
	mov.d	[--w15],w2
	mov.d	[--w15],w0
	pop	_RCOUNT
	retfie	
	.set ___PA___,0
.LFE4:
	.size	__AddressError, .-__AddressError
	.section	.isr.text._MathError,keep,code,keep
	.align	2
	.weak	__MathError
	.type	__MathError,@function
__MathError:
	.section	.isr.text._MathError,keep,code,keep
.LFB5:
	.section	.isr.text._MathError,keep,code,keep
	.loc 1 141 0
	.set ___PA___,1
	push	_RCOUNT
.LCFI15:
	mov.d	w0,[w15++]
.LCFI16:
	mov.d	w2,[w15++]
.LCFI17:
	mov.d	w4,[w15++]
.LCFI18:
	mov.d	w6,[w15++]
.LCFI19:
	.section	.isr.text._MathError,keep,code,keep
	.loc 1 142 0
	bclr.b	_INTCON1bits,#4
	.section	.isr.text._MathError,keep,code,keep
	.loc 1 143 0
	mov	#3,w0
	rcall	_TRAPS_halt_on_error
	.section	.isr.text._MathError,keep,code,keep
	.loc 1 144 0
	mov.d	[--w15],w6
	mov.d	[--w15],w4
	mov.d	[--w15],w2
	mov.d	[--w15],w0
	pop	_RCOUNT
	retfie	
	.set ___PA___,0
.LFE5:
	.size	__MathError, .-__MathError
	.section	.isr.text._DMACError,keep,code,keep
	.align	2
	.weak	__DMACError
	.type	__DMACError,@function
__DMACError:
	.section	.isr.text._DMACError,keep,code,keep
.LFB6:
	.section	.isr.text._DMACError,keep,code,keep
	.loc 1 147 0
	.set ___PA___,1
	push	_RCOUNT
.LCFI20:
	mov.d	w0,[w15++]
.LCFI21:
	mov.d	w2,[w15++]
.LCFI22:
	mov.d	w4,[w15++]
.LCFI23:
	mov.d	w6,[w15++]
.LCFI24:
	.section	.isr.text._DMACError,keep,code,keep
	.loc 1 148 0
	bclr.b	_INTCON1bits,#5
	.section	.isr.text._DMACError,keep,code,keep
	.loc 1 149 0
	mov	#4,w0
	rcall	_TRAPS_halt_on_error
	.section	.isr.text._DMACError,keep,code,keep
	.loc 1 150 0
	mov.d	[--w15],w6
	mov.d	[--w15],w4
	mov.d	[--w15],w2
	mov.d	[--w15],w0
	pop	_RCOUNT
	retfie	
	.set ___PA___,0
.LFE6:
	.size	__DMACError, .-__DMACError
	.section	.isr.text._HardTrapError,keep,code,keep
	.align	2
	.weak	__HardTrapError
	.type	__HardTrapError,@function
__HardTrapError:
	.section	.isr.text._HardTrapError,keep,code,keep
.LFB7:
	.section	.isr.text._HardTrapError,keep,code,keep
	.loc 1 153 0
	.set ___PA___,1
	push	_RCOUNT
.LCFI25:
	mov.d	w0,[w15++]
.LCFI26:
	mov.d	w2,[w15++]
.LCFI27:
	mov.d	w4,[w15++]
.LCFI28:
	mov.d	w6,[w15++]
.LCFI29:
	.section	.isr.text._HardTrapError,keep,code,keep
	.loc 1 154 0
	bclr.b	_INTCON4bits,#0
	.section	.isr.text._HardTrapError,keep,code,keep
	.loc 1 155 0
	mov	#7,w0
	rcall	_TRAPS_halt_on_error
	.section	.isr.text._HardTrapError,keep,code,keep
	.loc 1 156 0
	mov.d	[--w15],w6
	mov.d	[--w15],w4
	mov.d	[--w15],w2
	mov.d	[--w15],w0
	pop	_RCOUNT
	retfie	
	.set ___PA___,0
.LFE7:
	.size	__HardTrapError, .-__HardTrapError
	.section	.isr.text._SoftTrapError,keep,code,keep
	.align	2
	.weak	__SoftTrapError
	.type	__SoftTrapError,@function
__SoftTrapError:
	.section	.isr.text._SoftTrapError,keep,code,keep
.LFB8:
	.section	.isr.text._SoftTrapError,keep,code,keep
	.loc 1 159 0
	.set ___PA___,1
	push	_RCOUNT
.LCFI30:
	mov.d	w0,[w15++]
.LCFI31:
	mov.d	w2,[w15++]
.LCFI32:
	mov.d	w4,[w15++]
.LCFI33:
	mov.d	w6,[w15++]
.LCFI34:
	.section	.isr.text._SoftTrapError,keep,code,keep
	.loc 1 160 0
	btst.b	_INTCON3bits+8/8,#8%8
	.set ___BP___,71
	bra	z,.L11
	.section	.isr.text._SoftTrapError,keep,code,keep
	.loc 1 162 0
	bclr.b	_INTCON3bits+1,#0
	.section	.isr.text._SoftTrapError,keep,code,keep
	.loc 1 163 0
	mov	#12,w0
	rcall	_TRAPS_halt_on_error
.L11:
	.section	.isr.text._SoftTrapError,keep,code,keep
	.loc 1 167 0
	cp0	_INTCON3bits
	.set ___BP___,71
	bra	ge,.L12
	.section	.isr.text._SoftTrapError,keep,code,keep
	.loc 1 169 0
	bclr.b	_INTCON3bits+1,#7
	.section	.isr.text._SoftTrapError,keep,code,keep
	.loc 1 170 0
	mov	#8,w0
	rcall	_TRAPS_halt_on_error
.L12:
	.section	.isr.text._SoftTrapError,keep,code,keep
	.loc 1 175 0
	btst.b	_INTCON3bits,#5
	.set ___BP___,71
	bra	z,.L13
	.section	.isr.text._SoftTrapError,keep,code,keep
	.loc 1 177 0
	bclr.b	_INTCON3bits,#5
	.section	.isr.text._SoftTrapError,keep,code,keep
	.loc 1 178 0
	mov	#9,w0
	rcall	_TRAPS_halt_on_error
.L13:
	.section	.isr.text._SoftTrapError,keep,code,keep
	.loc 1 182 0
	btst.b	_INTCON3bits,#4
	.set ___BP___,71
	bra	z,.L14
	.section	.isr.text._SoftTrapError,keep,code,keep
	.loc 1 184 0
	bclr.b	_INTCON3bits,#4
	.section	.isr.text._SoftTrapError,keep,code,keep
	.loc 1 185 0
	mov	#10,w0
	rcall	_TRAPS_halt_on_error
.L14:
.L15:
	bra	.L15
.LFE8:
	.size	__SoftTrapError, .-__SoftTrapError
	.section	.bss,bss
	.type	_failsafe_stack.9397,@object
	.size	_failsafe_stack.9397, 32
_failsafe_stack.9397:
	.skip	32
	.section	.ndata,data,near
	.align	2
	.type	_TRAPS_error_code,@object
	.size	_TRAPS_error_code, 2
_TRAPS_error_code:
	.word	-1
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
	.byte	0x4
	.4byte	.LCFI1-.LFB2
	.byte	0x13
	.sleb128 -5
	.byte	0x4
	.4byte	.LCFI2-.LCFI1
	.byte	0x13
	.sleb128 -7
	.byte	0x4
	.4byte	.LCFI3-.LCFI2
	.byte	0x13
	.sleb128 -9
	.byte	0x4
	.4byte	.LCFI4-.LCFI3
	.byte	0x13
	.sleb128 -11
	.byte	0x86
	.uleb128 0x9
	.byte	0x84
	.uleb128 0x7
	.byte	0x82
	.uleb128 0x5
	.byte	0x80
	.uleb128 0x3
	.align	4
.LEFDE4:
.LSFDE6:
	.4byte	.LEFDE6-.LASFDE6
.LASFDE6:
	.4byte	.Lframe0
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.byte	0x4
	.4byte	.LCFI6-.LFB3
	.byte	0x13
	.sleb128 -5
	.byte	0x4
	.4byte	.LCFI7-.LCFI6
	.byte	0x13
	.sleb128 -7
	.byte	0x4
	.4byte	.LCFI8-.LCFI7
	.byte	0x13
	.sleb128 -9
	.byte	0x4
	.4byte	.LCFI9-.LCFI8
	.byte	0x13
	.sleb128 -11
	.byte	0x86
	.uleb128 0x9
	.byte	0x84
	.uleb128 0x7
	.byte	0x82
	.uleb128 0x5
	.byte	0x80
	.uleb128 0x3
	.align	4
.LEFDE6:
.LSFDE8:
	.4byte	.LEFDE8-.LASFDE8
.LASFDE8:
	.4byte	.Lframe0
	.4byte	.LFB4
	.4byte	.LFE4-.LFB4
	.byte	0x4
	.4byte	.LCFI11-.LFB4
	.byte	0x13
	.sleb128 -5
	.byte	0x4
	.4byte	.LCFI12-.LCFI11
	.byte	0x13
	.sleb128 -7
	.byte	0x4
	.4byte	.LCFI13-.LCFI12
	.byte	0x13
	.sleb128 -9
	.byte	0x4
	.4byte	.LCFI14-.LCFI13
	.byte	0x13
	.sleb128 -11
	.byte	0x86
	.uleb128 0x9
	.byte	0x84
	.uleb128 0x7
	.byte	0x82
	.uleb128 0x5
	.byte	0x80
	.uleb128 0x3
	.align	4
.LEFDE8:
.LSFDE10:
	.4byte	.LEFDE10-.LASFDE10
.LASFDE10:
	.4byte	.Lframe0
	.4byte	.LFB5
	.4byte	.LFE5-.LFB5
	.byte	0x4
	.4byte	.LCFI16-.LFB5
	.byte	0x13
	.sleb128 -5
	.byte	0x4
	.4byte	.LCFI17-.LCFI16
	.byte	0x13
	.sleb128 -7
	.byte	0x4
	.4byte	.LCFI18-.LCFI17
	.byte	0x13
	.sleb128 -9
	.byte	0x4
	.4byte	.LCFI19-.LCFI18
	.byte	0x13
	.sleb128 -11
	.byte	0x86
	.uleb128 0x9
	.byte	0x84
	.uleb128 0x7
	.byte	0x82
	.uleb128 0x5
	.byte	0x80
	.uleb128 0x3
	.align	4
.LEFDE10:
.LSFDE12:
	.4byte	.LEFDE12-.LASFDE12
.LASFDE12:
	.4byte	.Lframe0
	.4byte	.LFB6
	.4byte	.LFE6-.LFB6
	.byte	0x4
	.4byte	.LCFI21-.LFB6
	.byte	0x13
	.sleb128 -5
	.byte	0x4
	.4byte	.LCFI22-.LCFI21
	.byte	0x13
	.sleb128 -7
	.byte	0x4
	.4byte	.LCFI23-.LCFI22
	.byte	0x13
	.sleb128 -9
	.byte	0x4
	.4byte	.LCFI24-.LCFI23
	.byte	0x13
	.sleb128 -11
	.byte	0x86
	.uleb128 0x9
	.byte	0x84
	.uleb128 0x7
	.byte	0x82
	.uleb128 0x5
	.byte	0x80
	.uleb128 0x3
	.align	4
.LEFDE12:
.LSFDE14:
	.4byte	.LEFDE14-.LASFDE14
.LASFDE14:
	.4byte	.Lframe0
	.4byte	.LFB7
	.4byte	.LFE7-.LFB7
	.byte	0x4
	.4byte	.LCFI26-.LFB7
	.byte	0x13
	.sleb128 -5
	.byte	0x4
	.4byte	.LCFI27-.LCFI26
	.byte	0x13
	.sleb128 -7
	.byte	0x4
	.4byte	.LCFI28-.LCFI27
	.byte	0x13
	.sleb128 -9
	.byte	0x4
	.4byte	.LCFI29-.LCFI28
	.byte	0x13
	.sleb128 -11
	.byte	0x86
	.uleb128 0x9
	.byte	0x84
	.uleb128 0x7
	.byte	0x82
	.uleb128 0x5
	.byte	0x80
	.uleb128 0x3
	.align	4
.LEFDE14:
.LSFDE16:
	.4byte	.LEFDE16-.LASFDE16
.LASFDE16:
	.4byte	.Lframe0
	.4byte	.LFB8
	.4byte	.LFE8-.LFB8
	.byte	0x4
	.4byte	.LCFI31-.LFB8
	.byte	0x13
	.sleb128 -5
	.byte	0x4
	.4byte	.LCFI32-.LCFI31
	.byte	0x13
	.sleb128 -7
	.byte	0x4
	.4byte	.LCFI33-.LCFI32
	.byte	0x13
	.sleb128 -9
	.byte	0x4
	.4byte	.LCFI34-.LCFI33
	.byte	0x13
	.sleb128 -11
	.byte	0x86
	.uleb128 0x9
	.byte	0x84
	.uleb128 0x7
	.byte	0x82
	.uleb128 0x5
	.byte	0x80
	.uleb128 0x3
	.align	4
.LEFDE16:
	.section	.text,code
.Letext0:
	.file 2 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h"
	.file 3 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\dsPIC33E\\h/p33EV128GM106.h"
	.file 4 "mcc_generated_files/traps.h"
	.section	.debug_info,info
	.4byte	0x64e
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.asciz	"GNU C 4.5.1 (XC16, Microchip v2.10) (B) Build date: Mar 27 2023"
	.byte	0x1
	.asciz	"mcc_generated_files/traps.c"
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
	.uleb128 0x3
	.asciz	"uint8_t"
	.byte	0x2
	.byte	0xbb
	.4byte	0xfd
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
	.asciz	"tagINTCON1BITS"
	.byte	0x2
	.byte	0x3
	.2byte	0x156b
	.4byte	0x2b7
	.uleb128 0x5
	.asciz	"OSCFAIL"
	.byte	0x3
	.2byte	0x156d
	.4byte	0x10e
	.byte	0x2
	.byte	0x1
	.byte	0xe
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"STKERR"
	.byte	0x3
	.2byte	0x156e
	.4byte	0x10e
	.byte	0x2
	.byte	0x1
	.byte	0xd
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"ADDRERR"
	.byte	0x3
	.2byte	0x156f
	.4byte	0x10e
	.byte	0x2
	.byte	0x1
	.byte	0xc
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"MATHERR"
	.byte	0x3
	.2byte	0x1570
	.4byte	0x10e
	.byte	0x2
	.byte	0x1
	.byte	0xb
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"DMACERR"
	.byte	0x3
	.2byte	0x1571
	.4byte	0x10e
	.byte	0x2
	.byte	0x1
	.byte	0xa
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"DIV0ERR"
	.byte	0x3
	.2byte	0x1572
	.4byte	0x10e
	.byte	0x2
	.byte	0x1
	.byte	0x9
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"SFTACERR"
	.byte	0x3
	.2byte	0x1573
	.4byte	0x10e
	.byte	0x2
	.byte	0x1
	.byte	0x8
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"COVTE"
	.byte	0x3
	.2byte	0x1574
	.4byte	0x10e
	.byte	0x2
	.byte	0x1
	.byte	0x7
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"OVBTE"
	.byte	0x3
	.2byte	0x1575
	.4byte	0x10e
	.byte	0x2
	.byte	0x1
	.byte	0x6
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"OVATE"
	.byte	0x3
	.2byte	0x1576
	.4byte	0x10e
	.byte	0x2
	.byte	0x1
	.byte	0x5
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"COVBERR"
	.byte	0x3
	.2byte	0x1577
	.4byte	0x10e
	.byte	0x2
	.byte	0x1
	.byte	0x4
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"COVAERR"
	.byte	0x3
	.2byte	0x1578
	.4byte	0x10e
	.byte	0x2
	.byte	0x1
	.byte	0x3
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"OVBERR"
	.byte	0x3
	.2byte	0x1579
	.4byte	0x10e
	.byte	0x2
	.byte	0x1
	.byte	0x2
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"OVAERR"
	.byte	0x3
	.2byte	0x157a
	.4byte	0x10e
	.byte	0x2
	.byte	0x1
	.byte	0x1
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"NSTDIS"
	.byte	0x3
	.2byte	0x157b
	.4byte	0x10e
	.byte	0x2
	.byte	0x1
	.byte	0x0
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.byte	0x0
	.uleb128 0x6
	.asciz	"INTCON1BITS"
	.byte	0x3
	.2byte	0x157c
	.4byte	0x15d
	.uleb128 0x4
	.asciz	"tagINTCON3BITS"
	.byte	0x2
	.byte	0x3
	.2byte	0x1590
	.4byte	0x32e
	.uleb128 0x5
	.asciz	"DOOVR"
	.byte	0x3
	.2byte	0x1592
	.4byte	0x10e
	.byte	0x2
	.byte	0x1
	.byte	0xb
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"DAE"
	.byte	0x3
	.2byte	0x1593
	.4byte	0x10e
	.byte	0x2
	.byte	0x1
	.byte	0xa
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"NAE"
	.byte	0x3
	.2byte	0x1595
	.4byte	0x10e
	.byte	0x2
	.byte	0x1
	.byte	0x7
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"DMT"
	.byte	0x3
	.2byte	0x1597
	.4byte	0x10e
	.byte	0x2
	.byte	0x1
	.byte	0x0
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.byte	0x0
	.uleb128 0x6
	.asciz	"INTCON3BITS"
	.byte	0x3
	.2byte	0x1598
	.4byte	0x2cb
	.uleb128 0x4
	.asciz	"tagINTCON4BITS"
	.byte	0x2
	.byte	0x3
	.2byte	0x159d
	.4byte	0x383
	.uleb128 0x5
	.asciz	"SGHT"
	.byte	0x3
	.2byte	0x159e
	.4byte	0x10e
	.byte	0x2
	.byte	0x1
	.byte	0xf
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"ECCDBE"
	.byte	0x3
	.2byte	0x159f
	.4byte	0x10e
	.byte	0x2
	.byte	0x1
	.byte	0xe
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.byte	0x0
	.uleb128 0x6
	.asciz	"INTCON4BITS"
	.byte	0x3
	.2byte	0x15a0
	.4byte	0x342
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.asciz	"char"
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.asciz	"double"
	.uleb128 0x7
	.byte	0x2
	.byte	0x4
	.byte	0x36
	.4byte	0x45e
	.uleb128 0x8
	.asciz	"TRAPS_OSC_FAIL"
	.sleb128 0
	.uleb128 0x8
	.asciz	"TRAPS_STACK_ERR"
	.sleb128 1
	.uleb128 0x8
	.asciz	"TRAPS_ADDRESS_ERR"
	.sleb128 2
	.uleb128 0x8
	.asciz	"TRAPS_MATH_ERR"
	.sleb128 3
	.uleb128 0x8
	.asciz	"TRAPS_DMAC_ERR"
	.sleb128 4
	.uleb128 0x8
	.asciz	"TRAPS_HARD_ERR"
	.sleb128 7
	.uleb128 0x8
	.asciz	"TRAPS_NVM_ERR"
	.sleb128 12
	.uleb128 0x8
	.asciz	"TRAPS_DMT_ERR"
	.sleb128 8
	.uleb128 0x8
	.asciz	"TRAPS_DAE_ERR"
	.sleb128 9
	.uleb128 0x8
	.asciz	"TRAPS_DOOVR_ERR"
	.sleb128 10
	.byte	0x0
	.uleb128 0x9
	.asciz	"use_failsafe_stack"
	.byte	0x1
	.byte	0x64
	.byte	0x1
	.4byte	.LFB1
	.4byte	.LFE1
	.byte	0x1
	.byte	0x5f
	.4byte	0x4a0
	.uleb128 0xa
	.asciz	"failsafe_stack"
	.byte	0x1
	.byte	0x66
	.4byte	0x4a0
	.byte	0x5
	.byte	0x3
	.4byte	_failsafe_stack.9397
	.byte	0x0
	.uleb128 0xb
	.4byte	0xee
	.4byte	0x4b0
	.uleb128 0xc
	.4byte	0x11e
	.byte	0x1f
	.byte	0x0
	.uleb128 0xd
	.byte	0x1
	.asciz	"TRAPS_halt_on_error"
	.byte	0x1
	.byte	0x50
	.byte	0x1
	.4byte	.LFB0
	.4byte	.LFE0
	.byte	0x1
	.byte	0x5f
	.4byte	0x4e6
	.uleb128 0xe
	.asciz	"code"
	.byte	0x1
	.byte	0x50
	.4byte	0x10e
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0xf
	.byte	0x1
	.asciz	"_OscillatorFail"
	.byte	0x1
	.byte	0x75
	.byte	0x1
	.4byte	.LFB2
	.4byte	.LFE2
	.byte	0x1
	.byte	0x5f
	.uleb128 0xf
	.byte	0x1
	.asciz	"_StackError"
	.byte	0x1
	.byte	0x7b
	.byte	0x1
	.4byte	.LFB3
	.4byte	.LFE3
	.byte	0x1
	.byte	0x5f
	.uleb128 0xf
	.byte	0x1
	.asciz	"_AddressError"
	.byte	0x1
	.byte	0x86
	.byte	0x1
	.4byte	.LFB4
	.4byte	.LFE4
	.byte	0x1
	.byte	0x5f
	.uleb128 0xf
	.byte	0x1
	.asciz	"_MathError"
	.byte	0x1
	.byte	0x8c
	.byte	0x1
	.4byte	.LFB5
	.4byte	.LFE5
	.byte	0x1
	.byte	0x5f
	.uleb128 0xf
	.byte	0x1
	.asciz	"_DMACError"
	.byte	0x1
	.byte	0x92
	.byte	0x1
	.4byte	.LFB6
	.4byte	.LFE6
	.byte	0x1
	.byte	0x5f
	.uleb128 0xf
	.byte	0x1
	.asciz	"_HardTrapError"
	.byte	0x1
	.byte	0x98
	.byte	0x1
	.4byte	.LFB7
	.4byte	.LFE7
	.byte	0x1
	.byte	0x5f
	.uleb128 0xf
	.byte	0x1
	.asciz	"_SoftTrapError"
	.byte	0x1
	.byte	0x9e
	.byte	0x1
	.4byte	.LFB8
	.4byte	.LFE8
	.byte	0x1
	.byte	0x5f
	.uleb128 0x10
	.asciz	"SPLIM"
	.byte	0x3
	.byte	0x59
	.4byte	0x5bc
	.byte	0x1
	.byte	0x1
	.uleb128 0x11
	.4byte	0x10e
	.uleb128 0x12
	.4byte	.LASF0
	.byte	0x3
	.2byte	0x157d
	.4byte	0x5cf
	.byte	0x1
	.byte	0x1
	.uleb128 0x11
	.4byte	0x2b7
	.uleb128 0x12
	.4byte	.LASF1
	.byte	0x3
	.2byte	0x1599
	.4byte	0x5e2
	.byte	0x1
	.byte	0x1
	.uleb128 0x11
	.4byte	0x32e
	.uleb128 0x12
	.4byte	.LASF2
	.byte	0x3
	.2byte	0x15a1
	.4byte	0x5f5
	.byte	0x1
	.byte	0x1
	.uleb128 0x11
	.4byte	0x383
	.uleb128 0xa
	.asciz	"TRAPS_error_code"
	.byte	0x1
	.byte	0x49
	.4byte	0x10e
	.byte	0x5
	.byte	0x3
	.4byte	_TRAPS_error_code
	.uleb128 0x10
	.asciz	"SPLIM"
	.byte	0x3
	.byte	0x59
	.4byte	0x5bc
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF0
	.byte	0x3
	.2byte	0x157d
	.4byte	0x5cf
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF1
	.byte	0x3
	.2byte	0x1599
	.4byte	0x5e2
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF2
	.byte	0x3
	.2byte	0x15a1
	.4byte	0x5f5
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
	.uleb128 0x4
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
	.uleb128 0x28
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1c
	.uleb128 0xd
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
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xc
	.uleb128 0x21
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
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
	.uleb128 0x10
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
	.uleb128 0x11
	.uleb128 0x35
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x12
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
	.4byte	0xa0
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x652
	.4byte	0x4b0
	.asciz	"TRAPS_halt_on_error"
	.4byte	0x4e6
	.asciz	"_OscillatorFail"
	.4byte	0x505
	.asciz	"_StackError"
	.4byte	0x520
	.asciz	"_AddressError"
	.4byte	0x53d
	.asciz	"_MathError"
	.4byte	0x557
	.asciz	"_DMACError"
	.4byte	0x571
	.asciz	"_HardTrapError"
	.4byte	0x58f
	.asciz	"_SoftTrapError"
	.4byte	0x0
	.section	.debug_pubtypes,info
	.4byte	0x90
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x652
	.4byte	0xee
	.asciz	"uint8_t"
	.4byte	0x10e
	.asciz	"uint16_t"
	.4byte	0x15d
	.asciz	"tagINTCON1BITS"
	.4byte	0x2b7
	.asciz	"INTCON1BITS"
	.4byte	0x2cb
	.asciz	"tagINTCON3BITS"
	.4byte	0x32e
	.asciz	"INTCON3BITS"
	.4byte	0x342
	.asciz	"tagINTCON4BITS"
	.4byte	0x383
	.asciz	"INTCON4BITS"
	.4byte	0x0
	.section	.debug_aranges,info
	.4byte	0x5c
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
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.4byte	.LFB4
	.4byte	.LFE4-.LFB4
	.4byte	.LFB5
	.4byte	.LFE5-.LFB5
	.4byte	.LFB6
	.4byte	.LFE6-.LFB6
	.4byte	.LFB7
	.4byte	.LFE7-.LFB7
	.4byte	.LFB8
	.4byte	.LFE8-.LFB8
	.4byte	0x0
	.4byte	0x0
	.section	.debug_str,info
.LASF2:
	.asciz	"INTCON4bits"
.LASF0:
	.asciz	"INTCON1bits"
.LASF1:
	.asciz	"INTCON3bits"
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
