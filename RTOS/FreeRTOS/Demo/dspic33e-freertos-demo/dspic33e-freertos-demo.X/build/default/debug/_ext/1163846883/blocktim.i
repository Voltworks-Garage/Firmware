# 1 "../../Common/Minimal/blocktim.c"
# 1 "C:\\Users\\zachl\\Downloads\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo\\Demo\\dspic33e-freertos-demo\\dspic33e-freertos-demo.X"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "../../Common/Minimal/blocktim.c"
# 34 "../../Common/Minimal/blocktim.c"
# 1 "../../../Source/include/FreeRTOS.h" 1
# 35 "../../../Source/include/FreeRTOS.h"
# 1 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/stddef.h" 1 3 4
# 17 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/stddef.h" 3 4
# 1 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h" 1 3 4
# 10 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h" 3 4
typedef long double _Double;
# 42 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h" 3 4
typedef short unsigned int wchar_t;
# 221 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h" 3 4
typedef unsigned int size_t;
# 249 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h" 3 4
typedef int ptrdiff_t;
# 18 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/stddef.h" 2 3 4
# 36 "../../../Source/include/FreeRTOS.h" 2
# 50 "../../../Source/include/FreeRTOS.h"
# 1 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/stdint.h" 1 3 4
# 20 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/stdint.h" 3 4
# 1 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h" 1 3 4
# 154 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h" 3 4
typedef signed char int8_t;





typedef signed int int16_t;
# 172 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h" 3 4
typedef signed long int int32_t;




typedef signed long long int int64_t;




typedef long long int intmax_t;




typedef unsigned char uint8_t;





typedef unsigned int uint16_t;
# 205 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h" 3 4
typedef unsigned long int uint32_t;




typedef unsigned long long int uint64_t;




typedef unsigned long long int uintmax_t;
# 235 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h" 3 4
typedef unsigned int uintptr_t;
# 269 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h" 3 4
typedef int intptr_t;
# 21 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/stdint.h" 2 3 4


typedef int int_fast8_t;





typedef long long int int_fast64_t;





typedef signed char int_least8_t;





typedef int int_least16_t;





typedef long int int_least24_t;





typedef long int int_least32_t;





typedef long long int int_least64_t;





typedef unsigned int uint_fast8_t;





typedef long unsigned int uint_fast24_t;





typedef long long unsigned int uint_fast64_t;





typedef unsigned char uint_least8_t;





typedef unsigned int uint_least16_t;





typedef long unsigned int uint_least24_t;





typedef long unsigned int uint_least32_t;





typedef long long unsigned int uint_least64_t;
# 387 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/stdint.h" 3 4
# 1 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/stdint.h" 1 3 4

typedef int int_fast16_t;





typedef long int int_fast32_t;





typedef unsigned int uint_fast16_t;





typedef long unsigned int uint_fast32_t;
# 388 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/stdint.h" 2 3 4
# 51 "../../../Source/include/FreeRTOS.h" 2
# 59 "../../../Source/include/FreeRTOS.h"
# 1 "../FreeRTOSConfig.h" 1
# 32 "../FreeRTOSConfig.h"
# 1 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\generic\\h/xc.h" 1 3 4
# 46 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\generic\\h/xc.h" 3 4
# 1 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\support\\generic\\h/builtins.h" 1 3 4
# 44 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\support\\generic\\h/builtins.h" 3 4
void __builtin_write_OSCCONL(
        uint16_t);
void __builtin_write_OSCCONH(
        uint16_t);
void __builtin_write_DISICNT(
        uint16_t);
void __builtin_write_NVM(
        void);
void __builtin_write_CRYOTP(
        void);
void __builtin_write_DATAFLASH(
        void);
void __builtin_write_NVM_secure(
        uint16_t,
        uint16_t);
void __builtin_write_DATAFLASH_secure(
        uint16_t,
        uint16_t);
void __builtin_write_RTCWEN(
        void);
void __builtin_write_RTCC_WRLOCK(
        void);
void __builtin_write_PWMSFR(
        volatile uint16_t *,
        uint16_t,
        volatile uint16_t *);
void __builtin_write_RPCON(
        uint16_t);
uint16_t __builtin_readsfr(
        volatile void *);
void __builtin_writesfr(
        volatile void *,
        uint16_t);

uint16_t __builtin_edspage();
uint16_t __builtin_tblpage();
uint16_t __builtin_edsoffset();
uint16_t __builtin_dataflashoffset();
uint16_t __builtin_tbloffset();
uint16_t __builtin_psvpage();
uint16_t __builtin_psvoffset();
uint16_t __builtin_dmaoffset();
uint16_t __builtin_dmapage();
uint32_t __builtin_tbladdress();

void __builtin_nop(
        void);
int16_t __builtin_divsd(
        const int32_t,
        const int16_t);
int16_t __builtin_modsd(
        const int32_t,
        const int16_t);
int16_t __builtin_divmodsd(
        const int32_t,
        const int16_t,
        int16_t *);
uint16_t __builtin_divud(
        const uint32_t,
        const uint16_t);
uint16_t __builtin_modud(
        const uint32_t,
        const uint16_t);
uint16_t __builtin_divmodud(
        const uint32_t,
        const uint16_t,
        uint16_t *);
uint16_t __builtin_divf(
        uint16_t,
        uint16_t);
int32_t __builtin_mulss(
        const int16_t,
        const int16_t);
uint32_t __builtin_muluu(
        const uint16_t,
        const uint16_t);
int32_t __builtin_mulsu(
        const int16_t,
        const uint16_t);
int32_t __builtin_mulus(
        const uint16_t,
        const int16_t);
void __builtin_btg(
        uint16_t *,
        const uint16_t);
int16_t __builtin_addab(
        int16_t,
        int16_t);
int16_t __builtin_add(
        int16_t,
        int16_t,
        int16_t);
int16_t __builtin_clr(
        void);
int16_t __builtin_clr_prefetch(
        int16_t * *,
        int16_t *,
        int16_t,
        int16_t * *,
        int16_t *,
        int16_t,
        int16_t *,
        int16_t);
int16_t __builtin_ed(
        int16_t,
        int16_t * *,
        int16_t,
        int16_t * *,
        int16_t,
        int16_t *);
int16_t __builtin_edac(
        int16_t,
        int16_t,
        int16_t * *,
        int16_t,
        int16_t * *,
        int16_t,
        int16_t *);
int16_t __builtin_fbcl(
        int16_t);
int16_t __builtin_lac(
        int16_t,
        int16_t);
int16_t __builtin_lacd(
        int32_t,
        int16_t);
int16_t __builtin_mac(
        int16_t,
        int16_t,
        int16_t,
        int16_t * *,
        int16_t *,
        int16_t,
        int16_t * *,
        int16_t *,
        int16_t,
        int16_t *,
        int16_t);
void __builtin_movsac(
        int16_t * *,
        int16_t *,
        int16_t,
        int16_t * *,
        int16_t *,
        int16_t,
        int16_t *,
        int16_t);
int16_t __builtin_mpy(
        int16_t,
        int16_t,
        int16_t * *,
        int16_t *,
        int16_t,
        int16_t * *,
        int16_t *,
        int16_t);
int16_t __builtin_mpyn(
        int16_t,
        int16_t,
        int16_t * *,
        int16_t *,
        int16_t,
        int16_t * *,
        int16_t *,
        int16_t);
int16_t __builtin_msc(
        int16_t,
        int16_t,
        int16_t,
        int16_t * *,
        int16_t *,
        int16_t,
        int16_t * *,
        int16_t *,
        int16_t,
        int16_t *,
        int16_t);
int16_t __builtin_sac(
        int16_t,
        int16_t);
int32_t __builtin_sacd(
        int16_t,
        int16_t);
int16_t __builtin_sacr(
        int16_t,
        int16_t);
int16_t __builtin_sftac(
        int16_t,
        int16_t);
int16_t __builtin_subab(
        int16_t,
        int16_t);
int16_t __builtin_ACCL(
        int16_t);
int16_t __builtin_ACCH(
        int16_t);
int16_t __builtin_ACCU(
        int16_t);
uint16_t __builtin_tblrdl(
        uint16_t);
uint16_t __builtin_tblrdh(
        uint16_t);
unsigned char __builtin_tblrdhb(
        uint16_t);
unsigned char __builtin_tblrdlb(
        uint16_t);
void __builtin_tblwtl(
        uint16_t,
        uint16_t);
void __builtin_tblwth(
        uint16_t,
        uint16_t);
void __builtin_tblwtlb(
        uint16_t,
        unsigned char);
void __builtin_tblwthb(
        uint16_t,
        unsigned char);
void __builtin_disi(
        int16_t);
uint32_t __builtin_section_begin(
        const char *);
uint32_t __builtin_section_size(
        const char *);
uint32_t __builtin_section_end(
        const char *);
uint16_t __builtin_get_isr_state(
        void);
void __builtin_set_isr_state(
        uint16_t);
void __builtin_disable_interrupts(
        void);
void __builtin_enable_interrupts(
        void);
void __builtin_software_breakpoint(
        void);

uint16_t __builtin_addr_low();
uint16_t __builtin_addr_high();
uint32_t __builtin_addr();

void __builtin_pwrsav(
        uint16_t);
void __builtin_clrwdt(
        void);
void _Static_assert(
        uint16_t,
        const char *);
uint16_t __builtin_ff1l(
        uint16_t);
uint16_t __builtin_ff1r(
        uint16_t);
uint16_t __builtin_swap(
        uint16_t);
unsigned char __builtin_swap_byte(
        unsigned char);
int16_t __builtin_flim(
        int16_t,
        int16_t,
        int16_t);
int16_t __builtin_flim_excess(
        int16_t,
        int16_t,
        int16_t,
        int16_t *);
int16_t __builtin_flimv_excess(
        int16_t,
        int16_t,
        int16_t,
        int16_t *);
int16_t __builtin_min(
        int16_t,
        int16_t);
int16_t __builtin_max(
        int16_t,
        int16_t);
int16_t __builtin_min_excess(
        int16_t,
        int16_t,
        int16_t *);
int16_t __builtin_minv_excess(
        int16_t,
        int16_t,
        int16_t *);
int16_t __builtin_max_excess(
        int16_t,
        int16_t,
        int16_t *);
int16_t __builtin_maxv_excess(
        int16_t,
        int16_t,
        int16_t *);
uint32_t __builtin_lshiftrt_32_16(
        uint32_t,
        uint16_t);
int32_t __builtin_ashiftrt_32_16(
        int32_t,
        uint16_t);
# 47 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\generic\\h/xc.h" 2 3 4
# 87 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\generic\\h/xc.h" 3 4
# 1 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\dsPIC33E\\h/p33EV128GM106.h" 1 3 4
# 57 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\dsPIC33E\\h/p33EV128GM106.h" 3 4
extern volatile uint16_t WREG0 __attribute__((__sfr__,__deprecated__,__unsafe__));

extern volatile uint16_t WREG1 __attribute__((__sfr__,__deprecated__,__unsafe__));

extern volatile uint16_t WREG2 __attribute__((__sfr__,__deprecated__,__unsafe__));

extern volatile uint16_t WREG3 __attribute__((__sfr__,__deprecated__,__unsafe__));

extern volatile uint16_t WREG4 __attribute__((__sfr__,__deprecated__,__unsafe__));

extern volatile uint16_t WREG5 __attribute__((__sfr__,__deprecated__,__unsafe__));

extern volatile uint16_t WREG6 __attribute__((__sfr__,__deprecated__,__unsafe__));

extern volatile uint16_t WREG7 __attribute__((__sfr__,__deprecated__,__unsafe__));

extern volatile uint16_t WREG8 __attribute__((__sfr__,__deprecated__,__unsafe__));

extern volatile uint16_t WREG9 __attribute__((__sfr__,__deprecated__,__unsafe__));

extern volatile uint16_t WREG10 __attribute__((__sfr__,__deprecated__,__unsafe__));

extern volatile uint16_t WREG11 __attribute__((__sfr__,__deprecated__,__unsafe__));

extern volatile uint16_t WREG12 __attribute__((__sfr__,__deprecated__,__unsafe__));

extern volatile uint16_t WREG13 __attribute__((__sfr__,__deprecated__,__unsafe__));

extern volatile uint16_t WREG14 __attribute__((__sfr__,__deprecated__,__unsafe__));

extern volatile uint16_t WREG15 __attribute__((__sfr__,__deprecated__,__unsafe__));

extern volatile uint16_t SPLIM __attribute__((__sfr__));

extern volatile uint16_t ACCAL __attribute__((__sfr__,__deprecated__,__unsafe__));

extern volatile uint16_t ACCAH __attribute__((__sfr__,__deprecated__,__unsafe__));

extern volatile uint8_t ACCAU __attribute__((__sfr__,__deprecated__,__unsafe__));

extern volatile uint16_t ACCBL __attribute__((__sfr__,__deprecated__,__unsafe__));

extern volatile uint16_t ACCBH __attribute__((__sfr__,__deprecated__,__unsafe__));

extern volatile uint8_t ACCBU __attribute__((__sfr__,__deprecated__,__unsafe__));

extern volatile uint16_t PCL __attribute__((__sfr__));

extern volatile uint8_t PCH __attribute__((__sfr__));

extern volatile uint16_t DSRPAG __attribute__((__sfr__));
typedef struct tagDSRPAGBITS {
  uint16_t DSRPAG:10;
} DSRPAGBITS;
extern volatile DSRPAGBITS DSRPAGbits __attribute__((__sfr__));


extern volatile uint16_t DSWPAG __attribute__((__sfr__));
typedef struct tagDSWPAGBITS {
  uint16_t DSWPAG:9;
} DSWPAGBITS;
extern volatile DSWPAGBITS DSWPAGbits __attribute__((__sfr__));


extern volatile uint16_t RCOUNT __attribute__((__sfr__));

extern volatile uint16_t DCOUNT __attribute__((__sfr__));

extern volatile uint16_t DOSTARTL __attribute__((__sfr__));

extern volatile uint16_t DOSTARTH __attribute__((__sfr__));

extern volatile uint16_t DOENDL __attribute__((__sfr__));

extern volatile uint16_t DOENDH __attribute__((__sfr__));

extern volatile uint16_t SR __attribute__((__sfr__));
__extension__ typedef struct tagSRBITS {
  union {
    struct {
      uint16_t C:1;
      uint16_t Z:1;
      uint16_t OV:1;
      uint16_t N:1;
      uint16_t RA:1;
      uint16_t IPL:3;
      uint16_t DC:1;
      uint16_t DA:1;
      uint16_t SAB:1;
      uint16_t OAB:1;
      uint16_t SB:1;
      uint16_t SA:1;
      uint16_t OB:1;
      uint16_t OA:1;
    };
    struct {
      uint16_t :5;
      uint16_t IPL0:1;
      uint16_t IPL1:1;
      uint16_t IPL2:1;
    };
  };
} SRBITS;
extern volatile SRBITS SRbits __attribute__((__sfr__));


extern volatile uint16_t CORCON __attribute__((__sfr__));
__extension__ typedef struct tagCORCONBITS {
  union {
    struct {
      uint16_t IF:1;
      uint16_t RND:1;
      uint16_t SFA:1;
      uint16_t IPL3:1;
      uint16_t ACCSAT:1;
      uint16_t SATDW:1;
      uint16_t SATB:1;
      uint16_t SATA:1;
      uint16_t DL:3;
      uint16_t EDT:1;
      uint16_t US:2;
      uint16_t :1;
      uint16_t VAR:1;
    };
    struct {
      uint16_t :8;
      uint16_t DL0:1;
      uint16_t DL1:1;
      uint16_t DL2:1;
      uint16_t :1;
      uint16_t US0:1;
      uint16_t US1:1;
    };
  };
} CORCONBITS;
extern volatile CORCONBITS CORCONbits __attribute__((__sfr__));


extern volatile uint16_t MODCON __attribute__((__sfr__));
__extension__ typedef struct tagMODCONBITS {
  union {
    struct {
      uint16_t XWM:4;
      uint16_t YWM:4;
      uint16_t BWM:4;
      uint16_t :2;
      uint16_t YMODEN:1;
      uint16_t XMODEN:1;
    };
    struct {
      uint16_t XWM0:1;
      uint16_t XWM1:1;
      uint16_t XWM2:1;
      uint16_t XWM3:1;
      uint16_t YWM0:1;
      uint16_t YWM1:1;
      uint16_t YWM2:1;
      uint16_t YWM3:1;
      uint16_t BWM0:1;
      uint16_t BWM1:1;
      uint16_t BWM2:1;
      uint16_t BWM3:1;
    };
  };
} MODCONBITS;
extern volatile MODCONBITS MODCONbits __attribute__((__sfr__));


extern volatile uint16_t XMODSRT __attribute__((__sfr__));

extern volatile uint16_t XMODEND __attribute__((__sfr__));

extern volatile uint16_t YMODSRT __attribute__((__sfr__));

extern volatile uint16_t YMODEND __attribute__((__sfr__));

extern volatile uint16_t XBREV __attribute__((__sfr__));
__extension__ typedef struct tagXBREVBITS {
  union {
    struct {
      uint16_t XB:15;
      uint16_t BREN:1;
    };
    struct {
      uint16_t XB0:1;
      uint16_t XB1:1;
      uint16_t XB2:1;
      uint16_t XB3:1;
      uint16_t XB4:1;
      uint16_t XB5:1;
      uint16_t XB6:1;
      uint16_t XB7:1;
      uint16_t XB8:1;
      uint16_t XB9:1;
      uint16_t XB10:1;
      uint16_t XB11:1;
      uint16_t XB12:1;
      uint16_t XB13:1;
      uint16_t XB14:1;
    };
  };
} XBREVBITS;
extern volatile XBREVBITS XBREVbits __attribute__((__sfr__));


extern volatile uint16_t DISICNT __attribute__((__sfr__));

extern volatile uint16_t TBLPAG __attribute__((__sfr__));
typedef struct tagTBLPAGBITS {
  uint16_t TBLPAG:8;
} TBLPAGBITS;
extern volatile TBLPAGBITS TBLPAGbits __attribute__((__sfr__));


extern volatile uint16_t MSTRPR __attribute__((__sfr__));

extern volatile uint16_t CTXTSTAT __attribute__((__sfr__));
typedef struct tagCTXTSTATBITS {
  uint16_t MCTXI:3;
  uint16_t :5;
  uint16_t CCTXI:3;
} CTXTSTATBITS;
extern volatile CTXTSTATBITS CTXTSTATbits __attribute__((__sfr__));


extern volatile uint16_t TMR1 __attribute__((__sfr__));

extern volatile uint16_t PR1 __attribute__((__sfr__));

extern volatile uint16_t T1CON __attribute__((__sfr__));
__extension__ typedef struct tagT1CONBITS {
  union {
    struct {
      uint16_t :1;
      uint16_t TCS:1;
      uint16_t TSYNC:1;
      uint16_t :1;
      uint16_t TCKPS:2;
      uint16_t TGATE:1;
      uint16_t :6;
      uint16_t TSIDL:1;
      uint16_t :1;
      uint16_t TON:1;
    };
    struct {
      uint16_t :4;
      uint16_t TCKPS0:1;
      uint16_t TCKPS1:1;
    };
  };
} T1CONBITS;
extern volatile T1CONBITS T1CONbits __attribute__((__sfr__));


extern volatile uint16_t TMR2 __attribute__((__sfr__));

extern volatile uint16_t TMR3HLD __attribute__((__sfr__));

extern volatile uint16_t TMR3 __attribute__((__sfr__));

extern volatile uint16_t PR2 __attribute__((__sfr__));

extern volatile uint16_t PR3 __attribute__((__sfr__));

extern volatile uint16_t T2CON __attribute__((__sfr__));
__extension__ typedef struct tagT2CONBITS {
  union {
    struct {
      uint16_t :1;
      uint16_t TCS:1;
      uint16_t :1;
      uint16_t T32:1;
      uint16_t TCKPS:2;
      uint16_t TGATE:1;
      uint16_t :6;
      uint16_t TSIDL:1;
      uint16_t :1;
      uint16_t TON:1;
    };
    struct {
      uint16_t :4;
      uint16_t TCKPS0:1;
      uint16_t TCKPS1:1;
    };
  };
} T2CONBITS;
extern volatile T2CONBITS T2CONbits __attribute__((__sfr__));


extern volatile uint16_t T3CON __attribute__((__sfr__));
__extension__ typedef struct tagT3CONBITS {
  union {
    struct {
      uint16_t :1;
      uint16_t TCS:1;
      uint16_t :2;
      uint16_t TCKPS:2;
      uint16_t TGATE:1;
      uint16_t :6;
      uint16_t TSIDL:1;
      uint16_t :1;
      uint16_t TON:1;
    };
    struct {
      uint16_t :4;
      uint16_t TCKPS0:1;
      uint16_t TCKPS1:1;
    };
  };
} T3CONBITS;
extern volatile T3CONBITS T3CONbits __attribute__((__sfr__));


extern volatile uint16_t TMR4 __attribute__((__sfr__));

extern volatile uint16_t TMR5HLD __attribute__((__sfr__));

extern volatile uint16_t TMR5 __attribute__((__sfr__));

extern volatile uint16_t PR4 __attribute__((__sfr__));

extern volatile uint16_t PR5 __attribute__((__sfr__));

extern volatile uint16_t T4CON __attribute__((__sfr__));
__extension__ typedef struct tagT4CONBITS {
  union {
    struct {
      uint16_t :1;
      uint16_t TCS:1;
      uint16_t :1;
      uint16_t T32:1;
      uint16_t TCKPS:2;
      uint16_t TGATE:1;
      uint16_t :6;
      uint16_t TSIDL:1;
      uint16_t :1;
      uint16_t TON:1;
    };
    struct {
      uint16_t :4;
      uint16_t TCKPS0:1;
      uint16_t TCKPS1:1;
    };
  };
} T4CONBITS;
extern volatile T4CONBITS T4CONbits __attribute__((__sfr__));


extern volatile uint16_t T5CON __attribute__((__sfr__));
__extension__ typedef struct tagT5CONBITS {
  union {
    struct {
      uint16_t :1;
      uint16_t TCS:1;
      uint16_t :2;
      uint16_t TCKPS:2;
      uint16_t TGATE:1;
      uint16_t :6;
      uint16_t TSIDL:1;
      uint16_t :1;
      uint16_t TON:1;
    };
    struct {
      uint16_t :4;
      uint16_t TCKPS0:1;
      uint16_t TCKPS1:1;
    };
  };
} T5CONBITS;
extern volatile T5CONBITS T5CONbits __attribute__((__sfr__));


extern volatile uint16_t IC1CON1 __attribute__((__sfr__));
__extension__ typedef struct tagIC1CON1BITS {
  union {
    struct {
      uint16_t ICM:3;
      uint16_t ICBNE:1;
      uint16_t ICOV:1;
      uint16_t ICI:2;
      uint16_t :3;
      uint16_t ICTSEL:3;
      uint16_t ICSIDL:1;
    };
    struct {
      uint16_t ICM0:1;
      uint16_t ICM1:1;
      uint16_t ICM2:1;
      uint16_t :2;
      uint16_t ICI0:1;
      uint16_t ICI1:1;
      uint16_t :3;
      uint16_t ICTSEL0:1;
      uint16_t ICTSEL1:1;
      uint16_t ICTSEL2:1;
    };
  };
} IC1CON1BITS;
extern volatile IC1CON1BITS IC1CON1bits __attribute__((__sfr__));


extern volatile uint16_t IC1CON2 __attribute__((__sfr__));
__extension__ typedef struct tagIC1CON2BITS {
  union {
    struct {
      uint16_t SYNCSEL:5;
      uint16_t :1;
      uint16_t TRIGSTAT:1;
      uint16_t ICTRIG:1;
      uint16_t IC32:1;
    };
    struct {
      uint16_t SYNCSEL0:1;
      uint16_t SYNCSEL1:1;
      uint16_t SYNCSEL2:1;
      uint16_t SYNCSEL3:1;
      uint16_t SYNCSEL4:1;
    };
  };
} IC1CON2BITS;
extern volatile IC1CON2BITS IC1CON2bits __attribute__((__sfr__));



typedef struct tagIC {
        uint16_t icxbuf;
        uint16_t icxcon;
} IC, *PIC;


extern volatile IC ACC1 __attribute__((__sfr__));


extern volatile uint16_t IC1BUF __attribute__((__sfr__));

extern volatile uint16_t IC1TMR __attribute__((__sfr__));

extern volatile uint16_t IC2CON1 __attribute__((__sfr__));
__extension__ typedef struct tagIC2CON1BITS {
  union {
    struct {
      uint16_t ICM:3;
      uint16_t ICBNE:1;
      uint16_t ICOV:1;
      uint16_t ICI:2;
      uint16_t :3;
      uint16_t ICTSEL:3;
      uint16_t ICSIDL:1;
    };
    struct {
      uint16_t ICM0:1;
      uint16_t ICM1:1;
      uint16_t ICM2:1;
      uint16_t :2;
      uint16_t ICI0:1;
      uint16_t ICI1:1;
      uint16_t :3;
      uint16_t ICTSEL0:1;
      uint16_t ICTSEL1:1;
      uint16_t ICTSEL2:1;
    };
  };
} IC2CON1BITS;
extern volatile IC2CON1BITS IC2CON1bits __attribute__((__sfr__));


extern volatile uint16_t IC2CON2 __attribute__((__sfr__));
__extension__ typedef struct tagIC2CON2BITS {
  union {
    struct {
      uint16_t SYNCSEL:5;
      uint16_t :1;
      uint16_t TRIGSTAT:1;
      uint16_t ICTRIG:1;
      uint16_t IC32:1;
    };
    struct {
      uint16_t SYNCSEL0:1;
      uint16_t SYNCSEL1:1;
      uint16_t SYNCSEL2:1;
      uint16_t SYNCSEL3:1;
      uint16_t SYNCSEL4:1;
    };
  };
} IC2CON2BITS;
extern volatile IC2CON2BITS IC2CON2bits __attribute__((__sfr__));



extern volatile IC ACC2 __attribute__((__sfr__));


extern volatile uint16_t IC2BUF __attribute__((__sfr__));

extern volatile uint16_t IC2TMR __attribute__((__sfr__));

extern volatile uint16_t IC3CON1 __attribute__((__sfr__));
__extension__ typedef struct tagIC3CON1BITS {
  union {
    struct {
      uint16_t ICM:3;
      uint16_t ICBNE:1;
      uint16_t ICOV:1;
      uint16_t ICI:2;
      uint16_t :3;
      uint16_t ICTSEL:3;
      uint16_t ICSIDL:1;
    };
    struct {
      uint16_t ICM0:1;
      uint16_t ICM1:1;
      uint16_t ICM2:1;
      uint16_t :2;
      uint16_t ICI0:1;
      uint16_t ICI1:1;
      uint16_t :3;
      uint16_t ICTSEL0:1;
      uint16_t ICTSEL1:1;
      uint16_t ICTSEL2:1;
    };
  };
} IC3CON1BITS;
extern volatile IC3CON1BITS IC3CON1bits __attribute__((__sfr__));


extern volatile uint16_t IC3CON2 __attribute__((__sfr__));
__extension__ typedef struct tagIC3CON2BITS {
  union {
    struct {
      uint16_t SYNCSEL:5;
      uint16_t :1;
      uint16_t TRIGSTAT:1;
      uint16_t ICTRIG:1;
      uint16_t IC32:1;
    };
    struct {
      uint16_t SYNCSEL0:1;
      uint16_t SYNCSEL1:1;
      uint16_t SYNCSEL2:1;
      uint16_t SYNCSEL3:1;
      uint16_t SYNCSEL4:1;
    };
  };
} IC3CON2BITS;
extern volatile IC3CON2BITS IC3CON2bits __attribute__((__sfr__));



extern volatile IC ACC3 __attribute__((__sfr__));


extern volatile uint16_t IC3BUF __attribute__((__sfr__));

extern volatile uint16_t IC3TMR __attribute__((__sfr__));

extern volatile uint16_t IC4CON1 __attribute__((__sfr__));
__extension__ typedef struct tagIC4CON1BITS {
  union {
    struct {
      uint16_t ICM:3;
      uint16_t ICBNE:1;
      uint16_t ICOV:1;
      uint16_t ICI:2;
      uint16_t :3;
      uint16_t ICTSEL:3;
      uint16_t ICSIDL:1;
    };
    struct {
      uint16_t ICM0:1;
      uint16_t ICM1:1;
      uint16_t ICM2:1;
      uint16_t :2;
      uint16_t ICI0:1;
      uint16_t ICI1:1;
      uint16_t :3;
      uint16_t ICTSEL0:1;
      uint16_t ICTSEL1:1;
      uint16_t ICTSEL2:1;
    };
  };
} IC4CON1BITS;
extern volatile IC4CON1BITS IC4CON1bits __attribute__((__sfr__));


extern volatile uint16_t IC4CON2 __attribute__((__sfr__));
__extension__ typedef struct tagIC4CON2BITS {
  union {
    struct {
      uint16_t SYNCSEL:5;
      uint16_t :1;
      uint16_t TRIGSTAT:1;
      uint16_t ICTRIG:1;
      uint16_t IC32:1;
    };
    struct {
      uint16_t SYNCSEL0:1;
      uint16_t SYNCSEL1:1;
      uint16_t SYNCSEL2:1;
      uint16_t SYNCSEL3:1;
      uint16_t SYNCSEL4:1;
    };
  };
} IC4CON2BITS;
extern volatile IC4CON2BITS IC4CON2bits __attribute__((__sfr__));



extern volatile IC ACC4 __attribute__((__sfr__));


extern volatile uint16_t IC4BUF __attribute__((__sfr__));

extern volatile uint16_t IC4TMR __attribute__((__sfr__));

extern volatile uint16_t I2C1CON1 __attribute__((__sfr__));
typedef struct tagI2C1CON1BITS {
  uint16_t SEN:1;
  uint16_t RSEN:1;
  uint16_t PEN:1;
  uint16_t RCEN:1;
  uint16_t ACKEN:1;
  uint16_t ACKDT:1;
  uint16_t STREN:1;
  uint16_t GCEN:1;
  uint16_t SMEN:1;
  uint16_t DISSLW:1;
  uint16_t A10M:1;
  uint16_t STRICT:1;
  uint16_t SCLREL:1;
  uint16_t I2CSIDL:1;
  uint16_t :1;
  uint16_t I2CEN:1;
} I2C1CON1BITS;
extern volatile I2C1CON1BITS I2C1CON1bits __attribute__((__sfr__));


extern volatile uint16_t I2C1CONL __attribute__((__sfr__));
typedef struct tagI2C1CONLBITS {
  uint16_t SEN:1;
  uint16_t RSEN:1;
  uint16_t PEN:1;
  uint16_t RCEN:1;
  uint16_t ACKEN:1;
  uint16_t ACKDT:1;
  uint16_t STREN:1;
  uint16_t GCEN:1;
  uint16_t SMEN:1;
  uint16_t DISSLW:1;
  uint16_t A10M:1;
  uint16_t STRICT:1;
  uint16_t SCLREL:1;
  uint16_t I2CSIDL:1;
  uint16_t :1;
  uint16_t I2CEN:1;
} I2C1CONLBITS;
extern volatile I2C1CONLBITS I2C1CONLbits __attribute__((__sfr__));


extern volatile uint16_t I2C1CON2 __attribute__((__sfr__));
typedef struct tagI2C1CON2BITS {
  uint16_t DHEN:1;
  uint16_t AHEN:1;
  uint16_t SBCDE:1;
  uint16_t SDAHT:1;
  uint16_t BOEN:1;
  uint16_t SCIE:1;
  uint16_t PCIE:1;
} I2C1CON2BITS;
extern volatile I2C1CON2BITS I2C1CON2bits __attribute__((__sfr__));


extern volatile uint16_t I2C1CONH __attribute__((__sfr__));
typedef struct tagI2C1CONHBITS {
  uint16_t DHEN:1;
  uint16_t AHEN:1;
  uint16_t SBCDE:1;
  uint16_t SDAHT:1;
  uint16_t BOEN:1;
  uint16_t SCIE:1;
  uint16_t PCIE:1;
} I2C1CONHBITS;
extern volatile I2C1CONHBITS I2C1CONHbits __attribute__((__sfr__));


extern volatile uint16_t I2C1STAT __attribute__((__sfr__));
typedef struct tagI2C1STATBITS {
  uint16_t TBF:1;
  uint16_t RBF:1;
  uint16_t R_W:1;
  uint16_t S:1;
  uint16_t P:1;
  uint16_t D_A:1;
  uint16_t I2COV:1;
  uint16_t IWCOL:1;
  uint16_t ADD10:1;
  uint16_t GCSTAT:1;
  uint16_t BCL:1;
  uint16_t :2;
  uint16_t ACKTIM:1;
  uint16_t TRSTAT:1;
  uint16_t ACKSTAT:1;
} I2C1STATBITS;
extern volatile I2C1STATBITS I2C1STATbits __attribute__((__sfr__));


extern volatile uint16_t I2C1ADD __attribute__((__sfr__));
typedef struct tagI2C1ADDBITS {
  uint16_t ADD:10;
} I2C1ADDBITS;
extern volatile I2C1ADDBITS I2C1ADDbits __attribute__((__sfr__));


extern volatile uint16_t I2C1MSK __attribute__((__sfr__));
__extension__ typedef struct tagI2C1MSKBITS {
  union {
    struct {
      uint16_t AMSK:10;
    };
    struct {
      uint16_t AMSK0:1;
      uint16_t AMSK1:1;
      uint16_t AMSK2:1;
      uint16_t AMSK3:1;
      uint16_t AMSK4:1;
      uint16_t AMSK5:1;
      uint16_t AMSK6:1;
      uint16_t AMSK7:1;
      uint16_t AMSK8:1;
      uint16_t AMSK9:1;
    };
  };
} I2C1MSKBITS;
extern volatile I2C1MSKBITS I2C1MSKbits __attribute__((__sfr__));


extern volatile uint16_t I2C1BRG __attribute__((__sfr__));

extern volatile uint16_t I2C1TRN __attribute__((__sfr__));
typedef struct tagI2C1TRNBITS {
  uint16_t I2CTXDATA:8;
} I2C1TRNBITS;
extern volatile I2C1TRNBITS I2C1TRNbits __attribute__((__sfr__));


extern volatile uint16_t I2C1RCV __attribute__((__sfr__));
typedef struct tagI2C1RCVBITS {
  uint16_t I2CRXDATA:8;
} I2C1RCVBITS;
extern volatile I2C1RCVBITS I2C1RCVbits __attribute__((__sfr__));



typedef struct tagUART {
        uint16_t uxmode;
        uint16_t uxsta;
        uint16_t uxtxreg;
        uint16_t uxrxreg;
        uint16_t uxbrg;
} UART, *PUART;
# 824 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\dsPIC33E\\h/p33EV128GM106.h" 3 4
extern volatile UART UART1 __attribute__((__sfr__));


extern volatile uint16_t U1MODE __attribute__((__sfr__));
__extension__ typedef struct tagU1MODEBITS {
  union {
    struct {
      uint16_t STSEL:1;
      uint16_t PDSEL:2;
      uint16_t BRGH:1;
      uint16_t URXINV:1;
      uint16_t ABAUD:1;
      uint16_t LPBACK:1;
      uint16_t WAKE:1;
      uint16_t UEN:2;
      uint16_t :1;
      uint16_t RTSMD:1;
      uint16_t IREN:1;
      uint16_t USIDL:1;
      uint16_t :1;
      uint16_t UARTEN:1;
    };
    struct {
      uint16_t :1;
      uint16_t PDSEL0:1;
      uint16_t PDSEL1:1;
      uint16_t :1;
      uint16_t RXINV:1;
      uint16_t :3;
      uint16_t UEN0:1;
      uint16_t UEN1:1;
    };
  };
} U1MODEBITS;
extern volatile U1MODEBITS U1MODEbits __attribute__((__sfr__));


extern volatile uint16_t U1STA __attribute__((__sfr__));
__extension__ typedef struct tagU1STABITS {
  union {
    struct {
      uint16_t URXDA:1;
      uint16_t OERR:1;
      uint16_t FERR:1;
      uint16_t PERR:1;
      uint16_t RIDLE:1;
      uint16_t ADDEN:1;
      uint16_t URXISEL:2;
      uint16_t TRMT:1;
      uint16_t UTXBF:1;
      uint16_t UTXEN:1;
      uint16_t UTXBRK:1;
      uint16_t :1;
      uint16_t UTXISEL0:1;
      uint16_t UTXINV:1;
      uint16_t UTXISEL1:1;
    };
    struct {
      uint16_t :6;
      uint16_t URXISEL0:1;
      uint16_t URXISEL1:1;
      uint16_t :6;
      uint16_t TXINV:1;
    };
  };
} U1STABITS;
extern volatile U1STABITS U1STAbits __attribute__((__sfr__));


extern volatile uint16_t U1TXREG __attribute__((__sfr__));

extern volatile uint16_t U1RXREG __attribute__((__sfr__));

extern volatile uint16_t U1BRG __attribute__((__sfr__));


extern volatile UART UART2 __attribute__((__sfr__));


extern volatile uint16_t U2MODE __attribute__((__sfr__));
__extension__ typedef struct tagU2MODEBITS {
  union {
    struct {
      uint16_t STSEL:1;
      uint16_t PDSEL:2;
      uint16_t BRGH:1;
      uint16_t URXINV:1;
      uint16_t ABAUD:1;
      uint16_t LPBACK:1;
      uint16_t WAKE:1;
      uint16_t UEN:2;
      uint16_t :1;
      uint16_t RTSMD:1;
      uint16_t IREN:1;
      uint16_t USIDL:1;
      uint16_t :1;
      uint16_t UARTEN:1;
    };
    struct {
      uint16_t :1;
      uint16_t PDSEL0:1;
      uint16_t PDSEL1:1;
      uint16_t :1;
      uint16_t RXINV:1;
      uint16_t :3;
      uint16_t UEN0:1;
      uint16_t UEN1:1;
    };
  };
} U2MODEBITS;
extern volatile U2MODEBITS U2MODEbits __attribute__((__sfr__));


extern volatile uint16_t U2STA __attribute__((__sfr__));
__extension__ typedef struct tagU2STABITS {
  union {
    struct {
      uint16_t URXDA:1;
      uint16_t OERR:1;
      uint16_t FERR:1;
      uint16_t PERR:1;
      uint16_t RIDLE:1;
      uint16_t ADDEN:1;
      uint16_t URXISEL:2;
      uint16_t TRMT:1;
      uint16_t UTXBF:1;
      uint16_t UTXEN:1;
      uint16_t UTXBRK:1;
      uint16_t :1;
      uint16_t UTXISEL0:1;
      uint16_t UTXINV:1;
      uint16_t UTXISEL1:1;
    };
    struct {
      uint16_t :6;
      uint16_t URXISEL0:1;
      uint16_t URXISEL1:1;
      uint16_t :6;
      uint16_t TXINV:1;
    };
  };
} U2STABITS;
extern volatile U2STABITS U2STAbits __attribute__((__sfr__));


extern volatile uint16_t U2TXREG __attribute__((__sfr__));

extern volatile uint16_t U2RXREG __attribute__((__sfr__));

extern volatile uint16_t U2BRG __attribute__((__sfr__));


typedef struct tagSPI {
        uint16_t spixstat;
        uint16_t spixcon1;
        uint16_t spixcon2;
        uint16_t unused;
        uint16_t spixbuf;
} SPI, *PSPI;





extern volatile SPI SPI1 __attribute__((__sfr__));


extern volatile uint16_t SPI1STAT __attribute__((__sfr__));
__extension__ typedef struct tagSPI1STATBITS {
  union {
    struct {
      uint16_t SPIRBF:1;
      uint16_t SPITBF:1;
      uint16_t SISEL:3;
      uint16_t SRXMPT:1;
      uint16_t SPIROV:1;
      uint16_t SRMPT:1;
      uint16_t SPIBEC:3;
      uint16_t :2;
      uint16_t SPISIDL:1;
      uint16_t :1;
      uint16_t SPIEN:1;
    };
    struct {
      uint16_t :2;
      uint16_t SISEL0:1;
      uint16_t SISEL1:1;
      uint16_t SISEL2:1;
      uint16_t :3;
      uint16_t SPIBEC0:1;
      uint16_t SPIBEC1:1;
      uint16_t SPIBEC2:1;
    };
  };
} SPI1STATBITS;
extern volatile SPI1STATBITS SPI1STATbits __attribute__((__sfr__));


extern volatile uint16_t SPI1CON1 __attribute__((__sfr__));
__extension__ typedef struct tagSPI1CON1BITS {
  union {
    struct {
      uint16_t PPRE:2;
      uint16_t SPRE:3;
      uint16_t MSTEN:1;
      uint16_t CKP:1;
      uint16_t SSEN:1;
      uint16_t CKE:1;
      uint16_t SMP:1;
      uint16_t MODE16:1;
      uint16_t DISSDO:1;
      uint16_t DISSCK:1;
    };
    struct {
      uint16_t PPRE0:1;
      uint16_t PPRE1:1;
      uint16_t SPRE0:1;
      uint16_t SPRE1:1;
      uint16_t SPRE2:1;
    };
  };
} SPI1CON1BITS;
extern volatile SPI1CON1BITS SPI1CON1bits __attribute__((__sfr__));


extern volatile uint16_t SPI1CON2 __attribute__((__sfr__));
typedef struct tagSPI1CON2BITS {
  uint16_t SPIBEN:1;
  uint16_t FRMDLY:1;
  uint16_t :11;
  uint16_t FRMPOL:1;
  uint16_t SPIFSD:1;
  uint16_t FRMEN:1;
} SPI1CON2BITS;
extern volatile SPI1CON2BITS SPI1CON2bits __attribute__((__sfr__));


extern volatile uint16_t SPI1BUF __attribute__((__sfr__));


extern volatile SPI SPI2 __attribute__((__sfr__));


extern volatile uint16_t SPI2STAT __attribute__((__sfr__));
__extension__ typedef struct tagSPI2STATBITS {
  union {
    struct {
      uint16_t SPIRBF:1;
      uint16_t SPITBF:1;
      uint16_t SISEL:3;
      uint16_t SRXMPT:1;
      uint16_t SPIROV:1;
      uint16_t SRMPT:1;
      uint16_t SPIBEC:3;
      uint16_t :2;
      uint16_t SPISIDL:1;
      uint16_t :1;
      uint16_t SPIEN:1;
    };
    struct {
      uint16_t :2;
      uint16_t SISEL0:1;
      uint16_t SISEL1:1;
      uint16_t SISEL2:1;
      uint16_t :3;
      uint16_t SPIBEC0:1;
      uint16_t SPIBEC1:1;
      uint16_t SPIBEC2:1;
    };
  };
} SPI2STATBITS;
extern volatile SPI2STATBITS SPI2STATbits __attribute__((__sfr__));


extern volatile uint16_t SPI2CON1 __attribute__((__sfr__));
__extension__ typedef struct tagSPI2CON1BITS {
  union {
    struct {
      uint16_t PPRE:2;
      uint16_t SPRE:3;
      uint16_t MSTEN:1;
      uint16_t CKP:1;
      uint16_t SSEN:1;
      uint16_t CKE:1;
      uint16_t SMP:1;
      uint16_t MODE16:1;
      uint16_t DISSDO:1;
      uint16_t DISSCK:1;
    };
    struct {
      uint16_t PPRE0:1;
      uint16_t PPRE1:1;
      uint16_t SPRE0:1;
      uint16_t SPRE1:1;
      uint16_t SPRE2:1;
    };
  };
} SPI2CON1BITS;
extern volatile SPI2CON1BITS SPI2CON1bits __attribute__((__sfr__));


extern volatile uint16_t SPI2CON2 __attribute__((__sfr__));
typedef struct tagSPI2CON2BITS {
  uint16_t SPIBEN:1;
  uint16_t FRMDLY:1;
  uint16_t :11;
  uint16_t FRMPOL:1;
  uint16_t SPIFSD:1;
  uint16_t FRMEN:1;
} SPI2CON2BITS;
extern volatile SPI2CON2BITS SPI2CON2bits __attribute__((__sfr__));


extern volatile uint16_t SPI2BUF __attribute__((__sfr__));

extern volatile uint16_t ADC1BUF0 __attribute__((__sfr__));

extern volatile uint16_t ADC1BUF1 __attribute__((__sfr__));

extern volatile uint16_t ADC1BUF2 __attribute__((__sfr__));

extern volatile uint16_t ADC1BUF3 __attribute__((__sfr__));

extern volatile uint16_t ADC1BUF4 __attribute__((__sfr__));

extern volatile uint16_t ADC1BUF5 __attribute__((__sfr__));

extern volatile uint16_t ADC1BUF6 __attribute__((__sfr__));

extern volatile uint16_t ADC1BUF7 __attribute__((__sfr__));

extern volatile uint16_t ADC1BUF8 __attribute__((__sfr__));

extern volatile uint16_t ADC1BUF9 __attribute__((__sfr__));

extern volatile uint16_t ADC1BUFA __attribute__((__sfr__));

extern volatile uint16_t ADC1BUFB __attribute__((__sfr__));

extern volatile uint16_t ADC1BUFC __attribute__((__sfr__));

extern volatile uint16_t ADC1BUFD __attribute__((__sfr__));

extern volatile uint16_t ADC1BUFE __attribute__((__sfr__));

extern volatile uint16_t ADC1BUFF __attribute__((__sfr__));

extern volatile uint16_t AD1CON1 __attribute__((__sfr__));
__extension__ typedef struct tagAD1CON1BITS {
  union {
    struct {
      uint16_t DONE:1;
      uint16_t SAMP:1;
      uint16_t ASAM:1;
      uint16_t SIMSAM:1;
      uint16_t SSRCG:1;
      uint16_t SSRC:3;
      uint16_t FORM:2;
      uint16_t AD12B:1;
      uint16_t :1;
      uint16_t ADDMABM:1;
      uint16_t ADSIDL:1;
      uint16_t :1;
      uint16_t ADON:1;
    };
    struct {
      uint16_t :5;
      uint16_t SSRC0:1;
      uint16_t SSRC1:1;
      uint16_t SSRC2:1;
      uint16_t FORM0:1;
      uint16_t FORM1:1;
    };
  };
} AD1CON1BITS;
extern volatile AD1CON1BITS AD1CON1bits __attribute__((__sfr__));


extern volatile uint16_t AD1CON2 __attribute__((__sfr__));
__extension__ typedef struct tagAD1CON2BITS {
  union {
    struct {
      uint16_t ALTS:1;
      uint16_t BUFM:1;
      uint16_t SMPI:5;
      uint16_t BUFS:1;
      uint16_t CHPS:2;
      uint16_t CSCNA:1;
      uint16_t :2;
      uint16_t VCFG:3;
    };
    struct {
      uint16_t :2;
      uint16_t SMPI0:1;
      uint16_t SMPI1:1;
      uint16_t SMPI2:1;
      uint16_t SMPI3:1;
      uint16_t SMPI4:1;
      uint16_t :1;
      uint16_t CHPS0:1;
      uint16_t CHPS1:1;
      uint16_t :3;
      uint16_t VCFG0:1;
      uint16_t VCFG1:1;
      uint16_t VCFG2:1;
    };
  };
} AD1CON2BITS;
extern volatile AD1CON2BITS AD1CON2bits __attribute__((__sfr__));


extern volatile uint16_t AD1CON3 __attribute__((__sfr__));
__extension__ typedef struct tagAD1CON3BITS {
  union {
    struct {
      uint16_t ADCS:8;
      uint16_t SAMC:5;
      uint16_t :2;
      uint16_t ADRC:1;
    };
    struct {
      uint16_t ADCS0:1;
      uint16_t ADCS1:1;
      uint16_t ADCS2:1;
      uint16_t ADCS3:1;
      uint16_t ADCS4:1;
      uint16_t ADCS5:1;
      uint16_t ADCS6:1;
      uint16_t ADCS7:1;
      uint16_t SAMC0:1;
      uint16_t SAMC1:1;
      uint16_t SAMC2:1;
      uint16_t SAMC3:1;
      uint16_t SAMC4:1;
    };
  };
} AD1CON3BITS;
extern volatile AD1CON3BITS AD1CON3bits __attribute__((__sfr__));


extern volatile uint16_t AD1CHS123 __attribute__((__sfr__));
__extension__ typedef struct tagAD1CHS123BITS {
  union {
    struct {
      uint16_t CH123SA0:1;
      uint16_t CH123NA:2;
      uint16_t CH123SA1:1;
      uint16_t CH123SA2:1;
      uint16_t :3;
      uint16_t CH123SB0:1;
      uint16_t CH123NB:2;
      uint16_t CH123SB1:1;
      uint16_t CH123SB2:1;
    };
    struct {
      uint16_t :1;
      uint16_t CH123NA0:1;
      uint16_t CH123NA1:1;
      uint16_t :6;
      uint16_t CH123NB0:1;
      uint16_t CH123NB1:1;
    };
  };
} AD1CHS123BITS;
extern volatile AD1CHS123BITS AD1CHS123bits __attribute__((__sfr__));


extern volatile uint16_t AD1CHS0 __attribute__((__sfr__));
__extension__ typedef struct tagAD1CHS0BITS {
  union {
    struct {
      uint16_t CH0SA:6;
      uint16_t :1;
      uint16_t CH0NA:1;
      uint16_t CH0SB:6;
      uint16_t :1;
      uint16_t CH0NB:1;
    };
    struct {
      uint16_t CH0SA0:1;
      uint16_t CH0SA1:1;
      uint16_t CH0SA2:1;
      uint16_t CH0SA3:1;
      uint16_t CH0SA4:1;
      uint16_t :3;
      uint16_t CH0SB0:1;
      uint16_t CH0SB1:1;
      uint16_t CH0SB2:1;
      uint16_t CH0SB3:1;
      uint16_t CH0SB4:1;
    };
  };
} AD1CHS0BITS;
extern volatile AD1CHS0BITS AD1CHS0bits __attribute__((__sfr__));


extern volatile uint16_t AD1CSSH __attribute__((__sfr__));
typedef struct tagAD1CSSHBITS {
  uint16_t CSS16:1;
  uint16_t CSS17:1;
  uint16_t CSS18:1;
  uint16_t CSS19:1;
  uint16_t :4;
  uint16_t CSS24:1;
  uint16_t CSS25:1;
  uint16_t CSS26:1;
  uint16_t CSS27:1;
  uint16_t CSS28:1;
  uint16_t CSS29:1;
  uint16_t CSS30:1;
  uint16_t CSS31:1;
} AD1CSSHBITS;
extern volatile AD1CSSHBITS AD1CSSHbits __attribute__((__sfr__));


extern volatile uint16_t AD1CSSL __attribute__((__sfr__));
typedef struct tagAD1CSSLBITS {
  uint16_t CSS0:1;
  uint16_t CSS1:1;
  uint16_t CSS2:1;
  uint16_t CSS3:1;
  uint16_t CSS4:1;
  uint16_t CSS5:1;
  uint16_t CSS6:1;
  uint16_t CSS7:1;
  uint16_t CSS8:1;
  uint16_t CSS9:1;
  uint16_t CSS10:1;
  uint16_t CSS11:1;
  uint16_t CSS12:1;
  uint16_t CSS13:1;
  uint16_t CSS14:1;
  uint16_t CSS15:1;
} AD1CSSLBITS;
extern volatile AD1CSSLBITS AD1CSSLbits __attribute__((__sfr__));


extern volatile uint16_t AD1CON4 __attribute__((__sfr__));
__extension__ typedef struct tagAD1CON4BITS {
  union {
    struct {
      uint16_t DMABL:3;
      uint16_t :5;
      uint16_t ADDMAEN:1;
    };
    struct {
      uint16_t DMABL0:1;
      uint16_t DMABL1:1;
      uint16_t DMABL2:1;
    };
  };
} AD1CON4BITS;
extern volatile AD1CON4BITS AD1CON4bits __attribute__((__sfr__));


extern volatile uint16_t CTMUCON1 __attribute__((__sfr__));
typedef struct tagCTMUCON1BITS {
  uint16_t :8;
  uint16_t CTTRIG:1;
  uint16_t IDISSEN:1;
  uint16_t EDGSEQEN:1;
  uint16_t EDGEN:1;
  uint16_t TGEN:1;
  uint16_t CTMUSIDL:1;
  uint16_t :1;
  uint16_t CTMUEN:1;
} CTMUCON1BITS;
extern volatile CTMUCON1BITS CTMUCON1bits __attribute__((__sfr__));


extern volatile uint16_t CTMUCON2 __attribute__((__sfr__));
__extension__ typedef struct tagCTMUCON2BITS {
  union {
    struct {
      uint16_t :2;
      uint16_t EDG2SEL:4;
      uint16_t EDG2POL:1;
      uint16_t EDG2MOD:1;
      uint16_t EDG1STAT:1;
      uint16_t EDG2STAT:1;
      uint16_t EDG1SEL:4;
      uint16_t EDG1POL:1;
      uint16_t EDG1MOD:1;
    };
    struct {
      uint16_t :2;
      uint16_t EDG2SEL0:1;
      uint16_t EDG2SEL1:1;
      uint16_t EDG2SEL2:1;
      uint16_t EDG2SEL3:1;
      uint16_t :4;
      uint16_t EDG1SEL0:1;
      uint16_t EDG1SEL1:1;
      uint16_t EDG1SEL2:1;
      uint16_t EDG1SEL3:1;
    };
  };
} CTMUCON2BITS;
extern volatile CTMUCON2BITS CTMUCON2bits __attribute__((__sfr__));


extern volatile uint16_t CTMUICON __attribute__((__sfr__));
__extension__ typedef struct tagCTMUICONBITS {
  union {
    struct {
      uint16_t :8;
      uint16_t IRNG:2;
      uint16_t ITRIM:6;
    };
    struct {
      uint16_t :8;
      uint16_t IRNG0:1;
      uint16_t IRNG1:1;
      uint16_t ITRIM0:1;
      uint16_t ITRIM1:1;
      uint16_t ITRIM2:1;
      uint16_t ITRIM3:1;
      uint16_t ITRIM4:1;
      uint16_t ITRIM5:1;
    };
  };
} CTMUICONBITS;
extern volatile CTMUICONBITS CTMUICONbits __attribute__((__sfr__));


extern volatile uint16_t C1CTRL1 __attribute__((__sfr__));
__extension__ typedef struct tagC1CTRL1BITS {
  union {
    struct {
      uint16_t WIN:1;
      uint16_t :2;
      uint16_t CANCAP:1;
      uint16_t :1;
      uint16_t OPMODE:3;
      uint16_t REQOP:3;
      uint16_t CANCKS:1;
      uint16_t ABAT:1;
      uint16_t CSIDL:1;
    };
    struct {
      uint16_t :5;
      uint16_t OPMODE0:1;
      uint16_t OPMODE1:1;
      uint16_t OPMODE2:1;
      uint16_t REQOP0:1;
      uint16_t REQOP1:1;
      uint16_t REQOP2:1;
    };
  };
} C1CTRL1BITS;
extern volatile C1CTRL1BITS C1CTRL1bits __attribute__((__sfr__));


extern volatile uint16_t C1CTRL2 __attribute__((__sfr__));
__extension__ typedef struct tagC1CTRL2BITS {
  union {
    struct {
      uint16_t DNCNT:5;
    };
    struct {
      uint16_t DNCNT0:1;
      uint16_t DNCNT1:1;
      uint16_t DNCNT2:1;
      uint16_t DNCNT3:1;
      uint16_t DNCNT4:1;
    };
  };
} C1CTRL2BITS;
extern volatile C1CTRL2BITS C1CTRL2bits __attribute__((__sfr__));


extern volatile uint16_t C1VEC __attribute__((__sfr__));
__extension__ typedef struct tagC1VECBITS {
  union {
    struct {
      uint16_t ICODE:7;
      uint16_t :1;
      uint16_t FILHIT:5;
    };
    struct {
      uint16_t ICODE0:1;
      uint16_t ICODE1:1;
      uint16_t ICODE2:1;
      uint16_t ICODE3:1;
      uint16_t ICODE4:1;
      uint16_t ICODE5:1;
      uint16_t ICODE6:1;
      uint16_t :1;
      uint16_t FILHIT0:1;
      uint16_t FILHIT1:1;
      uint16_t FILHIT2:1;
      uint16_t FILHIT3:1;
      uint16_t FILHIT4:1;
    };
  };
} C1VECBITS;
extern volatile C1VECBITS C1VECbits __attribute__((__sfr__));


extern volatile uint16_t C1FCTRL __attribute__((__sfr__));
__extension__ typedef struct tagC1FCTRLBITS {
  union {
    struct {
      uint16_t FSA:5;
      uint16_t :8;
      uint16_t DMABS:3;
    };
    struct {
      uint16_t FSA0:1;
      uint16_t FSA1:1;
      uint16_t FSA2:1;
      uint16_t FSA3:1;
      uint16_t FSA4:1;
      uint16_t :8;
      uint16_t DMABS0:1;
      uint16_t DMABS1:1;
      uint16_t DMABS2:1;
    };
  };
} C1FCTRLBITS;
extern volatile C1FCTRLBITS C1FCTRLbits __attribute__((__sfr__));


extern volatile uint16_t C1FIFO __attribute__((__sfr__));
__extension__ typedef struct tagC1FIFOBITS {
  union {
    struct {
      uint16_t FNRB:6;
      uint16_t :2;
      uint16_t FBP:6;
    };
    struct {
      uint16_t FNRB0:1;
      uint16_t FNRB1:1;
      uint16_t FNRB2:1;
      uint16_t FNRB3:1;
      uint16_t FNRB4:1;
      uint16_t FNRB5:1;
      uint16_t :2;
      uint16_t FBP0:1;
      uint16_t FBP1:1;
      uint16_t FBP2:1;
      uint16_t FBP3:1;
      uint16_t FBP4:1;
      uint16_t FBP5:1;
    };
  };
} C1FIFOBITS;
extern volatile C1FIFOBITS C1FIFObits __attribute__((__sfr__));


extern volatile uint16_t C1INTF __attribute__((__sfr__));
typedef struct tagC1INTFBITS {
  uint16_t TBIF:1;
  uint16_t RBIF:1;
  uint16_t RBOVIF:1;
  uint16_t FIFOIF:1;
  uint16_t :1;
  uint16_t ERRIF:1;
  uint16_t WAKIF:1;
  uint16_t IVRIF:1;
  uint16_t EWARN:1;
  uint16_t RXWAR:1;
  uint16_t TXWAR:1;
  uint16_t RXBP:1;
  uint16_t TXBP:1;
  uint16_t TXBO:1;
} C1INTFBITS;
extern volatile C1INTFBITS C1INTFbits __attribute__((__sfr__));


extern volatile uint16_t C1INTE __attribute__((__sfr__));
typedef struct tagC1INTEBITS {
  uint16_t TBIE:1;
  uint16_t RBIE:1;
  uint16_t RBOVIE:1;
  uint16_t FIFOIE:1;
  uint16_t :1;
  uint16_t ERRIE:1;
  uint16_t WAKIE:1;
  uint16_t IVRIE:1;
} C1INTEBITS;
extern volatile C1INTEBITS C1INTEbits __attribute__((__sfr__));


extern volatile uint16_t C1EC __attribute__((__sfr__));
typedef struct tagC1ECBITS {
  uint16_t RERRCNT:8;
  uint16_t TERRCNT:8;
} C1ECBITS;
extern volatile C1ECBITS C1ECbits __attribute__((__sfr__));


extern volatile uint8_t C1RERRCNT __attribute__((__sfr__));

extern volatile uint8_t C1TERRCNT __attribute__((__sfr__));

extern volatile uint16_t C1CFG1 __attribute__((__sfr__));
__extension__ typedef struct tagC1CFG1BITS {
  union {
    struct {
      uint16_t BRP:6;
      uint16_t SJW:2;
    };
    struct {
      uint16_t BRP0:1;
      uint16_t BRP1:1;
      uint16_t BRP2:1;
      uint16_t BRP3:1;
      uint16_t BRP4:1;
      uint16_t BRP5:1;
      uint16_t SJW0:1;
      uint16_t SJW1:1;
    };
  };
} C1CFG1BITS;
extern volatile C1CFG1BITS C1CFG1bits __attribute__((__sfr__));


extern volatile uint16_t C1CFG2 __attribute__((__sfr__));
__extension__ typedef struct tagC1CFG2BITS {
  union {
    struct {
      uint16_t PRSEG:3;
      uint16_t SEG1PH:3;
      uint16_t SAM:1;
      uint16_t SEG2PHTS:1;
      uint16_t SEG2PH:3;
      uint16_t :3;
      uint16_t WAKFIL:1;
    };
    struct {
      uint16_t PRSEG0:1;
      uint16_t PRSEG1:1;
      uint16_t PRSEG2:1;
      uint16_t SEG1PH0:1;
      uint16_t SEG1PH1:1;
      uint16_t SEG1PH2:1;
      uint16_t :2;
      uint16_t SEG2PH0:1;
      uint16_t SEG2PH1:1;
      uint16_t SEG2PH2:1;
    };
  };
} C1CFG2BITS;
extern volatile C1CFG2BITS C1CFG2bits __attribute__((__sfr__));


extern volatile uint16_t C1FEN1 __attribute__((__sfr__));
typedef struct tagC1FEN1BITS {
  uint16_t FLTEN0:1;
  uint16_t FLTEN1:1;
  uint16_t FLTEN2:1;
  uint16_t FLTEN3:1;
  uint16_t FLTEN4:1;
  uint16_t FLTEN5:1;
  uint16_t FLTEN6:1;
  uint16_t FLTEN7:1;
  uint16_t FLTEN8:1;
  uint16_t FLTEN9:1;
  uint16_t FLTEN10:1;
  uint16_t FLTEN11:1;
  uint16_t FLTEN12:1;
  uint16_t FLTEN13:1;
  uint16_t FLTEN14:1;
  uint16_t FLTEN15:1;
} C1FEN1BITS;
extern volatile C1FEN1BITS C1FEN1bits __attribute__((__sfr__));


extern volatile uint16_t C1FMSKSEL1 __attribute__((__sfr__));
__extension__ typedef struct tagC1FMSKSEL1BITS {
  union {
    struct {
      uint16_t F0MSK:2;
      uint16_t F1MSK:2;
      uint16_t F2MSK:2;
      uint16_t F3MSK:2;
      uint16_t F4MSK:2;
      uint16_t F5MSK:2;
      uint16_t F6MSK:2;
      uint16_t F7MSK:2;
    };
    struct {
      uint16_t F0MSK0:1;
      uint16_t F0MSK1:1;
      uint16_t F1MSK0:1;
      uint16_t F1MSK1:1;
      uint16_t F2MSK0:1;
      uint16_t F2MSK1:1;
      uint16_t F3MSK0:1;
      uint16_t F3MSK1:1;
      uint16_t F4MSK0:1;
      uint16_t F4MSK1:1;
      uint16_t F5MSK0:1;
      uint16_t F5MSK1:1;
      uint16_t F6MSK0:1;
      uint16_t F6MSK1:1;
      uint16_t F7MSK0:1;
      uint16_t F7MSK1:1;
    };
  };
} C1FMSKSEL1BITS;
extern volatile C1FMSKSEL1BITS C1FMSKSEL1bits __attribute__((__sfr__));


extern volatile uint16_t C1FMSKSEL2 __attribute__((__sfr__));
__extension__ typedef struct tagC1FMSKSEL2BITS {
  union {
    struct {
      uint16_t F8MSK:2;
      uint16_t F9MSK:2;
      uint16_t F10MSK:2;
      uint16_t F11MSK:2;
      uint16_t F12MSK:2;
      uint16_t F13MSK:2;
      uint16_t F14MSK:2;
      uint16_t F15MSK:2;
    };
    struct {
      uint16_t F8MSK0:1;
      uint16_t F8MSK1:1;
      uint16_t F9MSK0:1;
      uint16_t F9MSK1:1;
      uint16_t F10MSK0:1;
      uint16_t F10MSK1:1;
      uint16_t F11MSK0:1;
      uint16_t F11MSK1:1;
      uint16_t F12MSK0:1;
      uint16_t F12MSK1:1;
      uint16_t F13MSK0:1;
      uint16_t F13MSK1:1;
      uint16_t F14MSK0:1;
      uint16_t F14MSK1:1;
      uint16_t F15MSK0:1;
      uint16_t F15MSK1:1;
    };
  };
} C1FMSKSEL2BITS;
extern volatile C1FMSKSEL2BITS C1FMSKSEL2bits __attribute__((__sfr__));


extern volatile uint16_t C1BUFPNT1 __attribute__((__sfr__));
__extension__ typedef struct tagC1BUFPNT1BITS {
  union {
    struct {
      uint16_t F0BP:4;
      uint16_t F1BP:4;
      uint16_t F2BP:4;
      uint16_t F3BP:4;
    };
    struct {
      uint16_t F0BP0:1;
      uint16_t F0BP1:1;
      uint16_t F0BP2:1;
      uint16_t F0BP3:1;
      uint16_t F1BP0:1;
      uint16_t F1BP1:1;
      uint16_t F1BP2:1;
      uint16_t F1BP3:1;
      uint16_t F2BP0:1;
      uint16_t F2BP1:1;
      uint16_t F2BP2:1;
      uint16_t F2BP3:1;
      uint16_t F3BP0:1;
      uint16_t F3BP1:1;
      uint16_t F3BP2:1;
      uint16_t F3BP3:1;
    };
  };
} C1BUFPNT1BITS;
extern volatile C1BUFPNT1BITS C1BUFPNT1bits __attribute__((__sfr__));


extern volatile uint16_t C1RXFUL1 __attribute__((__sfr__));
typedef struct tagC1RXFUL1BITS {
  uint16_t RXFUL0:1;
  uint16_t RXFUL1:1;
  uint16_t RXFUL2:1;
  uint16_t RXFUL3:1;
  uint16_t RXFUL4:1;
  uint16_t RXFUL5:1;
  uint16_t RXFUL6:1;
  uint16_t RXFUL7:1;
  uint16_t RXFUL8:1;
  uint16_t RXFUL9:1;
  uint16_t RXFUL10:1;
  uint16_t RXFUL11:1;
  uint16_t RXFUL12:1;
  uint16_t RXFUL13:1;
  uint16_t RXFUL14:1;
  uint16_t RXFUL15:1;
} C1RXFUL1BITS;
extern volatile C1RXFUL1BITS C1RXFUL1bits __attribute__((__sfr__));


extern volatile uint16_t C1BUFPNT2 __attribute__((__sfr__));
__extension__ typedef struct tagC1BUFPNT2BITS {
  union {
    struct {
      uint16_t F4BP:4;
      uint16_t F5BP:4;
      uint16_t F6BP:4;
      uint16_t F7BP:4;
    };
    struct {
      uint16_t F4BP0:1;
      uint16_t F4BP1:1;
      uint16_t F4BP2:1;
      uint16_t F4BP3:1;
      uint16_t F5BP0:1;
      uint16_t F5BP1:1;
      uint16_t F5BP2:1;
      uint16_t F5BP3:1;
      uint16_t F6BP0:1;
      uint16_t F6BP1:1;
      uint16_t F6BP2:1;
      uint16_t F6BP3:1;
      uint16_t F7BP0:1;
      uint16_t F7BP1:1;
      uint16_t F7BP2:1;
      uint16_t F7BP3:1;
    };
  };
} C1BUFPNT2BITS;
extern volatile C1BUFPNT2BITS C1BUFPNT2bits __attribute__((__sfr__));


extern volatile uint16_t C1RXFUL2 __attribute__((__sfr__));
typedef struct tagC1RXFUL2BITS {
  uint16_t RXFUL16:1;
  uint16_t RXFUL17:1;
  uint16_t RXFUL18:1;
  uint16_t RXFUL19:1;
  uint16_t RXFUL20:1;
  uint16_t RXFUL21:1;
  uint16_t RXFUL22:1;
  uint16_t RXFUL23:1;
  uint16_t RXFUL24:1;
  uint16_t RXFUL25:1;
  uint16_t RXFUL26:1;
  uint16_t RXFUL27:1;
  uint16_t RXFUL28:1;
  uint16_t RXFUL29:1;
  uint16_t RXFUL30:1;
  uint16_t RXFUL31:1;
} C1RXFUL2BITS;
extern volatile C1RXFUL2BITS C1RXFUL2bits __attribute__((__sfr__));


extern volatile uint16_t C1BUFPNT3 __attribute__((__sfr__));
__extension__ typedef struct tagC1BUFPNT3BITS {
  union {
    struct {
      uint16_t F8BP:4;
      uint16_t F9BP:4;
      uint16_t F10BP:4;
      uint16_t F11BP:4;
    };
    struct {
      uint16_t F8BP0:1;
      uint16_t F8BP1:1;
      uint16_t F8BP2:1;
      uint16_t F8BP3:1;
      uint16_t F9BP0:1;
      uint16_t F9BP1:1;
      uint16_t F9BP2:1;
      uint16_t F9BP3:1;
      uint16_t F10BP0:1;
      uint16_t F10BP1:1;
      uint16_t F10BP2:1;
      uint16_t F10BP3:1;
      uint16_t F11BP0:1;
      uint16_t F11BP1:1;
      uint16_t F11BP2:1;
      uint16_t F11BP3:1;
    };
  };
} C1BUFPNT3BITS;
extern volatile C1BUFPNT3BITS C1BUFPNT3bits __attribute__((__sfr__));


extern volatile uint16_t C1BUFPNT4 __attribute__((__sfr__));
__extension__ typedef struct tagC1BUFPNT4BITS {
  union {
    struct {
      uint16_t F12BP:4;
      uint16_t F13BP:4;
      uint16_t F14BP:4;
      uint16_t F15BP:4;
    };
    struct {
      uint16_t F12BP0:1;
      uint16_t F12BP1:1;
      uint16_t F12BP2:1;
      uint16_t F12BP3:1;
      uint16_t F13BP0:1;
      uint16_t F13BP1:1;
      uint16_t F13BP2:1;
      uint16_t F13BP3:1;
      uint16_t F14BP0:1;
      uint16_t F14BP1:1;
      uint16_t F14BP2:1;
      uint16_t F14BP3:1;
      uint16_t F15BP0:1;
      uint16_t F15BP1:1;
      uint16_t F15BP2:1;
      uint16_t F15BP3:1;
    };
  };
} C1BUFPNT4BITS;
extern volatile C1BUFPNT4BITS C1BUFPNT4bits __attribute__((__sfr__));


extern volatile uint16_t C1RXOVF1 __attribute__((__sfr__));
typedef struct tagC1RXOVF1BITS {
  uint16_t RXOVF0:1;
  uint16_t RXOVF1:1;
  uint16_t RXOVF2:1;
  uint16_t RXOVF3:1;
  uint16_t RXOVF4:1;
  uint16_t RXOVF5:1;
  uint16_t RXOVF6:1;
  uint16_t RXOVF7:1;
  uint16_t RXOVF8:1;
  uint16_t RXOVF9:1;
  uint16_t RXOVF10:1;
  uint16_t RXOVF11:1;
  uint16_t RXOVF12:1;
  uint16_t RXOVF13:1;
  uint16_t RXOVF14:1;
  uint16_t RXOVF15:1;
} C1RXOVF1BITS;
extern volatile C1RXOVF1BITS C1RXOVF1bits __attribute__((__sfr__));


extern volatile uint16_t C1RXOVF2 __attribute__((__sfr__));
typedef struct tagC1RXOVF2BITS {
  uint16_t RXOVF16:1;
  uint16_t RXOVF17:1;
  uint16_t RXOVF18:1;
  uint16_t RXOVF19:1;
  uint16_t RXOVF20:1;
  uint16_t RXOVF21:1;
  uint16_t RXOVF22:1;
  uint16_t RXOVF23:1;
  uint16_t RXOVF24:1;
  uint16_t RXOVF25:1;
  uint16_t RXOVF26:1;
  uint16_t RXOVF27:1;
  uint16_t RXOVF28:1;
  uint16_t RXOVF29:1;
  uint16_t RXOVF30:1;
  uint16_t RXOVF31:1;
} C1RXOVF2BITS;
extern volatile C1RXOVF2BITS C1RXOVF2bits __attribute__((__sfr__));


extern volatile uint16_t C1RXM0SID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXM0SIDBITS {
  union {
    struct {
      uint16_t EID16:1;
      uint16_t EID17:1;
      uint16_t :1;
      uint16_t MIDE:1;
      uint16_t :1;
      uint16_t SID0:1;
      uint16_t SID1:1;
      uint16_t SID2:1;
      uint16_t SID3:1;
      uint16_t SID4:1;
      uint16_t SID5:1;
      uint16_t SID6:1;
      uint16_t SID7:1;
      uint16_t SID8:1;
      uint16_t SID9:1;
      uint16_t SID10:1;
    };
    struct {
      uint16_t EID:2;
      uint16_t :1;
      uint16_t EXIDE:1;
      uint16_t :1;
      uint16_t SID:11;
    };
  };
} C1RXM0SIDBITS;
extern volatile C1RXM0SIDBITS C1RXM0SIDbits __attribute__((__sfr__));


extern volatile uint16_t C1TR01CON __attribute__((__sfr__));
__extension__ typedef struct tagC1TR01CONBITS {
  union {
    struct {
      uint16_t TX0PRI:2;
      uint16_t RTREN0:1;
      uint16_t TXREQ0:1;
      uint16_t TXERR0:1;
      uint16_t TXLARB0:1;
      uint16_t TXABT0:1;
      uint16_t TXEN0:1;
      uint16_t TX1PRI:2;
      uint16_t RTREN1:1;
      uint16_t TXREQ1:1;
      uint16_t TXERR1:1;
      uint16_t TXLARB1:1;
      uint16_t TXABT1:1;
      uint16_t TXEN1:1;
    };
    struct {
      uint16_t TX0PRI0:1;
      uint16_t TX0PRI1:1;
      uint16_t :6;
      uint16_t TX1PRI0:1;
      uint16_t TX1PRI1:1;
    };
  };
} C1TR01CONBITS;
extern volatile C1TR01CONBITS C1TR01CONbits __attribute__((__sfr__));


extern volatile uint16_t C1RXM0EID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXM0EIDBITS {
  union {
    struct {
      uint16_t EID0:1;
      uint16_t EID1:1;
      uint16_t EID2:1;
      uint16_t EID3:1;
      uint16_t EID4:1;
      uint16_t EID5:1;
      uint16_t EID6:1;
      uint16_t EID7:1;
      uint16_t EID8:1;
      uint16_t EID9:1;
      uint16_t EID10:1;
      uint16_t EID11:1;
      uint16_t EID12:1;
      uint16_t EID13:1;
      uint16_t EID14:1;
      uint16_t EID15:1;
    };
    struct {
      uint16_t EID:16;
    };
  };
} C1RXM0EIDBITS;
extern volatile C1RXM0EIDBITS C1RXM0EIDbits __attribute__((__sfr__));


extern volatile uint16_t C1TR23CON __attribute__((__sfr__));
__extension__ typedef struct tagC1TR23CONBITS {
  union {
    struct {
      uint16_t TX2PRI:2;
      uint16_t RTREN2:1;
      uint16_t TXREQ2:1;
      uint16_t TXERR2:1;
      uint16_t TXLARB2:1;
      uint16_t TXABT2:1;
      uint16_t TXEN2:1;
      uint16_t TX3PRI:2;
      uint16_t RTREN3:1;
      uint16_t TXREQ3:1;
      uint16_t TXERR3:1;
      uint16_t TXLARB3:1;
      uint16_t TXABT3:1;
      uint16_t TXEN3:1;
    };
    struct {
      uint16_t TX2PRI0:1;
      uint16_t TX2PRI1:1;
      uint16_t :6;
      uint16_t TX3PRI0:1;
      uint16_t TX3PRI1:1;
    };
  };
} C1TR23CONBITS;
extern volatile C1TR23CONBITS C1TR23CONbits __attribute__((__sfr__));


extern volatile uint16_t C1RXM1SID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXM1SIDBITS {
  union {
    struct {
      uint16_t EID16:1;
      uint16_t EID17:1;
      uint16_t :1;
      uint16_t MIDE:1;
      uint16_t :1;
      uint16_t SID0:1;
      uint16_t SID1:1;
      uint16_t SID2:1;
      uint16_t SID3:1;
      uint16_t SID4:1;
      uint16_t SID5:1;
      uint16_t SID6:1;
      uint16_t SID7:1;
      uint16_t SID8:1;
      uint16_t SID9:1;
      uint16_t SID10:1;
    };
    struct {
      uint16_t EID:2;
      uint16_t :3;
      uint16_t SID:11;
    };
  };
} C1RXM1SIDBITS;
extern volatile C1RXM1SIDBITS C1RXM1SIDbits __attribute__((__sfr__));


extern volatile uint16_t C1TR45CON __attribute__((__sfr__));
__extension__ typedef struct tagC1TR45CONBITS {
  union {
    struct {
      uint16_t TX4PRI:2;
      uint16_t RTREN4:1;
      uint16_t TXREQ4:1;
      uint16_t TXERR4:1;
      uint16_t TXLARB4:1;
      uint16_t TXABT4:1;
      uint16_t TXEN4:1;
      uint16_t TX5PRI:2;
      uint16_t RTREN5:1;
      uint16_t TXREQ5:1;
      uint16_t TXERR5:1;
      uint16_t TXLARB5:1;
      uint16_t TXABT5:1;
      uint16_t TXEN5:1;
    };
    struct {
      uint16_t TX4PRI0:1;
      uint16_t TX4PRI1:1;
      uint16_t :6;
      uint16_t TX5PRI0:1;
      uint16_t TX5PRI1:1;
    };
  };
} C1TR45CONBITS;
extern volatile C1TR45CONBITS C1TR45CONbits __attribute__((__sfr__));


extern volatile uint16_t C1RXM1EID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXM1EIDBITS {
  union {
    struct {
      uint16_t EID0:1;
      uint16_t EID1:1;
      uint16_t EID2:1;
      uint16_t EID3:1;
      uint16_t EID4:1;
      uint16_t EID5:1;
      uint16_t EID6:1;
      uint16_t EID7:1;
      uint16_t EID8:1;
      uint16_t EID9:1;
      uint16_t EID10:1;
      uint16_t EID11:1;
      uint16_t EID12:1;
      uint16_t EID13:1;
      uint16_t EID14:1;
      uint16_t EID15:1;
    };
    struct {
      uint16_t EID:16;
    };
  };
} C1RXM1EIDBITS;
extern volatile C1RXM1EIDBITS C1RXM1EIDbits __attribute__((__sfr__));


extern volatile uint16_t C1TR67CON __attribute__((__sfr__));
__extension__ typedef struct tagC1TR67CONBITS {
  union {
    struct {
      uint16_t TX6PRI:2;
      uint16_t RTREN6:1;
      uint16_t TXREQ6:1;
      uint16_t TXERR6:1;
      uint16_t TXLARB6:1;
      uint16_t TXABT6:1;
      uint16_t TXEN6:1;
      uint16_t TX7PRI:2;
      uint16_t RTREN7:1;
      uint16_t TXREQ7:1;
      uint16_t TXERR7:1;
      uint16_t TXLARB7:1;
      uint16_t TXABT7:1;
      uint16_t TXEN7:1;
    };
    struct {
      uint16_t TX6PRI0:1;
      uint16_t TX6PRI1:1;
      uint16_t :6;
      uint16_t TX7PRI0:1;
      uint16_t TX7PRI1:1;
    };
  };
} C1TR67CONBITS;
extern volatile C1TR67CONBITS C1TR67CONbits __attribute__((__sfr__));


extern volatile uint16_t C1RXM2SID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXM2SIDBITS {
  union {
    struct {
      uint16_t EID16:1;
      uint16_t EID17:1;
      uint16_t :1;
      uint16_t MIDE:1;
      uint16_t :1;
      uint16_t SID0:1;
      uint16_t SID1:1;
      uint16_t SID2:1;
      uint16_t SID3:1;
      uint16_t SID4:1;
      uint16_t SID5:1;
      uint16_t SID6:1;
      uint16_t SID7:1;
      uint16_t SID8:1;
      uint16_t SID9:1;
      uint16_t SID10:1;
    };
    struct {
      uint16_t EID:2;
      uint16_t :3;
      uint16_t SID:11;
    };
  };
} C1RXM2SIDBITS;
extern volatile C1RXM2SIDBITS C1RXM2SIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXM2EID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXM2EIDBITS {
  union {
    struct {
      uint16_t EID0:1;
      uint16_t EID1:1;
      uint16_t EID2:1;
      uint16_t EID3:1;
      uint16_t EID4:1;
      uint16_t EID5:1;
      uint16_t EID6:1;
      uint16_t EID7:1;
      uint16_t EID8:1;
      uint16_t EID9:1;
      uint16_t EID10:1;
      uint16_t EID11:1;
      uint16_t EID12:1;
      uint16_t EID13:1;
      uint16_t EID14:1;
      uint16_t EID15:1;
    };
    struct {
      uint16_t EID:16;
    };
  };
} C1RXM2EIDBITS;
extern volatile C1RXM2EIDBITS C1RXM2EIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXD __attribute__((__sfr__));


typedef struct tagCAN {
} CAN, *PCAN;




extern volatile CAN CAN1 __attribute__((__sfr__));


extern volatile uint16_t C1RXF0SID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF0SIDBITS {
  union {
    struct {
      uint16_t EID16:1;
      uint16_t EID17:1;
      uint16_t :1;
      uint16_t EXIDE:1;
      uint16_t :1;
      uint16_t SID0:1;
      uint16_t SID1:1;
      uint16_t SID2:1;
      uint16_t SID3:1;
      uint16_t SID4:1;
      uint16_t SID5:1;
      uint16_t SID6:1;
      uint16_t SID7:1;
      uint16_t SID8:1;
      uint16_t SID9:1;
      uint16_t SID10:1;
    };
    struct {
      uint16_t EID:2;
      uint16_t :3;
      uint16_t SID:11;
    };
  };
} C1RXF0SIDBITS;
extern volatile C1RXF0SIDBITS C1RXF0SIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF0EID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF0EIDBITS {
  union {
    struct {
      uint16_t EID0:1;
      uint16_t EID1:1;
      uint16_t EID2:1;
      uint16_t EID3:1;
      uint16_t EID4:1;
      uint16_t EID5:1;
      uint16_t EID6:1;
      uint16_t EID7:1;
      uint16_t EID8:1;
      uint16_t EID9:1;
      uint16_t EID10:1;
      uint16_t EID11:1;
      uint16_t EID12:1;
      uint16_t EID13:1;
      uint16_t EID14:1;
      uint16_t EID15:1;
    };
    struct {
      uint16_t EID:16;
    };
  };
} C1RXF0EIDBITS;
extern volatile C1RXF0EIDBITS C1RXF0EIDbits __attribute__((__sfr__));


extern volatile uint16_t C1TXD __attribute__((__sfr__));

extern volatile uint16_t C1RXF1SID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF1SIDBITS {
  union {
    struct {
      uint16_t EID16:1;
      uint16_t EID17:1;
      uint16_t :1;
      uint16_t EXIDE:1;
      uint16_t :1;
      uint16_t SID0:1;
      uint16_t SID1:1;
      uint16_t SID2:1;
      uint16_t SID3:1;
      uint16_t SID4:1;
      uint16_t SID5:1;
      uint16_t SID6:1;
      uint16_t SID7:1;
      uint16_t SID8:1;
      uint16_t SID9:1;
      uint16_t SID10:1;
    };
    struct {
      uint16_t EID:2;
      uint16_t :3;
      uint16_t SID:11;
    };
  };
} C1RXF1SIDBITS;
extern volatile C1RXF1SIDBITS C1RXF1SIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF1EID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF1EIDBITS {
  union {
    struct {
      uint16_t EID0:1;
      uint16_t EID1:1;
      uint16_t EID2:1;
      uint16_t EID3:1;
      uint16_t EID4:1;
      uint16_t EID5:1;
      uint16_t EID6:1;
      uint16_t EID7:1;
      uint16_t EID8:1;
      uint16_t EID9:1;
      uint16_t EID10:1;
      uint16_t EID11:1;
      uint16_t EID12:1;
      uint16_t EID13:1;
      uint16_t EID14:1;
      uint16_t EID15:1;
    };
    struct {
      uint16_t EID:16;
    };
  };
} C1RXF1EIDBITS;
extern volatile C1RXF1EIDBITS C1RXF1EIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF2SID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF2SIDBITS {
  union {
    struct {
      uint16_t EID16:1;
      uint16_t EID17:1;
      uint16_t :1;
      uint16_t EXIDE:1;
      uint16_t :1;
      uint16_t SID0:1;
      uint16_t SID1:1;
      uint16_t SID2:1;
      uint16_t SID3:1;
      uint16_t SID4:1;
      uint16_t SID5:1;
      uint16_t SID6:1;
      uint16_t SID7:1;
      uint16_t SID8:1;
      uint16_t SID9:1;
      uint16_t SID10:1;
    };
    struct {
      uint16_t EID:2;
      uint16_t :3;
      uint16_t SID:11;
    };
  };
} C1RXF2SIDBITS;
extern volatile C1RXF2SIDBITS C1RXF2SIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF2EID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF2EIDBITS {
  union {
    struct {
      uint16_t EID0:1;
      uint16_t EID1:1;
      uint16_t EID2:1;
      uint16_t EID3:1;
      uint16_t EID4:1;
      uint16_t EID5:1;
      uint16_t EID6:1;
      uint16_t EID7:1;
      uint16_t EID8:1;
      uint16_t EID9:1;
      uint16_t EID10:1;
      uint16_t EID11:1;
      uint16_t EID12:1;
      uint16_t EID13:1;
      uint16_t EID14:1;
      uint16_t EID15:1;
    };
    struct {
      uint16_t EID:16;
    };
  };
} C1RXF2EIDBITS;
extern volatile C1RXF2EIDBITS C1RXF2EIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF3SID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF3SIDBITS {
  union {
    struct {
      uint16_t EID16:1;
      uint16_t EID17:1;
      uint16_t :1;
      uint16_t EXIDE:1;
      uint16_t :1;
      uint16_t SID0:1;
      uint16_t SID1:1;
      uint16_t SID2:1;
      uint16_t SID3:1;
      uint16_t SID4:1;
      uint16_t SID5:1;
      uint16_t SID6:1;
      uint16_t SID7:1;
      uint16_t SID8:1;
      uint16_t SID9:1;
      uint16_t SID10:1;
    };
    struct {
      uint16_t EID:2;
      uint16_t :3;
      uint16_t SID:11;
    };
  };
} C1RXF3SIDBITS;
extern volatile C1RXF3SIDBITS C1RXF3SIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF3EID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF3EIDBITS {
  union {
    struct {
      uint16_t EID0:1;
      uint16_t EID1:1;
      uint16_t EID2:1;
      uint16_t EID3:1;
      uint16_t EID4:1;
      uint16_t EID5:1;
      uint16_t EID6:1;
      uint16_t EID7:1;
      uint16_t EID8:1;
      uint16_t EID9:1;
      uint16_t EID10:1;
      uint16_t EID11:1;
      uint16_t EID12:1;
      uint16_t EID13:1;
      uint16_t EID14:1;
      uint16_t EID15:1;
    };
    struct {
      uint16_t EID:16;
    };
  };
} C1RXF3EIDBITS;
extern volatile C1RXF3EIDBITS C1RXF3EIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF4SID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF4SIDBITS {
  union {
    struct {
      uint16_t EID16:1;
      uint16_t EID17:1;
      uint16_t :1;
      uint16_t EXIDE:1;
      uint16_t :1;
      uint16_t SID0:1;
      uint16_t SID1:1;
      uint16_t SID2:1;
      uint16_t SID3:1;
      uint16_t SID4:1;
      uint16_t SID5:1;
      uint16_t SID6:1;
      uint16_t SID7:1;
      uint16_t SID8:1;
      uint16_t SID9:1;
      uint16_t SID10:1;
    };
    struct {
      uint16_t EID:2;
      uint16_t :3;
      uint16_t SID:11;
    };
  };
} C1RXF4SIDBITS;
extern volatile C1RXF4SIDBITS C1RXF4SIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF4EID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF4EIDBITS {
  union {
    struct {
      uint16_t EID0:1;
      uint16_t EID1:1;
      uint16_t EID2:1;
      uint16_t EID3:1;
      uint16_t EID4:1;
      uint16_t EID5:1;
      uint16_t EID6:1;
      uint16_t EID7:1;
      uint16_t EID8:1;
      uint16_t EID9:1;
      uint16_t EID10:1;
      uint16_t EID11:1;
      uint16_t EID12:1;
      uint16_t EID13:1;
      uint16_t EID14:1;
      uint16_t EID15:1;
    };
    struct {
      uint16_t EID:16;
    };
  };
} C1RXF4EIDBITS;
extern volatile C1RXF4EIDBITS C1RXF4EIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF5SID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF5SIDBITS {
  union {
    struct {
      uint16_t EID16:1;
      uint16_t EID17:1;
      uint16_t :1;
      uint16_t EXIDE:1;
      uint16_t :1;
      uint16_t SID0:1;
      uint16_t SID1:1;
      uint16_t SID2:1;
      uint16_t SID3:1;
      uint16_t SID4:1;
      uint16_t SID5:1;
      uint16_t SID6:1;
      uint16_t SID7:1;
      uint16_t SID8:1;
      uint16_t SID9:1;
      uint16_t SID10:1;
    };
    struct {
      uint16_t EID:2;
      uint16_t :3;
      uint16_t SID:11;
    };
  };
} C1RXF5SIDBITS;
extern volatile C1RXF5SIDBITS C1RXF5SIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF5EID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF5EIDBITS {
  union {
    struct {
      uint16_t EID0:1;
      uint16_t EID1:1;
      uint16_t EID2:1;
      uint16_t EID3:1;
      uint16_t EID4:1;
      uint16_t EID5:1;
      uint16_t EID6:1;
      uint16_t EID7:1;
      uint16_t EID8:1;
      uint16_t EID9:1;
      uint16_t EID10:1;
      uint16_t EID11:1;
      uint16_t EID12:1;
      uint16_t EID13:1;
      uint16_t EID14:1;
      uint16_t EID15:1;
    };
    struct {
      uint16_t EID:16;
    };
  };
} C1RXF5EIDBITS;
extern volatile C1RXF5EIDBITS C1RXF5EIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF6SID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF6SIDBITS {
  union {
    struct {
      uint16_t EID16:1;
      uint16_t EID17:1;
      uint16_t :1;
      uint16_t EXIDE:1;
      uint16_t :1;
      uint16_t SID0:1;
      uint16_t SID1:1;
      uint16_t SID2:1;
      uint16_t SID3:1;
      uint16_t SID4:1;
      uint16_t SID5:1;
      uint16_t SID6:1;
      uint16_t SID7:1;
      uint16_t SID8:1;
      uint16_t SID9:1;
      uint16_t SID10:1;
    };
    struct {
      uint16_t EID:2;
      uint16_t :3;
      uint16_t SID:11;
    };
  };
} C1RXF6SIDBITS;
extern volatile C1RXF6SIDBITS C1RXF6SIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF6EID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF6EIDBITS {
  union {
    struct {
      uint16_t EID0:1;
      uint16_t EID1:1;
      uint16_t EID2:1;
      uint16_t EID3:1;
      uint16_t EID4:1;
      uint16_t EID5:1;
      uint16_t EID6:1;
      uint16_t EID7:1;
      uint16_t EID8:1;
      uint16_t EID9:1;
      uint16_t EID10:1;
      uint16_t EID11:1;
      uint16_t EID12:1;
      uint16_t EID13:1;
      uint16_t EID14:1;
      uint16_t EID15:1;
    };
    struct {
      uint16_t EID:16;
    };
  };
} C1RXF6EIDBITS;
extern volatile C1RXF6EIDBITS C1RXF6EIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF7SID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF7SIDBITS {
  union {
    struct {
      uint16_t EID16:1;
      uint16_t EID17:1;
      uint16_t :1;
      uint16_t EXIDE:1;
      uint16_t :1;
      uint16_t SID0:1;
      uint16_t SID1:1;
      uint16_t SID2:1;
      uint16_t SID3:1;
      uint16_t SID4:1;
      uint16_t SID5:1;
      uint16_t SID6:1;
      uint16_t SID7:1;
      uint16_t SID8:1;
      uint16_t SID9:1;
      uint16_t SID10:1;
    };
    struct {
      uint16_t EID:2;
      uint16_t :3;
      uint16_t SID:11;
    };
  };
} C1RXF7SIDBITS;
extern volatile C1RXF7SIDBITS C1RXF7SIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF7EID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF7EIDBITS {
  union {
    struct {
      uint16_t EID0:1;
      uint16_t EID1:1;
      uint16_t EID2:1;
      uint16_t EID3:1;
      uint16_t EID4:1;
      uint16_t EID5:1;
      uint16_t EID6:1;
      uint16_t EID7:1;
      uint16_t EID8:1;
      uint16_t EID9:1;
      uint16_t EID10:1;
      uint16_t EID11:1;
      uint16_t EID12:1;
      uint16_t EID13:1;
      uint16_t EID14:1;
      uint16_t EID15:1;
    };
    struct {
      uint16_t EID:16;
    };
  };
} C1RXF7EIDBITS;
extern volatile C1RXF7EIDBITS C1RXF7EIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF8SID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF8SIDBITS {
  union {
    struct {
      uint16_t EID16:1;
      uint16_t EID17:1;
      uint16_t :1;
      uint16_t EXIDE:1;
      uint16_t :1;
      uint16_t SID0:1;
      uint16_t SID1:1;
      uint16_t SID2:1;
      uint16_t SID3:1;
      uint16_t SID4:1;
      uint16_t SID5:1;
      uint16_t SID6:1;
      uint16_t SID7:1;
      uint16_t SID8:1;
      uint16_t SID9:1;
      uint16_t SID10:1;
    };
    struct {
      uint16_t EID:2;
      uint16_t :3;
      uint16_t SID:11;
    };
  };
} C1RXF8SIDBITS;
extern volatile C1RXF8SIDBITS C1RXF8SIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF8EID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF8EIDBITS {
  union {
    struct {
      uint16_t EID0:1;
      uint16_t EID1:1;
      uint16_t EID2:1;
      uint16_t EID3:1;
      uint16_t EID4:1;
      uint16_t EID5:1;
      uint16_t EID6:1;
      uint16_t EID7:1;
      uint16_t EID8:1;
      uint16_t EID9:1;
      uint16_t EID10:1;
      uint16_t EID11:1;
      uint16_t EID12:1;
      uint16_t EID13:1;
      uint16_t EID14:1;
      uint16_t EID15:1;
    };
    struct {
      uint16_t EID:16;
    };
  };
} C1RXF8EIDBITS;
extern volatile C1RXF8EIDBITS C1RXF8EIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF9SID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF9SIDBITS {
  union {
    struct {
      uint16_t EID16:1;
      uint16_t EID17:1;
      uint16_t :1;
      uint16_t EXIDE:1;
      uint16_t :1;
      uint16_t SID0:1;
      uint16_t SID1:1;
      uint16_t SID2:1;
      uint16_t SID3:1;
      uint16_t SID4:1;
      uint16_t SID5:1;
      uint16_t SID6:1;
      uint16_t SID7:1;
      uint16_t SID8:1;
      uint16_t SID9:1;
      uint16_t SID10:1;
    };
    struct {
      uint16_t EID:2;
      uint16_t :3;
      uint16_t SID:11;
    };
  };
} C1RXF9SIDBITS;
extern volatile C1RXF9SIDBITS C1RXF9SIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF9EID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF9EIDBITS {
  union {
    struct {
      uint16_t EID0:1;
      uint16_t EID1:1;
      uint16_t EID2:1;
      uint16_t EID3:1;
      uint16_t EID4:1;
      uint16_t EID5:1;
      uint16_t EID6:1;
      uint16_t EID7:1;
      uint16_t EID8:1;
      uint16_t EID9:1;
      uint16_t EID10:1;
      uint16_t EID11:1;
      uint16_t EID12:1;
      uint16_t EID13:1;
      uint16_t EID14:1;
      uint16_t EID15:1;
    };
    struct {
      uint16_t EID:16;
    };
  };
} C1RXF9EIDBITS;
extern volatile C1RXF9EIDBITS C1RXF9EIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF10SID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF10SIDBITS {
  union {
    struct {
      uint16_t EID16:1;
      uint16_t EID17:1;
      uint16_t :1;
      uint16_t EXIDE:1;
      uint16_t :1;
      uint16_t SID0:1;
      uint16_t SID1:1;
      uint16_t SID2:1;
      uint16_t SID3:1;
      uint16_t SID4:1;
      uint16_t SID5:1;
      uint16_t SID6:1;
      uint16_t SID7:1;
      uint16_t SID8:1;
      uint16_t SID9:1;
      uint16_t SID10:1;
    };
    struct {
      uint16_t EID:2;
      uint16_t :3;
      uint16_t SID:11;
    };
  };
} C1RXF10SIDBITS;
extern volatile C1RXF10SIDBITS C1RXF10SIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF10EID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF10EIDBITS {
  union {
    struct {
      uint16_t EID0:1;
      uint16_t EID1:1;
      uint16_t EID2:1;
      uint16_t EID3:1;
      uint16_t EID4:1;
      uint16_t EID5:1;
      uint16_t EID6:1;
      uint16_t EID7:1;
      uint16_t EID8:1;
      uint16_t EID9:1;
      uint16_t EID10:1;
      uint16_t EID11:1;
      uint16_t EID12:1;
      uint16_t EID13:1;
      uint16_t EID14:1;
      uint16_t EID15:1;
    };
    struct {
      uint16_t EID:16;
    };
  };
} C1RXF10EIDBITS;
extern volatile C1RXF10EIDBITS C1RXF10EIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF11SID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF11SIDBITS {
  union {
    struct {
      uint16_t EID16:1;
      uint16_t EID17:1;
      uint16_t :1;
      uint16_t EXIDE:1;
      uint16_t :1;
      uint16_t SID0:1;
      uint16_t SID1:1;
      uint16_t SID2:1;
      uint16_t SID3:1;
      uint16_t SID4:1;
      uint16_t SID5:1;
      uint16_t SID6:1;
      uint16_t SID7:1;
      uint16_t SID8:1;
      uint16_t SID9:1;
      uint16_t SID10:1;
    };
    struct {
      uint16_t EID:2;
      uint16_t :3;
      uint16_t SID:11;
    };
  };
} C1RXF11SIDBITS;
extern volatile C1RXF11SIDBITS C1RXF11SIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF11EID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF11EIDBITS {
  union {
    struct {
      uint16_t EID0:1;
      uint16_t EID1:1;
      uint16_t EID2:1;
      uint16_t EID3:1;
      uint16_t EID4:1;
      uint16_t EID5:1;
      uint16_t EID6:1;
      uint16_t EID7:1;
      uint16_t EID8:1;
      uint16_t EID9:1;
      uint16_t EID10:1;
      uint16_t EID11:1;
      uint16_t EID12:1;
      uint16_t EID13:1;
      uint16_t EID14:1;
      uint16_t EID15:1;
    };
    struct {
      uint16_t EID:16;
    };
  };
} C1RXF11EIDBITS;
extern volatile C1RXF11EIDBITS C1RXF11EIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF12SID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF12SIDBITS {
  union {
    struct {
      uint16_t EID16:1;
      uint16_t EID17:1;
      uint16_t :1;
      uint16_t EXIDE:1;
      uint16_t :1;
      uint16_t SID0:1;
      uint16_t SID1:1;
      uint16_t SID2:1;
      uint16_t SID3:1;
      uint16_t SID4:1;
      uint16_t SID5:1;
      uint16_t SID6:1;
      uint16_t SID7:1;
      uint16_t SID8:1;
      uint16_t SID9:1;
      uint16_t SID10:1;
    };
    struct {
      uint16_t EID:2;
      uint16_t :3;
      uint16_t SID:11;
    };
  };
} C1RXF12SIDBITS;
extern volatile C1RXF12SIDBITS C1RXF12SIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF12EID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF12EIDBITS {
  union {
    struct {
      uint16_t EID0:1;
      uint16_t EID1:1;
      uint16_t EID2:1;
      uint16_t EID3:1;
      uint16_t EID4:1;
      uint16_t EID5:1;
      uint16_t EID6:1;
      uint16_t EID7:1;
      uint16_t EID8:1;
      uint16_t EID9:1;
      uint16_t EID10:1;
      uint16_t EID11:1;
      uint16_t EID12:1;
      uint16_t EID13:1;
      uint16_t EID14:1;
      uint16_t EID15:1;
    };
    struct {
      uint16_t EID:16;
    };
  };
} C1RXF12EIDBITS;
extern volatile C1RXF12EIDBITS C1RXF12EIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF13SID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF13SIDBITS {
  union {
    struct {
      uint16_t EID16:1;
      uint16_t EID17:1;
      uint16_t :1;
      uint16_t EXIDE:1;
      uint16_t :1;
      uint16_t SID0:1;
      uint16_t SID1:1;
      uint16_t SID2:1;
      uint16_t SID3:1;
      uint16_t SID4:1;
      uint16_t SID5:1;
      uint16_t SID6:1;
      uint16_t SID7:1;
      uint16_t SID8:1;
      uint16_t SID9:1;
      uint16_t SID10:1;
    };
    struct {
      uint16_t EID:2;
      uint16_t :3;
      uint16_t SID:11;
    };
  };
} C1RXF13SIDBITS;
extern volatile C1RXF13SIDBITS C1RXF13SIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF13EID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF13EIDBITS {
  union {
    struct {
      uint16_t EID0:1;
      uint16_t EID1:1;
      uint16_t EID2:1;
      uint16_t EID3:1;
      uint16_t EID4:1;
      uint16_t EID5:1;
      uint16_t EID6:1;
      uint16_t EID7:1;
      uint16_t EID8:1;
      uint16_t EID9:1;
      uint16_t EID10:1;
      uint16_t EID11:1;
      uint16_t EID12:1;
      uint16_t EID13:1;
      uint16_t EID14:1;
      uint16_t EID15:1;
    };
    struct {
      uint16_t EID:16;
    };
  };
} C1RXF13EIDBITS;
extern volatile C1RXF13EIDBITS C1RXF13EIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF14SID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF14SIDBITS {
  union {
    struct {
      uint16_t EID16:1;
      uint16_t EID17:1;
      uint16_t :1;
      uint16_t EXIDE:1;
      uint16_t :1;
      uint16_t SID0:1;
      uint16_t SID1:1;
      uint16_t SID2:1;
      uint16_t SID3:1;
      uint16_t SID4:1;
      uint16_t SID5:1;
      uint16_t SID6:1;
      uint16_t SID7:1;
      uint16_t SID8:1;
      uint16_t SID9:1;
      uint16_t SID10:1;
    };
    struct {
      uint16_t EID:2;
      uint16_t :3;
      uint16_t SID:11;
    };
  };
} C1RXF14SIDBITS;
extern volatile C1RXF14SIDBITS C1RXF14SIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF14EID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF14EIDBITS {
  union {
    struct {
      uint16_t EID0:1;
      uint16_t EID1:1;
      uint16_t EID2:1;
      uint16_t EID3:1;
      uint16_t EID4:1;
      uint16_t EID5:1;
      uint16_t EID6:1;
      uint16_t EID7:1;
      uint16_t EID8:1;
      uint16_t EID9:1;
      uint16_t EID10:1;
      uint16_t EID11:1;
      uint16_t EID12:1;
      uint16_t EID13:1;
      uint16_t EID14:1;
      uint16_t EID15:1;
    };
    struct {
      uint16_t EID:16;
    };
  };
} C1RXF14EIDBITS;
extern volatile C1RXF14EIDBITS C1RXF14EIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF15SID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF15SIDBITS {
  union {
    struct {
      uint16_t EID16:1;
      uint16_t EID17:1;
      uint16_t :1;
      uint16_t EXIDE:1;
      uint16_t :1;
      uint16_t SID0:1;
      uint16_t SID1:1;
      uint16_t SID2:1;
      uint16_t SID3:1;
      uint16_t SID4:1;
      uint16_t SID5:1;
      uint16_t SID6:1;
      uint16_t SID7:1;
      uint16_t SID8:1;
      uint16_t SID9:1;
      uint16_t SID10:1;
    };
    struct {
      uint16_t EID:2;
      uint16_t :3;
      uint16_t SID:11;
    };
  };
} C1RXF15SIDBITS;
extern volatile C1RXF15SIDBITS C1RXF15SIDbits __attribute__((__sfr__));


extern volatile uint16_t C1RXF15EID __attribute__((__sfr__));
__extension__ typedef struct tagC1RXF15EIDBITS {
  union {
    struct {
      uint16_t EID0:1;
      uint16_t EID1:1;
      uint16_t EID2:1;
      uint16_t EID3:1;
      uint16_t EID4:1;
      uint16_t EID5:1;
      uint16_t EID6:1;
      uint16_t EID7:1;
      uint16_t EID8:1;
      uint16_t EID9:1;
      uint16_t EID10:1;
      uint16_t EID11:1;
      uint16_t EID12:1;
      uint16_t EID13:1;
      uint16_t EID14:1;
      uint16_t EID15:1;
    };
    struct {
      uint16_t EID:16;
    };
  };
} C1RXF15EIDBITS;
extern volatile C1RXF15EIDBITS C1RXF15EIDbits __attribute__((__sfr__));


extern volatile uint16_t SENT1CON1 __attribute__((__sfr__));
typedef struct tagSENT1CON1BITS {
  uint16_t NIBCNT:3;
  uint16_t :1;
  uint16_t PS:1;
  uint16_t :1;
  uint16_t SPCEN:1;
  uint16_t PPP:1;
  uint16_t CRCEN:1;
  uint16_t TXPOL:1;
  uint16_t TXM:1;
  uint16_t RCVEN:1;
  uint16_t :1;
  uint16_t SNTSIDL:1;
  uint16_t :1;
  uint16_t SNTEN:1;
} SENT1CON1BITS;
extern volatile SENT1CON1BITS SENT1CON1bits __attribute__((__sfr__));


extern volatile uint16_t SENT1CON2 __attribute__((__sfr__));

extern volatile uint16_t SENT1CON3 __attribute__((__sfr__));

extern volatile uint16_t SENT1STAT __attribute__((__sfr__));
__extension__ typedef struct tagSENT1STATBITS {
  union {
    struct {
      uint16_t SYNCTXEN:1;
      uint16_t RXIDLE:1;
      uint16_t FRMERR:1;
      uint16_t CRCERR:1;
      uint16_t NIB:3;
      uint16_t PAUSE:1;
    };
    struct {
      uint16_t SYNC:1;
      uint16_t :3;
      uint16_t NIB0:1;
      uint16_t NIB1:1;
      uint16_t NIB2:1;
    };
    struct {
      uint16_t TXEN:1;
    };
  };
} SENT1STATBITS;
extern volatile SENT1STATBITS SENT1STATbits __attribute__((__sfr__));


extern volatile uint16_t SENT1SYNC __attribute__((__sfr__));

extern volatile uint16_t SENT1DATL __attribute__((__sfr__));
__extension__ typedef struct tagSENT1DATLBITS {
  union {
    struct {
      uint16_t CRC:4;
      uint16_t DATA6:4;
      uint16_t DATA5:4;
      uint16_t DATA4:4;
    };
    struct {
      uint16_t CRC0:1;
      uint16_t CRC1:1;
      uint16_t CRC2:1;
      uint16_t CRC3:1;
      uint16_t DATA60:1;
      uint16_t DATA61:1;
      uint16_t DATA62:1;
      uint16_t DATA63:1;
      uint16_t DATA50:1;
      uint16_t DATA51:1;
      uint16_t DATA52:1;
      uint16_t DATA53:1;
      uint16_t DATA40:1;
      uint16_t DATA41:1;
      uint16_t DATA42:1;
      uint16_t DATA43:1;
    };
  };
} SENT1DATLBITS;
extern volatile SENT1DATLBITS SENT1DATLbits __attribute__((__sfr__));


extern volatile uint16_t SENT1DATH __attribute__((__sfr__));
__extension__ typedef struct tagSENT1DATHBITS {
  union {
    struct {
      uint16_t DATA3:4;
      uint16_t DATA2:4;
      uint16_t DATA1:4;
      uint16_t STAT:4;
    };
    struct {
      uint16_t DATA30:1;
      uint16_t DATA31:1;
      uint16_t DATA32:1;
      uint16_t DATA33:1;
      uint16_t DATA20:1;
      uint16_t DATA21:1;
      uint16_t DATA22:1;
      uint16_t DATA23:1;
      uint16_t DATA10:1;
      uint16_t DATA11:1;
      uint16_t DATA12:1;
      uint16_t DATA13:1;
      uint16_t STAT0:1;
      uint16_t STAT1:1;
      uint16_t STAT2:1;
      uint16_t STAT3:1;
    };
  };
} SENT1DATHBITS;
extern volatile SENT1DATHBITS SENT1DATHbits __attribute__((__sfr__));


extern volatile uint16_t SENT2CON1 __attribute__((__sfr__));
typedef struct tagSENT2CON1BITS {
  uint16_t NIBCNT:3;
  uint16_t :1;
  uint16_t PS:1;
  uint16_t :1;
  uint16_t SPCEN:1;
  uint16_t PPP:1;
  uint16_t CRCEN:1;
  uint16_t TXPOL:1;
  uint16_t TXM:1;
  uint16_t RCVEN:1;
  uint16_t :1;
  uint16_t SNTSIDL:1;
  uint16_t :1;
  uint16_t SNTEN:1;
} SENT2CON1BITS;
extern volatile SENT2CON1BITS SENT2CON1bits __attribute__((__sfr__));


extern volatile uint16_t SENT2CON2 __attribute__((__sfr__));

extern volatile uint16_t SENT2CON3 __attribute__((__sfr__));

extern volatile uint16_t SENT2STAT __attribute__((__sfr__));
__extension__ typedef struct tagSENT2STATBITS {
  union {
    struct {
      uint16_t SYNCTXEN:1;
      uint16_t RXIDLE:1;
      uint16_t FRMERR:1;
      uint16_t CRCERR:1;
      uint16_t NIB:3;
      uint16_t PAUSE:1;
    };
    struct {
      uint16_t SYNC:1;
      uint16_t :3;
      uint16_t NIB0:1;
      uint16_t NIB1:1;
      uint16_t NIB2:1;
    };
    struct {
      uint16_t TXEN:1;
    };
  };
} SENT2STATBITS;
extern volatile SENT2STATBITS SENT2STATbits __attribute__((__sfr__));


extern volatile uint16_t SENT2SYNC __attribute__((__sfr__));

extern volatile uint16_t SENT2DATL __attribute__((__sfr__));
__extension__ typedef struct tagSENT2DATLBITS {
  union {
    struct {
      uint16_t CRC:4;
      uint16_t DATA6:4;
      uint16_t DATA5:4;
      uint16_t DATA4:4;
    };
    struct {
      uint16_t CRC0:1;
      uint16_t CRC1:1;
      uint16_t CRC2:1;
      uint16_t CRC3:1;
      uint16_t DATA60:1;
      uint16_t DATA61:1;
      uint16_t DATA62:1;
      uint16_t DATA63:1;
      uint16_t DATA50:1;
      uint16_t DATA51:1;
      uint16_t DATA52:1;
      uint16_t DATA53:1;
      uint16_t DATA40:1;
      uint16_t DATA41:1;
      uint16_t DATA42:1;
      uint16_t DATA43:1;
    };
  };
} SENT2DATLBITS;
extern volatile SENT2DATLBITS SENT2DATLbits __attribute__((__sfr__));


extern volatile uint16_t SENT2DATH __attribute__((__sfr__));
__extension__ typedef struct tagSENT2DATHBITS {
  union {
    struct {
      uint16_t DATA3:4;
      uint16_t DATA2:4;
      uint16_t DATA1:4;
      uint16_t STAT:4;
    };
    struct {
      uint16_t DATA30:1;
      uint16_t DATA31:1;
      uint16_t DATA32:1;
      uint16_t DATA33:1;
      uint16_t DATA20:1;
      uint16_t DATA21:1;
      uint16_t DATA22:1;
      uint16_t DATA23:1;
      uint16_t DATA10:1;
      uint16_t DATA11:1;
      uint16_t DATA12:1;
      uint16_t DATA13:1;
      uint16_t STAT0:1;
      uint16_t STAT1:1;
      uint16_t STAT2:1;
      uint16_t STAT3:1;
    };
  };
} SENT2DATHBITS;
extern volatile SENT2DATHBITS SENT2DATHbits __attribute__((__sfr__));


extern volatile uint16_t RPOR0 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR0BITS {
  union {
    struct {
      uint16_t RP20R:6;
      uint16_t :2;
      uint16_t RP35R:6;
    };
    struct {
      uint16_t RP20R0:1;
      uint16_t RP20R1:1;
      uint16_t RP20R2:1;
      uint16_t RP20R3:1;
      uint16_t RP20R4:1;
      uint16_t RP20R5:1;
      uint16_t :2;
      uint16_t RP35R0:1;
      uint16_t RP35R1:1;
      uint16_t RP35R2:1;
      uint16_t RP35R3:1;
      uint16_t RP35R4:1;
      uint16_t RP35R5:1;
    };
  };
} RPOR0BITS;
extern volatile RPOR0BITS RPOR0bits __attribute__((__sfr__));


extern volatile uint16_t RPOR1 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR1BITS {
  union {
    struct {
      uint16_t RP36R:6;
      uint16_t :2;
      uint16_t RP37R:6;
    };
    struct {
      uint16_t RP36R0:1;
      uint16_t RP36R1:1;
      uint16_t RP36R2:1;
      uint16_t RP36R3:1;
      uint16_t RP36R4:1;
      uint16_t RP36R5:1;
      uint16_t :2;
      uint16_t RP37R0:1;
      uint16_t RP37R1:1;
      uint16_t RP37R2:1;
      uint16_t RP37R3:1;
      uint16_t RP37R4:1;
      uint16_t RP37R5:1;
    };
  };
} RPOR1BITS;
extern volatile RPOR1BITS RPOR1bits __attribute__((__sfr__));


extern volatile uint16_t RPOR2 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR2BITS {
  union {
    struct {
      uint16_t RP38R:6;
      uint16_t :2;
      uint16_t RP39R:6;
    };
    struct {
      uint16_t RP38R0:1;
      uint16_t RP38R1:1;
      uint16_t RP38R2:1;
      uint16_t RP38R3:1;
      uint16_t RP38R4:1;
      uint16_t RP38R5:1;
      uint16_t :2;
      uint16_t RP39R0:1;
      uint16_t RP39R1:1;
      uint16_t RP39R2:1;
      uint16_t RP39R3:1;
      uint16_t RP39R4:1;
      uint16_t RP39R5:1;
    };
  };
} RPOR2BITS;
extern volatile RPOR2BITS RPOR2bits __attribute__((__sfr__));


extern volatile uint16_t RPOR3 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR3BITS {
  union {
    struct {
      uint16_t RP40R:6;
      uint16_t :2;
      uint16_t RP41R:6;
    };
    struct {
      uint16_t RP40R0:1;
      uint16_t RP40R1:1;
      uint16_t RP40R2:1;
      uint16_t RP40R3:1;
      uint16_t RP40R4:1;
      uint16_t RP40R5:1;
      uint16_t :2;
      uint16_t RP41R0:1;
      uint16_t RP41R1:1;
      uint16_t RP41R2:1;
      uint16_t RP41R3:1;
      uint16_t RP41R4:1;
      uint16_t RP41R5:1;
    };
  };
} RPOR3BITS;
extern volatile RPOR3BITS RPOR3bits __attribute__((__sfr__));


extern volatile uint16_t RPOR4 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR4BITS {
  union {
    struct {
      uint16_t RP42R:6;
      uint16_t :2;
      uint16_t RP43R:6;
    };
    struct {
      uint16_t RP42R0:1;
      uint16_t RP42R1:1;
      uint16_t RP42R2:1;
      uint16_t RP42R3:1;
      uint16_t RP42R4:1;
      uint16_t RP42R5:1;
      uint16_t :2;
      uint16_t RP43R0:1;
      uint16_t RP43R1:1;
      uint16_t RP43R2:1;
      uint16_t RP43R3:1;
      uint16_t RP43R4:1;
      uint16_t RP43R5:1;
    };
  };
} RPOR4BITS;
extern volatile RPOR4BITS RPOR4bits __attribute__((__sfr__));


extern volatile uint16_t RPOR5 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR5BITS {
  union {
    struct {
      uint16_t RP48R:6;
      uint16_t :2;
      uint16_t RP49R:6;
    };
    struct {
      uint16_t RP48R0:1;
      uint16_t RP48R1:1;
      uint16_t RP48R2:1;
      uint16_t RP48R3:1;
      uint16_t RP48R4:1;
      uint16_t RP48R5:1;
      uint16_t :2;
      uint16_t RP49R0:1;
      uint16_t RP49R1:1;
      uint16_t RP49R2:1;
      uint16_t RP49R3:1;
      uint16_t RP49R4:1;
      uint16_t RP49R5:1;
    };
  };
} RPOR5BITS;
extern volatile RPOR5BITS RPOR5bits __attribute__((__sfr__));


extern volatile uint16_t RPOR6 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR6BITS {
  union {
    struct {
      uint16_t RP54R:6;
      uint16_t :2;
      uint16_t RP55R:6;
    };
    struct {
      uint16_t RP54R0:1;
      uint16_t RP54R1:1;
      uint16_t RP54R2:1;
      uint16_t RP54R3:1;
      uint16_t RP54R4:1;
      uint16_t RP54R5:1;
      uint16_t :2;
      uint16_t RP55R0:1;
      uint16_t RP55R1:1;
      uint16_t RP55R2:1;
      uint16_t RP55R3:1;
      uint16_t RP55R4:1;
      uint16_t RP55R5:1;
    };
  };
} RPOR6BITS;
extern volatile RPOR6BITS RPOR6bits __attribute__((__sfr__));


extern volatile uint16_t RPOR7 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR7BITS {
  union {
    struct {
      uint16_t RP56R:6;
      uint16_t :2;
      uint16_t RP57R:6;
    };
    struct {
      uint16_t RP56R0:1;
      uint16_t RP56R1:1;
      uint16_t RP56R2:1;
      uint16_t RP56R3:1;
      uint16_t RP56R4:1;
      uint16_t RP56R5:1;
      uint16_t :2;
      uint16_t RP57R0:1;
      uint16_t RP57R1:1;
      uint16_t RP57R2:1;
      uint16_t RP57R3:1;
      uint16_t RP57R4:1;
      uint16_t RP57R5:1;
    };
  };
} RPOR7BITS;
extern volatile RPOR7BITS RPOR7bits __attribute__((__sfr__));


extern volatile uint16_t RPOR8 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR8BITS {
  union {
    struct {
      uint16_t RP69R:6;
      uint16_t :2;
      uint16_t RP70R:6;
    };
    struct {
      uint16_t RP69R0:1;
      uint16_t RP69R1:1;
      uint16_t RP69R2:1;
      uint16_t RP69R3:1;
      uint16_t RP69R4:1;
      uint16_t RP69R5:1;
      uint16_t :2;
      uint16_t RP70R0:1;
      uint16_t RP70R1:1;
      uint16_t RP70R2:1;
      uint16_t RP70R3:1;
      uint16_t RP70R4:1;
      uint16_t RP70R5:1;
    };
  };
} RPOR8BITS;
extern volatile RPOR8BITS RPOR8bits __attribute__((__sfr__));


extern volatile uint16_t RPOR9 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR9BITS {
  union {
    struct {
      uint16_t RP97R:6;
      uint16_t :2;
      uint16_t RP118R:6;
    };
    struct {
      uint16_t RP97R0:1;
      uint16_t RP97R1:1;
      uint16_t RP97R2:1;
      uint16_t RP97R3:1;
      uint16_t RP97R4:1;
      uint16_t RP97R5:1;
      uint16_t :2;
      uint16_t RP118R0:1;
      uint16_t RP118R1:1;
      uint16_t RP118R2:1;
      uint16_t RP118R3:1;
      uint16_t RP118R4:1;
      uint16_t RP118R5:1;
    };
  };
} RPOR9BITS;
extern volatile RPOR9BITS RPOR9bits __attribute__((__sfr__));


extern volatile uint16_t RPOR10 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR10BITS {
  union {
    struct {
      uint16_t RP120R:6;
      uint16_t :2;
      uint16_t RP176R:6;
    };
    struct {
      uint16_t RP120R0:1;
      uint16_t RP120R1:1;
      uint16_t RP120R2:1;
      uint16_t RP120R3:1;
      uint16_t RP120R4:1;
      uint16_t RP120R5:1;
      uint16_t :2;
      uint16_t RP176R0:1;
      uint16_t RP176R1:1;
      uint16_t RP176R2:1;
      uint16_t RP176R3:1;
      uint16_t RP176R4:1;
      uint16_t RP176R5:1;
    };
  };
} RPOR10BITS;
extern volatile RPOR10BITS RPOR10bits __attribute__((__sfr__));


extern volatile uint16_t RPOR11 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR11BITS {
  union {
    struct {
      uint16_t RP177R:6;
      uint16_t :2;
      uint16_t RP178R:6;
    };
    struct {
      uint16_t RP177R0:1;
      uint16_t RP177R1:1;
      uint16_t RP177R2:1;
      uint16_t RP177R3:1;
      uint16_t RP177R4:1;
      uint16_t RP177R5:1;
      uint16_t :2;
      uint16_t RP178R0:1;
      uint16_t RP178R1:1;
      uint16_t RP178R2:1;
      uint16_t RP178R3:1;
      uint16_t RP178R4:1;
      uint16_t RP178R5:1;
    };
  };
} RPOR11BITS;
extern volatile RPOR11BITS RPOR11bits __attribute__((__sfr__));


extern volatile uint16_t RPOR12 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR12BITS {
  union {
    struct {
      uint16_t RP179R:6;
      uint16_t :2;
      uint16_t RP180R:6;
    };
    struct {
      uint16_t RP179R0:1;
      uint16_t RP179R1:1;
      uint16_t RP179R2:1;
      uint16_t RP179R3:1;
      uint16_t RP179R4:1;
      uint16_t RP179R5:1;
      uint16_t :2;
      uint16_t RP180R0:1;
      uint16_t RP180R1:1;
      uint16_t RP180R2:1;
      uint16_t RP180R3:1;
      uint16_t RP180R4:1;
      uint16_t RP180R5:1;
    };
  };
} RPOR12BITS;
extern volatile RPOR12BITS RPOR12bits __attribute__((__sfr__));


extern volatile uint16_t RPOR13 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR13BITS {
  union {
    struct {
      uint16_t RP181R:6;
    };
    struct {
      uint16_t RP181R0:1;
      uint16_t RP181R1:1;
      uint16_t RP181R2:1;
      uint16_t RP181R3:1;
      uint16_t RP181R4:1;
      uint16_t RP181R5:1;
    };
  };
} RPOR13BITS;
extern volatile RPOR13BITS RPOR13bits __attribute__((__sfr__));


extern volatile uint16_t RPINR0 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR0BITS {
  union {
    struct {
      uint16_t :8;
      uint16_t INT1R:8;
    };
    struct {
      uint16_t :8;
      uint16_t INT1R0:1;
      uint16_t INT1R1:1;
      uint16_t INT1R2:1;
      uint16_t INT1R3:1;
      uint16_t INT1R4:1;
      uint16_t INT1R5:1;
      uint16_t INT1R6:1;
      uint16_t INT1R7:1;
    };
  };
} RPINR0BITS;
extern volatile RPINR0BITS RPINR0bits __attribute__((__sfr__));


extern volatile uint16_t RPINR1 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR1BITS {
  union {
    struct {
      uint16_t INT2R:8;
    };
    struct {
      uint16_t INT2R0:1;
      uint16_t INT2R1:1;
      uint16_t INT2R2:1;
      uint16_t INT2R3:1;
      uint16_t INT2R4:1;
      uint16_t INT2R5:1;
      uint16_t INT2R6:1;
      uint16_t INT2R7:1;
    };
  };
} RPINR1BITS;
extern volatile RPINR1BITS RPINR1bits __attribute__((__sfr__));


extern volatile uint16_t RPINR3 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR3BITS {
  union {
    struct {
      uint16_t T2CKR:8;
    };
    struct {
      uint16_t T2CKR0:1;
      uint16_t T2CKR1:1;
      uint16_t T2CKR2:1;
      uint16_t T2CKR3:1;
      uint16_t T2CKR4:1;
      uint16_t T2CKR5:1;
      uint16_t T2CKR6:1;
      uint16_t T2CKR7:1;
    };
  };
} RPINR3BITS;
extern volatile RPINR3BITS RPINR3bits __attribute__((__sfr__));


extern volatile uint16_t RPINR7 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR7BITS {
  union {
    struct {
      uint16_t IC1R:8;
      uint16_t IC2R:8;
    };
    struct {
      uint16_t IC1R0:1;
      uint16_t IC1R1:1;
      uint16_t IC1R2:1;
      uint16_t IC1R3:1;
      uint16_t IC1R4:1;
      uint16_t IC1R5:1;
      uint16_t IC1R6:1;
      uint16_t IC1R7:1;
      uint16_t IC2R0:1;
      uint16_t IC2R1:1;
      uint16_t IC2R2:1;
      uint16_t IC2R3:1;
      uint16_t IC2R4:1;
      uint16_t IC2R5:1;
      uint16_t IC2R6:1;
      uint16_t IC2R7:1;
    };
  };
} RPINR7BITS;
extern volatile RPINR7BITS RPINR7bits __attribute__((__sfr__));


extern volatile uint16_t RPINR8 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR8BITS {
  union {
    struct {
      uint16_t IC3R:8;
      uint16_t IC4R:8;
    };
    struct {
      uint16_t IC3R0:1;
      uint16_t IC3R1:1;
      uint16_t IC3R2:1;
      uint16_t IC3R3:1;
      uint16_t IC3R4:1;
      uint16_t IC3R5:1;
      uint16_t IC3R6:1;
      uint16_t IC3R7:1;
      uint16_t IC4R0:1;
      uint16_t IC4R1:1;
      uint16_t IC4R2:1;
      uint16_t IC4R3:1;
      uint16_t IC4R4:1;
      uint16_t IC4R5:1;
      uint16_t IC4R6:1;
      uint16_t IC4R7:1;
    };
  };
} RPINR8BITS;
extern volatile RPINR8BITS RPINR8bits __attribute__((__sfr__));


extern volatile uint16_t RPINR11 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR11BITS {
  union {
    struct {
      uint16_t OCFAR:8;
    };
    struct {
      uint16_t OCFAR0:1;
      uint16_t OCFAR1:1;
      uint16_t OCFAR2:1;
      uint16_t OCFAR3:1;
      uint16_t OCFAR4:1;
      uint16_t OCFAR5:1;
      uint16_t OCFAR6:1;
      uint16_t OCFAR7:1;
    };
  };
} RPINR11BITS;
extern volatile RPINR11BITS RPINR11bits __attribute__((__sfr__));


extern volatile uint16_t RPINR12 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR12BITS {
  union {
    struct {
      uint16_t FLT1R:8;
      uint16_t FLT2R:8;
    };
    struct {
      uint16_t FLT1R0:1;
      uint16_t FLT1R1:1;
      uint16_t FLT1R2:1;
      uint16_t FLT1R3:1;
      uint16_t FLT1R4:1;
      uint16_t FLT1R5:1;
      uint16_t FLT1R6:1;
      uint16_t FLT1R7:1;
      uint16_t FLT2R0:1;
      uint16_t FLT2R1:1;
      uint16_t FLT2R2:1;
      uint16_t FLT2R3:1;
      uint16_t FLT2R4:1;
      uint16_t FLT2R5:1;
      uint16_t FLT2R6:1;
      uint16_t FLT2R7:1;
    };
  };
} RPINR12BITS;
extern volatile RPINR12BITS RPINR12bits __attribute__((__sfr__));


extern volatile uint16_t RPINR18 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR18BITS {
  union {
    struct {
      uint16_t U1RXR:8;
    };
    struct {
      uint16_t U1RXR0:1;
      uint16_t U1RXR1:1;
      uint16_t U1RXR2:1;
      uint16_t U1RXR3:1;
      uint16_t U1RXR4:1;
      uint16_t U1RXR5:1;
      uint16_t U1RXR6:1;
      uint16_t U1RXR7:1;
    };
  };
} RPINR18BITS;
extern volatile RPINR18BITS RPINR18bits __attribute__((__sfr__));


extern volatile uint16_t RPINR19 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR19BITS {
  union {
    struct {
      uint16_t U2RXR:8;
    };
    struct {
      uint16_t U2RXR0:1;
      uint16_t U2RXR1:1;
      uint16_t U2RXR2:1;
      uint16_t U2RXR3:1;
      uint16_t U2RXR4:1;
      uint16_t U2RXR5:1;
      uint16_t U2RXR6:1;
      uint16_t U2RXR7:1;
    };
  };
} RPINR19BITS;
extern volatile RPINR19BITS RPINR19bits __attribute__((__sfr__));


extern volatile uint16_t RPINR22 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR22BITS {
  union {
    struct {
      uint16_t SDI2R:8;
      uint16_t SCK2R:8;
    };
    struct {
      uint16_t SDI2R0:1;
      uint16_t SDI2R1:1;
      uint16_t SDI2R2:1;
      uint16_t SDI2R3:1;
      uint16_t SDI2R4:1;
      uint16_t SDI2R5:1;
      uint16_t SDI2R6:1;
      uint16_t SDI2R7:1;
      uint16_t SCK2R0:1;
      uint16_t SCK2R1:1;
      uint16_t SCK2R2:1;
      uint16_t SCK2R3:1;
      uint16_t SCK2R4:1;
      uint16_t SCK2R5:1;
      uint16_t SCK2R6:1;
      uint16_t SCK2R7:1;
    };
  };
} RPINR22BITS;
extern volatile RPINR22BITS RPINR22bits __attribute__((__sfr__));


extern volatile uint16_t RPINR23 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR23BITS {
  union {
    struct {
      uint16_t SS2R:8;
    };
    struct {
      uint16_t SS2R0:1;
      uint16_t SS2R1:1;
      uint16_t SS2R2:1;
      uint16_t SS2R3:1;
      uint16_t SS2R4:1;
      uint16_t SS2R5:1;
      uint16_t SS2R6:1;
      uint16_t SS2R7:1;
    };
  };
} RPINR23BITS;
extern volatile RPINR23BITS RPINR23bits __attribute__((__sfr__));


extern volatile uint16_t RPINR26 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR26BITS {
  union {
    struct {
      uint16_t C1RXR:8;
    };
    struct {
      uint16_t C1RXR0:1;
      uint16_t C1RXR1:1;
      uint16_t C1RXR2:1;
      uint16_t C1RXR3:1;
      uint16_t C1RXR4:1;
      uint16_t C1RXR5:1;
      uint16_t C1RXR6:1;
      uint16_t C1RXR7:1;
    };
  };
} RPINR26BITS;
extern volatile RPINR26BITS RPINR26bits __attribute__((__sfr__));


extern volatile uint16_t RPINR37 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR37BITS {
  union {
    struct {
      uint16_t :8;
      uint16_t SYNCI1R:8;
    };
    struct {
      uint16_t :8;
      uint16_t SYNCI1R0:1;
      uint16_t SYNCI1R1:1;
      uint16_t SYNCI1R2:1;
      uint16_t SYNCI1R3:1;
      uint16_t SYNCI1R4:1;
      uint16_t SYNCI1R5:1;
      uint16_t SYNCI1R6:1;
      uint16_t SYNCI1R7:1;
    };
  };
} RPINR37BITS;
extern volatile RPINR37BITS RPINR37bits __attribute__((__sfr__));


extern volatile uint16_t RPINR38 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR38BITS {
  union {
    struct {
      uint16_t :8;
      uint16_t DTCMP1R:8;
    };
    struct {
      uint16_t :8;
      uint16_t DTCMP1R0:1;
      uint16_t DTCMP1R1:1;
      uint16_t DTCMP1R2:1;
      uint16_t DTCMP1R3:1;
      uint16_t DTCMP1R4:1;
      uint16_t DTCMP1R5:1;
      uint16_t DTCMP1R6:1;
      uint16_t DTCMP1R7:1;
    };
  };
} RPINR38BITS;
extern volatile RPINR38BITS RPINR38bits __attribute__((__sfr__));


extern volatile uint16_t RPINR39 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR39BITS {
  union {
    struct {
      uint16_t DTCMP2R:8;
      uint16_t DTCMP3R:8;
    };
    struct {
      uint16_t DTCMP2R0:1;
      uint16_t DTCMP2R1:1;
      uint16_t DTCMP2R2:1;
      uint16_t DTCMP2R3:1;
      uint16_t DTCMP2R4:1;
      uint16_t DTCMP2R5:1;
      uint16_t DTCMP2R6:1;
      uint16_t DTCMP2R7:1;
      uint16_t DTCMP3R0:1;
      uint16_t DTCMP3R1:1;
      uint16_t DTCMP3R2:1;
      uint16_t DTCMP3R3:1;
      uint16_t DTCMP3R4:1;
      uint16_t DTCMP3R5:1;
      uint16_t DTCMP3R6:1;
      uint16_t DTCMP3R7:1;
    };
  };
} RPINR39BITS;
extern volatile RPINR39BITS RPINR39bits __attribute__((__sfr__));


extern volatile uint16_t RPINR44 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR44BITS {
  union {
    struct {
      uint16_t :8;
      uint16_t SENT1R:8;
    };
    struct {
      uint16_t :8;
      uint16_t SENT1R0:1;
      uint16_t SENT1R1:1;
      uint16_t SENT1R2:1;
      uint16_t SENT1R3:1;
      uint16_t SENT1R4:1;
      uint16_t SENT1R5:1;
      uint16_t SENT1R6:1;
      uint16_t SENT1R7:1;
    };
  };
} RPINR44BITS;
extern volatile RPINR44BITS RPINR44bits __attribute__((__sfr__));


extern volatile uint16_t RPINR45 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR45BITS {
  union {
    struct {
      uint16_t SENT2R:8;
    };
    struct {
      uint16_t SENT2R0:1;
      uint16_t SENT2R1:1;
      uint16_t SENT2R2:1;
      uint16_t SENT2R3:1;
      uint16_t SENT2R4:1;
      uint16_t SENT2R5:1;
      uint16_t SENT2R6:1;
      uint16_t SENT2R7:1;
    };
  };
} RPINR45BITS;
extern volatile RPINR45BITS RPINR45bits __attribute__((__sfr__));


extern volatile uint16_t DMTCON __attribute__((__sfr__));
typedef struct tagDMTCONBITS {
  uint16_t :15;
  uint16_t ON:1;
} DMTCONBITS;
extern volatile DMTCONBITS DMTCONbits __attribute__((__sfr__));


extern volatile uint16_t DMTPRECLR __attribute__((__sfr__));
typedef struct tagDMTPRECLRBITS {
  uint16_t :8;
  uint16_t STEP1:8;
} DMTPRECLRBITS;
extern volatile DMTPRECLRBITS DMTPRECLRbits __attribute__((__sfr__));


extern volatile uint16_t DMTCLR __attribute__((__sfr__));
typedef struct tagDMTCLRBITS {
  uint16_t STEP2:8;
} DMTCLRBITS;
extern volatile DMTCLRBITS DMTCLRbits __attribute__((__sfr__));


extern volatile uint16_t DMTSTAT __attribute__((__sfr__));
typedef struct tagDMTSTATBITS {
  uint16_t WINOPN:1;
  uint16_t :4;
  uint16_t DMTEVENT:1;
  uint16_t BAD2:1;
  uint16_t BAD1:1;
} DMTSTATBITS;
extern volatile DMTSTATBITS DMTSTATbits __attribute__((__sfr__));


extern volatile uint16_t DMTCNTL __attribute__((__sfr__));

extern volatile uint16_t DMTCNTH __attribute__((__sfr__));

extern volatile uint16_t DMTHOLDREG __attribute__((__sfr__));

extern volatile uint16_t DMTPSCNTL __attribute__((__sfr__));

extern volatile uint16_t DMTPSCNTH __attribute__((__sfr__));

extern volatile uint16_t DMTPSINTVL __attribute__((__sfr__));

extern volatile uint16_t DMTPSINTVH __attribute__((__sfr__));

extern volatile uint16_t NVMCON __attribute__((__sfr__));
__extension__ typedef struct tagNVMCONBITS {
  union {
    struct {
      uint16_t NVMOP:4;
      uint16_t :4;
      uint16_t URERR:1;
      uint16_t RPDF:1;
      uint16_t :2;
      uint16_t NVMSIDL:1;
      uint16_t WRERR:1;
      uint16_t WREN:1;
      uint16_t WR:1;
    };
    struct {
      uint16_t NVMOP0:1;
      uint16_t NVMOP1:1;
      uint16_t NVMOP2:1;
      uint16_t NVMOP3:1;
    };
  };
} NVMCONBITS;
extern volatile NVMCONBITS NVMCONbits __attribute__((__sfr__));


extern volatile uint16_t NVMADR __attribute__((__sfr__));

extern volatile uint16_t NVMADRU __attribute__((__sfr__));
typedef struct tagNVMADRUBITS {
  uint16_t NVMADRU:8;
} NVMADRUBITS;
extern volatile NVMADRUBITS NVMADRUbits __attribute__((__sfr__));


extern volatile uint16_t NVMKEY __attribute__((__sfr__));

extern volatile uint16_t NVMSRCADRL __attribute__((__sfr__));

extern volatile uint16_t NVMSRCADRH __attribute__((__sfr__));
typedef struct tagNVMSRCADRHBITS {
  uint16_t NVMSRCADRH:8;
} NVMSRCADRHBITS;
extern volatile NVMSRCADRHBITS NVMSRCADRHbits __attribute__((__sfr__));


extern volatile uint16_t RCON __attribute__((__sfr__));
typedef struct tagRCONBITS {
  uint16_t POR:1;
  uint16_t BOR:1;
  uint16_t IDLE:1;
  uint16_t SLEEP:1;
  uint16_t WDTO:1;
  uint16_t SWDTEN:1;
  uint16_t SWR:1;
  uint16_t EXTR:1;
  uint16_t VREGS:1;
  uint16_t CM:1;
  uint16_t :1;
  uint16_t VREGSF:1;
  uint16_t :2;
  uint16_t IOPUWR:1;
  uint16_t TRAPR:1;
} RCONBITS;
extern volatile RCONBITS RCONbits __attribute__((__sfr__));


extern volatile uint16_t OSCCON __attribute__((__sfr__));
__extension__ typedef struct tagOSCCONBITS {
  union {
    struct {
      uint16_t OSWEN:1;
      uint16_t :2;
      uint16_t CF:1;
      uint16_t :1;
      uint16_t LOCK:1;
      uint16_t IOLOCK:1;
      uint16_t CLKLOCK:1;
      uint16_t NOSC:3;
      uint16_t :1;
      uint16_t COSC:3;
    };
    struct {
      uint16_t :8;
      uint16_t NOSC0:1;
      uint16_t NOSC1:1;
      uint16_t NOSC2:1;
      uint16_t :1;
      uint16_t COSC0:1;
      uint16_t COSC1:1;
      uint16_t COSC2:1;
    };
  };
} OSCCONBITS;
extern volatile OSCCONBITS OSCCONbits __attribute__((__sfr__));


extern volatile uint8_t OSCCONL __attribute__((__sfr__));

extern volatile uint8_t OSCCONH __attribute__((__sfr__));

extern volatile uint16_t CLKDIV __attribute__((__sfr__));
__extension__ typedef struct tagCLKDIVBITS {
  union {
    struct {
      uint16_t PLLPRE:5;
      uint16_t :1;
      uint16_t PLLPOST:2;
      uint16_t FRCDIV:3;
      uint16_t DOZEN:1;
      uint16_t DOZE:3;
      uint16_t ROI:1;
    };
    struct {
      uint16_t PLLPRE0:1;
      uint16_t PLLPRE1:1;
      uint16_t PLLPRE2:1;
      uint16_t PLLPRE3:1;
      uint16_t PLLPRE4:1;
      uint16_t :1;
      uint16_t PLLPOST0:1;
      uint16_t PLLPOST1:1;
      uint16_t FRCDIV0:1;
      uint16_t FRCDIV1:1;
      uint16_t FRCDIV2:1;
      uint16_t :1;
      uint16_t DOZE0:1;
      uint16_t DOZE1:1;
      uint16_t DOZE2:1;
    };
  };
} CLKDIVBITS;
extern volatile CLKDIVBITS CLKDIVbits __attribute__((__sfr__));


extern volatile uint16_t PLLFBD __attribute__((__sfr__));
__extension__ typedef struct tagPLLFBDBITS {
  union {
    struct {
      uint16_t PLLDIV:9;
    };
    struct {
      uint16_t PLLDIV0:1;
      uint16_t PLLDIV1:1;
      uint16_t PLLDIV2:1;
      uint16_t PLLDIV3:1;
      uint16_t PLLDIV4:1;
      uint16_t PLLDIV5:1;
      uint16_t PLLDIV6:1;
      uint16_t PLLDIV7:1;
      uint16_t PLLDIV8:1;
    };
  };
} PLLFBDBITS;
extern volatile PLLFBDBITS PLLFBDbits __attribute__((__sfr__));


extern volatile uint16_t OSCTUN __attribute__((__sfr__));
__extension__ typedef struct tagOSCTUNBITS {
  union {
    struct {
      uint16_t TUN:6;
    };
    struct {
      uint16_t TUN0:1;
      uint16_t TUN1:1;
      uint16_t TUN2:1;
      uint16_t TUN3:1;
      uint16_t TUN4:1;
      uint16_t TUN5:1;
    };
  };
} OSCTUNBITS;
extern volatile OSCTUNBITS OSCTUNbits __attribute__((__sfr__));


extern volatile uint16_t REFOCON __attribute__((__sfr__));
__extension__ typedef struct tagREFOCONBITS {
  union {
    struct {
      uint16_t :8;
      uint16_t RODIV:4;
      uint16_t ROSEL:1;
      uint16_t ROSSLP:1;
      uint16_t :1;
      uint16_t ROON:1;
    };
    struct {
      uint16_t :8;
      uint16_t RODIV0:1;
      uint16_t RODIV1:1;
      uint16_t RODIV2:1;
      uint16_t RODIV3:1;
    };
  };
} REFOCONBITS;
extern volatile REFOCONBITS REFOCONbits __attribute__((__sfr__));


extern volatile uint16_t PMD1 __attribute__((__sfr__));
typedef struct tagPMD1BITS {
  uint16_t AD1MD:1;
  uint16_t C1MD:1;
  uint16_t :1;
  uint16_t SPI1MD:1;
  uint16_t SPI2MD:1;
  uint16_t U1MD:1;
  uint16_t U2MD:1;
  uint16_t I2C1MD:1;
  uint16_t :1;
  uint16_t PWMMD:1;
  uint16_t :1;
  uint16_t T1MD:1;
  uint16_t T2MD:1;
  uint16_t T3MD:1;
  uint16_t T4MD:1;
  uint16_t T5MD:1;
} PMD1BITS;
extern volatile PMD1BITS PMD1bits __attribute__((__sfr__));


extern volatile uint16_t PMD2 __attribute__((__sfr__));
typedef struct tagPMD2BITS {
  uint16_t OC1MD:1;
  uint16_t OC2MD:1;
  uint16_t OC3MD:1;
  uint16_t OC4MD:1;
  uint16_t :4;
  uint16_t IC1MD:1;
  uint16_t IC2MD:1;
  uint16_t IC3MD:1;
  uint16_t IC4MD:1;
} PMD2BITS;
extern volatile PMD2BITS PMD2bits __attribute__((__sfr__));


extern volatile uint16_t PMD3 __attribute__((__sfr__));
typedef struct tagPMD3BITS {
  uint16_t :10;
  uint16_t CMPMD:1;
} PMD3BITS;
extern volatile PMD3BITS PMD3bits __attribute__((__sfr__));


extern volatile uint16_t PMD4 __attribute__((__sfr__));
typedef struct tagPMD4BITS {
  uint16_t :2;
  uint16_t CTMUMD:1;
  uint16_t REFOMD:1;
} PMD4BITS;
extern volatile PMD4BITS PMD4bits __attribute__((__sfr__));


extern volatile uint16_t PMD6 __attribute__((__sfr__));
typedef struct tagPMD6BITS {
  uint16_t :8;
  uint16_t PWM1MD:1;
  uint16_t PWM2MD:1;
  uint16_t PWM3MD:1;
} PMD6BITS;
extern volatile PMD6BITS PMD6bits __attribute__((__sfr__));


extern volatile uint16_t PMD7 __attribute__((__sfr__));
__extension__ typedef struct tagPMD7BITS {
  union {
    struct {
      uint16_t :4;
      uint16_t DMA0MD:1;
    };
    struct {
      uint16_t :4;
      uint16_t DMA1MD:1;
    };
    struct {
      uint16_t :4;
      uint16_t DMA2MD:1;
    };
    struct {
      uint16_t :4;
      uint16_t DMA3MD:1;
    };
  };
} PMD7BITS;
extern volatile PMD7BITS PMD7bits __attribute__((__sfr__));


extern volatile uint16_t PMD8 __attribute__((__sfr__));
typedef struct tagPMD8BITS {
  uint16_t :8;
  uint16_t DMTMD:1;
  uint16_t :2;
  uint16_t SENT1MD:1;
  uint16_t SENT2MD:1;
} PMD8BITS;
extern volatile PMD8BITS PMD8bits __attribute__((__sfr__));


extern volatile uint16_t IFS0 __attribute__((__sfr__));
typedef struct tagIFS0BITS {
  uint16_t INT0IF:1;
  uint16_t IC1IF:1;
  uint16_t OC1IF:1;
  uint16_t T1IF:1;
  uint16_t DMA0IF:1;
  uint16_t IC2IF:1;
  uint16_t OC2IF:1;
  uint16_t T2IF:1;
  uint16_t T3IF:1;
  uint16_t SPI1EIF:1;
  uint16_t SPI1IF:1;
  uint16_t U1RXIF:1;
  uint16_t U1TXIF:1;
  uint16_t AD1IF:1;
  uint16_t DMA1IF:1;
  uint16_t NVMIF:1;
} IFS0BITS;
extern volatile IFS0BITS IFS0bits __attribute__((__sfr__));


extern volatile uint16_t IFS1 __attribute__((__sfr__));
__extension__ typedef struct tagIFS1BITS {
  union {
    struct {
      uint16_t SI2C1IF:1;
      uint16_t MI2C1IF:1;
      uint16_t CMIF:1;
      uint16_t CNIF:1;
      uint16_t INT1IF:1;
      uint16_t :3;
      uint16_t DMA2IF:1;
      uint16_t OC3IF:1;
      uint16_t OC4IF:1;
      uint16_t T4IF:1;
      uint16_t T5IF:1;
      uint16_t INT2IF:1;
      uint16_t U2RXIF:1;
      uint16_t U2TXIF:1;
    };
    struct {
      uint16_t :2;
      uint16_t CMPIF:1;
    };
  };
} IFS1BITS;
extern volatile IFS1BITS IFS1bits __attribute__((__sfr__));


extern volatile uint16_t IFS2 __attribute__((__sfr__));
typedef struct tagIFS2BITS {
  uint16_t SPI2EIF:1;
  uint16_t SPI2IF:1;
  uint16_t C1RXIF:1;
  uint16_t C1IF:1;
  uint16_t DMA3IF:1;
  uint16_t IC3IF:1;
  uint16_t IC4IF:1;
} IFS2BITS;
extern volatile IFS2BITS IFS2bits __attribute__((__sfr__));


extern volatile uint16_t IFS3 __attribute__((__sfr__));
typedef struct tagIFS3BITS {
  uint16_t :9;
  uint16_t PSEMIF:1;
} IFS3BITS;
extern volatile IFS3BITS IFS3bits __attribute__((__sfr__));


extern volatile uint16_t IFS4 __attribute__((__sfr__));
typedef struct tagIFS4BITS {
  uint16_t :1;
  uint16_t U1EIF:1;
  uint16_t U2EIF:1;
  uint16_t :3;
  uint16_t C1TXIF:1;
  uint16_t :6;
  uint16_t CTMUIF:1;
} IFS4BITS;
extern volatile IFS4BITS IFS4bits __attribute__((__sfr__));


extern volatile uint16_t IFS5 __attribute__((__sfr__));
typedef struct tagIFS5BITS {
  uint16_t :14;
  uint16_t PWM1IF:1;
  uint16_t PWM2IF:1;
} IFS5BITS;
extern volatile IFS5BITS IFS5bits __attribute__((__sfr__));


extern volatile uint16_t IFS6 __attribute__((__sfr__));
typedef struct tagIFS6BITS {
  uint16_t PWM3IF:1;
} IFS6BITS;
extern volatile IFS6BITS IFS6bits __attribute__((__sfr__));


extern volatile uint16_t IFS8 __attribute__((__sfr__));
typedef struct tagIFS8BITS {
  uint16_t :14;
  uint16_t ICDIF:1;
} IFS8BITS;
extern volatile IFS8BITS IFS8bits __attribute__((__sfr__));


extern volatile uint16_t IFS10 __attribute__((__sfr__));
typedef struct tagIFS10BITS {
  uint16_t :13;
  uint16_t I2C1BCIF:1;
} IFS10BITS;
extern volatile IFS10BITS IFS10bits __attribute__((__sfr__));


extern volatile uint16_t IFS11 __attribute__((__sfr__));
typedef struct tagIFS11BITS {
  uint16_t :6;
  uint16_t SENT1EIF:1;
  uint16_t SENT1IF:1;
  uint16_t SENT2EIF:1;
  uint16_t SENT2IF:1;
  uint16_t ECCSBEIF:1;
} IFS11BITS;
extern volatile IFS11BITS IFS11bits __attribute__((__sfr__));


extern volatile uint16_t IEC0 __attribute__((__sfr__));
typedef struct tagIEC0BITS {
  uint16_t INT0IE:1;
  uint16_t IC1IE:1;
  uint16_t OC1IE:1;
  uint16_t T1IE:1;
  uint16_t DMA0IE:1;
  uint16_t IC2IE:1;
  uint16_t OC2IE:1;
  uint16_t T2IE:1;
  uint16_t T3IE:1;
  uint16_t SPI1EIE:1;
  uint16_t SPI1IE:1;
  uint16_t U1RXIE:1;
  uint16_t U1TXIE:1;
  uint16_t AD1IE:1;
  uint16_t DMA1IE:1;
  uint16_t NVMIE:1;
} IEC0BITS;
extern volatile IEC0BITS IEC0bits __attribute__((__sfr__));


extern volatile uint16_t IEC1 __attribute__((__sfr__));
__extension__ typedef struct tagIEC1BITS {
  union {
    struct {
      uint16_t SI2C1IE:1;
      uint16_t MI2C1IE:1;
      uint16_t CMIE:1;
      uint16_t CNIE:1;
      uint16_t INT1IE:1;
      uint16_t :3;
      uint16_t DMA2IE:1;
      uint16_t OC3IE:1;
      uint16_t OC4IE:1;
      uint16_t T4IE:1;
      uint16_t T5IE:1;
      uint16_t INT2IE:1;
      uint16_t U2RXIE:1;
      uint16_t U2TXIE:1;
    };
    struct {
      uint16_t :2;
      uint16_t CMPIE:1;
    };
  };
} IEC1BITS;
extern volatile IEC1BITS IEC1bits __attribute__((__sfr__));


extern volatile uint16_t IEC2 __attribute__((__sfr__));
typedef struct tagIEC2BITS {
  uint16_t SPI2EIE:1;
  uint16_t SPI2IE:1;
  uint16_t C1RXIE:1;
  uint16_t C1IE:1;
  uint16_t DMA3IE:1;
  uint16_t IC3IE:1;
  uint16_t IC4IE:1;
} IEC2BITS;
extern volatile IEC2BITS IEC2bits __attribute__((__sfr__));


extern volatile uint16_t IEC3 __attribute__((__sfr__));
typedef struct tagIEC3BITS {
  uint16_t :9;
  uint16_t PSEMIE:1;
} IEC3BITS;
extern volatile IEC3BITS IEC3bits __attribute__((__sfr__));


extern volatile uint16_t IEC4 __attribute__((__sfr__));
typedef struct tagIEC4BITS {
  uint16_t :1;
  uint16_t U1EIE:1;
  uint16_t U2EIE:1;
  uint16_t :3;
  uint16_t C1TXIE:1;
  uint16_t :6;
  uint16_t CTMUIE:1;
} IEC4BITS;
extern volatile IEC4BITS IEC4bits __attribute__((__sfr__));


extern volatile uint16_t IEC5 __attribute__((__sfr__));
typedef struct tagIEC5BITS {
  uint16_t :14;
  uint16_t PWM1IE:1;
  uint16_t PWM2IE:1;
} IEC5BITS;
extern volatile IEC5BITS IEC5bits __attribute__((__sfr__));


extern volatile uint16_t IEC6 __attribute__((__sfr__));
typedef struct tagIEC6BITS {
  uint16_t PWM3IE:1;
} IEC6BITS;
extern volatile IEC6BITS IEC6bits __attribute__((__sfr__));


extern volatile uint16_t IEC8 __attribute__((__sfr__));
typedef struct tagIEC8BITS {
  uint16_t :14;
  uint16_t ICDIE:1;
} IEC8BITS;
extern volatile IEC8BITS IEC8bits __attribute__((__sfr__));


extern volatile uint16_t IEC10 __attribute__((__sfr__));
typedef struct tagIEC10BITS {
  uint16_t :13;
  uint16_t I2C1BCIE:1;
} IEC10BITS;
extern volatile IEC10BITS IEC10bits __attribute__((__sfr__));


extern volatile uint16_t IEC11 __attribute__((__sfr__));
typedef struct tagIEC11BITS {
  uint16_t :6;
  uint16_t SENT1EIE:1;
  uint16_t SENT1IE:1;
  uint16_t SENT2EIE:1;
  uint16_t SENT2IE:1;
  uint16_t ECCSBEIE:1;
} IEC11BITS;
extern volatile IEC11BITS IEC11bits __attribute__((__sfr__));


extern volatile uint16_t IPC0 __attribute__((__sfr__));
__extension__ typedef struct tagIPC0BITS {
  union {
    struct {
      uint16_t INT0IP:3;
      uint16_t :1;
      uint16_t IC1IP:3;
      uint16_t :1;
      uint16_t OC1IP:3;
      uint16_t :1;
      uint16_t T1IP:3;
    };
    struct {
      uint16_t INT0IP0:1;
      uint16_t INT0IP1:1;
      uint16_t INT0IP2:1;
      uint16_t :1;
      uint16_t IC1IP0:1;
      uint16_t IC1IP1:1;
      uint16_t IC1IP2:1;
      uint16_t :1;
      uint16_t OC1IP0:1;
      uint16_t OC1IP1:1;
      uint16_t OC1IP2:1;
      uint16_t :1;
      uint16_t T1IP0:1;
      uint16_t T1IP1:1;
      uint16_t T1IP2:1;
    };
  };
} IPC0BITS;
extern volatile IPC0BITS IPC0bits __attribute__((__sfr__));


extern volatile uint16_t IPC1 __attribute__((__sfr__));
__extension__ typedef struct tagIPC1BITS {
  union {
    struct {
      uint16_t DMA0IP:3;
      uint16_t :1;
      uint16_t IC2IP:3;
      uint16_t :1;
      uint16_t OC2IP:3;
      uint16_t :1;
      uint16_t T2IP:3;
    };
    struct {
      uint16_t DMA0IP0:1;
      uint16_t DMA0IP1:1;
      uint16_t DMA0IP2:1;
      uint16_t :1;
      uint16_t IC2IP0:1;
      uint16_t IC2IP1:1;
      uint16_t IC2IP2:1;
      uint16_t :1;
      uint16_t OC2IP0:1;
      uint16_t OC2IP1:1;
      uint16_t OC2IP2:1;
      uint16_t :1;
      uint16_t T2IP0:1;
      uint16_t T2IP1:1;
      uint16_t T2IP2:1;
    };
  };
} IPC1BITS;
extern volatile IPC1BITS IPC1bits __attribute__((__sfr__));


extern volatile uint16_t IPC2 __attribute__((__sfr__));
__extension__ typedef struct tagIPC2BITS {
  union {
    struct {
      uint16_t T3IP:3;
      uint16_t :1;
      uint16_t SPI1EIP:3;
      uint16_t :1;
      uint16_t SPI1IP:3;
      uint16_t :1;
      uint16_t U1RXIP:3;
    };
    struct {
      uint16_t T3IP0:1;
      uint16_t T3IP1:1;
      uint16_t T3IP2:1;
      uint16_t :1;
      uint16_t SPI1EIP0:1;
      uint16_t SPI1EIP1:1;
      uint16_t SPI1EIP2:1;
      uint16_t :1;
      uint16_t SPI1IP0:1;
      uint16_t SPI1IP1:1;
      uint16_t SPI1IP2:1;
      uint16_t :1;
      uint16_t U1RXIP0:1;
      uint16_t U1RXIP1:1;
      uint16_t U1RXIP2:1;
    };
  };
} IPC2BITS;
extern volatile IPC2BITS IPC2bits __attribute__((__sfr__));


extern volatile uint16_t IPC3 __attribute__((__sfr__));
__extension__ typedef struct tagIPC3BITS {
  union {
    struct {
      uint16_t U1TXIP:3;
      uint16_t :1;
      uint16_t AD1IP:3;
      uint16_t :1;
      uint16_t DMA1IP:3;
      uint16_t :1;
      uint16_t NVMIP:3;
    };
    struct {
      uint16_t U1TXIP0:1;
      uint16_t U1TXIP1:1;
      uint16_t U1TXIP2:1;
      uint16_t :1;
      uint16_t AD1IP0:1;
      uint16_t AD1IP1:1;
      uint16_t AD1IP2:1;
      uint16_t :1;
      uint16_t DMA1IP0:1;
      uint16_t DMA1IP1:1;
      uint16_t DMA1IP2:1;
      uint16_t :1;
      uint16_t NVMIP0:1;
      uint16_t NVMIP1:1;
      uint16_t NVMIP2:1;
    };
  };
} IPC3BITS;
extern volatile IPC3BITS IPC3bits __attribute__((__sfr__));


extern volatile uint16_t IPC4 __attribute__((__sfr__));
__extension__ typedef struct tagIPC4BITS {
  union {
    struct {
      uint16_t SI2C1IP:3;
      uint16_t :1;
      uint16_t MI2C1IP:3;
      uint16_t :1;
      uint16_t CMIP:3;
      uint16_t :1;
      uint16_t CNIP:3;
    };
    struct {
      uint16_t SI2C1IP0:1;
      uint16_t SI2C1IP1:1;
      uint16_t SI2C1IP2:1;
      uint16_t :1;
      uint16_t MI2C1IP0:1;
      uint16_t MI2C1IP1:1;
      uint16_t MI2C1IP2:1;
      uint16_t :1;
      uint16_t CMIP0:1;
      uint16_t CMIP1:1;
      uint16_t CMIP2:1;
      uint16_t :1;
      uint16_t CNIP0:1;
      uint16_t CNIP1:1;
      uint16_t CNIP2:1;
    };
    struct {
      uint16_t :8;
      uint16_t CMPIP:3;
    };
  };
} IPC4BITS;
extern volatile IPC4BITS IPC4bits __attribute__((__sfr__));


extern volatile uint16_t IPC5 __attribute__((__sfr__));
__extension__ typedef struct tagIPC5BITS {
  union {
    struct {
      uint16_t INT1IP:3;
    };
    struct {
      uint16_t INT1IP0:1;
      uint16_t INT1IP1:1;
      uint16_t INT1IP2:1;
      uint16_t :1;
      uint16_t AD2IP0:1;
      uint16_t AD2IP1:1;
      uint16_t AD2IP2:1;
      uint16_t :1;
      uint16_t IC7IP0:1;
      uint16_t IC7IP1:1;
      uint16_t IC7IP2:1;
      uint16_t :1;
      uint16_t IC8IP0:1;
      uint16_t IC8IP1:1;
      uint16_t IC8IP2:1;
    };
  };
} IPC5BITS;
extern volatile IPC5BITS IPC5bits __attribute__((__sfr__));


extern volatile uint16_t IPC6 __attribute__((__sfr__));
__extension__ typedef struct tagIPC6BITS {
  union {
    struct {
      uint16_t DMA2IP:3;
      uint16_t :1;
      uint16_t OC3IP:3;
      uint16_t :1;
      uint16_t OC4IP:3;
      uint16_t :1;
      uint16_t T4IP:3;
    };
    struct {
      uint16_t DMA2IP0:1;
      uint16_t DMA2IP1:1;
      uint16_t DMA2IP2:1;
      uint16_t :1;
      uint16_t OC3IP0:1;
      uint16_t OC3IP1:1;
      uint16_t OC3IP2:1;
      uint16_t :1;
      uint16_t OC4IP0:1;
      uint16_t OC4IP1:1;
      uint16_t OC4IP2:1;
      uint16_t :1;
      uint16_t T4IP0:1;
      uint16_t T4IP1:1;
      uint16_t T4IP2:1;
    };
  };
} IPC6BITS;
extern volatile IPC6BITS IPC6bits __attribute__((__sfr__));


extern volatile uint16_t IPC7 __attribute__((__sfr__));
__extension__ typedef struct tagIPC7BITS {
  union {
    struct {
      uint16_t T5IP:3;
      uint16_t :1;
      uint16_t INT2IP:3;
      uint16_t :1;
      uint16_t U2RXIP:3;
      uint16_t :1;
      uint16_t U2TXIP:3;
    };
    struct {
      uint16_t T5IP0:1;
      uint16_t T5IP1:1;
      uint16_t T5IP2:1;
      uint16_t :1;
      uint16_t INT2IP0:1;
      uint16_t INT2IP1:1;
      uint16_t INT2IP2:1;
      uint16_t :1;
      uint16_t U2RXIP0:1;
      uint16_t U2RXIP1:1;
      uint16_t U2RXIP2:1;
      uint16_t :1;
      uint16_t U2TXIP0:1;
      uint16_t U2TXIP1:1;
      uint16_t U2TXIP2:1;
    };
  };
} IPC7BITS;
extern volatile IPC7BITS IPC7bits __attribute__((__sfr__));


extern volatile uint16_t IPC8 __attribute__((__sfr__));
__extension__ typedef struct tagIPC8BITS {
  union {
    struct {
      uint16_t SPI2EIP:3;
      uint16_t :1;
      uint16_t SPI2IP:3;
      uint16_t :1;
      uint16_t C1RXIP:3;
      uint16_t :1;
      uint16_t C1IP:3;
    };
    struct {
      uint16_t SPI2EIP0:1;
      uint16_t SPI2EIP1:1;
      uint16_t SPI2EIP2:1;
      uint16_t :1;
      uint16_t SPI2IP0:1;
      uint16_t SPI2IP1:1;
      uint16_t SPI2IP2:1;
      uint16_t :1;
      uint16_t C1RXIP0:1;
      uint16_t C1RXIP1:1;
      uint16_t C1RXIP2:1;
      uint16_t :1;
      uint16_t C1IP0:1;
      uint16_t C1IP1:1;
      uint16_t C1IP2:1;
    };
  };
} IPC8BITS;
extern volatile IPC8BITS IPC8bits __attribute__((__sfr__));


extern volatile uint16_t IPC9 __attribute__((__sfr__));
__extension__ typedef struct tagIPC9BITS {
  union {
    struct {
      uint16_t DMA3IP:3;
      uint16_t :1;
      uint16_t IC3IP:3;
      uint16_t :1;
      uint16_t IC4IP:3;
    };
    struct {
      uint16_t DMA3IP0:1;
      uint16_t DMA3IP1:1;
      uint16_t DMA3IP2:1;
      uint16_t :1;
      uint16_t IC3IP0:1;
      uint16_t IC3IP1:1;
      uint16_t IC3IP2:1;
      uint16_t :1;
      uint16_t IC4IP0:1;
      uint16_t IC4IP1:1;
      uint16_t IC4IP2:1;
      uint16_t :1;
      uint16_t IC5IP0:1;
      uint16_t IC5IP1:1;
      uint16_t IC5IP2:1;
    };
  };
} IPC9BITS;
extern volatile IPC9BITS IPC9bits __attribute__((__sfr__));


extern volatile uint16_t IPC14 __attribute__((__sfr__));
__extension__ typedef struct tagIPC14BITS {
  union {
    struct {
      uint16_t :4;
      uint16_t PSEMIP:3;
    };
    struct {
      uint16_t C2IP0:1;
      uint16_t C2IP1:1;
      uint16_t C2IP2:1;
      uint16_t :1;
      uint16_t PSEMIP0:1;
      uint16_t PSEMIP1:1;
      uint16_t PSEMIP2:1;
      uint16_t :1;
      uint16_t QEI1IP0:1;
      uint16_t QEI1IP1:1;
      uint16_t QEI1IP2:1;
      uint16_t :1;
      uint16_t DCIEIP0:1;
      uint16_t DCIEIP1:1;
      uint16_t DCIEIP2:1;
    };
  };
} IPC14BITS;
extern volatile IPC14BITS IPC14bits __attribute__((__sfr__));


extern volatile uint16_t IPC16 __attribute__((__sfr__));
__extension__ typedef struct tagIPC16BITS {
  union {
    struct {
      uint16_t :4;
      uint16_t U1EIP:3;
      uint16_t :1;
      uint16_t U2EIP:3;
    };
    struct {
      uint16_t :4;
      uint16_t U1EIP0:1;
      uint16_t U1EIP1:1;
      uint16_t U1EIP2:1;
      uint16_t :1;
      uint16_t U2EIP0:1;
      uint16_t U2EIP1:1;
      uint16_t U2EIP2:1;
      uint16_t :1;
      uint16_t CRCIP0:1;
      uint16_t CRCIP1:1;
      uint16_t CRCIP2:1;
    };
  };
} IPC16BITS;
extern volatile IPC16BITS IPC16bits __attribute__((__sfr__));


extern volatile uint16_t IPC17 __attribute__((__sfr__));
__extension__ typedef struct tagIPC17BITS {
  union {
    struct {
      uint16_t :8;
      uint16_t C1TXIP:3;
    };
    struct {
      uint16_t DMA6IP0:1;
      uint16_t DMA6IP1:1;
      uint16_t DMA6IP2:1;
      uint16_t :1;
      uint16_t DMA7IP0:1;
      uint16_t DMA7IP1:1;
      uint16_t DMA7IP2:1;
      uint16_t :1;
      uint16_t C1TXIP0:1;
      uint16_t C1TXIP1:1;
      uint16_t C1TXIP2:1;
      uint16_t :1;
      uint16_t C2TXIP0:1;
      uint16_t C2TXIP1:1;
      uint16_t C2TXIP2:1;
    };
  };
} IPC17BITS;
extern volatile IPC17BITS IPC17bits __attribute__((__sfr__));


extern volatile uint16_t IPC19 __attribute__((__sfr__));
__extension__ typedef struct tagIPC19BITS {
  union {
    struct {
      uint16_t :4;
      uint16_t CTMUIP:3;
    };
    struct {
      uint16_t :4;
      uint16_t CTMUIP0:1;
      uint16_t CTMUIP1:1;
      uint16_t CTMUIP2:1;
    };
  };
} IPC19BITS;
extern volatile IPC19BITS IPC19bits __attribute__((__sfr__));


extern volatile uint16_t IPC23 __attribute__((__sfr__));
__extension__ typedef struct tagIPC23BITS {
  union {
    struct {
      uint16_t :8;
      uint16_t PWM1IP:3;
      uint16_t :1;
      uint16_t PWM2IP:3;
    };
    struct {
      uint16_t OC9IP0:1;
      uint16_t OC9IP1:1;
      uint16_t OC9IP2:1;
      uint16_t :1;
      uint16_t IC9IP0:1;
      uint16_t IC9IP1:1;
      uint16_t IC9IP2:1;
      uint16_t :1;
      uint16_t PWM1IP0:1;
      uint16_t PWM1IP1:1;
      uint16_t PWM1IP2:1;
      uint16_t :1;
      uint16_t PWM2IP0:1;
      uint16_t PWM2IP1:1;
      uint16_t PWM2IP2:1;
    };
  };
} IPC23BITS;
extern volatile IPC23BITS IPC23bits __attribute__((__sfr__));


extern volatile uint16_t IPC24 __attribute__((__sfr__));
__extension__ typedef struct tagIPC24BITS {
  union {
    struct {
      uint16_t PWM3IP:3;
    };
    struct {
      uint16_t PWM3IP0:1;
      uint16_t PWM3IP1:1;
      uint16_t PWM3IP2:1;
      uint16_t :1;
      uint16_t PWM4IP0:1;
      uint16_t PWM4IP1:1;
      uint16_t PWM4IP2:1;
      uint16_t :1;
      uint16_t PWM5IP0:1;
      uint16_t PWM5IP1:1;
      uint16_t PWM5IP2:1;
      uint16_t :1;
      uint16_t PWM6IP0:1;
      uint16_t PWM6IP1:1;
      uint16_t PWM6IP2:1;
    };
  };
} IPC24BITS;
extern volatile IPC24BITS IPC24bits __attribute__((__sfr__));


extern volatile uint16_t IPC35 __attribute__((__sfr__));
__extension__ typedef struct tagIPC35BITS {
  union {
    struct {
      uint16_t :8;
      uint16_t ICDIP:3;
    };
    struct {
      uint16_t OC16IP0:1;
      uint16_t OC16IP1:1;
      uint16_t OC16IP2:1;
      uint16_t :1;
      uint16_t IC16IP0:1;
      uint16_t IC16IP1:1;
      uint16_t IC16IP2:1;
      uint16_t :1;
      uint16_t ICDIP0:1;
      uint16_t ICDIP1:1;
      uint16_t ICDIP2:1;
    };
  };
} IPC35BITS;
extern volatile IPC35BITS IPC35bits __attribute__((__sfr__));


extern volatile uint16_t IPC43 __attribute__((__sfr__));
__extension__ typedef struct tagIPC43BITS {
  union {
    struct {
      uint16_t :4;
      uint16_t I2C1BCIP:3;
    };
    struct {
      uint16_t :4;
      uint16_t I2C1BCIP0:1;
      uint16_t I2C1BCIP1:1;
      uint16_t I2C1BCIP2:1;
    };
  };
} IPC43BITS;
extern volatile IPC43BITS IPC43bits __attribute__((__sfr__));


extern volatile uint16_t IPC45 __attribute__((__sfr__));
__extension__ typedef struct tagIPC45BITS {
  union {
    struct {
      uint16_t :8;
      uint16_t SENT1EIP:3;
      uint16_t :1;
      uint16_t SENT1IP:3;
    };
    struct {
      uint16_t :8;
      uint16_t SENT1EIP0:1;
      uint16_t SENT1EIP1:1;
      uint16_t SENT1EIP2:1;
      uint16_t :1;
      uint16_t SENT1IP0:1;
      uint16_t SENT1IP1:1;
      uint16_t SENT1IP2:1;
    };
  };
} IPC45BITS;
extern volatile IPC45BITS IPC45bits __attribute__((__sfr__));


extern volatile uint16_t IPC46 __attribute__((__sfr__));
__extension__ typedef struct tagIPC46BITS {
  union {
    struct {
      uint16_t SENT2EIP:3;
      uint16_t :1;
      uint16_t SENT2IP:3;
      uint16_t :1;
      uint16_t ECCSBEIP:3;
    };
    struct {
      uint16_t SENT2EIP0:1;
      uint16_t SENT2EIP1:1;
      uint16_t SENT2EIP2:1;
      uint16_t :1;
      uint16_t SENT2IP0:1;
      uint16_t SENT2IP1:1;
      uint16_t SENT2IP2:1;
      uint16_t :1;
      uint16_t ECCSBEIP0:1;
      uint16_t ECCSBEIP1:1;
      uint16_t ECCSBEIP2:1;
    };
  };
} IPC46BITS;
extern volatile IPC46BITS IPC46bits __attribute__((__sfr__));


extern volatile uint16_t INTCON1 __attribute__((__sfr__));
typedef struct tagINTCON1BITS {
  uint16_t :1;
  uint16_t OSCFAIL:1;
  uint16_t STKERR:1;
  uint16_t ADDRERR:1;
  uint16_t MATHERR:1;
  uint16_t DMACERR:1;
  uint16_t DIV0ERR:1;
  uint16_t SFTACERR:1;
  uint16_t COVTE:1;
  uint16_t OVBTE:1;
  uint16_t OVATE:1;
  uint16_t COVBERR:1;
  uint16_t COVAERR:1;
  uint16_t OVBERR:1;
  uint16_t OVAERR:1;
  uint16_t NSTDIS:1;
} INTCON1BITS;
extern volatile INTCON1BITS INTCON1bits __attribute__((__sfr__));


extern volatile uint16_t INTCON2 __attribute__((__sfr__));
typedef struct tagINTCON2BITS {
  uint16_t INT0EP:1;
  uint16_t INT1EP:1;
  uint16_t INT2EP:1;
  uint16_t :5;
  uint16_t AIVTEN:1;
  uint16_t :4;
  uint16_t SWTRAP:1;
  uint16_t DISI:1;
  uint16_t GIE:1;
} INTCON2BITS;
extern volatile INTCON2BITS INTCON2bits __attribute__((__sfr__));


extern volatile uint16_t INTCON3 __attribute__((__sfr__));
typedef struct tagINTCON3BITS {
  uint16_t :4;
  uint16_t DOOVR:1;
  uint16_t DAE:1;
  uint16_t :2;
  uint16_t NAE:1;
  uint16_t :6;
  uint16_t DMT:1;
} INTCON3BITS;
extern volatile INTCON3BITS INTCON3bits __attribute__((__sfr__));


extern volatile uint16_t INTCON4 __attribute__((__sfr__));
typedef struct tagINTCON4BITS {
  uint16_t SGHT:1;
  uint16_t ECCDBE:1;
} INTCON4BITS;
extern volatile INTCON4BITS INTCON4bits __attribute__((__sfr__));


extern volatile uint16_t INTTREG __attribute__((__sfr__));
__extension__ typedef struct tagINTTREGBITS {
  union {
    struct {
      uint16_t VECNUM:8;
      uint16_t ILR:4;
    };
    struct {
      uint16_t VECNUM0:1;
      uint16_t VECNUM1:1;
      uint16_t VECNUM2:1;
      uint16_t VECNUM3:1;
      uint16_t VECNUM4:1;
      uint16_t VECNUM5:1;
      uint16_t VECNUM6:1;
      uint16_t VECNUM7:1;
      uint16_t ILR0:1;
      uint16_t ILR1:1;
      uint16_t ILR2:1;
      uint16_t ILR3:1;
    };
  };
} INTTREGBITS;
extern volatile INTTREGBITS INTTREGbits __attribute__((__sfr__));


extern volatile uint16_t OC1CON1 __attribute__((__sfr__));
__extension__ typedef struct tagOC1CON1BITS {
  union {
    struct {
      uint16_t OCM:3;
      uint16_t TRIGMODE:1;
      uint16_t OCFLTA:1;
      uint16_t :2;
      uint16_t ENFLTA:1;
      uint16_t :2;
      uint16_t OCTSEL:3;
      uint16_t OCSIDL:1;
    };
    struct {
      uint16_t OCM0:1;
      uint16_t OCM1:1;
      uint16_t OCM2:1;
      uint16_t :1;
      uint16_t OCFLT:3;
      uint16_t ENFLT:3;
      uint16_t OCTSEL0:1;
      uint16_t OCTSEL1:1;
      uint16_t OCTSEL2:1;
    };
    struct {
      uint16_t :4;
      uint16_t OCFLT0:1;
      uint16_t :2;
      uint16_t ENFLT0:1;
    };
  };
} OC1CON1BITS;
extern volatile OC1CON1BITS OC1CON1bits __attribute__((__sfr__));


extern volatile uint16_t OC1CON2 __attribute__((__sfr__));
__extension__ typedef struct tagOC1CON2BITS {
  union {
    struct {
      uint16_t SYNCSEL:5;
      uint16_t OCTRIS:1;
      uint16_t TRIGSTAT:1;
      uint16_t OCTRIG:1;
      uint16_t OC32:1;
      uint16_t :3;
      uint16_t OCINV:1;
      uint16_t FLTTRIEN:1;
      uint16_t FLTOUT:1;
      uint16_t FLTMD:1;
    };
    struct {
      uint16_t SYNCSEL0:1;
      uint16_t SYNCSEL1:1;
      uint16_t SYNCSEL2:1;
      uint16_t SYNCSEL3:1;
      uint16_t SYNCSEL4:1;
      uint16_t :9;
      uint16_t FLTMODE:1;
    };
  };
} OC1CON2BITS;
extern volatile OC1CON2BITS OC1CON2bits __attribute__((__sfr__));



typedef struct tagOC {
        uint16_t ocxrs;
        uint16_t ocxr;
        uint16_t ocxcon;
} OC, *POC;


extern volatile OC OC1 __attribute__((__sfr__));


extern volatile uint16_t OC1RS __attribute__((__sfr__));

extern volatile uint16_t OC1R __attribute__((__sfr__));

extern volatile uint16_t OC1TMR __attribute__((__sfr__));

extern volatile uint16_t OC2CON1 __attribute__((__sfr__));
__extension__ typedef struct tagOC2CON1BITS {
  union {
    struct {
      uint16_t OCM:3;
      uint16_t TRIGMODE:1;
      uint16_t OCFLTA:1;
      uint16_t :2;
      uint16_t ENFLTA:1;
      uint16_t :2;
      uint16_t OCTSEL:3;
      uint16_t OCSIDL:1;
    };
    struct {
      uint16_t OCM0:1;
      uint16_t OCM1:1;
      uint16_t OCM2:1;
      uint16_t :1;
      uint16_t OCFLT:3;
      uint16_t ENFLT:3;
      uint16_t OCTSEL0:1;
      uint16_t OCTSEL1:1;
      uint16_t OCTSEL2:1;
    };
    struct {
      uint16_t :4;
      uint16_t OCFLT0:1;
      uint16_t :2;
      uint16_t ENFLT0:1;
    };
  };
} OC2CON1BITS;
extern volatile OC2CON1BITS OC2CON1bits __attribute__((__sfr__));


extern volatile uint16_t OC2CON2 __attribute__((__sfr__));
__extension__ typedef struct tagOC2CON2BITS {
  union {
    struct {
      uint16_t SYNCSEL:5;
      uint16_t OCTRIS:1;
      uint16_t TRIGSTAT:1;
      uint16_t OCTRIG:1;
      uint16_t OC32:1;
      uint16_t :3;
      uint16_t OCINV:1;
      uint16_t FLTTRIEN:1;
      uint16_t FLTOUT:1;
      uint16_t FLTMD:1;
    };
    struct {
      uint16_t SYNCSEL0:1;
      uint16_t SYNCSEL1:1;
      uint16_t SYNCSEL2:1;
      uint16_t SYNCSEL3:1;
      uint16_t SYNCSEL4:1;
      uint16_t :9;
      uint16_t FLTMODE:1;
    };
  };
} OC2CON2BITS;
extern volatile OC2CON2BITS OC2CON2bits __attribute__((__sfr__));



extern volatile uint16_t OC2RS __attribute__((__sfr__));

extern volatile uint16_t OC2R __attribute__((__sfr__));

extern volatile uint16_t OC2TMR __attribute__((__sfr__));

extern volatile uint16_t OC3CON1 __attribute__((__sfr__));
__extension__ typedef struct tagOC3CON1BITS {
  union {
    struct {
      uint16_t OCM:3;
      uint16_t TRIGMODE:1;
      uint16_t OCFLTA:1;
      uint16_t :2;
      uint16_t ENFLTA:1;
      uint16_t :2;
      uint16_t OCTSEL:3;
      uint16_t OCSIDL:1;
    };
    struct {
      uint16_t OCM0:1;
      uint16_t OCM1:1;
      uint16_t OCM2:1;
      uint16_t :1;
      uint16_t OCFLT:3;
      uint16_t ENFLT:3;
      uint16_t OCTSEL0:1;
      uint16_t OCTSEL1:1;
      uint16_t OCTSEL2:1;
    };
    struct {
      uint16_t :4;
      uint16_t OCFLT0:1;
      uint16_t :2;
      uint16_t ENFLT0:1;
    };
  };
} OC3CON1BITS;
extern volatile OC3CON1BITS OC3CON1bits __attribute__((__sfr__));


extern volatile uint16_t OC3CON2 __attribute__((__sfr__));
__extension__ typedef struct tagOC3CON2BITS {
  union {
    struct {
      uint16_t SYNCSEL:5;
      uint16_t OCTRIS:1;
      uint16_t TRIGSTAT:1;
      uint16_t OCTRIG:1;
      uint16_t OC32:1;
      uint16_t :3;
      uint16_t OCINV:1;
      uint16_t FLTTRIEN:1;
      uint16_t FLTOUT:1;
      uint16_t FLTMD:1;
    };
    struct {
      uint16_t SYNCSEL0:1;
      uint16_t SYNCSEL1:1;
      uint16_t SYNCSEL2:1;
      uint16_t SYNCSEL3:1;
      uint16_t SYNCSEL4:1;
      uint16_t :9;
      uint16_t FLTMODE:1;
    };
  };
} OC3CON2BITS;
extern volatile OC3CON2BITS OC3CON2bits __attribute__((__sfr__));



extern volatile uint16_t OC3RS __attribute__((__sfr__));

extern volatile uint16_t OC3R __attribute__((__sfr__));

extern volatile uint16_t OC3TMR __attribute__((__sfr__));

extern volatile uint16_t OC4CON1 __attribute__((__sfr__));
__extension__ typedef struct tagOC4CON1BITS {
  union {
    struct {
      uint16_t OCM:3;
      uint16_t TRIGMODE:1;
      uint16_t OCFLTA:1;
      uint16_t :2;
      uint16_t ENFLTA:1;
      uint16_t :2;
      uint16_t OCTSEL:3;
      uint16_t OCSIDL:1;
    };
    struct {
      uint16_t OCM0:1;
      uint16_t OCM1:1;
      uint16_t OCM2:1;
      uint16_t :1;
      uint16_t OCFLT:3;
      uint16_t ENFLT:3;
      uint16_t OCTSEL0:1;
      uint16_t OCTSEL1:1;
      uint16_t OCTSEL2:1;
    };
    struct {
      uint16_t :4;
      uint16_t OCFLT0:1;
      uint16_t :2;
      uint16_t ENFLT0:1;
    };
  };
} OC4CON1BITS;
extern volatile OC4CON1BITS OC4CON1bits __attribute__((__sfr__));


extern volatile uint16_t OC4CON2 __attribute__((__sfr__));
__extension__ typedef struct tagOC4CON2BITS {
  union {
    struct {
      uint16_t SYNCSEL:5;
      uint16_t OCTRIS:1;
      uint16_t TRIGSTAT:1;
      uint16_t OCTRIG:1;
      uint16_t OC32:1;
      uint16_t :3;
      uint16_t OCINV:1;
      uint16_t FLTTRIEN:1;
      uint16_t FLTOUT:1;
      uint16_t FLTMD:1;
    };
    struct {
      uint16_t SYNCSEL0:1;
      uint16_t SYNCSEL1:1;
      uint16_t SYNCSEL2:1;
      uint16_t SYNCSEL3:1;
      uint16_t SYNCSEL4:1;
      uint16_t :9;
      uint16_t FLTMODE:1;
    };
  };
} OC4CON2BITS;
extern volatile OC4CON2BITS OC4CON2bits __attribute__((__sfr__));



extern volatile uint16_t OC4RS __attribute__((__sfr__));

extern volatile uint16_t OC4R __attribute__((__sfr__));

extern volatile uint16_t OC4TMR __attribute__((__sfr__));

extern volatile uint16_t CMSTAT __attribute__((__sfr__));
typedef struct tagCMSTATBITS {
  uint16_t C1OUT:1;
  uint16_t C2OUT:1;
  uint16_t C3OUT:1;
  uint16_t C4OUT:1;
  uint16_t C5OUT:1;
  uint16_t :3;
  uint16_t C1EVT:1;
  uint16_t C2EVT:1;
  uint16_t C3EVT:1;
  uint16_t C4EVT:1;
  uint16_t C5EVT:1;
  uint16_t :2;
  uint16_t PSIDL:1;
} CMSTATBITS;
extern volatile CMSTATBITS CMSTATbits __attribute__((__sfr__));


extern volatile uint16_t CVR1CON __attribute__((__sfr__));
__extension__ typedef struct tagCVR1CONBITS {
  union {
    struct {
      uint16_t CVR:7;
      uint16_t :3;
      uint16_t VREFSEL:1;
      uint16_t CVRSS:1;
      uint16_t :2;
      uint16_t CVROE:1;
      uint16_t CVREN:1;
    };
    struct {
      uint16_t CVR0:1;
      uint16_t CVR1:1;
      uint16_t CVR2:1;
      uint16_t CVR3:1;
      uint16_t CVR4:1;
      uint16_t CVR5:1;
      uint16_t CVR6:1;
    };
  };
} CVR1CONBITS;
extern volatile CVR1CONBITS CVR1CONbits __attribute__((__sfr__));


extern volatile uint16_t CM1CON __attribute__((__sfr__));
__extension__ typedef struct tagCM1CONBITS {
  union {
    struct {
      uint16_t CCH:2;
      uint16_t :2;
      uint16_t CREF:1;
      uint16_t :1;
      uint16_t EVPOL:2;
      uint16_t COUT:1;
      uint16_t CEVT:1;
      uint16_t OPAEN:1;
      uint16_t :2;
      uint16_t CPOL:1;
      uint16_t COE:1;
      uint16_t CON:1;
    };
    struct {
      uint16_t CCH0:1;
      uint16_t CCH1:1;
      uint16_t :4;
      uint16_t EVPOL0:1;
      uint16_t EVPOL1:1;
      uint16_t :7;
      uint16_t CEN:1;
    };
  };
} CM1CONBITS;
extern volatile CM1CONBITS CM1CONbits __attribute__((__sfr__));


extern volatile uint16_t CM1MSKSRC __attribute__((__sfr__));
__extension__ typedef struct tagCM1MSKSRCBITS {
  union {
    struct {
      uint16_t SELSRCA:4;
      uint16_t SELSRCB:4;
      uint16_t SELSRCC:4;
    };
    struct {
      uint16_t SELSRCA0:1;
      uint16_t SELSRCA1:1;
      uint16_t SELSRCA2:1;
      uint16_t SELSRCA3:1;
      uint16_t SELSRCB0:1;
      uint16_t SELSRCB1:1;
      uint16_t SELSRCB2:1;
      uint16_t SELSRCB3:1;
      uint16_t SELSRCC0:1;
      uint16_t SELSRCC1:1;
      uint16_t SELSRCC2:1;
      uint16_t SELSRCC3:1;
    };
  };
} CM1MSKSRCBITS;
extern volatile CM1MSKSRCBITS CM1MSKSRCbits __attribute__((__sfr__));


extern volatile uint16_t CM1MSKCON __attribute__((__sfr__));
typedef struct tagCM1MSKCONBITS {
  uint16_t AANEN:1;
  uint16_t AAEN:1;
  uint16_t ABNEN:1;
  uint16_t ABEN:1;
  uint16_t ACNEN:1;
  uint16_t ACEN:1;
  uint16_t PAGS:1;
  uint16_t NAGS:1;
  uint16_t OANEN:1;
  uint16_t OAEN:1;
  uint16_t OBNEN:1;
  uint16_t OBEN:1;
  uint16_t OCNEN:1;
  uint16_t OCEN:1;
  uint16_t :1;
  uint16_t HLMS:1;
} CM1MSKCONBITS;
extern volatile CM1MSKCONBITS CM1MSKCONbits __attribute__((__sfr__));


extern volatile uint16_t CM1FLTR __attribute__((__sfr__));
__extension__ typedef struct tagCM1FLTRBITS {
  union {
    struct {
      uint16_t CFDIV:3;
      uint16_t CFLTREN:1;
      uint16_t CFSEL:3;
    };
    struct {
      uint16_t CFDIV0:1;
      uint16_t CFDIV1:1;
      uint16_t CFDIV2:1;
      uint16_t :1;
      uint16_t CFSEL0:1;
      uint16_t CFSEL1:1;
      uint16_t CFSEL2:1;
    };
  };
} CM1FLTRBITS;
extern volatile CM1FLTRBITS CM1FLTRbits __attribute__((__sfr__));


extern volatile uint16_t CM2CON __attribute__((__sfr__));
__extension__ typedef struct tagCM2CONBITS {
  union {
    struct {
      uint16_t CCH:2;
      uint16_t :2;
      uint16_t CREF:1;
      uint16_t :1;
      uint16_t EVPOL:2;
      uint16_t COUT:1;
      uint16_t CEVT:1;
      uint16_t OPAEN:1;
      uint16_t :2;
      uint16_t CPOL:1;
      uint16_t COE:1;
      uint16_t CON:1;
    };
    struct {
      uint16_t CCH0:1;
      uint16_t CCH1:1;
      uint16_t :4;
      uint16_t EVPOL0:1;
      uint16_t EVPOL1:1;
      uint16_t :7;
      uint16_t CEN:1;
    };
  };
} CM2CONBITS;
extern volatile CM2CONBITS CM2CONbits __attribute__((__sfr__));


extern volatile uint16_t CM2MSKSRC __attribute__((__sfr__));
__extension__ typedef struct tagCM2MSKSRCBITS {
  union {
    struct {
      uint16_t SELSRCA:4;
      uint16_t SELSRCB:4;
      uint16_t SELSRCC:4;
    };
    struct {
      uint16_t SELSRCA0:1;
      uint16_t SELSRCA1:1;
      uint16_t SELSRCA2:1;
      uint16_t SELSRCA3:1;
      uint16_t SELSRCB0:1;
      uint16_t SELSRCB1:1;
      uint16_t SELSRCB2:1;
      uint16_t SELSRCB3:1;
      uint16_t SELSRCC0:1;
      uint16_t SELSRCC1:1;
      uint16_t SELSRCC2:1;
      uint16_t SELSRCC3:1;
    };
  };
} CM2MSKSRCBITS;
extern volatile CM2MSKSRCBITS CM2MSKSRCbits __attribute__((__sfr__));


extern volatile uint16_t CM2MSKCON __attribute__((__sfr__));
typedef struct tagCM2MSKCONBITS {
  uint16_t AANEN:1;
  uint16_t AAEN:1;
  uint16_t ABNEN:1;
  uint16_t ABEN:1;
  uint16_t ACNEN:1;
  uint16_t ACEN:1;
  uint16_t PAGS:1;
  uint16_t NAGS:1;
  uint16_t OANEN:1;
  uint16_t OAEN:1;
  uint16_t OBNEN:1;
  uint16_t OBEN:1;
  uint16_t OCNEN:1;
  uint16_t OCEN:1;
  uint16_t :1;
  uint16_t HLMS:1;
} CM2MSKCONBITS;
extern volatile CM2MSKCONBITS CM2MSKCONbits __attribute__((__sfr__));


extern volatile uint16_t CM2FLTR __attribute__((__sfr__));
__extension__ typedef struct tagCM2FLTRBITS {
  union {
    struct {
      uint16_t CFDIV:3;
      uint16_t CFLTREN:1;
      uint16_t CFSEL:3;
    };
    struct {
      uint16_t CFDIV0:1;
      uint16_t CFDIV1:1;
      uint16_t CFDIV2:1;
      uint16_t :1;
      uint16_t CFSEL0:1;
      uint16_t CFSEL1:1;
      uint16_t CFSEL2:1;
    };
  };
} CM2FLTRBITS;
extern volatile CM2FLTRBITS CM2FLTRbits __attribute__((__sfr__));


extern volatile uint16_t CM3CON __attribute__((__sfr__));
__extension__ typedef struct tagCM3CONBITS {
  union {
    struct {
      uint16_t CCH:2;
      uint16_t :2;
      uint16_t CREF:1;
      uint16_t :1;
      uint16_t EVPOL:2;
      uint16_t COUT:1;
      uint16_t CEVT:1;
      uint16_t OPAEN:1;
      uint16_t :2;
      uint16_t CPOL:1;
      uint16_t COE:1;
      uint16_t CON:1;
    };
    struct {
      uint16_t CCH0:1;
      uint16_t CCH1:1;
      uint16_t :4;
      uint16_t EVPOL0:1;
      uint16_t EVPOL1:1;
      uint16_t :7;
      uint16_t CEN:1;
    };
  };
} CM3CONBITS;
extern volatile CM3CONBITS CM3CONbits __attribute__((__sfr__));


extern volatile uint16_t CM3MSKSRC __attribute__((__sfr__));
__extension__ typedef struct tagCM3MSKSRCBITS {
  union {
    struct {
      uint16_t SELSRCA:4;
      uint16_t SELSRCB:4;
      uint16_t SELSRCC:4;
    };
    struct {
      uint16_t SELSRCA0:1;
      uint16_t SELSRCA1:1;
      uint16_t SELSRCA2:1;
      uint16_t SELSRCA3:1;
      uint16_t SELSRCB0:1;
      uint16_t SELSRCB1:1;
      uint16_t SELSRCB2:1;
      uint16_t SELSRCB3:1;
      uint16_t SELSRCC0:1;
      uint16_t SELSRCC1:1;
      uint16_t SELSRCC2:1;
      uint16_t SELSRCC3:1;
    };
  };
} CM3MSKSRCBITS;
extern volatile CM3MSKSRCBITS CM3MSKSRCbits __attribute__((__sfr__));


extern volatile uint16_t CM3MSKCON __attribute__((__sfr__));
typedef struct tagCM3MSKCONBITS {
  uint16_t AANEN:1;
  uint16_t AAEN:1;
  uint16_t ABNEN:1;
  uint16_t ABEN:1;
  uint16_t ACNEN:1;
  uint16_t ACEN:1;
  uint16_t PAGS:1;
  uint16_t NAGS:1;
  uint16_t OANEN:1;
  uint16_t OAEN:1;
  uint16_t OBNEN:1;
  uint16_t OBEN:1;
  uint16_t OCNEN:1;
  uint16_t OCEN:1;
  uint16_t :1;
  uint16_t HLMS:1;
} CM3MSKCONBITS;
extern volatile CM3MSKCONBITS CM3MSKCONbits __attribute__((__sfr__));


extern volatile uint16_t CM3FLTR __attribute__((__sfr__));
__extension__ typedef struct tagCM3FLTRBITS {
  union {
    struct {
      uint16_t CFDIV:3;
      uint16_t CFLTREN:1;
      uint16_t CFSEL:3;
    };
    struct {
      uint16_t CFDIV0:1;
      uint16_t CFDIV1:1;
      uint16_t CFDIV2:1;
      uint16_t :1;
      uint16_t CFSEL0:1;
      uint16_t CFSEL1:1;
      uint16_t CFSEL2:1;
    };
  };
} CM3FLTRBITS;
extern volatile CM3FLTRBITS CM3FLTRbits __attribute__((__sfr__));


extern volatile uint16_t CM4CON __attribute__((__sfr__));
__extension__ typedef struct tagCM4CONBITS {
  union {
    struct {
      uint16_t CCH:2;
      uint16_t :2;
      uint16_t CREF:1;
      uint16_t :1;
      uint16_t EVPOL:2;
      uint16_t COUT:1;
      uint16_t CEVT:1;
      uint16_t :3;
      uint16_t CPOL:1;
      uint16_t COE:1;
      uint16_t CON:1;
    };
    struct {
      uint16_t CCH0:1;
      uint16_t CCH1:1;
      uint16_t :4;
      uint16_t EVPOL0:1;
      uint16_t EVPOL1:1;
      uint16_t :7;
      uint16_t CEN:1;
    };
  };
} CM4CONBITS;
extern volatile CM4CONBITS CM4CONbits __attribute__((__sfr__));


extern volatile uint16_t CM4MSKSRC __attribute__((__sfr__));
__extension__ typedef struct tagCM4MSKSRCBITS {
  union {
    struct {
      uint16_t SELSRCA:4;
      uint16_t SELSRCB:4;
      uint16_t SELSRCC:4;
    };
    struct {
      uint16_t SELSRCA0:1;
      uint16_t SELSRCA1:1;
      uint16_t SELSRCA2:1;
      uint16_t SELSRCA3:1;
      uint16_t SELSRCB0:1;
      uint16_t SELSRCB1:1;
      uint16_t SELSRCB2:1;
      uint16_t SELSRCB3:1;
      uint16_t SELSRCC0:1;
      uint16_t SELSRCC1:1;
      uint16_t SELSRCC2:1;
      uint16_t SELSRCC3:1;
    };
  };
} CM4MSKSRCBITS;
extern volatile CM4MSKSRCBITS CM4MSKSRCbits __attribute__((__sfr__));


extern volatile uint16_t CM4MSKCON __attribute__((__sfr__));
typedef struct tagCM4MSKCONBITS {
  uint16_t AANEN:1;
  uint16_t AAEN:1;
  uint16_t ABNEN:1;
  uint16_t ABEN:1;
  uint16_t ACNEN:1;
  uint16_t ACEN:1;
  uint16_t PAGS:1;
  uint16_t NAGS:1;
  uint16_t OANEN:1;
  uint16_t OAEN:1;
  uint16_t OBNEN:1;
  uint16_t OBEN:1;
  uint16_t OCNEN:1;
  uint16_t OCEN:1;
  uint16_t :1;
  uint16_t HLMS:1;
} CM4MSKCONBITS;
extern volatile CM4MSKCONBITS CM4MSKCONbits __attribute__((__sfr__));


extern volatile uint16_t CM4FLTR __attribute__((__sfr__));
__extension__ typedef struct tagCM4FLTRBITS {
  union {
    struct {
      uint16_t CFDIV:3;
      uint16_t CFLTREN:1;
      uint16_t CFSEL:3;
    };
    struct {
      uint16_t CFDIV0:1;
      uint16_t CFDIV1:1;
      uint16_t CFDIV2:1;
      uint16_t :1;
      uint16_t CFSEL0:1;
      uint16_t CFSEL1:1;
      uint16_t CFSEL2:1;
    };
  };
} CM4FLTRBITS;
extern volatile CM4FLTRBITS CM4FLTRbits __attribute__((__sfr__));


extern volatile uint16_t CM5CON __attribute__((__sfr__));
__extension__ typedef struct tagCM5CONBITS {
  union {
    struct {
      uint16_t CCH:2;
      uint16_t :2;
      uint16_t CREF:1;
      uint16_t :1;
      uint16_t EVPOL:2;
      uint16_t COUT:1;
      uint16_t CEVT:1;
      uint16_t OPAEN:1;
      uint16_t :2;
      uint16_t CPOL:1;
      uint16_t COE:1;
      uint16_t CON:1;
    };
    struct {
      uint16_t CCH0:1;
      uint16_t CCH1:1;
      uint16_t :4;
      uint16_t EVPOL0:1;
      uint16_t EVPOL1:1;
      uint16_t :7;
      uint16_t CEN:1;
    };
  };
} CM5CONBITS;
extern volatile CM5CONBITS CM5CONbits __attribute__((__sfr__));


extern volatile uint16_t CM5MSKSRC __attribute__((__sfr__));
__extension__ typedef struct tagCM5MSKSRCBITS {
  union {
    struct {
      uint16_t SELSRCA:4;
      uint16_t SELSRCB:4;
      uint16_t SELSRCC:4;
    };
    struct {
      uint16_t SELSRCA0:1;
      uint16_t SELSRCA1:1;
      uint16_t SELSRCA2:1;
      uint16_t SELSRCA3:1;
      uint16_t SELSRCB0:1;
      uint16_t SELSRCB1:1;
      uint16_t SELSRCB2:1;
      uint16_t SELSRCB3:1;
      uint16_t SELSRCC0:1;
      uint16_t SELSRCC1:1;
      uint16_t SELSRCC2:1;
      uint16_t SELSRCC3:1;
    };
  };
} CM5MSKSRCBITS;
extern volatile CM5MSKSRCBITS CM5MSKSRCbits __attribute__((__sfr__));


extern volatile uint16_t CM5MSKCON __attribute__((__sfr__));
typedef struct tagCM5MSKCONBITS {
  uint16_t AANEN:1;
  uint16_t AAEN:1;
  uint16_t ABNEN:1;
  uint16_t ABEN:1;
  uint16_t ACNEN:1;
  uint16_t ACEN:1;
  uint16_t PAGS:1;
  uint16_t NAGS:1;
  uint16_t OANEN:1;
  uint16_t OAEN:1;
  uint16_t OBNEN:1;
  uint16_t OBEN:1;
  uint16_t OCNEN:1;
  uint16_t OCEN:1;
  uint16_t :1;
  uint16_t HLMS:1;
} CM5MSKCONBITS;
extern volatile CM5MSKCONBITS CM5MSKCONbits __attribute__((__sfr__));


extern volatile uint16_t CM5FLTR __attribute__((__sfr__));
__extension__ typedef struct tagCM5FLTRBITS {
  union {
    struct {
      uint16_t CFDIV:3;
      uint16_t CFLTREN:1;
      uint16_t CFSEL:3;
    };
    struct {
      uint16_t CFDIV0:1;
      uint16_t CFDIV1:1;
      uint16_t CFDIV2:1;
      uint16_t :1;
      uint16_t CFSEL0:1;
      uint16_t CFSEL1:1;
      uint16_t CFSEL2:1;
    };
  };
} CM5FLTRBITS;
extern volatile CM5FLTRBITS CM5FLTRbits __attribute__((__sfr__));


extern volatile uint16_t CVR2CON __attribute__((__sfr__));
__extension__ typedef struct tagCVR2CONBITS {
  union {
    struct {
      uint16_t CVR:7;
      uint16_t :3;
      uint16_t VREFSEL:1;
      uint16_t CVRSS:1;
      uint16_t :2;
      uint16_t CVROE:1;
      uint16_t CVREN:1;
    };
    struct {
      uint16_t CVR0:1;
      uint16_t CVR1:1;
      uint16_t CVR2:1;
      uint16_t CVR3:1;
      uint16_t CVR4:1;
      uint16_t CVR5:1;
      uint16_t CVR6:1;
    };
  };
} CVR2CONBITS;
extern volatile CVR2CONBITS CVR2CONbits __attribute__((__sfr__));


extern volatile uint16_t DMA0CON __attribute__((__sfr__));
__extension__ typedef struct tagDMA0CONBITS {
  union {
    struct {
      uint16_t MODE:2;
      uint16_t :2;
      uint16_t AMODE:2;
      uint16_t :5;
      uint16_t NULLW:1;
      uint16_t HALF:1;
      uint16_t DIR:1;
      uint16_t SIZE:1;
      uint16_t CHEN:1;
    };
    struct {
      uint16_t MODE0:1;
      uint16_t MODE1:1;
      uint16_t :2;
      uint16_t AMODE0:1;
      uint16_t AMODE1:1;
    };
  };
} DMA0CONBITS;
extern volatile DMA0CONBITS DMA0CONbits __attribute__((__sfr__));


extern volatile uint16_t DMA0REQ __attribute__((__sfr__));
__extension__ typedef struct tagDMA0REQBITS {
  union {
    struct {
      uint16_t IRQSEL:8;
      uint16_t :7;
      uint16_t FORCE:1;
    };
    struct {
      uint16_t IRQSEL0:1;
      uint16_t IRQSEL1:1;
      uint16_t IRQSEL2:1;
      uint16_t IRQSEL3:1;
      uint16_t IRQSEL4:1;
      uint16_t IRQSEL5:1;
      uint16_t IRQSEL6:1;
      uint16_t IRQSEL7:1;
    };
  };
} DMA0REQBITS;
extern volatile DMA0REQBITS DMA0REQbits __attribute__((__sfr__));


extern volatile uint16_t DMA0STAL __attribute__((__sfr__));

extern volatile uint16_t DMA0STAH __attribute__((__sfr__));
typedef struct tagDMA0STAHBITS {
  uint16_t STA:8;
} DMA0STAHBITS;
extern volatile DMA0STAHBITS DMA0STAHbits __attribute__((__sfr__));


extern volatile uint16_t DMA0STBL __attribute__((__sfr__));

extern volatile uint16_t DMA0STBH __attribute__((__sfr__));
typedef struct tagDMA0STBHBITS {
  uint16_t STB:8;
} DMA0STBHBITS;
extern volatile DMA0STBHBITS DMA0STBHbits __attribute__((__sfr__));


extern volatile uint16_t DMA0PAD __attribute__((__sfr__));

extern volatile uint16_t DMA0CNT __attribute__((__sfr__));
typedef struct tagDMA0CNTBITS {
  uint16_t CNT:14;
} DMA0CNTBITS;
extern volatile DMA0CNTBITS DMA0CNTbits __attribute__((__sfr__));


extern volatile uint16_t DMA1CON __attribute__((__sfr__));
__extension__ typedef struct tagDMA1CONBITS {
  union {
    struct {
      uint16_t MODE:2;
      uint16_t :2;
      uint16_t AMODE:2;
      uint16_t :5;
      uint16_t NULLW:1;
      uint16_t HALF:1;
      uint16_t DIR:1;
      uint16_t SIZE:1;
      uint16_t CHEN:1;
    };
    struct {
      uint16_t MODE0:1;
      uint16_t MODE1:1;
      uint16_t :2;
      uint16_t AMODE0:1;
      uint16_t AMODE1:1;
    };
  };
} DMA1CONBITS;
extern volatile DMA1CONBITS DMA1CONbits __attribute__((__sfr__));


extern volatile uint16_t DMA1REQ __attribute__((__sfr__));
__extension__ typedef struct tagDMA1REQBITS {
  union {
    struct {
      uint16_t IRQSEL:8;
      uint16_t :7;
      uint16_t FORCE:1;
    };
    struct {
      uint16_t IRQSEL0:1;
      uint16_t IRQSEL1:1;
      uint16_t IRQSEL2:1;
      uint16_t IRQSEL3:1;
      uint16_t IRQSEL4:1;
      uint16_t IRQSEL5:1;
      uint16_t IRQSEL6:1;
      uint16_t IRQSEL7:1;
    };
  };
} DMA1REQBITS;
extern volatile DMA1REQBITS DMA1REQbits __attribute__((__sfr__));


extern volatile uint16_t DMA1STAL __attribute__((__sfr__));

extern volatile uint16_t DMA1STAH __attribute__((__sfr__));
typedef struct tagDMA1STAHBITS {
  uint16_t STA:8;
} DMA1STAHBITS;
extern volatile DMA1STAHBITS DMA1STAHbits __attribute__((__sfr__));


extern volatile uint16_t DMA1STBL __attribute__((__sfr__));

extern volatile uint16_t DMA1STBH __attribute__((__sfr__));
typedef struct tagDMA1STBHBITS {
  uint16_t STB:8;
} DMA1STBHBITS;
extern volatile DMA1STBHBITS DMA1STBHbits __attribute__((__sfr__));


extern volatile uint16_t DMA1PAD __attribute__((__sfr__));

extern volatile uint16_t DMA1CNT __attribute__((__sfr__));
typedef struct tagDMA1CNTBITS {
  uint16_t CNT:14;
} DMA1CNTBITS;
extern volatile DMA1CNTBITS DMA1CNTbits __attribute__((__sfr__));


extern volatile uint16_t DMA2CON __attribute__((__sfr__));
__extension__ typedef struct tagDMA2CONBITS {
  union {
    struct {
      uint16_t MODE:2;
      uint16_t :2;
      uint16_t AMODE:2;
      uint16_t :5;
      uint16_t NULLW:1;
      uint16_t HALF:1;
      uint16_t DIR:1;
      uint16_t SIZE:1;
      uint16_t CHEN:1;
    };
    struct {
      uint16_t MODE0:1;
      uint16_t MODE1:1;
      uint16_t :2;
      uint16_t AMODE0:1;
      uint16_t AMODE1:1;
    };
  };
} DMA2CONBITS;
extern volatile DMA2CONBITS DMA2CONbits __attribute__((__sfr__));


extern volatile uint16_t DMA2REQ __attribute__((__sfr__));
__extension__ typedef struct tagDMA2REQBITS {
  union {
    struct {
      uint16_t IRQSEL:8;
      uint16_t :7;
      uint16_t FORCE:1;
    };
    struct {
      uint16_t IRQSEL0:1;
      uint16_t IRQSEL1:1;
      uint16_t IRQSEL2:1;
      uint16_t IRQSEL3:1;
      uint16_t IRQSEL4:1;
      uint16_t IRQSEL5:1;
      uint16_t IRQSEL6:1;
      uint16_t IRQSEL7:1;
    };
  };
} DMA2REQBITS;
extern volatile DMA2REQBITS DMA2REQbits __attribute__((__sfr__));


extern volatile uint16_t DMA2STAL __attribute__((__sfr__));

extern volatile uint16_t DMA2STAH __attribute__((__sfr__));
typedef struct tagDMA2STAHBITS {
  uint16_t STA:8;
} DMA2STAHBITS;
extern volatile DMA2STAHBITS DMA2STAHbits __attribute__((__sfr__));


extern volatile uint16_t DMA2STBL __attribute__((__sfr__));

extern volatile uint16_t DMA2STBH __attribute__((__sfr__));
typedef struct tagDMA2STBHBITS {
  uint16_t STB:8;
} DMA2STBHBITS;
extern volatile DMA2STBHBITS DMA2STBHbits __attribute__((__sfr__));


extern volatile uint16_t DMA2PAD __attribute__((__sfr__));

extern volatile uint16_t DMA2CNT __attribute__((__sfr__));
typedef struct tagDMA2CNTBITS {
  uint16_t CNT:14;
} DMA2CNTBITS;
extern volatile DMA2CNTBITS DMA2CNTbits __attribute__((__sfr__));


extern volatile uint16_t DMA3CON __attribute__((__sfr__));
__extension__ typedef struct tagDMA3CONBITS {
  union {
    struct {
      uint16_t MODE:2;
      uint16_t :2;
      uint16_t AMODE:2;
      uint16_t :5;
      uint16_t NULLW:1;
      uint16_t HALF:1;
      uint16_t DIR:1;
      uint16_t SIZE:1;
      uint16_t CHEN:1;
    };
    struct {
      uint16_t MODE0:1;
      uint16_t MODE1:1;
      uint16_t :2;
      uint16_t AMODE0:1;
      uint16_t AMODE1:1;
    };
  };
} DMA3CONBITS;
extern volatile DMA3CONBITS DMA3CONbits __attribute__((__sfr__));


extern volatile uint16_t DMA3REQ __attribute__((__sfr__));
__extension__ typedef struct tagDMA3REQBITS {
  union {
    struct {
      uint16_t IRQSEL:8;
      uint16_t :7;
      uint16_t FORCE:1;
    };
    struct {
      uint16_t IRQSEL0:1;
      uint16_t IRQSEL1:1;
      uint16_t IRQSEL2:1;
      uint16_t IRQSEL3:1;
      uint16_t IRQSEL4:1;
      uint16_t IRQSEL5:1;
      uint16_t IRQSEL6:1;
      uint16_t IRQSEL7:1;
    };
  };
} DMA3REQBITS;
extern volatile DMA3REQBITS DMA3REQbits __attribute__((__sfr__));


extern volatile uint16_t DMA3STAL __attribute__((__sfr__));

extern volatile uint16_t DMA3STAH __attribute__((__sfr__));
typedef struct tagDMA3STAHBITS {
  uint16_t STA:8;
} DMA3STAHBITS;
extern volatile DMA3STAHBITS DMA3STAHbits __attribute__((__sfr__));


extern volatile uint16_t DMA3STBL __attribute__((__sfr__));

extern volatile uint16_t DMA3STBH __attribute__((__sfr__));
typedef struct tagDMA3STBHBITS {
  uint16_t STB:8;
} DMA3STBHBITS;
extern volatile DMA3STBHBITS DMA3STBHbits __attribute__((__sfr__));


extern volatile uint16_t DMA3PAD __attribute__((__sfr__));

extern volatile uint16_t DMA3CNT __attribute__((__sfr__));
typedef struct tagDMA3CNTBITS {
  uint16_t CNT:14;
} DMA3CNTBITS;
extern volatile DMA3CNTBITS DMA3CNTbits __attribute__((__sfr__));


extern volatile uint16_t DMAPWC __attribute__((__sfr__));
typedef struct tagDMAPWCBITS {
  uint16_t PWCOL0:1;
  uint16_t PWCOL1:1;
  uint16_t PWCOL2:1;
  uint16_t PWCOL3:1;
} DMAPWCBITS;
extern volatile DMAPWCBITS DMAPWCbits __attribute__((__sfr__));


extern volatile uint16_t DMARQC __attribute__((__sfr__));
typedef struct tagDMARQCBITS {
  uint16_t RQCOL0:1;
  uint16_t RQCOL1:1;
  uint16_t RQCOL2:1;
  uint16_t RQCOL3:1;
} DMARQCBITS;
extern volatile DMARQCBITS DMARQCbits __attribute__((__sfr__));


extern volatile uint16_t DMAPPS __attribute__((__sfr__));
typedef struct tagDMAPPSBITS {
  uint16_t PPST0:1;
  uint16_t PPST1:1;
  uint16_t PPST2:1;
  uint16_t PPST3:1;
} DMAPPSBITS;
extern volatile DMAPPSBITS DMAPPSbits __attribute__((__sfr__));


extern volatile uint16_t DMALCA __attribute__((__sfr__));
__extension__ typedef struct tagDMALCABITS {
  union {
    struct {
      uint16_t LSTCH:4;
    };
    struct {
      uint16_t LSTCH0:1;
      uint16_t LSTCH1:1;
      uint16_t LSTCH2:1;
      uint16_t LSTCH3:1;
    };
  };
} DMALCABITS;
extern volatile DMALCABITS DMALCAbits __attribute__((__sfr__));


extern volatile uint16_t DSADRL __attribute__((__sfr__));

extern volatile uint16_t DSADRH __attribute__((__sfr__));
typedef struct tagDSADRHBITS {
  uint16_t DSADR:8;
} DSADRHBITS;
extern volatile DSADRHBITS DSADRHbits __attribute__((__sfr__));


extern volatile uint16_t PTCON __attribute__((__sfr__));
__extension__ typedef struct tagPTCONBITS {
  union {
    struct {
      uint16_t SEVTPS:4;
      uint16_t SYNCSRC:3;
      uint16_t SYNCEN:1;
      uint16_t SYNCOEN:1;
      uint16_t SYNCPOL:1;
      uint16_t EIPU:1;
      uint16_t SEIEN:1;
      uint16_t SESTAT:1;
      uint16_t PTSIDL:1;
      uint16_t :1;
      uint16_t PTEN:1;
    };
    struct {
      uint16_t SEVTPS0:1;
      uint16_t SEVTPS1:1;
      uint16_t SEVTPS2:1;
      uint16_t SEVTPS3:1;
      uint16_t SYNCSRC0:1;
      uint16_t SYNCSRC1:1;
      uint16_t SYNCSRC2:1;
    };
  };
} PTCONBITS;
extern volatile PTCONBITS PTCONbits __attribute__((__sfr__));


extern volatile uint16_t PTCON2 __attribute__((__sfr__));
__extension__ typedef struct tagPTCON2BITS {
  union {
    struct {
      uint16_t PCLKDIV:3;
    };
    struct {
      uint16_t PCLKDIV0:1;
      uint16_t PCLKDIV1:1;
      uint16_t PCLKDIV2:1;
    };
  };
} PTCON2BITS;
extern volatile PTCON2BITS PTCON2bits __attribute__((__sfr__));


extern volatile uint16_t PTPER __attribute__((__sfr__));

extern volatile uint16_t SEVTCMP __attribute__((__sfr__));

extern volatile uint16_t MDC __attribute__((__sfr__));

extern volatile uint16_t CHOP __attribute__((__sfr__));
__extension__ typedef struct tagCHOPBITS {
  union {
    struct {
      uint16_t CHOPCLK:10;
      uint16_t :5;
      uint16_t CHPCLKEN:1;
    };
    struct {
      uint16_t CHOPCLK0:1;
      uint16_t CHOPCLK1:1;
      uint16_t CHOPCLK2:1;
      uint16_t CHOPCLK3:1;
      uint16_t CHOPCLK4:1;
      uint16_t CHOPCLK5:1;
      uint16_t CHOPCLK6:1;
      uint16_t CHOPCLK7:1;
      uint16_t CHOPCLK8:1;
      uint16_t CHOPCLK9:1;
    };
  };
} CHOPBITS;
extern volatile CHOPBITS CHOPbits __attribute__((__sfr__));


extern volatile uint16_t PWMKEY __attribute__((__sfr__));

extern volatile uint16_t PWMCON1 __attribute__((__sfr__));
__extension__ typedef struct tagPWMCON1BITS {
  union {
    struct {
      uint16_t IUE:1;
      uint16_t XPRES:1;
      uint16_t CAM:1;
      uint16_t :2;
      uint16_t DTCP:1;
      uint16_t DTC:2;
      uint16_t MDCS:1;
      uint16_t ITB:1;
      uint16_t TRGIEN:1;
      uint16_t CLIEN:1;
      uint16_t FLTIEN:1;
      uint16_t TRGSTAT:1;
      uint16_t CLSTAT:1;
      uint16_t FLTSTAT:1;
    };
    struct {
      uint16_t :6;
      uint16_t DTC0:1;
      uint16_t DTC1:1;
    };
  };
} PWMCON1BITS;
extern volatile PWMCON1BITS PWMCON1bits __attribute__((__sfr__));


extern volatile uint16_t IOCON1 __attribute__((__sfr__));
__extension__ typedef struct tagIOCON1BITS {
  union {
    struct {
      uint16_t OSYNC:1;
      uint16_t SWAP:1;
      uint16_t CLDAT:2;
      uint16_t FLTDAT:2;
      uint16_t OVRDAT:2;
      uint16_t OVRENL:1;
      uint16_t OVRENH:1;
      uint16_t PMOD:2;
      uint16_t POLL:1;
      uint16_t POLH:1;
      uint16_t PENL:1;
      uint16_t PENH:1;
    };
    struct {
      uint16_t :2;
      uint16_t CLDAT0:1;
      uint16_t CLDAT1:1;
      uint16_t FLTDAT0:1;
      uint16_t FLTDAT1:1;
      uint16_t OVRDAT0:1;
      uint16_t OVRDAT1:1;
      uint16_t :2;
      uint16_t PMOD0:1;
      uint16_t PMOD1:1;
    };
  };
} IOCON1BITS;
extern volatile IOCON1BITS IOCON1bits __attribute__((__sfr__));


extern volatile uint16_t FCLCON1 __attribute__((__sfr__));
__extension__ typedef struct tagFCLCON1BITS {
  union {
    struct {
      uint16_t FLTMOD:2;
      uint16_t FLTPOL:1;
      uint16_t FLTSRC:5;
      uint16_t CLMOD:1;
      uint16_t CLPOL:1;
      uint16_t CLSRC:5;
      uint16_t IFLTMOD:1;
    };
    struct {
      uint16_t FLTMOD0:1;
      uint16_t FLTMOD1:1;
      uint16_t :1;
      uint16_t FLTSRC0:1;
      uint16_t FLTSRC1:1;
      uint16_t FLTSRC2:1;
      uint16_t FLTSRC3:1;
      uint16_t FLTSRC4:1;
      uint16_t :2;
      uint16_t CLSRC0:1;
      uint16_t CLSRC1:1;
      uint16_t CLSRC2:1;
      uint16_t CLSRC3:1;
      uint16_t CLSRC4:1;
    };
  };
} FCLCON1BITS;
extern volatile FCLCON1BITS FCLCON1bits __attribute__((__sfr__));


extern volatile uint16_t PDC1 __attribute__((__sfr__));

extern volatile uint16_t PHASE1 __attribute__((__sfr__));

extern volatile uint16_t DTR1 __attribute__((__sfr__));

extern volatile uint16_t ALTDTR1 __attribute__((__sfr__));

extern volatile uint16_t TRIG1 __attribute__((__sfr__));
__extension__ typedef struct tagTRIG1BITS {
  union {
    struct {
      uint16_t TRGCMP:16;
    };
    struct {
      uint16_t TRGCMP0:1;
      uint16_t TRGCMP1:1;
      uint16_t TRGCMP2:1;
      uint16_t TRGCMP3:1;
      uint16_t TRGCMP4:1;
      uint16_t TRGCMP5:1;
      uint16_t TRGCMP6:1;
      uint16_t TRGCMP7:1;
      uint16_t TRGCMP8:1;
      uint16_t TRGCMP9:1;
      uint16_t TRGCMP10:1;
      uint16_t TRGCMP11:1;
      uint16_t TRGCMP12:1;
      uint16_t TRGCMP13:1;
      uint16_t TRGCMP14:1;
      uint16_t TRGCMP15:1;
    };
  };
} TRIG1BITS;
extern volatile TRIG1BITS TRIG1bits __attribute__((__sfr__));


extern volatile uint16_t TRGCON1 __attribute__((__sfr__));
__extension__ typedef struct tagTRGCON1BITS {
  union {
    struct {
      uint16_t TRGSTRT:6;
      uint16_t :6;
      uint16_t TRGDIV:4;
    };
    struct {
      uint16_t TRGSTRT0:1;
      uint16_t TRGSTRT1:1;
      uint16_t TRGSTRT2:1;
      uint16_t TRGSTRT3:1;
      uint16_t TRGSTRT4:1;
      uint16_t TRGSTRT5:1;
      uint16_t :6;
      uint16_t TRGDIV0:1;
      uint16_t TRGDIV1:1;
      uint16_t TRGDIV2:1;
      uint16_t TRGDIV3:1;
    };
  };
} TRGCON1BITS;
extern volatile TRGCON1BITS TRGCON1bits __attribute__((__sfr__));


extern volatile uint16_t PWMCAP1 __attribute__((__sfr__));
__extension__ typedef struct tagPWMCAP1BITS {
  union {
    struct {
      uint16_t :3;
      uint16_t PWMCAP:13;
    };
    struct {
      uint16_t :3;
      uint16_t PWMCAP0:1;
      uint16_t PWMCAP1:1;
      uint16_t PWMCAP2:1;
      uint16_t PWMCAP3:1;
      uint16_t PWMCAP4:1;
      uint16_t PWMCAP5:1;
      uint16_t PWMCAP6:1;
      uint16_t PWMCAP7:1;
      uint16_t PWMCAP8:1;
      uint16_t PWMCAP9:1;
      uint16_t PWMCAP10:1;
      uint16_t PWMCAP11:1;
      uint16_t PWMCAP12:1;
    };
  };
} PWMCAP1BITS;
extern volatile PWMCAP1BITS PWMCAP1bits __attribute__((__sfr__));


extern volatile uint16_t LEBCON1 __attribute__((__sfr__));
typedef struct tagLEBCON1BITS {
  uint16_t BPLL:1;
  uint16_t BPLH:1;
  uint16_t BPHL:1;
  uint16_t BPHH:1;
  uint16_t BCL:1;
  uint16_t BCH:1;
  uint16_t :4;
  uint16_t CLLEBEN:1;
  uint16_t FLTLEBEN:1;
  uint16_t PLF:1;
  uint16_t PLR:1;
  uint16_t PHF:1;
  uint16_t PHR:1;
} LEBCON1BITS;
extern volatile LEBCON1BITS LEBCON1bits __attribute__((__sfr__));


extern volatile uint16_t LEBDLY1 __attribute__((__sfr__));
__extension__ typedef struct tagLEBDLY1BITS {
  union {
    struct {
      uint16_t :3;
      uint16_t LEB:9;
    };
    struct {
      uint16_t :3;
      uint16_t LEB0:1;
      uint16_t LEB1:1;
      uint16_t LEB2:1;
      uint16_t LEB3:1;
      uint16_t LEB4:1;
      uint16_t LEB5:1;
      uint16_t LEB6:1;
      uint16_t LEB7:1;
      uint16_t LEB8:1;
    };
  };
} LEBDLY1BITS;
extern volatile LEBDLY1BITS LEBDLY1bits __attribute__((__sfr__));


extern volatile uint16_t AUXCON1 __attribute__((__sfr__));
__extension__ typedef struct tagAUXCON1BITS {
  union {
    struct {
      uint16_t CHOPLEN:1;
      uint16_t CHOPHEN:1;
      uint16_t CHOPSEL:4;
      uint16_t :2;
      uint16_t BLANKSEL:4;
    };
    struct {
      uint16_t :2;
      uint16_t CHOPSEL0:1;
      uint16_t CHOPSEL1:1;
      uint16_t CHOPSEL2:1;
      uint16_t CHOPSEL3:1;
      uint16_t :2;
      uint16_t BLANKSEL0:1;
      uint16_t BLANKSEL1:1;
      uint16_t BLANKSEL2:1;
      uint16_t BLANKSEL3:1;
    };
  };
} AUXCON1BITS;
extern volatile AUXCON1BITS AUXCON1bits __attribute__((__sfr__));


extern volatile uint16_t PWMCON2 __attribute__((__sfr__));
__extension__ typedef struct tagPWMCON2BITS {
  union {
    struct {
      uint16_t IUE:1;
      uint16_t XPRES:1;
      uint16_t CAM:1;
      uint16_t :2;
      uint16_t DTCP:1;
      uint16_t DTC:2;
      uint16_t MDCS:1;
      uint16_t ITB:1;
      uint16_t TRGIEN:1;
      uint16_t CLIEN:1;
      uint16_t FLTIEN:1;
      uint16_t TRGSTAT:1;
      uint16_t CLSTAT:1;
      uint16_t FLTSTAT:1;
    };
    struct {
      uint16_t :6;
      uint16_t DTC0:1;
      uint16_t DTC1:1;
    };
  };
} PWMCON2BITS;
extern volatile PWMCON2BITS PWMCON2bits __attribute__((__sfr__));


extern volatile uint16_t IOCON2 __attribute__((__sfr__));
__extension__ typedef struct tagIOCON2BITS {
  union {
    struct {
      uint16_t OSYNC:1;
      uint16_t SWAP:1;
      uint16_t CLDAT:2;
      uint16_t FLTDAT:2;
      uint16_t OVRDAT:2;
      uint16_t OVRENL:1;
      uint16_t OVRENH:1;
      uint16_t PMOD:2;
      uint16_t POLL:1;
      uint16_t POLH:1;
      uint16_t PENL:1;
      uint16_t PENH:1;
    };
    struct {
      uint16_t :2;
      uint16_t CLDAT0:1;
      uint16_t CLDAT1:1;
      uint16_t FLTDAT0:1;
      uint16_t FLTDAT1:1;
      uint16_t OVRDAT0:1;
      uint16_t OVRDAT1:1;
      uint16_t :2;
      uint16_t PMOD0:1;
      uint16_t PMOD1:1;
    };
  };
} IOCON2BITS;
extern volatile IOCON2BITS IOCON2bits __attribute__((__sfr__));


extern volatile uint16_t FCLCON2 __attribute__((__sfr__));
__extension__ typedef struct tagFCLCON2BITS {
  union {
    struct {
      uint16_t FLTMOD:2;
      uint16_t FLTPOL:1;
      uint16_t FLTSRC:5;
      uint16_t CLMOD:1;
      uint16_t CLPOL:1;
      uint16_t CLSRC:5;
      uint16_t IFLTMOD:1;
    };
    struct {
      uint16_t FLTMOD0:1;
      uint16_t FLTMOD1:1;
      uint16_t :1;
      uint16_t FLTSRC0:1;
      uint16_t FLTSRC1:1;
      uint16_t FLTSRC2:1;
      uint16_t FLTSRC3:1;
      uint16_t FLTSRC4:1;
      uint16_t :2;
      uint16_t CLSRC0:1;
      uint16_t CLSRC1:1;
      uint16_t CLSRC2:1;
      uint16_t CLSRC3:1;
      uint16_t CLSRC4:1;
    };
  };
} FCLCON2BITS;
extern volatile FCLCON2BITS FCLCON2bits __attribute__((__sfr__));


extern volatile uint16_t PDC2 __attribute__((__sfr__));

extern volatile uint16_t PHASE2 __attribute__((__sfr__));

extern volatile uint16_t DTR2 __attribute__((__sfr__));

extern volatile uint16_t ALTDTR2 __attribute__((__sfr__));

extern volatile uint16_t TRIG2 __attribute__((__sfr__));
__extension__ typedef struct tagTRIG2BITS {
  union {
    struct {
      uint16_t TRGCMP:16;
    };
    struct {
      uint16_t TRGCMP0:1;
      uint16_t TRGCMP1:1;
      uint16_t TRGCMP2:1;
      uint16_t TRGCMP3:1;
      uint16_t TRGCMP4:1;
      uint16_t TRGCMP5:1;
      uint16_t TRGCMP6:1;
      uint16_t TRGCMP7:1;
      uint16_t TRGCMP8:1;
      uint16_t TRGCMP9:1;
      uint16_t TRGCMP10:1;
      uint16_t TRGCMP11:1;
      uint16_t TRGCMP12:1;
      uint16_t TRGCMP13:1;
      uint16_t TRGCMP14:1;
      uint16_t TRGCMP15:1;
    };
  };
} TRIG2BITS;
extern volatile TRIG2BITS TRIG2bits __attribute__((__sfr__));


extern volatile uint16_t TRGCON2 __attribute__((__sfr__));
__extension__ typedef struct tagTRGCON2BITS {
  union {
    struct {
      uint16_t TRGSTRT:6;
      uint16_t :6;
      uint16_t TRGDIV:4;
    };
    struct {
      uint16_t TRGSTRT0:1;
      uint16_t TRGSTRT1:1;
      uint16_t TRGSTRT2:1;
      uint16_t TRGSTRT3:1;
      uint16_t TRGSTRT4:1;
      uint16_t TRGSTRT5:1;
      uint16_t :6;
      uint16_t TRGDIV0:1;
      uint16_t TRGDIV1:1;
      uint16_t TRGDIV2:1;
      uint16_t TRGDIV3:1;
    };
  };
} TRGCON2BITS;
extern volatile TRGCON2BITS TRGCON2bits __attribute__((__sfr__));


extern volatile uint16_t PWMCAP2 __attribute__((__sfr__));
__extension__ typedef struct tagPWMCAP2BITS {
  union {
    struct {
      uint16_t :3;
      uint16_t PWMCAP:13;
    };
    struct {
      uint16_t :3;
      uint16_t PWMCAP0:1;
      uint16_t PWMCAP1:1;
      uint16_t PWMCAP2:1;
      uint16_t PWMCAP3:1;
      uint16_t PWMCAP4:1;
      uint16_t PWMCAP5:1;
      uint16_t PWMCAP6:1;
      uint16_t PWMCAP7:1;
      uint16_t PWMCAP8:1;
      uint16_t PWMCAP9:1;
      uint16_t PWMCAP10:1;
      uint16_t PWMCAP11:1;
      uint16_t PWMCAP12:1;
    };
  };
} PWMCAP2BITS;
extern volatile PWMCAP2BITS PWMCAP2bits __attribute__((__sfr__));


extern volatile uint16_t LEBCON2 __attribute__((__sfr__));
typedef struct tagLEBCON2BITS {
  uint16_t BPLL:1;
  uint16_t BPLH:1;
  uint16_t BPHL:1;
  uint16_t BPHH:1;
  uint16_t BCL:1;
  uint16_t BCH:1;
  uint16_t :4;
  uint16_t CLLEBEN:1;
  uint16_t FLTLEBEN:1;
  uint16_t PLF:1;
  uint16_t PLR:1;
  uint16_t PHF:1;
  uint16_t PHR:1;
} LEBCON2BITS;
extern volatile LEBCON2BITS LEBCON2bits __attribute__((__sfr__));


extern volatile uint16_t LEBDLY2 __attribute__((__sfr__));
__extension__ typedef struct tagLEBDLY2BITS {
  union {
    struct {
      uint16_t :3;
      uint16_t LEB:9;
    };
    struct {
      uint16_t :3;
      uint16_t LEB0:1;
      uint16_t LEB1:1;
      uint16_t LEB2:1;
      uint16_t LEB3:1;
      uint16_t LEB4:1;
      uint16_t LEB5:1;
      uint16_t LEB6:1;
      uint16_t LEB7:1;
      uint16_t LEB8:1;
    };
  };
} LEBDLY2BITS;
extern volatile LEBDLY2BITS LEBDLY2bits __attribute__((__sfr__));


extern volatile uint16_t AUXCON2 __attribute__((__sfr__));
__extension__ typedef struct tagAUXCON2BITS {
  union {
    struct {
      uint16_t CHOPLEN:1;
      uint16_t CHOPHEN:1;
      uint16_t CHOPSEL:4;
      uint16_t :2;
      uint16_t BLANKSEL:4;
    };
    struct {
      uint16_t :2;
      uint16_t CHOPSEL0:1;
      uint16_t CHOPSEL1:1;
      uint16_t CHOPSEL2:1;
      uint16_t CHOPSEL3:1;
      uint16_t :2;
      uint16_t BLANKSEL0:1;
      uint16_t BLANKSEL1:1;
      uint16_t BLANKSEL2:1;
      uint16_t BLANKSEL3:1;
    };
  };
} AUXCON2BITS;
extern volatile AUXCON2BITS AUXCON2bits __attribute__((__sfr__));


extern volatile uint16_t PWMCON3 __attribute__((__sfr__));
__extension__ typedef struct tagPWMCON3BITS {
  union {
    struct {
      uint16_t IUE:1;
      uint16_t XPRES:1;
      uint16_t CAM:1;
      uint16_t :2;
      uint16_t DTCP:1;
      uint16_t DTC:2;
      uint16_t MDCS:1;
      uint16_t ITB:1;
      uint16_t TRGIEN:1;
      uint16_t CLIEN:1;
      uint16_t FLTIEN:1;
      uint16_t TRGSTAT:1;
      uint16_t CLSTAT:1;
      uint16_t FLTSTAT:1;
    };
    struct {
      uint16_t :6;
      uint16_t DTC0:1;
      uint16_t DTC1:1;
    };
  };
} PWMCON3BITS;
extern volatile PWMCON3BITS PWMCON3bits __attribute__((__sfr__));


extern volatile uint16_t IOCON3 __attribute__((__sfr__));
__extension__ typedef struct tagIOCON3BITS {
  union {
    struct {
      uint16_t OSYNC:1;
      uint16_t SWAP:1;
      uint16_t CLDAT:2;
      uint16_t FLTDAT:2;
      uint16_t OVRDAT:2;
      uint16_t OVRENL:1;
      uint16_t OVRENH:1;
      uint16_t PMOD:2;
      uint16_t POLL:1;
      uint16_t POLH:1;
      uint16_t PENL:1;
      uint16_t PENH:1;
    };
    struct {
      uint16_t :2;
      uint16_t CLDAT0:1;
      uint16_t CLDAT1:1;
      uint16_t FLTDAT0:1;
      uint16_t FLTDAT1:1;
      uint16_t OVRDAT0:1;
      uint16_t OVRDAT1:1;
      uint16_t :2;
      uint16_t PMOD0:1;
      uint16_t PMOD1:1;
    };
  };
} IOCON3BITS;
extern volatile IOCON3BITS IOCON3bits __attribute__((__sfr__));


extern volatile uint16_t FCLCON3 __attribute__((__sfr__));
__extension__ typedef struct tagFCLCON3BITS {
  union {
    struct {
      uint16_t FLTMOD:2;
      uint16_t FLTPOL:1;
      uint16_t FLTSRC:5;
      uint16_t CLMOD:1;
      uint16_t CLPOL:1;
      uint16_t CLSRC:5;
      uint16_t IFLTMOD:1;
    };
    struct {
      uint16_t FLTMOD0:1;
      uint16_t FLTMOD1:1;
      uint16_t :1;
      uint16_t FLTSRC0:1;
      uint16_t FLTSRC1:1;
      uint16_t FLTSRC2:1;
      uint16_t FLTSRC3:1;
      uint16_t FLTSRC4:1;
      uint16_t :2;
      uint16_t CLSRC0:1;
      uint16_t CLSRC1:1;
      uint16_t CLSRC2:1;
      uint16_t CLSRC3:1;
      uint16_t CLSRC4:1;
    };
  };
} FCLCON3BITS;
extern volatile FCLCON3BITS FCLCON3bits __attribute__((__sfr__));


extern volatile uint16_t PDC3 __attribute__((__sfr__));

extern volatile uint16_t PHASE3 __attribute__((__sfr__));

extern volatile uint16_t DTR3 __attribute__((__sfr__));

extern volatile uint16_t ALTDTR3 __attribute__((__sfr__));

extern volatile uint16_t TRIG3 __attribute__((__sfr__));
__extension__ typedef struct tagTRIG3BITS {
  union {
    struct {
      uint16_t TRGCMP:16;
    };
    struct {
      uint16_t TRGCMP0:1;
      uint16_t TRGCMP1:1;
      uint16_t TRGCMP2:1;
      uint16_t TRGCMP3:1;
      uint16_t TRGCMP4:1;
      uint16_t TRGCMP5:1;
      uint16_t TRGCMP6:1;
      uint16_t TRGCMP7:1;
      uint16_t TRGCMP8:1;
      uint16_t TRGCMP9:1;
      uint16_t TRGCMP10:1;
      uint16_t TRGCMP11:1;
      uint16_t TRGCMP12:1;
      uint16_t TRGCMP13:1;
      uint16_t TRGCMP14:1;
      uint16_t TRGCMP15:1;
    };
  };
} TRIG3BITS;
extern volatile TRIG3BITS TRIG3bits __attribute__((__sfr__));


extern volatile uint16_t TRGCON3 __attribute__((__sfr__));
__extension__ typedef struct tagTRGCON3BITS {
  union {
    struct {
      uint16_t TRGSTRT:6;
      uint16_t :6;
      uint16_t TRGDIV:4;
    };
    struct {
      uint16_t TRGSTRT0:1;
      uint16_t TRGSTRT1:1;
      uint16_t TRGSTRT2:1;
      uint16_t TRGSTRT3:1;
      uint16_t TRGSTRT4:1;
      uint16_t TRGSTRT5:1;
      uint16_t :6;
      uint16_t TRGDIV0:1;
      uint16_t TRGDIV1:1;
      uint16_t TRGDIV2:1;
      uint16_t TRGDIV3:1;
    };
  };
} TRGCON3BITS;
extern volatile TRGCON3BITS TRGCON3bits __attribute__((__sfr__));


extern volatile uint16_t PWMCAP3 __attribute__((__sfr__));
__extension__ typedef struct tagPWMCAP3BITS {
  union {
    struct {
      uint16_t :3;
      uint16_t PWMCAP:13;
    };
    struct {
      uint16_t :3;
      uint16_t PWMCAP0:1;
      uint16_t PWMCAP1:1;
      uint16_t PWMCAP2:1;
      uint16_t PWMCAP3:1;
      uint16_t PWMCAP4:1;
      uint16_t PWMCAP5:1;
      uint16_t PWMCAP6:1;
      uint16_t PWMCAP7:1;
      uint16_t PWMCAP8:1;
      uint16_t PWMCAP9:1;
      uint16_t PWMCAP10:1;
      uint16_t PWMCAP11:1;
      uint16_t PWMCAP12:1;
    };
  };
} PWMCAP3BITS;
extern volatile PWMCAP3BITS PWMCAP3bits __attribute__((__sfr__));


extern volatile uint16_t LEBCON3 __attribute__((__sfr__));
typedef struct tagLEBCON3BITS {
  uint16_t BPLL:1;
  uint16_t BPLH:1;
  uint16_t BPHL:1;
  uint16_t BPHH:1;
  uint16_t BCL:1;
  uint16_t BCH:1;
  uint16_t :4;
  uint16_t CLLEBEN:1;
  uint16_t FLTLEBEN:1;
  uint16_t PLF:1;
  uint16_t PLR:1;
  uint16_t PHF:1;
  uint16_t PHR:1;
} LEBCON3BITS;
extern volatile LEBCON3BITS LEBCON3bits __attribute__((__sfr__));


extern volatile uint16_t LEBDLY3 __attribute__((__sfr__));
__extension__ typedef struct tagLEBDLY3BITS {
  union {
    struct {
      uint16_t :3;
      uint16_t LEB:9;
    };
    struct {
      uint16_t :3;
      uint16_t LEB0:1;
      uint16_t LEB1:1;
      uint16_t LEB2:1;
      uint16_t LEB3:1;
      uint16_t LEB4:1;
      uint16_t LEB5:1;
      uint16_t LEB6:1;
      uint16_t LEB7:1;
      uint16_t LEB8:1;
    };
  };
} LEBDLY3BITS;
extern volatile LEBDLY3BITS LEBDLY3bits __attribute__((__sfr__));


extern volatile uint16_t AUXCON3 __attribute__((__sfr__));
__extension__ typedef struct tagAUXCON3BITS {
  union {
    struct {
      uint16_t CHOPLEN:1;
      uint16_t CHOPHEN:1;
      uint16_t CHOPSEL:4;
      uint16_t :2;
      uint16_t BLANKSEL:4;
    };
    struct {
      uint16_t :2;
      uint16_t CHOPSEL0:1;
      uint16_t CHOPSEL1:1;
      uint16_t CHOPSEL2:1;
      uint16_t CHOPSEL3:1;
      uint16_t :2;
      uint16_t BLANKSEL0:1;
      uint16_t BLANKSEL1:1;
      uint16_t BLANKSEL2:1;
      uint16_t BLANKSEL3:1;
    };
  };
} AUXCON3BITS;
extern volatile AUXCON3BITS AUXCON3bits __attribute__((__sfr__));


extern volatile uint16_t TRISA __attribute__((__sfr__));
typedef struct tagTRISABITS {
  uint16_t TRISA0:1;
  uint16_t TRISA1:1;
  uint16_t :2;
  uint16_t TRISA4:1;
  uint16_t :2;
  uint16_t TRISA7:1;
  uint16_t TRISA8:1;
  uint16_t TRISA9:1;
  uint16_t TRISA10:1;
  uint16_t TRISA11:1;
  uint16_t TRISA12:1;
} TRISABITS;
extern volatile TRISABITS TRISAbits __attribute__((__sfr__));


extern volatile uint16_t PORTA __attribute__((__sfr__));
typedef struct tagPORTABITS {
  uint16_t RA0:1;
  uint16_t RA1:1;
  uint16_t :2;
  uint16_t RA4:1;
  uint16_t :2;
  uint16_t RA7:1;
  uint16_t RA8:1;
  uint16_t RA9:1;
  uint16_t RA10:1;
  uint16_t RA11:1;
  uint16_t RA12:1;
} PORTABITS;
extern volatile PORTABITS PORTAbits __attribute__((__sfr__));


extern volatile uint16_t LATA __attribute__((__sfr__));
typedef struct tagLATABITS {
  uint16_t LATA0:1;
  uint16_t LATA1:1;
  uint16_t :2;
  uint16_t LATA4:1;
  uint16_t :2;
  uint16_t LATA7:1;
  uint16_t LATA8:1;
  uint16_t LATA9:1;
  uint16_t LATA10:1;
  uint16_t LATA11:1;
  uint16_t LATA12:1;
} LATABITS;
extern volatile LATABITS LATAbits __attribute__((__sfr__));


extern volatile uint16_t ODCA __attribute__((__sfr__));
typedef struct tagODCABITS {
  uint16_t ODCA0:1;
  uint16_t ODCA1:1;
  uint16_t :2;
  uint16_t ODCA4:1;
  uint16_t :2;
  uint16_t ODCA7:1;
  uint16_t ODCA8:1;
  uint16_t ODCA9:1;
  uint16_t ODCA10:1;
  uint16_t ODCA11:1;
  uint16_t ODCA12:1;
} ODCABITS;
extern volatile ODCABITS ODCAbits __attribute__((__sfr__));


extern volatile uint16_t CNENA __attribute__((__sfr__));
typedef struct tagCNENABITS {
  uint16_t CNIEA0:1;
  uint16_t CNIEA1:1;
  uint16_t :2;
  uint16_t CNIEA4:1;
  uint16_t :2;
  uint16_t CNIEA7:1;
  uint16_t CNIEA8:1;
  uint16_t CNIEA9:1;
  uint16_t CNIEA10:1;
  uint16_t CNIEA11:1;
  uint16_t CNIEA12:1;
} CNENABITS;
extern volatile CNENABITS CNENAbits __attribute__((__sfr__));


extern volatile uint16_t CNPUA __attribute__((__sfr__));
typedef struct tagCNPUABITS {
  uint16_t CNPUA0:1;
  uint16_t CNPUA1:1;
  uint16_t :2;
  uint16_t CNPUA4:1;
  uint16_t :2;
  uint16_t CNPUA7:1;
  uint16_t CNPUA8:1;
  uint16_t CNPUA9:1;
  uint16_t CNPUA10:1;
  uint16_t CNPUA11:1;
  uint16_t CNPUA12:1;
} CNPUABITS;
extern volatile CNPUABITS CNPUAbits __attribute__((__sfr__));


extern volatile uint16_t CNPDA __attribute__((__sfr__));
typedef struct tagCNPDABITS {
  uint16_t CNPDA0:1;
  uint16_t CNPDA1:1;
  uint16_t :2;
  uint16_t CNPDA4:1;
  uint16_t :2;
  uint16_t CNPDA7:1;
  uint16_t CNPDA8:1;
  uint16_t CNPDA9:1;
  uint16_t CNPDA10:1;
  uint16_t CNPDA11:1;
  uint16_t CNPDA12:1;
} CNPDABITS;
extern volatile CNPDABITS CNPDAbits __attribute__((__sfr__));


extern volatile uint16_t ANSELA __attribute__((__sfr__));
typedef struct tagANSELABITS {
  uint16_t ANSA0:1;
  uint16_t ANSA1:1;
  uint16_t :2;
  uint16_t ANSA4:1;
  uint16_t :2;
  uint16_t ANSA7:1;
  uint16_t :1;
  uint16_t ANSA9:1;
  uint16_t ANSA10:1;
  uint16_t ANSA11:1;
  uint16_t ANSA12:1;
} ANSELABITS;
extern volatile ANSELABITS ANSELAbits __attribute__((__sfr__));


extern volatile uint16_t SR1A __attribute__((__sfr__));
typedef struct tagSR1ABITS {
  uint16_t :4;
  uint16_t SR1A4:1;
  uint16_t :4;
  uint16_t SR1A9:1;
} SR1ABITS;
extern volatile SR1ABITS SR1Abits __attribute__((__sfr__));


extern volatile uint16_t SR0A __attribute__((__sfr__));
typedef struct tagSR0ABITS {
  uint16_t :4;
  uint16_t SR0A4:1;
  uint16_t :4;
  uint16_t SR0A9:1;
} SR0ABITS;
extern volatile SR0ABITS SR0Abits __attribute__((__sfr__));


extern volatile uint16_t TRISB __attribute__((__sfr__));
typedef struct tagTRISBBITS {
  uint16_t TRISB0:1;
  uint16_t TRISB1:1;
  uint16_t TRISB2:1;
  uint16_t TRISB3:1;
  uint16_t TRISB4:1;
  uint16_t TRISB5:1;
  uint16_t TRISB6:1;
  uint16_t TRISB7:1;
  uint16_t TRISB8:1;
  uint16_t TRISB9:1;
  uint16_t TRISB10:1;
  uint16_t TRISB11:1;
  uint16_t TRISB12:1;
  uint16_t TRISB13:1;
  uint16_t TRISB14:1;
  uint16_t TRISB15:1;
} TRISBBITS;
extern volatile TRISBBITS TRISBbits __attribute__((__sfr__));


extern volatile uint16_t PORTB __attribute__((__sfr__));
typedef struct tagPORTBBITS {
  uint16_t RB0:1;
  uint16_t RB1:1;
  uint16_t RB2:1;
  uint16_t RB3:1;
  uint16_t RB4:1;
  uint16_t RB5:1;
  uint16_t RB6:1;
  uint16_t RB7:1;
  uint16_t RB8:1;
  uint16_t RB9:1;
  uint16_t RB10:1;
  uint16_t RB11:1;
  uint16_t RB12:1;
  uint16_t RB13:1;
  uint16_t RB14:1;
  uint16_t RB15:1;
} PORTBBITS;
extern volatile PORTBBITS PORTBbits __attribute__((__sfr__));


extern volatile uint16_t LATB __attribute__((__sfr__));
typedef struct tagLATBBITS {
  uint16_t LATB0:1;
  uint16_t LATB1:1;
  uint16_t LATB2:1;
  uint16_t LATB3:1;
  uint16_t LATB4:1;
  uint16_t LATB5:1;
  uint16_t LATB6:1;
  uint16_t LATB7:1;
  uint16_t LATB8:1;
  uint16_t LATB9:1;
  uint16_t LATB10:1;
  uint16_t LATB11:1;
  uint16_t LATB12:1;
  uint16_t LATB13:1;
  uint16_t LATB14:1;
  uint16_t LATB15:1;
} LATBBITS;
extern volatile LATBBITS LATBbits __attribute__((__sfr__));


extern volatile uint16_t ODCB __attribute__((__sfr__));
typedef struct tagODCBBITS {
  uint16_t ODCB0:1;
  uint16_t ODCB1:1;
  uint16_t ODCB2:1;
  uint16_t ODCB3:1;
  uint16_t ODCB4:1;
  uint16_t ODCB5:1;
  uint16_t ODCB6:1;
  uint16_t ODCB7:1;
  uint16_t ODCB8:1;
  uint16_t ODCB9:1;
  uint16_t ODCB10:1;
  uint16_t ODCB11:1;
  uint16_t ODCB12:1;
  uint16_t ODCB13:1;
  uint16_t ODCB14:1;
  uint16_t ODCB15:1;
} ODCBBITS;
extern volatile ODCBBITS ODCBbits __attribute__((__sfr__));


extern volatile uint16_t CNENB __attribute__((__sfr__));
typedef struct tagCNENBBITS {
  uint16_t CNIEB0:1;
  uint16_t CNIEB1:1;
  uint16_t CNIEB2:1;
  uint16_t CNIEB3:1;
  uint16_t CNIEB4:1;
  uint16_t CNIEB5:1;
  uint16_t CNIEB6:1;
  uint16_t CNIEB7:1;
  uint16_t CNIEB8:1;
  uint16_t CNIEB9:1;
  uint16_t CNIEB10:1;
  uint16_t CNIEB11:1;
  uint16_t CNIEB12:1;
  uint16_t CNIEB13:1;
  uint16_t CNIEB14:1;
  uint16_t CNIEB15:1;
} CNENBBITS;
extern volatile CNENBBITS CNENBbits __attribute__((__sfr__));


extern volatile uint16_t CNPUB __attribute__((__sfr__));
typedef struct tagCNPUBBITS {
  uint16_t CNPUB0:1;
  uint16_t CNPUB1:1;
  uint16_t CNPUB2:1;
  uint16_t CNPUB3:1;
  uint16_t CNPUB4:1;
  uint16_t CNPUB5:1;
  uint16_t CNPUB6:1;
  uint16_t CNPUB7:1;
  uint16_t CNPUB8:1;
  uint16_t CNPUB9:1;
  uint16_t CNPUB10:1;
  uint16_t CNPUB11:1;
  uint16_t CNPUB12:1;
  uint16_t CNPUB13:1;
  uint16_t CNPUB14:1;
  uint16_t CNPUB15:1;
} CNPUBBITS;
extern volatile CNPUBBITS CNPUBbits __attribute__((__sfr__));


extern volatile uint16_t CNPDB __attribute__((__sfr__));
typedef struct tagCNPDBBITS {
  uint16_t CNPDB0:1;
  uint16_t CNPDB1:1;
  uint16_t CNPDB2:1;
  uint16_t CNPDB3:1;
  uint16_t CNPDB4:1;
  uint16_t CNPDB5:1;
  uint16_t CNPDB6:1;
  uint16_t CNPDB7:1;
  uint16_t CNPDB8:1;
  uint16_t CNPDB9:1;
  uint16_t CNPDB10:1;
  uint16_t CNPDB11:1;
  uint16_t CNPDB12:1;
  uint16_t CNPDB13:1;
  uint16_t CNPDB14:1;
  uint16_t CNPDB15:1;
} CNPDBBITS;
extern volatile CNPDBBITS CNPDBbits __attribute__((__sfr__));


extern volatile uint16_t ANSELB __attribute__((__sfr__));
typedef struct tagANSELBBITS {
  uint16_t ANSB0:1;
  uint16_t ANSB1:1;
  uint16_t ANSB2:1;
  uint16_t ANSB3:1;
  uint16_t :3;
  uint16_t ANSB7:1;
  uint16_t ANSB8:1;
  uint16_t ANSB9:1;
} ANSELBBITS;
extern volatile ANSELBBITS ANSELBbits __attribute__((__sfr__));


extern volatile uint16_t SR1B __attribute__((__sfr__));
typedef struct tagSR1BBITS {
  uint16_t :4;
  uint16_t SR1B4:1;
  uint16_t :2;
  uint16_t SR1B7:1;
  uint16_t SR1B8:1;
  uint16_t SR1B9:1;
} SR1BBITS;
extern volatile SR1BBITS SR1Bbits __attribute__((__sfr__));


extern volatile uint16_t SR0B __attribute__((__sfr__));
typedef struct tagSR0BBITS {
  uint16_t :4;
  uint16_t SR0B4:1;
  uint16_t :2;
  uint16_t SR0B7:1;
  uint16_t SR0B8:1;
  uint16_t SR0B9:1;
} SR0BBITS;
extern volatile SR0BBITS SR0Bbits __attribute__((__sfr__));


extern volatile uint16_t TRISC __attribute__((__sfr__));
typedef struct tagTRISCBITS {
  uint16_t TRISC0:1;
  uint16_t TRISC1:1;
  uint16_t TRISC2:1;
  uint16_t TRISC3:1;
  uint16_t TRISC4:1;
  uint16_t TRISC5:1;
  uint16_t TRISC6:1;
  uint16_t TRISC7:1;
  uint16_t TRISC8:1;
  uint16_t TRISC9:1;
  uint16_t TRISC10:1;
  uint16_t TRISC11:1;
  uint16_t TRISC12:1;
  uint16_t TRISC13:1;
  uint16_t :1;
  uint16_t TRISC15:1;
} TRISCBITS;
extern volatile TRISCBITS TRISCbits __attribute__((__sfr__));


extern volatile uint16_t PORTC __attribute__((__sfr__));
typedef struct tagPORTCBITS {
  uint16_t RC0:1;
  uint16_t RC1:1;
  uint16_t RC2:1;
  uint16_t RC3:1;
  uint16_t RC4:1;
  uint16_t RC5:1;
  uint16_t RC6:1;
  uint16_t RC7:1;
  uint16_t RC8:1;
  uint16_t RC9:1;
  uint16_t RC10:1;
  uint16_t RC11:1;
  uint16_t RC12:1;
  uint16_t RC13:1;
  uint16_t :1;
  uint16_t RC15:1;
} PORTCBITS;
extern volatile PORTCBITS PORTCbits __attribute__((__sfr__));


extern volatile uint16_t LATC __attribute__((__sfr__));
typedef struct tagLATCBITS {
  uint16_t LATC0:1;
  uint16_t LATC1:1;
  uint16_t LATC2:1;
  uint16_t LATC3:1;
  uint16_t LATC4:1;
  uint16_t LATC5:1;
  uint16_t LATC6:1;
  uint16_t LATC7:1;
  uint16_t LATC8:1;
  uint16_t LATC9:1;
  uint16_t LATC10:1;
  uint16_t LATC11:1;
  uint16_t LATC12:1;
  uint16_t LATC13:1;
  uint16_t :1;
  uint16_t LATC15:1;
} LATCBITS;
extern volatile LATCBITS LATCbits __attribute__((__sfr__));


extern volatile uint16_t ODCC __attribute__((__sfr__));
typedef struct tagODCCBITS {
  uint16_t ODCC0:1;
  uint16_t ODCC1:1;
  uint16_t ODCC2:1;
  uint16_t ODCC3:1;
  uint16_t ODCC4:1;
  uint16_t ODCC5:1;
  uint16_t ODCC6:1;
  uint16_t ODCC7:1;
  uint16_t ODCC8:1;
  uint16_t ODCC9:1;
  uint16_t ODCC10:1;
  uint16_t ODCC11:1;
  uint16_t ODCC12:1;
  uint16_t ODCC13:1;
  uint16_t :1;
  uint16_t ODCC15:1;
} ODCCBITS;
extern volatile ODCCBITS ODCCbits __attribute__((__sfr__));


extern volatile uint16_t CNENC __attribute__((__sfr__));
typedef struct tagCNENCBITS {
  uint16_t CNIEC0:1;
  uint16_t CNIEC1:1;
  uint16_t CNIEC2:1;
  uint16_t CNIEC3:1;
  uint16_t CNIEC4:1;
  uint16_t CNIEC5:1;
  uint16_t CNIEC6:1;
  uint16_t CNIEC7:1;
  uint16_t CNIEC8:1;
  uint16_t CNIEC9:1;
  uint16_t CNIEC10:1;
  uint16_t CNIEC11:1;
  uint16_t CNIEC12:1;
  uint16_t CNIEC13:1;
  uint16_t :1;
  uint16_t CNIEC15:1;
} CNENCBITS;
extern volatile CNENCBITS CNENCbits __attribute__((__sfr__));


extern volatile uint16_t CNPUC __attribute__((__sfr__));
typedef struct tagCNPUCBITS {
  uint16_t CNPUC0:1;
  uint16_t CNPUC1:1;
  uint16_t CNPUC2:1;
  uint16_t CNPUC3:1;
  uint16_t CNPUC4:1;
  uint16_t CNPUC5:1;
  uint16_t CNPUC6:1;
  uint16_t CNPUC7:1;
  uint16_t CNPUC8:1;
  uint16_t CNPUC9:1;
  uint16_t CNPUC10:1;
  uint16_t CNPUC11:1;
  uint16_t CNPUC12:1;
  uint16_t CNPUC13:1;
  uint16_t :1;
  uint16_t CNPUC15:1;
} CNPUCBITS;
extern volatile CNPUCBITS CNPUCbits __attribute__((__sfr__));


extern volatile uint16_t CNPDC __attribute__((__sfr__));
typedef struct tagCNPDCBITS {
  uint16_t CNPDC0:1;
  uint16_t CNPDC1:1;
  uint16_t CNPDC2:1;
  uint16_t CNPDC3:1;
  uint16_t CNPDC4:1;
  uint16_t CNPDC5:1;
  uint16_t CNPDC6:1;
  uint16_t CNPDC7:1;
  uint16_t CNPDC8:1;
  uint16_t CNPDC9:1;
  uint16_t CNPDC10:1;
  uint16_t CNPDC11:1;
  uint16_t CNPDC12:1;
  uint16_t CNPDC13:1;
  uint16_t :1;
  uint16_t CNPDC15:1;
} CNPDCBITS;
extern volatile CNPDCBITS CNPDCbits __attribute__((__sfr__));


extern volatile uint16_t ANSELC __attribute__((__sfr__));
typedef struct tagANSELCBITS {
  uint16_t ANSC0:1;
  uint16_t ANSC1:1;
  uint16_t ANSC2:1;
  uint16_t ANSC3:1;
  uint16_t ANSC4:1;
  uint16_t ANSC5:1;
  uint16_t ANSC6:1;
  uint16_t ANSC7:1;
  uint16_t ANSC8:1;
  uint16_t ANSC9:1;
  uint16_t ANSC10:1;
  uint16_t ANSC11:1;
  uint16_t ANSC12:1;
} ANSELCBITS;
extern volatile ANSELCBITS ANSELCbits __attribute__((__sfr__));


extern volatile uint16_t SR1C __attribute__((__sfr__));
typedef struct tagSR1CBITS {
  uint16_t :3;
  uint16_t SR1C3:1;
  uint16_t :2;
  uint16_t SR1C6:1;
  uint16_t SR1C7:1;
  uint16_t SR1C8:1;
  uint16_t SR1C9:1;
} SR1CBITS;
extern volatile SR1CBITS SR1Cbits __attribute__((__sfr__));


extern volatile uint16_t SR0C __attribute__((__sfr__));
typedef struct tagSR0CBITS {
  uint16_t :3;
  uint16_t SR0C3:1;
  uint16_t :2;
  uint16_t SR0C6:1;
  uint16_t SR0C7:1;
  uint16_t SR0C8:1;
  uint16_t SR0C9:1;
} SR0CBITS;
extern volatile SR0CBITS SR0Cbits __attribute__((__sfr__));


extern volatile uint16_t TRISD __attribute__((__sfr__));
typedef struct tagTRISDBITS {
  uint16_t :5;
  uint16_t TRISD5:1;
  uint16_t TRISD6:1;
  uint16_t :1;
  uint16_t TRISD8:1;
} TRISDBITS;
extern volatile TRISDBITS TRISDbits __attribute__((__sfr__));


extern volatile uint16_t PORTD __attribute__((__sfr__));
typedef struct tagPORTDBITS {
  uint16_t :5;
  uint16_t RD5:1;
  uint16_t RD6:1;
  uint16_t :1;
  uint16_t RD8:1;
} PORTDBITS;
extern volatile PORTDBITS PORTDbits __attribute__((__sfr__));


extern volatile uint16_t LATD __attribute__((__sfr__));
typedef struct tagLATDBITS {
  uint16_t :5;
  uint16_t LATD5:1;
  uint16_t LATD6:1;
  uint16_t :1;
  uint16_t LATD8:1;
} LATDBITS;
extern volatile LATDBITS LATDbits __attribute__((__sfr__));


extern volatile uint16_t ODCD __attribute__((__sfr__));
typedef struct tagODCDBITS {
  uint16_t :5;
  uint16_t ODCD5:1;
  uint16_t ODCD6:1;
  uint16_t :1;
  uint16_t ODCD8:1;
} ODCDBITS;
extern volatile ODCDBITS ODCDbits __attribute__((__sfr__));


extern volatile uint16_t CNEND __attribute__((__sfr__));
typedef struct tagCNENDBITS {
  uint16_t :5;
  uint16_t CNIED5:1;
  uint16_t CNIED6:1;
  uint16_t :1;
  uint16_t CNIED8:1;
} CNENDBITS;
extern volatile CNENDBITS CNENDbits __attribute__((__sfr__));


extern volatile uint16_t CNPUD __attribute__((__sfr__));
typedef struct tagCNPUDBITS {
  uint16_t :5;
  uint16_t CNPUD5:1;
  uint16_t CNPUD6:1;
  uint16_t :1;
  uint16_t CNPUD8:1;
} CNPUDBITS;
extern volatile CNPUDBITS CNPUDbits __attribute__((__sfr__));


extern volatile uint16_t CNPDD __attribute__((__sfr__));
typedef struct tagCNPDDBITS {
  uint16_t :5;
  uint16_t CNPDD5:1;
  uint16_t CNPDD6:1;
  uint16_t :1;
  uint16_t CNPDD8:1;
} CNPDDBITS;
extern volatile CNPDDBITS CNPDDbits __attribute__((__sfr__));


extern volatile uint16_t TRISE __attribute__((__sfr__));
typedef struct tagTRISEBITS {
  uint16_t :12;
  uint16_t TRISE12:1;
  uint16_t TRISE13:1;
  uint16_t TRISE14:1;
  uint16_t TRISE15:1;
} TRISEBITS;
extern volatile TRISEBITS TRISEbits __attribute__((__sfr__));


extern volatile uint16_t PORTE __attribute__((__sfr__));
typedef struct tagPORTEBITS {
  uint16_t :12;
  uint16_t RE12:1;
  uint16_t RE13:1;
  uint16_t RE14:1;
  uint16_t RE15:1;
} PORTEBITS;
extern volatile PORTEBITS PORTEbits __attribute__((__sfr__));


extern volatile uint16_t LATE __attribute__((__sfr__));
typedef struct tagLATEBITS {
  uint16_t :12;
  uint16_t LATE12:1;
  uint16_t LATE13:1;
  uint16_t LATE14:1;
  uint16_t LATE15:1;
} LATEBITS;
extern volatile LATEBITS LATEbits __attribute__((__sfr__));


extern volatile uint16_t ODCE __attribute__((__sfr__));
typedef struct tagODCEBITS {
  uint16_t :12;
  uint16_t ODCE12:1;
  uint16_t ODCE13:1;
  uint16_t ODCE14:1;
  uint16_t ODCE15:1;
} ODCEBITS;
extern volatile ODCEBITS ODCEbits __attribute__((__sfr__));


extern volatile uint16_t CNENE __attribute__((__sfr__));
typedef struct tagCNENEBITS {
  uint16_t :12;
  uint16_t CNIEE12:1;
  uint16_t CNIEE13:1;
  uint16_t CNIEE14:1;
  uint16_t CNIEE15:1;
} CNENEBITS;
extern volatile CNENEBITS CNENEbits __attribute__((__sfr__));


extern volatile uint16_t CNPUE __attribute__((__sfr__));
typedef struct tagCNPUEBITS {
  uint16_t :12;
  uint16_t CNPUE12:1;
  uint16_t CNPUE13:1;
  uint16_t CNPUE14:1;
  uint16_t CNPUE15:1;
} CNPUEBITS;
extern volatile CNPUEBITS CNPUEbits __attribute__((__sfr__));


extern volatile uint16_t CNPDE __attribute__((__sfr__));
typedef struct tagCNPDEBITS {
  uint16_t :12;
  uint16_t CNPDE12:1;
  uint16_t CNPDE13:1;
  uint16_t CNPDE14:1;
  uint16_t CNPDE15:1;
} CNPDEBITS;
extern volatile CNPDEBITS CNPDEbits __attribute__((__sfr__));


extern volatile uint16_t ANSELE __attribute__((__sfr__));
typedef struct tagANSELEBITS {
  uint16_t :12;
  uint16_t ANSE12:1;
  uint16_t ANSE13:1;
  uint16_t ANSE14:1;
  uint16_t ANSE15:1;
} ANSELEBITS;
extern volatile ANSELEBITS ANSELEbits __attribute__((__sfr__));


extern volatile uint16_t TRISF __attribute__((__sfr__));
typedef struct tagTRISFBITS {
  uint16_t TRISF0:1;
  uint16_t TRISF1:1;
} TRISFBITS;
extern volatile TRISFBITS TRISFbits __attribute__((__sfr__));


extern volatile uint16_t PORTF __attribute__((__sfr__));
typedef struct tagPORTFBITS {
  uint16_t RF0:1;
  uint16_t RF1:1;
} PORTFBITS;
extern volatile PORTFBITS PORTFbits __attribute__((__sfr__));


extern volatile uint16_t LATF __attribute__((__sfr__));
typedef struct tagLATFBITS {
  uint16_t LATF0:1;
  uint16_t LATF1:1;
} LATFBITS;
extern volatile LATFBITS LATFbits __attribute__((__sfr__));


extern volatile uint16_t ODCF __attribute__((__sfr__));
typedef struct tagODCFBITS {
  uint16_t ODCF0:1;
  uint16_t ODCF1:1;
} ODCFBITS;
extern volatile ODCFBITS ODCFbits __attribute__((__sfr__));


extern volatile uint16_t CNENF __attribute__((__sfr__));
typedef struct tagCNENFBITS {
  uint16_t CNIEF0:1;
  uint16_t CNIEF1:1;
} CNENFBITS;
extern volatile CNENFBITS CNENFbits __attribute__((__sfr__));


extern volatile uint16_t CNPUF __attribute__((__sfr__));
typedef struct tagCNPUFBITS {
  uint16_t CNPUF0:1;
  uint16_t CNPUF1:1;
} CNPUFBITS;
extern volatile CNPUFBITS CNPUFbits __attribute__((__sfr__));


extern volatile uint16_t CNPDF __attribute__((__sfr__));
typedef struct tagCNPDFBITS {
  uint16_t CNPDF0:1;
  uint16_t CNPDF1:1;
} CNPDFBITS;
extern volatile CNPDFBITS CNPDFbits __attribute__((__sfr__));


extern volatile uint16_t TRISG __attribute__((__sfr__));
typedef struct tagTRISGBITS {
  uint16_t :6;
  uint16_t TRISG6:1;
  uint16_t TRISG7:1;
  uint16_t TRISG8:1;
  uint16_t TRISG9:1;
} TRISGBITS;
extern volatile TRISGBITS TRISGbits __attribute__((__sfr__));


extern volatile uint16_t PORTG __attribute__((__sfr__));
typedef struct tagPORTGBITS {
  uint16_t :6;
  uint16_t RG6:1;
  uint16_t RG7:1;
  uint16_t RG8:1;
  uint16_t RG9:1;
} PORTGBITS;
extern volatile PORTGBITS PORTGbits __attribute__((__sfr__));


extern volatile uint16_t LATG __attribute__((__sfr__));
typedef struct tagLATGBITS {
  uint16_t :6;
  uint16_t LATG6:1;
  uint16_t LATG7:1;
  uint16_t LATG8:1;
  uint16_t LATG9:1;
} LATGBITS;
extern volatile LATGBITS LATGbits __attribute__((__sfr__));


extern volatile uint16_t ODCG __attribute__((__sfr__));
typedef struct tagODCGBITS {
  uint16_t :6;
  uint16_t ODCG6:1;
  uint16_t ODCG7:1;
  uint16_t ODCG8:1;
  uint16_t ODCG9:1;
} ODCGBITS;
extern volatile ODCGBITS ODCGbits __attribute__((__sfr__));


extern volatile uint16_t CNENG __attribute__((__sfr__));
typedef struct tagCNENGBITS {
  uint16_t :6;
  uint16_t CNIEG6:1;
  uint16_t CNIEG7:1;
  uint16_t CNIEG8:1;
  uint16_t CNIEG9:1;
} CNENGBITS;
extern volatile CNENGBITS CNENGbits __attribute__((__sfr__));


extern volatile uint16_t CNPUG __attribute__((__sfr__));
typedef struct tagCNPUGBITS {
  uint16_t :6;
  uint16_t CNPUG6:1;
  uint16_t CNPUG7:1;
  uint16_t CNPUG8:1;
  uint16_t CNPUG9:1;
} CNPUGBITS;
extern volatile CNPUGBITS CNPUGbits __attribute__((__sfr__));


extern volatile uint16_t CNPDG __attribute__((__sfr__));
typedef struct tagCNPDGBITS {
  uint16_t :6;
  uint16_t CNPDG6:1;
  uint16_t CNPDG7:1;
  uint16_t CNPDG8:1;
  uint16_t CNPDG9:1;
} CNPDGBITS;
extern volatile CNPDGBITS CNPDGbits __attribute__((__sfr__));


extern volatile uint16_t ANSELG __attribute__((__sfr__));
typedef struct tagANSELGBITS {
  uint16_t :6;
  uint16_t ANSG6:1;
  uint16_t ANSG7:1;
  uint16_t ANSG8:1;
  uint16_t ANSG9:1;
} ANSELGBITS;
extern volatile ANSELGBITS ANSELGbits __attribute__((__sfr__));


extern volatile uint16_t FEXL __attribute__((__sfr__));

extern volatile uint16_t FEXU __attribute__((__sfr__));
typedef struct tagFEXUBITS {
  uint16_t FEXU:8;
} FEXUBITS;
extern volatile FEXUBITS FEXUbits __attribute__((__sfr__));


extern volatile uint16_t FEX2L __attribute__((__sfr__));

extern volatile uint16_t FEX2U __attribute__((__sfr__));
typedef struct tagFEX2UBITS {
  uint16_t FEX2U:8;
} FEX2UBITS;
extern volatile FEX2UBITS FEX2Ubits __attribute__((__sfr__));


extern volatile uint16_t VISI __attribute__((__sfr__));

extern volatile uint16_t DPCL __attribute__((__sfr__));

extern volatile uint16_t DPCH __attribute__((__sfr__));
typedef struct tagDPCHBITS {
  uint16_t DPCH:8;
} DPCHBITS;
extern volatile DPCHBITS DPCHbits __attribute__((__sfr__));


extern volatile uint16_t APPO __attribute__((__sfr__));

extern volatile uint16_t APPI __attribute__((__sfr__));

extern volatile uint16_t APPS __attribute__((__sfr__));
typedef struct tagAPPSBITS {
  uint16_t APIFUL:1;
  uint16_t APIOV:1;
  uint16_t APOFUL:1;
  uint16_t APOOV:1;
  uint16_t STRFUL:1;
} APPSBITS;
extern volatile APPSBITS APPSbits __attribute__((__sfr__));


extern volatile uint16_t STROUTL __attribute__((__sfr__));

extern volatile uint16_t STROUTH __attribute__((__sfr__));

extern volatile uint16_t STROVCNT __attribute__((__sfr__));
# 29385 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\dsPIC33E\\h/p33EV128GM106.h" 3 4
extern __attribute__((space(prog))) __prog__ uint16_t _FSEC;
# 29465 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\dsPIC33E\\h/p33EV128GM106.h" 3 4
extern __attribute__((space(prog))) __prog__ uint16_t _FBSLIM;
# 29486 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\dsPIC33E\\h/p33EV128GM106.h" 3 4
extern __attribute__((space(prog))) __prog__ uint16_t _FOSCSEL;
# 29526 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\dsPIC33E\\h/p33EV128GM106.h" 3 4
extern __attribute__((space(prog))) __prog__ uint16_t _FOSC;
# 29583 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\dsPIC33E\\h/p33EV128GM106.h" 3 4
extern __attribute__((space(prog))) __prog__ uint16_t _FWDT;
# 29670 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\dsPIC33E\\h/p33EV128GM106.h" 3 4
extern __attribute__((space(prog))) __prog__ uint16_t _FPOR;
# 29693 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\dsPIC33E\\h/p33EV128GM106.h" 3 4
extern __attribute__((space(prog))) __prog__ uint16_t _FICD;
# 29720 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\dsPIC33E\\h/p33EV128GM106.h" 3 4
extern __attribute__((space(prog))) __prog__ uint16_t _FDMTINTVL;
# 29741 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\dsPIC33E\\h/p33EV128GM106.h" 3 4
extern __attribute__((space(prog))) __prog__ uint16_t _FDMTINTVH;
# 29762 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\dsPIC33E\\h/p33EV128GM106.h" 3 4
extern __attribute__((space(prog))) __prog__ uint16_t _FDMTCNTL;
# 29783 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\dsPIC33E\\h/p33EV128GM106.h" 3 4
extern __attribute__((space(prog))) __prog__ uint16_t _FDMTCNTH;
# 29804 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\dsPIC33E\\h/p33EV128GM106.h" 3 4
extern __attribute__((space(prog))) __prog__ uint16_t _FDMT;
# 29827 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\dsPIC33E\\h/p33EV128GM106.h" 3 4
extern __attribute__((space(prog))) __prog__ uint16_t _FDEVOPT;
# 29857 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\dsPIC33E\\h/p33EV128GM106.h" 3 4
extern __attribute__((space(prog))) __prog__ uint16_t _FALTREG;
# 88 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\generic\\h/xc.h" 2 3 4
# 33 "../FreeRTOSConfig.h" 2
# 60 "../../../Source/include/FreeRTOS.h" 2


# 1 "../../../Source/include/projdefs.h" 1
# 36 "../../../Source/include/projdefs.h"
typedef void (* TaskFunction_t)( void * );
# 63 "../../../Source/include/FreeRTOS.h" 2


# 1 "../../../Source/include/portable.h" 1
# 46 "../../../Source/include/portable.h"
# 1 "../../../Source/include/deprecated_definitions.h" 1
# 47 "../../../Source/include/portable.h" 2
# 56 "../../../Source/include/portable.h"
# 1 "../../../Source/include/../../Source/portable/MPLAB/PIC24_dsPIC/portmacro.h" 1
# 96 "../../../Source/include/../../Source/portable/MPLAB/PIC24_dsPIC/portmacro.h"
typedef uint16_t StackType_t;
typedef short BaseType_t;
typedef unsigned short UBaseType_t;


 typedef uint16_t TickType_t;
# 124 "../../../Source/include/../../Source/portable/MPLAB/PIC24_dsPIC/portmacro.h"
extern void vPortEnterCritical( void );
extern void vPortExitCritical( void );





extern void vPortYield( void );
# 57 "../../../Source/include/portable.h" 2
# 103 "../../../Source/include/portable.h"
# 1 "../../../Source/include/mpu_wrappers.h" 1
# 104 "../../../Source/include/portable.h" 2
# 131 "../../../Source/include/portable.h"
        StackType_t * pxPortInitialiseStack( StackType_t * pxTopOfStack,
                                             TaskFunction_t pxCode,
                                             void * pvParameters ) ;





typedef struct HeapRegion
{
    uint8_t * pucStartAddress;
    size_t xSizeInBytes;
} HeapRegion_t;


typedef struct xHeapStats
{
    size_t xAvailableHeapSpaceInBytes;
    size_t xSizeOfLargestFreeBlockInBytes;
    size_t xSizeOfSmallestFreeBlockInBytes;
    size_t xNumberOfFreeBlocks;
    size_t xMinimumEverFreeBytesRemaining;
    size_t xNumberOfSuccessfulAllocations;
    size_t xNumberOfSuccessfulFrees;
} HeapStats_t;
# 168 "../../../Source/include/portable.h"
void vPortDefineHeapRegions( const HeapRegion_t * const pxHeapRegions ) ;





void vPortGetHeapStats( HeapStats_t * pxHeapStats );




void * pvPortMalloc( size_t xSize ) ;
void * pvPortCalloc( size_t xNum,
                     size_t xSize ) ;
void vPortFree( void * pv ) ;
void vPortInitialiseBlocks( void ) ;
size_t xPortGetFreeHeapSize( void ) ;
size_t xPortGetMinimumEverFreeHeapSize( void ) ;
# 212 "../../../Source/include/portable.h"
BaseType_t xPortStartScheduler( void ) ;






void vPortEndScheduler( void ) ;
# 66 "../../../Source/include/FreeRTOS.h" 2
# 1201 "../../../Source/include/FreeRTOS.h"
struct xSTATIC_LIST_ITEM
{



    TickType_t xDummy2;
    void * pvDummy3[ 4 ];



};
typedef struct xSTATIC_LIST_ITEM StaticListItem_t;



    struct xSTATIC_MINI_LIST_ITEM
    {



        TickType_t xDummy2;
        void * pvDummy3[ 2 ];
    };
    typedef struct xSTATIC_MINI_LIST_ITEM StaticMiniListItem_t;





typedef struct xSTATIC_LIST
{



    UBaseType_t uxDummy2;
    void * pvDummy3;
    StaticMiniListItem_t xDummy4;



} StaticList_t;
# 1256 "../../../Source/include/FreeRTOS.h"
typedef struct xSTATIC_TCB
{
    void * pxDummy1;



    StaticListItem_t xDummy3[ 2 ];
    UBaseType_t uxDummy5;
    void * pxDummy6;
    uint8_t ucDummy7[ ( 4 ) ];

        void * pxDummy8;
# 1291 "../../../Source/include/FreeRTOS.h"
        uint32_t ulDummy18[ 1 ];
        uint8_t ucDummy19[ 1 ];
# 1304 "../../../Source/include/FreeRTOS.h"
} StaticTask_t;
# 1320 "../../../Source/include/FreeRTOS.h"
typedef struct xSTATIC_QUEUE
{
    void * pvDummy1[ 3 ];

    union
    {
        void * pvDummy2;
        UBaseType_t uxDummy2;
    } u;

    StaticList_t xDummy3[ 2 ];
    UBaseType_t uxDummy4[ 3 ];
    uint8_t ucDummy5[ 2 ];
# 1346 "../../../Source/include/FreeRTOS.h"
} StaticQueue_t;
typedef StaticQueue_t StaticSemaphore_t;
# 1363 "../../../Source/include/FreeRTOS.h"
typedef struct xSTATIC_EVENT_GROUP
{
    TickType_t xDummy1;
    StaticList_t xDummy2;
# 1375 "../../../Source/include/FreeRTOS.h"
} StaticEventGroup_t;
# 1391 "../../../Source/include/FreeRTOS.h"
typedef struct xSTATIC_TIMER
{
    void * pvDummy1;
    StaticListItem_t xDummy2;
    TickType_t xDummy3;
    void * pvDummy5;
    TaskFunction_t pvDummy6;



    uint8_t ucDummy8;
} StaticTimer_t;
# 1418 "../../../Source/include/FreeRTOS.h"
typedef struct xSTATIC_STREAM_BUFFER
{
    size_t uxDummy1[ 4 ];
    void * pvDummy2[ 3 ];
    uint8_t ucDummy3;






} StaticStreamBuffer_t;


typedef StaticStreamBuffer_t StaticMessageBuffer_t;
# 35 "../../Common/Minimal/blocktim.c" 2
# 1 "../../../Source/include/task.h" 1
# 37 "../../../Source/include/task.h"
# 1 "../../../Source/include/list.h" 1
# 143 "../../../Source/include/list.h"
struct xLIST;
struct xLIST_ITEM
{
   
    TickType_t xItemValue;
    struct xLIST_ITEM * pxNext;
    struct xLIST_ITEM * pxPrevious;
    void * pvOwner;
    struct xLIST * pvContainer;
   
};
typedef struct xLIST_ITEM ListItem_t;


    struct xMINI_LIST_ITEM
    {
       
        TickType_t xItemValue;
        struct xLIST_ITEM * pxNext;
        struct xLIST_ITEM * pxPrevious;
    };
    typedef struct xMINI_LIST_ITEM MiniListItem_t;







typedef struct xLIST
{
   
    volatile UBaseType_t uxNumberOfItems;
    ListItem_t * pxIndex;
    MiniListItem_t xListEnd;
   
} List_t;
# 433 "../../../Source/include/list.h"
void vListInitialise( List_t * const pxList ) ;
# 444 "../../../Source/include/list.h"
void vListInitialiseItem( ListItem_t * const pxItem ) ;
# 457 "../../../Source/include/list.h"
void vListInsert( List_t * const pxList,
                  ListItem_t * const pxNewListItem ) ;
# 479 "../../../Source/include/list.h"
void vListInsertEnd( List_t * const pxList,
                     ListItem_t * const pxNewListItem ) ;
# 495 "../../../Source/include/list.h"
UBaseType_t uxListRemove( ListItem_t * const pxItemToRemove ) ;
# 38 "../../../Source/include/task.h" 2
# 86 "../../../Source/include/task.h"
struct tskTaskControlBlock;
typedef struct tskTaskControlBlock * TaskHandle_t;





typedef BaseType_t (* TaskHookFunction_t)( void * );


typedef enum
{
    eRunning = 0,
    eReady,
    eBlocked,
    eSuspended,
    eDeleted,
    eInvalid
} eTaskState;


typedef enum
{
    eNoAction = 0,
    eSetBits,
    eIncrement,
    eSetValueWithOverwrite,
    eSetValueWithoutOverwrite
} eNotifyAction;




typedef struct xTIME_OUT
{
    BaseType_t xOverflowCount;
    TickType_t xTimeOnEntering;
} TimeOut_t;




typedef struct xMEMORY_REGION
{
    void * pvBaseAddress;
    uint32_t ulLengthInBytes;
    uint32_t ulParameters;
} MemoryRegion_t;




typedef struct xTASK_PARAMETERS
{
    TaskFunction_t pvTaskCode;
    const char * pcName;
    uint16_t usStackDepth;
    void * pvParameters;
    UBaseType_t uxPriority;
    StackType_t * puxStackBuffer;
    MemoryRegion_t xRegions[ 1 ];



} TaskParameters_t;



typedef struct xTASK_STATUS
{
    TaskHandle_t xHandle;
    const char * pcTaskName;
    UBaseType_t xTaskNumber;
    eTaskState eCurrentState;
    UBaseType_t uxCurrentPriority;
    UBaseType_t uxBasePriority;
    uint32_t ulRunTimeCounter;
    StackType_t * pxStackBase;




    uint16_t usStackHighWaterMark;
} TaskStatus_t;


typedef enum
{
    eAbortSleep = 0,
    eStandardSleep,

        eNoTasksWaitingTimeout

} eSleepModeStatus;
# 357 "../../../Source/include/task.h"
    BaseType_t xTaskCreate( TaskFunction_t pxTaskCode,
                            const char * const pcName,
                            const uint16_t usStackDepth,
                            void * const pvParameters,
                            UBaseType_t uxPriority,
                            TaskHandle_t * const pxCreatedTask ) ;
# 698 "../../../Source/include/task.h"
void vTaskAllocateMPURegions( TaskHandle_t xTask,
                              const MemoryRegion_t * const pxRegions ) ;
# 742 "../../../Source/include/task.h"
void vTaskDelete( TaskHandle_t xTaskToDelete ) ;
# 796 "../../../Source/include/task.h"
void vTaskDelay( const TickType_t xTicksToDelay ) ;
# 863 "../../../Source/include/task.h"
BaseType_t xTaskDelayUntil( TickType_t * const pxPreviousWakeTime,
                            const TickType_t xTimeIncrement ) ;
# 906 "../../../Source/include/task.h"
BaseType_t xTaskAbortDelay( TaskHandle_t xTask ) ;
# 955 "../../../Source/include/task.h"
UBaseType_t uxTaskPriorityGet( const TaskHandle_t xTask ) ;
# 965 "../../../Source/include/task.h"
UBaseType_t uxTaskPriorityGetFromISR( const TaskHandle_t xTask ) ;
# 985 "../../../Source/include/task.h"
eTaskState eTaskGetState( TaskHandle_t xTask ) ;
# 1043 "../../../Source/include/task.h"
void vTaskGetInfo( TaskHandle_t xTask,
                   TaskStatus_t * pxTaskStatus,
                   BaseType_t xGetFreeStackSpace,
                   eTaskState eState ) ;
# 1090 "../../../Source/include/task.h"
void vTaskPrioritySet( TaskHandle_t xTask,
                       UBaseType_t uxNewPriority ) ;
# 1144 "../../../Source/include/task.h"
void vTaskSuspend( TaskHandle_t xTaskToSuspend ) ;
# 1195 "../../../Source/include/task.h"
void vTaskResume( TaskHandle_t xTaskToResume ) ;
# 1226 "../../../Source/include/task.h"
BaseType_t xTaskResumeFromISR( TaskHandle_t xTaskToResume ) ;
# 1261 "../../../Source/include/task.h"
void vTaskStartScheduler( void ) ;
# 1319 "../../../Source/include/task.h"
void vTaskEndScheduler( void ) ;
# 1372 "../../../Source/include/task.h"
void vTaskSuspendAll( void ) ;
# 1428 "../../../Source/include/task.h"
BaseType_t xTaskResumeAll( void ) ;
# 1445 "../../../Source/include/task.h"
TickType_t xTaskGetTickCount( void ) ;
# 1463 "../../../Source/include/task.h"
TickType_t xTaskGetTickCountFromISR( void ) ;
# 1479 "../../../Source/include/task.h"
UBaseType_t uxTaskGetNumberOfTasks( void ) ;
# 1494 "../../../Source/include/task.h"
char * pcTaskGetName( TaskHandle_t xTaskToQuery ) ;
# 1512 "../../../Source/include/task.h"
TaskHandle_t xTaskGetHandle( const char * pcNameToQuery ) ;
# 1541 "../../../Source/include/task.h"
UBaseType_t uxTaskGetStackHighWaterMark( TaskHandle_t xTask ) ;
# 1570 "../../../Source/include/task.h"
uint16_t uxTaskGetStackHighWaterMark2( TaskHandle_t xTask ) ;
# 1701 "../../../Source/include/task.h"
BaseType_t xTaskCallApplicationTaskHook( TaskHandle_t xTask,
                                         void * pvParameter ) ;
# 1711 "../../../Source/include/task.h"
TaskHandle_t xTaskGetIdleTaskHandle( void ) ;
# 1810 "../../../Source/include/task.h"
UBaseType_t uxTaskGetSystemState( TaskStatus_t * const pxTaskStatusArray,
                                  const UBaseType_t uxArraySize,
                                  uint32_t * const pulTotalRunTime ) ;
# 1863 "../../../Source/include/task.h"
void vTaskList( char * pcWriteBuffer ) ;
# 1919 "../../../Source/include/task.h"
void vTaskGetRunTimeStats( char * pcWriteBuffer ) ;
# 1959 "../../../Source/include/task.h"
uint32_t ulTaskGetIdleRunTimeCounter( void ) ;
uint32_t ulTaskGetIdleRunTimePercent( void ) ;
# 2070 "../../../Source/include/task.h"
BaseType_t xTaskGenericNotify( TaskHandle_t xTaskToNotify,
                               UBaseType_t uxIndexToNotify,
                               uint32_t ulValue,
                               eNotifyAction eAction,
                               uint32_t * pulPreviousNotificationValue ) ;
# 2222 "../../../Source/include/task.h"
BaseType_t xTaskGenericNotifyFromISR( TaskHandle_t xTaskToNotify,
                                      UBaseType_t uxIndexToNotify,
                                      uint32_t ulValue,
                                      eNotifyAction eAction,
                                      uint32_t * pulPreviousNotificationValue,
                                      BaseType_t * pxHigherPriorityTaskWoken ) ;
# 2366 "../../../Source/include/task.h"
BaseType_t xTaskGenericNotifyWait( UBaseType_t uxIndexToWaitOn,
                                   uint32_t ulBitsToClearOnEntry,
                                   uint32_t ulBitsToClearOnExit,
                                   uint32_t * pulNotificationValue,
                                   TickType_t xTicksToWait ) ;
# 2532 "../../../Source/include/task.h"
void vTaskGenericNotifyGiveFromISR( TaskHandle_t xTaskToNotify,
                                    UBaseType_t uxIndexToNotify,
                                    BaseType_t * pxHigherPriorityTaskWoken ) ;
# 2638 "../../../Source/include/task.h"
uint32_t ulTaskGenericNotifyTake( UBaseType_t uxIndexToWaitOn,
                                  BaseType_t xClearCountOnExit,
                                  TickType_t xTicksToWait ) ;
# 2703 "../../../Source/include/task.h"
BaseType_t xTaskGenericNotifyStateClear( TaskHandle_t xTask,
                                         UBaseType_t uxIndexToClear ) ;
# 2768 "../../../Source/include/task.h"
uint32_t ulTaskGenericNotifyValueClear( TaskHandle_t xTask,
                                        UBaseType_t uxIndexToClear,
                                        uint32_t ulBitsToClear ) ;
# 2790 "../../../Source/include/task.h"
void vTaskSetTimeOutState( TimeOut_t * const pxTimeOut ) ;
# 2875 "../../../Source/include/task.h"
BaseType_t xTaskCheckForTimeOut( TimeOut_t * const pxTimeOut,
                                 TickType_t * const pxTicksToWait ) ;
# 2904 "../../../Source/include/task.h"
BaseType_t xTaskCatchUpTicks( TickType_t xTicksToCatchUp ) ;
# 2926 "../../../Source/include/task.h"
BaseType_t xTaskIncrementTick( void ) ;
# 2959 "../../../Source/include/task.h"
void vTaskPlaceOnEventList( List_t * const pxEventList,
                            const TickType_t xTicksToWait ) ;
void vTaskPlaceOnUnorderedEventList( List_t * pxEventList,
                                     const TickType_t xItemValue,
                                     const TickType_t xTicksToWait ) ;
# 2976 "../../../Source/include/task.h"
void vTaskPlaceOnEventListRestricted( List_t * const pxEventList,
                                      TickType_t xTicksToWait,
                                      const BaseType_t xWaitIndefinitely ) ;
# 3004 "../../../Source/include/task.h"
BaseType_t xTaskRemoveFromEventList( const List_t * const pxEventList ) ;
void vTaskRemoveFromUnorderedEventList( ListItem_t * pxEventListItem,
                                        const TickType_t xItemValue ) ;
# 3016 "../../../Source/include/task.h"
 void vTaskSwitchContext( void ) ;





TickType_t uxTaskResetEventItemValue( void ) ;




TaskHandle_t xTaskGetCurrentTaskHandle( void ) ;





void vTaskMissedYield( void ) ;





BaseType_t xTaskGetSchedulerState( void ) ;





BaseType_t xTaskPriorityInherit( TaskHandle_t const pxMutexHolder ) ;





BaseType_t xTaskPriorityDisinherit( TaskHandle_t const pxMutexHolder ) ;
# 3061 "../../../Source/include/task.h"
void vTaskPriorityDisinheritAfterTimeout( TaskHandle_t const pxMutexHolder,
                                          UBaseType_t uxHighestPriorityWaitingTask ) ;




UBaseType_t uxTaskGetTaskNumber( TaskHandle_t xTask ) ;





void vTaskSetTaskNumber( TaskHandle_t xTask,
                         const UBaseType_t uxHandle ) ;
# 3084 "../../../Source/include/task.h"
void vTaskStepTick( TickType_t xTicksToJump ) ;
# 3100 "../../../Source/include/task.h"
eSleepModeStatus eTaskConfirmSleepModeStatus( void ) ;





TaskHandle_t pvTaskIncrementMutexHeldCount( void ) ;





void vTaskInternalSetTimeOutState( TimeOut_t * const pxTimeOut ) ;
# 36 "../../Common/Minimal/blocktim.c" 2
# 1 "../../../Source/include/queue.h" 1
# 43 "../../../Source/include/queue.h"
# 1 "../../../Source/include/task.h" 1
# 44 "../../../Source/include/queue.h" 2






struct QueueDefinition;
typedef struct QueueDefinition * QueueHandle_t;






typedef struct QueueDefinition * QueueSetHandle_t;






typedef struct QueueDefinition * QueueSetMemberHandle_t;
# 657 "../../../Source/include/queue.h"
BaseType_t xQueueGenericSend( QueueHandle_t xQueue,
                              const void * const pvItemToQueue,
                              TickType_t xTicksToWait,
                              const BaseType_t xCopyPosition ) ;
# 755 "../../../Source/include/queue.h"
BaseType_t xQueuePeek( QueueHandle_t xQueue,
                       void * const pvBuffer,
                       TickType_t xTicksToWait ) ;
# 791 "../../../Source/include/queue.h"
BaseType_t xQueuePeekFromISR( QueueHandle_t xQueue,
                              void * const pvBuffer ) ;
# 884 "../../../Source/include/queue.h"
BaseType_t xQueueReceive( QueueHandle_t xQueue,
                          void * const pvBuffer,
                          TickType_t xTicksToWait ) ;
# 903 "../../../Source/include/queue.h"
UBaseType_t uxQueueMessagesWaiting( const QueueHandle_t xQueue ) ;
# 922 "../../../Source/include/queue.h"
UBaseType_t uxQueueSpacesAvailable( const QueueHandle_t xQueue ) ;
# 938 "../../../Source/include/queue.h"
void vQueueDelete( QueueHandle_t xQueue ) ;
# 1323 "../../../Source/include/queue.h"
BaseType_t xQueueGenericSendFromISR( QueueHandle_t xQueue,
                                     const void * const pvItemToQueue,
                                     BaseType_t * const pxHigherPriorityTaskWoken,
                                     const BaseType_t xCopyPosition ) ;
BaseType_t xQueueGiveFromISR( QueueHandle_t xQueue,
                              BaseType_t * const pxHigherPriorityTaskWoken ) ;
# 1417 "../../../Source/include/queue.h"
BaseType_t xQueueReceiveFromISR( QueueHandle_t xQueue,
                                 void * const pvBuffer,
                                 BaseType_t * const pxHigherPriorityTaskWoken ) ;





BaseType_t xQueueIsQueueEmptyFromISR( const QueueHandle_t xQueue ) ;
BaseType_t xQueueIsQueueFullFromISR( const QueueHandle_t xQueue ) ;
UBaseType_t uxQueueMessagesWaitingFromISR( const QueueHandle_t xQueue ) ;
# 1438 "../../../Source/include/queue.h"
BaseType_t xQueueCRSendFromISR( QueueHandle_t xQueue,
                                const void * pvItemToQueue,
                                BaseType_t xCoRoutinePreviouslyWoken );
BaseType_t xQueueCRReceiveFromISR( QueueHandle_t xQueue,
                                   void * pvBuffer,
                                   BaseType_t * pxTaskWoken );
BaseType_t xQueueCRSend( QueueHandle_t xQueue,
                         const void * pvItemToQueue,
                         TickType_t xTicksToWait );
BaseType_t xQueueCRReceive( QueueHandle_t xQueue,
                            void * pvBuffer,
                            TickType_t xTicksToWait );






QueueHandle_t xQueueCreateMutex( const uint8_t ucQueueType ) ;
QueueHandle_t xQueueCreateMutexStatic( const uint8_t ucQueueType,
                                       StaticQueue_t * pxStaticQueue ) ;
QueueHandle_t xQueueCreateCountingSemaphore( const UBaseType_t uxMaxCount,
                                             const UBaseType_t uxInitialCount ) ;
QueueHandle_t xQueueCreateCountingSemaphoreStatic( const UBaseType_t uxMaxCount,
                                                   const UBaseType_t uxInitialCount,
                                                   StaticQueue_t * pxStaticQueue ) ;
BaseType_t xQueueSemaphoreTake( QueueHandle_t xQueue,
                                TickType_t xTicksToWait ) ;
TaskHandle_t xQueueGetMutexHolder( QueueHandle_t xSemaphore ) ;
TaskHandle_t xQueueGetMutexHolderFromISR( QueueHandle_t xSemaphore ) ;





BaseType_t xQueueTakeMutexRecursive( QueueHandle_t xMutex,
                                     TickType_t xTicksToWait ) ;
BaseType_t xQueueGiveMutexRecursive( QueueHandle_t xMutex ) ;
# 1549 "../../../Source/include/queue.h"
    QueueHandle_t xQueueGenericCreate( const UBaseType_t uxQueueLength,
                                       const UBaseType_t uxItemSize,
                                       const uint8_t ucQueueType ) ;
# 1615 "../../../Source/include/queue.h"
QueueSetHandle_t xQueueCreateSet( const UBaseType_t uxEventQueueLength ) ;
# 1639 "../../../Source/include/queue.h"
BaseType_t xQueueAddToSet( QueueSetMemberHandle_t xQueueOrSemaphore,
                           QueueSetHandle_t xQueueSet ) ;
# 1659 "../../../Source/include/queue.h"
BaseType_t xQueueRemoveFromSet( QueueSetMemberHandle_t xQueueOrSemaphore,
                                QueueSetHandle_t xQueueSet ) ;
# 1696 "../../../Source/include/queue.h"
QueueSetMemberHandle_t xQueueSelectFromSet( QueueSetHandle_t xQueueSet,
                                            const TickType_t xTicksToWait ) ;




QueueSetMemberHandle_t xQueueSelectFromSetFromISR( QueueSetHandle_t xQueueSet ) ;


void vQueueWaitForMessageRestricted( QueueHandle_t xQueue,
                                     TickType_t xTicksToWait,
                                     const BaseType_t xWaitIndefinitely ) ;
BaseType_t xQueueGenericReset( QueueHandle_t xQueue,
                               BaseType_t xNewQueue ) ;
void vQueueSetQueueNumber( QueueHandle_t xQueue,
                           UBaseType_t uxQueueNumber ) ;
UBaseType_t uxQueueGetQueueNumber( QueueHandle_t xQueue ) ;
uint8_t ucQueueGetQueueType( QueueHandle_t xQueue ) ;
# 37 "../../Common/Minimal/blocktim.c" 2


# 1 "../../Common/include/blocktim.h" 1
# 30 "../../Common/include/blocktim.h"
void vCreateBlockTimeTasks( void );
BaseType_t xAreBlockTimeTestTasksStillRunning( void );
# 40 "../../Common/Minimal/blocktim.c" 2
# 74 "../../Common/Minimal/blocktim.c"
static void vPrimaryBlockTimeTestTask( void * pvParameters );
static void vSecondaryBlockTimeTestTask( void * pvParameters );




static void prvBasicDelayTests( void );




static QueueHandle_t xTestQueue;



static TaskHandle_t xSecondary;


static volatile BaseType_t xPrimaryCycles = 0, xSecondaryCycles = 0;
static volatile BaseType_t xErrorOccurred = ( ( BaseType_t ) 0 );



static volatile UBaseType_t xRunIndicator;



void vCreateBlockTimeTasks( void )
{

    xTestQueue = xQueueGenericCreate( ( ( 5 ) ), ( sizeof( BaseType_t ) ), ( ( ( uint8_t ) 0U ) ) );

    if( xTestQueue != ((void*)0) )
    {






        ;


        xTaskCreate( vPrimaryBlockTimeTestTask, "BTest1", ( 105 ), ((void*)0), ( ( 4 ) - 3 ), ((void*)0) );
        xTaskCreate( vSecondaryBlockTimeTestTask, "BTest2", ( 105 ), ((void*)0), ( ( 4 ) - 4 ), &xSecondary );
    }
}


static void vPrimaryBlockTimeTestTask( void * pvParameters )
{
    BaseType_t xItem, xData;
    TickType_t xTimeWhenBlocking;
    TickType_t xTimeToBlock, xBlockedTime;

    ( void ) pvParameters;

    for( ; ; )
    {




        prvBasicDelayTests();





        for( xItem = 0; xItem < ( 5 ); xItem++ )
        {


            xTimeToBlock = ( TickType_t ) ( ( 10 ) << xItem );

            xTimeWhenBlocking = xTaskGetTickCount();



            if( xQueueReceive( xTestQueue, &xData, xTimeToBlock ) != ( ( BaseType_t ) 0 ) )
            {
                xErrorOccurred = ( ( BaseType_t ) 1 );
            }


            xBlockedTime = xTaskGetTickCount() - xTimeWhenBlocking;

            if( xBlockedTime < xTimeToBlock )
            {

                xErrorOccurred = ( ( BaseType_t ) 1 );
            }

            if( xBlockedTime > ( xTimeToBlock + ( 15 ) ) )
            {



                xErrorOccurred = ( ( BaseType_t ) 1 );
            }
        }







        for( xItem = 0; xItem < ( 5 ); xItem++ )
        {
            if( xQueueGenericSend( ( xTestQueue ), ( &xItem ), ( ( ( TickType_t ) 0 ) ), ( ( BaseType_t ) 0 ) ) != ( ( ( BaseType_t ) 1 ) ) )
            {
                xErrorOccurred = ( ( BaseType_t ) 1 );
            }




        }

        for( xItem = 0; xItem < ( 5 ); xItem++ )
        {


            xTimeToBlock = ( TickType_t ) ( ( 10 ) << xItem );

            xTimeWhenBlocking = xTaskGetTickCount();



            if( xQueueGenericSend( ( xTestQueue ), ( &xItem ), ( xTimeToBlock ), ( ( BaseType_t ) 0 ) ) != ( ( BaseType_t ) 0 ) )
            {
                xErrorOccurred = ( ( BaseType_t ) 1 );
            }


            xBlockedTime = xTaskGetTickCount() - xTimeWhenBlocking;

            if( xBlockedTime < xTimeToBlock )
            {

                xErrorOccurred = ( ( BaseType_t ) 1 );
            }

            if( xBlockedTime > ( xTimeToBlock + ( 15 ) ) )
            {



                xErrorOccurred = ( ( BaseType_t ) 1 );
            }
        }
# 239 "../../Common/Minimal/blocktim.c"
        xRunIndicator = 0;
        vTaskResume( xSecondary );


        while( xRunIndicator != ( ( UBaseType_t ) 0x55 ) )
        {

            vTaskDelay( ( ( TickType_t) ( ( ( TickType_t) ( ( TickType_t ) 20 ) )) * ((( TickType_t) ( ( TickType_t ) 1000 ) ) / ( TickType_t) 1000 )) );
        }


        vTaskDelay( ( ( TickType_t) ( ( ( TickType_t) ( ( TickType_t ) 20 ) )) * ((( TickType_t) ( ( TickType_t ) 1000 ) ) / ( TickType_t) 1000 )) );
        xRunIndicator = 0;

        for( xItem = 0; xItem < ( 5 ); xItem++ )
        {


            if( xQueueReceive( xTestQueue, &xData, ( ( TickType_t ) 0 ) ) != ( ( ( BaseType_t ) 1 ) ) )
            {
                xErrorOccurred = ( ( BaseType_t ) 1 );
            }




            if( xQueueGenericSend( ( xTestQueue ), ( &xItem ), ( ( ( TickType_t ) 0 ) ), ( ( BaseType_t ) 0 ) ) != ( ( ( BaseType_t ) 1 ) ) )
            {
                xErrorOccurred = ( ( BaseType_t ) 1 );
            }

            if( xRunIndicator == ( ( UBaseType_t ) 0x55 ) )
            {

                xErrorOccurred = ( ( BaseType_t ) 1 );
            }



            vTaskPrioritySet( xSecondary, ( ( 4 ) - 3 ) + 2 );



            if( xRunIndicator == ( ( UBaseType_t ) 0x55 ) )
            {


                xErrorOccurred = ( ( BaseType_t ) 1 );
            }


            vTaskPrioritySet( xSecondary, ( ( 4 ) - 4 ) );
        }



        while( xRunIndicator != ( ( UBaseType_t ) 0x55 ) )
        {
            vTaskDelay( ( ( TickType_t) ( ( ( TickType_t) ( ( TickType_t ) 20 ) )) * ((( TickType_t) ( ( TickType_t ) 1000 ) ) / ( TickType_t) 1000 )) );
        }

        vTaskDelay( ( ( TickType_t) ( ( ( TickType_t) ( ( TickType_t ) 20 ) )) * ((( TickType_t) ( ( TickType_t ) 1000 ) ) / ( TickType_t) 1000 )) );
        xRunIndicator = 0;
# 310 "../../Common/Minimal/blocktim.c"
        for( xItem = 0; xItem < ( 5 ); xItem++ )
        {
            if( xQueueReceive( xTestQueue, &xData, ( ( TickType_t ) 0 ) ) != ( ( ( BaseType_t ) 1 ) ) )
            {
                xErrorOccurred = ( ( BaseType_t ) 1 );
            }
        }



        vTaskResume( xSecondary );


        while( xRunIndicator != ( ( UBaseType_t ) 0x55 ) )
        {
            vTaskDelay( ( ( TickType_t) ( ( ( TickType_t) ( ( TickType_t ) 20 ) )) * ((( TickType_t) ( ( TickType_t ) 1000 ) ) / ( TickType_t) 1000 )) );
        }

        vTaskDelay( ( ( TickType_t) ( ( ( TickType_t) ( ( TickType_t ) 20 ) )) * ((( TickType_t) ( ( TickType_t ) 1000 ) ) / ( TickType_t) 1000 )) );
        xRunIndicator = 0;

        for( xItem = 0; xItem < ( 5 ); xItem++ )
        {


            if( xQueueGenericSend( ( xTestQueue ), ( &xItem ), ( ( ( TickType_t ) 0 ) ), ( ( BaseType_t ) 0 ) ) != ( ( ( BaseType_t ) 1 ) ) )
            {
                xErrorOccurred = ( ( BaseType_t ) 1 );
            }




            if( xQueueReceive( xTestQueue, &xData, ( ( TickType_t ) 0 ) ) != ( ( ( BaseType_t ) 1 ) ) )
            {
                xErrorOccurred = ( ( BaseType_t ) 1 );
            }

            if( xRunIndicator == ( ( UBaseType_t ) 0x55 ) )
            {

                xErrorOccurred = ( ( BaseType_t ) 1 );
            }



            vTaskPrioritySet( xSecondary, ( ( 4 ) - 3 ) + 2 );



            if( xRunIndicator == ( ( UBaseType_t ) 0x55 ) )
            {


                xErrorOccurred = ( ( BaseType_t ) 1 );
            }

            vTaskPrioritySet( xSecondary, ( ( 4 ) - 4 ) );
        }



        while( xRunIndicator != ( ( UBaseType_t ) 0x55 ) )
        {
            vTaskDelay( ( ( TickType_t) ( ( ( TickType_t) ( ( TickType_t ) 20 ) )) * ((( TickType_t) ( ( TickType_t ) 1000 ) ) / ( TickType_t) 1000 )) );
        }

        vTaskDelay( ( ( TickType_t) ( ( ( TickType_t) ( ( TickType_t ) 20 ) )) * ((( TickType_t) ( ( TickType_t ) 1000 ) ) / ( TickType_t) 1000 )) );

        xPrimaryCycles++;
    }
}


static void vSecondaryBlockTimeTestTask( void * pvParameters )
{
    TickType_t xTimeWhenBlocking, xBlockedTime;
    BaseType_t xData;

    ( void ) pvParameters;

    for( ; ; )
    {




        vTaskSuspend( ((void*)0) );







        xTimeWhenBlocking = xTaskGetTickCount();



        xData = 0;
        xRunIndicator = ( ( UBaseType_t ) 0x55 );

        if( xQueueGenericSend( ( xTestQueue ), ( &xData ), ( ( 175 ) ), ( ( BaseType_t ) 0 ) ) != ( ( BaseType_t ) 0 ) )
        {
            xErrorOccurred = ( ( BaseType_t ) 1 );
        }


        xBlockedTime = xTaskGetTickCount() - xTimeWhenBlocking;


        if( xBlockedTime < ( 175 ) )
        {
            xErrorOccurred = ( ( BaseType_t ) 1 );
        }




        if( xBlockedTime > ( ( 175 ) + ( 15 ) ) )
        {
            xErrorOccurred = ( ( BaseType_t ) 1 );
        }


        xRunIndicator = ( ( UBaseType_t ) 0x55 );
        vTaskSuspend( ((void*)0) );





        xTimeWhenBlocking = xTaskGetTickCount();



        xRunIndicator = ( ( UBaseType_t ) 0x55 );

        if( xQueueReceive( xTestQueue, &xData, ( 175 ) ) != ( ( BaseType_t ) 0 ) )
        {
            xErrorOccurred = ( ( BaseType_t ) 1 );
        }

        xBlockedTime = xTaskGetTickCount() - xTimeWhenBlocking;


        if( xBlockedTime < ( 175 ) )
        {
            xErrorOccurred = ( ( BaseType_t ) 1 );
        }




        if( xBlockedTime > ( ( 175 ) + ( 15 ) ) )
        {
            xErrorOccurred = ( ( BaseType_t ) 1 );
        }

        xRunIndicator = ( ( UBaseType_t ) 0x55 );

        xSecondaryCycles++;
    }
}


static void prvBasicDelayTests( void )
{
    TickType_t xPreTime, xPostTime, x, xLastUnblockTime, xExpectedUnblockTime;
    const TickType_t xPeriod = 75, xCycles = 5, xAllowableMargin = ( ( 15 ) >> 1 ), xHalfPeriod = xPeriod / ( TickType_t ) 2;
    BaseType_t xDidBlock;



    vTaskPrioritySet( ((void*)0), ( ( 4 ) - 1 ) - 1 );



    xPreTime = xTaskGetTickCount();
    vTaskDelay( ( 175 ) );
    xPostTime = xTaskGetTickCount();



    if( ( xPostTime - xPreTime ) > ( ( 175 ) + xAllowableMargin ) )
    {
        xErrorOccurred = ( ( BaseType_t ) 1 );
    }


    xPostTime = xTaskGetTickCount();
    xLastUnblockTime = xPostTime;

    for( x = 0; x < xCycles; x++ )
    {


        xExpectedUnblockTime = xPostTime + ( x * xPeriod );

        do { ( void ) xTaskDelayUntil( ( &xLastUnblockTime ), ( xPeriod ) ); } while( 0 );

        if( ( xTaskGetTickCount() - xExpectedUnblockTime ) > ( ( 175 ) + xAllowableMargin ) )
        {
            xErrorOccurred = ( ( BaseType_t ) 1 );
        }

        xPrimaryCycles++;
    }



    xDidBlock = xTaskDelayUntil( &xLastUnblockTime, xPeriod );

    if( xDidBlock != ( ( BaseType_t ) 1 ) )
    {
        xErrorOccurred = ( ( BaseType_t ) 1 );
    }



    vTaskDelay( xHalfPeriod );
    xDidBlock = xTaskDelayUntil( &xLastUnblockTime, xPeriod );

    if( xDidBlock != ( ( BaseType_t ) 1 ) )
    {
        xErrorOccurred = ( ( BaseType_t ) 1 );
    }



    vTaskDelay( xPeriod );
    xDidBlock = xTaskDelayUntil( &xLastUnblockTime, xPeriod );

    if( xDidBlock != ( ( BaseType_t ) 0 ) )
    {
        xErrorOccurred = ( ( BaseType_t ) 1 );
    }


    xDidBlock = xTaskDelayUntil( &xLastUnblockTime, xPeriod );

    if( xDidBlock != ( ( BaseType_t ) 1 ) )
    {
        xErrorOccurred = ( ( BaseType_t ) 1 );
    }



    vTaskDelay( xPeriod + xAllowableMargin );
    xDidBlock = xTaskDelayUntil( &xLastUnblockTime, xPeriod );

    if( xDidBlock != ( ( BaseType_t ) 0 ) )
    {
        xErrorOccurred = ( ( BaseType_t ) 1 );
    }


    vTaskPrioritySet( ((void*)0), ( ( 4 ) - 3 ) );
}


BaseType_t xAreBlockTimeTestTasksStillRunning( void )
{
    static BaseType_t xLastPrimaryCycleCount = 0, xLastSecondaryCycleCount = 0;
    BaseType_t xReturn = ( ( ( BaseType_t ) 1 ) );



    if( xPrimaryCycles == xLastPrimaryCycleCount )
    {
        xReturn = ( ( ( BaseType_t ) 0 ) );
    }

    if( xSecondaryCycles == xLastSecondaryCycleCount )
    {
        xReturn = ( ( ( BaseType_t ) 0 ) );
    }

    if( xErrorOccurred == ( ( BaseType_t ) 1 ) )
    {
        xReturn = ( ( ( BaseType_t ) 0 ) );
    }

    xLastSecondaryCycleCount = xSecondaryCycles;
    xLastPrimaryCycleCount = xPrimaryCycles;

    return xReturn;
}
