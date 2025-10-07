	.file "C:\\Users\\zachl\\Downloads\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo\\Demo\\dspic33e-freertos-demo\\dspic33e-freertos-demo.X\\..\\..\\..\\Source\\list.c"
	.section	.debug_abbrev,info
.Ldebug_abbrev0:
	.section	.debug_info,info
.Ldebug_info0:
	.section	.debug_line,info
.Ldebug_line0:
	.section	.text,code
.Ltext0:
	.section	.text.vListInitialise,code
	.align	2
	.global	_vListInitialise	; export
	.type	_vListInitialise,@function
_vListInitialise:
.LFB0:
	.file 1 "../../../Source/list.c"
	.loc 1 49 0
	.set ___PA___,1
	.loc 1 53 0
	add	w0,#4,w1
	mov	w1,[w0+2]
	.loc 1 59 0
	setm	w2
	mov	w2,[w0+4]
	.loc 1 63 0
	mov	w1,[w0+6]
	.loc 1 64 0
	mov	w1,[w0+8]
	.loc 1 75 0
	clr	[w0]
	.loc 1 81 0
	return	
	.set ___PA___,0
.LFE0:
	.size	_vListInitialise, .-_vListInitialise
	.section	.text.vListInitialiseItem,code
	.align	2
	.global	_vListInitialiseItem	; export
	.type	_vListInitialiseItem,@function
_vListInitialiseItem:
.LFB1:
	.loc 1 85 0
	.set ___PA___,1
	.loc 1 87 0
	clr	w1
	mov	w1,[w0+8]
	.loc 1 93 0
	return	
	.set ___PA___,0
.LFE1:
	.size	_vListInitialiseItem, .-_vListInitialiseItem
	.section	.text.vListInsertEnd,code
	.align	2
	.global	_vListInsertEnd	; export
	.type	_vListInsertEnd,@function
_vListInsertEnd:
.LFB2:
	.loc 1 98 0
	.set ___PA___,1
	.loc 1 99 0
	mov	[w0+2],w2
	.loc 1 110 0
	mov	w2,[w1+2]
	.loc 1 111 0
	mov	[w2+4],w3
	mov	w3,[w1+4]
	.loc 1 116 0
	mov	[w2+4],w3
	mov	w1,[w3+2]
	.loc 1 117 0
	mov	w1,[w2+4]
	.loc 1 120 0
	mov	w0,[w1+8]
	.loc 1 122 0
	inc	[w0],[w0]
	.loc 1 123 0
	return	
	.set ___PA___,0
.LFE2:
	.size	_vListInsertEnd, .-_vListInsertEnd
	.section	.text.vListInsert,code
	.align	2
	.global	_vListInsert	; export
	.type	_vListInsert,@function
_vListInsert:
.LFB3:
	.loc 1 128 0
	.set ___PA___,1
	.loc 1 130 0
	mov	[w1],w4
	.loc 1 146 0
	add	w4,#1,[w15]
	.set ___BP___,19
	bra	z,.L16
	.loc 1 177 0
	add	w0,#4,w3
	mov	[w3+2],w2
	sub	w4,[w2],[w15]
	.set ___BP___,9
	bra	ltu,.L12
.L14:
	mov	w2,w3
	mov	[w3+2],w2
	sub	w4,[w2],[w15]
	.set ___BP___,91
	bra	geu,.L14
.L12:
	.loc 1 184 0
	mov	w2,[w1+2]
	.loc 1 185 0
	mov	w1,[w2+4]
	.loc 1 186 0
	mov	w3,[w1+4]
	.loc 1 187 0
	mov	w1,[w3+2]
	.loc 1 191 0
	mov	w0,[w1+8]
	.loc 1 193 0
	inc	[w0],[w0]
	.loc 1 194 0
	return	
.L17:
	.set ___PA___,0
.L16:
	.loc 1 148 0
	mov	[w0+8],w3
	mov	[w3+2],w2
	.loc 1 184 0
	mov	w2,[w1+2]
	.loc 1 185 0
	mov	w1,[w2+4]
	.loc 1 186 0
	mov	w3,[w1+4]
	.loc 1 187 0
	mov	w1,[w3+2]
	.loc 1 191 0
	mov	w0,[w1+8]
	.loc 1 193 0
	inc	[w0],[w0]
	.loc 1 194 0
	return	
	bra	.L17
.LFE3:
	.size	_vListInsert, .-_vListInsert
	.section	.text.uxListRemove,code
	.align	2
	.global	_uxListRemove	; export
	.type	_uxListRemove,@function
_uxListRemove:
.LFB4:
	.loc 1 198 0
	.set ___PA___,1
	.loc 1 201 0
	mov	[w0+8],w1
	.loc 1 203 0
	mov	[w0+2],w2
	mov	[w0+4],w3
	mov	w3,[w2+4]
	.loc 1 204 0
	mov	[w0+4],w3
	mov	w2,[w3+2]
	.loc 1 210 0
	mov	[w1+2],w2
	sub	w2,w0,[w15]
	.set ___BP___,21
	bra	z,.L22
	.loc 1 219 0
	clr	w2
	mov	w2,[w0+8]
	.loc 1 220 0
	dec	[w1],[w1]
	.loc 1 222 0
	mov	[w1],w0
	.loc 1 223 0
	return	
.L23:
	.set ___PA___,0
.L22:
	.loc 1 212 0
	mov	w3,[w1+2]
	.loc 1 219 0
	clr	w2
	mov	w2,[w0+8]
	.loc 1 220 0
	dec	[w1],[w1]
	.loc 1 222 0
	mov	[w1],w0
	.loc 1 223 0
	return	
	bra	.L23
.LFE4:
	.size	_uxListRemove, .-_uxListRemove
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
.LSFDE8:
	.4byte	.LEFDE8-.LASFDE8
.LASFDE8:
	.4byte	.Lframe0
	.4byte	.LFB4
	.4byte	.LFE4-.LFB4
	.align	4
.LEFDE8:
	.section	.text,code
.Letext0:
	.file 2 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h"
	.file 3 "../../../Source/include/../../Source/portable/MPLAB/PIC24_dsPIC/portmacro.h"
	.file 4 "../../../Source/include/list.h"
	.section	.debug_info,info
	.4byte	0x4c8
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.asciz	"GNU C 4.5.1 (XC16, Microchip v2.10) (B) Build date: Mar 27 2023"
	.byte	0x1
	.asciz	"../../../Source/list.c"
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
	.4byte	0x141
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
	.uleb128 0x3
	.asciz	"UBaseType_t"
	.byte	0x3
	.byte	0x62
	.4byte	0x12b
	.uleb128 0x3
	.asciz	"TickType_t"
	.byte	0x3
	.byte	0x65
	.4byte	0x195
	.uleb128 0x5
	.asciz	"xLIST_ITEM"
	.byte	0xa
	.byte	0x4
	.byte	0x90
	.4byte	0x271
	.uleb128 0x6
	.4byte	.LASF0
	.byte	0x4
	.byte	0x93
	.4byte	0x1f6
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x7
	.asciz	"pxNext"
	.byte	0x4
	.byte	0x94
	.4byte	0x271
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0x6
	.4byte	.LASF1
	.byte	0x4
	.byte	0x95
	.4byte	0x271
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x7
	.asciz	"pvOwner"
	.byte	0x4
	.byte	0x96
	.4byte	0x1d4
	.byte	0x2
	.byte	0x23
	.uleb128 0x6
	.uleb128 0x7
	.asciz	"pvContainer"
	.byte	0x4
	.byte	0x97
	.4byte	0x2c5
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.byte	0x0
	.uleb128 0x8
	.byte	0x2
	.4byte	0x208
	.uleb128 0x5
	.asciz	"xLIST"
	.byte	0xa
	.byte	0x4
	.byte	0xac
	.4byte	0x2c5
	.uleb128 0x7
	.asciz	"uxNumberOfItems"
	.byte	0x4
	.byte	0xaf
	.4byte	0x339
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x7
	.asciz	"pxIndex"
	.byte	0x4
	.byte	0xb0
	.4byte	0x33e
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0x7
	.asciz	"xListEnd"
	.byte	0x4
	.byte	0xb1
	.4byte	0x323
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.byte	0x0
	.uleb128 0x8
	.byte	0x2
	.4byte	0x277
	.uleb128 0x3
	.asciz	"ListItem_t"
	.byte	0x4
	.byte	0x9a
	.4byte	0x208
	.uleb128 0x5
	.asciz	"xMINI_LIST_ITEM"
	.byte	0x6
	.byte	0x4
	.byte	0x9d
	.4byte	0x323
	.uleb128 0x6
	.4byte	.LASF0
	.byte	0x4
	.byte	0xa0
	.4byte	0x1f6
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x7
	.asciz	"pxNext"
	.byte	0x4
	.byte	0xa1
	.4byte	0x271
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0x6
	.4byte	.LASF1
	.byte	0x4
	.byte	0xa2
	.4byte	0x271
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.byte	0x0
	.uleb128 0x3
	.asciz	"MiniListItem_t"
	.byte	0x4
	.byte	0xa4
	.4byte	0x2dd
	.uleb128 0x9
	.4byte	0x1e3
	.uleb128 0x8
	.byte	0x2
	.4byte	0x2cb
	.uleb128 0x3
	.asciz	"List_t"
	.byte	0x4
	.byte	0xb3
	.4byte	0x277
	.uleb128 0xa
	.byte	0x1
	.asciz	"vListInitialise"
	.byte	0x1
	.byte	0x30
	.byte	0x1
	.4byte	.LFB0
	.4byte	.LFE0
	.byte	0x1
	.byte	0x5f
	.4byte	0x383
	.uleb128 0xb
	.4byte	.LASF2
	.byte	0x1
	.byte	0x30
	.4byte	0x383
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0xc
	.4byte	0x388
	.uleb128 0x8
	.byte	0x2
	.4byte	0x344
	.uleb128 0xa
	.byte	0x1
	.asciz	"vListInitialiseItem"
	.byte	0x1
	.byte	0x54
	.byte	0x1
	.4byte	.LFB1
	.4byte	.LFE1
	.byte	0x1
	.byte	0x5f
	.4byte	0x3c6
	.uleb128 0xd
	.asciz	"pxItem"
	.byte	0x1
	.byte	0x54
	.4byte	0x3c6
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0xc
	.4byte	0x33e
	.uleb128 0xa
	.byte	0x1
	.asciz	"vListInsertEnd"
	.byte	0x1
	.byte	0x60
	.byte	0x1
	.4byte	.LFB2
	.4byte	.LFE2
	.byte	0x1
	.byte	0x5f
	.4byte	0x419
	.uleb128 0xb
	.4byte	.LASF2
	.byte	0x1
	.byte	0x60
	.4byte	0x383
	.byte	0x1
	.byte	0x50
	.uleb128 0xb
	.4byte	.LASF3
	.byte	0x1
	.byte	0x61
	.4byte	0x3c6
	.byte	0x1
	.byte	0x51
	.uleb128 0xe
	.asciz	"pxIndex"
	.byte	0x1
	.byte	0x63
	.4byte	0x3c6
	.byte	0x1
	.byte	0x52
	.byte	0x0
	.uleb128 0xa
	.byte	0x1
	.asciz	"vListInsert"
	.byte	0x1
	.byte	0x7e
	.byte	0x1
	.4byte	.LFB3
	.4byte	.LFE3
	.byte	0x1
	.byte	0x5f
	.4byte	0x480
	.uleb128 0xb
	.4byte	.LASF2
	.byte	0x1
	.byte	0x7e
	.4byte	0x383
	.byte	0x1
	.byte	0x50
	.uleb128 0xb
	.4byte	.LASF3
	.byte	0x1
	.byte	0x7f
	.4byte	0x3c6
	.byte	0x1
	.byte	0x51
	.uleb128 0xf
	.asciz	"pxIterator"
	.byte	0x1
	.byte	0x81
	.4byte	0x33e
	.uleb128 0xe
	.asciz	"xValueOfInsertion"
	.byte	0x1
	.byte	0x82
	.4byte	0x480
	.byte	0x1
	.byte	0x54
	.byte	0x0
	.uleb128 0xc
	.4byte	0x1f6
	.uleb128 0x10
	.byte	0x1
	.asciz	"uxListRemove"
	.byte	0x1
	.byte	0xc5
	.byte	0x1
	.4byte	0x1e3
	.4byte	.LFB4
	.4byte	.LFE4
	.byte	0x1
	.byte	0x5f
	.uleb128 0xd
	.asciz	"pxItemToRemove"
	.byte	0x1
	.byte	0xc5
	.4byte	0x3c6
	.byte	0x1
	.byte	0x50
	.uleb128 0x11
	.4byte	.LASF2
	.byte	0x1
	.byte	0xc9
	.4byte	0x383
	.byte	0x1
	.byte	0x51
	.byte	0x0
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
	.uleb128 0x13
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
	.uleb128 0x6
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
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
	.uleb128 0x7
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
	.uleb128 0x8
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
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
	.uleb128 0xb
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
	.uleb128 0xc
	.uleb128 0x26
	.byte	0x0
	.uleb128 0x49
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
	.byte	0x0
	.byte	0x0
	.uleb128 0x11
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
	.byte	0x0
	.section	.debug_pubnames,info
	.4byte	0x6e
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x4cc
	.4byte	0x352
	.asciz	"vListInitialise"
	.4byte	0x38e
	.asciz	"vListInitialiseItem"
	.4byte	0x3cb
	.asciz	"vListInsertEnd"
	.4byte	0x419
	.asciz	"vListInsert"
	.4byte	0x485
	.asciz	"uxListRemove"
	.4byte	0x0
	.section	.debug_pubtypes,info
	.4byte	0x94
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x4cc
	.4byte	0x195
	.asciz	"uint16_t"
	.4byte	0x1e3
	.asciz	"UBaseType_t"
	.4byte	0x1f6
	.asciz	"TickType_t"
	.4byte	0x208
	.asciz	"xLIST_ITEM"
	.4byte	0x2cb
	.asciz	"ListItem_t"
	.4byte	0x2dd
	.asciz	"xMINI_LIST_ITEM"
	.4byte	0x323
	.asciz	"MiniListItem_t"
	.4byte	0x277
	.asciz	"xLIST"
	.4byte	0x344
	.asciz	"List_t"
	.4byte	0x0
	.section	.debug_aranges,info
	.4byte	0x3c
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
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.4byte	.LFB4
	.4byte	.LFE4-.LFB4
	.4byte	0x0
	.4byte	0x0
	.section	.debug_str,info
.LASF1:
	.asciz	"pxPrevious"
.LASF2:
	.asciz	"pxList"
.LASF3:
	.asciz	"pxNewListItem"
.LASF0:
	.asciz	"xItemValue"
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
