/*   
To download other free projects visit www.avrprojects.info

*/

#include <mega16.h>
#include <delay.h>
#include <lcd.h>
#include <stdlib.h>
#include <math.h>

#asm
   .equ __lcd_port=0x18
#endasm
//#############################################
int key(void);
float _Main(void);
void Mohandes(void);
void Mohasebe(void);
void Alamat(int,int);
float Emoji(int);
//#############################################
float a = 0 , b = 0 , c = 0 , q , t;
int i ;
char y=0 , lcd[25] , z   ;
//#############################################
void main(void){

DDRB=0x0F;
DDRC=0x07;
DDRD=0x0F;

lcd_init(16);
while (1){
_Main();
}
}
//#############################################################
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
//##########################################################
void Mohasebe(void){                                          
if(z == 10)c = a / b ;
if(z == 11)c = a * b ;
if(z == 12)c = a - b ;
if(z == 13)c = a + b ;
ftoa(c , 3 , lcd);            
lcd_puts(lcd);
delay_ms(100);
}
//#########################################################
float Emoji(int rr){
q=1;
for(i=0;i<rr;i++)q = q * 2.71728 ;
return q;	
}
//#########################################################   
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
//#########################################################
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
//#########################################################
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
        //==========================================
        PORTD.0 = 0 ;
        PORTD.1 = 1 ;
        PORTD.2 = 0 ;
        PORTD.3 = 0 ;
        if(PIND.4 == 1){return 4 ; KEY = 0;}     
        if(PIND.5 == 1){return 5 ; KEY = 0;}    
        if(PIND.6 == 1){return 6 ; KEY = 0;}
        if(PIND.7 == 1){return 11; KEY = 0;}       
        //==========================================
        PORTD.0 = 0 ;
        PORTD.1 = 0 ;
        PORTD.2 = 1 ;
        PORTD.3 = 0 ;
        if(PIND.4 == 1){return 1 ; KEY = 0;}         
        if(PIND.5 == 1){return 2 ; KEY = 0;}       
        if(PIND.6 == 1){return 3 ; KEY = 0;}      
        if(PIND.7 == 1){return 12; KEY = 0;}         
        //==========================================
        PORTD.0 = 0 ;
        PORTD.1 = 0 ;
        PORTD.2 = 0 ;
        PORTD.3 = 1 ;
        if(PIND.4 == 1){return 15; KEY = 0;}        
        if(PIND.5 == 1){return 0 ; KEY = 0;}        
        if(PIND.6 == 1){return 14; KEY = 0;}       
        if(PIND.7 == 1){return 13; KEY = 0;}

        //=============================================================================
        PORTC.0 = 1 ;
        PORTC.1 = 0 ;
        PORTC.2 = 0 ;
        if(PINC.5 == 1){return 16 ; KEY=0;}
        if(PINC.6 == 1){return 17; KEY=0;}
        if(PINC.7 == 1){return 18 ; KEY=0;}
        //===================================================== 
        PORTC.0 = 0 ;
        PORTC.1 = 1 ;
        PORTC.2 = 0 ;
        if(PINC.5 == 1){return 19 ; KEY=0;}         
        if(PINC.6 == 1){return 20 ; KEY=0;}
        if(PINC.7 == 1){return 21 ; KEY=0;}
        //=====================================================
        PORTC.0 = 0 ;
        PORTC.1 = 0 ;
        PORTC.2 = 1 ;
        if(PINC.5 == 1){return 22 ; KEY=0;} 
        if(PINC.6 == 1){return 23 ; KEY=0;}
        if(PINC.7 == 1){return 24 ; KEY=0;}
 
KEY = 1 ;       
}
}
//############################################################

