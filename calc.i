
#pragma used+
sfrb TWBR=0;
sfrb TWSR=1;
sfrb TWAR=2;
sfrb TWDR=3;
sfrb ADCL=4;
sfrb ADCH=5;
sfrw ADCW=4;      
sfrb ADCSRA=6;
sfrb ADMUX=7;
sfrb ACSR=8;
sfrb UBRRL=9;
sfrb UCSRB=0xa;
sfrb UCSRA=0xb;
sfrb UDR=0xc;
sfrb SPCR=0xd;
sfrb SPSR=0xe;
sfrb SPDR=0xf;
sfrb PIND=0x10;
sfrb DDRD=0x11;
sfrb PORTD=0x12;
sfrb PINC=0x13;
sfrb DDRC=0x14;
sfrb PORTC=0x15;
sfrb PINB=0x16;
sfrb DDRB=0x17;
sfrb PORTB=0x18;
sfrb PINA=0x19;
sfrb DDRA=0x1a;
sfrb PORTA=0x1b;
sfrb EECR=0x1c;
sfrb EEDR=0x1d;
sfrb EEARL=0x1e;
sfrb EEARH=0x1f;
sfrw EEAR=0x1e;   
sfrb UBRRH=0x20;
sfrb UCSRC=0X20;
sfrb WDTCR=0x21;
sfrb ASSR=0x22;
sfrb OCR2=0x23;
sfrb TCNT2=0x24;
sfrb TCCR2=0x25;
sfrb ICR1L=0x26;
sfrb ICR1H=0x27;
sfrb OCR1BL=0x28;
sfrb OCR1BH=0x29;
sfrw OCR1B=0x28;  
sfrb OCR1AL=0x2a;
sfrb OCR1AH=0x2b;
sfrw OCR1A=0x2a;  
sfrb TCNT1L=0x2c;
sfrb TCNT1H=0x2d;
sfrw TCNT1=0x2c;  
sfrb TCCR1B=0x2e;
sfrb TCCR1A=0x2f;
sfrb SFIOR=0x30;
sfrb OSCCAL=0x31;
sfrb OCDR=0x31;
sfrb TCNT0=0x32;
sfrb TCCR0=0x33;
sfrb MCUCSR=0x34;
sfrb MCUCR=0x35;
sfrb TWCR=0x36;
sfrb SPMCR=0x37;
sfrb TIFR=0x38;
sfrb TIMSK=0x39;
sfrb GIFR=0x3a;
sfrb GICR=0x3b;
sfrb OCR0=0X3c;
sfrb SPL=0x3d;
sfrb SPH=0x3e;
sfrb SREG=0x3f;
#pragma used-

#asm
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
#endasm

#pragma used+

void delay_us(unsigned int n);
void delay_ms(unsigned int n);

#pragma used-

#pragma used+

void _lcd_ready(void);
void _lcd_write_data(unsigned char data);

void lcd_write_byte(unsigned char addr, unsigned char data);

unsigned char lcd_read_byte(unsigned char addr);

void lcd_gotoxy(unsigned char x, unsigned char y);

void lcd_clear(void);
void lcd_putchar(char c);

void lcd_puts(char *str);

void lcd_putsf(char flash *str);

unsigned char lcd_init(unsigned char lcd_columns);

void lcd_control (unsigned char control);

#pragma used-
#pragma library lcd.lib

#pragma used+

unsigned char cabs(signed char x);
unsigned int abs(int x);
unsigned long labs(long x);
float fabs(float x);
int atoi(char *str);
long int atol(char *str);
float atof(char *str);
void itoa(int n,char *str);
void ltoa(long int n,char *str);
void ftoa(float n,unsigned char decimals,char *str);
void ftoe(float n,unsigned char decimals,char *str);
void srand(int seed);
int rand(void);
void *malloc(unsigned int size);
void *calloc(unsigned int num, unsigned int size);
void *realloc(void *ptr, unsigned int size); 
void free(void *ptr);

#pragma used-
#pragma library stdlib.lib

#pragma used+

signed char cmax(signed char a,signed char b);
int max(int a,int b);
long lmax(long a,long b);
float fmax(float a,float b);
signed char cmin(signed char a,signed char b);
int min(int a,int b);
long lmin(long a,long b);
float fmin(float a,float b);
signed char csign(signed char x);
signed char sign(int x);
signed char lsign(long x);
signed char fsign(float x);
unsigned char isqrt(unsigned int x);
unsigned int lsqrt(unsigned long x);
float sqrt(float x);
float ftrunc(float x);
float floor(float x);
float ceil(float x);
float fmod(float x,float y);
float modf(float x,float *ipart);
float ldexp(float x,int expon);
float frexp(float x,int *expon);
float exp(float x);
float log(float x);
float log10(float x);
float pow(float x,float y);
float sin(float x);
float cos(float x);
float tan(float x);
float sinh(float x);
float cosh(float x);
float tanh(float x);
float asin(float x);
float acos(float x);
float atan(float x);
float atan2(float y,float x);

#pragma used-
#pragma library math.lib

#asm
   .equ __lcd_port=0x18
#endasm

int key(void);
float _Main(void);
void Mohandes(void);
void Mohasebe(void);
void Alamat(int,int);
float Emoji(int);

float a = 0 , b = 0 , c = 0 , q , t;
int i ;
char y=0 , lcd[25] , z   ;

void main(void){

DDRB=0x0F;
DDRC=0x07;
DDRD=0x0F;

lcd_init(16);
while (1){
_Main();
}
}

float _Main(void){
int Loop = 1 ;
y = key();
if( y == 15 ){a = 0 ;b = 0 ;c = 0 ;lcd_clear();return 0 ;}
if( y < 10 ){
a = (a*10)+y ;
itoa(y , lcd);
lcd_puts(lcd);
delay_ms(50);
}

if( y > 9 && y < 16 ){
if( y == 15 ){a = 0 ;b = 0 ;c = 0 ;lcd_clear();return 0 ;}
z = y ;
Alamat(y,1);
while(Loop){
y = key();
if( y == 15 ){a = 0 ;b = 0 ;c = 0 ;lcd_clear();return 0 ;}
if( y < 10 ){
b = (b*10)+y ;
itoa(y , lcd);
lcd_puts(lcd);
delay_ms(50); 
}else if(y == 14){
lcd_putchar('=');
Mohasebe();
y = 0 ;
Loop = 0 ;
}
}
} 
if( y > 15 ){
lcd_clear();
a= 0 ; b = 0 ; c = 0;
Alamat(y , 2);
z = y ;
Loop = 1 ;
while(Loop){
y = key();
if( y == 15 ){a = 0 ;b = 0 ;c = 0 ;lcd_clear();return 0 ;}
if(y <  10){
a = (a*10) + y ;
itoa(y , lcd);
lcd_puts(lcd);
delay_ms(50);
}else if ( y == 14){
lcd_putchar('=');
Mohandes();
}
Loop = 1 ;
}
}
return 0;
}

void Mohasebe(void){                                          
if(z == 10)c = a / b ;
if(z == 11)c = a * b ;
if(z == 12)c = a - b ;
if(z == 13)c = a + b ;
ftoa(c , 3 , lcd);            
lcd_puts(lcd);
delay_ms(100);
}

float Emoji(int rr){
q=1;
for(i=0;i<rr;i++)q = q * 2.71728 ;
return q;	
}

void Mohandes(void){
t = (3.1415926535897932384626433832795/180)*a ;
if(z == 16)c = sin(t) ;
if(z == 17)c = cos(t) ;
if(z == 18)c = tan(t) ;
if(z == 19)c = 1/tan(t) ;
if(z == 20)c = asin(t) ;
if(z == 21)c = acos(t) ;
if(z == 22)c = log(a) ;
if(z == 23)c = sqrt(a) ;
if(z == 24)c = Emoji(a) ;
ftoa(c , 3 , lcd);            
lcd_puts(lcd);
delay_ms(100);
}

void Alamat(int Moji,int Halat){
if(Halat == 1){
if(Moji == 10)lcd_putchar('/') ;
if(Moji == 11)lcd_putchar('*') ;
if(Moji == 12)lcd_putchar('-') ;
if(Moji == 13)lcd_putchar('+') ; 
delay_ms(100);      
}
if(Halat == 2){
if(Moji == 16)lcd_putsf("Sin ") ;
if(Moji == 17)lcd_putsf("Cos ") ;
if(Moji == 18)lcd_putsf("Tan ") ;
if(Moji == 19)lcd_putsf("Cot ") ;  
if(Moji == 20)lcd_putsf("aSin") ;
if(Moji == 21)lcd_putsf("aCos") ;
if(Moji == 22)lcd_putsf("Log ") ;
if(Moji == 23)lcd_putsf("Sqrt ") ;  
if(Moji == 24)lcd_putsf("exp ") ;
delay_ms(100);

}
}

int key(void){
char KEY = 1 ;
while(KEY){

PORTD.0 = 1 ;
PORTD.1 = 0 ;
PORTD.2 = 0 ;
PORTD.3 = 0 ;
if(PIND.4 == 1){return 7 ; KEY = 0;delay_ms(50);}     
if(PIND.5 == 1){return 8 ; KEY = 0;delay_ms(50);}    
if(PIND.6 == 1){return 9 ; KEY = 0;delay_ms(50);}   
if(PIND.7 == 1){return 10; KEY = 0;delay_ms(50);}       

PORTD.0 = 0 ;
PORTD.1 = 1 ;
PORTD.2 = 0 ;
PORTD.3 = 0 ;
if(PIND.4 == 1){return 4 ; KEY = 0;}     
if(PIND.5 == 1){return 5 ; KEY = 0;}    
if(PIND.6 == 1){return 6 ; KEY = 0;}
if(PIND.7 == 1){return 11; KEY = 0;}       

PORTD.0 = 0 ;
PORTD.1 = 0 ;
PORTD.2 = 1 ;
PORTD.3 = 0 ;
if(PIND.4 == 1){return 1 ; KEY = 0;}         
if(PIND.5 == 1){return 2 ; KEY = 0;}       
if(PIND.6 == 1){return 3 ; KEY = 0;}      
if(PIND.7 == 1){return 12; KEY = 0;}         

PORTD.0 = 0 ;
PORTD.1 = 0 ;
PORTD.2 = 0 ;
PORTD.3 = 1 ;
if(PIND.4 == 1){return 15; KEY = 0;}        
if(PIND.5 == 1){return 0 ; KEY = 0;}        
if(PIND.6 == 1){return 14; KEY = 0;}       
if(PIND.7 == 1){return 13; KEY = 0;}

PORTC.0 = 1 ;
PORTC.1 = 0 ;
PORTC.2 = 0 ;
if(PINC.5 == 1){return 16 ; KEY=0;}
if(PINC.6 == 1){return 17; KEY=0;}
if(PINC.7 == 1){return 18 ; KEY=0;}

PORTC.0 = 0 ;
PORTC.1 = 1 ;
PORTC.2 = 0 ;
if(PINC.5 == 1){return 19 ; KEY=0;}         
if(PINC.6 == 1){return 20 ; KEY=0;}
if(PINC.7 == 1){return 21 ; KEY=0;}

PORTC.0 = 0 ;
PORTC.1 = 0 ;
PORTC.2 = 1 ;
if(PINC.5 == 1){return 22 ; KEY=0;} 
if(PINC.6 == 1){return 23 ; KEY=0;}
if(PINC.7 == 1){return 24 ; KEY=0;}

KEY = 1 ;       
}
}

