/*******************************************************
This program was created by the CodeWizardAVR V3.34 
Automatic Program Generator
© Copyright 1998-2018 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 1/30/2019
Author  : 
Company : 
Comments: 


Chip type               : ATmega32
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 512
*******************************************************/

#include <mega32.h>
#include <delay.h>
#include <stdlib.h>

// Alphanumeric LCD Module functions
#asm
   .equ __lcd_port=0x15 ;PORTC
#endasm
#include <lcd.h>

// Declare your global variables here
void main(void)
{

unsigned int op= 0;
long int_R;// result from operations
char Char_R;// char shows on lcd

unsigned int num1,num2= 0;//numbers from input
unsigned int digit_tmp = 11;//default

PORTC=0x00;
DDRC=0x00;
PORTD=0x00;
DDRD=0x0F;
ACSR=0x80;
SFIOR=0x00;    



lcd_init(16);
while (1)///////////////////////////////chech 4ever
      {
      PORTD = 0b00000001; 
      
      if (PIND == 0b00010001)//check if the first column is pressed= number 1
      {  
         while (PIND == 0b00010001){
            PORTD = 0;
         }
         lcd_putchar('1');
         digit_tmp= 1; 
         delay_ms(200); 
      }  
      else if (PIND == 0b00100001)//check if the sec column is pressed = bumber 2
      {  
         while (PIND == 0b00100001){
            PORTD = 0;//reset portD
         }
         lcd_putchar('2');
         digit_tmp = 2; 
         delay_ms(200);
      }
      else if (PIND == 0b01000001)//check if the 3rd column is pressed number 3
      {  
         while (PIND == 0b01000001){
            PORTD = 0;
         }                
         lcd_putchar('3');
         digit_tmp = 3; 
         delay_ms(200);
      }
      else if (PIND == 0b10000001)//first op is / division
      {  
         while (PIND == 0b10000001){
            PORTD = 0;
         }
         lcd_putchar('/');
         op = 1; 
         delay_ms(200);        
      }
                
      PORTD = 0b00000010;  // row 2 is preseeed
      if (PIND == 0b00010010)
      {  
         while (PIND == 0b00010010){ // check if 4 is pressed
            PORTD = 0;
         }         
         lcd_putchar('4');
         digit_tmp = 4; 
         delay_ms(200);
      }   
      else if (PIND == 0b00100010)
      { 
         while (PIND == 0b00100010){ //check for num5
            PORTD = 0;
         }
         lcd_putchar('5');
         digit_tmp= 5; 
         delay_ms(200);
      }
      else if (PIND == 0b01000010)
      {                                
         while (PIND == 0b01000010){// check for number 6
            PORTD = 0;
         }                
         lcd_putchar('6');
         digit_tmp = 6; 
         delay_ms(200);
      }
      else if (PIND == 0b10000010)
      { 
         while (PIND == 0b10000010){ // check for * op
            PORTD = 0;
         }
         lcd_putchar('*');
         op = 2; 
         delay_ms(200);        
      }
      
      PORTD = 0b00000100; 
      
      if (PIND == 0b00010100)
      { 
         while (PIND == 0b00010100){ //check for number 7
            PORTD = 0;
         }         
         lcd_putchar('7');
         digit_tmp = 7; 
         delay_ms(200);
      }  
      else if (PIND == 0b00100100)
      { 
         while (PIND == 0b00100100){ // check for number 8
            PORTD = 0;
         }
         lcd_putchar('8');
         digit_tmp = 8; 
         delay_ms(200);
      }
      else if (PIND == 0b01000100)
      { 
         while (PIND == 0b01000100){// check for number 9
            PORTD = 0;
         }                
         lcd_putchar('9');
         digit_tmp = 9; 
         delay_ms(200);
      }
      else if (PIND == 0b10000100)
      { 
         while (PIND == 0b10000100){  //check for - operation
            PORTD = 0;
         }
         lcd_putchar('-');
         op = 3; 
         delay_ms(200);        
      }
      
      PORTD = 0b00001000; 
      
      if (PIND == 0b00011000)
      { 
         while (PIND == 0b00011000){ // if the button number 13 is pressed do the reset
            PORTD = 0;
         }         
         lcd_clear();
         num1 = 0;
         num2 = 0;
         digit_tmp = 11; //default digit temp
         op= 0; 
         delay_ms(200);
      }   
     
      else if (PIND == 0b01001000)
      { 
         while (PIND == 0b01001000){ //last row and 3rd column is = ... number 10
            PORTD = 0;
         }                
         lcd_putchar('=');
         digit_tmp = 10; 
         delay_ms(200);
      }
      else if (PIND == 0b10001000)
      { 
         while (PIND == 0b10001000){ //last button for +
            PORTD = 0;
         }
         lcd_putchar('+');
         op = 4; 
         delay_ms(200);        
      }
        if(digit_tmp== 10) // do the opertaion
      {
          switch (op){
          case 1:
              int_R=num1/num2;
              break;
          case 2:
              int_R= num1*num2;
              break;                     
          case 3:
              int_R=num1-num2;
              break;
          case 4:
              int_R =num1+num2;
              break;
          }
          lcd_clear();
          lcd_gotoxy(0,0);   
          ltoa(int_R,&Char_R); //show result 
          lcd_puts(&Char_R);
          num1= 0;
          num2 = 0;
          digit_tmp= 11;
          op = 0;              
      }
      else if (digit_tmp < 10) //get number input and add the next digit
      {
          if (op == 0)
              num1= num1*10+digit_tmp;
          else
              num2= num2*10+digit_tmp;
          digit_tmp = 11;
      } 
	   if (PIND == 0b00101000)
      { 
         while (PIND == 0b00101000){ // there is 0 number next to reset
            PORTD = 0;
         }
         lcd_putchar('0');
         digit_tmp= 0; 
         delay_ms(200);
      }                                
   
      };
}
