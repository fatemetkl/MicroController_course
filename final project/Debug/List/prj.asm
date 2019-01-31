
;CodeVisionAVR C Compiler V3.34 Evaluation
;(C) Copyright 1998-2018 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega32
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 512 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Mode 2
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega32
	#pragma AVRPART MEMORY PROG_FLASH 32768
	#pragma AVRPART MEMORY EEPROM 1024
	#pragma AVRPART MEMORY INT_SRAM SIZE 2048
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x085F
	.EQU __DSTACK_SIZE=0x0200
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD2M
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF __lcd_x=R5
	.DEF __lcd_y=R4
	.DEF __lcd_maxx=R7

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G105:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G105:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0x2000060:
	.DB  0x1
_0x2000000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0
_0x2020003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  __seed_G100
	.DW  _0x2000060*2

	.DW  0x02
	.DW  __base_y_G101
	.DW  _0x2020003*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0x00

	.DSEG
	.ORG 0x260

	.CSEG
;/*******************************************************
;This program was created by the CodeWizardAVR V3.34
;Automatic Program Generator
;© Copyright 1998-2018 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 1/30/2019
;Author  :
;Company :
;Comments:
;
;
;Chip type               : ATmega32
;Program type            : Application
;AVR Core Clock frequency: 8.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 512
;*******************************************************/
;
;#include <mega32.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;#include <stdlib.h>
;
;// Alphanumeric LCD Module functions
;#asm
   .equ __lcd_port=0x15 ;PORTC
; 0000 001E #endasm
;#include <lcd.h>
;
;// Declare your global variables here
;void main(void)
; 0000 0023 {

	.CSEG
_main:
; .FSTART _main
; 0000 0024 
; 0000 0025 unsigned int op= 0;
; 0000 0026 long int_R;// result from operations
; 0000 0027 char Char_R;// char shows on lcd
; 0000 0028 
; 0000 0029 unsigned int num1,num2= 0;//numbers from input
; 0000 002A unsigned int digit_tmp = 11;//default
; 0000 002B 
; 0000 002C PORTC=0x00;
	SBIW R28,8
	LDI  R30,LOW(11)
	ST   Y,R30
	LDI  R30,LOW(0)
	STD  Y+1,R30
	STD  Y+2,R30
	STD  Y+3,R30
;	op -> R16,R17
;	int_R -> Y+4
;	Char_R -> R19
;	num1 -> R20,R21
;	num2 -> Y+2
;	digit_tmp -> Y+0
	__GETWRN 16,17,0
	OUT  0x15,R30
; 0000 002D DDRC=0x00;
	OUT  0x14,R30
; 0000 002E PORTD=0x00;
	OUT  0x12,R30
; 0000 002F DDRD=0x0F;
	LDI  R30,LOW(15)
	OUT  0x11,R30
; 0000 0030 ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 0031 SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 0032 
; 0000 0033 
; 0000 0034 
; 0000 0035 lcd_init(16);
	LDI  R26,LOW(16)
	RCALL _lcd_init
; 0000 0036 while (1)///////////////////////////////chech 4ever
_0x3:
; 0000 0037       {
; 0000 0038       PORTD = 0b00000001; //check if the first row is pressed
	LDI  R30,LOW(1)
	OUT  0x12,R30
; 0000 0039 
; 0000 003A       if (PIND == 0b00010001)//check if the first column is pressed= number 1
	IN   R30,0x10
	CPI  R30,LOW(0x11)
	BRNE _0x6
; 0000 003B       {
; 0000 003C          while (PIND == 0b00010001){
_0x7:
	IN   R30,0x10
	CPI  R30,LOW(0x11)
	BRNE _0x9
; 0000 003D             PORTD = 0;
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 003E          }
	RJMP _0x7
_0x9:
; 0000 003F          lcd_putchar('1');
	LDI  R26,LOW(49)
	RCALL _lcd_putchar
; 0000 0040          digit_tmp= 1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   Y,R30
	STD  Y+1,R31
; 0000 0041          delay_ms(200);
	RJMP _0x5F
; 0000 0042       }
; 0000 0043       else if (PIND == 0b00100001)//check if the sec column is pressed = bumber 2
_0x6:
	IN   R30,0x10
	CPI  R30,LOW(0x21)
	BRNE _0xB
; 0000 0044       {
; 0000 0045          while (PIND == 0b00100001){
_0xC:
	IN   R30,0x10
	CPI  R30,LOW(0x21)
	BRNE _0xE
; 0000 0046             PORTD = 0;//reset portD
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 0047          }
	RJMP _0xC
_0xE:
; 0000 0048          lcd_putchar('2');
	LDI  R26,LOW(50)
	RCALL _lcd_putchar
; 0000 0049          digit_tmp = 2;
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	ST   Y,R30
	STD  Y+1,R31
; 0000 004A          delay_ms(200);
	RJMP _0x5F
; 0000 004B       }
; 0000 004C       else if (PIND == 0b01000001)//check if the 3rd column is pressed number 3
_0xB:
	IN   R30,0x10
	CPI  R30,LOW(0x41)
	BRNE _0x10
; 0000 004D       {
; 0000 004E          while (PIND == 0b01000001){
_0x11:
	IN   R30,0x10
	CPI  R30,LOW(0x41)
	BRNE _0x13
; 0000 004F             PORTD = 0;
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 0050          }
	RJMP _0x11
_0x13:
; 0000 0051          lcd_putchar('3');
	LDI  R26,LOW(51)
	RCALL _lcd_putchar
; 0000 0052          digit_tmp = 3;
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	ST   Y,R30
	STD  Y+1,R31
; 0000 0053          delay_ms(200);
	RJMP _0x5F
; 0000 0054       }
; 0000 0055       else if (PIND == 0b10000001)//first op is / division
_0x10:
	IN   R30,0x10
	CPI  R30,LOW(0x81)
	BRNE _0x15
; 0000 0056       {
; 0000 0057          while (PIND == 0b10000001){
_0x16:
	IN   R30,0x10
	CPI  R30,LOW(0x81)
	BRNE _0x18
; 0000 0058             PORTD = 0;
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 0059          }
	RJMP _0x16
_0x18:
; 0000 005A          lcd_putchar('/');
	LDI  R26,LOW(47)
	RCALL _lcd_putchar
; 0000 005B          op = 1;
	__GETWRN 16,17,1
; 0000 005C          delay_ms(200);
_0x5F:
	LDI  R26,LOW(200)
	LDI  R27,0
	RCALL _delay_ms
; 0000 005D       }
; 0000 005E 
; 0000 005F       PORTD = 0b00000010;  // row 2 is preseeed
_0x15:
	LDI  R30,LOW(2)
	OUT  0x12,R30
; 0000 0060       if (PIND == 0b00010010)
	IN   R30,0x10
	CPI  R30,LOW(0x12)
	BRNE _0x19
; 0000 0061       {
; 0000 0062          while (PIND == 0b00010010){ // check if 4 is pressed
_0x1A:
	IN   R30,0x10
	CPI  R30,LOW(0x12)
	BRNE _0x1C
; 0000 0063             PORTD = 0;
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 0064          }
	RJMP _0x1A
_0x1C:
; 0000 0065          lcd_putchar('4');
	LDI  R26,LOW(52)
	RCALL _lcd_putchar
; 0000 0066          digit_tmp = 4;
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	ST   Y,R30
	STD  Y+1,R31
; 0000 0067          delay_ms(200);
	RJMP _0x60
; 0000 0068       }
; 0000 0069       else if (PIND == 0b00100010)
_0x19:
	IN   R30,0x10
	CPI  R30,LOW(0x22)
	BRNE _0x1E
; 0000 006A       {
; 0000 006B          while (PIND == 0b00100010){ //check for num5
_0x1F:
	IN   R30,0x10
	CPI  R30,LOW(0x22)
	BRNE _0x21
; 0000 006C             PORTD = 0;
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 006D          }
	RJMP _0x1F
_0x21:
; 0000 006E          lcd_putchar('5');
	LDI  R26,LOW(53)
	RCALL _lcd_putchar
; 0000 006F          digit_tmp= 5;
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	ST   Y,R30
	STD  Y+1,R31
; 0000 0070          delay_ms(200);
	RJMP _0x60
; 0000 0071       }
; 0000 0072       else if (PIND == 0b01000010)
_0x1E:
	IN   R30,0x10
	CPI  R30,LOW(0x42)
	BRNE _0x23
; 0000 0073       {
; 0000 0074          while (PIND == 0b01000010){// check for number 6
_0x24:
	IN   R30,0x10
	CPI  R30,LOW(0x42)
	BRNE _0x26
; 0000 0075             PORTD = 0;
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 0076          }
	RJMP _0x24
_0x26:
; 0000 0077          lcd_putchar('6');
	LDI  R26,LOW(54)
	RCALL _lcd_putchar
; 0000 0078          digit_tmp = 6;
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	ST   Y,R30
	STD  Y+1,R31
; 0000 0079          delay_ms(200);
	RJMP _0x60
; 0000 007A       }
; 0000 007B       else if (PIND == 0b10000010)
_0x23:
	IN   R30,0x10
	CPI  R30,LOW(0x82)
	BRNE _0x28
; 0000 007C       {
; 0000 007D          while (PIND == 0b10000010){ // check for * op
_0x29:
	IN   R30,0x10
	CPI  R30,LOW(0x82)
	BRNE _0x2B
; 0000 007E             PORTD = 0;
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 007F          }
	RJMP _0x29
_0x2B:
; 0000 0080          lcd_putchar('*');
	LDI  R26,LOW(42)
	RCALL _lcd_putchar
; 0000 0081          op = 2;
	__GETWRN 16,17,2
; 0000 0082          delay_ms(200);
_0x60:
	LDI  R26,LOW(200)
	LDI  R27,0
	RCALL _delay_ms
; 0000 0083       }
; 0000 0084 
; 0000 0085       PORTD = 0b00000100;
_0x28:
	LDI  R30,LOW(4)
	OUT  0x12,R30
; 0000 0086 
; 0000 0087       if (PIND == 0b00010100)
	IN   R30,0x10
	CPI  R30,LOW(0x14)
	BRNE _0x2C
; 0000 0088       {
; 0000 0089          while (PIND == 0b00010100){ //check for number 7
_0x2D:
	IN   R30,0x10
	CPI  R30,LOW(0x14)
	BRNE _0x2F
; 0000 008A             PORTD = 0;
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 008B          }
	RJMP _0x2D
_0x2F:
; 0000 008C          lcd_putchar('7');
	LDI  R26,LOW(55)
	RCALL _lcd_putchar
; 0000 008D          digit_tmp = 7;
	LDI  R30,LOW(7)
	LDI  R31,HIGH(7)
	ST   Y,R30
	STD  Y+1,R31
; 0000 008E          delay_ms(200);
	RJMP _0x61
; 0000 008F       }
; 0000 0090       else if (PIND == 0b00100100)
_0x2C:
	IN   R30,0x10
	CPI  R30,LOW(0x24)
	BRNE _0x31
; 0000 0091       {
; 0000 0092          while (PIND == 0b00100100){ // check for number 8
_0x32:
	IN   R30,0x10
	CPI  R30,LOW(0x24)
	BRNE _0x34
; 0000 0093             PORTD = 0;
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 0094          }
	RJMP _0x32
_0x34:
; 0000 0095          lcd_putchar('8');
	LDI  R26,LOW(56)
	RCALL _lcd_putchar
; 0000 0096          digit_tmp = 8;
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	ST   Y,R30
	STD  Y+1,R31
; 0000 0097          delay_ms(200);
	RJMP _0x61
; 0000 0098       }
; 0000 0099       else if (PIND == 0b01000100)
_0x31:
	IN   R30,0x10
	CPI  R30,LOW(0x44)
	BRNE _0x36
; 0000 009A       {
; 0000 009B          while (PIND == 0b01000100){// check for number 9
_0x37:
	IN   R30,0x10
	CPI  R30,LOW(0x44)
	BRNE _0x39
; 0000 009C             PORTD = 0;
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 009D          }
	RJMP _0x37
_0x39:
; 0000 009E          lcd_putchar('9');
	LDI  R26,LOW(57)
	RCALL _lcd_putchar
; 0000 009F          digit_tmp = 9;
	LDI  R30,LOW(9)
	LDI  R31,HIGH(9)
	ST   Y,R30
	STD  Y+1,R31
; 0000 00A0          delay_ms(200);
	RJMP _0x61
; 0000 00A1       }
; 0000 00A2       else if (PIND == 0b10000100)
_0x36:
	IN   R30,0x10
	CPI  R30,LOW(0x84)
	BRNE _0x3B
; 0000 00A3       {
; 0000 00A4          while (PIND == 0b10000100){  //check for - operation
_0x3C:
	IN   R30,0x10
	CPI  R30,LOW(0x84)
	BRNE _0x3E
; 0000 00A5             PORTD = 0;
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 00A6          }
	RJMP _0x3C
_0x3E:
; 0000 00A7          lcd_putchar('-');
	LDI  R26,LOW(45)
	RCALL _lcd_putchar
; 0000 00A8          op = 3;
	__GETWRN 16,17,3
; 0000 00A9          delay_ms(200);
_0x61:
	LDI  R26,LOW(200)
	LDI  R27,0
	RCALL _delay_ms
; 0000 00AA       }
; 0000 00AB 
; 0000 00AC       PORTD = 0b00001000;
_0x3B:
	LDI  R30,LOW(8)
	OUT  0x12,R30
; 0000 00AD 
; 0000 00AE       if (PIND == 0b00011000)
	IN   R30,0x10
	CPI  R30,LOW(0x18)
	BRNE _0x3F
; 0000 00AF       {
; 0000 00B0          while (PIND == 0b00011000){ // if the button number 13 is pressed do the reset
_0x40:
	IN   R30,0x10
	CPI  R30,LOW(0x18)
	BRNE _0x42
; 0000 00B1             PORTD = 0;
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 00B2          }
	RJMP _0x40
_0x42:
; 0000 00B3          lcd_clear();
	RCALL _lcd_clear
; 0000 00B4          num1 = 0;
	RCALL SUBOPT_0x0
; 0000 00B5          num2 = 0;
; 0000 00B6          digit_tmp = 11; //default digit temp
; 0000 00B7          op= 0;
; 0000 00B8          delay_ms(200);
	RJMP _0x62
; 0000 00B9       }
; 0000 00BA       else if (PIND == 0b00101000)
_0x3F:
	IN   R30,0x10
	CPI  R30,LOW(0x28)
	BRNE _0x44
; 0000 00BB       {
; 0000 00BC          while (PIND == 0b00101000){ // there is 0 number next to reset
_0x45:
	IN   R30,0x10
	CPI  R30,LOW(0x28)
	BRNE _0x47
; 0000 00BD             PORTD = 0;
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 00BE          }
	RJMP _0x45
_0x47:
; 0000 00BF          lcd_putchar('0');
	LDI  R26,LOW(48)
	RCALL _lcd_putchar
; 0000 00C0          digit_tmp= 0;
	LDI  R30,LOW(0)
	STD  Y+0,R30
	STD  Y+0+1,R30
; 0000 00C1          delay_ms(200);
	RJMP _0x62
; 0000 00C2       }
; 0000 00C3       else if (PIND == 0b01001000)
_0x44:
	IN   R30,0x10
	CPI  R30,LOW(0x48)
	BRNE _0x49
; 0000 00C4       {
; 0000 00C5          while (PIND == 0b01001000){ //last row and 3rd column is = ... number 10
_0x4A:
	IN   R30,0x10
	CPI  R30,LOW(0x48)
	BRNE _0x4C
; 0000 00C6             PORTD = 0;
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 00C7          }
	RJMP _0x4A
_0x4C:
; 0000 00C8          lcd_putchar('=');
	LDI  R26,LOW(61)
	RCALL _lcd_putchar
; 0000 00C9          digit_tmp = 10;
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   Y,R30
	STD  Y+1,R31
; 0000 00CA          delay_ms(200);
	RJMP _0x62
; 0000 00CB       }
; 0000 00CC       else if (PIND == 0b10001000)
_0x49:
	IN   R30,0x10
	CPI  R30,LOW(0x88)
	BRNE _0x4E
; 0000 00CD       {
; 0000 00CE          while (PIND == 0b10001000){ //last button for +
_0x4F:
	IN   R30,0x10
	CPI  R30,LOW(0x88)
	BRNE _0x51
; 0000 00CF             PORTD = 0;
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 00D0          }
	RJMP _0x4F
_0x51:
; 0000 00D1          lcd_putchar('+');
	LDI  R26,LOW(43)
	RCALL _lcd_putchar
; 0000 00D2          op = 4;
	__GETWRN 16,17,4
; 0000 00D3          delay_ms(200);
_0x62:
	LDI  R26,LOW(200)
	LDI  R27,0
	RCALL _delay_ms
; 0000 00D4       }
; 0000 00D5       if (digit_tmp < 10) //get number input and add the next digit
_0x4E:
	LD   R26,Y
	LDD  R27,Y+1
	SBIW R26,10
	BRSH _0x52
; 0000 00D6       {
; 0000 00D7           if (op == 0)
	MOV  R0,R16
	OR   R0,R17
	BRNE _0x53
; 0000 00D8               num1= num1*10+digit_tmp;
	__MULBNWRU 20,21,10
	RCALL SUBOPT_0x1
	MOVW R20,R30
; 0000 00D9           else
	RJMP _0x54
_0x53:
; 0000 00DA               num2= num2*10+digit_tmp;
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(10)
	CALL __MULB1W2U
	RCALL SUBOPT_0x1
	STD  Y+2,R30
	STD  Y+2+1,R31
; 0000 00DB           digit_tmp = 11;
_0x54:
	LDI  R30,LOW(11)
	LDI  R31,HIGH(11)
	ST   Y,R30
	STD  Y+1,R31
; 0000 00DC       }
; 0000 00DD       else if(digit_tmp== 10) // do the opertaion
	RJMP _0x55
_0x52:
	LD   R26,Y
	LDD  R27,Y+1
	SBIW R26,10
	BRNE _0x56
; 0000 00DE       {
; 0000 00DF           switch (op){
	MOVW R30,R16
; 0000 00E0           case 1:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x5A
; 0000 00E1               int_R=num1/num2;
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	MOVW R26,R20
	RCALL __DIVW21U
	RJMP _0x63
; 0000 00E2               break;
; 0000 00E3           case 2:
_0x5A:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x5B
; 0000 00E4               int_R= num1*num2;
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	MOVW R26,R20
	RCALL __MULW12U
	RJMP _0x63
; 0000 00E5               break;
; 0000 00E6           case 3:
_0x5B:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x5C
; 0000 00E7               int_R=num1-num2;
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	MOVW R30,R20
	SUB  R30,R26
	SBC  R31,R27
	RJMP _0x63
; 0000 00E8               break;
; 0000 00E9           case 4:
_0x5C:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x59
; 0000 00EA               int_R =num1+num2;
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ADD  R30,R20
	ADC  R31,R21
_0x63:
	CLR  R22
	CLR  R23
	RCALL SUBOPT_0x2
; 0000 00EB               break;
; 0000 00EC           }
_0x59:
; 0000 00ED           lcd_clear();
	RCALL _lcd_clear
; 0000 00EE           lcd_gotoxy(0,0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _lcd_gotoxy
; 0000 00EF           ltoa(int_R,&Char_R); //show result
	RCALL SUBOPT_0x3
	RCALL __PUTPARD1
	IN   R26,SPL
	IN   R27,SPH
	PUSH R19
	RCALL _ltoa
	POP  R19
; 0000 00F0           lcd_puts(&Char_R);
	IN   R26,SPL
	IN   R27,SPH
	PUSH R19
	RCALL _lcd_puts
	POP  R19
; 0000 00F1           num1= 0;
	RCALL SUBOPT_0x0
; 0000 00F2           num2 = 0;
; 0000 00F3           digit_tmp= 11;
; 0000 00F4           op = 0;
; 0000 00F5       }
; 0000 00F6       };
_0x56:
_0x55:
	RJMP _0x3
; 0000 00F7 }
_0x5E:
	RJMP _0x5E
; .FEND

	.CSEG
_ltoa:
; .FSTART _ltoa
	SBIW R28,4
	RCALL __SAVELOCR4
	MOVW R18,R26
	__GETD1N 0x3B9ACA00
	RCALL SUBOPT_0x2
	LDI  R16,LOW(0)
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2000003
	__GETD1S 8
	RCALL __ANEGD1
	RCALL SUBOPT_0x4
	MOVW R26,R18
	__ADDWRN 18,19,1
	LDI  R30,LOW(45)
	ST   X,R30
_0x2000003:
_0x2000005:
	RCALL SUBOPT_0x5
	RCALL __DIVD21U
	MOV  R17,R30
	CPI  R17,0
	BRNE _0x2000008
	CPI  R16,0
	BRNE _0x2000008
	RCALL SUBOPT_0x6
	__CPD2N 0x1
	BRNE _0x2000007
_0x2000008:
	PUSH R19
	PUSH R18
	__ADDWRN 18,19,1
	MOV  R30,R17
	SUBI R30,-LOW(48)
	POP  R26
	POP  R27
	ST   X,R30
	LDI  R16,LOW(1)
_0x2000007:
	RCALL SUBOPT_0x5
	RCALL __MODD21U
	RCALL SUBOPT_0x4
	RCALL SUBOPT_0x6
	__GETD1N 0xA
	RCALL __DIVD21U
	RCALL SUBOPT_0x2
	RCALL SUBOPT_0x3
	RCALL __CPD10
	BRNE _0x2000005
	MOVW R26,R18
	LDI  R30,LOW(0)
	ST   X,R30
	RCALL __LOADLOCR4
	ADIW R28,12
	RET
; .FEND

	.DSEG

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
    .equ __lcd_direction=__lcd_port-1
    .equ __lcd_pin=__lcd_port-2
    .equ __lcd_rs=0
    .equ __lcd_rd=1
    .equ __lcd_enable=2
    .equ __lcd_busy_flag=7

	.DSEG

	.CSEG
__lcd_delay_G101:
; .FSTART __lcd_delay_G101
    ldi   r31,15
__lcd_delay0:
    dec   r31
    brne  __lcd_delay0
	RET
; .FEND
__lcd_ready:
; .FSTART __lcd_ready
    in    r26,__lcd_direction
    andi  r26,0xf                 ;set as input
    out   __lcd_direction,r26
    sbi   __lcd_port,__lcd_rd     ;RD=1
    cbi   __lcd_port,__lcd_rs     ;RS=0
__lcd_busy:
	RCALL __lcd_delay_G101
    sbi   __lcd_port,__lcd_enable ;EN=1
	RCALL __lcd_delay_G101
    in    r26,__lcd_pin
    cbi   __lcd_port,__lcd_enable ;EN=0
	RCALL __lcd_delay_G101
    sbi   __lcd_port,__lcd_enable ;EN=1
	RCALL __lcd_delay_G101
    cbi   __lcd_port,__lcd_enable ;EN=0
    sbrc  r26,__lcd_busy_flag
    rjmp  __lcd_busy
	RET
; .FEND
__lcd_write_nibble_G101:
; .FSTART __lcd_write_nibble_G101
    andi  r26,0xf0
    or    r26,r27
    out   __lcd_port,r26          ;write
    sbi   __lcd_port,__lcd_enable ;EN=1
	RCALL __lcd_delay_G101
    cbi   __lcd_port,__lcd_enable ;EN=0
	RCALL __lcd_delay_G101
	RET
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
    cbi  __lcd_port,__lcd_rd 	  ;RD=0
    in    r26,__lcd_direction
    ori   r26,0xf0 | (1<<__lcd_rs) | (1<<__lcd_rd) | (1<<__lcd_enable) ;set as output
    out   __lcd_direction,r26
    in    r27,__lcd_port
    andi  r27,0xf
    ld    r26,y
	RCALL __lcd_write_nibble_G101
    ld    r26,y
    swap  r26
	RCALL __lcd_write_nibble_G101
    sbi   __lcd_port,__lcd_rd     ;RD=1
	JMP  _0x20C0001
; .FEND
__lcd_read_nibble_G101:
; .FSTART __lcd_read_nibble_G101
    sbi   __lcd_port,__lcd_enable ;EN=1
	RCALL __lcd_delay_G101
    in    r30,__lcd_pin           ;read
    cbi   __lcd_port,__lcd_enable ;EN=0
	RCALL __lcd_delay_G101
    andi  r30,0xf0
	RET
; .FEND
_lcd_read_byte0_G101:
; .FSTART _lcd_read_byte0_G101
	RCALL __lcd_delay_G101
	RCALL __lcd_read_nibble_G101
    mov   r26,r30
	RCALL __lcd_read_nibble_G101
    cbi   __lcd_port,__lcd_rd     ;RD=0
    swap  r30
    or    r30,r26
	RET
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R26
	RCALL __lcd_ready
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G101)
	SBCI R31,HIGH(-__base_y_G101)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R5,Y+1
	LDD  R4,Y+0
	ADIW R28,2
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	RCALL __lcd_ready
	LDI  R26,LOW(2)
	RCALL __lcd_write_data
	RCALL __lcd_ready
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	RCALL __lcd_ready
	LDI  R26,LOW(1)
	RCALL __lcd_write_data
	LDI  R30,LOW(0)
	MOV  R4,R30
	MOV  R5,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R26
    push r30
    push r31
    ld   r26,y
    set
    cpi  r26,10
    breq __lcd_putchar1
    clt
	CP   R5,R7
	BRLO _0x2020004
	__lcd_putchar1:
	INC  R4
	LDI  R30,LOW(0)
	ST   -Y,R30
	MOV  R26,R4
	RCALL _lcd_gotoxy
	brts __lcd_putchar0
_0x2020004:
	INC  R5
    rcall __lcd_ready
    sbi  __lcd_port,__lcd_rs ;RS=1
	LD   R26,Y
	RCALL __lcd_write_data
__lcd_putchar0:
    pop  r31
    pop  r30
	JMP  _0x20C0001
; .FEND
_lcd_puts:
; .FSTART _lcd_puts
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2020005:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x2020007
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2020005
_0x2020007:
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
__long_delay_G101:
; .FSTART __long_delay_G101
    clr   r26
    clr   r27
__long_delay0:
    sbiw  r26,1         ;2 cycles
    brne  __long_delay0 ;2 cycles
	RET
; .FEND
__lcd_init_write_G101:
; .FSTART __lcd_init_write_G101
	ST   -Y,R26
    cbi  __lcd_port,__lcd_rd 	  ;RD=0
    in    r26,__lcd_direction
    ori   r26,0xf7                ;set as output
    out   __lcd_direction,r26
    in    r27,__lcd_port
    andi  r27,0xf
    ld    r26,y
	RCALL __lcd_write_nibble_G101
    sbi   __lcd_port,__lcd_rd     ;RD=1
	RJMP _0x20C0001
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R26
    cbi   __lcd_port,__lcd_enable ;EN=0
    cbi   __lcd_port,__lcd_rs     ;RS=0
	LDD  R7,Y+0
	LD   R30,Y
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G101,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G101,3
	RCALL __long_delay_G101
	LDI  R26,LOW(48)
	RCALL __lcd_init_write_G101
	RCALL __long_delay_G101
	LDI  R26,LOW(48)
	RCALL __lcd_init_write_G101
	RCALL __long_delay_G101
	LDI  R26,LOW(48)
	RCALL __lcd_init_write_G101
	RCALL __long_delay_G101
	LDI  R26,LOW(32)
	RCALL __lcd_init_write_G101
	RCALL __long_delay_G101
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	RCALL __long_delay_G101
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	RCALL __long_delay_G101
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	RCALL __long_delay_G101
    in    r26,__lcd_direction
    andi  r26,0xf                 ;set as input
    out   __lcd_direction,r26
    sbi   __lcd_port,__lcd_rd     ;RD=1
	RCALL _lcd_read_byte0_G101
	CPI  R30,LOW(0x5)
	BREQ _0x202000B
	LDI  R30,LOW(0)
	RJMP _0x20C0001
_0x202000B:
	RCALL __lcd_ready
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
	LDI  R30,LOW(1)
_0x20C0001:
	ADIW R28,1
	RET
; .FEND

	.CSEG

	.CSEG

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG

	.DSEG
__seed_G100:
	.BYTE 0x4
__base_y_G101:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x0:
	__GETWRN 20,21,0
	LDI  R30,LOW(0)
	STD  Y+2,R30
	STD  Y+2+1,R30
	LDI  R30,LOW(11)
	LDI  R31,HIGH(11)
	ST   Y,R30
	STD  Y+1,R31
	__GETWRN 16,17,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1:
	LD   R26,Y
	LDD  R27,Y+1
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x2:
	__PUTD1S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x3:
	__GETD1S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4:
	__PUTD1S 8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x5:
	RCALL SUBOPT_0x3
	__GETD2S 8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x6:
	__GETD2S 4
	RET

;RUNTIME LIBRARY

	.CSEG
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__MULB1W2U:
	MOV  R22,R30
	MUL  R22,R26
	MOVW R30,R0
	MUL  R22,R27
	ADD  R31,R0
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVD21U:
	PUSH R19
	PUSH R20
	PUSH R21
	CLR  R0
	CLR  R1
	MOVW R20,R0
	LDI  R19,32
__DIVD21U1:
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	ROL  R0
	ROL  R1
	ROL  R20
	ROL  R21
	SUB  R0,R30
	SBC  R1,R31
	SBC  R20,R22
	SBC  R21,R23
	BRCC __DIVD21U2
	ADD  R0,R30
	ADC  R1,R31
	ADC  R20,R22
	ADC  R21,R23
	RJMP __DIVD21U3
__DIVD21U2:
	SBR  R26,1
__DIVD21U3:
	DEC  R19
	BRNE __DIVD21U1
	MOVW R30,R26
	MOVW R22,R24
	MOVW R26,R0
	MOVW R24,R20
	POP  R21
	POP  R20
	POP  R19
	RET

__MODD21U:
	RCALL __DIVD21U
	MOVW R30,R26
	MOVW R22,R24
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__CPD10:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	RET

_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0x7D0
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
