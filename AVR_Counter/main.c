 
 #define F_CPU 1000000
 #include <util/delay.h>
 #include <avr/io.h>
 //Declare global variable here
 
 #define _0char  0b00110000
 #define _1char  0b00110001
 #define _2char  0b00000010
 #define _3char  0b00110011
 #define _4char  0b00110100
  #define _5char  0b00110101
  #define _6char  0b00110110
  #define _7char  0b00110111
  #define _8char  0b00111000 
 #define _9char  0b00111001
  #define _10char  0b00111010 //A
  #define _11char  0b00111011 //B
   #define _12char  0b00111100  //C
    #define _13char  0b00111101   //D
	 #define _14char  0b00111110  //E
	  #define _15char  0b00111111 //F

 #define S1pressed  0b11111110
 #define S2pressed  0b11111101
 #define S3pressed 0b11111011
 #define S4pressed 0b11110111
       
 
 
 
 int main(void)
 {
	 DDRC |= (1<<PC0);// output
	 DDRC |= (1<<PC1);
	 DDRC |= (1<<PC2);
	 DDRC |= (1<<PC3);
	 DDRC |= (1<<PC4);
	 DDRA &= ~(1<<PA0); // input
	 DDRA &= ~(1<<PA1);
	 DDRA &= ~(1<<PA2);
	 DDRA &= ~(1<<PA3);
	 volatile uint8_t SWData;
	 DDRA=0b00000000;
	 PORTA=0b11111111;
	 while(1)
	 {
		 SWData=PINA|0b11110000;
		 switch (SWData)
		 {
			 case S1pressed:
			 Do(1);
			 
			 break;
			 case S2pressed:
			 Do(2);
			 
			 break;
			 case S3pressed:
			 Do(4);
			 
			 break;
			 case S4pressed:
			 Do(8);
			  
			 break;
			 case S1pressed & S2pressed:
			 Do(3);
			 
			 break;
			  
			  case S2pressed & S3pressed:
			  Do(6);
			  
			  break;
			  
			   case S3pressed & S4pressed:
			   Do(12);
			   
			   break;
			  case S1pressed & S4pressed:
			  Do(9);
			  
			  break;
			  case S1pressed & S3pressed:
			  Do(5);
			  
			  break;  
			 case S4pressed & S2pressed:
			 Do(10);
			 
			 
		 case S1pressed & S2pressed & S3pressed:
		 Do(7);
		 
		 break;	 
		 
		 
		  case S1pressed & S2pressed & S4pressed:
		  Do(11);
		  
		  break;
		 case S2pressed & S3pressed & S4pressed:
		 Do(14);
	
		 break;	 
	     case S1pressed & S3pressed & S4pressed:
	     Do(13);
	 
	     break;
		 
		 case S1pressed & S3pressed & S4pressed &S2pressed:
		 Do(15);
		 
		 break; 	 
			 break;   
			 default:
			 break;
		 }
	 }
 }
 void Do(int n)
 {
	 char ssd[]={0b00110000, 0b00110001, 0b00000010,0b00110011, 0b00110100,0b00110101,0b00110110,0b00110111,0b00111000,0b00111001,0b00111010,0b00111011,0b00111100,0b00111101,0b00111110 ,0b00111111  };
for (int i=0; i<=n ;i++){
	PORTC =	 ssd[i];
	_delay_ms(1000);
 }
 
 }


	