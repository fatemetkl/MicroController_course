;
; AVRasm.asm
;
; Created: 12/12/2018 6:22:38 AM
; Author : fateme
;
    .INCLUDE "M32DEF.INC"
	.ORG 0
	
	LDI R16, HIGH(RAMEND)
	OUT SPH, R16
	LDI R16, LOW(RAMEND)
	OUT SPL, R16
	LDI R16, 0x0F // FIRST 4 PINS AS OUTPUT
	OUT DDRc, R16 
	

MAIN:
        LDI R16,  0x00 
	    OUT PORTC, R16
		CALL Delay

		LDI R16, 0x08
		OUT PORTC, R16
		CALL Delay

		LDI R16, 0x04
		OUT PORTC, R16
		CALL Delay

		LDI R16, 0x02
		OUT PORTC, R16
		CALL Delay

		LDI R16, 0x01
		OUT PORTC, R16
		CALL Delay

		RJMP MAIN

Delay:
        LDI R16, 0xFF


AGAIN: NOP
       NOP
	   NOP
	   DEC R16
	   BRNE AGAIN
	   RET