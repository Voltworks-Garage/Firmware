# 1 "../serial/serial.c"
# 1 "C:\\Users\\zachl\\Downloads\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo\\Demo\\dspic33e-freertos-demo\\dspic33e-freertos-demo.X"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "../serial/serial.c"
# 35 "../serial/serial.c"
# 1 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/stdlib.h" 1 3 4







# 1 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/features.h" 1 3 4
# 9 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/stdlib.h" 2 3 4
# 19 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/stdlib.h" 3 4
# 1 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h" 1 3 4
# 10 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h" 3 4
typedef long double _Double;
# 42 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h" 3 4
typedef short unsigned int wchar_t;
# 221 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h" 3 4
typedef unsigned int size_t;
# 20 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/stdlib.h" 2 3 4

int atoi (const char *);
long atol (const char *);
long long atoll (const char *);
double atof (const char *);

float strtof (const char *restrict, char **restrict);
double strtod (const char *restrict, char **restrict);
long double strtold (const char *restrict, char **restrict);

long strtol (const char *restrict, char **restrict, int);
unsigned long strtoul (const char *restrict, char **restrict, int);
long long strtoll (const char *restrict, char **restrict, int);
unsigned long long strtoull (const char *restrict, char **restrict, int);

int rand (void);
void srand (unsigned);

void *malloc (size_t);
void *calloc (size_t, size_t);
void *realloc (void *, size_t);
void free (void *);
void *aligned_alloc(size_t, size_t);

__attribute__((__noreturn__)) void abort (void);
int atexit (void (*) (void));
__attribute__((__noreturn__)) void exit (int);
__attribute__((__noreturn__)) void _Exit (int);
int at_quick_exit (void (*) (void));
__attribute__((__noreturn__)) void quick_exit (int);

char *getenv (const char *);

int system (const char *);

void *bsearch (const void *, const void *, size_t, size_t, int (*)(const void *, const void *));
void qsort (void *, size_t, size_t, int (*)(const void *, const void *));

int abs (int);
long labs (long);
long long llabs (long long);

typedef struct { int quot, rem; } div_t;
typedef struct { long quot, rem; } ldiv_t;
typedef struct { long long quot, rem; } lldiv_t;

div_t div (int, int);
ldiv_t ldiv (long, long);
lldiv_t lldiv (long long, long long);

int mblen (const char *, size_t);
int mbtowc (wchar_t *restrict, const char *restrict, size_t);
int wctomb (char *, wchar_t);
size_t mbstowcs (wchar_t *restrict, const char *restrict, size_t);
size_t wcstombs (char *restrict, const wchar_t *restrict, size_t);




size_t __ctype_get_mb_cur_max(void);
# 99 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/stdlib.h" 3 4
int posix_memalign (void **, size_t, size_t);
int setenv (const char *, const char *, int);
int unsetenv (const char *);
int mkstemp (char *);
int mkostemp (char *, int);
char *mkdtemp (char *);
int getsubopt (char **, char *const *, char **);
int rand_r (unsigned *);






char *realpath (const char *restrict, char *restrict);
long int random (void);
void srandom (unsigned int);
char *initstate (unsigned int, char *, size_t);
char *setstate (char *);
int putenv (char *);
int posix_openpt (int);
int grantpt (int);
int unlockpt (int);
char *ptsname (int);
char *l64a (long);
long a64l (const char *);
void setkey (const char *);
double drand48 (void);
double erand48 (unsigned short [3]);
long int lrand48 (void);
long int nrand48 (unsigned short [3]);
long mrand48 (void);
long jrand48 (unsigned short [3]);
void srand48 (long);
unsigned short *seed48 (unsigned short [3]);
void lcong48 (unsigned short [7]);



# 1 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/alloca.h" 1 3 4
# 9 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/alloca.h" 3 4
# 1 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h" 1 3 4
# 10 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/alloca.h" 2 3 4

void *alloca(size_t);
# 139 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/stdlib.h" 2 3 4
char *mktemp (char *);
int mkstemps (char *, int);
int mkostemps (char *, int, int);
void *valloc (size_t);
void *memalign(size_t, size_t);
int getloadavg(double *, int);
int clearenv(void);
# 36 "../serial/serial.c" 2


# 1 "../../../Source/include/FreeRTOS.h" 1
# 35 "../../../Source/include/FreeRTOS.h"
# 1 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/stddef.h" 1 3 4
# 17 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/stddef.h" 3 4
# 1 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h" 1 3 4
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
# 1 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33E-GM-GP-MC-GU-MU_DFP/1.5.258/xc16/bin/..\\support\\generic\\h/xc.h" 1 3 4
# 46 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33E-GM-GP-MC-GU-MU_DFP/1.5.258/xc16/bin/..\\support\\generic\\h/xc.h" 3 4
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
# 47 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33E-GM-GP-MC-GU-MU_DFP/1.5.258/xc16/bin/..\\support\\generic\\h/xc.h" 2 3 4
# 443 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33E-GM-GP-MC-GU-MU_DFP/1.5.258/xc16/bin/..\\support\\generic\\h/xc.h" 3 4
# 1 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33E-GM-GP-MC-GU-MU_DFP/1.5.258/xc16/bin/..\\support\\dsPIC33E\\h/p33EP512MU810.h" 1 3 4
# 57 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33E-GM-GP-MC-GU-MU_DFP/1.5.258/xc16/bin/..\\support\\dsPIC33E\\h/p33EP512MU810.h" 3 4
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


extern volatile uint16_t TMR6 __attribute__((__sfr__));

extern volatile uint16_t TMR7HLD __attribute__((__sfr__));

extern volatile uint16_t TMR7 __attribute__((__sfr__));

extern volatile uint16_t PR6 __attribute__((__sfr__));

extern volatile uint16_t PR7 __attribute__((__sfr__));

extern volatile uint16_t T6CON __attribute__((__sfr__));
__extension__ typedef struct tagT6CONBITS {
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
} T6CONBITS;
extern volatile T6CONBITS T6CONbits __attribute__((__sfr__));


extern volatile uint16_t T7CON __attribute__((__sfr__));
__extension__ typedef struct tagT7CONBITS {
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
} T7CONBITS;
extern volatile T7CONBITS T7CONbits __attribute__((__sfr__));


extern volatile uint16_t TMR8 __attribute__((__sfr__));

extern volatile uint16_t TMR9HLD __attribute__((__sfr__));

extern volatile uint16_t TMR9 __attribute__((__sfr__));

extern volatile uint16_t PR8 __attribute__((__sfr__));

extern volatile uint16_t PR9 __attribute__((__sfr__));

extern volatile uint16_t T8CON __attribute__((__sfr__));
__extension__ typedef struct tagT8CONBITS {
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
} T8CONBITS;
extern volatile T8CONBITS T8CONbits __attribute__((__sfr__));


extern volatile uint16_t T9CON __attribute__((__sfr__));
__extension__ typedef struct tagT9CONBITS {
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
} T9CONBITS;
extern volatile T9CONBITS T9CONbits __attribute__((__sfr__));


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

extern volatile uint16_t IC5CON1 __attribute__((__sfr__));
__extension__ typedef struct tagIC5CON1BITS {
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
} IC5CON1BITS;
extern volatile IC5CON1BITS IC5CON1bits __attribute__((__sfr__));


extern volatile uint16_t IC5CON2 __attribute__((__sfr__));
__extension__ typedef struct tagIC5CON2BITS {
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
} IC5CON2BITS;
extern volatile IC5CON2BITS IC5CON2bits __attribute__((__sfr__));



extern volatile IC ACC5 __attribute__((__sfr__));


extern volatile uint16_t IC5BUF __attribute__((__sfr__));

extern volatile uint16_t IC5TMR __attribute__((__sfr__));

extern volatile uint16_t IC6CON1 __attribute__((__sfr__));
__extension__ typedef struct tagIC6CON1BITS {
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
} IC6CON1BITS;
extern volatile IC6CON1BITS IC6CON1bits __attribute__((__sfr__));


extern volatile uint16_t IC6CON2 __attribute__((__sfr__));
__extension__ typedef struct tagIC6CON2BITS {
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
} IC6CON2BITS;
extern volatile IC6CON2BITS IC6CON2bits __attribute__((__sfr__));



extern volatile IC ACC6 __attribute__((__sfr__));


extern volatile uint16_t IC6BUF __attribute__((__sfr__));

extern volatile uint16_t IC6TMR __attribute__((__sfr__));

extern volatile uint16_t IC7CON1 __attribute__((__sfr__));
__extension__ typedef struct tagIC7CON1BITS {
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
} IC7CON1BITS;
extern volatile IC7CON1BITS IC7CON1bits __attribute__((__sfr__));


extern volatile uint16_t IC7CON2 __attribute__((__sfr__));
__extension__ typedef struct tagIC7CON2BITS {
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
} IC7CON2BITS;
extern volatile IC7CON2BITS IC7CON2bits __attribute__((__sfr__));



extern volatile IC ACC7 __attribute__((__sfr__));


extern volatile uint16_t IC7BUF __attribute__((__sfr__));

extern volatile uint16_t IC7TMR __attribute__((__sfr__));

extern volatile uint16_t IC8CON1 __attribute__((__sfr__));
__extension__ typedef struct tagIC8CON1BITS {
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
} IC8CON1BITS;
extern volatile IC8CON1BITS IC8CON1bits __attribute__((__sfr__));


extern volatile uint16_t IC8CON2 __attribute__((__sfr__));
__extension__ typedef struct tagIC8CON2BITS {
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
} IC8CON2BITS;
extern volatile IC8CON2BITS IC8CON2bits __attribute__((__sfr__));



extern volatile IC ACC8 __attribute__((__sfr__));


extern volatile uint16_t IC8BUF __attribute__((__sfr__));

extern volatile uint16_t IC8TMR __attribute__((__sfr__));

extern volatile uint16_t IC9CON1 __attribute__((__sfr__));
__extension__ typedef struct tagIC9CON1BITS {
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
} IC9CON1BITS;
extern volatile IC9CON1BITS IC9CON1bits __attribute__((__sfr__));


extern volatile uint16_t IC9CON2 __attribute__((__sfr__));
__extension__ typedef struct tagIC9CON2BITS {
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
} IC9CON2BITS;
extern volatile IC9CON2BITS IC9CON2bits __attribute__((__sfr__));



extern volatile IC ACC9 __attribute__((__sfr__));


extern volatile uint16_t IC9BUF __attribute__((__sfr__));

extern volatile uint16_t IC9TMR __attribute__((__sfr__));

extern volatile uint16_t IC10CON1 __attribute__((__sfr__));
__extension__ typedef struct tagIC10CON1BITS {
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
} IC10CON1BITS;
extern volatile IC10CON1BITS IC10CON1bits __attribute__((__sfr__));


extern volatile uint16_t IC10CON2 __attribute__((__sfr__));
__extension__ typedef struct tagIC10CON2BITS {
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
} IC10CON2BITS;
extern volatile IC10CON2BITS IC10CON2bits __attribute__((__sfr__));


extern volatile uint16_t IC10BUF __attribute__((__sfr__));

extern volatile uint16_t IC10TMR __attribute__((__sfr__));

extern volatile uint16_t IC11CON1 __attribute__((__sfr__));
__extension__ typedef struct tagIC11CON1BITS {
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
} IC11CON1BITS;
extern volatile IC11CON1BITS IC11CON1bits __attribute__((__sfr__));


extern volatile uint16_t IC11CON2 __attribute__((__sfr__));
__extension__ typedef struct tagIC11CON2BITS {
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
} IC11CON2BITS;
extern volatile IC11CON2BITS IC11CON2bits __attribute__((__sfr__));


extern volatile uint16_t IC11BUF __attribute__((__sfr__));

extern volatile uint16_t IC11TMR __attribute__((__sfr__));

extern volatile uint16_t IC12CON1 __attribute__((__sfr__));
__extension__ typedef struct tagIC12CON1BITS {
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
} IC12CON1BITS;
extern volatile IC12CON1BITS IC12CON1bits __attribute__((__sfr__));


extern volatile uint16_t IC12CON2 __attribute__((__sfr__));
__extension__ typedef struct tagIC12CON2BITS {
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
} IC12CON2BITS;
extern volatile IC12CON2BITS IC12CON2bits __attribute__((__sfr__));


extern volatile uint16_t IC12BUF __attribute__((__sfr__));

extern volatile uint16_t IC12TMR __attribute__((__sfr__));

extern volatile uint16_t IC13CON1 __attribute__((__sfr__));
__extension__ typedef struct tagIC13CON1BITS {
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
} IC13CON1BITS;
extern volatile IC13CON1BITS IC13CON1bits __attribute__((__sfr__));


extern volatile uint16_t IC13CON2 __attribute__((__sfr__));
__extension__ typedef struct tagIC13CON2BITS {
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
} IC13CON2BITS;
extern volatile IC13CON2BITS IC13CON2bits __attribute__((__sfr__));


extern volatile uint16_t IC13BUF __attribute__((__sfr__));

extern volatile uint16_t IC13TMR __attribute__((__sfr__));

extern volatile uint16_t IC14CON1 __attribute__((__sfr__));
__extension__ typedef struct tagIC14CON1BITS {
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
} IC14CON1BITS;
extern volatile IC14CON1BITS IC14CON1bits __attribute__((__sfr__));


extern volatile uint16_t IC14CON2 __attribute__((__sfr__));
__extension__ typedef struct tagIC14CON2BITS {
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
} IC14CON2BITS;
extern volatile IC14CON2BITS IC14CON2bits __attribute__((__sfr__));


extern volatile uint16_t IC14BUF __attribute__((__sfr__));

extern volatile uint16_t IC14TMR __attribute__((__sfr__));

extern volatile uint16_t IC15CON1 __attribute__((__sfr__));
__extension__ typedef struct tagIC15CON1BITS {
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
} IC15CON1BITS;
extern volatile IC15CON1BITS IC15CON1bits __attribute__((__sfr__));


extern volatile uint16_t IC15CON2 __attribute__((__sfr__));
__extension__ typedef struct tagIC15CON2BITS {
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
} IC15CON2BITS;
extern volatile IC15CON2BITS IC15CON2bits __attribute__((__sfr__));


extern volatile uint16_t IC15BUF __attribute__((__sfr__));

extern volatile uint16_t IC15TMR __attribute__((__sfr__));

extern volatile uint16_t IC16CON1 __attribute__((__sfr__));
__extension__ typedef struct tagIC16CON1BITS {
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
} IC16CON1BITS;
extern volatile IC16CON1BITS IC16CON1bits __attribute__((__sfr__));


extern volatile uint16_t IC16CON2 __attribute__((__sfr__));
__extension__ typedef struct tagIC16CON2BITS {
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
} IC16CON2BITS;
extern volatile IC16CON2BITS IC16CON2bits __attribute__((__sfr__));


extern volatile uint16_t IC16BUF __attribute__((__sfr__));

extern volatile uint16_t IC16TMR __attribute__((__sfr__));

extern volatile uint16_t QEI1CON __attribute__((__sfr__));
typedef struct tagQEI1CONBITS {
  uint16_t CCM:2;
  uint16_t GATEN:1;
  uint16_t CNTPOL:1;
  uint16_t INTDIV:3;
  uint16_t :1;
  uint16_t IMV:2;
  uint16_t PIMOD:3;
  uint16_t QEISIDL:1;
  uint16_t :1;
  uint16_t QEIEN:1;
} QEI1CONBITS;
extern volatile QEI1CONBITS QEI1CONbits __attribute__((__sfr__));


extern volatile uint16_t QEI1IOC __attribute__((__sfr__));
typedef struct tagQEI1IOCBITS {
  uint16_t QEA:1;
  uint16_t QEB:1;
  uint16_t INDEX:1;
  uint16_t HOME:1;
  uint16_t QEAPOL:1;
  uint16_t QEBPOL:1;
  uint16_t IDXPOL:1;
  uint16_t HOMPOL:1;
  uint16_t SWPAB:1;
  uint16_t OUTFNC:2;
  uint16_t QFDIV:3;
  uint16_t FLTREN:1;
  uint16_t QCAPEN:1;
} QEI1IOCBITS;
extern volatile QEI1IOCBITS QEI1IOCbits __attribute__((__sfr__));


extern volatile uint16_t QEI1STAT __attribute__((__sfr__));
typedef struct tagQEI1STATBITS {
  uint16_t IDXIEN:1;
  uint16_t IDXIRQ:1;
  uint16_t HOMIEN:1;
  uint16_t HOMIRQ:1;
  uint16_t VELOVIEN:1;
  uint16_t VELOVIRQ:1;
  uint16_t PCIIEN:1;
  uint16_t PCIIRQ:1;
  uint16_t POSOVIEN:1;
  uint16_t POSOVIRQ:1;
  uint16_t PCLEQIEN:1;
  uint16_t PCLEQIRQ:1;
  uint16_t PCHEQIEN:1;
  uint16_t PCHEQIRQ:1;
} QEI1STATBITS;
extern volatile QEI1STATBITS QEI1STATbits __attribute__((__sfr__));


extern volatile uint16_t POS1CNTL __attribute__((__sfr__));

extern volatile uint16_t POS1CNTH __attribute__((__sfr__));

extern volatile uint16_t POS1HLD __attribute__((__sfr__));

extern volatile uint16_t VEL1CNT __attribute__((__sfr__));

extern volatile uint16_t INT1TMRL __attribute__((__sfr__));

extern volatile uint16_t INT1TMRH __attribute__((__sfr__));

extern volatile uint16_t INT1HLDL __attribute__((__sfr__));

extern volatile uint16_t INT1HLDH __attribute__((__sfr__));

extern volatile uint16_t INDX1CNTL __attribute__((__sfr__));

extern volatile uint16_t INDX1CNTH __attribute__((__sfr__));

extern volatile uint16_t INDX1HLD __attribute__((__sfr__));

extern volatile uint16_t QEI1GECL __attribute__((__sfr__));

extern volatile uint16_t QEI1ICL __attribute__((__sfr__));

extern volatile uint16_t QEI1GECH __attribute__((__sfr__));

extern volatile uint16_t QEI1ICH __attribute__((__sfr__));

extern volatile uint16_t QEI1LECL __attribute__((__sfr__));

extern volatile uint16_t QEI1LECH __attribute__((__sfr__));

extern volatile uint16_t I2C1RCV __attribute__((__sfr__));

extern volatile uint16_t I2C1TRN __attribute__((__sfr__));

extern volatile uint16_t I2C1BRG __attribute__((__sfr__));

extern volatile uint16_t I2C1CON __attribute__((__sfr__));
typedef struct tagI2C1CONBITS {
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
  uint16_t IPMIEN:1;
  uint16_t SCLREL:1;
  uint16_t I2CSIDL:1;
  uint16_t :1;
  uint16_t I2CEN:1;
} I2C1CONBITS;
extern volatile I2C1CONBITS I2C1CONbits __attribute__((__sfr__));


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
  uint16_t :3;
  uint16_t TRSTAT:1;
  uint16_t ACKSTAT:1;
} I2C1STATBITS;
extern volatile I2C1STATBITS I2C1STATbits __attribute__((__sfr__));


extern volatile uint16_t I2C1ADD __attribute__((__sfr__));

extern volatile uint16_t I2C1MSK __attribute__((__sfr__));

extern volatile uint16_t I2C2RCV __attribute__((__sfr__));

extern volatile uint16_t I2C2TRN __attribute__((__sfr__));

extern volatile uint16_t I2C2BRG __attribute__((__sfr__));

extern volatile uint16_t I2C2CON __attribute__((__sfr__));
typedef struct tagI2C2CONBITS {
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
  uint16_t IPMIEN:1;
  uint16_t SCLREL:1;
  uint16_t I2CSIDL:1;
  uint16_t :1;
  uint16_t I2CEN:1;
} I2C2CONBITS;
extern volatile I2C2CONBITS I2C2CONbits __attribute__((__sfr__));


extern volatile uint16_t I2C2STAT __attribute__((__sfr__));
typedef struct tagI2C2STATBITS {
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
  uint16_t :3;
  uint16_t TRSTAT:1;
  uint16_t ACKSTAT:1;
} I2C2STATBITS;
extern volatile I2C2STATBITS I2C2STATbits __attribute__((__sfr__));


extern volatile uint16_t I2C2ADD __attribute__((__sfr__));

extern volatile uint16_t I2C2MSK __attribute__((__sfr__));


typedef struct tagUART {
        uint16_t uxmode;
        uint16_t uxsta;
        uint16_t uxtxreg;
        uint16_t uxrxreg;
        uint16_t uxbrg;
} UART, *PUART;
# 1669 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33E-GM-GP-MC-GU-MU_DFP/1.5.258/xc16/bin/..\\support\\dsPIC33E\\h/p33EP512MU810.h" 3 4
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


extern volatile UART UART3 __attribute__((__sfr__));


extern volatile uint16_t U3MODE __attribute__((__sfr__));
__extension__ typedef struct tagU3MODEBITS {
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
} U3MODEBITS;
extern volatile U3MODEBITS U3MODEbits __attribute__((__sfr__));


extern volatile uint16_t U3STA __attribute__((__sfr__));
__extension__ typedef struct tagU3STABITS {
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
} U3STABITS;
extern volatile U3STABITS U3STAbits __attribute__((__sfr__));


extern volatile uint16_t U3TXREG __attribute__((__sfr__));

extern volatile uint16_t U3RXREG __attribute__((__sfr__));

extern volatile uint16_t U3BRG __attribute__((__sfr__));


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

extern volatile uint16_t DCICON1 __attribute__((__sfr__));
__extension__ typedef struct tagDCICON1BITS {
  union {
    struct {
      uint16_t COFSM:2;
      uint16_t :3;
      uint16_t DJST:1;
      uint16_t CSDOM:1;
      uint16_t UNFM:1;
      uint16_t COFSD:1;
      uint16_t CSCKE:1;
      uint16_t CSCKD:1;
      uint16_t DLOOP:1;
      uint16_t :1;
      uint16_t DCISIDL:1;
      uint16_t :1;
      uint16_t DCIEN:1;
    };
    struct {
      uint16_t COFSM0:1;
      uint16_t COFSM1:1;
    };
  };
} DCICON1BITS;
extern volatile DCICON1BITS DCICON1bits __attribute__((__sfr__));


extern volatile uint16_t DCICON2 __attribute__((__sfr__));
__extension__ typedef struct tagDCICON2BITS {
  union {
    struct {
      uint16_t WS:4;
      uint16_t :1;
      uint16_t COFSG:4;
      uint16_t :1;
      uint16_t BLEN:2;
    };
    struct {
      uint16_t WS0:1;
      uint16_t WS1:1;
      uint16_t WS2:1;
      uint16_t WS3:1;
      uint16_t :1;
      uint16_t COFSG0:1;
      uint16_t COFSG1:1;
      uint16_t COFSG2:1;
      uint16_t COFSG3:1;
      uint16_t :1;
      uint16_t BLEN0:1;
      uint16_t BLEN1:1;
    };
  };
} DCICON2BITS;
extern volatile DCICON2BITS DCICON2bits __attribute__((__sfr__));


extern volatile uint16_t DCICON3 __attribute__((__sfr__));
__extension__ typedef struct tagDCICON3BITS {
  union {
    struct {
      uint16_t BCG:12;
    };
    struct {
      uint16_t BCG0:1;
      uint16_t BCG1:1;
      uint16_t BCG2:1;
      uint16_t BCG3:1;
      uint16_t BCG4:1;
      uint16_t BCG5:1;
      uint16_t BCG6:1;
      uint16_t BCG7:1;
      uint16_t BCG8:1;
      uint16_t BCG9:1;
      uint16_t BCG10:1;
      uint16_t BCG11:1;
    };
  };
} DCICON3BITS;
extern volatile DCICON3BITS DCICON3bits __attribute__((__sfr__));


extern volatile uint16_t DCISTAT __attribute__((__sfr__));
__extension__ typedef struct tagDCISTATBITS {
  union {
    struct {
      uint16_t TMPTY:1;
      uint16_t TUNF:1;
      uint16_t RFUL:1;
      uint16_t ROV:1;
      uint16_t :4;
      uint16_t SLOT:4;
    };
    struct {
      uint16_t :8;
      uint16_t SLOT0:1;
      uint16_t SLOT1:1;
      uint16_t SLOT2:1;
      uint16_t SLOT3:1;
    };
  };
} DCISTATBITS;
extern volatile DCISTATBITS DCISTATbits __attribute__((__sfr__));


extern volatile uint16_t TSCON __attribute__((__sfr__));
typedef struct tagTSCONBITS {
  uint16_t TSE0:1;
  uint16_t TSE1:1;
  uint16_t TSE2:1;
  uint16_t TSE3:1;
  uint16_t TSE4:1;
  uint16_t TSE5:1;
  uint16_t TSE6:1;
  uint16_t TSE7:1;
  uint16_t TSE8:1;
  uint16_t TSE9:1;
  uint16_t TSE10:1;
  uint16_t TSE11:1;
  uint16_t TSE12:1;
  uint16_t TSE13:1;
  uint16_t TSE14:1;
  uint16_t TSE15:1;
} TSCONBITS;
extern volatile TSCONBITS TSCONbits __attribute__((__sfr__));


extern volatile uint16_t RSCON __attribute__((__sfr__));
typedef struct tagRSCONBITS {
  uint16_t RSE0:1;
  uint16_t RSE1:1;
  uint16_t RSE2:1;
  uint16_t RSE3:1;
  uint16_t RSE4:1;
  uint16_t RSE5:1;
  uint16_t RSE6:1;
  uint16_t RSE7:1;
  uint16_t RSE8:1;
  uint16_t RSE9:1;
  uint16_t RSE10:1;
  uint16_t RSE11:1;
  uint16_t RSE12:1;
  uint16_t RSE13:1;
  uint16_t RSE14:1;
  uint16_t RSE15:1;
} RSCONBITS;
extern volatile RSCONBITS RSCONbits __attribute__((__sfr__));


extern volatile uint16_t RXBUF0 __attribute__((__sfr__));

extern volatile uint16_t RXBUF1 __attribute__((__sfr__));

extern volatile uint16_t RXBUF2 __attribute__((__sfr__));

extern volatile uint16_t RXBUF3 __attribute__((__sfr__));

extern volatile uint16_t TXBUF0 __attribute__((__sfr__));

extern volatile uint16_t TXBUF1 __attribute__((__sfr__));

extern volatile uint16_t TXBUF2 __attribute__((__sfr__));

extern volatile uint16_t TXBUF3 __attribute__((__sfr__));


extern volatile SPI SPI3 __attribute__((__sfr__));


extern volatile uint16_t SPI3STAT __attribute__((__sfr__));
__extension__ typedef struct tagSPI3STATBITS {
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
} SPI3STATBITS;
extern volatile SPI3STATBITS SPI3STATbits __attribute__((__sfr__));


extern volatile uint16_t SPI3CON1 __attribute__((__sfr__));
__extension__ typedef struct tagSPI3CON1BITS {
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
} SPI3CON1BITS;
extern volatile SPI3CON1BITS SPI3CON1bits __attribute__((__sfr__));


extern volatile uint16_t SPI3CON2 __attribute__((__sfr__));
typedef struct tagSPI3CON2BITS {
  uint16_t SPIBEN:1;
  uint16_t FRMDLY:1;
  uint16_t :11;
  uint16_t FRMPOL:1;
  uint16_t SPIFSD:1;
  uint16_t FRMEN:1;
} SPI3CON2BITS;
extern volatile SPI3CON2BITS SPI3CON2bits __attribute__((__sfr__));


extern volatile uint16_t SPI3BUF __attribute__((__sfr__));


extern volatile UART UART4 __attribute__((__sfr__));


extern volatile uint16_t U4MODE __attribute__((__sfr__));
__extension__ typedef struct tagU4MODEBITS {
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
} U4MODEBITS;
extern volatile U4MODEBITS U4MODEbits __attribute__((__sfr__));


extern volatile uint16_t U4STA __attribute__((__sfr__));
__extension__ typedef struct tagU4STABITS {
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
} U4STABITS;
extern volatile U4STABITS U4STAbits __attribute__((__sfr__));


extern volatile uint16_t U4TXREG __attribute__((__sfr__));

extern volatile uint16_t U4RXREG __attribute__((__sfr__));

extern volatile uint16_t U4BRG __attribute__((__sfr__));


extern volatile SPI SPI4 __attribute__((__sfr__));


extern volatile uint16_t SPI4STAT __attribute__((__sfr__));
__extension__ typedef struct tagSPI4STATBITS {
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
} SPI4STATBITS;
extern volatile SPI4STATBITS SPI4STATbits __attribute__((__sfr__));


extern volatile uint16_t SPI4CON1 __attribute__((__sfr__));
__extension__ typedef struct tagSPI4CON1BITS {
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
} SPI4CON1BITS;
extern volatile SPI4CON1BITS SPI4CON1bits __attribute__((__sfr__));


extern volatile uint16_t SPI4CON2 __attribute__((__sfr__));
typedef struct tagSPI4CON2BITS {
  uint16_t SPIBEN:1;
  uint16_t FRMDLY:1;
  uint16_t :11;
  uint16_t FRMPOL:1;
  uint16_t SPIFSD:1;
  uint16_t FRMEN:1;
} SPI4CON2BITS;
extern volatile SPI4CON2BITS SPI4CON2bits __attribute__((__sfr__));


extern volatile uint16_t SPI4BUF __attribute__((__sfr__));

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
      uint16_t CH123SA:1;
      uint16_t CH123NA:2;
      uint16_t :5;
      uint16_t CH123SB:1;
      uint16_t CH123NB:2;
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
      uint16_t CH0SA:5;
      uint16_t :2;
      uint16_t CH0NA:1;
      uint16_t CH0SB:5;
      uint16_t :2;
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
  uint16_t CSS20:1;
  uint16_t CSS21:1;
  uint16_t CSS22:1;
  uint16_t CSS23:1;
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


extern volatile uint16_t ADC2BUF0 __attribute__((__sfr__));

extern volatile uint16_t ADC2BUF1 __attribute__((__sfr__));

extern volatile uint16_t ADC2BUF2 __attribute__((__sfr__));

extern volatile uint16_t ADC2BUF3 __attribute__((__sfr__));

extern volatile uint16_t ADC2BUF4 __attribute__((__sfr__));

extern volatile uint16_t ADC2BUF5 __attribute__((__sfr__));

extern volatile uint16_t ADC2BUF6 __attribute__((__sfr__));

extern volatile uint16_t ADC2BUF7 __attribute__((__sfr__));

extern volatile uint16_t ADC2BUF8 __attribute__((__sfr__));

extern volatile uint16_t ADC2BUF9 __attribute__((__sfr__));

extern volatile uint16_t ADC2BUFA __attribute__((__sfr__));

extern volatile uint16_t ADC2BUFB __attribute__((__sfr__));

extern volatile uint16_t ADC2BUFC __attribute__((__sfr__));

extern volatile uint16_t ADC2BUFD __attribute__((__sfr__));

extern volatile uint16_t ADC2BUFE __attribute__((__sfr__));

extern volatile uint16_t ADC2BUFF __attribute__((__sfr__));

extern volatile uint16_t AD2CON1 __attribute__((__sfr__));
__extension__ typedef struct tagAD2CON1BITS {
  union {
    struct {
      uint16_t DONE:1;
      uint16_t SAMP:1;
      uint16_t ASAM:1;
      uint16_t SIMSAM:1;
      uint16_t SSRCG:1;
      uint16_t SSRC:3;
      uint16_t FORM:2;
      uint16_t :2;
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
} AD2CON1BITS;
extern volatile AD2CON1BITS AD2CON1bits __attribute__((__sfr__));


extern volatile uint16_t AD2CON2 __attribute__((__sfr__));
__extension__ typedef struct tagAD2CON2BITS {
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
} AD2CON2BITS;
extern volatile AD2CON2BITS AD2CON2bits __attribute__((__sfr__));


extern volatile uint16_t AD2CON3 __attribute__((__sfr__));
__extension__ typedef struct tagAD2CON3BITS {
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
} AD2CON3BITS;
extern volatile AD2CON3BITS AD2CON3bits __attribute__((__sfr__));


extern volatile uint16_t AD2CHS123 __attribute__((__sfr__));
__extension__ typedef struct tagAD2CHS123BITS {
  union {
    struct {
      uint16_t CH123SA:1;
      uint16_t CH123NA:2;
      uint16_t :5;
      uint16_t CH123SB:1;
      uint16_t CH123NB:2;
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
} AD2CHS123BITS;
extern volatile AD2CHS123BITS AD2CHS123bits __attribute__((__sfr__));


extern volatile uint16_t AD2CHS0 __attribute__((__sfr__));
__extension__ typedef struct tagAD2CHS0BITS {
  union {
    struct {
      uint16_t CH0SA:5;
      uint16_t :2;
      uint16_t CH0NA:1;
      uint16_t CH0SB:5;
      uint16_t :2;
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
} AD2CHS0BITS;
extern volatile AD2CHS0BITS AD2CHS0bits __attribute__((__sfr__));


extern volatile uint16_t AD2CSSL __attribute__((__sfr__));
typedef struct tagAD2CSSLBITS {
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
} AD2CSSLBITS;
extern volatile AD2CSSLBITS AD2CSSLbits __attribute__((__sfr__));


extern volatile uint16_t AD2CON4 __attribute__((__sfr__));
__extension__ typedef struct tagAD2CON4BITS {
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
} AD2CON4BITS;
extern volatile AD2CON4BITS AD2CON4bits __attribute__((__sfr__));


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


extern volatile uint16_t U1OTGIR __attribute__((__sfr__));
typedef struct tagU1OTGIRBITS {
  uint16_t VBUSVDIF:1;
  uint16_t :1;
  uint16_t SESENDIF:1;
  uint16_t SESVDIF:1;
  uint16_t ACTVIF:1;
  uint16_t LSTATEIF:1;
  uint16_t T1MSECIF:1;
  uint16_t IDIF:1;
} U1OTGIRBITS;
extern volatile U1OTGIRBITS U1OTGIRbits __attribute__((__sfr__));


extern volatile uint16_t U1OTGIE __attribute__((__sfr__));
typedef struct tagU1OTGIEBITS {
  uint16_t VBUSVDIE:1;
  uint16_t :1;
  uint16_t SESENDIE:1;
  uint16_t SESVDIE:1;
  uint16_t ACTVIE:1;
  uint16_t LSTATEIE:1;
  uint16_t T1MSECIE:1;
  uint16_t IDIE:1;
} U1OTGIEBITS;
extern volatile U1OTGIEBITS U1OTGIEbits __attribute__((__sfr__));


extern volatile uint16_t U1OTGSTAT __attribute__((__sfr__));
typedef struct tagU1OTGSTATBITS {
  uint16_t VBUSVD:1;
  uint16_t :1;
  uint16_t SESEND:1;
  uint16_t SESVD:1;
  uint16_t :1;
  uint16_t LSTATE:1;
  uint16_t :1;
  uint16_t ID:1;
} U1OTGSTATBITS;
extern volatile U1OTGSTATBITS U1OTGSTATbits __attribute__((__sfr__));


extern volatile uint16_t U1OTGCON __attribute__((__sfr__));
typedef struct tagU1OTGCONBITS {
  uint16_t VBUSDIS:1;
  uint16_t VBUSCHG:1;
  uint16_t OTGEN:1;
  uint16_t VBUSON:1;
  uint16_t DMPULDWN:1;
  uint16_t DPPULDWN:1;
  uint16_t DMPULUP:1;
  uint16_t DPPULUP:1;
} U1OTGCONBITS;
extern volatile U1OTGCONBITS U1OTGCONbits __attribute__((__sfr__));


extern volatile uint16_t U1PWRC __attribute__((__sfr__));
__extension__ typedef struct tagU1PWRCBITS {
  union {
    struct {
      uint16_t USBPWR:1;
      uint16_t USUSPND:1;
      uint16_t :2;
      uint16_t USLPGRD:1;
      uint16_t :2;
      uint16_t UACTPND:1;
    };
    struct {
      uint16_t :1;
      uint16_t USUSPEND:1;
    };
  };
} U1PWRCBITS;
extern volatile U1PWRCBITS U1PWRCbits __attribute__((__sfr__));


extern volatile uint16_t U1IR __attribute__((__sfr__));
__extension__ typedef struct tagU1IRBITS {
  union {
    struct {
      uint16_t URSTIF:1;
      uint16_t UERRIF:1;
      uint16_t SOFIF:1;
      uint16_t TRNIF:1;
      uint16_t IDLEIF:1;
      uint16_t RESUMEIF:1;
      uint16_t :1;
      uint16_t STALLIF:1;
    };
    struct {
      uint16_t DETACHIF:1;
      uint16_t :5;
      uint16_t ATTACHIF:1;
    };
  };
} U1IRBITS;
extern volatile U1IRBITS U1IRbits __attribute__((__sfr__));


extern volatile uint16_t U1IE __attribute__((__sfr__));
__extension__ typedef struct tagU1IEBITS {
  union {
    struct {
      uint16_t URSTIE:1;
      uint16_t UERRIE:1;
      uint16_t SOFIE:1;
      uint16_t TRNIE:1;
      uint16_t IDLEIE:1;
      uint16_t RESUMEIE:1;
      uint16_t :1;
      uint16_t STALLIE:1;
    };
    struct {
      uint16_t DETACHIE:1;
      uint16_t :5;
      uint16_t ATTACHIE:1;
    };
  };
} U1IEBITS;
extern volatile U1IEBITS U1IEbits __attribute__((__sfr__));


extern volatile uint16_t U1EIR __attribute__((__sfr__));
__extension__ typedef struct tagU1EIRBITS {
  union {
    struct {
      uint16_t PIDEF:1;
      uint16_t CRC5EF:1;
      uint16_t CRC16EF:1;
      uint16_t DFN8EF:1;
      uint16_t BTOEF:1;
      uint16_t DMAEF:1;
      uint16_t BUSACCEF:1;
      uint16_t BTSEF:1;
    };
    struct {
      uint16_t :1;
      uint16_t EOFEF:1;
    };
  };
} U1EIRBITS;
extern volatile U1EIRBITS U1EIRbits __attribute__((__sfr__));


extern volatile uint16_t U1EIE __attribute__((__sfr__));
__extension__ typedef struct tagU1EIEBITS {
  union {
    struct {
      uint16_t PIDEE:1;
      uint16_t CRC5EE:1;
      uint16_t CRC16EE:1;
      uint16_t DFN8EE:1;
      uint16_t BTOEE:1;
      uint16_t DMAEE:1;
      uint16_t BUSACCEE:1;
      uint16_t BTSEE:1;
    };
    struct {
      uint16_t :1;
      uint16_t EOFEE:1;
    };
  };
} U1EIEBITS;
extern volatile U1EIEBITS U1EIEbits __attribute__((__sfr__));


extern volatile uint16_t U1STAT __attribute__((__sfr__));
__extension__ typedef struct tagU1STATBITS {
  union {
    struct {
      uint16_t :2;
      uint16_t PPBI:1;
      uint16_t DIR:1;
      uint16_t ENDPT:4;
    };
    struct {
      uint16_t :4;
      uint16_t ENDPT0:1;
      uint16_t ENDPT1:1;
      uint16_t ENDPT2:1;
      uint16_t ENDPT3:1;
    };
  };
} U1STATBITS;
extern volatile U1STATBITS U1STATbits __attribute__((__sfr__));


extern volatile uint16_t U1CON __attribute__((__sfr__));
__extension__ typedef struct tagU1CONBITS {
  union {
    struct {
      uint16_t USBEN:1;
      uint16_t PPBRST:1;
      uint16_t RESUME:1;
      uint16_t HOSTEN:1;
      uint16_t :1;
      uint16_t PKTDIS:1;
      uint16_t SE0:1;
    };
    struct {
      uint16_t SOFEN:1;
      uint16_t :3;
      uint16_t USBRST:1;
      uint16_t TOKBUSY:1;
      uint16_t :1;
      uint16_t JSTATE:1;
    };
    struct {
      uint16_t :4;
      uint16_t RESET:1;
    };
  };
} U1CONBITS;
extern volatile U1CONBITS U1CONbits __attribute__((__sfr__));


extern volatile uint16_t U1ADDR __attribute__((__sfr__));
__extension__ typedef struct tagU1ADDRBITS {
  union {
    struct {
      uint16_t DEVADDR:7;
      uint16_t LSPDEN:1;
    };
    struct {
      uint16_t DEVADDR0:1;
      uint16_t DEVADDR1:1;
      uint16_t DEVADDR2:1;
      uint16_t DEVADDR3:1;
      uint16_t DEVADDR4:1;
      uint16_t DEVADDR5:1;
      uint16_t DEVADDR6:1;
      uint16_t LOWSPDEN:1;
    };
  };
} U1ADDRBITS;
extern volatile U1ADDRBITS U1ADDRbits __attribute__((__sfr__));


extern volatile uint16_t U1BDTP1 __attribute__((__sfr__));
typedef struct tagU1BDTP1BITS {
  uint16_t :1;
  uint16_t BDTPTRL:7;
} U1BDTP1BITS;
extern volatile U1BDTP1BITS U1BDTP1bits __attribute__((__sfr__));


extern volatile uint16_t U1FRML __attribute__((__sfr__));
typedef struct tagU1FRMLBITS {
  uint16_t FRM0:1;
  uint16_t FRM1:1;
  uint16_t FRM2:1;
  uint16_t FRM3:1;
  uint16_t FRM4:1;
  uint16_t FRM5:1;
  uint16_t FRM6:1;
  uint16_t FRM7:1;
} U1FRMLBITS;
extern volatile U1FRMLBITS U1FRMLbits __attribute__((__sfr__));


extern volatile uint16_t U1FRMH __attribute__((__sfr__));
typedef struct tagU1FRMHBITS {
  uint16_t FRM8:1;
  uint16_t FRM9:1;
  uint16_t FRM10:1;
} U1FRMHBITS;
extern volatile U1FRMHBITS U1FRMHbits __attribute__((__sfr__));


extern volatile uint16_t U1TOK __attribute__((__sfr__));
__extension__ typedef struct tagU1TOKBITS {
  union {
    struct {
      uint16_t EP0:1;
      uint16_t EP1:1;
      uint16_t EP2:1;
      uint16_t EP3:1;
      uint16_t PID0:1;
      uint16_t PID1:1;
      uint16_t PID2:1;
      uint16_t PID3:1;
    };
    struct {
      uint16_t EP:4;
      uint16_t PID:4;
    };
  };
} U1TOKBITS;
extern volatile U1TOKBITS U1TOKbits __attribute__((__sfr__));


extern volatile uint16_t U1SOF __attribute__((__sfr__));
typedef struct tagU1SOFBITS {
  uint16_t CNT:8;
} U1SOFBITS;
extern volatile U1SOFBITS U1SOFbits __attribute__((__sfr__));


extern volatile uint16_t U1BDTP2 __attribute__((__sfr__));
typedef struct tagU1BDTP2BITS {
  uint16_t BDTPTRH:8;
} U1BDTP2BITS;
extern volatile U1BDTP2BITS U1BDTP2bits __attribute__((__sfr__));


extern volatile uint16_t U1BDTP3 __attribute__((__sfr__));
typedef struct tagU1BDTP3BITS {
  uint16_t BDTPTRU:8;
} U1BDTP3BITS;
extern volatile U1BDTP3BITS U1BDTP3bits __attribute__((__sfr__));


extern volatile uint16_t U1CNFG1 __attribute__((__sfr__));
typedef struct tagU1CNFG1BITS {
  uint16_t :4;
  uint16_t USBSIDL:1;
  uint16_t :1;
  uint16_t UOEMON:1;
  uint16_t UTEYE:1;
} U1CNFG1BITS;
extern volatile U1CNFG1BITS U1CNFG1bits __attribute__((__sfr__));


extern volatile uint16_t U1CNFG2 __attribute__((__sfr__));
typedef struct tagU1CNFG2BITS {
  uint16_t UTRDIS:1;
  uint16_t UVCMPDIS:1;
  uint16_t UVBUSDIS:1;
  uint16_t EXTI2CEN:1;
  uint16_t PUVBUS:1;
  uint16_t UVCMPSEL:1;
} U1CNFG2BITS;
extern volatile U1CNFG2BITS U1CNFG2bits __attribute__((__sfr__));


extern volatile uint16_t U1EP0 __attribute__((__sfr__));
__extension__ typedef struct tagU1EP0BITS {
  union {
    struct {
      uint16_t EPHSHK:1;
      uint16_t EPSTALL:1;
      uint16_t EPTXEN:1;
      uint16_t EPRXEN:1;
      uint16_t EPCONDIS:1;
      uint16_t :1;
      uint16_t RETRYDIS:1;
      uint16_t LSPD:1;
    };
    struct {
      uint16_t :2;
      uint16_t EPINEN:1;
      uint16_t EPOUTEN:1;
      uint16_t :3;
      uint16_t LOWSPD:1;
    };
  };
} U1EP0BITS;
extern volatile U1EP0BITS U1EP0bits __attribute__((__sfr__));


extern volatile uint16_t U1EP1 __attribute__((__sfr__));
__extension__ typedef struct tagU1EP1BITS {
  union {
    struct {
      uint16_t EPHSHK:1;
      uint16_t EPSTALL:1;
      uint16_t EPTXEN:1;
      uint16_t EPRXEN:1;
      uint16_t EPCONDIS:1;
    };
    struct {
      uint16_t :2;
      uint16_t EPINEN:1;
      uint16_t EPOUTEN:1;
    };
  };
} U1EP1BITS;
extern volatile U1EP1BITS U1EP1bits __attribute__((__sfr__));


extern volatile uint16_t U1EP2 __attribute__((__sfr__));
__extension__ typedef struct tagU1EP2BITS {
  union {
    struct {
      uint16_t EPHSHK:1;
      uint16_t EPSTALL:1;
      uint16_t EPTXEN:1;
      uint16_t EPRXEN:1;
      uint16_t EPCONDIS:1;
    };
    struct {
      uint16_t :2;
      uint16_t EPINEN:1;
      uint16_t EPOUTEN:1;
    };
  };
} U1EP2BITS;
extern volatile U1EP2BITS U1EP2bits __attribute__((__sfr__));


extern volatile uint16_t U1EP3 __attribute__((__sfr__));
__extension__ typedef struct tagU1EP3BITS {
  union {
    struct {
      uint16_t EPHSHK:1;
      uint16_t EPSTALL:1;
      uint16_t EPTXEN:1;
      uint16_t EPRXEN:1;
      uint16_t EPCONDIS:1;
    };
    struct {
      uint16_t :2;
      uint16_t EPINEN:1;
      uint16_t EPOUTEN:1;
    };
  };
} U1EP3BITS;
extern volatile U1EP3BITS U1EP3bits __attribute__((__sfr__));


extern volatile uint16_t U1EP4 __attribute__((__sfr__));
__extension__ typedef struct tagU1EP4BITS {
  union {
    struct {
      uint16_t EPHSHK:1;
      uint16_t EPSTALL:1;
      uint16_t EPTXEN:1;
      uint16_t EPRXEN:1;
      uint16_t EPCONDIS:1;
    };
    struct {
      uint16_t :2;
      uint16_t EPINEN:1;
      uint16_t EPOUTEN:1;
    };
  };
} U1EP4BITS;
extern volatile U1EP4BITS U1EP4bits __attribute__((__sfr__));


extern volatile uint16_t U1EP5 __attribute__((__sfr__));
__extension__ typedef struct tagU1EP5BITS {
  union {
    struct {
      uint16_t EPHSHK:1;
      uint16_t EPSTALL:1;
      uint16_t EPTXEN:1;
      uint16_t EPRXEN:1;
      uint16_t EPCONDIS:1;
    };
    struct {
      uint16_t :2;
      uint16_t EPINEN:1;
      uint16_t EPOUTEN:1;
    };
  };
} U1EP5BITS;
extern volatile U1EP5BITS U1EP5bits __attribute__((__sfr__));


extern volatile uint16_t U1EP6 __attribute__((__sfr__));
__extension__ typedef struct tagU1EP6BITS {
  union {
    struct {
      uint16_t EPHSHK:1;
      uint16_t EPSTALL:1;
      uint16_t EPTXEN:1;
      uint16_t EPRXEN:1;
      uint16_t EPCONDIS:1;
    };
    struct {
      uint16_t :2;
      uint16_t EPINEN:1;
      uint16_t EPOUTEN:1;
    };
  };
} U1EP6BITS;
extern volatile U1EP6BITS U1EP6bits __attribute__((__sfr__));


extern volatile uint16_t U1EP7 __attribute__((__sfr__));
__extension__ typedef struct tagU1EP7BITS {
  union {
    struct {
      uint16_t EPHSHK:1;
      uint16_t EPSTALL:1;
      uint16_t EPTXEN:1;
      uint16_t EPRXEN:1;
      uint16_t EPCONDIS:1;
    };
    struct {
      uint16_t :2;
      uint16_t EPINEN:1;
      uint16_t EPOUTEN:1;
    };
  };
} U1EP7BITS;
extern volatile U1EP7BITS U1EP7bits __attribute__((__sfr__));


extern volatile uint16_t U1EP8 __attribute__((__sfr__));
__extension__ typedef struct tagU1EP8BITS {
  union {
    struct {
      uint16_t EPHSHK:1;
      uint16_t EPSTALL:1;
      uint16_t EPTXEN:1;
      uint16_t EPRXEN:1;
      uint16_t EPCONDIS:1;
    };
    struct {
      uint16_t :2;
      uint16_t EPINEN:1;
      uint16_t EPOUTEN:1;
    };
  };
} U1EP8BITS;
extern volatile U1EP8BITS U1EP8bits __attribute__((__sfr__));


extern volatile uint16_t U1EP9 __attribute__((__sfr__));
__extension__ typedef struct tagU1EP9BITS {
  union {
    struct {
      uint16_t EPHSHK:1;
      uint16_t EPSTALL:1;
      uint16_t EPTXEN:1;
      uint16_t EPRXEN:1;
      uint16_t EPCONDIS:1;
    };
    struct {
      uint16_t :2;
      uint16_t EPINEN:1;
      uint16_t EPOUTEN:1;
    };
  };
} U1EP9BITS;
extern volatile U1EP9BITS U1EP9bits __attribute__((__sfr__));


extern volatile uint16_t U1EP10 __attribute__((__sfr__));
__extension__ typedef struct tagU1EP10BITS {
  union {
    struct {
      uint16_t EPHSHK:1;
      uint16_t EPSTALL:1;
      uint16_t EPTXEN:1;
      uint16_t EPRXEN:1;
      uint16_t EPCONDIS:1;
    };
    struct {
      uint16_t :2;
      uint16_t EPINEN:1;
      uint16_t EPOUTEN:1;
    };
  };
} U1EP10BITS;
extern volatile U1EP10BITS U1EP10bits __attribute__((__sfr__));


extern volatile uint16_t U1EP11 __attribute__((__sfr__));
__extension__ typedef struct tagU1EP11BITS {
  union {
    struct {
      uint16_t EPHSHK:1;
      uint16_t EPSTALL:1;
      uint16_t EPTXEN:1;
      uint16_t EPRXEN:1;
      uint16_t EPCONDIS:1;
    };
    struct {
      uint16_t :2;
      uint16_t EPINEN:1;
      uint16_t EPOUTEN:1;
    };
  };
} U1EP11BITS;
extern volatile U1EP11BITS U1EP11bits __attribute__((__sfr__));


extern volatile uint16_t U1EP12 __attribute__((__sfr__));
__extension__ typedef struct tagU1EP12BITS {
  union {
    struct {
      uint16_t EPHSHK:1;
      uint16_t EPSTALL:1;
      uint16_t EPTXEN:1;
      uint16_t EPRXEN:1;
      uint16_t EPCONDIS:1;
    };
    struct {
      uint16_t :2;
      uint16_t EPINEN:1;
      uint16_t EPOUTEN:1;
    };
  };
} U1EP12BITS;
extern volatile U1EP12BITS U1EP12bits __attribute__((__sfr__));


extern volatile uint16_t U1EP13 __attribute__((__sfr__));
__extension__ typedef struct tagU1EP13BITS {
  union {
    struct {
      uint16_t EPHSHK:1;
      uint16_t EPSTALL:1;
      uint16_t EPTXEN:1;
      uint16_t EPRXEN:1;
      uint16_t EPCONDIS:1;
    };
    struct {
      uint16_t :2;
      uint16_t EPINEN:1;
      uint16_t EPOUTEN:1;
    };
  };
} U1EP13BITS;
extern volatile U1EP13BITS U1EP13bits __attribute__((__sfr__));


extern volatile uint16_t U1EP14 __attribute__((__sfr__));
__extension__ typedef struct tagU1EP14BITS {
  union {
    struct {
      uint16_t EPHSHK:1;
      uint16_t EPSTALL:1;
      uint16_t EPTXEN:1;
      uint16_t EPRXEN:1;
      uint16_t EPCONDIS:1;
    };
    struct {
      uint16_t :2;
      uint16_t EPINEN:1;
      uint16_t EPOUTEN:1;
    };
  };
} U1EP14BITS;
extern volatile U1EP14BITS U1EP14bits __attribute__((__sfr__));


extern volatile uint16_t U1EP15 __attribute__((__sfr__));
__extension__ typedef struct tagU1EP15BITS {
  union {
    struct {
      uint16_t EPHSHK:1;
      uint16_t EPSTALL:1;
      uint16_t EPTXEN:1;
      uint16_t EPRXEN:1;
      uint16_t EPCONDIS:1;
    };
    struct {
      uint16_t :2;
      uint16_t EPINEN:1;
      uint16_t EPOUTEN:1;
    };
  };
} U1EP15BITS;
extern volatile U1EP15BITS U1EP15bits __attribute__((__sfr__));


extern volatile uint16_t C2CTRL1 __attribute__((__sfr__));
__extension__ typedef struct tagC2CTRL1BITS {
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
} C2CTRL1BITS;
extern volatile C2CTRL1BITS C2CTRL1bits __attribute__((__sfr__));


extern volatile uint16_t C2CTRL2 __attribute__((__sfr__));
__extension__ typedef struct tagC2CTRL2BITS {
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
} C2CTRL2BITS;
extern volatile C2CTRL2BITS C2CTRL2bits __attribute__((__sfr__));


extern volatile uint16_t C2VEC __attribute__((__sfr__));
__extension__ typedef struct tagC2VECBITS {
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
} C2VECBITS;
extern volatile C2VECBITS C2VECbits __attribute__((__sfr__));


extern volatile uint16_t C2FCTRL __attribute__((__sfr__));
__extension__ typedef struct tagC2FCTRLBITS {
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
} C2FCTRLBITS;
extern volatile C2FCTRLBITS C2FCTRLbits __attribute__((__sfr__));


extern volatile uint16_t C2FIFO __attribute__((__sfr__));
__extension__ typedef struct tagC2FIFOBITS {
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
} C2FIFOBITS;
extern volatile C2FIFOBITS C2FIFObits __attribute__((__sfr__));


extern volatile uint16_t C2INTF __attribute__((__sfr__));
typedef struct tagC2INTFBITS {
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
} C2INTFBITS;
extern volatile C2INTFBITS C2INTFbits __attribute__((__sfr__));


extern volatile uint16_t C2INTE __attribute__((__sfr__));
typedef struct tagC2INTEBITS {
  uint16_t TBIE:1;
  uint16_t RBIE:1;
  uint16_t RBOVIE:1;
  uint16_t FIFOIE:1;
  uint16_t :1;
  uint16_t ERRIE:1;
  uint16_t WAKIE:1;
  uint16_t IVRIE:1;
} C2INTEBITS;
extern volatile C2INTEBITS C2INTEbits __attribute__((__sfr__));


extern volatile uint16_t C2EC __attribute__((__sfr__));
typedef struct tagC2ECBITS {
  uint16_t RERRCNT:8;
  uint16_t TERRCNT:8;
} C2ECBITS;
extern volatile C2ECBITS C2ECbits __attribute__((__sfr__));


extern volatile uint8_t C2RERRCNT __attribute__((__sfr__));

extern volatile uint8_t C2TERRCNT __attribute__((__sfr__));

extern volatile uint16_t C2CFG1 __attribute__((__sfr__));
__extension__ typedef struct tagC2CFG1BITS {
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
} C2CFG1BITS;
extern volatile C2CFG1BITS C2CFG1bits __attribute__((__sfr__));


extern volatile uint16_t C2CFG2 __attribute__((__sfr__));
__extension__ typedef struct tagC2CFG2BITS {
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
} C2CFG2BITS;
extern volatile C2CFG2BITS C2CFG2bits __attribute__((__sfr__));


extern volatile uint16_t C2FEN1 __attribute__((__sfr__));
typedef struct tagC2FEN1BITS {
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
} C2FEN1BITS;
extern volatile C2FEN1BITS C2FEN1bits __attribute__((__sfr__));


extern volatile uint16_t C2FMSKSEL1 __attribute__((__sfr__));
__extension__ typedef struct tagC2FMSKSEL1BITS {
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
} C2FMSKSEL1BITS;
extern volatile C2FMSKSEL1BITS C2FMSKSEL1bits __attribute__((__sfr__));


extern volatile uint16_t C2FMSKSEL2 __attribute__((__sfr__));
__extension__ typedef struct tagC2FMSKSEL2BITS {
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
} C2FMSKSEL2BITS;
extern volatile C2FMSKSEL2BITS C2FMSKSEL2bits __attribute__((__sfr__));


extern volatile uint16_t C2BUFPNT1 __attribute__((__sfr__));
__extension__ typedef struct tagC2BUFPNT1BITS {
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
} C2BUFPNT1BITS;
extern volatile C2BUFPNT1BITS C2BUFPNT1bits __attribute__((__sfr__));


extern volatile uint16_t C2RXFUL1 __attribute__((__sfr__));
typedef struct tagC2RXFUL1BITS {
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
} C2RXFUL1BITS;
extern volatile C2RXFUL1BITS C2RXFUL1bits __attribute__((__sfr__));


extern volatile uint16_t C2BUFPNT2 __attribute__((__sfr__));
__extension__ typedef struct tagC2BUFPNT2BITS {
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
} C2BUFPNT2BITS;
extern volatile C2BUFPNT2BITS C2BUFPNT2bits __attribute__((__sfr__));


extern volatile uint16_t C2RXFUL2 __attribute__((__sfr__));
typedef struct tagC2RXFUL2BITS {
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
} C2RXFUL2BITS;
extern volatile C2RXFUL2BITS C2RXFUL2bits __attribute__((__sfr__));


extern volatile uint16_t C2BUFPNT3 __attribute__((__sfr__));
__extension__ typedef struct tagC2BUFPNT3BITS {
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
} C2BUFPNT3BITS;
extern volatile C2BUFPNT3BITS C2BUFPNT3bits __attribute__((__sfr__));


extern volatile uint16_t C2BUFPNT4 __attribute__((__sfr__));
__extension__ typedef struct tagC2BUFPNT4BITS {
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
} C2BUFPNT4BITS;
extern volatile C2BUFPNT4BITS C2BUFPNT4bits __attribute__((__sfr__));


extern volatile uint16_t C2RXOVF1 __attribute__((__sfr__));
typedef struct tagC2RXOVF1BITS {
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
} C2RXOVF1BITS;
extern volatile C2RXOVF1BITS C2RXOVF1bits __attribute__((__sfr__));


extern volatile uint16_t C2RXOVF2 __attribute__((__sfr__));
typedef struct tagC2RXOVF2BITS {
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
} C2RXOVF2BITS;
extern volatile C2RXOVF2BITS C2RXOVF2bits __attribute__((__sfr__));


extern volatile uint16_t C2RXM0SID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXM0SIDBITS {
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
} C2RXM0SIDBITS;
extern volatile C2RXM0SIDBITS C2RXM0SIDbits __attribute__((__sfr__));


extern volatile uint16_t C2TR01CON __attribute__((__sfr__));
__extension__ typedef struct tagC2TR01CONBITS {
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
} C2TR01CONBITS;
extern volatile C2TR01CONBITS C2TR01CONbits __attribute__((__sfr__));


extern volatile uint16_t C2RXM0EID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXM0EIDBITS {
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
} C2RXM0EIDBITS;
extern volatile C2RXM0EIDBITS C2RXM0EIDbits __attribute__((__sfr__));


extern volatile uint16_t C2TR23CON __attribute__((__sfr__));
__extension__ typedef struct tagC2TR23CONBITS {
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
} C2TR23CONBITS;
extern volatile C2TR23CONBITS C2TR23CONbits __attribute__((__sfr__));


extern volatile uint16_t C2RXM1SID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXM1SIDBITS {
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
} C2RXM1SIDBITS;
extern volatile C2RXM1SIDBITS C2RXM1SIDbits __attribute__((__sfr__));


extern volatile uint16_t C2TR45CON __attribute__((__sfr__));
__extension__ typedef struct tagC2TR45CONBITS {
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
} C2TR45CONBITS;
extern volatile C2TR45CONBITS C2TR45CONbits __attribute__((__sfr__));


extern volatile uint16_t C2RXM1EID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXM1EIDBITS {
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
} C2RXM1EIDBITS;
extern volatile C2RXM1EIDBITS C2RXM1EIDbits __attribute__((__sfr__));


extern volatile uint16_t C2TR67CON __attribute__((__sfr__));
__extension__ typedef struct tagC2TR67CONBITS {
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
} C2TR67CONBITS;
extern volatile C2TR67CONBITS C2TR67CONbits __attribute__((__sfr__));


extern volatile uint16_t C2RXM2SID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXM2SIDBITS {
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
} C2RXM2SIDBITS;
extern volatile C2RXM2SIDBITS C2RXM2SIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXM2EID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXM2EIDBITS {
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
} C2RXM2EIDBITS;
extern volatile C2RXM2EIDBITS C2RXM2EIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXD __attribute__((__sfr__));

extern volatile CAN CAN2 __attribute__((__sfr__));


extern volatile uint16_t C2RXF0SID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF0SIDBITS {
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
} C2RXF0SIDBITS;
extern volatile C2RXF0SIDBITS C2RXF0SIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF0EID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF0EIDBITS {
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
} C2RXF0EIDBITS;
extern volatile C2RXF0EIDBITS C2RXF0EIDbits __attribute__((__sfr__));


extern volatile uint16_t C2TXD __attribute__((__sfr__));

extern volatile uint16_t C2RXF1SID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF1SIDBITS {
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
} C2RXF1SIDBITS;
extern volatile C2RXF1SIDBITS C2RXF1SIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF1EID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF1EIDBITS {
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
} C2RXF1EIDBITS;
extern volatile C2RXF1EIDBITS C2RXF1EIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF2SID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF2SIDBITS {
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
} C2RXF2SIDBITS;
extern volatile C2RXF2SIDBITS C2RXF2SIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF2EID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF2EIDBITS {
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
} C2RXF2EIDBITS;
extern volatile C2RXF2EIDBITS C2RXF2EIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF3SID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF3SIDBITS {
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
} C2RXF3SIDBITS;
extern volatile C2RXF3SIDBITS C2RXF3SIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF3EID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF3EIDBITS {
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
} C2RXF3EIDBITS;
extern volatile C2RXF3EIDBITS C2RXF3EIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF4SID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF4SIDBITS {
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
} C2RXF4SIDBITS;
extern volatile C2RXF4SIDBITS C2RXF4SIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF4EID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF4EIDBITS {
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
} C2RXF4EIDBITS;
extern volatile C2RXF4EIDBITS C2RXF4EIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF5SID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF5SIDBITS {
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
} C2RXF5SIDBITS;
extern volatile C2RXF5SIDBITS C2RXF5SIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF5EID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF5EIDBITS {
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
} C2RXF5EIDBITS;
extern volatile C2RXF5EIDBITS C2RXF5EIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF6SID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF6SIDBITS {
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
} C2RXF6SIDBITS;
extern volatile C2RXF6SIDBITS C2RXF6SIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF6EID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF6EIDBITS {
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
} C2RXF6EIDBITS;
extern volatile C2RXF6EIDBITS C2RXF6EIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF7SID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF7SIDBITS {
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
} C2RXF7SIDBITS;
extern volatile C2RXF7SIDBITS C2RXF7SIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF7EID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF7EIDBITS {
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
} C2RXF7EIDBITS;
extern volatile C2RXF7EIDBITS C2RXF7EIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF8SID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF8SIDBITS {
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
} C2RXF8SIDBITS;
extern volatile C2RXF8SIDBITS C2RXF8SIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF8EID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF8EIDBITS {
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
} C2RXF8EIDBITS;
extern volatile C2RXF8EIDBITS C2RXF8EIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF9SID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF9SIDBITS {
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
} C2RXF9SIDBITS;
extern volatile C2RXF9SIDBITS C2RXF9SIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF9EID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF9EIDBITS {
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
} C2RXF9EIDBITS;
extern volatile C2RXF9EIDBITS C2RXF9EIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF10SID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF10SIDBITS {
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
} C2RXF10SIDBITS;
extern volatile C2RXF10SIDBITS C2RXF10SIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF10EID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF10EIDBITS {
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
} C2RXF10EIDBITS;
extern volatile C2RXF10EIDBITS C2RXF10EIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF11SID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF11SIDBITS {
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
} C2RXF11SIDBITS;
extern volatile C2RXF11SIDBITS C2RXF11SIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF11EID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF11EIDBITS {
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
} C2RXF11EIDBITS;
extern volatile C2RXF11EIDBITS C2RXF11EIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF12SID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF12SIDBITS {
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
} C2RXF12SIDBITS;
extern volatile C2RXF12SIDBITS C2RXF12SIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF12EID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF12EIDBITS {
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
} C2RXF12EIDBITS;
extern volatile C2RXF12EIDBITS C2RXF12EIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF13SID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF13SIDBITS {
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
} C2RXF13SIDBITS;
extern volatile C2RXF13SIDBITS C2RXF13SIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF13EID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF13EIDBITS {
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
} C2RXF13EIDBITS;
extern volatile C2RXF13EIDBITS C2RXF13EIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF14SID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF14SIDBITS {
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
} C2RXF14SIDBITS;
extern volatile C2RXF14SIDBITS C2RXF14SIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF14EID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF14EIDBITS {
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
} C2RXF14EIDBITS;
extern volatile C2RXF14EIDBITS C2RXF14EIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF15SID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF15SIDBITS {
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
} C2RXF15SIDBITS;
extern volatile C2RXF15SIDBITS C2RXF15SIDbits __attribute__((__sfr__));


extern volatile uint16_t C2RXF15EID __attribute__((__sfr__));
__extension__ typedef struct tagC2RXF15EIDBITS {
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
} C2RXF15EIDBITS;
extern volatile C2RXF15EIDBITS C2RXF15EIDbits __attribute__((__sfr__));


extern volatile uint16_t U1PWMRRS __attribute__((__sfr__));
typedef struct tagU1PWMRRSBITS {
  uint16_t PER:8;
  uint16_t DC:8;
} U1PWMRRSBITS;
extern volatile U1PWMRRSBITS U1PWMRRSbits __attribute__((__sfr__));


extern volatile uint16_t U1PWMCON __attribute__((__sfr__));
typedef struct tagU1PWMCONBITS {
  uint16_t :8;
  uint16_t CNTEN:1;
  uint16_t PWMPOL:1;
  uint16_t :5;
  uint16_t PWMEN:1;
} U1PWMCONBITS;
extern volatile U1PWMCONBITS U1PWMCONbits __attribute__((__sfr__));


extern volatile uint16_t QEI2CON __attribute__((__sfr__));
typedef struct tagQEI2CONBITS {
  uint16_t CCM:2;
  uint16_t GATEN:1;
  uint16_t CNTPOL:1;
  uint16_t INTDIV:3;
  uint16_t :1;
  uint16_t IMV:2;
  uint16_t PIMOD:3;
  uint16_t QEISIDL:1;
  uint16_t :1;
  uint16_t QEIEN:1;
} QEI2CONBITS;
extern volatile QEI2CONBITS QEI2CONbits __attribute__((__sfr__));


extern volatile uint16_t QEI2IOC __attribute__((__sfr__));
typedef struct tagQEI2IOCBITS {
  uint16_t QEA:1;
  uint16_t QEB:1;
  uint16_t INDEX:1;
  uint16_t HOME:1;
  uint16_t QEAPOL:1;
  uint16_t QEBPOL:1;
  uint16_t IDXPOL:1;
  uint16_t HOMPOL:1;
  uint16_t SWPAB:1;
  uint16_t OUTFNC:2;
  uint16_t QFDIV:3;
  uint16_t FLTREN:1;
  uint16_t QCAPEN:1;
} QEI2IOCBITS;
extern volatile QEI2IOCBITS QEI2IOCbits __attribute__((__sfr__));


extern volatile uint16_t QEI2STAT __attribute__((__sfr__));
typedef struct tagQEI2STATBITS {
  uint16_t IDXIEN:1;
  uint16_t IDXIRQ:1;
  uint16_t HOMIEN:1;
  uint16_t HOMIRQ:1;
  uint16_t VELOVIEN:1;
  uint16_t VELOVIRQ:1;
  uint16_t PCIIEN:1;
  uint16_t PCIIRQ:1;
  uint16_t POSOVIEN:1;
  uint16_t POSOVIRQ:1;
  uint16_t PCLEQIEN:1;
  uint16_t PCLEQIRQ:1;
  uint16_t PCHEQIEN:1;
  uint16_t PCHEQIRQ:1;
} QEI2STATBITS;
extern volatile QEI2STATBITS QEI2STATbits __attribute__((__sfr__));


extern volatile uint16_t POS2CNTL __attribute__((__sfr__));

extern volatile uint16_t POS2CNTH __attribute__((__sfr__));

extern volatile uint16_t POS2HLD __attribute__((__sfr__));

extern volatile uint16_t VEL2CNT __attribute__((__sfr__));

extern volatile uint16_t INT2TMRL __attribute__((__sfr__));

extern volatile uint16_t INT2TMRH __attribute__((__sfr__));

extern volatile uint16_t INT2HLDL __attribute__((__sfr__));

extern volatile uint16_t INT2HLDH __attribute__((__sfr__));

extern volatile uint16_t INDX2CNTL __attribute__((__sfr__));

extern volatile uint16_t INDX2CNTH __attribute__((__sfr__));

extern volatile uint16_t INDX2HLD __attribute__((__sfr__));

extern volatile uint16_t QEI2GECL __attribute__((__sfr__));

extern volatile uint16_t QEI2ICL __attribute__((__sfr__));

extern volatile uint16_t QEI2GECH __attribute__((__sfr__));

extern volatile uint16_t QEI2ICH __attribute__((__sfr__));

extern volatile uint16_t QEI2LECL __attribute__((__sfr__));

extern volatile uint16_t QEI2LECH __attribute__((__sfr__));

extern volatile uint16_t PMCON __attribute__((__sfr__));
__extension__ typedef struct tagPMCONBITS {
  union {
    struct {
      uint16_t RDSP:1;
      uint16_t WRSP:1;
      uint16_t BEP:1;
      uint16_t CS1P:1;
      uint16_t CS2P:1;
      uint16_t ALP:1;
      uint16_t CSF:2;
      uint16_t PTRDEN:1;
      uint16_t PTWREN:1;
      uint16_t PTBEEN:1;
      uint16_t ADRMUX:2;
      uint16_t PSIDL:1;
      uint16_t :1;
      uint16_t PMPEN:1;
    };
    struct {
      uint16_t :6;
      uint16_t CSF0:1;
      uint16_t CSF1:1;
      uint16_t :3;
      uint16_t ADRMUX0:1;
      uint16_t ADRMUX1:1;
    };
  };
} PMCONBITS;
extern volatile PMCONBITS PMCONbits __attribute__((__sfr__));


extern volatile uint16_t PMMODE __attribute__((__sfr__));
__extension__ typedef struct tagPMMODEBITS {
  union {
    struct {
      uint16_t WAITE:2;
      uint16_t WAITM:4;
      uint16_t WAITB:2;
      uint16_t MODE:2;
      uint16_t MODE16:1;
      uint16_t INCM:2;
      uint16_t IRQM:2;
      uint16_t BUSY:1;
    };
    struct {
      uint16_t WAITE0:1;
      uint16_t WAITE1:1;
      uint16_t WAITM0:1;
      uint16_t WAITM1:1;
      uint16_t WAITM2:1;
      uint16_t WAITM3:1;
      uint16_t WAITB0:1;
      uint16_t WAITB1:1;
      uint16_t MODE0:1;
      uint16_t MODE1:1;
      uint16_t :1;
      uint16_t INCM0:1;
      uint16_t INCM1:1;
      uint16_t IRQM0:1;
      uint16_t IRQM1:1;
    };
  };
} PMMODEBITS;
extern volatile PMMODEBITS PMMODEbits __attribute__((__sfr__));


extern volatile uint16_t PMADDR __attribute__((__sfr__));
__extension__ typedef struct tagPMADDRBITS {
  union {
    struct {
      uint16_t ADDR:14;
      uint16_t CS1:1;
      uint16_t CS2:1;
    };
    struct {
      uint16_t ADDR0:1;
      uint16_t ADDR1:1;
      uint16_t ADDR2:1;
      uint16_t ADDR3:1;
      uint16_t ADDR4:1;
      uint16_t ADDR5:1;
      uint16_t ADDR6:1;
      uint16_t ADDR7:1;
      uint16_t ADDR8:1;
      uint16_t ADDR9:1;
      uint16_t ADDR10:1;
      uint16_t ADDR11:1;
      uint16_t ADDR12:1;
      uint16_t ADDR13:1;
    };
  };
} PMADDRBITS;
extern volatile PMADDRBITS PMADDRbits __attribute__((__sfr__));


extern volatile uint16_t PMDOUT1 __attribute__((__sfr__));
__extension__ typedef struct tagPMDOUT1BITS {
  union {
    struct {
      uint16_t ADDR:14;
      uint16_t CS1:1;
      uint16_t CS2:1;
    };
    struct {
      uint16_t ADDR0:1;
      uint16_t ADDR1:1;
      uint16_t ADDR2:1;
      uint16_t ADDR3:1;
      uint16_t ADDR4:1;
      uint16_t ADDR5:1;
      uint16_t ADDR6:1;
      uint16_t ADDR7:1;
      uint16_t ADDR8:1;
      uint16_t ADDR9:1;
      uint16_t ADDR10:1;
      uint16_t ADDR11:1;
      uint16_t ADDR12:1;
      uint16_t ADDR13:1;
    };
  };
} PMDOUT1BITS;
extern volatile PMDOUT1BITS PMDOUT1bits __attribute__((__sfr__));


extern volatile uint16_t PMDOUT2 __attribute__((__sfr__));

extern volatile uint16_t PMDIN1 __attribute__((__sfr__));

extern volatile uint16_t PMDIN2 __attribute__((__sfr__));

extern volatile uint16_t PMAEN __attribute__((__sfr__));
typedef struct tagPMAENBITS {
  uint16_t PTEN0:1;
  uint16_t PTEN1:1;
  uint16_t PTEN2:1;
  uint16_t PTEN3:1;
  uint16_t PTEN4:1;
  uint16_t PTEN5:1;
  uint16_t PTEN6:1;
  uint16_t PTEN7:1;
  uint16_t PTEN8:1;
  uint16_t PTEN9:1;
  uint16_t PTEN10:1;
  uint16_t PTEN11:1;
  uint16_t PTEN12:1;
  uint16_t PTEN13:1;
  uint16_t PTEN14:1;
  uint16_t PTEN15:1;
} PMAENBITS;
extern volatile PMAENBITS PMAENbits __attribute__((__sfr__));


extern volatile uint16_t PMSTAT __attribute__((__sfr__));
typedef struct tagPMSTATBITS {
  uint16_t OB0E:1;
  uint16_t OB1E:1;
  uint16_t OB2E:1;
  uint16_t OB3E:1;
  uint16_t :2;
  uint16_t OBUF:1;
  uint16_t OBE:1;
  uint16_t IB0F:1;
  uint16_t IB1F:1;
  uint16_t IB2F:1;
  uint16_t IB3F:1;
  uint16_t :2;
  uint16_t IBOV:1;
  uint16_t IBF:1;
} PMSTATBITS;
extern volatile PMSTATBITS PMSTATbits __attribute__((__sfr__));


extern volatile uint16_t ALRMVAL __attribute__((__sfr__));

extern volatile uint16_t ALCFGRPT __attribute__((__sfr__));
__extension__ typedef struct tagALCFGRPTBITS {
  union {
    struct {
      uint16_t ARPT:8;
      uint16_t ALRMPTR:2;
      uint16_t AMASK:4;
      uint16_t CHIME:1;
      uint16_t ALRMEN:1;
    };
    struct {
      uint16_t ARPT0:1;
      uint16_t ARPT1:1;
      uint16_t ARPT2:1;
      uint16_t ARPT3:1;
      uint16_t ARPT4:1;
      uint16_t ARPT5:1;
      uint16_t ARPT6:1;
      uint16_t ARPT7:1;
      uint16_t ALRMPTR0:1;
      uint16_t ALRMPTR1:1;
      uint16_t AMASK0:1;
      uint16_t AMASK1:1;
      uint16_t AMASK2:1;
      uint16_t AMASK3:1;
    };
  };
} ALCFGRPTBITS;
extern volatile ALCFGRPTBITS ALCFGRPTbits __attribute__((__sfr__));


extern volatile uint16_t RTCVAL __attribute__((__sfr__));

extern volatile uint16_t RCFGCAL __attribute__((__sfr__));
__extension__ typedef struct tagRCFGCALBITS {
  union {
    struct {
      uint16_t CAL:8;
      uint16_t RTCPTR:2;
      uint16_t RTCOE:1;
      uint16_t HALFSEC:1;
      uint16_t RTCSYNC:1;
      uint16_t RTCWREN:1;
      uint16_t :1;
      uint16_t RTCEN:1;
    };
    struct {
      uint16_t CAL0:1;
      uint16_t CAL1:1;
      uint16_t CAL2:1;
      uint16_t CAL3:1;
      uint16_t CAL4:1;
      uint16_t CAL5:1;
      uint16_t CAL6:1;
      uint16_t CAL7:1;
      uint16_t RTCPTR0:1;
      uint16_t RTCPTR1:1;
    };
  };
} RCFGCALBITS;
extern volatile RCFGCALBITS RCFGCALbits __attribute__((__sfr__));


extern volatile uint16_t CRCCON1 __attribute__((__sfr__));
__extension__ typedef struct tagCRCCON1BITS {
  union {
    struct {
      uint16_t :3;
      uint16_t LENDIAN:1;
      uint16_t CRCGO:1;
      uint16_t CRCISEL:1;
      uint16_t CRCMPT:1;
      uint16_t CRCFUL:1;
      uint16_t VWORD:5;
      uint16_t CSIDL:1;
      uint16_t :1;
      uint16_t CRCEN:1;
    };
    struct {
      uint16_t :8;
      uint16_t VWORD0:1;
      uint16_t VWORD1:1;
      uint16_t VWORD2:1;
      uint16_t VWORD3:1;
      uint16_t VWORD4:1;
    };
  };
} CRCCON1BITS;
extern volatile CRCCON1BITS CRCCON1bits __attribute__((__sfr__));


extern volatile uint16_t CRCCON2 __attribute__((__sfr__));
__extension__ typedef struct tagCRCCON2BITS {
  union {
    struct {
      uint16_t PLEN:5;
      uint16_t :3;
      uint16_t DWIDTH:5;
    };
    struct {
      uint16_t PLEN0:1;
      uint16_t PLEN1:1;
      uint16_t PLEN2:1;
      uint16_t PLEN3:1;
      uint16_t PLEN4:1;
      uint16_t :3;
      uint16_t DWIDTH0:1;
      uint16_t DWIDTH1:1;
      uint16_t DWIDTH2:1;
      uint16_t DWIDTH3:1;
      uint16_t DWIDTH4:1;
    };
  };
} CRCCON2BITS;
extern volatile CRCCON2BITS CRCCON2bits __attribute__((__sfr__));


extern volatile uint16_t CRCXORL __attribute__((__sfr__));
typedef struct tagCRCXORLBITS {
  uint16_t :1;
  uint16_t X1:1;
  uint16_t X2:1;
  uint16_t X3:1;
  uint16_t X4:1;
  uint16_t X5:1;
  uint16_t X6:1;
  uint16_t X7:1;
  uint16_t X8:1;
  uint16_t X9:1;
  uint16_t X10:1;
  uint16_t X11:1;
  uint16_t X12:1;
  uint16_t X13:1;
  uint16_t X14:1;
  uint16_t X15:1;
} CRCXORLBITS;
extern volatile CRCXORLBITS CRCXORLbits __attribute__((__sfr__));


extern volatile uint16_t CRCXORH __attribute__((__sfr__));
typedef struct tagCRCXORHBITS {
  uint16_t X16:1;
  uint16_t X17:1;
  uint16_t X18:1;
  uint16_t X19:1;
  uint16_t X20:1;
  uint16_t X21:1;
  uint16_t X22:1;
  uint16_t X23:1;
  uint16_t X24:1;
  uint16_t X25:1;
  uint16_t X26:1;
  uint16_t X27:1;
  uint16_t X28:1;
  uint16_t X29:1;
  uint16_t X30:1;
  uint16_t X31:1;
} CRCXORHBITS;
extern volatile CRCXORHBITS CRCXORHbits __attribute__((__sfr__));


extern volatile uint16_t CRCDAT __attribute__((__sfr__));

extern volatile uint16_t CRCDATL __attribute__((__sfr__));

extern volatile uint16_t CRCDATH __attribute__((__sfr__));

extern volatile uint16_t CRCWDAT __attribute__((__sfr__));

extern volatile uint16_t CRCWDATL __attribute__((__sfr__));

extern volatile uint16_t CRCWDATH __attribute__((__sfr__));

extern volatile uint16_t RPOR0 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR0BITS {
  union {
    struct {
      uint16_t RP64R:6;
      uint16_t :2;
      uint16_t RP65R:6;
    };
    struct {
      uint16_t RP64R0:1;
      uint16_t RP64R1:1;
      uint16_t RP64R2:1;
      uint16_t RP64R3:1;
      uint16_t RP64R4:1;
      uint16_t RP64R5:1;
      uint16_t :2;
      uint16_t RP65R0:1;
      uint16_t RP65R1:1;
      uint16_t RP65R2:1;
      uint16_t RP65R3:1;
      uint16_t RP65R4:1;
      uint16_t RP65R5:1;
    };
  };
} RPOR0BITS;
extern volatile RPOR0BITS RPOR0bits __attribute__((__sfr__));


extern volatile uint16_t RPOR1 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR1BITS {
  union {
    struct {
      uint16_t RP66R:6;
      uint16_t :2;
      uint16_t RP67R:6;
    };
    struct {
      uint16_t RP66R0:1;
      uint16_t RP66R1:1;
      uint16_t RP66R2:1;
      uint16_t RP66R3:1;
      uint16_t RP66R4:1;
      uint16_t RP66R5:1;
      uint16_t :2;
      uint16_t RP67R0:1;
      uint16_t RP67R1:1;
      uint16_t RP67R2:1;
      uint16_t RP67R3:1;
      uint16_t RP67R4:1;
      uint16_t RP67R5:1;
    };
  };
} RPOR1BITS;
extern volatile RPOR1BITS RPOR1bits __attribute__((__sfr__));


extern volatile uint16_t RPOR2 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR2BITS {
  union {
    struct {
      uint16_t RP68R:6;
      uint16_t :2;
      uint16_t RP69R:6;
    };
    struct {
      uint16_t RP68R0:1;
      uint16_t RP68R1:1;
      uint16_t RP68R2:1;
      uint16_t RP68R3:1;
      uint16_t RP68R4:1;
      uint16_t RP68R5:1;
      uint16_t :2;
      uint16_t RP69R0:1;
      uint16_t RP69R1:1;
      uint16_t RP69R2:1;
      uint16_t RP69R3:1;
      uint16_t RP69R4:1;
      uint16_t RP69R5:1;
    };
  };
} RPOR2BITS;
extern volatile RPOR2BITS RPOR2bits __attribute__((__sfr__));


extern volatile uint16_t RPOR3 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR3BITS {
  union {
    struct {
      uint16_t RP70R:6;
      uint16_t :2;
      uint16_t RP71R:6;
    };
    struct {
      uint16_t RP70R0:1;
      uint16_t RP70R1:1;
      uint16_t RP70R2:1;
      uint16_t RP70R3:1;
      uint16_t RP70R4:1;
      uint16_t RP70R5:1;
      uint16_t :2;
      uint16_t RP71R0:1;
      uint16_t RP71R1:1;
      uint16_t RP71R2:1;
      uint16_t RP71R3:1;
      uint16_t RP71R4:1;
      uint16_t RP71R5:1;
    };
  };
} RPOR3BITS;
extern volatile RPOR3BITS RPOR3bits __attribute__((__sfr__));


extern volatile uint16_t RPOR4 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR4BITS {
  union {
    struct {
      uint16_t RP79R:6;
      uint16_t :2;
      uint16_t RP80R:6;
    };
    struct {
      uint16_t RP79R0:1;
      uint16_t RP79R1:1;
      uint16_t RP79R2:1;
      uint16_t RP79R3:1;
      uint16_t RP79R4:1;
      uint16_t RP79R5:1;
      uint16_t :2;
      uint16_t RP80R0:1;
      uint16_t RP80R1:1;
      uint16_t RP80R2:1;
      uint16_t RP80R3:1;
      uint16_t RP80R4:1;
      uint16_t RP80R5:1;
    };
  };
} RPOR4BITS;
extern volatile RPOR4BITS RPOR4bits __attribute__((__sfr__));


extern volatile uint16_t RPOR5 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR5BITS {
  union {
    struct {
      uint16_t RP82R:6;
      uint16_t :2;
      uint16_t RP84R:6;
    };
    struct {
      uint16_t RP82R0:1;
      uint16_t RP82R1:1;
      uint16_t RP82R2:1;
      uint16_t RP82R3:1;
      uint16_t RP82R4:1;
      uint16_t RP82R5:1;
      uint16_t :2;
      uint16_t RP84R0:1;
      uint16_t RP84R1:1;
      uint16_t RP84R2:1;
      uint16_t RP84R3:1;
      uint16_t RP84R4:1;
      uint16_t RP84R5:1;
    };
  };
} RPOR5BITS;
extern volatile RPOR5BITS RPOR5bits __attribute__((__sfr__));


extern volatile uint16_t RPOR6 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR6BITS {
  union {
    struct {
      uint16_t RP85R:6;
      uint16_t :2;
      uint16_t RP87R:6;
    };
    struct {
      uint16_t RP85R0:1;
      uint16_t RP85R1:1;
      uint16_t RP85R2:1;
      uint16_t RP85R3:1;
      uint16_t RP85R4:1;
      uint16_t RP85R5:1;
      uint16_t :2;
      uint16_t RP87R0:1;
      uint16_t RP87R1:1;
      uint16_t RP87R2:1;
      uint16_t RP87R3:1;
      uint16_t RP87R4:1;
      uint16_t RP87R5:1;
    };
  };
} RPOR6BITS;
extern volatile RPOR6BITS RPOR6bits __attribute__((__sfr__));


extern volatile uint16_t RPOR7 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR7BITS {
  union {
    struct {
      uint16_t RP96R:6;
      uint16_t :2;
      uint16_t RP97R:6;
    };
    struct {
      uint16_t RP96R0:1;
      uint16_t RP96R1:1;
      uint16_t RP96R2:1;
      uint16_t RP96R3:1;
      uint16_t RP96R4:1;
      uint16_t RP96R5:1;
      uint16_t :2;
      uint16_t RP97R0:1;
      uint16_t RP97R1:1;
      uint16_t RP97R2:1;
      uint16_t RP97R3:1;
      uint16_t RP97R4:1;
      uint16_t RP97R5:1;
    };
  };
} RPOR7BITS;
extern volatile RPOR7BITS RPOR7bits __attribute__((__sfr__));


extern volatile uint16_t RPOR8 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR8BITS {
  union {
    struct {
      uint16_t RP98R:6;
      uint16_t :2;
      uint16_t RP99R:6;
    };
    struct {
      uint16_t RP98R0:1;
      uint16_t RP98R1:1;
      uint16_t RP98R2:1;
      uint16_t RP98R3:1;
      uint16_t RP98R4:1;
      uint16_t RP98R5:1;
      uint16_t :2;
      uint16_t RP99R0:1;
      uint16_t RP99R1:1;
      uint16_t RP99R2:1;
      uint16_t RP99R3:1;
      uint16_t RP99R4:1;
      uint16_t RP99R5:1;
    };
  };
} RPOR8BITS;
extern volatile RPOR8BITS RPOR8bits __attribute__((__sfr__));


extern volatile uint16_t RPOR9 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR9BITS {
  union {
    struct {
      uint16_t RP100R:6;
      uint16_t :2;
      uint16_t RP101R:6;
    };
    struct {
      uint16_t RP100R0:1;
      uint16_t RP100R1:1;
      uint16_t RP100R2:1;
      uint16_t RP100R3:1;
      uint16_t RP100R4:1;
      uint16_t RP100R5:1;
      uint16_t :2;
      uint16_t RP101R0:1;
      uint16_t RP101R1:1;
      uint16_t RP101R2:1;
      uint16_t RP101R3:1;
      uint16_t RP101R4:1;
      uint16_t RP101R5:1;
    };
  };
} RPOR9BITS;
extern volatile RPOR9BITS RPOR9bits __attribute__((__sfr__));


extern volatile uint16_t RPOR11 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR11BITS {
  union {
    struct {
      uint16_t RP104R:6;
      uint16_t :2;
      uint16_t RP108R:6;
    };
    struct {
      uint16_t RP104R0:1;
      uint16_t RP104R1:1;
      uint16_t RP104R2:1;
      uint16_t RP104R3:1;
      uint16_t RP104R4:1;
      uint16_t RP104R5:1;
      uint16_t :2;
      uint16_t RP108R0:1;
      uint16_t RP108R1:1;
      uint16_t RP108R2:1;
      uint16_t RP108R3:1;
      uint16_t RP108R4:1;
      uint16_t RP108R5:1;
    };
  };
} RPOR11BITS;
extern volatile RPOR11BITS RPOR11bits __attribute__((__sfr__));


extern volatile uint16_t RPOR12 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR12BITS {
  union {
    struct {
      uint16_t RP109R:6;
      uint16_t :2;
      uint16_t RP112R:6;
    };
    struct {
      uint16_t RP109R0:1;
      uint16_t RP109R1:1;
      uint16_t RP109R2:1;
      uint16_t RP109R3:1;
      uint16_t RP109R4:1;
      uint16_t RP109R5:1;
      uint16_t :2;
      uint16_t RP112R0:1;
      uint16_t RP112R1:1;
      uint16_t RP112R2:1;
      uint16_t RP112R3:1;
      uint16_t RP112R4:1;
      uint16_t RP112R5:1;
    };
  };
} RPOR12BITS;
extern volatile RPOR12BITS RPOR12bits __attribute__((__sfr__));


extern volatile uint16_t RPOR13 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR13BITS {
  union {
    struct {
      uint16_t RP113R:6;
      uint16_t :2;
      uint16_t RP118R:6;
    };
    struct {
      uint16_t RP113R0:1;
      uint16_t RP113R1:1;
      uint16_t RP113R2:1;
      uint16_t RP113R3:1;
      uint16_t RP113R4:1;
      uint16_t RP113R5:1;
      uint16_t :2;
      uint16_t RP118R0:1;
      uint16_t RP118R1:1;
      uint16_t RP118R2:1;
      uint16_t RP118R3:1;
      uint16_t RP118R4:1;
      uint16_t RP118R5:1;
    };
  };
} RPOR13BITS;
extern volatile RPOR13BITS RPOR13bits __attribute__((__sfr__));


extern volatile uint16_t RPOR14 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR14BITS {
  union {
    struct {
      uint16_t RP120R:6;
      uint16_t :2;
      uint16_t RP125R:6;
    };
    struct {
      uint16_t RP120R0:1;
      uint16_t RP120R1:1;
      uint16_t RP120R2:1;
      uint16_t RP120R3:1;
      uint16_t RP120R4:1;
      uint16_t RP120R5:1;
      uint16_t :2;
      uint16_t RP125R0:1;
      uint16_t RP125R1:1;
      uint16_t RP125R2:1;
      uint16_t RP125R3:1;
      uint16_t RP125R4:1;
      uint16_t RP125R5:1;
    };
  };
} RPOR14BITS;
extern volatile RPOR14BITS RPOR14bits __attribute__((__sfr__));


extern volatile uint16_t RPOR15 __attribute__((__sfr__));
__extension__ typedef struct tagRPOR15BITS {
  union {
    struct {
      uint16_t RP126R:6;
      uint16_t :2;
      uint16_t RP127R:6;
    };
    struct {
      uint16_t RP126R0:1;
      uint16_t RP126R1:1;
      uint16_t RP126R2:1;
      uint16_t RP126R3:1;
      uint16_t RP126R4:1;
      uint16_t RP126R5:1;
      uint16_t :2;
      uint16_t RP127R0:1;
      uint16_t RP127R1:1;
      uint16_t RP127R2:1;
      uint16_t RP127R3:1;
      uint16_t RP127R4:1;
      uint16_t RP127R5:1;
    };
  };
} RPOR15BITS;
extern volatile RPOR15BITS RPOR15bits __attribute__((__sfr__));


extern volatile uint16_t RPINR0 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR0BITS {
  union {
    struct {
      uint16_t :8;
      uint16_t INT1R:7;
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
    };
  };
} RPINR0BITS;
extern volatile RPINR0BITS RPINR0bits __attribute__((__sfr__));


extern volatile uint16_t RPINR1 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR1BITS {
  union {
    struct {
      uint16_t INT2R:7;
      uint16_t :1;
      uint16_t INT3R:7;
    };
    struct {
      uint16_t INT2R0:1;
      uint16_t INT2R1:1;
      uint16_t INT2R2:1;
      uint16_t INT2R3:1;
      uint16_t INT2R4:1;
      uint16_t INT2R5:1;
      uint16_t INT2R6:1;
      uint16_t :1;
      uint16_t INT3R0:1;
      uint16_t INT3R1:1;
      uint16_t INT3R2:1;
      uint16_t INT3R3:1;
      uint16_t INT3R4:1;
      uint16_t INT3R5:1;
      uint16_t INT3R6:1;
    };
  };
} RPINR1BITS;
extern volatile RPINR1BITS RPINR1bits __attribute__((__sfr__));


extern volatile uint16_t RPINR2 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR2BITS {
  union {
    struct {
      uint16_t INT4R:7;
      uint16_t :1;
      uint16_t RSVR:7;
    };
    struct {
      uint16_t INT4R0:1;
      uint16_t INT4R1:1;
      uint16_t INT4R2:1;
      uint16_t INT4R3:1;
      uint16_t INT4R4:1;
      uint16_t INT4R5:1;
      uint16_t INT4R6:1;
      uint16_t :1;
      uint16_t RSVR0:1;
      uint16_t RSVR1:1;
      uint16_t RSVR2:1;
      uint16_t RSVR3:1;
      uint16_t RSVR4:1;
      uint16_t RSVR5:1;
      uint16_t RSVR6:1;
    };
  };
} RPINR2BITS;
extern volatile RPINR2BITS RPINR2bits __attribute__((__sfr__));


extern volatile uint16_t RPINR3 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR3BITS {
  union {
    struct {
      uint16_t T2CKR:7;
      uint16_t :1;
      uint16_t T3CKR:7;
    };
    struct {
      uint16_t T2CKR0:1;
      uint16_t T2CKR1:1;
      uint16_t T2CKR2:1;
      uint16_t T2CKR3:1;
      uint16_t T2CKR4:1;
      uint16_t T2CKR5:1;
      uint16_t T2CKR6:1;
      uint16_t :1;
      uint16_t T3CKR0:1;
      uint16_t T3CKR1:1;
      uint16_t T3CKR2:1;
      uint16_t T3CKR3:1;
      uint16_t T3CKR4:1;
      uint16_t T3CKR5:1;
      uint16_t T3CKR6:1;
    };
  };
} RPINR3BITS;
extern volatile RPINR3BITS RPINR3bits __attribute__((__sfr__));


extern volatile uint16_t RPINR4 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR4BITS {
  union {
    struct {
      uint16_t T4CKR:7;
      uint16_t :1;
      uint16_t T5CKR:7;
    };
    struct {
      uint16_t T4CKR0:1;
      uint16_t T4CKR1:1;
      uint16_t T4CKR2:1;
      uint16_t T4CKR3:1;
      uint16_t T4CKR4:1;
      uint16_t T4CKR5:1;
      uint16_t T4CKR6:1;
      uint16_t :1;
      uint16_t T5CKR0:1;
      uint16_t T5CKR1:1;
      uint16_t T5CKR2:1;
      uint16_t T5CKR3:1;
      uint16_t T5CKR4:1;
      uint16_t T5CKR5:1;
      uint16_t T5CKR6:1;
    };
  };
} RPINR4BITS;
extern volatile RPINR4BITS RPINR4bits __attribute__((__sfr__));


extern volatile uint16_t RPINR5 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR5BITS {
  union {
    struct {
      uint16_t T6CKR:7;
      uint16_t :1;
      uint16_t T7CKR:7;
    };
    struct {
      uint16_t T6CKR0:1;
      uint16_t T6CKR1:1;
      uint16_t T6CKR2:1;
      uint16_t T6CKR3:1;
      uint16_t T6CKR4:1;
      uint16_t T6CKR5:1;
      uint16_t T6CKR6:1;
      uint16_t :1;
      uint16_t T7CKR0:1;
      uint16_t T7CKR1:1;
      uint16_t T7CKR2:1;
      uint16_t T7CKR3:1;
      uint16_t T7CKR4:1;
      uint16_t T7CKR5:1;
      uint16_t T7CKR6:1;
    };
  };
} RPINR5BITS;
extern volatile RPINR5BITS RPINR5bits __attribute__((__sfr__));


extern volatile uint16_t RPINR6 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR6BITS {
  union {
    struct {
      uint16_t T8CKR:7;
      uint16_t :1;
      uint16_t T9CKR:7;
    };
    struct {
      uint16_t T8CKR0:1;
      uint16_t T8CKR1:1;
      uint16_t T8CKR2:1;
      uint16_t T8CKR3:1;
      uint16_t T8CKR4:1;
      uint16_t T8CKR5:1;
      uint16_t T8CKR6:1;
      uint16_t :1;
      uint16_t T9CKR0:1;
      uint16_t T9CKR1:1;
      uint16_t T9CKR2:1;
      uint16_t T9CKR3:1;
      uint16_t T9CKR4:1;
      uint16_t T9CKR5:1;
      uint16_t T9CKR6:1;
    };
  };
} RPINR6BITS;
extern volatile RPINR6BITS RPINR6bits __attribute__((__sfr__));


extern volatile uint16_t RPINR7 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR7BITS {
  union {
    struct {
      uint16_t IC1R:7;
      uint16_t :1;
      uint16_t IC2R:7;
    };
    struct {
      uint16_t IC1R0:1;
      uint16_t IC1R1:1;
      uint16_t IC1R2:1;
      uint16_t IC1R3:1;
      uint16_t IC1R4:1;
      uint16_t IC1R5:1;
      uint16_t IC1R6:1;
      uint16_t :1;
      uint16_t IC2R0:1;
      uint16_t IC2R1:1;
      uint16_t IC2R2:1;
      uint16_t IC2R3:1;
      uint16_t IC2R4:1;
      uint16_t IC2R5:1;
      uint16_t IC2R6:1;
    };
  };
} RPINR7BITS;
extern volatile RPINR7BITS RPINR7bits __attribute__((__sfr__));


extern volatile uint16_t RPINR8 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR8BITS {
  union {
    struct {
      uint16_t IC3R:7;
      uint16_t :1;
      uint16_t IC4R:7;
    };
    struct {
      uint16_t IC3R0:1;
      uint16_t IC3R1:1;
      uint16_t IC3R2:1;
      uint16_t IC3R3:1;
      uint16_t IC3R4:1;
      uint16_t IC3R5:1;
      uint16_t IC3R6:1;
      uint16_t :1;
      uint16_t IC4R0:1;
      uint16_t IC4R1:1;
      uint16_t IC4R2:1;
      uint16_t IC4R3:1;
      uint16_t IC4R4:1;
      uint16_t IC4R5:1;
      uint16_t IC4R6:1;
    };
  };
} RPINR8BITS;
extern volatile RPINR8BITS RPINR8bits __attribute__((__sfr__));


extern volatile uint16_t RPINR9 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR9BITS {
  union {
    struct {
      uint16_t IC5R:7;
      uint16_t :1;
      uint16_t IC6R:7;
    };
    struct {
      uint16_t IC5R0:1;
      uint16_t IC5R1:1;
      uint16_t IC5R2:1;
      uint16_t IC5R3:1;
      uint16_t IC5R4:1;
      uint16_t IC5R5:1;
      uint16_t IC5R6:1;
      uint16_t :1;
      uint16_t IC6R0:1;
      uint16_t IC6R1:1;
      uint16_t IC6R2:1;
      uint16_t IC6R3:1;
      uint16_t IC6R4:1;
      uint16_t IC6R5:1;
      uint16_t IC6R6:1;
    };
  };
} RPINR9BITS;
extern volatile RPINR9BITS RPINR9bits __attribute__((__sfr__));


extern volatile uint16_t RPINR10 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR10BITS {
  union {
    struct {
      uint16_t IC7R:7;
      uint16_t :1;
      uint16_t IC8R:7;
    };
    struct {
      uint16_t IC7R0:1;
      uint16_t IC7R1:1;
      uint16_t IC7R2:1;
      uint16_t IC7R3:1;
      uint16_t IC7R4:1;
      uint16_t IC7R5:1;
      uint16_t IC7R6:1;
      uint16_t :1;
      uint16_t IC8R0:1;
      uint16_t IC8R1:1;
      uint16_t IC8R2:1;
      uint16_t IC8R3:1;
      uint16_t IC8R4:1;
      uint16_t IC8R5:1;
      uint16_t IC8R6:1;
    };
  };
} RPINR10BITS;
extern volatile RPINR10BITS RPINR10bits __attribute__((__sfr__));


extern volatile uint16_t RPINR11 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR11BITS {
  union {
    struct {
      uint16_t OCFAR:7;
      uint16_t :1;
      uint16_t OCFBR:7;
    };
    struct {
      uint16_t OCFAR0:1;
      uint16_t OCFAR1:1;
      uint16_t OCFAR2:1;
      uint16_t OCFAR3:1;
      uint16_t OCFAR4:1;
      uint16_t OCFAR5:1;
      uint16_t OCFAR6:1;
      uint16_t :1;
      uint16_t OCFBR0:1;
      uint16_t OCFBR1:1;
      uint16_t OCFBR2:1;
      uint16_t OCFBR3:1;
      uint16_t OCFBR4:1;
      uint16_t OCFBR5:1;
      uint16_t OCFBR6:1;
    };
  };
} RPINR11BITS;
extern volatile RPINR11BITS RPINR11bits __attribute__((__sfr__));


extern volatile uint16_t RPINR12 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR12BITS {
  union {
    struct {
      uint16_t FLT1R:7;
      uint16_t :1;
      uint16_t FLT2R:7;
    };
    struct {
      uint16_t FLT1R0:1;
      uint16_t FLT1R1:1;
      uint16_t FLT1R2:1;
      uint16_t FLT1R3:1;
      uint16_t FLT1R4:1;
      uint16_t FLT1R5:1;
      uint16_t FLT1R6:1;
      uint16_t :1;
      uint16_t FLT2R0:1;
      uint16_t FLT2R1:1;
      uint16_t FLT2R2:1;
      uint16_t FLT2R3:1;
      uint16_t FLT2R4:1;
      uint16_t FLT2R5:1;
      uint16_t FLT2R6:1;
    };
  };
} RPINR12BITS;
extern volatile RPINR12BITS RPINR12bits __attribute__((__sfr__));


extern volatile uint16_t RPINR13 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR13BITS {
  union {
    struct {
      uint16_t FLT3R:7;
      uint16_t :1;
      uint16_t FLT4R:7;
    };
    struct {
      uint16_t FLT3R0:1;
      uint16_t FLT3R1:1;
      uint16_t FLT3R2:1;
      uint16_t FLT3R3:1;
      uint16_t FLT3R4:1;
      uint16_t FLT3R5:1;
      uint16_t FLT3R6:1;
      uint16_t :1;
      uint16_t FLT4R0:1;
      uint16_t FLT4R1:1;
      uint16_t FLT4R2:1;
      uint16_t FLT4R3:1;
      uint16_t FLT4R4:1;
      uint16_t FLT4R5:1;
      uint16_t FLT4R6:1;
    };
  };
} RPINR13BITS;
extern volatile RPINR13BITS RPINR13bits __attribute__((__sfr__));


extern volatile uint16_t RPINR14 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR14BITS {
  union {
    struct {
      uint16_t QEA1R:7;
      uint16_t :1;
      uint16_t QEB1R:7;
    };
    struct {
      uint16_t QEA1R0:1;
      uint16_t QEA1R1:1;
      uint16_t QEA1R2:1;
      uint16_t QEA1R3:1;
      uint16_t QEA1R4:1;
      uint16_t QEA1R5:1;
      uint16_t QEA1R6:1;
      uint16_t :1;
      uint16_t QEB1R0:1;
      uint16_t QEB1R1:1;
      uint16_t QEB1R2:1;
      uint16_t QEB1R3:1;
      uint16_t QEB1R4:1;
      uint16_t QEB1R5:1;
      uint16_t QEB1R6:1;
    };
  };
} RPINR14BITS;
extern volatile RPINR14BITS RPINR14bits __attribute__((__sfr__));


extern volatile uint16_t RPINR15 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR15BITS {
  union {
    struct {
      uint16_t INDX1R:7;
      uint16_t :1;
      uint16_t HOME1R:7;
    };
    struct {
      uint16_t INDX1R0:1;
      uint16_t INDX1R1:1;
      uint16_t INDX1R2:1;
      uint16_t INDX1R3:1;
      uint16_t INDX1R4:1;
      uint16_t INDX1R5:1;
      uint16_t INDX1R6:1;
      uint16_t :1;
      uint16_t HOME1R0:1;
      uint16_t HOME1R1:1;
      uint16_t HOME1R2:1;
      uint16_t HOME1R3:1;
      uint16_t HOME1R4:1;
      uint16_t HOME1R5:1;
      uint16_t HOME1R6:1;
    };
  };
} RPINR15BITS;
extern volatile RPINR15BITS RPINR15bits __attribute__((__sfr__));


extern volatile uint16_t RPINR16 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR16BITS {
  union {
    struct {
      uint16_t QEA2R:7;
      uint16_t :1;
      uint16_t QEB2R:7;
    };
    struct {
      uint16_t QEA2R0:1;
      uint16_t QEA2R1:1;
      uint16_t QEA2R2:1;
      uint16_t QEA2R3:1;
      uint16_t QEA2R4:1;
      uint16_t QEA2R5:1;
      uint16_t QEA2R6:1;
      uint16_t :1;
      uint16_t QEB2R0:1;
      uint16_t QEB2R1:1;
      uint16_t QEB2R2:1;
      uint16_t QEB2R3:1;
      uint16_t QEB2R4:1;
      uint16_t QEB2R5:1;
      uint16_t QEB2R6:1;
    };
  };
} RPINR16BITS;
extern volatile RPINR16BITS RPINR16bits __attribute__((__sfr__));


extern volatile uint16_t RPINR17 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR17BITS {
  union {
    struct {
      uint16_t INDX2R:7;
      uint16_t :1;
      uint16_t HOME2R:7;
    };
    struct {
      uint16_t INDX2R0:1;
      uint16_t INDX2R1:1;
      uint16_t INDX2R2:1;
      uint16_t INDX2R3:1;
      uint16_t INDX2R4:1;
      uint16_t INDX2R5:1;
      uint16_t INDX2R6:1;
      uint16_t :1;
      uint16_t HOME2R0:1;
      uint16_t HOME2R1:1;
      uint16_t HOME2R2:1;
      uint16_t HOME2R3:1;
      uint16_t HOME2R4:1;
      uint16_t HOME2R5:1;
      uint16_t HOME2R6:1;
    };
  };
} RPINR17BITS;
extern volatile RPINR17BITS RPINR17bits __attribute__((__sfr__));


extern volatile uint16_t RPINR18 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR18BITS {
  union {
    struct {
      uint16_t U1RXR:7;
      uint16_t :1;
      uint16_t U1CTSR:7;
    };
    struct {
      uint16_t U1RXR0:1;
      uint16_t U1RXR1:1;
      uint16_t U1RXR2:1;
      uint16_t U1RXR3:1;
      uint16_t U1RXR4:1;
      uint16_t U1RXR5:1;
      uint16_t U1RXR6:1;
      uint16_t :1;
      uint16_t U1CTSR0:1;
      uint16_t U1CTSR1:1;
      uint16_t U1CTSR2:1;
      uint16_t U1CTSR3:1;
      uint16_t U1CTSR4:1;
      uint16_t U1CTSR5:1;
      uint16_t U1CTSR6:1;
    };
  };
} RPINR18BITS;
extern volatile RPINR18BITS RPINR18bits __attribute__((__sfr__));


extern volatile uint16_t RPINR19 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR19BITS {
  union {
    struct {
      uint16_t U2RXR:7;
      uint16_t :1;
      uint16_t U2CTSR:7;
    };
    struct {
      uint16_t U2RXR0:1;
      uint16_t U2RXR1:1;
      uint16_t U2RXR2:1;
      uint16_t U2RXR3:1;
      uint16_t U2RXR4:1;
      uint16_t U2RXR5:1;
      uint16_t U2RXR6:1;
      uint16_t :1;
      uint16_t U2CTSR0:1;
      uint16_t U2CTSR1:1;
      uint16_t U2CTSR2:1;
      uint16_t U2CTSR3:1;
      uint16_t U2CTSR4:1;
      uint16_t U2CTSR5:1;
      uint16_t U2CTSR6:1;
    };
  };
} RPINR19BITS;
extern volatile RPINR19BITS RPINR19bits __attribute__((__sfr__));


extern volatile uint16_t RPINR20 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR20BITS {
  union {
    struct {
      uint16_t SDI1R:7;
      uint16_t :1;
      uint16_t SCK1R:7;
    };
    struct {
      uint16_t SDI1R0:1;
      uint16_t SDI1R1:1;
      uint16_t SDI1R2:1;
      uint16_t SDI1R3:1;
      uint16_t SDI1R4:1;
      uint16_t SDI1R5:1;
      uint16_t SDI1R6:1;
      uint16_t :1;
      uint16_t SCK1R0:1;
      uint16_t SCK1R1:1;
      uint16_t SCK1R2:1;
      uint16_t SCK1R3:1;
      uint16_t SCK1R4:1;
      uint16_t SCK1R5:1;
      uint16_t SCK1R6:1;
    };
  };
} RPINR20BITS;
extern volatile RPINR20BITS RPINR20bits __attribute__((__sfr__));


extern volatile uint16_t RPINR21 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR21BITS {
  union {
    struct {
      uint16_t SS1R:7;
    };
    struct {
      uint16_t SS1R0:1;
      uint16_t SS1R1:1;
      uint16_t SS1R2:1;
      uint16_t SS1R3:1;
      uint16_t SS1R4:1;
      uint16_t SS1R5:1;
      uint16_t SS1R6:1;
    };
  };
} RPINR21BITS;
extern volatile RPINR21BITS RPINR21bits __attribute__((__sfr__));


extern volatile uint16_t RPINR23 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR23BITS {
  union {
    struct {
      uint16_t SS2R:7;
    };
    struct {
      uint16_t SS2R0:1;
      uint16_t SS2R1:1;
      uint16_t SS2R2:1;
      uint16_t SS2R3:1;
      uint16_t SS2R4:1;
      uint16_t SS2R5:1;
      uint16_t SS2R6:1;
    };
  };
} RPINR23BITS;
extern volatile RPINR23BITS RPINR23bits __attribute__((__sfr__));


extern volatile uint16_t RPINR24 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR24BITS {
  union {
    struct {
      uint16_t CSDIR:7;
      uint16_t :1;
      uint16_t CSCKR:7;
    };
    struct {
      uint16_t CSDIR0:1;
      uint16_t CSDIR1:1;
      uint16_t CSDIR2:1;
      uint16_t CSDIR3:1;
      uint16_t CSDIR4:1;
      uint16_t CSDIR5:1;
      uint16_t CSDIR6:1;
      uint16_t :1;
      uint16_t CSCKR0:1;
      uint16_t CSCKR1:1;
      uint16_t CSCKR2:1;
      uint16_t CSCKR3:1;
      uint16_t CSCKR4:1;
      uint16_t CSCKR5:1;
      uint16_t CSCKR6:1;
    };
  };
} RPINR24BITS;
extern volatile RPINR24BITS RPINR24bits __attribute__((__sfr__));


extern volatile uint16_t RPINR25 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR25BITS {
  union {
    struct {
      uint16_t COFSR:7;
    };
    struct {
      uint16_t COFSR0:1;
      uint16_t COFSR1:1;
      uint16_t COFSR2:1;
      uint16_t COFSR3:1;
      uint16_t COFSR4:1;
      uint16_t COFSR5:1;
      uint16_t COFSR6:1;
    };
  };
} RPINR25BITS;
extern volatile RPINR25BITS RPINR25bits __attribute__((__sfr__));


extern volatile uint16_t RPINR26 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR26BITS {
  union {
    struct {
      uint16_t C1RXR:7;
      uint16_t :1;
      uint16_t C2RXR:7;
    };
    struct {
      uint16_t C1RXR0:1;
      uint16_t C1RXR1:1;
      uint16_t C1RXR2:1;
      uint16_t C1RXR3:1;
      uint16_t C1RXR4:1;
      uint16_t C1RXR5:1;
      uint16_t C1RXR6:1;
      uint16_t :1;
      uint16_t C2RXR0:1;
      uint16_t C2RXR1:1;
      uint16_t C2RXR2:1;
      uint16_t C2RXR3:1;
      uint16_t C2RXR4:1;
      uint16_t C2RXR5:1;
      uint16_t C2RXR6:1;
    };
  };
} RPINR26BITS;
extern volatile RPINR26BITS RPINR26bits __attribute__((__sfr__));


extern volatile uint16_t RPINR27 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR27BITS {
  union {
    struct {
      uint16_t U3RXR:7;
      uint16_t :1;
      uint16_t U3CTSR:7;
    };
    struct {
      uint16_t U3RXR0:1;
      uint16_t U3RXR1:1;
      uint16_t U3RXR2:1;
      uint16_t U3RXR3:1;
      uint16_t U3RXR4:1;
      uint16_t U3RXR5:1;
      uint16_t U3RXR6:1;
      uint16_t :1;
      uint16_t U3CTSR0:1;
      uint16_t U3CTSR1:1;
      uint16_t U3CTSR2:1;
      uint16_t U3CTSR3:1;
      uint16_t U3CTSR4:1;
      uint16_t U3CTSR5:1;
      uint16_t U3CTSR6:1;
    };
  };
} RPINR27BITS;
extern volatile RPINR27BITS RPINR27bits __attribute__((__sfr__));


extern volatile uint16_t RPINR28 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR28BITS {
  union {
    struct {
      uint16_t U4RXR:7;
      uint16_t :1;
      uint16_t U4CTSR:7;
    };
    struct {
      uint16_t U4RXR0:1;
      uint16_t U4RXR1:1;
      uint16_t U4RXR2:1;
      uint16_t U4RXR3:1;
      uint16_t U4RXR4:1;
      uint16_t U4RXR5:1;
      uint16_t U4RXR6:1;
      uint16_t :1;
      uint16_t U4CTSR0:1;
      uint16_t U4CTSR1:1;
      uint16_t U4CTSR2:1;
      uint16_t U4CTSR3:1;
      uint16_t U4CTSR4:1;
      uint16_t U4CTSR5:1;
      uint16_t U4CTSR6:1;
    };
  };
} RPINR28BITS;
extern volatile RPINR28BITS RPINR28bits __attribute__((__sfr__));


extern volatile uint16_t RPINR29 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR29BITS {
  union {
    struct {
      uint16_t SDI3R:7;
      uint16_t :1;
      uint16_t SCK3R:7;
    };
    struct {
      uint16_t SDI3R0:1;
      uint16_t SDI3R1:1;
      uint16_t SDI3R2:1;
      uint16_t SDI3R3:1;
      uint16_t SDI3R4:1;
      uint16_t SDI3R5:1;
      uint16_t SDI3R6:1;
      uint16_t :1;
      uint16_t SCK3R0:1;
      uint16_t SCK3R1:1;
      uint16_t SCK3R2:1;
      uint16_t SCK3R3:1;
      uint16_t SCK3R4:1;
      uint16_t SCK3R5:1;
      uint16_t SCK3R6:1;
    };
  };
} RPINR29BITS;
extern volatile RPINR29BITS RPINR29bits __attribute__((__sfr__));


extern volatile uint16_t RPINR30 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR30BITS {
  union {
    struct {
      uint16_t SS3R:7;
    };
    struct {
      uint16_t SS3R0:1;
      uint16_t SS3R1:1;
      uint16_t SS3R2:1;
      uint16_t SS3R3:1;
      uint16_t SS3R4:1;
      uint16_t SS3R5:1;
      uint16_t SS3R6:1;
    };
  };
} RPINR30BITS;
extern volatile RPINR30BITS RPINR30bits __attribute__((__sfr__));


extern volatile uint16_t RPINR31 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR31BITS {
  union {
    struct {
      uint16_t SDI4R:7;
      uint16_t :1;
      uint16_t SCK4R:7;
    };
    struct {
      uint16_t SDI4R0:1;
      uint16_t SDI4R1:1;
      uint16_t SDI4R2:1;
      uint16_t SDI4R3:1;
      uint16_t SDI4R4:1;
      uint16_t SDI4R5:1;
      uint16_t SDI4R6:1;
      uint16_t :1;
      uint16_t SCK4R0:1;
      uint16_t SCK4R1:1;
      uint16_t SCK4R2:1;
      uint16_t SCK4R3:1;
      uint16_t SCK4R4:1;
      uint16_t SCK4R5:1;
      uint16_t SCK4R6:1;
    };
  };
} RPINR31BITS;
extern volatile RPINR31BITS RPINR31bits __attribute__((__sfr__));


extern volatile uint16_t RPINR32 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR32BITS {
  union {
    struct {
      uint16_t SS4R:7;
    };
    struct {
      uint16_t SS4R0:1;
      uint16_t SS4R1:1;
      uint16_t SS4R2:1;
      uint16_t SS4R3:1;
      uint16_t SS4R4:1;
      uint16_t SS4R5:1;
      uint16_t SS4R6:1;
    };
  };
} RPINR32BITS;
extern volatile RPINR32BITS RPINR32bits __attribute__((__sfr__));


extern volatile uint16_t RPINR33 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR33BITS {
  union {
    struct {
      uint16_t IC9R:7;
      uint16_t :1;
      uint16_t IC10R:7;
    };
    struct {
      uint16_t IC9R0:1;
      uint16_t IC9R1:1;
      uint16_t IC9R2:1;
      uint16_t IC9R3:1;
      uint16_t IC9R4:1;
      uint16_t IC9R5:1;
      uint16_t IC9R6:1;
      uint16_t :1;
      uint16_t IC10R0:1;
      uint16_t IC10R1:1;
      uint16_t IC10R2:1;
      uint16_t IC10R3:1;
      uint16_t IC10R4:1;
      uint16_t IC10R5:1;
      uint16_t IC10R6:1;
    };
  };
} RPINR33BITS;
extern volatile RPINR33BITS RPINR33bits __attribute__((__sfr__));


extern volatile uint16_t RPINR34 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR34BITS {
  union {
    struct {
      uint16_t IC11R:7;
      uint16_t :1;
      uint16_t IC12R:7;
    };
    struct {
      uint16_t IC11R0:1;
      uint16_t IC11R1:1;
      uint16_t IC11R2:1;
      uint16_t IC11R3:1;
      uint16_t IC11R4:1;
      uint16_t IC11R5:1;
      uint16_t IC11R6:1;
      uint16_t :1;
      uint16_t IC12R0:1;
      uint16_t IC12R1:1;
      uint16_t IC12R2:1;
      uint16_t IC12R3:1;
      uint16_t IC12R4:1;
      uint16_t IC12R5:1;
      uint16_t IC12R6:1;
    };
  };
} RPINR34BITS;
extern volatile RPINR34BITS RPINR34bits __attribute__((__sfr__));


extern volatile uint16_t RPINR35 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR35BITS {
  union {
    struct {
      uint16_t IC13R:7;
      uint16_t :1;
      uint16_t IC14R:7;
    };
    struct {
      uint16_t IC13R0:1;
      uint16_t IC13R1:1;
      uint16_t IC13R2:1;
      uint16_t IC13R3:1;
      uint16_t IC13R4:1;
      uint16_t IC13R5:1;
      uint16_t IC13R6:1;
      uint16_t :1;
      uint16_t IC14R0:1;
      uint16_t IC14R1:1;
      uint16_t IC14R2:1;
      uint16_t IC14R3:1;
      uint16_t IC14R4:1;
      uint16_t IC14R5:1;
      uint16_t IC14R6:1;
    };
  };
} RPINR35BITS;
extern volatile RPINR35BITS RPINR35bits __attribute__((__sfr__));


extern volatile uint16_t RPINR36 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR36BITS {
  union {
    struct {
      uint16_t IC15R:7;
      uint16_t :1;
      uint16_t IC16R:7;
    };
    struct {
      uint16_t IC15R0:1;
      uint16_t IC15R1:1;
      uint16_t IC15R2:1;
      uint16_t IC15R3:1;
      uint16_t IC15R4:1;
      uint16_t IC15R5:1;
      uint16_t IC15R6:1;
      uint16_t :1;
      uint16_t IC16R0:1;
      uint16_t IC16R1:1;
      uint16_t IC16R2:1;
      uint16_t IC16R3:1;
      uint16_t IC16R4:1;
      uint16_t IC16R5:1;
      uint16_t IC16R6:1;
    };
  };
} RPINR36BITS;
extern volatile RPINR36BITS RPINR36bits __attribute__((__sfr__));


extern volatile uint16_t RPINR37 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR37BITS {
  union {
    struct {
      uint16_t OCFCR:7;
      uint16_t :1;
      uint16_t SYNCI1R:7;
    };
    struct {
      uint16_t OCFCR0:1;
      uint16_t OCFCR1:1;
      uint16_t OCFCR2:1;
      uint16_t OCFCR3:1;
      uint16_t OCFCR4:1;
      uint16_t OCFCR5:1;
      uint16_t OCFCR6:1;
      uint16_t :1;
      uint16_t SYNCI1R0:1;
      uint16_t SYNCI1R1:1;
      uint16_t SYNCI1R2:1;
      uint16_t SYNCI1R3:1;
      uint16_t SYNCI1R4:1;
      uint16_t SYNCI1R5:1;
      uint16_t SYNCI1R6:1;
    };
  };
} RPINR37BITS;
extern volatile RPINR37BITS RPINR37bits __attribute__((__sfr__));


extern volatile uint16_t RPINR38 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR38BITS {
  union {
    struct {
      uint16_t SYNCI2R:7;
      uint16_t :1;
      uint16_t DTCMP1R:7;
    };
    struct {
      uint16_t SYNCI2R0:1;
      uint16_t SYNCI2R1:1;
      uint16_t SYNCI2R2:1;
      uint16_t SYNCI2R3:1;
      uint16_t SYNCI2R4:1;
      uint16_t SYNCI2R5:1;
      uint16_t SYNCI2R6:1;
      uint16_t :1;
      uint16_t DTCMP1R0:1;
      uint16_t DTCMP1R1:1;
      uint16_t DTCMP1R2:1;
      uint16_t DTCMP1R3:1;
      uint16_t DTCMP1R4:1;
      uint16_t DTCMP1R5:1;
      uint16_t DTCMP1R6:1;
    };
  };
} RPINR38BITS;
extern volatile RPINR38BITS RPINR38bits __attribute__((__sfr__));


extern volatile uint16_t RPINR39 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR39BITS {
  union {
    struct {
      uint16_t DTCMP2R:7;
      uint16_t :1;
      uint16_t DTCMP3R:7;
    };
    struct {
      uint16_t DTCMP2R0:1;
      uint16_t DTCMP2R1:1;
      uint16_t DTCMP2R2:1;
      uint16_t DTCMP2R3:1;
      uint16_t DTCMP2R4:1;
      uint16_t DTCMP2R5:1;
      uint16_t DTCMP2R6:1;
      uint16_t :1;
      uint16_t DTCMP3R0:1;
      uint16_t DTCMP3R1:1;
      uint16_t DTCMP3R2:1;
      uint16_t DTCMP3R3:1;
      uint16_t DTCMP3R4:1;
      uint16_t DTCMP3R5:1;
      uint16_t DTCMP3R6:1;
    };
  };
} RPINR39BITS;
extern volatile RPINR39BITS RPINR39bits __attribute__((__sfr__));


extern volatile uint16_t RPINR40 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR40BITS {
  union {
    struct {
      uint16_t DTCMP4R:7;
      uint16_t :1;
      uint16_t DTCMP5R:7;
    };
    struct {
      uint16_t DTCMP4R0:1;
      uint16_t DTCMP4R1:1;
      uint16_t DTCMP4R2:1;
      uint16_t DTCMP4R3:1;
      uint16_t DTCMP4R4:1;
      uint16_t DTCMP4R5:1;
      uint16_t DTCMP4R6:1;
      uint16_t :1;
      uint16_t DTCMP5R0:1;
      uint16_t DTCMP5R1:1;
      uint16_t DTCMP5R2:1;
      uint16_t DTCMP5R3:1;
      uint16_t DTCMP5R4:1;
      uint16_t DTCMP5R5:1;
      uint16_t DTCMP5R6:1;
    };
  };
} RPINR40BITS;
extern volatile RPINR40BITS RPINR40bits __attribute__((__sfr__));


extern volatile uint16_t RPINR41 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR41BITS {
  union {
    struct {
      uint16_t DTCMP6R:7;
    };
    struct {
      uint16_t DTCMP6R0:1;
      uint16_t DTCMP6R1:1;
      uint16_t DTCMP6R2:1;
      uint16_t DTCMP6R3:1;
      uint16_t DTCMP6R4:1;
      uint16_t DTCMP6R5:1;
      uint16_t DTCMP6R6:1;
    };
  };
} RPINR41BITS;
extern volatile RPINR41BITS RPINR41bits __attribute__((__sfr__));


extern volatile uint16_t RPINR42 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR42BITS {
  union {
    struct {
      uint16_t FLT5R:7;
      uint16_t :1;
      uint16_t FLT6R:7;
    };
    struct {
      uint16_t FLT5R0:1;
      uint16_t FLT5R1:1;
      uint16_t FLT5R2:1;
      uint16_t FLT5R3:1;
      uint16_t FLT5R4:1;
      uint16_t FLT5R5:1;
      uint16_t FLT5R6:1;
      uint16_t :1;
      uint16_t FLT6R0:1;
      uint16_t FLT6R1:1;
      uint16_t FLT6R2:1;
      uint16_t FLT6R3:1;
      uint16_t FLT6R4:1;
      uint16_t FLT6R5:1;
      uint16_t FLT6R6:1;
    };
  };
} RPINR42BITS;
extern volatile RPINR42BITS RPINR42bits __attribute__((__sfr__));


extern volatile uint16_t RPINR43 __attribute__((__sfr__));
__extension__ typedef struct tagRPINR43BITS {
  union {
    struct {
      uint16_t FLT7R:7;
    };
    struct {
      uint16_t FLT7R0:1;
      uint16_t FLT7R1:1;
      uint16_t FLT7R2:1;
      uint16_t FLT7R3:1;
      uint16_t FLT7R4:1;
      uint16_t FLT7R5:1;
      uint16_t FLT7R6:1;
    };
  };
} RPINR43BITS;
extern volatile RPINR43BITS RPINR43bits __attribute__((__sfr__));


extern volatile uint16_t NVMCON __attribute__((__sfr__));
__extension__ typedef struct tagNVMCONBITS {
  union {
    struct {
      uint16_t NVMOP:4;
      uint16_t :8;
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
      uint16_t LPOSCEN:1;
      uint16_t :1;
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


extern volatile uint16_t ACLKCON3 __attribute__((__sfr__));
__extension__ typedef struct tagACLKCON3BITS {
  union {
    struct {
      uint16_t APLLPRE:3;
      uint16_t :2;
      uint16_t APLLPOST:3;
      uint16_t :1;
      uint16_t FRCSEL:1;
      uint16_t ASRCSEL:1;
      uint16_t AOSCMD:2;
      uint16_t SELACLK:1;
      uint16_t APLLCK:1;
      uint16_t ENAPLL:1;
    };
    struct {
      uint16_t APPLPRE0:1;
      uint16_t APPLPRE1:1;
      uint16_t APPLPRE2:1;
      uint16_t :2;
      uint16_t APLLPOST0:1;
      uint16_t APLLPOST1:1;
      uint16_t APLLPOST2:1;
      uint16_t :3;
      uint16_t AOSCMD0:1;
      uint16_t AOSCMD1:1;
    };
  };
} ACLKCON3BITS;
extern volatile ACLKCON3BITS ACLKCON3bits __attribute__((__sfr__));


extern volatile uint16_t ACLKDIV3 __attribute__((__sfr__));
__extension__ typedef struct tagACLKDIV3BITS {
  union {
    struct {
      uint16_t APLLDIV:3;
    };
    struct {
      uint16_t APLLDIV0:1;
      uint16_t APLLDIV1:1;
      uint16_t APLLDIV2:1;
    };
  };
} ACLKDIV3BITS;
extern volatile ACLKDIV3BITS ACLKDIV3bits __attribute__((__sfr__));


extern volatile uint16_t PMD1 __attribute__((__sfr__));
typedef struct tagPMD1BITS {
  uint16_t AD1MD:1;
  uint16_t C1MD:1;
  uint16_t C2MD:1;
  uint16_t SPI1MD:1;
  uint16_t SPI2MD:1;
  uint16_t U1MD:1;
  uint16_t U2MD:1;
  uint16_t I2C1MD:1;
  uint16_t DCIMD:1;
  uint16_t PWMMD:1;
  uint16_t QEI1MD:1;
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
  uint16_t OC5MD:1;
  uint16_t OC6MD:1;
  uint16_t OC7MD:1;
  uint16_t OC8MD:1;
  uint16_t IC1MD:1;
  uint16_t IC2MD:1;
  uint16_t IC3MD:1;
  uint16_t IC4MD:1;
  uint16_t IC5MD:1;
  uint16_t IC6MD:1;
  uint16_t IC7MD:1;
  uint16_t IC8MD:1;
} PMD2BITS;
extern volatile PMD2BITS PMD2bits __attribute__((__sfr__));


extern volatile uint16_t PMD3 __attribute__((__sfr__));
typedef struct tagPMD3BITS {
  uint16_t AD2MD:1;
  uint16_t I2C2MD:1;
  uint16_t :1;
  uint16_t U3MD:1;
  uint16_t :1;
  uint16_t QEI2MD:1;
  uint16_t DAC1MD:1;
  uint16_t CRCMD:1;
  uint16_t PMPMD:1;
  uint16_t RTCCMD:1;
  uint16_t CMPMD:1;
  uint16_t :1;
  uint16_t T6MD:1;
  uint16_t T7MD:1;
  uint16_t T8MD:1;
  uint16_t T9MD:1;
} PMD3BITS;
extern volatile PMD3BITS PMD3bits __attribute__((__sfr__));


extern volatile uint16_t PMD4 __attribute__((__sfr__));
typedef struct tagPMD4BITS {
  uint16_t USB1MD:1;
  uint16_t :2;
  uint16_t REFOMD:1;
  uint16_t :1;
  uint16_t U4MD:1;
} PMD4BITS;
extern volatile PMD4BITS PMD4bits __attribute__((__sfr__));


extern volatile uint16_t PMD5 __attribute__((__sfr__));
typedef struct tagPMD5BITS {
  uint16_t OC9MD:1;
  uint16_t OC10MD:1;
  uint16_t OC11MD:1;
  uint16_t OC12MD:1;
  uint16_t OC13MD:1;
  uint16_t OC14MD:1;
  uint16_t OC15MD:1;
  uint16_t OC16MD:1;
  uint16_t IC9MD:1;
  uint16_t IC10MD:1;
  uint16_t IC11MD:1;
  uint16_t IC12MD:1;
  uint16_t IC13MD:1;
  uint16_t IC14MD:1;
  uint16_t IC15MD:1;
  uint16_t IC16MD:1;
} PMD5BITS;
extern volatile PMD5BITS PMD5bits __attribute__((__sfr__));


extern volatile uint16_t PMD6 __attribute__((__sfr__));
typedef struct tagPMD6BITS {
  uint16_t SPI3MD:1;
  uint16_t SPI4MD:1;
  uint16_t :6;
  uint16_t PWM1MD:1;
  uint16_t PWM2MD:1;
  uint16_t PWM3MD:1;
  uint16_t PWM4MD:1;
  uint16_t PWM5MD:1;
  uint16_t PWM6MD:1;
} PMD6BITS;
extern volatile PMD6BITS PMD6bits __attribute__((__sfr__));


extern volatile uint16_t PMD7 __attribute__((__sfr__));
__extension__ typedef struct tagPMD7BITS {
  union {
    struct {
      uint16_t :4;
      uint16_t DMA0MD:1;
      uint16_t DMA4MD:1;
      uint16_t DMA8MD:1;
      uint16_t DMA12MD:1;
    };
    struct {
      uint16_t :4;
      uint16_t DMA1MD:1;
      uint16_t DMA5MD:1;
      uint16_t DMA9MD:1;
      uint16_t DMA13MD:1;
    };
    struct {
      uint16_t :4;
      uint16_t DMA2MD:1;
      uint16_t DMA6MD:1;
      uint16_t DMA10MD:1;
      uint16_t DMA14MD:1;
    };
    struct {
      uint16_t :4;
      uint16_t DMA3MD:1;
      uint16_t DMA7MD:1;
      uint16_t DMA11MD:1;
    };
  };
} PMD7BITS;
extern volatile PMD7BITS PMD7bits __attribute__((__sfr__));


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
typedef struct tagIFS1BITS {
  uint16_t SI2C1IF:1;
  uint16_t MI2C1IF:1;
  uint16_t CMIF:1;
  uint16_t CNIF:1;
  uint16_t INT1IF:1;
  uint16_t AD2IF:1;
  uint16_t IC7IF:1;
  uint16_t IC8IF:1;
  uint16_t DMA2IF:1;
  uint16_t OC3IF:1;
  uint16_t OC4IF:1;
  uint16_t T4IF:1;
  uint16_t T5IF:1;
  uint16_t INT2IF:1;
  uint16_t U2RXIF:1;
  uint16_t U2TXIF:1;
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
  uint16_t IC5IF:1;
  uint16_t IC6IF:1;
  uint16_t OC5IF:1;
  uint16_t OC6IF:1;
  uint16_t OC7IF:1;
  uint16_t OC8IF:1;
  uint16_t PMPIF:1;
  uint16_t DMA4IF:1;
  uint16_t T6IF:1;
} IFS2BITS;
extern volatile IFS2BITS IFS2bits __attribute__((__sfr__));


extern volatile uint16_t IFS3 __attribute__((__sfr__));
typedef struct tagIFS3BITS {
  uint16_t T7IF:1;
  uint16_t SI2C2IF:1;
  uint16_t MI2C2IF:1;
  uint16_t T8IF:1;
  uint16_t T9IF:1;
  uint16_t INT3IF:1;
  uint16_t INT4IF:1;
  uint16_t C2RXIF:1;
  uint16_t C2IF:1;
  uint16_t PSEMIF:1;
  uint16_t QEI1IF:1;
  uint16_t DCIEIF:1;
  uint16_t DCIIF:1;
  uint16_t DMA5IF:1;
  uint16_t RTCIF:1;
} IFS3BITS;
extern volatile IFS3BITS IFS3bits __attribute__((__sfr__));


extern volatile uint16_t IFS4 __attribute__((__sfr__));
typedef struct tagIFS4BITS {
  uint16_t :1;
  uint16_t U1EIF:1;
  uint16_t U2EIF:1;
  uint16_t CRCIF:1;
  uint16_t DMA6IF:1;
  uint16_t DMA7IF:1;
  uint16_t C1TXIF:1;
  uint16_t C2TXIF:1;
  uint16_t :1;
  uint16_t PSESMIF:1;
  uint16_t :1;
  uint16_t QEI2IF:1;
} IFS4BITS;
extern volatile IFS4BITS IFS4bits __attribute__((__sfr__));


extern volatile uint16_t IFS5 __attribute__((__sfr__));
typedef struct tagIFS5BITS {
  uint16_t :1;
  uint16_t U3EIF:1;
  uint16_t U3RXIF:1;
  uint16_t U3TXIF:1;
  uint16_t :2;
  uint16_t USB1IF:1;
  uint16_t U4EIF:1;
  uint16_t U4RXIF:1;
  uint16_t U4TXIF:1;
  uint16_t SPI3EIF:1;
  uint16_t SPI3IF:1;
  uint16_t OC9IF:1;
  uint16_t IC9IF:1;
  uint16_t PWM1IF:1;
  uint16_t PWM2IF:1;
} IFS5BITS;
extern volatile IFS5BITS IFS5bits __attribute__((__sfr__));


extern volatile uint16_t IFS6 __attribute__((__sfr__));
typedef struct tagIFS6BITS {
  uint16_t PWM3IF:1;
  uint16_t PWM4IF:1;
  uint16_t PWM5IF:1;
  uint16_t PWM6IF:1;
} IFS6BITS;
extern volatile IFS6BITS IFS6bits __attribute__((__sfr__));


extern volatile uint16_t IFS7 __attribute__((__sfr__));
typedef struct tagIFS7BITS {
  uint16_t :6;
  uint16_t DMA8IF:1;
  uint16_t DMA9IF:1;
  uint16_t DMA10IF:1;
  uint16_t DMA11IF:1;
  uint16_t SPI4EIF:1;
  uint16_t SPI4IF:1;
  uint16_t OC10IF:1;
  uint16_t IC10IF:1;
  uint16_t OC11IF:1;
  uint16_t IC11IF:1;
} IFS7BITS;
extern volatile IFS7BITS IFS7bits __attribute__((__sfr__));


extern volatile uint16_t IFS8 __attribute__((__sfr__));
typedef struct tagIFS8BITS {
  uint16_t OC12IF:1;
  uint16_t IC12IF:1;
  uint16_t DMA12IF:1;
  uint16_t DMA13IF:1;
  uint16_t DMA14IF:1;
  uint16_t :1;
  uint16_t OC13IF:1;
  uint16_t IC13IF:1;
  uint16_t OC14IF:1;
  uint16_t IC14IF:1;
  uint16_t OC15IF:1;
  uint16_t IC15IF:1;
  uint16_t OC16IF:1;
  uint16_t IC16IF:1;
  uint16_t ICDIF:1;
} IFS8BITS;
extern volatile IFS8BITS IFS8bits __attribute__((__sfr__));


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
typedef struct tagIEC1BITS {
  uint16_t SI2C1IE:1;
  uint16_t MI2C1IE:1;
  uint16_t CMIE:1;
  uint16_t CNIE:1;
  uint16_t INT1IE:1;
  uint16_t AD2IE:1;
  uint16_t IC7IE:1;
  uint16_t IC8IE:1;
  uint16_t DMA2IE:1;
  uint16_t OC3IE:1;
  uint16_t OC4IE:1;
  uint16_t T4IE:1;
  uint16_t T5IE:1;
  uint16_t INT2IE:1;
  uint16_t U2RXIE:1;
  uint16_t U2TXIE:1;
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
  uint16_t IC5IE:1;
  uint16_t IC6IE:1;
  uint16_t OC5IE:1;
  uint16_t OC6IE:1;
  uint16_t OC7IE:1;
  uint16_t OC8IE:1;
  uint16_t PMPIE:1;
  uint16_t DMA4IE:1;
  uint16_t T6IE:1;
} IEC2BITS;
extern volatile IEC2BITS IEC2bits __attribute__((__sfr__));


extern volatile uint16_t IEC3 __attribute__((__sfr__));
typedef struct tagIEC3BITS {
  uint16_t T7IE:1;
  uint16_t SI2C2IE:1;
  uint16_t MI2C2IE:1;
  uint16_t T8IE:1;
  uint16_t T9IE:1;
  uint16_t INT3IE:1;
  uint16_t INT4IE:1;
  uint16_t C2RXIE:1;
  uint16_t C2IE:1;
  uint16_t PSEMIE:1;
  uint16_t QEI1IE:1;
  uint16_t DCIEIE:1;
  uint16_t DCIIE:1;
  uint16_t DMA5IE:1;
  uint16_t RTCIE:1;
} IEC3BITS;
extern volatile IEC3BITS IEC3bits __attribute__((__sfr__));


extern volatile uint16_t IEC4 __attribute__((__sfr__));
typedef struct tagIEC4BITS {
  uint16_t :1;
  uint16_t U1EIE:1;
  uint16_t U2EIE:1;
  uint16_t CRCIE:1;
  uint16_t DMA6IE:1;
  uint16_t DMA7IE:1;
  uint16_t C1TXIE:1;
  uint16_t C2TXIE:1;
  uint16_t :1;
  uint16_t PSESMIE:1;
  uint16_t :1;
  uint16_t QEI2IE:1;
} IEC4BITS;
extern volatile IEC4BITS IEC4bits __attribute__((__sfr__));


extern volatile uint16_t IEC5 __attribute__((__sfr__));
typedef struct tagIEC5BITS {
  uint16_t :1;
  uint16_t U3EIE:1;
  uint16_t U3RXIE:1;
  uint16_t U3TXIE:1;
  uint16_t :2;
  uint16_t USB1IE:1;
  uint16_t U4EIE:1;
  uint16_t U4RXIE:1;
  uint16_t U4TXIE:1;
  uint16_t SPI3EIE:1;
  uint16_t SPI3IE:1;
  uint16_t OC9IE:1;
  uint16_t IC9IE:1;
  uint16_t PWM1IE:1;
  uint16_t PWM2IE:1;
} IEC5BITS;
extern volatile IEC5BITS IEC5bits __attribute__((__sfr__));


extern volatile uint16_t IEC6 __attribute__((__sfr__));
typedef struct tagIEC6BITS {
  uint16_t PWM3IE:1;
  uint16_t PWM4IE:1;
  uint16_t PWM5IE:1;
  uint16_t PWM6IE:1;
} IEC6BITS;
extern volatile IEC6BITS IEC6bits __attribute__((__sfr__));


extern volatile uint16_t IEC7 __attribute__((__sfr__));
typedef struct tagIEC7BITS {
  uint16_t :6;
  uint16_t DMA8IE:1;
  uint16_t DMA9IE:1;
  uint16_t DMA10IE:1;
  uint16_t DMA11IE:1;
  uint16_t SPI4EIE:1;
  uint16_t SPI4IE:1;
  uint16_t OC10IE:1;
  uint16_t IC10IE:1;
  uint16_t OC11IE:1;
  uint16_t IC11IE:1;
} IEC7BITS;
extern volatile IEC7BITS IEC7bits __attribute__((__sfr__));


extern volatile uint16_t IEC8 __attribute__((__sfr__));
typedef struct tagIEC8BITS {
  uint16_t OC12IE:1;
  uint16_t IC12IE:1;
  uint16_t DMA12IE:1;
  uint16_t DMA13IE:1;
  uint16_t DMA14IE:1;
  uint16_t :1;
  uint16_t OC13IE:1;
  uint16_t IC13IE:1;
  uint16_t OC14IE:1;
  uint16_t IC14IE:1;
  uint16_t OC15IE:1;
  uint16_t IC15IE:1;
  uint16_t OC16IE:1;
  uint16_t IC16IE:1;
  uint16_t ICDIF:1;
} IEC8BITS;
extern volatile IEC8BITS IEC8bits __attribute__((__sfr__));


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
  };
} IPC4BITS;
extern volatile IPC4BITS IPC4bits __attribute__((__sfr__));


extern volatile uint16_t IPC5 __attribute__((__sfr__));
__extension__ typedef struct tagIPC5BITS {
  union {
    struct {
      uint16_t INT1IP:3;
      uint16_t :1;
      uint16_t AD2IP:3;
      uint16_t :1;
      uint16_t IC7IP:3;
      uint16_t :1;
      uint16_t IC8IP:3;
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
      uint16_t :1;
      uint16_t IC5IP:3;
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


extern volatile uint16_t IPC10 __attribute__((__sfr__));
__extension__ typedef struct tagIPC10BITS {
  union {
    struct {
      uint16_t IC6IP:3;
      uint16_t :1;
      uint16_t OC5IP:3;
      uint16_t :1;
      uint16_t OC6IP:3;
      uint16_t :1;
      uint16_t OC7IP:3;
    };
    struct {
      uint16_t IC6IP0:1;
      uint16_t IC6IP1:1;
      uint16_t IC6IP2:1;
      uint16_t :1;
      uint16_t OC5IP0:1;
      uint16_t OC5IP1:1;
      uint16_t OC5IP2:1;
      uint16_t :1;
      uint16_t OC6IP0:1;
      uint16_t OC6IP1:1;
      uint16_t OC6IP2:1;
      uint16_t :1;
      uint16_t OC7IP0:1;
      uint16_t OC7IP1:1;
      uint16_t OC7IP2:1;
    };
  };
} IPC10BITS;
extern volatile IPC10BITS IPC10bits __attribute__((__sfr__));


extern volatile uint16_t IPC11 __attribute__((__sfr__));
__extension__ typedef struct tagIPC11BITS {
  union {
    struct {
      uint16_t OC8IP:3;
      uint16_t :1;
      uint16_t PMPIP:3;
      uint16_t :1;
      uint16_t DMA4IP:3;
      uint16_t :1;
      uint16_t T6IP:3;
    };
    struct {
      uint16_t OC8IP0:1;
      uint16_t OC8IP1:1;
      uint16_t OC8IP2:1;
      uint16_t :1;
      uint16_t PMPIP0:1;
      uint16_t PMPIP1:1;
      uint16_t PMPIP2:1;
      uint16_t :1;
      uint16_t DMA4IP0:1;
      uint16_t DMA4IP1:1;
      uint16_t DMA4IP2:1;
      uint16_t :1;
      uint16_t T6IP0:1;
      uint16_t T6IP1:1;
      uint16_t T6IP2:1;
    };
  };
} IPC11BITS;
extern volatile IPC11BITS IPC11bits __attribute__((__sfr__));


extern volatile uint16_t IPC12 __attribute__((__sfr__));
__extension__ typedef struct tagIPC12BITS {
  union {
    struct {
      uint16_t T7IP:3;
      uint16_t :1;
      uint16_t SI2C2IP:3;
      uint16_t :1;
      uint16_t MI2C2IP:3;
      uint16_t :1;
      uint16_t T8IP:3;
    };
    struct {
      uint16_t T7IP0:1;
      uint16_t T7IP1:1;
      uint16_t T7IP2:1;
      uint16_t :1;
      uint16_t SI2C2IP0:1;
      uint16_t SI2C2IP1:1;
      uint16_t SI2C2IP2:1;
      uint16_t :1;
      uint16_t MI2C2IP0:1;
      uint16_t MI2C2IP1:1;
      uint16_t MI2C2IP2:1;
      uint16_t :1;
      uint16_t T8IP0:1;
      uint16_t T8IP1:1;
      uint16_t T8IP2:1;
    };
  };
} IPC12BITS;
extern volatile IPC12BITS IPC12bits __attribute__((__sfr__));


extern volatile uint16_t IPC13 __attribute__((__sfr__));
__extension__ typedef struct tagIPC13BITS {
  union {
    struct {
      uint16_t T9IP:3;
      uint16_t :1;
      uint16_t INT3IP:3;
      uint16_t :1;
      uint16_t INT4IP:3;
      uint16_t :1;
      uint16_t C2RXIP:3;
    };
    struct {
      uint16_t T9IP0:1;
      uint16_t T9IP1:1;
      uint16_t T9IP2:1;
      uint16_t :1;
      uint16_t INT3IP0:1;
      uint16_t INT3IP1:1;
      uint16_t INT3IP2:1;
      uint16_t :1;
      uint16_t INT4IP0:1;
      uint16_t INT4IP1:1;
      uint16_t INT4IP2:1;
      uint16_t :1;
      uint16_t C2RXIP0:1;
      uint16_t C2RXIP1:1;
      uint16_t C2RXIP2:1;
    };
  };
} IPC13BITS;
extern volatile IPC13BITS IPC13bits __attribute__((__sfr__));


extern volatile uint16_t IPC14 __attribute__((__sfr__));
__extension__ typedef struct tagIPC14BITS {
  union {
    struct {
      uint16_t C2IP:3;
      uint16_t :1;
      uint16_t PSEMIP:3;
      uint16_t :1;
      uint16_t QEI1IP:3;
      uint16_t :1;
      uint16_t DCIEIP:3;
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


extern volatile uint16_t IPC15 __attribute__((__sfr__));
__extension__ typedef struct tagIPC15BITS {
  union {
    struct {
      uint16_t DCIIP:3;
      uint16_t :1;
      uint16_t DMA5IP:3;
      uint16_t :1;
      uint16_t RTCIP:3;
    };
    struct {
      uint16_t DCIIP0:1;
      uint16_t DCIIP1:1;
      uint16_t DCIIP2:1;
      uint16_t :1;
      uint16_t DMA5IP0:1;
      uint16_t DMA5IP1:1;
      uint16_t DMA5IP2:1;
      uint16_t :1;
      uint16_t RTCIP0:1;
      uint16_t RTCIP1:1;
      uint16_t RTCIP2:1;
    };
  };
} IPC15BITS;
extern volatile IPC15BITS IPC15bits __attribute__((__sfr__));


extern volatile uint16_t IPC16 __attribute__((__sfr__));
__extension__ typedef struct tagIPC16BITS {
  union {
    struct {
      uint16_t :4;
      uint16_t U1EIP:3;
      uint16_t :1;
      uint16_t U2EIP:3;
      uint16_t :1;
      uint16_t CRCIP:3;
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
      uint16_t DMA6IP:3;
      uint16_t :1;
      uint16_t DMA7IP:3;
      uint16_t :1;
      uint16_t C1TXIP:3;
      uint16_t :1;
      uint16_t C2TXIP:3;
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


extern volatile uint16_t IPC18 __attribute__((__sfr__));
__extension__ typedef struct tagIPC18BITS {
  union {
    struct {
      uint16_t :4;
      uint16_t PSESMIP:3;
      uint16_t :5;
      uint16_t QEI2IP:3;
    };
    struct {
      uint16_t :4;
      uint16_t PSESMIP0:1;
      uint16_t PSESMIP1:1;
      uint16_t PSESMIP2:1;
      uint16_t :5;
      uint16_t QEI2IP0:1;
      uint16_t QEI2IP1:1;
      uint16_t QEI2IP2:1;
    };
  };
} IPC18BITS;
extern volatile IPC18BITS IPC18bits __attribute__((__sfr__));


extern volatile uint16_t IPC20 __attribute__((__sfr__));
__extension__ typedef struct tagIPC20BITS {
  union {
    struct {
      uint16_t :4;
      uint16_t U3EIP:3;
      uint16_t :1;
      uint16_t U3RXIP:3;
      uint16_t :1;
      uint16_t U3TXIP:3;
    };
    struct {
      uint16_t :4;
      uint16_t U3EIP0:1;
      uint16_t U3EIP1:1;
      uint16_t U3EIP2:1;
      uint16_t :1;
      uint16_t U3RXIP0:1;
      uint16_t U3RXIP1:1;
      uint16_t U3RXIP2:1;
      uint16_t :1;
      uint16_t U3TXIP0:1;
      uint16_t U3TXIP1:1;
      uint16_t U3TXIP2:1;
    };
  };
} IPC20BITS;
extern volatile IPC20BITS IPC20bits __attribute__((__sfr__));


extern volatile uint16_t IPC21 __attribute__((__sfr__));
__extension__ typedef struct tagIPC21BITS {
  union {
    struct {
      uint16_t :8;
      uint16_t USB1IP:3;
      uint16_t :1;
      uint16_t U4EIP:3;
    };
    struct {
      uint16_t :8;
      uint16_t USB1IP0:1;
      uint16_t USB1IP1:1;
      uint16_t USB1IP2:1;
      uint16_t :1;
      uint16_t U4EIP0:1;
      uint16_t U4EIP1:1;
      uint16_t U4EIP2:1;
    };
  };
} IPC21BITS;
extern volatile IPC21BITS IPC21bits __attribute__((__sfr__));


extern volatile uint16_t IPC22 __attribute__((__sfr__));
__extension__ typedef struct tagIPC22BITS {
  union {
    struct {
      uint16_t U4RXIP:3;
      uint16_t :1;
      uint16_t U4TXIP:3;
      uint16_t :1;
      uint16_t SPI3EIP:3;
      uint16_t :1;
      uint16_t SPI3IP:3;
    };
    struct {
      uint16_t U4RXIP0:1;
      uint16_t U4RXIP1:1;
      uint16_t U4RXIP2:1;
      uint16_t :1;
      uint16_t U4TXIP0:1;
      uint16_t U4TXIP1:1;
      uint16_t U4TXIP2:1;
      uint16_t :1;
      uint16_t SPI3EIP0:1;
      uint16_t SPI3EIP1:1;
      uint16_t SPI3EIP2:1;
      uint16_t :1;
      uint16_t SPI3IP0:1;
      uint16_t SPI3IP1:1;
      uint16_t SPI3IP2:1;
    };
  };
} IPC22BITS;
extern volatile IPC22BITS IPC22bits __attribute__((__sfr__));


extern volatile uint16_t IPC23 __attribute__((__sfr__));
__extension__ typedef struct tagIPC23BITS {
  union {
    struct {
      uint16_t OC9IP:3;
      uint16_t :1;
      uint16_t IC9IP:3;
      uint16_t :1;
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
      uint16_t :1;
      uint16_t PWM4IP:3;
      uint16_t :1;
      uint16_t PWM5IP:3;
      uint16_t :1;
      uint16_t PWM6IP:3;
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


extern volatile uint16_t IPC29 __attribute__((__sfr__));
__extension__ typedef struct tagIPC29BITS {
  union {
    struct {
      uint16_t :8;
      uint16_t DMA8IP:3;
      uint16_t :1;
      uint16_t DMA9IP:3;
    };
    struct {
      uint16_t :8;
      uint16_t DMA8IP0:1;
      uint16_t DMA8IP1:1;
      uint16_t DMA8IP2:1;
      uint16_t :1;
      uint16_t DMA9IP0:1;
      uint16_t DMA9IP1:1;
      uint16_t DMA9IP2:1;
    };
  };
} IPC29BITS;
extern volatile IPC29BITS IPC29bits __attribute__((__sfr__));


extern volatile uint16_t IPC30 __attribute__((__sfr__));
__extension__ typedef struct tagIPC30BITS {
  union {
    struct {
      uint16_t DMA10IP:3;
      uint16_t :1;
      uint16_t DMA11IP:3;
      uint16_t :1;
      uint16_t SPI4EIP:3;
      uint16_t :1;
      uint16_t SPI4IP:3;
    };
    struct {
      uint16_t DMA10IP0:1;
      uint16_t DMA10IP1:1;
      uint16_t DMA10IP2:1;
      uint16_t :1;
      uint16_t DMA11IP0:1;
      uint16_t DMA11IP1:1;
      uint16_t DMA11IP2:1;
      uint16_t :1;
      uint16_t SPI4EIP0:1;
      uint16_t SPI4EIP1:1;
      uint16_t SPI4EIP2:1;
      uint16_t :1;
      uint16_t SPI4IP0:1;
      uint16_t SPI4IP1:1;
      uint16_t SPI4IP2:1;
    };
  };
} IPC30BITS;
extern volatile IPC30BITS IPC30bits __attribute__((__sfr__));


extern volatile uint16_t IPC31 __attribute__((__sfr__));
__extension__ typedef struct tagIPC31BITS {
  union {
    struct {
      uint16_t OC10IP:3;
      uint16_t :1;
      uint16_t IC10IP:3;
      uint16_t :1;
      uint16_t OC11IP:3;
      uint16_t :1;
      uint16_t IC11IP:3;
    };
    struct {
      uint16_t OC10IP0:1;
      uint16_t OC10IP1:1;
      uint16_t OC10IP2:1;
      uint16_t :1;
      uint16_t IC10IP0:1;
      uint16_t IC10IP1:1;
      uint16_t IC10IP2:1;
      uint16_t :1;
      uint16_t OC11IP0:1;
      uint16_t OC11IP1:1;
      uint16_t OC11IP2:1;
      uint16_t :1;
      uint16_t IC11IP0:1;
      uint16_t IC11IP1:1;
      uint16_t IC11IP2:1;
    };
  };
} IPC31BITS;
extern volatile IPC31BITS IPC31bits __attribute__((__sfr__));


extern volatile uint16_t IPC32 __attribute__((__sfr__));
__extension__ typedef struct tagIPC32BITS {
  union {
    struct {
      uint16_t OC12IP:3;
      uint16_t :1;
      uint16_t IC12IP:3;
      uint16_t :1;
      uint16_t DMA12IP:3;
      uint16_t :1;
      uint16_t DMA13IP:3;
    };
    struct {
      uint16_t OC12IP0:1;
      uint16_t OC12IP1:1;
      uint16_t OC12IP2:1;
      uint16_t :1;
      uint16_t IC12IP0:1;
      uint16_t IC12IP1:1;
      uint16_t IC12IP2:1;
      uint16_t :1;
      uint16_t DMA12IP0:1;
      uint16_t DMA12IP1:1;
      uint16_t DMA12IP2:1;
      uint16_t :1;
      uint16_t DMA13IP0:1;
      uint16_t DMA13IP1:1;
      uint16_t DMA13IP2:1;
    };
  };
} IPC32BITS;
extern volatile IPC32BITS IPC32bits __attribute__((__sfr__));


extern volatile uint16_t IPC33 __attribute__((__sfr__));
__extension__ typedef struct tagIPC33BITS {
  union {
    struct {
      uint16_t DMA14IP:3;
      uint16_t :5;
      uint16_t OC13IP:3;
      uint16_t :1;
      uint16_t IC13IP:3;
    };
    struct {
      uint16_t DMA14IP0:1;
      uint16_t DMA14IP1:1;
      uint16_t DMA14IP2:1;
      uint16_t :5;
      uint16_t OC13IP0:1;
      uint16_t OC13IP1:1;
      uint16_t OC13IP2:1;
      uint16_t :1;
      uint16_t IC13IP0:1;
      uint16_t IC13IP1:1;
      uint16_t IC13IP2:1;
    };
  };
} IPC33BITS;
extern volatile IPC33BITS IPC33bits __attribute__((__sfr__));


extern volatile uint16_t IPC34 __attribute__((__sfr__));
__extension__ typedef struct tagIPC34BITS {
  union {
    struct {
      uint16_t OC14IP:3;
      uint16_t :1;
      uint16_t IC14IP:3;
      uint16_t :1;
      uint16_t OC15IP:3;
      uint16_t :1;
      uint16_t IC15IP:3;
    };
    struct {
      uint16_t OC14IP0:1;
      uint16_t OC14IP1:1;
      uint16_t OC14IP2:1;
      uint16_t :1;
      uint16_t IC14IP0:1;
      uint16_t IC14IP1:1;
      uint16_t IC14IP2:1;
      uint16_t :1;
      uint16_t OC15IP0:1;
      uint16_t OC15IP1:1;
      uint16_t OC15IP2:1;
      uint16_t :1;
      uint16_t IC15IP0:1;
      uint16_t IC15IP1:1;
      uint16_t IC15IP2:1;
    };
  };
} IPC34BITS;
extern volatile IPC34BITS IPC34bits __attribute__((__sfr__));


extern volatile uint16_t IPC35 __attribute__((__sfr__));
__extension__ typedef struct tagIPC35BITS {
  union {
    struct {
      uint16_t OC16IP:3;
      uint16_t :1;
      uint16_t IC16IP:3;
      uint16_t :1;
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
  uint16_t INT3EP:1;
  uint16_t INT4EP:1;
  uint16_t :8;
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
  uint16_t UAE:1;
} INTCON3BITS;
extern volatile INTCON3BITS INTCON3bits __attribute__((__sfr__));


extern volatile uint16_t INTCON4 __attribute__((__sfr__));
typedef struct tagINTCON4BITS {
  uint16_t SGHT:1;
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
      uint16_t OCFLTB:1;
      uint16_t OCFLTC:1;
      uint16_t ENFLTA:1;
      uint16_t ENFLTB:1;
      uint16_t ENFLTC:1;
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
      uint16_t OCFLT1:1;
      uint16_t OCFLT2:1;
      uint16_t ENFLT0:1;
      uint16_t ENFLT1:1;
      uint16_t ENFLT2:1;
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
      uint16_t OCFLTB:1;
      uint16_t OCFLTC:1;
      uint16_t ENFLTA:1;
      uint16_t ENFLTB:1;
      uint16_t ENFLTC:1;
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
      uint16_t OCFLT1:1;
      uint16_t OCFLT2:1;
      uint16_t ENFLT0:1;
      uint16_t ENFLT1:1;
      uint16_t ENFLT2:1;
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
      uint16_t OCFLTB:1;
      uint16_t OCFLTC:1;
      uint16_t ENFLTA:1;
      uint16_t ENFLTB:1;
      uint16_t ENFLTC:1;
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
      uint16_t OCFLT1:1;
      uint16_t OCFLT2:1;
      uint16_t ENFLT0:1;
      uint16_t ENFLT1:1;
      uint16_t ENFLT2:1;
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
      uint16_t OCFLTB:1;
      uint16_t OCFLTC:1;
      uint16_t ENFLTA:1;
      uint16_t ENFLTB:1;
      uint16_t ENFLTC:1;
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
      uint16_t OCFLT1:1;
      uint16_t OCFLT2:1;
      uint16_t ENFLT0:1;
      uint16_t ENFLT1:1;
      uint16_t ENFLT2:1;
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

extern volatile uint16_t OC5CON1 __attribute__((__sfr__));
__extension__ typedef struct tagOC5CON1BITS {
  union {
    struct {
      uint16_t OCM:3;
      uint16_t TRIGMODE:1;
      uint16_t OCFLTA:1;
      uint16_t OCFLTB:1;
      uint16_t OCFLTC:1;
      uint16_t ENFLTA:1;
      uint16_t ENFLTB:1;
      uint16_t ENFLTC:1;
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
      uint16_t OCFLT1:1;
      uint16_t OCFLT2:1;
      uint16_t ENFLT0:1;
      uint16_t ENFLT1:1;
      uint16_t ENFLT2:1;
    };
  };
} OC5CON1BITS;
extern volatile OC5CON1BITS OC5CON1bits __attribute__((__sfr__));


extern volatile uint16_t OC5CON2 __attribute__((__sfr__));
__extension__ typedef struct tagOC5CON2BITS {
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
} OC5CON2BITS;
extern volatile OC5CON2BITS OC5CON2bits __attribute__((__sfr__));



extern volatile uint16_t OC5RS __attribute__((__sfr__));

extern volatile uint16_t OC5R __attribute__((__sfr__));

extern volatile uint16_t OC5TMR __attribute__((__sfr__));

extern volatile uint16_t OC6CON1 __attribute__((__sfr__));
__extension__ typedef struct tagOC6CON1BITS {
  union {
    struct {
      uint16_t OCM:3;
      uint16_t TRIGMODE:1;
      uint16_t OCFLTA:1;
      uint16_t OCFLTB:1;
      uint16_t OCFLTC:1;
      uint16_t ENFLTA:1;
      uint16_t ENFLTB:1;
      uint16_t ENFLTC:1;
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
      uint16_t OCFLT1:1;
      uint16_t OCFLT2:1;
      uint16_t ENFLT0:1;
      uint16_t ENFLT1:1;
      uint16_t ENFLT2:1;
    };
  };
} OC6CON1BITS;
extern volatile OC6CON1BITS OC6CON1bits __attribute__((__sfr__));


extern volatile uint16_t OC6CON2 __attribute__((__sfr__));
__extension__ typedef struct tagOC6CON2BITS {
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
} OC6CON2BITS;
extern volatile OC6CON2BITS OC6CON2bits __attribute__((__sfr__));



extern volatile uint16_t OC6RS __attribute__((__sfr__));

extern volatile uint16_t OC6R __attribute__((__sfr__));

extern volatile uint16_t OC6TMR __attribute__((__sfr__));

extern volatile uint16_t OC7CON1 __attribute__((__sfr__));
__extension__ typedef struct tagOC7CON1BITS {
  union {
    struct {
      uint16_t OCM:3;
      uint16_t TRIGMODE:1;
      uint16_t OCFLTA:1;
      uint16_t OCFLTB:1;
      uint16_t OCFLTC:1;
      uint16_t ENFLTA:1;
      uint16_t ENFLTB:1;
      uint16_t ENFLTC:1;
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
      uint16_t OCFLT1:1;
      uint16_t OCFLT2:1;
      uint16_t ENFLT0:1;
      uint16_t ENFLT1:1;
      uint16_t ENFLT2:1;
    };
  };
} OC7CON1BITS;
extern volatile OC7CON1BITS OC7CON1bits __attribute__((__sfr__));


extern volatile uint16_t OC7CON2 __attribute__((__sfr__));
__extension__ typedef struct tagOC7CON2BITS {
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
} OC7CON2BITS;
extern volatile OC7CON2BITS OC7CON2bits __attribute__((__sfr__));



extern volatile uint16_t OC7RS __attribute__((__sfr__));

extern volatile uint16_t OC7R __attribute__((__sfr__));

extern volatile uint16_t OC7TMR __attribute__((__sfr__));

extern volatile uint16_t OC8CON1 __attribute__((__sfr__));
__extension__ typedef struct tagOC8CON1BITS {
  union {
    struct {
      uint16_t OCM:3;
      uint16_t TRIGMODE:1;
      uint16_t OCFLTA:1;
      uint16_t OCFLTB:1;
      uint16_t OCFLTC:1;
      uint16_t ENFLTA:1;
      uint16_t ENFLTB:1;
      uint16_t ENFLTC:1;
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
      uint16_t OCFLT1:1;
      uint16_t OCFLT2:1;
      uint16_t ENFLT0:1;
      uint16_t ENFLT1:1;
      uint16_t ENFLT2:1;
    };
  };
} OC8CON1BITS;
extern volatile OC8CON1BITS OC8CON1bits __attribute__((__sfr__));


extern volatile uint16_t OC8CON2 __attribute__((__sfr__));
__extension__ typedef struct tagOC8CON2BITS {
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
} OC8CON2BITS;
extern volatile OC8CON2BITS OC8CON2bits __attribute__((__sfr__));



extern volatile uint16_t OC8RS __attribute__((__sfr__));

extern volatile uint16_t OC8R __attribute__((__sfr__));

extern volatile uint16_t OC8TMR __attribute__((__sfr__));

extern volatile uint16_t OC9CON1 __attribute__((__sfr__));
__extension__ typedef struct tagOC9CON1BITS {
  union {
    struct {
      uint16_t OCM:3;
      uint16_t TRIGMODE:1;
      uint16_t OCFLTA:1;
      uint16_t OCFLTB:1;
      uint16_t OCFLTC:1;
      uint16_t ENFLTA:1;
      uint16_t ENFLTB:1;
      uint16_t ENFLTC:1;
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
      uint16_t OCFLT1:1;
      uint16_t OCFLT2:1;
      uint16_t ENFLT0:1;
      uint16_t ENFLT1:1;
      uint16_t ENFLT2:1;
    };
  };
} OC9CON1BITS;
extern volatile OC9CON1BITS OC9CON1bits __attribute__((__sfr__));


extern volatile uint16_t OC9CON2 __attribute__((__sfr__));
__extension__ typedef struct tagOC9CON2BITS {
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
} OC9CON2BITS;
extern volatile OC9CON2BITS OC9CON2bits __attribute__((__sfr__));



extern volatile uint16_t OC9RS __attribute__((__sfr__));

extern volatile uint16_t OC9R __attribute__((__sfr__));

extern volatile uint16_t OC9TMR __attribute__((__sfr__));

extern volatile uint16_t OC10CON1 __attribute__((__sfr__));
__extension__ typedef struct tagOC10CON1BITS {
  union {
    struct {
      uint16_t OCM:3;
      uint16_t TRIGMODE:1;
      uint16_t OCFLTA:1;
      uint16_t OCFLTB:1;
      uint16_t OCFLTC:1;
      uint16_t ENFLTA:1;
      uint16_t ENFLTB:1;
      uint16_t ENFLTC:1;
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
      uint16_t OCFLT1:1;
      uint16_t OCFLT2:1;
      uint16_t ENFLT0:1;
      uint16_t ENFLT1:1;
      uint16_t ENFLT2:1;
    };
  };
} OC10CON1BITS;
extern volatile OC10CON1BITS OC10CON1bits __attribute__((__sfr__));


extern volatile uint16_t OC10CON2 __attribute__((__sfr__));
__extension__ typedef struct tagOC10CON2BITS {
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
} OC10CON2BITS;
extern volatile OC10CON2BITS OC10CON2bits __attribute__((__sfr__));


extern volatile uint16_t OC10RS __attribute__((__sfr__));

extern volatile uint16_t OC10R __attribute__((__sfr__));

extern volatile uint16_t OC10TMR __attribute__((__sfr__));

extern volatile uint16_t OC11CON1 __attribute__((__sfr__));
__extension__ typedef struct tagOC11CON1BITS {
  union {
    struct {
      uint16_t OCM:3;
      uint16_t TRIGMODE:1;
      uint16_t OCFLTA:1;
      uint16_t OCFLTB:1;
      uint16_t OCFLTC:1;
      uint16_t ENFLTA:1;
      uint16_t ENFLTB:1;
      uint16_t ENFLTC:1;
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
      uint16_t OCFLT1:1;
      uint16_t OCFLT2:1;
      uint16_t ENFLT0:1;
      uint16_t ENFLT1:1;
      uint16_t ENFLT2:1;
    };
  };
} OC11CON1BITS;
extern volatile OC11CON1BITS OC11CON1bits __attribute__((__sfr__));


extern volatile uint16_t OC11CON2 __attribute__((__sfr__));
__extension__ typedef struct tagOC11CON2BITS {
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
} OC11CON2BITS;
extern volatile OC11CON2BITS OC11CON2bits __attribute__((__sfr__));


extern volatile uint16_t OC11RS __attribute__((__sfr__));

extern volatile uint16_t OC11R __attribute__((__sfr__));

extern volatile uint16_t OC11TMR __attribute__((__sfr__));

extern volatile uint16_t OC12CON1 __attribute__((__sfr__));
__extension__ typedef struct tagOC12CON1BITS {
  union {
    struct {
      uint16_t OCM:3;
      uint16_t TRIGMODE:1;
      uint16_t OCFLTA:1;
      uint16_t OCFLTB:1;
      uint16_t OCFLTC:1;
      uint16_t ENFLTA:1;
      uint16_t ENFLTB:1;
      uint16_t ENFLTC:1;
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
      uint16_t OCFLT1:1;
      uint16_t OCFLT2:1;
      uint16_t ENFLT0:1;
      uint16_t ENFLT1:1;
      uint16_t ENFLT2:1;
    };
  };
} OC12CON1BITS;
extern volatile OC12CON1BITS OC12CON1bits __attribute__((__sfr__));


extern volatile uint16_t OC12CON2 __attribute__((__sfr__));
__extension__ typedef struct tagOC12CON2BITS {
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
} OC12CON2BITS;
extern volatile OC12CON2BITS OC12CON2bits __attribute__((__sfr__));


extern volatile uint16_t OC12RS __attribute__((__sfr__));

extern volatile uint16_t OC12R __attribute__((__sfr__));

extern volatile uint16_t OC12TMR __attribute__((__sfr__));

extern volatile uint16_t OC13CON1 __attribute__((__sfr__));
__extension__ typedef struct tagOC13CON1BITS {
  union {
    struct {
      uint16_t OCM:3;
      uint16_t TRIGMODE:1;
      uint16_t OCFLTA:1;
      uint16_t OCFLTB:1;
      uint16_t OCFLTC:1;
      uint16_t ENFLTA:1;
      uint16_t ENFLTB:1;
      uint16_t ENFLTC:1;
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
      uint16_t OCFLT1:1;
      uint16_t OCFLT2:1;
      uint16_t ENFLT0:1;
      uint16_t ENFLT1:1;
      uint16_t ENFLT2:1;
    };
  };
} OC13CON1BITS;
extern volatile OC13CON1BITS OC13CON1bits __attribute__((__sfr__));


extern volatile uint16_t OC13CON2 __attribute__((__sfr__));
__extension__ typedef struct tagOC13CON2BITS {
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
} OC13CON2BITS;
extern volatile OC13CON2BITS OC13CON2bits __attribute__((__sfr__));


extern volatile uint16_t OC13RS __attribute__((__sfr__));

extern volatile uint16_t OC13R __attribute__((__sfr__));

extern volatile uint16_t OC13TMR __attribute__((__sfr__));

extern volatile uint16_t OC14CON1 __attribute__((__sfr__));
__extension__ typedef struct tagOC14CON1BITS {
  union {
    struct {
      uint16_t OCM:3;
      uint16_t TRIGMODE:1;
      uint16_t OCFLTA:1;
      uint16_t OCFLTB:1;
      uint16_t OCFLTC:1;
      uint16_t ENFLTA:1;
      uint16_t ENFLTB:1;
      uint16_t ENFLTC:1;
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
      uint16_t OCFLT1:1;
      uint16_t OCFLT2:1;
      uint16_t ENFLT0:1;
      uint16_t ENFLT1:1;
      uint16_t ENFLT2:1;
    };
  };
} OC14CON1BITS;
extern volatile OC14CON1BITS OC14CON1bits __attribute__((__sfr__));


extern volatile uint16_t OC14CON2 __attribute__((__sfr__));
__extension__ typedef struct tagOC14CON2BITS {
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
} OC14CON2BITS;
extern volatile OC14CON2BITS OC14CON2bits __attribute__((__sfr__));


extern volatile uint16_t OC14RS __attribute__((__sfr__));

extern volatile uint16_t OC14R __attribute__((__sfr__));

extern volatile uint16_t OC14TMR __attribute__((__sfr__));

extern volatile uint16_t OC15CON1 __attribute__((__sfr__));
__extension__ typedef struct tagOC15CON1BITS {
  union {
    struct {
      uint16_t OCM:3;
      uint16_t TRIGMODE:1;
      uint16_t OCFLTA:1;
      uint16_t OCFLTB:1;
      uint16_t OCFLTC:1;
      uint16_t ENFLTA:1;
      uint16_t ENFLTB:1;
      uint16_t ENFLTC:1;
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
      uint16_t OCFLT1:1;
      uint16_t OCFLT2:1;
      uint16_t ENFLT0:1;
      uint16_t ENFLT1:1;
      uint16_t ENFLT2:1;
    };
  };
} OC15CON1BITS;
extern volatile OC15CON1BITS OC15CON1bits __attribute__((__sfr__));


extern volatile uint16_t OC15CON2 __attribute__((__sfr__));
__extension__ typedef struct tagOC15CON2BITS {
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
} OC15CON2BITS;
extern volatile OC15CON2BITS OC15CON2bits __attribute__((__sfr__));


extern volatile uint16_t OC15RS __attribute__((__sfr__));

extern volatile uint16_t OC15R __attribute__((__sfr__));

extern volatile uint16_t OC15TMR __attribute__((__sfr__));

extern volatile uint16_t OC16CON1 __attribute__((__sfr__));
__extension__ typedef struct tagOC16CON1BITS {
  union {
    struct {
      uint16_t OCM:3;
      uint16_t TRIGMODE:1;
      uint16_t OCFLTA:1;
      uint16_t OCFLTB:1;
      uint16_t OCFLTC:1;
      uint16_t ENFLTA:1;
      uint16_t ENFLTB:1;
      uint16_t ENFLTC:1;
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
      uint16_t OCFLT1:1;
      uint16_t OCFLT2:1;
      uint16_t ENFLT0:1;
      uint16_t ENFLT1:1;
      uint16_t ENFLT2:1;
    };
  };
} OC16CON1BITS;
extern volatile OC16CON1BITS OC16CON1bits __attribute__((__sfr__));


extern volatile uint16_t OC16CON2 __attribute__((__sfr__));
__extension__ typedef struct tagOC16CON2BITS {
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
} OC16CON2BITS;
extern volatile OC16CON2BITS OC16CON2bits __attribute__((__sfr__));


extern volatile uint16_t OC16RS __attribute__((__sfr__));

extern volatile uint16_t OC16R __attribute__((__sfr__));

extern volatile uint16_t OC16TMR __attribute__((__sfr__));

extern volatile uint16_t CMSTAT __attribute__((__sfr__));
typedef struct tagCMSTATBITS {
  uint16_t C1OUT:1;
  uint16_t C2OUT:1;
  uint16_t C3OUT:1;
  uint16_t :5;
  uint16_t C1EVT:1;
  uint16_t C2EVT:1;
  uint16_t C3EVT:1;
  uint16_t :4;
  uint16_t CMSIDL:1;
} CMSTATBITS;
extern volatile CMSTATBITS CMSTATbits __attribute__((__sfr__));


extern volatile uint16_t CVRCON __attribute__((__sfr__));
__extension__ typedef struct tagCVRCONBITS {
  union {
    struct {
      uint16_t CVR:4;
      uint16_t CVRSS:1;
      uint16_t CVRR:1;
      uint16_t CVROE:1;
      uint16_t CVREN:1;
      uint16_t BGSEL:2;
      uint16_t VREFSEL:1;
    };
    struct {
      uint16_t CVR0:1;
      uint16_t CVR1:1;
      uint16_t CVR2:1;
      uint16_t CVR3:1;
      uint16_t :4;
      uint16_t BGSEL0:1;
      uint16_t BGSEL1:1;
    };
  };
} CVRCONBITS;
extern volatile CVRCONBITS CVRCONbits __attribute__((__sfr__));


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


extern volatile uint16_t DMA4CON __attribute__((__sfr__));
__extension__ typedef struct tagDMA4CONBITS {
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
} DMA4CONBITS;
extern volatile DMA4CONBITS DMA4CONbits __attribute__((__sfr__));


extern volatile uint16_t DMA4REQ __attribute__((__sfr__));
__extension__ typedef struct tagDMA4REQBITS {
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
} DMA4REQBITS;
extern volatile DMA4REQBITS DMA4REQbits __attribute__((__sfr__));


extern volatile uint16_t DMA4STAL __attribute__((__sfr__));

extern volatile uint16_t DMA4STAH __attribute__((__sfr__));
typedef struct tagDMA4STAHBITS {
  uint16_t STA:8;
} DMA4STAHBITS;
extern volatile DMA4STAHBITS DMA4STAHbits __attribute__((__sfr__));


extern volatile uint16_t DMA4STBL __attribute__((__sfr__));

extern volatile uint16_t DMA4STBH __attribute__((__sfr__));
typedef struct tagDMA4STBHBITS {
  uint16_t STB:8;
} DMA4STBHBITS;
extern volatile DMA4STBHBITS DMA4STBHbits __attribute__((__sfr__));


extern volatile uint16_t DMA4PAD __attribute__((__sfr__));

extern volatile uint16_t DMA4CNT __attribute__((__sfr__));
typedef struct tagDMA4CNTBITS {
  uint16_t CNT:14;
} DMA4CNTBITS;
extern volatile DMA4CNTBITS DMA4CNTbits __attribute__((__sfr__));


extern volatile uint16_t DMA5CON __attribute__((__sfr__));
__extension__ typedef struct tagDMA5CONBITS {
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
} DMA5CONBITS;
extern volatile DMA5CONBITS DMA5CONbits __attribute__((__sfr__));


extern volatile uint16_t DMA5REQ __attribute__((__sfr__));
__extension__ typedef struct tagDMA5REQBITS {
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
} DMA5REQBITS;
extern volatile DMA5REQBITS DMA5REQbits __attribute__((__sfr__));


extern volatile uint16_t DMA5STAL __attribute__((__sfr__));

extern volatile uint16_t DMA5STAH __attribute__((__sfr__));
typedef struct tagDMA5STAHBITS {
  uint16_t STA:8;
} DMA5STAHBITS;
extern volatile DMA5STAHBITS DMA5STAHbits __attribute__((__sfr__));


extern volatile uint16_t DMA5STBL __attribute__((__sfr__));

extern volatile uint16_t DMA5STBH __attribute__((__sfr__));
typedef struct tagDMA5STBHBITS {
  uint16_t STB:8;
} DMA5STBHBITS;
extern volatile DMA5STBHBITS DMA5STBHbits __attribute__((__sfr__));


extern volatile uint16_t DMA5PAD __attribute__((__sfr__));

extern volatile uint16_t DMA5CNT __attribute__((__sfr__));
typedef struct tagDMA5CNTBITS {
  uint16_t CNT:14;
} DMA5CNTBITS;
extern volatile DMA5CNTBITS DMA5CNTbits __attribute__((__sfr__));


extern volatile uint16_t DMA6CON __attribute__((__sfr__));
__extension__ typedef struct tagDMA6CONBITS {
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
} DMA6CONBITS;
extern volatile DMA6CONBITS DMA6CONbits __attribute__((__sfr__));


extern volatile uint16_t DMA6REQ __attribute__((__sfr__));
__extension__ typedef struct tagDMA6REQBITS {
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
} DMA6REQBITS;
extern volatile DMA6REQBITS DMA6REQbits __attribute__((__sfr__));


extern volatile uint16_t DMA6STAL __attribute__((__sfr__));

extern volatile uint16_t DMA6STAH __attribute__((__sfr__));
typedef struct tagDMA6STAHBITS {
  uint16_t STA:8;
} DMA6STAHBITS;
extern volatile DMA6STAHBITS DMA6STAHbits __attribute__((__sfr__));


extern volatile uint16_t DMA6STBL __attribute__((__sfr__));

extern volatile uint16_t DMA6STBH __attribute__((__sfr__));
typedef struct tagDMA6STBHBITS {
  uint16_t STB:8;
} DMA6STBHBITS;
extern volatile DMA6STBHBITS DMA6STBHbits __attribute__((__sfr__));


extern volatile uint16_t DMA6PAD __attribute__((__sfr__));

extern volatile uint16_t DMA6CNT __attribute__((__sfr__));
typedef struct tagDMA6CNTBITS {
  uint16_t CNT:14;
} DMA6CNTBITS;
extern volatile DMA6CNTBITS DMA6CNTbits __attribute__((__sfr__));


extern volatile uint16_t DMA7CON __attribute__((__sfr__));
__extension__ typedef struct tagDMA7CONBITS {
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
} DMA7CONBITS;
extern volatile DMA7CONBITS DMA7CONbits __attribute__((__sfr__));


extern volatile uint16_t DMA7REQ __attribute__((__sfr__));
__extension__ typedef struct tagDMA7REQBITS {
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
} DMA7REQBITS;
extern volatile DMA7REQBITS DMA7REQbits __attribute__((__sfr__));


extern volatile uint16_t DMA7STAL __attribute__((__sfr__));

extern volatile uint16_t DMA7STAH __attribute__((__sfr__));
typedef struct tagDMA7STAHBITS {
  uint16_t STA:8;
} DMA7STAHBITS;
extern volatile DMA7STAHBITS DMA7STAHbits __attribute__((__sfr__));


extern volatile uint16_t DMA7STBL __attribute__((__sfr__));

extern volatile uint16_t DMA7STBH __attribute__((__sfr__));
typedef struct tagDMA7STBHBITS {
  uint16_t STB:8;
} DMA7STBHBITS;
extern volatile DMA7STBHBITS DMA7STBHbits __attribute__((__sfr__));


extern volatile uint16_t DMA7PAD __attribute__((__sfr__));

extern volatile uint16_t DMA7CNT __attribute__((__sfr__));
typedef struct tagDMA7CNTBITS {
  uint16_t CNT:14;
} DMA7CNTBITS;
extern volatile DMA7CNTBITS DMA7CNTbits __attribute__((__sfr__));


extern volatile uint16_t DMA8CON __attribute__((__sfr__));
__extension__ typedef struct tagDMA8CONBITS {
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
} DMA8CONBITS;
extern volatile DMA8CONBITS DMA8CONbits __attribute__((__sfr__));


extern volatile uint16_t DMA8REQ __attribute__((__sfr__));
__extension__ typedef struct tagDMA8REQBITS {
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
} DMA8REQBITS;
extern volatile DMA8REQBITS DMA8REQbits __attribute__((__sfr__));


extern volatile uint16_t DMA8STAL __attribute__((__sfr__));

extern volatile uint16_t DMA8STAH __attribute__((__sfr__));
typedef struct tagDMA8STAHBITS {
  uint16_t STA:8;
} DMA8STAHBITS;
extern volatile DMA8STAHBITS DMA8STAHbits __attribute__((__sfr__));


extern volatile uint16_t DMA8STBL __attribute__((__sfr__));

extern volatile uint16_t DMA8STBH __attribute__((__sfr__));
typedef struct tagDMA8STBHBITS {
  uint16_t STB:8;
} DMA8STBHBITS;
extern volatile DMA8STBHBITS DMA8STBHbits __attribute__((__sfr__));


extern volatile uint16_t DMA8PAD __attribute__((__sfr__));

extern volatile uint16_t DMA8CNT __attribute__((__sfr__));
typedef struct tagDMA8CNTBITS {
  uint16_t CNT:14;
} DMA8CNTBITS;
extern volatile DMA8CNTBITS DMA8CNTbits __attribute__((__sfr__));


extern volatile uint16_t DMA9CON __attribute__((__sfr__));
__extension__ typedef struct tagDMA9CONBITS {
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
} DMA9CONBITS;
extern volatile DMA9CONBITS DMA9CONbits __attribute__((__sfr__));


extern volatile uint16_t DMA9REQ __attribute__((__sfr__));
__extension__ typedef struct tagDMA9REQBITS {
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
} DMA9REQBITS;
extern volatile DMA9REQBITS DMA9REQbits __attribute__((__sfr__));


extern volatile uint16_t DMA9STAL __attribute__((__sfr__));

extern volatile uint16_t DMA9STAH __attribute__((__sfr__));
typedef struct tagDMA9STAHBITS {
  uint16_t STA:8;
} DMA9STAHBITS;
extern volatile DMA9STAHBITS DMA9STAHbits __attribute__((__sfr__));


extern volatile uint16_t DMA9STBL __attribute__((__sfr__));

extern volatile uint16_t DMA9STBH __attribute__((__sfr__));
typedef struct tagDMA9STBHBITS {
  uint16_t STB:8;
} DMA9STBHBITS;
extern volatile DMA9STBHBITS DMA9STBHbits __attribute__((__sfr__));


extern volatile uint16_t DMA9PAD __attribute__((__sfr__));

extern volatile uint16_t DMA9CNT __attribute__((__sfr__));
typedef struct tagDMA9CNTBITS {
  uint16_t CNT:14;
} DMA9CNTBITS;
extern volatile DMA9CNTBITS DMA9CNTbits __attribute__((__sfr__));


extern volatile uint16_t DMA10CON __attribute__((__sfr__));
__extension__ typedef struct tagDMA10CONBITS {
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
} DMA10CONBITS;
extern volatile DMA10CONBITS DMA10CONbits __attribute__((__sfr__));


extern volatile uint16_t DMA10REQ __attribute__((__sfr__));
__extension__ typedef struct tagDMA10REQBITS {
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
} DMA10REQBITS;
extern volatile DMA10REQBITS DMA10REQbits __attribute__((__sfr__));


extern volatile uint16_t DMA10STAL __attribute__((__sfr__));

extern volatile uint16_t DMA10STAH __attribute__((__sfr__));
typedef struct tagDMA10STAHBITS {
  uint16_t STA:8;
} DMA10STAHBITS;
extern volatile DMA10STAHBITS DMA10STAHbits __attribute__((__sfr__));


extern volatile uint16_t DMA10STBL __attribute__((__sfr__));

extern volatile uint16_t DMA10STBH __attribute__((__sfr__));
typedef struct tagDMA10STBHBITS {
  uint16_t STB:8;
} DMA10STBHBITS;
extern volatile DMA10STBHBITS DMA10STBHbits __attribute__((__sfr__));


extern volatile uint16_t DMA10PAD __attribute__((__sfr__));

extern volatile uint16_t DMA10CNT __attribute__((__sfr__));
typedef struct tagDMA10CNTBITS {
  uint16_t CNT:14;
} DMA10CNTBITS;
extern volatile DMA10CNTBITS DMA10CNTbits __attribute__((__sfr__));


extern volatile uint16_t DMA11CON __attribute__((__sfr__));
__extension__ typedef struct tagDMA11CONBITS {
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
} DMA11CONBITS;
extern volatile DMA11CONBITS DMA11CONbits __attribute__((__sfr__));


extern volatile uint16_t DMA11REQ __attribute__((__sfr__));
__extension__ typedef struct tagDMA11REQBITS {
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
} DMA11REQBITS;
extern volatile DMA11REQBITS DMA11REQbits __attribute__((__sfr__));


extern volatile uint16_t DMA11STAL __attribute__((__sfr__));

extern volatile uint16_t DMA11STAH __attribute__((__sfr__));
typedef struct tagDMA11STAHBITS {
  uint16_t STA:8;
} DMA11STAHBITS;
extern volatile DMA11STAHBITS DMA11STAHbits __attribute__((__sfr__));


extern volatile uint16_t DMA11STBL __attribute__((__sfr__));

extern volatile uint16_t DMA11STBH __attribute__((__sfr__));
typedef struct tagDMA11STBHBITS {
  uint16_t STB:8;
} DMA11STBHBITS;
extern volatile DMA11STBHBITS DMA11STBHbits __attribute__((__sfr__));


extern volatile uint16_t DMA11PAD __attribute__((__sfr__));

extern volatile uint16_t DMA11CNT __attribute__((__sfr__));
typedef struct tagDMA11CNTBITS {
  uint16_t CNT:14;
} DMA11CNTBITS;
extern volatile DMA11CNTBITS DMA11CNTbits __attribute__((__sfr__));


extern volatile uint16_t DMA12CON __attribute__((__sfr__));
__extension__ typedef struct tagDMA12CONBITS {
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
} DMA12CONBITS;
extern volatile DMA12CONBITS DMA12CONbits __attribute__((__sfr__));


extern volatile uint16_t DMA12REQ __attribute__((__sfr__));
__extension__ typedef struct tagDMA12REQBITS {
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
} DMA12REQBITS;
extern volatile DMA12REQBITS DMA12REQbits __attribute__((__sfr__));


extern volatile uint16_t DMA12STAL __attribute__((__sfr__));

extern volatile uint16_t DMA12STAH __attribute__((__sfr__));
typedef struct tagDMA12STAHBITS {
  uint16_t STA:8;
} DMA12STAHBITS;
extern volatile DMA12STAHBITS DMA12STAHbits __attribute__((__sfr__));


extern volatile uint16_t DMA12STBL __attribute__((__sfr__));

extern volatile uint16_t DMA12STBH __attribute__((__sfr__));
typedef struct tagDMA12STBHBITS {
  uint16_t STB:8;
} DMA12STBHBITS;
extern volatile DMA12STBHBITS DMA12STBHbits __attribute__((__sfr__));


extern volatile uint16_t DMA12PAD __attribute__((__sfr__));

extern volatile uint16_t DMA12CNT __attribute__((__sfr__));
typedef struct tagDMA12CNTBITS {
  uint16_t CNT:14;
} DMA12CNTBITS;
extern volatile DMA12CNTBITS DMA12CNTbits __attribute__((__sfr__));


extern volatile uint16_t DMA13CON __attribute__((__sfr__));
__extension__ typedef struct tagDMA13CONBITS {
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
} DMA13CONBITS;
extern volatile DMA13CONBITS DMA13CONbits __attribute__((__sfr__));


extern volatile uint16_t DMA13REQ __attribute__((__sfr__));
__extension__ typedef struct tagDMA13REQBITS {
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
} DMA13REQBITS;
extern volatile DMA13REQBITS DMA13REQbits __attribute__((__sfr__));


extern volatile uint16_t DMA13STAL __attribute__((__sfr__));

extern volatile uint16_t DMA13STAH __attribute__((__sfr__));
typedef struct tagDMA13STAHBITS {
  uint16_t STA:8;
} DMA13STAHBITS;
extern volatile DMA13STAHBITS DMA13STAHbits __attribute__((__sfr__));


extern volatile uint16_t DMA13STBL __attribute__((__sfr__));

extern volatile uint16_t DMA13STBH __attribute__((__sfr__));
typedef struct tagDMA13STBHBITS {
  uint16_t STB:8;
} DMA13STBHBITS;
extern volatile DMA13STBHBITS DMA13STBHbits __attribute__((__sfr__));


extern volatile uint16_t DMA13PAD __attribute__((__sfr__));

extern volatile uint16_t DMA13CNT __attribute__((__sfr__));
typedef struct tagDMA13CNTBITS {
  uint16_t CNT:14;
} DMA13CNTBITS;
extern volatile DMA13CNTBITS DMA13CNTbits __attribute__((__sfr__));


extern volatile uint16_t DMA14CON __attribute__((__sfr__));
__extension__ typedef struct tagDMA14CONBITS {
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
} DMA14CONBITS;
extern volatile DMA14CONBITS DMA14CONbits __attribute__((__sfr__));


extern volatile uint16_t DMA14REQ __attribute__((__sfr__));
__extension__ typedef struct tagDMA14REQBITS {
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
} DMA14REQBITS;
extern volatile DMA14REQBITS DMA14REQbits __attribute__((__sfr__));


extern volatile uint16_t DMA14STAL __attribute__((__sfr__));

extern volatile uint16_t DMA14STAH __attribute__((__sfr__));
typedef struct tagDMA14STAHBITS {
  uint16_t STA:8;
} DMA14STAHBITS;
extern volatile DMA14STAHBITS DMA14STAHbits __attribute__((__sfr__));


extern volatile uint16_t DMA14STBL __attribute__((__sfr__));

extern volatile uint16_t DMA14STBH __attribute__((__sfr__));
typedef struct tagDMA14STBHBITS {
  uint16_t STB:8;
} DMA14STBHBITS;
extern volatile DMA14STBHBITS DMA14STBHbits __attribute__((__sfr__));


extern volatile uint16_t DMA14PAD __attribute__((__sfr__));

extern volatile uint16_t DMA14CNT __attribute__((__sfr__));
typedef struct tagDMA14CNTBITS {
  uint16_t CNT:14;
} DMA14CNTBITS;
extern volatile DMA14CNTBITS DMA14CNTbits __attribute__((__sfr__));


extern volatile uint16_t DMAPWC __attribute__((__sfr__));
typedef struct tagDMAPWCBITS {
  uint16_t PWCOL0:1;
  uint16_t PWCOL1:1;
  uint16_t PWCOL2:1;
  uint16_t PWCOL3:1;
  uint16_t PWCOL4:1;
  uint16_t PWCOL5:1;
  uint16_t PWCOL6:1;
  uint16_t PWCOL7:1;
  uint16_t PWCOL8:1;
  uint16_t PWCOL9:1;
  uint16_t PWCOL10:1;
  uint16_t PWCOL11:1;
  uint16_t PWCOL12:1;
  uint16_t PWCOL13:1;
  uint16_t PWCOL14:1;
} DMAPWCBITS;
extern volatile DMAPWCBITS DMAPWCbits __attribute__((__sfr__));


extern volatile uint16_t DMARQC __attribute__((__sfr__));
typedef struct tagDMARQCBITS {
  uint16_t RQCOL0:1;
  uint16_t RQCOL1:1;
  uint16_t RQCOL2:1;
  uint16_t RQCOL3:1;
  uint16_t RQCOL4:1;
  uint16_t RQCOL5:1;
  uint16_t RQCOL6:1;
  uint16_t RQCOL7:1;
  uint16_t RQCOL8:1;
  uint16_t RQCOL9:1;
  uint16_t RQCOL10:1;
  uint16_t RQCOL11:1;
  uint16_t RQCOL12:1;
  uint16_t RQCOL13:1;
  uint16_t RQCOL14:1;
} DMARQCBITS;
extern volatile DMARQCBITS DMARQCbits __attribute__((__sfr__));


extern volatile uint16_t DMAPPS __attribute__((__sfr__));
typedef struct tagDMAPPSBITS {
  uint16_t PPST0:1;
  uint16_t PPST1:1;
  uint16_t PPST2:1;
  uint16_t PPST3:1;
  uint16_t PPST4:1;
  uint16_t PPST5:1;
  uint16_t PPST6:1;
  uint16_t PPST7:1;
  uint16_t PPST8:1;
  uint16_t PPST9:1;
  uint16_t PPST10:1;
  uint16_t PPST11:1;
  uint16_t PPST12:1;
  uint16_t PPST13:1;
  uint16_t PPST14:1;
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
typedef struct tagSEVTCMPBITS {
  uint16_t :3;
  uint16_t SEVTCMP:13;
} SEVTCMPBITS;
extern volatile SEVTCMPBITS SEVTCMPbits __attribute__((__sfr__));


extern volatile uint16_t MDC __attribute__((__sfr__));

extern volatile uint16_t STCON __attribute__((__sfr__));
__extension__ typedef struct tagSTCONBITS {
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
} STCONBITS;
extern volatile STCONBITS STCONbits __attribute__((__sfr__));


extern volatile uint16_t STCON2 __attribute__((__sfr__));
__extension__ typedef struct tagSTCON2BITS {
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
} STCON2BITS;
extern volatile STCON2BITS STCON2bits __attribute__((__sfr__));


extern volatile uint16_t STPER __attribute__((__sfr__));

extern volatile uint16_t SSEVTCMP __attribute__((__sfr__));
__extension__ typedef struct tagSSEVTCMPBITS {
  union {
    struct {
      uint16_t :3;
      uint16_t SSEVTCMP:13;
    };
    struct {
      uint16_t :3;
      uint16_t SSEVTCMP0:1;
      uint16_t SSEVTCMP1:1;
      uint16_t SSEVTCMP2:1;
      uint16_t SSEVTCMP3:1;
      uint16_t SSEVTCMP4:1;
      uint16_t SSEVTCMP5:1;
      uint16_t SSEVTCMP6:1;
      uint16_t SSEVTCMP7:1;
      uint16_t SSEVTCMP8:1;
      uint16_t SSEVTCMP9:1;
      uint16_t SSEVTCMP10:1;
      uint16_t SSEVTCMP11:1;
      uint16_t SSEVTCMP12:1;
    };
  };
} SSEVTCMPBITS;
extern volatile SSEVTCMPBITS SSEVTCMPbits __attribute__((__sfr__));


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


extern volatile uint16_t PWMCON1 __attribute__((__sfr__));
__extension__ typedef struct tagPWMCON1BITS {
  union {
    struct {
      uint16_t IUE:1;
      uint16_t XPRES:1;
      uint16_t CAM:1;
      uint16_t MTBS:1;
      uint16_t :1;
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

extern volatile uint16_t SDC1 __attribute__((__sfr__));

extern volatile uint16_t SPHASE1 __attribute__((__sfr__));

extern volatile uint16_t TRIG1 __attribute__((__sfr__));
__extension__ typedef struct tagTRIG1BITS {
  union {
    struct {
      uint16_t :3;
      uint16_t TRGCMP:13;
    };
    struct {
      uint16_t :3;
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
      uint16_t MTBS:1;
      uint16_t :1;
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

extern volatile uint16_t SDC2 __attribute__((__sfr__));

extern volatile uint16_t SPHASE2 __attribute__((__sfr__));

extern volatile uint16_t TRIG2 __attribute__((__sfr__));
__extension__ typedef struct tagTRIG2BITS {
  union {
    struct {
      uint16_t :3;
      uint16_t TRGCMP:13;
    };
    struct {
      uint16_t :3;
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
      uint16_t MTBS:1;
      uint16_t :1;
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

extern volatile uint16_t SDC3 __attribute__((__sfr__));

extern volatile uint16_t SPHASE3 __attribute__((__sfr__));

extern volatile uint16_t TRIG3 __attribute__((__sfr__));
__extension__ typedef struct tagTRIG3BITS {
  union {
    struct {
      uint16_t :3;
      uint16_t TRGCMP:13;
    };
    struct {
      uint16_t :3;
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


extern volatile uint16_t PWMCON4 __attribute__((__sfr__));
__extension__ typedef struct tagPWMCON4BITS {
  union {
    struct {
      uint16_t IUE:1;
      uint16_t XPRES:1;
      uint16_t CAM:1;
      uint16_t MTBS:1;
      uint16_t :1;
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
} PWMCON4BITS;
extern volatile PWMCON4BITS PWMCON4bits __attribute__((__sfr__));


extern volatile uint16_t IOCON4 __attribute__((__sfr__));
__extension__ typedef struct tagIOCON4BITS {
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
} IOCON4BITS;
extern volatile IOCON4BITS IOCON4bits __attribute__((__sfr__));


extern volatile uint16_t FCLCON4 __attribute__((__sfr__));
__extension__ typedef struct tagFCLCON4BITS {
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
} FCLCON4BITS;
extern volatile FCLCON4BITS FCLCON4bits __attribute__((__sfr__));


extern volatile uint16_t PDC4 __attribute__((__sfr__));

extern volatile uint16_t PHASE4 __attribute__((__sfr__));

extern volatile uint16_t DTR4 __attribute__((__sfr__));

extern volatile uint16_t ALTDTR4 __attribute__((__sfr__));

extern volatile uint16_t SDC4 __attribute__((__sfr__));

extern volatile uint16_t SPHASE4 __attribute__((__sfr__));

extern volatile uint16_t TRIG4 __attribute__((__sfr__));
__extension__ typedef struct tagTRIG4BITS {
  union {
    struct {
      uint16_t :3;
      uint16_t TRGCMP:13;
    };
    struct {
      uint16_t :3;
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
    };
  };
} TRIG4BITS;
extern volatile TRIG4BITS TRIG4bits __attribute__((__sfr__));


extern volatile uint16_t TRGCON4 __attribute__((__sfr__));
__extension__ typedef struct tagTRGCON4BITS {
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
} TRGCON4BITS;
extern volatile TRGCON4BITS TRGCON4bits __attribute__((__sfr__));


extern volatile uint16_t PWMCAP4 __attribute__((__sfr__));
__extension__ typedef struct tagPWMCAP4BITS {
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
} PWMCAP4BITS;
extern volatile PWMCAP4BITS PWMCAP4bits __attribute__((__sfr__));


extern volatile uint16_t LEBCON4 __attribute__((__sfr__));
typedef struct tagLEBCON4BITS {
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
} LEBCON4BITS;
extern volatile LEBCON4BITS LEBCON4bits __attribute__((__sfr__));


extern volatile uint16_t LEBDLY4 __attribute__((__sfr__));
__extension__ typedef struct tagLEBDLY4BITS {
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
} LEBDLY4BITS;
extern volatile LEBDLY4BITS LEBDLY4bits __attribute__((__sfr__));


extern volatile uint16_t AUXCON4 __attribute__((__sfr__));
__extension__ typedef struct tagAUXCON4BITS {
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
} AUXCON4BITS;
extern volatile AUXCON4BITS AUXCON4bits __attribute__((__sfr__));


extern volatile uint16_t PWMCON5 __attribute__((__sfr__));
__extension__ typedef struct tagPWMCON5BITS {
  union {
    struct {
      uint16_t IUE:1;
      uint16_t XPRES:1;
      uint16_t CAM:1;
      uint16_t MTBS:1;
      uint16_t :1;
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
} PWMCON5BITS;
extern volatile PWMCON5BITS PWMCON5bits __attribute__((__sfr__));


extern volatile uint16_t IOCON5 __attribute__((__sfr__));
__extension__ typedef struct tagIOCON5BITS {
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
} IOCON5BITS;
extern volatile IOCON5BITS IOCON5bits __attribute__((__sfr__));


extern volatile uint16_t FCLCON5 __attribute__((__sfr__));
__extension__ typedef struct tagFCLCON5BITS {
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
} FCLCON5BITS;
extern volatile FCLCON5BITS FCLCON5bits __attribute__((__sfr__));


extern volatile uint16_t PDC5 __attribute__((__sfr__));

extern volatile uint16_t PHASE5 __attribute__((__sfr__));

extern volatile uint16_t DTR5 __attribute__((__sfr__));

extern volatile uint16_t ALTDTR5 __attribute__((__sfr__));

extern volatile uint16_t SDC5 __attribute__((__sfr__));

extern volatile uint16_t SPHASE5 __attribute__((__sfr__));

extern volatile uint16_t TRIG5 __attribute__((__sfr__));
__extension__ typedef struct tagTRIG5BITS {
  union {
    struct {
      uint16_t :3;
      uint16_t TRGCMP:13;
    };
    struct {
      uint16_t :3;
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
    };
  };
} TRIG5BITS;
extern volatile TRIG5BITS TRIG5bits __attribute__((__sfr__));


extern volatile uint16_t TRGCON5 __attribute__((__sfr__));
__extension__ typedef struct tagTRGCON5BITS {
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
} TRGCON5BITS;
extern volatile TRGCON5BITS TRGCON5bits __attribute__((__sfr__));


extern volatile uint16_t PWMCAP5 __attribute__((__sfr__));
__extension__ typedef struct tagPWMCAP5BITS {
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
} PWMCAP5BITS;
extern volatile PWMCAP5BITS PWMCAP5bits __attribute__((__sfr__));


extern volatile uint16_t LEBCON5 __attribute__((__sfr__));
typedef struct tagLEBCON5BITS {
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
} LEBCON5BITS;
extern volatile LEBCON5BITS LEBCON5bits __attribute__((__sfr__));


extern volatile uint16_t LEBDLY5 __attribute__((__sfr__));
__extension__ typedef struct tagLEBDLY5BITS {
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
} LEBDLY5BITS;
extern volatile LEBDLY5BITS LEBDLY5bits __attribute__((__sfr__));


extern volatile uint16_t AUXCON5 __attribute__((__sfr__));
__extension__ typedef struct tagAUXCON5BITS {
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
} AUXCON5BITS;
extern volatile AUXCON5BITS AUXCON5bits __attribute__((__sfr__));


extern volatile uint16_t PWMCON6 __attribute__((__sfr__));
__extension__ typedef struct tagPWMCON6BITS {
  union {
    struct {
      uint16_t IUE:1;
      uint16_t XPRES:1;
      uint16_t CAM:1;
      uint16_t MTBS:1;
      uint16_t :1;
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
} PWMCON6BITS;
extern volatile PWMCON6BITS PWMCON6bits __attribute__((__sfr__));


extern volatile uint16_t IOCON6 __attribute__((__sfr__));
__extension__ typedef struct tagIOCON6BITS {
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
} IOCON6BITS;
extern volatile IOCON6BITS IOCON6bits __attribute__((__sfr__));


extern volatile uint16_t FCLCON6 __attribute__((__sfr__));
__extension__ typedef struct tagFCLCON6BITS {
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
} FCLCON6BITS;
extern volatile FCLCON6BITS FCLCON6bits __attribute__((__sfr__));


extern volatile uint16_t PDC6 __attribute__((__sfr__));

extern volatile uint16_t PHASE6 __attribute__((__sfr__));

extern volatile uint16_t DTR6 __attribute__((__sfr__));

extern volatile uint16_t ALTDTR6 __attribute__((__sfr__));

extern volatile uint16_t SDC6 __attribute__((__sfr__));

extern volatile uint16_t SPHASE6 __attribute__((__sfr__));

extern volatile uint16_t TRIG6 __attribute__((__sfr__));
__extension__ typedef struct tagTRIG6BITS {
  union {
    struct {
      uint16_t :3;
      uint16_t TRGCMP:13;
    };
    struct {
      uint16_t :3;
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
    };
  };
} TRIG6BITS;
extern volatile TRIG6BITS TRIG6bits __attribute__((__sfr__));


extern volatile uint16_t TRGCON6 __attribute__((__sfr__));
__extension__ typedef struct tagTRGCON6BITS {
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
} TRGCON6BITS;
extern volatile TRGCON6BITS TRGCON6bits __attribute__((__sfr__));


extern volatile uint16_t PWMCAP6 __attribute__((__sfr__));
__extension__ typedef struct tagPWMCAP6BITS {
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
} PWMCAP6BITS;
extern volatile PWMCAP6BITS PWMCAP6bits __attribute__((__sfr__));


extern volatile uint16_t LEBCON6 __attribute__((__sfr__));
typedef struct tagLEBCON6BITS {
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
} LEBCON6BITS;
extern volatile LEBCON6BITS LEBCON6bits __attribute__((__sfr__));


extern volatile uint16_t LEBDLY6 __attribute__((__sfr__));
__extension__ typedef struct tagLEBDLY6BITS {
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
} LEBDLY6BITS;
extern volatile LEBDLY6BITS LEBDLY6bits __attribute__((__sfr__));


extern volatile uint16_t AUXCON6 __attribute__((__sfr__));
__extension__ typedef struct tagAUXCON6BITS {
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
} AUXCON6BITS;
extern volatile AUXCON6BITS AUXCON6bits __attribute__((__sfr__));


extern volatile uint16_t TRISA __attribute__((__sfr__));
typedef struct tagTRISABITS {
  uint16_t TRISA0:1;
  uint16_t TRISA1:1;
  uint16_t TRISA2:1;
  uint16_t TRISA3:1;
  uint16_t TRISA4:1;
  uint16_t TRISA5:1;
  uint16_t TRISA6:1;
  uint16_t TRISA7:1;
  uint16_t :1;
  uint16_t TRISA9:1;
  uint16_t TRISA10:1;
  uint16_t :3;
  uint16_t TRISA14:1;
  uint16_t TRISA15:1;
} TRISABITS;
extern volatile TRISABITS TRISAbits __attribute__((__sfr__));


extern volatile uint16_t PORTA __attribute__((__sfr__));
typedef struct tagPORTABITS {
  uint16_t RA0:1;
  uint16_t RA1:1;
  uint16_t RA2:1;
  uint16_t RA3:1;
  uint16_t RA4:1;
  uint16_t RA5:1;
  uint16_t RA6:1;
  uint16_t RA7:1;
  uint16_t :1;
  uint16_t RA9:1;
  uint16_t RA10:1;
  uint16_t :3;
  uint16_t RA14:1;
  uint16_t RA15:1;
} PORTABITS;
extern volatile PORTABITS PORTAbits __attribute__((__sfr__));


extern volatile uint16_t LATA __attribute__((__sfr__));
typedef struct tagLATABITS {
  uint16_t LATA0:1;
  uint16_t LATA1:1;
  uint16_t LATA2:1;
  uint16_t LATA3:1;
  uint16_t LATA4:1;
  uint16_t LATA5:1;
  uint16_t LATA6:1;
  uint16_t LATA7:1;
  uint16_t :1;
  uint16_t LATA9:1;
  uint16_t LATA10:1;
  uint16_t :3;
  uint16_t LATA14:1;
  uint16_t LATA15:1;
} LATABITS;
extern volatile LATABITS LATAbits __attribute__((__sfr__));


extern volatile uint16_t ODCA __attribute__((__sfr__));
typedef struct tagODCABITS {
  uint16_t ODCA0:1;
  uint16_t ODCA1:1;
  uint16_t ODCA2:1;
  uint16_t ODCA3:1;
  uint16_t ODCA4:1;
  uint16_t ODCA5:1;
  uint16_t :8;
  uint16_t ODCA14:1;
  uint16_t ODCA15:1;
} ODCABITS;
extern volatile ODCABITS ODCAbits __attribute__((__sfr__));


extern volatile uint16_t CNENA __attribute__((__sfr__));
typedef struct tagCNENABITS {
  uint16_t CNIEA0:1;
  uint16_t CNIEA1:1;
  uint16_t CNIEA2:1;
  uint16_t CNIEA3:1;
  uint16_t CNIEA4:1;
  uint16_t CNIEA5:1;
  uint16_t CNIEA6:1;
  uint16_t CNIEA7:1;
  uint16_t :1;
  uint16_t CNIEA9:1;
  uint16_t CNIEA10:1;
  uint16_t :3;
  uint16_t CNIEA14:1;
  uint16_t CNIEA15:1;
} CNENABITS;
extern volatile CNENABITS CNENAbits __attribute__((__sfr__));


extern volatile uint16_t CNPUA __attribute__((__sfr__));
typedef struct tagCNPUABITS {
  uint16_t CNPUA0:1;
  uint16_t CNPUA1:1;
  uint16_t CNPUA2:1;
  uint16_t CNPUA3:1;
  uint16_t CNPUA4:1;
  uint16_t CNPUA5:1;
  uint16_t CNPUA6:1;
  uint16_t CNPUA7:1;
  uint16_t :1;
  uint16_t CNPUA9:1;
  uint16_t CNPUA10:1;
  uint16_t :3;
  uint16_t CNPUA14:1;
  uint16_t CNPUA15:1;
} CNPUABITS;
extern volatile CNPUABITS CNPUAbits __attribute__((__sfr__));


extern volatile uint16_t CNPDA __attribute__((__sfr__));
typedef struct tagCNPDABITS {
  uint16_t CNPDA0:1;
  uint16_t CNPDA1:1;
  uint16_t CNPDA2:1;
  uint16_t CNPDA3:1;
  uint16_t CNPDA4:1;
  uint16_t CNPDA5:1;
  uint16_t CNPDA6:1;
  uint16_t CNPDA7:1;
  uint16_t :1;
  uint16_t CNPDA9:1;
  uint16_t CNPDA10:1;
  uint16_t :3;
  uint16_t CNPDA14:1;
  uint16_t CNPDA15:1;
} CNPDABITS;
extern volatile CNPDABITS CNPDAbits __attribute__((__sfr__));


extern volatile uint16_t ANSELA __attribute__((__sfr__));
typedef struct tagANSELABITS {
  uint16_t :6;
  uint16_t ANSA6:1;
  uint16_t ANSA7:1;
  uint16_t :1;
  uint16_t ANSA9:1;
  uint16_t ANSA10:1;
} ANSELABITS;
extern volatile ANSELABITS ANSELAbits __attribute__((__sfr__));


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
  uint16_t ANSB4:1;
  uint16_t ANSB5:1;
  uint16_t ANSB6:1;
  uint16_t ANSB7:1;
  uint16_t ANSB8:1;
  uint16_t ANSB9:1;
  uint16_t ANSB10:1;
  uint16_t ANSB11:1;
  uint16_t ANSB12:1;
  uint16_t ANSB13:1;
  uint16_t ANSB14:1;
  uint16_t ANSB15:1;
} ANSELBBITS;
extern volatile ANSELBBITS ANSELBbits __attribute__((__sfr__));


extern volatile uint16_t TRISC __attribute__((__sfr__));
typedef struct tagTRISCBITS {
  uint16_t :1;
  uint16_t TRISC1:1;
  uint16_t TRISC2:1;
  uint16_t TRISC3:1;
  uint16_t TRISC4:1;
  uint16_t :7;
  uint16_t TRISC12:1;
  uint16_t TRISC13:1;
  uint16_t TRISC14:1;
  uint16_t TRISC15:1;
} TRISCBITS;
extern volatile TRISCBITS TRISCbits __attribute__((__sfr__));


extern volatile uint16_t PORTC __attribute__((__sfr__));
typedef struct tagPORTCBITS {
  uint16_t :1;
  uint16_t RC1:1;
  uint16_t RC2:1;
  uint16_t RC3:1;
  uint16_t RC4:1;
  uint16_t :7;
  uint16_t RC12:1;
  uint16_t RC13:1;
  uint16_t RC14:1;
  uint16_t RC15:1;
} PORTCBITS;
extern volatile PORTCBITS PORTCbits __attribute__((__sfr__));


extern volatile uint16_t LATC __attribute__((__sfr__));
typedef struct tagLATCBITS {
  uint16_t :1;
  uint16_t LATC1:1;
  uint16_t LATC2:1;
  uint16_t LATC3:1;
  uint16_t LATC4:1;
  uint16_t :7;
  uint16_t LATC12:1;
  uint16_t LATC13:1;
  uint16_t LATC14:1;
  uint16_t LATC15:1;
} LATCBITS;
extern volatile LATCBITS LATCbits __attribute__((__sfr__));


extern volatile uint16_t CNENC __attribute__((__sfr__));
typedef struct tagCNENCBITS {
  uint16_t :1;
  uint16_t CNIEC1:1;
  uint16_t CNIEC2:1;
  uint16_t CNIEC3:1;
  uint16_t CNIEC4:1;
  uint16_t :7;
  uint16_t CNIEC12:1;
  uint16_t CNIEC13:1;
  uint16_t CNIEC14:1;
  uint16_t CNIEC15:1;
} CNENCBITS;
extern volatile CNENCBITS CNENCbits __attribute__((__sfr__));


extern volatile uint16_t CNPUC __attribute__((__sfr__));
typedef struct tagCNPUCBITS {
  uint16_t :1;
  uint16_t CNPUC1:1;
  uint16_t CNPUC2:1;
  uint16_t CNPUC3:1;
  uint16_t CNPUC4:1;
  uint16_t :7;
  uint16_t CNPUC12:1;
  uint16_t CNPUC13:1;
  uint16_t CNPUC14:1;
  uint16_t CNPUC15:1;
} CNPUCBITS;
extern volatile CNPUCBITS CNPUCbits __attribute__((__sfr__));


extern volatile uint16_t CNPDC __attribute__((__sfr__));
typedef struct tagCNPDCBITS {
  uint16_t :1;
  uint16_t CNPDC1:1;
  uint16_t CNPDC2:1;
  uint16_t CNPDC3:1;
  uint16_t CNPDC4:1;
  uint16_t :7;
  uint16_t CNPDC12:1;
  uint16_t CNPDC13:1;
  uint16_t CNPDC14:1;
  uint16_t CNPDC15:1;
} CNPDCBITS;
extern volatile CNPDCBITS CNPDCbits __attribute__((__sfr__));


extern volatile uint16_t ANSELC __attribute__((__sfr__));
typedef struct tagANSELCBITS {
  uint16_t :1;
  uint16_t ANSC1:1;
  uint16_t ANSC2:1;
  uint16_t ANSC3:1;
  uint16_t ANSC4:1;
  uint16_t :8;
  uint16_t ANSC13:1;
  uint16_t ANSC14:1;
} ANSELCBITS;
extern volatile ANSELCBITS ANSELCbits __attribute__((__sfr__));


extern volatile uint16_t TRISD __attribute__((__sfr__));
typedef struct tagTRISDBITS {
  uint16_t TRISD0:1;
  uint16_t TRISD1:1;
  uint16_t TRISD2:1;
  uint16_t TRISD3:1;
  uint16_t TRISD4:1;
  uint16_t TRISD5:1;
  uint16_t TRISD6:1;
  uint16_t TRISD7:1;
  uint16_t TRISD8:1;
  uint16_t TRISD9:1;
  uint16_t TRISD10:1;
  uint16_t TRISD11:1;
  uint16_t TRISD12:1;
  uint16_t TRISD13:1;
  uint16_t TRISD14:1;
  uint16_t TRISD15:1;
} TRISDBITS;
extern volatile TRISDBITS TRISDbits __attribute__((__sfr__));


extern volatile uint16_t PORTD __attribute__((__sfr__));
typedef struct tagPORTDBITS {
  uint16_t RD0:1;
  uint16_t RD1:1;
  uint16_t RD2:1;
  uint16_t RD3:1;
  uint16_t RD4:1;
  uint16_t RD5:1;
  uint16_t RD6:1;
  uint16_t RD7:1;
  uint16_t RD8:1;
  uint16_t RD9:1;
  uint16_t RD10:1;
  uint16_t RD11:1;
  uint16_t RD12:1;
  uint16_t RD13:1;
  uint16_t RD14:1;
  uint16_t RD15:1;
} PORTDBITS;
extern volatile PORTDBITS PORTDbits __attribute__((__sfr__));


extern volatile uint16_t LATD __attribute__((__sfr__));
typedef struct tagLATDBITS {
  uint16_t LATD0:1;
  uint16_t LATD1:1;
  uint16_t LATD2:1;
  uint16_t LATD3:1;
  uint16_t LATD4:1;
  uint16_t LATD5:1;
  uint16_t LATD6:1;
  uint16_t LATD7:1;
  uint16_t LATD8:1;
  uint16_t LATD9:1;
  uint16_t LATD10:1;
  uint16_t LATD11:1;
  uint16_t LATD12:1;
  uint16_t LATD13:1;
  uint16_t LATD14:1;
  uint16_t LATD15:1;
} LATDBITS;
extern volatile LATDBITS LATDbits __attribute__((__sfr__));


extern volatile uint16_t ODCD __attribute__((__sfr__));
typedef struct tagODCDBITS {
  uint16_t ODCD0:1;
  uint16_t ODCD1:1;
  uint16_t ODCD2:1;
  uint16_t ODCD3:1;
  uint16_t ODCD4:1;
  uint16_t ODCD5:1;
  uint16_t :2;
  uint16_t ODCD8:1;
  uint16_t ODCD9:1;
  uint16_t ODCD10:1;
  uint16_t ODCD11:1;
  uint16_t ODCD12:1;
  uint16_t ODCD13:1;
  uint16_t ODCD14:1;
  uint16_t ODCD15:1;
} ODCDBITS;
extern volatile ODCDBITS ODCDbits __attribute__((__sfr__));


extern volatile uint16_t CNEND __attribute__((__sfr__));
typedef struct tagCNENDBITS {
  uint16_t CNIED0:1;
  uint16_t CNIED1:1;
  uint16_t CNIED2:1;
  uint16_t CNIED3:1;
  uint16_t CNIED4:1;
  uint16_t CNIED5:1;
  uint16_t CNIED6:1;
  uint16_t CNIED7:1;
  uint16_t CNIED8:1;
  uint16_t CNIED9:1;
  uint16_t CNIED10:1;
  uint16_t CNIED11:1;
  uint16_t CNIED12:1;
  uint16_t CNIED13:1;
  uint16_t CNIED14:1;
  uint16_t CNIED15:1;
} CNENDBITS;
extern volatile CNENDBITS CNENDbits __attribute__((__sfr__));


extern volatile uint16_t CNPUD __attribute__((__sfr__));
typedef struct tagCNPUDBITS {
  uint16_t CNPUD0:1;
  uint16_t CNPUD1:1;
  uint16_t CNPUD2:1;
  uint16_t CNPUD3:1;
  uint16_t CNPUD4:1;
  uint16_t CNPUD5:1;
  uint16_t CNPUD6:1;
  uint16_t CNPUD7:1;
  uint16_t CNPUD8:1;
  uint16_t CNPUD9:1;
  uint16_t CNPUD10:1;
  uint16_t CNPUD11:1;
  uint16_t CNPUD12:1;
  uint16_t CNPUD13:1;
  uint16_t CNPUD14:1;
  uint16_t CNPUD15:1;
} CNPUDBITS;
extern volatile CNPUDBITS CNPUDbits __attribute__((__sfr__));


extern volatile uint16_t CNPDD __attribute__((__sfr__));
typedef struct tagCNPDDBITS {
  uint16_t CNPDD0:1;
  uint16_t CNPDD1:1;
  uint16_t CNPDD2:1;
  uint16_t CNPDD3:1;
  uint16_t CNPDD4:1;
  uint16_t CNPDD5:1;
  uint16_t CNPDD6:1;
  uint16_t CNPDD7:1;
  uint16_t CNPDD8:1;
  uint16_t CNPDD9:1;
  uint16_t CNPDD10:1;
  uint16_t CNPDD11:1;
  uint16_t CNPDD12:1;
  uint16_t CNPDD13:1;
  uint16_t CNPDD14:1;
  uint16_t CNPDD15:1;
} CNPDDBITS;
extern volatile CNPDDBITS CNPDDbits __attribute__((__sfr__));


extern volatile uint16_t ANSELD __attribute__((__sfr__));
typedef struct tagANSELDBITS {
  uint16_t :6;
  uint16_t ANSD6:1;
  uint16_t ANSD7:1;
} ANSELDBITS;
extern volatile ANSELDBITS ANSELDbits __attribute__((__sfr__));


extern volatile uint16_t TRISE __attribute__((__sfr__));
typedef struct tagTRISEBITS {
  uint16_t TRISE0:1;
  uint16_t TRISE1:1;
  uint16_t TRISE2:1;
  uint16_t TRISE3:1;
  uint16_t TRISE4:1;
  uint16_t TRISE5:1;
  uint16_t TRISE6:1;
  uint16_t TRISE7:1;
  uint16_t TRISE8:1;
  uint16_t TRISE9:1;
} TRISEBITS;
extern volatile TRISEBITS TRISEbits __attribute__((__sfr__));


extern volatile uint16_t PORTE __attribute__((__sfr__));
typedef struct tagPORTEBITS {
  uint16_t RE0:1;
  uint16_t RE1:1;
  uint16_t RE2:1;
  uint16_t RE3:1;
  uint16_t RE4:1;
  uint16_t RE5:1;
  uint16_t RE6:1;
  uint16_t RE7:1;
  uint16_t RE8:1;
  uint16_t RE9:1;
} PORTEBITS;
extern volatile PORTEBITS PORTEbits __attribute__((__sfr__));


extern volatile uint16_t LATE __attribute__((__sfr__));
typedef struct tagLATEBITS {
  uint16_t LATE0:1;
  uint16_t LATE1:1;
  uint16_t LATE2:1;
  uint16_t LATE3:1;
  uint16_t LATE4:1;
  uint16_t LATE5:1;
  uint16_t LATE6:1;
  uint16_t LATE7:1;
  uint16_t LATE8:1;
  uint16_t LATE9:1;
} LATEBITS;
extern volatile LATEBITS LATEbits __attribute__((__sfr__));


extern volatile uint16_t CNENE __attribute__((__sfr__));
typedef struct tagCNENEBITS {
  uint16_t CNIEE0:1;
  uint16_t CNIEE1:1;
  uint16_t CNIEE2:1;
  uint16_t CNIEE3:1;
  uint16_t CNIEE4:1;
  uint16_t CNIEE5:1;
  uint16_t CNIEE6:1;
  uint16_t CNIEE7:1;
  uint16_t CNIEE8:1;
  uint16_t CNIEE9:1;
} CNENEBITS;
extern volatile CNENEBITS CNENEbits __attribute__((__sfr__));


extern volatile uint16_t CNPUE __attribute__((__sfr__));
typedef struct tagCNPUEBITS {
  uint16_t CNPUE0:1;
  uint16_t CNPUE1:1;
  uint16_t CNPUE2:1;
  uint16_t CNPUE3:1;
  uint16_t CNPUE4:1;
  uint16_t CNPUE5:1;
  uint16_t CNPUE6:1;
  uint16_t CNPUE7:1;
  uint16_t CNPUE8:1;
  uint16_t CNPUE9:1;
} CNPUEBITS;
extern volatile CNPUEBITS CNPUEbits __attribute__((__sfr__));


extern volatile uint16_t CNPDE __attribute__((__sfr__));
typedef struct tagCNPDEBITS {
  uint16_t CNPDE0:1;
  uint16_t CNPDE1:1;
  uint16_t CNPDE2:1;
  uint16_t CNPDE3:1;
  uint16_t CNPDE4:1;
  uint16_t CNPDE5:1;
  uint16_t CNPDE6:1;
  uint16_t CNPDE7:1;
  uint16_t CNPDE8:1;
  uint16_t CNPDE9:1;
} CNPDEBITS;
extern volatile CNPDEBITS CNPDEbits __attribute__((__sfr__));


extern volatile uint16_t ANSELE __attribute__((__sfr__));
typedef struct tagANSELEBITS {
  uint16_t ANSE0:1;
  uint16_t ANSE1:1;
  uint16_t ANSE2:1;
  uint16_t ANSE3:1;
  uint16_t ANSE4:1;
  uint16_t ANSE5:1;
  uint16_t ANSE6:1;
  uint16_t ANSE7:1;
  uint16_t ANSE8:1;
  uint16_t ANSE9:1;
} ANSELEBITS;
extern volatile ANSELEBITS ANSELEbits __attribute__((__sfr__));


extern volatile uint16_t TRISF __attribute__((__sfr__));
typedef struct tagTRISFBITS {
  uint16_t TRISF0:1;
  uint16_t TRISF1:1;
  uint16_t TRISF2:1;
  uint16_t TRISF3:1;
  uint16_t TRISF4:1;
  uint16_t TRISF5:1;
  uint16_t :2;
  uint16_t TRISF8:1;
  uint16_t :3;
  uint16_t TRISF12:1;
  uint16_t TRISF13:1;
} TRISFBITS;
extern volatile TRISFBITS TRISFbits __attribute__((__sfr__));


extern volatile uint16_t PORTF __attribute__((__sfr__));
typedef struct tagPORTFBITS {
  uint16_t RF0:1;
  uint16_t RF1:1;
  uint16_t RF2:1;
  uint16_t RF3:1;
  uint16_t RF4:1;
  uint16_t RF5:1;
  uint16_t :2;
  uint16_t RF8:1;
  uint16_t :3;
  uint16_t RF12:1;
  uint16_t RF13:1;
} PORTFBITS;
extern volatile PORTFBITS PORTFbits __attribute__((__sfr__));


extern volatile uint16_t LATF __attribute__((__sfr__));
typedef struct tagLATFBITS {
  uint16_t LATF0:1;
  uint16_t LATF1:1;
  uint16_t LATF2:1;
  uint16_t LATF3:1;
  uint16_t LATF4:1;
  uint16_t LATF5:1;
  uint16_t :2;
  uint16_t LATF8:1;
  uint16_t :3;
  uint16_t LATF12:1;
  uint16_t LATF13:1;
} LATFBITS;
extern volatile LATFBITS LATFbits __attribute__((__sfr__));


extern volatile uint16_t ODCF __attribute__((__sfr__));
typedef struct tagODCFBITS {
  uint16_t ODCF0:1;
  uint16_t ODCF1:1;
  uint16_t ODCF2:1;
  uint16_t ODCF3:1;
  uint16_t ODCF4:1;
  uint16_t ODCF5:1;
  uint16_t :2;
  uint16_t ODCF8:1;
  uint16_t :3;
  uint16_t ODCF12:1;
  uint16_t ODCF13:1;
} ODCFBITS;
extern volatile ODCFBITS ODCFbits __attribute__((__sfr__));


extern volatile uint16_t CNENF __attribute__((__sfr__));
typedef struct tagCNENFBITS {
  uint16_t CNIEF0:1;
  uint16_t CNIEF1:1;
  uint16_t CNIEF2:1;
  uint16_t CNIEF3:1;
  uint16_t CNIEF4:1;
  uint16_t CNIEF5:1;
  uint16_t :2;
  uint16_t CNIEF8:1;
  uint16_t :3;
  uint16_t CNIEF12:1;
  uint16_t CNIEF13:1;
} CNENFBITS;
extern volatile CNENFBITS CNENFbits __attribute__((__sfr__));


extern volatile uint16_t CNPUF __attribute__((__sfr__));
typedef struct tagCNPUFBITS {
  uint16_t CNPUF0:1;
  uint16_t CNPUF1:1;
  uint16_t CNPUF2:1;
  uint16_t CNPUF3:1;
  uint16_t CNPUF4:1;
  uint16_t CNPUF5:1;
  uint16_t :2;
  uint16_t CNPUF8:1;
  uint16_t :3;
  uint16_t CNPUF12:1;
  uint16_t CNPUF13:1;
} CNPUFBITS;
extern volatile CNPUFBITS CNPUFbits __attribute__((__sfr__));


extern volatile uint16_t CNPDF __attribute__((__sfr__));
typedef struct tagCNPDFBITS {
  uint16_t CNPDF0:1;
  uint16_t CNPDF1:1;
  uint16_t CNPDF2:1;
  uint16_t CNPDF3:1;
  uint16_t CNPDF4:1;
  uint16_t CNPDF5:1;
  uint16_t :2;
  uint16_t CNPDF8:1;
  uint16_t :3;
  uint16_t CNPDF12:1;
  uint16_t CNPDF13:1;
} CNPDFBITS;
extern volatile CNPDFBITS CNPDFbits __attribute__((__sfr__));


extern volatile uint16_t TRISG __attribute__((__sfr__));
typedef struct tagTRISGBITS {
  uint16_t TRISG0:1;
  uint16_t TRISG1:1;
  uint16_t :4;
  uint16_t TRISG6:1;
  uint16_t TRISG7:1;
  uint16_t TRISG8:1;
  uint16_t TRISG9:1;
  uint16_t :2;
  uint16_t TRISG12:1;
  uint16_t TRISG13:1;
  uint16_t TRISG14:1;
  uint16_t TRISG15:1;
} TRISGBITS;
extern volatile TRISGBITS TRISGbits __attribute__((__sfr__));


extern volatile uint16_t PORTG __attribute__((__sfr__));
typedef struct tagPORTGBITS {
  uint16_t RG0:1;
  uint16_t RG1:1;
  uint16_t RG2:1;
  uint16_t RG3:1;
  uint16_t :2;
  uint16_t RG6:1;
  uint16_t RG7:1;
  uint16_t RG8:1;
  uint16_t RG9:1;
  uint16_t :2;
  uint16_t RG12:1;
  uint16_t RG13:1;
  uint16_t RG14:1;
  uint16_t RG15:1;
} PORTGBITS;
extern volatile PORTGBITS PORTGbits __attribute__((__sfr__));


extern volatile uint16_t LATG __attribute__((__sfr__));
typedef struct tagLATGBITS {
  uint16_t LATG0:1;
  uint16_t LATG1:1;
  uint16_t :4;
  uint16_t LATG6:1;
  uint16_t LATG7:1;
  uint16_t LATG8:1;
  uint16_t LATG9:1;
  uint16_t :2;
  uint16_t LATG12:1;
  uint16_t LATG13:1;
  uint16_t LATG14:1;
  uint16_t LATG15:1;
} LATGBITS;
extern volatile LATGBITS LATGbits __attribute__((__sfr__));


extern volatile uint16_t ODCG __attribute__((__sfr__));
typedef struct tagODCGBITS {
  uint16_t ODCG0:1;
  uint16_t ODCG1:1;
  uint16_t :10;
  uint16_t ODCG12:1;
  uint16_t ODCG13:1;
  uint16_t ODCG14:1;
  uint16_t ODCG15:1;
} ODCGBITS;
extern volatile ODCGBITS ODCGbits __attribute__((__sfr__));


extern volatile uint16_t CNENG __attribute__((__sfr__));
typedef struct tagCNENGBITS {
  uint16_t CNIEG0:1;
  uint16_t CNIEG1:1;
  uint16_t CNIEG2:1;
  uint16_t CNIEG3:1;
  uint16_t :2;
  uint16_t CNIEG6:1;
  uint16_t CNIEG7:1;
  uint16_t CNIEG8:1;
  uint16_t CNIEG9:1;
  uint16_t :2;
  uint16_t CNIEG12:1;
  uint16_t CNIEG13:1;
  uint16_t CNIEG14:1;
  uint16_t CNIEG15:1;
} CNENGBITS;
extern volatile CNENGBITS CNENGbits __attribute__((__sfr__));


extern volatile uint16_t CNPUG __attribute__((__sfr__));
typedef struct tagCNPUGBITS {
  uint16_t CNPUG0:1;
  uint16_t CNPUG1:1;
  uint16_t :4;
  uint16_t CNPUG6:1;
  uint16_t CNPUG7:1;
  uint16_t CNPUG8:1;
  uint16_t CNPUG9:1;
  uint16_t :2;
  uint16_t CNPUG12:1;
  uint16_t CNPUG13:1;
  uint16_t CNPUG14:1;
  uint16_t CNPUG15:1;
} CNPUGBITS;
extern volatile CNPUGBITS CNPUGbits __attribute__((__sfr__));


extern volatile uint16_t CNPDG __attribute__((__sfr__));
typedef struct tagCNPDGBITS {
  uint16_t CNPDG0:1;
  uint16_t CNPDG1:1;
  uint16_t :4;
  uint16_t CNPDG6:1;
  uint16_t CNPDG7:1;
  uint16_t CNPDG8:1;
  uint16_t CNPDG9:1;
  uint16_t :2;
  uint16_t CNPDG12:1;
  uint16_t CNPDG13:1;
  uint16_t CNPDG14:1;
  uint16_t CNPDG15:1;
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


extern volatile uint16_t PADCFG1 __attribute__((__sfr__));
typedef struct tagPADCFG1BITS {
  uint16_t PMPTTL:1;
  uint16_t RTSECSEL:1;
} PADCFG1BITS;
extern volatile PADCFG1BITS PADCFG1bits __attribute__((__sfr__));


extern volatile uint16_t _APPO __attribute__((__sfr__));

extern volatile uint16_t _APPIN __attribute__((__sfr__));

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
# 58054 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33E-GM-GP-MC-GU-MU_DFP/1.5.258/xc16/bin/..\\support\\dsPIC33E\\h/p33EP512MU810.h" 3 4
extern __attribute__((space(prog))) __prog__ uint16_t _FGS;
# 58091 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33E-GM-GP-MC-GU-MU_DFP/1.5.258/xc16/bin/..\\support\\dsPIC33E\\h/p33EP512MU810.h" 3 4
extern __attribute__((space(prog))) __prog__ uint16_t _FOSCSEL;
# 58133 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33E-GM-GP-MC-GU-MU_DFP/1.5.258/xc16/bin/..\\support\\dsPIC33E\\h/p33EP512MU810.h" 3 4
extern __attribute__((space(prog))) __prog__ uint16_t _FOSC;
# 58183 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33E-GM-GP-MC-GU-MU_DFP/1.5.258/xc16/bin/..\\support\\dsPIC33E\\h/p33EP512MU810.h" 3 4
extern __attribute__((space(prog))) __prog__ uint16_t _FWDT;
# 58262 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33E-GM-GP-MC-GU-MU_DFP/1.5.258/xc16/bin/..\\support\\dsPIC33E\\h/p33EP512MU810.h" 3 4
extern __attribute__((space(prog))) __prog__ uint16_t _FPOR;
# 58318 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33E-GM-GP-MC-GU-MU_DFP/1.5.258/xc16/bin/..\\support\\dsPIC33E\\h/p33EP512MU810.h" 3 4
extern __attribute__((space(prog))) __prog__ uint16_t _FICD;
# 58359 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33E-GM-GP-MC-GU-MU_DFP/1.5.258/xc16/bin/..\\support\\dsPIC33E\\h/p33EP512MU810.h" 3 4
extern __attribute__((space(prog))) __prog__ uint16_t _FAS;
# 58396 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33E-GM-GP-MC-GU-MU_DFP/1.5.258/xc16/bin/..\\support\\dsPIC33E\\h/p33EP512MU810.h" 3 4
extern __attribute__((space(prog))) __prog__ uint16_t _FUID0;
# 444 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33E-GM-GP-MC-GU-MU_DFP/1.5.258/xc16/bin/..\\support\\generic\\h/xc.h" 2 3 4
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
# 39 "../serial/serial.c" 2
# 1 "../../../Source/include/queue.h" 1
# 43 "../../../Source/include/queue.h"
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
# 40 "../serial/serial.c" 2
# 1 "../../../Source/include/task.h" 1
# 41 "../serial/serial.c" 2


# 1 "../../Common/include/serial.h" 1
# 30 "../../Common/include/serial.h"
typedef void * xComPortHandle;

typedef enum
{
    serCOM1,
    serCOM2,
    serCOM3,
    serCOM4,
    serCOM5,
    serCOM6,
    serCOM7,
    serCOM8
} eCOMPort;

typedef enum
{
    serNO_PARITY,
    serODD_PARITY,
    serEVEN_PARITY,
    serMARK_PARITY,
    serSPACE_PARITY
} eParity;

typedef enum
{
    serSTOP_1,
    serSTOP_2
} eStopBits;

typedef enum
{
    serBITS_5,
    serBITS_6,
    serBITS_7,
    serBITS_8
} eDataBits;

typedef enum
{
    ser50,
    ser75,
    ser110,
    ser134,
    ser150,
    ser200,
    ser300,
    ser600,
    ser1200,
    ser1800,
    ser2400,
    ser4800,
    ser9600,
    ser19200,
    ser38400,
    ser57600,
    ser115200
} eBaud;

xComPortHandle xSerialPortInitMinimal( unsigned long ulWantedBaud,
                                       unsigned short uxQueueLength );
xComPortHandle xSerialPortInit( eCOMPort ePort,
                                eBaud eWantedBaud,
                                eParity eWantedParity,
                                eDataBits eWantedDataBits,
                                eStopBits eWantedStopBits,
                                unsigned short uxBufferLength );
void vSerialPutString( xComPortHandle pxPort,
                       const signed char * const pcString,
                       unsigned short usStringLength );
signed short xSerialGetChar( xComPortHandle pxPort,
                                     signed char * pcRxedChar,
                                     TickType_t xBlockTime );
signed short xSerialPutChar( xComPortHandle pxPort,
                                     signed char cOutChar,
                                     TickType_t xBlockTime );
short xSerialWaitForSemaphore( xComPortHandle xPort );
void vSerialClose( xComPortHandle xPort );
# 44 "../serial/serial.c" 2
# 69 "../serial/serial.c"
static QueueHandle_t xRxedChars;
static QueueHandle_t xCharsForTx;

static short xTxHasEnded;


xComPortHandle xSerialPortInitMinimal( unsigned long ulWantedBaud, unsigned short uxQueueLength )
{
char cChar;


 xRxedChars = xQueueGenericCreate( ( uxQueueLength ), ( ( unsigned short ) sizeof( signed char ) ), ( ( ( uint8_t ) 0U ) ) );
 xCharsForTx = xQueueGenericCreate( ( uxQueueLength ), ( ( unsigned short ) sizeof( signed char ) ), ( ( ( uint8_t ) 0U ) ) );



    RPOR9bits.RP101R = 3;
    RPINR19bits.U2RXR = 100;



 U2MODEbits.BRGH = 0;
 U2MODEbits.STSEL = 0;
 U2MODEbits.PDSEL = 0;
 U2MODEbits.ABAUD = 0;
 U2MODEbits.LPBACK = 0;
 U2MODEbits.WAKE = 0;
 U2MODEbits.UEN = 0;
 U2MODEbits.IREN = 0;
 U2MODEbits.USIDL = 0;
 U2MODEbits.UARTEN = 1;

 U2BRG = (unsigned short)(( (float)( ( unsigned long ) 25000000 ) / ( (float)16 * (float)ulWantedBaud ) ) - (float)0.5);

 U2STAbits.URXISEL = 0;
 U2STAbits.UTXEN = 1;
 U2STAbits.UTXINV = 0;
 U2STAbits.UTXISEL0 = 0;
 U2STAbits.UTXISEL1 = 0;




 { SRbits.IPL = 0x01; __builtin_nop(); } (void) 0; __asm volatile ( "NOP" );

 IFS1bits.U2RXIF = 0;
 IFS1bits.U2TXIF = 0;
 IPC7bits.U2RXIP = 0x01;
 IPC7bits.U2TXIP = 0x01;
 IEC1bits.U2TXIE = 1;
 IEC1bits.U2RXIE = 1;


 while( U2STAbits.URXDA == 1 )
 {
  cChar = U2RXREG;
 }

 xTxHasEnded = ( ( BaseType_t ) 1 );

 return ((void*)0);
}


signed short xSerialGetChar( xComPortHandle pxPort, signed char *pcRxedChar, TickType_t xBlockTime )
{

 ( void ) pxPort;



 if( xQueueReceive( xRxedChars, pcRxedChar, xBlockTime ) )
 {
  return ( ( BaseType_t ) 1 );
 }
 else
 {
  return ( ( BaseType_t ) 0 );
 }
}


signed short xSerialPutChar( xComPortHandle pxPort, signed char cOutChar, TickType_t xBlockTime )
{

 ( void ) pxPort;


 if( xQueueGenericSend( ( xCharsForTx ), ( &cOutChar ), ( xBlockTime ), ( ( BaseType_t ) 0 ) ) != ( ( ( BaseType_t ) 1 ) ) )
 {
  return ( ( ( BaseType_t ) 0 ) );
 }



 if( xTxHasEnded )
 {
  xTxHasEnded = ( ( BaseType_t ) 0 );
  IFS1bits.U2TXIF = 1;
 }

 return ( ( ( BaseType_t ) 1 ) );
}


void vSerialClose( xComPortHandle xPort )
{
}


void __attribute__((__interrupt__, auto_psv)) _U2RXInterrupt( void )
{
char cChar;
short xHigherPriorityTaskWoken = ( ( BaseType_t ) 0 );




 IFS1bits.U2RXIF = 0;
 while( U2STAbits.URXDA )
 {
  cChar = U2RXREG;
  xQueueGenericSendFromISR( ( xRxedChars ), ( &cChar ), ( &xHigherPriorityTaskWoken ), ( ( BaseType_t ) 0 ) );
 }

 if( xHigherPriorityTaskWoken != ( ( BaseType_t ) 0 ) )
 {
  asm volatile ( "CALL _vPortYield			\n" "NOP					  " );;
 }
}


void __attribute__((__interrupt__, auto_psv)) _U2TXInterrupt( void )
{
signed char cChar;
short xTaskWoken = ( ( BaseType_t ) 0 );




 IFS1bits.U2TXIF = 0;
 while( !( U2STAbits.UTXBF ) )
 {
  if( xQueueReceiveFromISR( xCharsForTx, &cChar, &xTaskWoken ) == ( ( BaseType_t ) 1 ) )
  {

   U2TXREG = cChar;
  }
  else
  {

   xTxHasEnded = ( ( BaseType_t ) 1 );
   break;
  }
 }

 if( xTaskWoken != ( ( BaseType_t ) 0 ) )
 {
  asm volatile ( "CALL _vPortYield			\n" "NOP					  " );;
 }
}
