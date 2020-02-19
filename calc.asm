
;CodeVisionAVR C Compiler V3.20 Evaluation
;(C) Copyright 1998-2015 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Release
;Chip type              : ATmega16
;Program type           : Application
;Clock frequency        : 4.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': No
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: No
;Enhanced function parameter passing: Mode 1
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega16
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
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
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
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
	.DEF _i=R4
	.DEF _i_msb=R5
	.DEF _y=R7
	.DEF _z=R6
	.DEF __lcd_x=R9
	.DEF __lcd_y=R8
	.DEF __lcd_maxx=R11

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

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0

_0x0:
	.DB  0x53,0x69,0x6E,0x20,0x0,0x43,0x6F,0x73
	.DB  0x20,0x0,0x54,0x61,0x6E,0x20,0x0,0x43
	.DB  0x6F,0x74,0x20,0x0,0x61,0x53,0x69,0x6E
	.DB  0x0,0x61,0x43,0x6F,0x73,0x0,0x4C,0x6F
	.DB  0x67,0x20,0x0,0x53,0x71,0x72,0x74,0x20
	.DB  0x0,0x65,0x78,0x70,0x20,0x0
_0x2000003:
	.DB  0x80,0xC0
_0x2020060:
	.DB  0x1
_0x2020000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  0x07
	.DW  __REG_VARS*2

	.DW  0x02
	.DW  __base_y_G100
	.DW  _0x2000003*2

	.DW  0x01
	.DW  __seed_G101
	.DW  _0x2020060*2

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

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

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
	.ORG 0

	.DSEG
	.ORG 0x160

	.CSEG
;/*
;To download other free projects visit www.avrprojects.info
;
;*/
;
;#include <mega16.h>
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
;#include <delay.h>
;#include <lcd.h>
;#include <stdlib.h>
;#include <math.h>
;
;#asm
   .equ __lcd_port=0x18
; 0000 000E #endasm
;//#############################################
;int key(void);
;float _Main(void);
;void Mohandes(void);
;void Mohasebe(void);
;void Alamat(int,int);
;float Emoji(int);
;//#############################################
;float a = 0 , b = 0 , c = 0 , q , t;
;int i ;
;char y=0 , lcd[25] , z   ;
;//#############################################
;void main(void){
; 0000 001B void main(void){

	.CSEG
_main:
; .FSTART _main
; 0000 001C 
; 0000 001D DDRB=0x0F;
	LDI  R30,LOW(15)
	OUT  0x17,R30
; 0000 001E DDRC=0x07;
	LDI  R30,LOW(7)
	OUT  0x14,R30
; 0000 001F DDRD=0x0F;
	LDI  R30,LOW(15)
	OUT  0x11,R30
; 0000 0020 
; 0000 0021 lcd_init(16);
	LDI  R26,LOW(16)
	RCALL _lcd_init
; 0000 0022 while (1){
_0x3:
; 0000 0023 _Main();
	RCALL __Main
; 0000 0024 }
	RJMP _0x3
; 0000 0025 }
_0x6:
	RJMP _0x6
; .FEND
;//#############################################################
;float _Main(void){
; 0000 0027 float _Main(void){
__Main:
; .FSTART __Main
; 0000 0028 int Loop = 1 ;
; 0000 0029 y = key();
	ST   -Y,R17
	ST   -Y,R16
;	Loop -> R16,R17
	__GETWRN 16,17,1
	RCALL SUBOPT_0x0
; 0000 002A if( y == 15 ){a = 0 ;b = 0 ;c = 0 ;lcd_clear();return 0 ;}
	BRNE _0x7
	RCALL SUBOPT_0x1
	RJMP _0x20A000F
; 0000 002B if( y < 10 ){
_0x7:
	LDI  R30,LOW(10)
	CP   R7,R30
	BRSH _0x8
; 0000 002C         a = (a*10)+y ;
	RCALL SUBOPT_0x2
; 0000 002D         itoa(y , lcd);
; 0000 002E         lcd_puts(lcd);
; 0000 002F         delay_ms(50);
; 0000 0030 }
; 0000 0031 
; 0000 0032 
; 0000 0033 
; 0000 0034 if( y > 9 && y < 16 ){
_0x8:
	LDI  R30,LOW(9)
	CP   R30,R7
	BRSH _0xA
	LDI  R30,LOW(16)
	CP   R7,R30
	BRLO _0xB
_0xA:
	RJMP _0x9
_0xB:
; 0000 0035         if( y == 15 ){a = 0 ;b = 0 ;c = 0 ;lcd_clear();return 0 ;}
	LDI  R30,LOW(15)
	CP   R30,R7
	BRNE _0xC
	RCALL SUBOPT_0x1
	RJMP _0x20A000F
; 0000 0036         z = y ;
_0xC:
	MOV  R6,R7
; 0000 0037         Alamat(y,1);
	RCALL SUBOPT_0x3
	LDI  R26,LOW(1)
	LDI  R27,0
	RCALL _Alamat
; 0000 0038         while(Loop){
_0xD:
	MOV  R0,R16
	OR   R0,R17
	BREQ _0xF
; 0000 0039         y = key();
	RCALL SUBOPT_0x0
; 0000 003A         if( y == 15 ){a = 0 ;b = 0 ;c = 0 ;lcd_clear();return 0 ;}
	BRNE _0x10
	RCALL SUBOPT_0x1
	RJMP _0x20A000F
; 0000 003B         if( y < 10 ){
_0x10:
	LDI  R30,LOW(10)
	CP   R7,R30
	BRSH _0x11
; 0000 003C                 b = (b*10)+y ;
	RCALL SUBOPT_0x4
	RCALL SUBOPT_0x5
	MOVW R26,R30
	MOVW R24,R22
	MOV  R30,R7
	RCALL SUBOPT_0x6
	RCALL __ADDF12
	STS  _b,R30
	STS  _b+1,R31
	STS  _b+2,R22
	STS  _b+3,R23
; 0000 003D                 itoa(y , lcd);
	RCALL SUBOPT_0x3
	LDI  R26,LOW(_lcd)
	LDI  R27,HIGH(_lcd)
	RCALL _itoa
; 0000 003E                 lcd_puts(lcd);
	LDI  R26,LOW(_lcd)
	LDI  R27,HIGH(_lcd)
	RCALL _lcd_puts
; 0000 003F                 delay_ms(50);
	LDI  R26,LOW(50)
	LDI  R27,0
	RCALL _delay_ms
; 0000 0040         }else if(y == 14){
	RJMP _0x12
_0x11:
	LDI  R30,LOW(14)
	CP   R30,R7
	BRNE _0x13
; 0000 0041                 lcd_putchar('=');
	LDI  R26,LOW(61)
	RCALL _lcd_putchar
; 0000 0042                 Mohasebe();
	RCALL _Mohasebe
; 0000 0043                 y = 0 ;
	CLR  R7
; 0000 0044                 Loop = 0 ;
	__GETWRN 16,17,0
; 0000 0045         }
; 0000 0046         }
_0x13:
_0x12:
	RJMP _0xD
_0xF:
; 0000 0047 }
; 0000 0048 if( y > 15 ){
_0x9:
	LDI  R30,LOW(15)
	CP   R30,R7
	BRSH _0x14
; 0000 0049 lcd_clear();
	RCALL _lcd_clear
; 0000 004A a= 0 ; b = 0 ; c = 0;
	LDI  R30,LOW(0)
	STS  _a,R30
	STS  _a+1,R30
	STS  _a+2,R30
	STS  _a+3,R30
	STS  _b,R30
	STS  _b+1,R30
	STS  _b+2,R30
	STS  _b+3,R30
	STS  _c,R30
	STS  _c+1,R30
	STS  _c+2,R30
	STS  _c+3,R30
; 0000 004B Alamat(y , 2);
	RCALL SUBOPT_0x3
	LDI  R26,LOW(2)
	LDI  R27,0
	RCALL _Alamat
; 0000 004C z = y ;
	MOV  R6,R7
; 0000 004D Loop = 1 ;
	__GETWRN 16,17,1
; 0000 004E while(Loop){
_0x15:
	MOV  R0,R16
	OR   R0,R17
	BREQ _0x17
; 0000 004F y = key();
	RCALL SUBOPT_0x0
; 0000 0050 if( y == 15 ){a = 0 ;b = 0 ;c = 0 ;lcd_clear();return 0 ;}
	BRNE _0x18
	RCALL SUBOPT_0x1
	RJMP _0x20A000F
; 0000 0051 if(y <  10){
_0x18:
	LDI  R30,LOW(10)
	CP   R7,R30
	BRSH _0x19
; 0000 0052         a = (a*10) + y ;
	RCALL SUBOPT_0x2
; 0000 0053         itoa(y , lcd);
; 0000 0054         lcd_puts(lcd);
; 0000 0055         delay_ms(50);
; 0000 0056 }else if ( y == 14){
	RJMP _0x1A
_0x19:
	LDI  R30,LOW(14)
	CP   R30,R7
	BRNE _0x1B
; 0000 0057         lcd_putchar('=');
	LDI  R26,LOW(61)
	RCALL _lcd_putchar
; 0000 0058         Mohandes();
	RCALL _Mohandes
; 0000 0059 }
; 0000 005A Loop = 1 ;
_0x1B:
_0x1A:
	__GETWRN 16,17,1
; 0000 005B }
	RJMP _0x15
_0x17:
; 0000 005C }
; 0000 005D return 0;
_0x14:
_0x20A000F:
	__GETD1N 0x0
	LD   R16,Y+
	LD   R17,Y+
	RET
; 0000 005E }
; .FEND
;//##########################################################
;void Mohasebe(void){
; 0000 0060 void Mohasebe(void){
_Mohasebe:
; .FSTART _Mohasebe
; 0000 0061 if(z == 10)c = a / b ;
	LDI  R30,LOW(10)
	CP   R30,R6
	BRNE _0x1C
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x8
; 0000 0062 if(z == 11)c = a * b ;
_0x1C:
	LDI  R30,LOW(11)
	CP   R30,R6
	BRNE _0x1D
	RCALL SUBOPT_0x7
	RCALL __MULF12
	RCALL SUBOPT_0x9
; 0000 0063 if(z == 12)c = a - b ;
_0x1D:
	LDI  R30,LOW(12)
	CP   R30,R6
	BRNE _0x1E
	RCALL SUBOPT_0x4
	RCALL SUBOPT_0xA
	RCALL __SUBF12
	RCALL SUBOPT_0x9
; 0000 0064 if(z == 13)c = a + b ;
_0x1E:
	LDI  R30,LOW(13)
	CP   R30,R6
	BRNE _0x1F
	RCALL SUBOPT_0x7
	RCALL __ADDF12
	RCALL SUBOPT_0x9
; 0000 0065 ftoa(c , 3 , lcd);
_0x1F:
	RJMP _0x20A000E
; 0000 0066 lcd_puts(lcd);
; 0000 0067 delay_ms(100);
; 0000 0068 }
; .FEND
;//#########################################################
;float Emoji(int rr){
; 0000 006A float Emoji(int rr){
_Emoji:
; .FSTART _Emoji
; 0000 006B q=1;
	ST   -Y,R27
	ST   -Y,R26
;	rr -> Y+0
	RCALL SUBOPT_0xB
	RCALL SUBOPT_0xC
; 0000 006C for(i=0;i<rr;i++)q = q * 2.71728 ;
	CLR  R4
	CLR  R5
_0x21:
	LD   R30,Y
	LDD  R31,Y+1
	CP   R4,R30
	CPC  R5,R31
	BRGE _0x22
	LDS  R26,_q
	LDS  R27,_q+1
	LDS  R24,_q+2
	LDS  R25,_q+3
	__GETD1N 0x402DE7EA
	RCALL __MULF12
	RCALL SUBOPT_0xC
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	RJMP _0x21
_0x22:
; 0000 006D return q;
	LDS  R30,_q
	LDS  R31,_q+1
	LDS  R22,_q+2
	LDS  R23,_q+3
	JMP  _0x20A000C
; 0000 006E }
; .FEND
;//#########################################################
;void Mohandes(void){
; 0000 0070 void Mohandes(void){
_Mohandes:
; .FSTART _Mohandes
; 0000 0071 t = (3.1415926535897932384626433832795/180)*a ;
	RCALL SUBOPT_0xA
	__GETD2N 0x3C8EFA35
	RCALL __MULF12
	STS  _t,R30
	STS  _t+1,R31
	STS  _t+2,R22
	STS  _t+3,R23
; 0000 0072 if(z == 16)c = sin(t) ;
	LDI  R30,LOW(16)
	CP   R30,R6
	BRNE _0x23
	RCALL SUBOPT_0xD
	RCALL _sin
	RCALL SUBOPT_0x9
; 0000 0073 if(z == 17)c = cos(t) ;
_0x23:
	LDI  R30,LOW(17)
	CP   R30,R6
	BRNE _0x24
	RCALL SUBOPT_0xD
	RCALL _cos
	RCALL SUBOPT_0x9
; 0000 0074 if(z == 18)c = tan(t) ;
_0x24:
	LDI  R30,LOW(18)
	CP   R30,R6
	BRNE _0x25
	RCALL SUBOPT_0xD
	RCALL _tan
	RCALL SUBOPT_0x9
; 0000 0075 if(z == 19)c = 1/tan(t) ;
_0x25:
	LDI  R30,LOW(19)
	CP   R30,R6
	BRNE _0x26
	RCALL SUBOPT_0xD
	RCALL _tan
	RCALL SUBOPT_0xE
	RCALL SUBOPT_0x8
; 0000 0076 if(z == 20)c = asin(t) ;
_0x26:
	LDI  R30,LOW(20)
	CP   R30,R6
	BRNE _0x27
	RCALL SUBOPT_0xD
	RCALL _asin
	RCALL SUBOPT_0x9
; 0000 0077 if(z == 21)c = acos(t) ;
_0x27:
	LDI  R30,LOW(21)
	CP   R30,R6
	BRNE _0x28
	RCALL SUBOPT_0xD
	RCALL _acos
	RCALL SUBOPT_0x9
; 0000 0078 if(z == 22)c = log(a) ;
_0x28:
	LDI  R30,LOW(22)
	CP   R30,R6
	BRNE _0x29
	RCALL SUBOPT_0xF
	RCALL _log
	RCALL SUBOPT_0x9
; 0000 0079 if(z == 23)c = sqrt(a) ;
_0x29:
	LDI  R30,LOW(23)
	CP   R30,R6
	BRNE _0x2A
	RCALL SUBOPT_0xF
	RCALL _sqrt
	RCALL SUBOPT_0x9
; 0000 007A if(z == 24)c = Emoji(a) ;
_0x2A:
	LDI  R30,LOW(24)
	CP   R30,R6
	BRNE _0x2B
	RCALL SUBOPT_0xA
	RCALL __CFD1
	MOVW R26,R30
	RCALL _Emoji
	RCALL SUBOPT_0x9
; 0000 007B ftoa(c , 3 , lcd);
_0x2B:
_0x20A000E:
	LDS  R30,_c
	LDS  R31,_c+1
	LDS  R22,_c+2
	LDS  R23,_c+3
	RCALL __PUTPARD1
	LDI  R30,LOW(3)
	ST   -Y,R30
	LDI  R26,LOW(_lcd)
	LDI  R27,HIGH(_lcd)
	RCALL _ftoa
; 0000 007C lcd_puts(lcd);
	LDI  R26,LOW(_lcd)
	LDI  R27,HIGH(_lcd)
	RCALL _lcd_puts
; 0000 007D delay_ms(100);
	LDI  R26,LOW(100)
	LDI  R27,0
	RCALL _delay_ms
; 0000 007E }
	RET
; .FEND
;//#########################################################
;void Alamat(int Moji,int Halat){
; 0000 0080 void Alamat(int Moji,int Halat){
_Alamat:
; .FSTART _Alamat
; 0000 0081 if(Halat == 1){
	ST   -Y,R27
	ST   -Y,R26
;	Moji -> Y+2
;	Halat -> Y+0
	LD   R26,Y
	LDD  R27,Y+1
	SBIW R26,1
	BRNE _0x2C
; 0000 0082         if(Moji == 10)lcd_putchar('/') ;
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,10
	BRNE _0x2D
	LDI  R26,LOW(47)
	RCALL _lcd_putchar
; 0000 0083         if(Moji == 11)lcd_putchar('*') ;
_0x2D:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,11
	BRNE _0x2E
	LDI  R26,LOW(42)
	RCALL _lcd_putchar
; 0000 0084         if(Moji == 12)lcd_putchar('-') ;
_0x2E:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,12
	BRNE _0x2F
	LDI  R26,LOW(45)
	RCALL _lcd_putchar
; 0000 0085         if(Moji == 13)lcd_putchar('+') ;
_0x2F:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,13
	BRNE _0x30
	LDI  R26,LOW(43)
	RCALL _lcd_putchar
; 0000 0086         delay_ms(100);
_0x30:
	LDI  R26,LOW(100)
	LDI  R27,0
	RCALL _delay_ms
; 0000 0087 }
; 0000 0088 if(Halat == 2){
_0x2C:
	LD   R26,Y
	LDD  R27,Y+1
	SBIW R26,2
	BREQ PC+2
	RJMP _0x31
; 0000 0089         if(Moji == 16)lcd_putsf("Sin ") ;
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,16
	BRNE _0x32
	__POINTW2FN _0x0,0
	RCALL _lcd_putsf
; 0000 008A         if(Moji == 17)lcd_putsf("Cos ") ;
_0x32:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,17
	BRNE _0x33
	__POINTW2FN _0x0,5
	RCALL _lcd_putsf
; 0000 008B         if(Moji == 18)lcd_putsf("Tan ") ;
_0x33:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,18
	BRNE _0x34
	__POINTW2FN _0x0,10
	RCALL _lcd_putsf
; 0000 008C         if(Moji == 19)lcd_putsf("Cot ") ;
_0x34:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,19
	BRNE _0x35
	__POINTW2FN _0x0,15
	RCALL _lcd_putsf
; 0000 008D         if(Moji == 20)lcd_putsf("aSin") ;
_0x35:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,20
	BRNE _0x36
	__POINTW2FN _0x0,20
	RCALL _lcd_putsf
; 0000 008E         if(Moji == 21)lcd_putsf("aCos") ;
_0x36:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,21
	BRNE _0x37
	__POINTW2FN _0x0,25
	RCALL _lcd_putsf
; 0000 008F         if(Moji == 22)lcd_putsf("Log ") ;
_0x37:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,22
	BRNE _0x38
	__POINTW2FN _0x0,30
	RCALL _lcd_putsf
; 0000 0090         if(Moji == 23)lcd_putsf("Sqrt ") ;
_0x38:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,23
	BRNE _0x39
	__POINTW2FN _0x0,35
	RCALL _lcd_putsf
; 0000 0091         if(Moji == 24)lcd_putsf("exp ") ;
_0x39:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,24
	BRNE _0x3A
	__POINTW2FN _0x0,41
	RCALL _lcd_putsf
; 0000 0092         delay_ms(100);
_0x3A:
	LDI  R26,LOW(100)
	LDI  R27,0
	RCALL _delay_ms
; 0000 0093 
; 0000 0094 }
; 0000 0095 }
_0x31:
	JMP  _0x20A0001
; .FEND
;//#########################################################
;int key(void){
; 0000 0097 int key(void){
_key:
; .FSTART _key
; 0000 0098 char KEY = 1 ;
; 0000 0099 while(KEY){
	ST   -Y,R17
;	KEY -> R17
	LDI  R17,1
_0x3B:
	CPI  R17,0
	BRNE PC+2
	RJMP _0x3D
; 0000 009A 
; 0000 009B         PORTD.0 = 1 ;
	SBI  0x12,0
; 0000 009C         PORTD.1 = 0 ;
	CBI  0x12,1
; 0000 009D         PORTD.2 = 0 ;
	CBI  0x12,2
; 0000 009E         PORTD.3 = 0 ;
	CBI  0x12,3
; 0000 009F         if(PIND.4 == 1){return 7 ; KEY = 0;delay_ms(50);}
	SBIS 0x10,4
	RJMP _0x46
	LDI  R30,LOW(7)
	LDI  R31,HIGH(7)
	RJMP _0x20A000D
; 0000 00A0         if(PIND.5 == 1){return 8 ; KEY = 0;delay_ms(50);}
_0x46:
	SBIS 0x10,5
	RJMP _0x47
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	RJMP _0x20A000D
; 0000 00A1         if(PIND.6 == 1){return 9 ; KEY = 0;delay_ms(50);}
_0x47:
	SBIS 0x10,6
	RJMP _0x48
	LDI  R30,LOW(9)
	LDI  R31,HIGH(9)
	RJMP _0x20A000D
; 0000 00A2         if(PIND.7 == 1){return 10; KEY = 0;delay_ms(50);}
_0x48:
	SBIS 0x10,7
	RJMP _0x49
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	RJMP _0x20A000D
; 0000 00A3         //==========================================
; 0000 00A4         PORTD.0 = 0 ;
_0x49:
	CBI  0x12,0
; 0000 00A5         PORTD.1 = 1 ;
	SBI  0x12,1
; 0000 00A6         PORTD.2 = 0 ;
	CBI  0x12,2
; 0000 00A7         PORTD.3 = 0 ;
	CBI  0x12,3
; 0000 00A8         if(PIND.4 == 1){return 4 ; KEY = 0;}
	SBIS 0x10,4
	RJMP _0x52
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	RJMP _0x20A000D
; 0000 00A9         if(PIND.5 == 1){return 5 ; KEY = 0;}
_0x52:
	SBIS 0x10,5
	RJMP _0x53
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	RJMP _0x20A000D
; 0000 00AA         if(PIND.6 == 1){return 6 ; KEY = 0;}
_0x53:
	SBIS 0x10,6
	RJMP _0x54
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	RJMP _0x20A000D
; 0000 00AB         if(PIND.7 == 1){return 11; KEY = 0;}
_0x54:
	SBIS 0x10,7
	RJMP _0x55
	LDI  R30,LOW(11)
	LDI  R31,HIGH(11)
	RJMP _0x20A000D
; 0000 00AC         //==========================================
; 0000 00AD         PORTD.0 = 0 ;
_0x55:
	CBI  0x12,0
; 0000 00AE         PORTD.1 = 0 ;
	CBI  0x12,1
; 0000 00AF         PORTD.2 = 1 ;
	SBI  0x12,2
; 0000 00B0         PORTD.3 = 0 ;
	CBI  0x12,3
; 0000 00B1         if(PIND.4 == 1){return 1 ; KEY = 0;}
	SBIS 0x10,4
	RJMP _0x5E
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RJMP _0x20A000D
; 0000 00B2         if(PIND.5 == 1){return 2 ; KEY = 0;}
_0x5E:
	SBIS 0x10,5
	RJMP _0x5F
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	RJMP _0x20A000D
; 0000 00B3         if(PIND.6 == 1){return 3 ; KEY = 0;}
_0x5F:
	SBIS 0x10,6
	RJMP _0x60
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	RJMP _0x20A000D
; 0000 00B4         if(PIND.7 == 1){return 12; KEY = 0;}
_0x60:
	SBIS 0x10,7
	RJMP _0x61
	LDI  R30,LOW(12)
	LDI  R31,HIGH(12)
	RJMP _0x20A000D
; 0000 00B5         //==========================================
; 0000 00B6         PORTD.0 = 0 ;
_0x61:
	CBI  0x12,0
; 0000 00B7         PORTD.1 = 0 ;
	CBI  0x12,1
; 0000 00B8         PORTD.2 = 0 ;
	CBI  0x12,2
; 0000 00B9         PORTD.3 = 1 ;
	SBI  0x12,3
; 0000 00BA         if(PIND.4 == 1){return 15; KEY = 0;}
	SBIS 0x10,4
	RJMP _0x6A
	LDI  R30,LOW(15)
	LDI  R31,HIGH(15)
	RJMP _0x20A000D
; 0000 00BB         if(PIND.5 == 1){return 0 ; KEY = 0;}
_0x6A:
	SBIS 0x10,5
	RJMP _0x6B
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x20A000D
; 0000 00BC         if(PIND.6 == 1){return 14; KEY = 0;}
_0x6B:
	SBIS 0x10,6
	RJMP _0x6C
	LDI  R30,LOW(14)
	LDI  R31,HIGH(14)
	RJMP _0x20A000D
; 0000 00BD         if(PIND.7 == 1){return 13; KEY = 0;}
_0x6C:
	SBIS 0x10,7
	RJMP _0x6D
	LDI  R30,LOW(13)
	LDI  R31,HIGH(13)
	RJMP _0x20A000D
; 0000 00BE 
; 0000 00BF         //=============================================================================
; 0000 00C0         PORTC.0 = 1 ;
_0x6D:
	SBI  0x15,0
; 0000 00C1         PORTC.1 = 0 ;
	CBI  0x15,1
; 0000 00C2         PORTC.2 = 0 ;
	CBI  0x15,2
; 0000 00C3         if(PINC.5 == 1){return 16 ; KEY=0;}
	SBIS 0x13,5
	RJMP _0x74
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	RJMP _0x20A000D
; 0000 00C4         if(PINC.6 == 1){return 17; KEY=0;}
_0x74:
	SBIS 0x13,6
	RJMP _0x75
	LDI  R30,LOW(17)
	LDI  R31,HIGH(17)
	RJMP _0x20A000D
; 0000 00C5         if(PINC.7 == 1){return 18 ; KEY=0;}
_0x75:
	SBIS 0x13,7
	RJMP _0x76
	LDI  R30,LOW(18)
	LDI  R31,HIGH(18)
	RJMP _0x20A000D
; 0000 00C6         //=====================================================
; 0000 00C7         PORTC.0 = 0 ;
_0x76:
	CBI  0x15,0
; 0000 00C8         PORTC.1 = 1 ;
	SBI  0x15,1
; 0000 00C9         PORTC.2 = 0 ;
	CBI  0x15,2
; 0000 00CA         if(PINC.5 == 1){return 19 ; KEY=0;}
	SBIS 0x13,5
	RJMP _0x7D
	LDI  R30,LOW(19)
	LDI  R31,HIGH(19)
	RJMP _0x20A000D
; 0000 00CB         if(PINC.6 == 1){return 20 ; KEY=0;}
_0x7D:
	SBIS 0x13,6
	RJMP _0x7E
	LDI  R30,LOW(20)
	LDI  R31,HIGH(20)
	RJMP _0x20A000D
; 0000 00CC         if(PINC.7 == 1){return 21 ; KEY=0;}
_0x7E:
	SBIS 0x13,7
	RJMP _0x7F
	LDI  R30,LOW(21)
	LDI  R31,HIGH(21)
	RJMP _0x20A000D
; 0000 00CD         //=====================================================
; 0000 00CE         PORTC.0 = 0 ;
_0x7F:
	CBI  0x15,0
; 0000 00CF         PORTC.1 = 0 ;
	CBI  0x15,1
; 0000 00D0         PORTC.2 = 1 ;
	SBI  0x15,2
; 0000 00D1         if(PINC.5 == 1){return 22 ; KEY=0;}
	SBIS 0x13,5
	RJMP _0x86
	LDI  R30,LOW(22)
	LDI  R31,HIGH(22)
	RJMP _0x20A000D
; 0000 00D2         if(PINC.6 == 1){return 23 ; KEY=0;}
_0x86:
	SBIS 0x13,6
	RJMP _0x87
	LDI  R30,LOW(23)
	LDI  R31,HIGH(23)
	RJMP _0x20A000D
; 0000 00D3         if(PINC.7 == 1){return 24 ; KEY=0;}
_0x87:
	SBIS 0x13,7
	RJMP _0x88
	LDI  R30,LOW(24)
	LDI  R31,HIGH(24)
	RJMP _0x20A000D
; 0000 00D4 
; 0000 00D5 KEY = 1 ;
_0x88:
	LDI  R17,LOW(1)
; 0000 00D6 }
	RJMP _0x3B
_0x3D:
; 0000 00D7 }
_0x20A000D:
	LD   R17,Y+
	RET
; .FEND
;//############################################################
;
    .equ __lcd_direction=__lcd_port-1
    .equ __lcd_pin=__lcd_port-2
    .equ __lcd_rs=0
    .equ __lcd_rd=1
    .equ __lcd_enable=2
    .equ __lcd_busy_flag=7

	.DSEG

	.CSEG
__lcd_delay_G100:
; .FSTART __lcd_delay_G100
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
	RCALL __lcd_delay_G100
    sbi   __lcd_port,__lcd_enable ;EN=1
	RCALL __lcd_delay_G100
    in    r26,__lcd_pin
    cbi   __lcd_port,__lcd_enable ;EN=0
	RCALL __lcd_delay_G100
    sbi   __lcd_port,__lcd_enable ;EN=1
	RCALL __lcd_delay_G100
    cbi   __lcd_port,__lcd_enable ;EN=0
    sbrc  r26,__lcd_busy_flag
    rjmp  __lcd_busy
	RET
; .FEND
__lcd_write_nibble_G100:
; .FSTART __lcd_write_nibble_G100
    andi  r26,0xf0
    or    r26,r27
    out   __lcd_port,r26          ;write
    sbi   __lcd_port,__lcd_enable ;EN=1
	RCALL __lcd_delay_G100
    cbi   __lcd_port,__lcd_enable ;EN=0
	RCALL __lcd_delay_G100
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
	RCALL __lcd_write_nibble_G100
    ld    r26,y
    swap  r26
	RCALL __lcd_write_nibble_G100
    sbi   __lcd_port,__lcd_rd     ;RD=1
	JMP  _0x20A000A
; .FEND
__lcd_read_nibble_G100:
; .FSTART __lcd_read_nibble_G100
    sbi   __lcd_port,__lcd_enable ;EN=1
	RCALL __lcd_delay_G100
    in    r30,__lcd_pin           ;read
    cbi   __lcd_port,__lcd_enable ;EN=0
	RCALL __lcd_delay_G100
    andi  r30,0xf0
	RET
; .FEND
_lcd_read_byte0_G100:
; .FSTART _lcd_read_byte0_G100
	RCALL __lcd_delay_G100
	RCALL __lcd_read_nibble_G100
    mov   r26,r30
	RCALL __lcd_read_nibble_G100
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
	SUBI R30,LOW(-__base_y_G100)
	SBCI R31,HIGH(-__base_y_G100)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R9,Y+1
	LDD  R8,Y+0
_0x20A000C:
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
	MOV  R8,R30
	MOV  R9,R30
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
	CP   R9,R11
	BRLO _0x2000004
	__lcd_putchar1:
	INC  R8
	LDI  R30,LOW(0)
	ST   -Y,R30
	MOV  R26,R8
	RCALL _lcd_gotoxy
	brts __lcd_putchar0
_0x2000004:
	INC  R9
    rcall __lcd_ready
    sbi  __lcd_port,__lcd_rs ;RS=1
	LD   R26,Y
	RCALL __lcd_write_data
__lcd_putchar0:
    pop  r31
    pop  r30
	JMP  _0x20A000A
; .FEND
_lcd_puts:
; .FSTART _lcd_puts
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2000005:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x2000007
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2000005
_0x2000007:
	RJMP _0x20A000B
; .FEND
_lcd_putsf:
; .FSTART _lcd_putsf
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2000008:
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ADIW R30,1
	STD  Y+1,R30
	STD  Y+1+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x200000A
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2000008
_0x200000A:
_0x20A000B:
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
__long_delay_G100:
; .FSTART __long_delay_G100
    clr   r26
    clr   r27
__long_delay0:
    sbiw  r26,1         ;2 cycles
    brne  __long_delay0 ;2 cycles
	RET
; .FEND
__lcd_init_write_G100:
; .FSTART __lcd_init_write_G100
	ST   -Y,R26
    cbi  __lcd_port,__lcd_rd 	  ;RD=0
    in    r26,__lcd_direction
    ori   r26,0xf7                ;set as output
    out   __lcd_direction,r26
    in    r27,__lcd_port
    andi  r27,0xf
    ld    r26,y
	RCALL __lcd_write_nibble_G100
    sbi   __lcd_port,__lcd_rd     ;RD=1
	RJMP _0x20A000A
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R26
    cbi   __lcd_port,__lcd_enable ;EN=0
    cbi   __lcd_port,__lcd_rs     ;RS=0
	LDD  R11,Y+0
	LD   R30,Y
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G100,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G100,3
	RCALL __long_delay_G100
	LDI  R26,LOW(48)
	RCALL __lcd_init_write_G100
	RCALL __long_delay_G100
	LDI  R26,LOW(48)
	RCALL __lcd_init_write_G100
	RCALL __long_delay_G100
	LDI  R26,LOW(48)
	RCALL __lcd_init_write_G100
	RCALL __long_delay_G100
	LDI  R26,LOW(32)
	RCALL __lcd_init_write_G100
	RCALL __long_delay_G100
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	RCALL __long_delay_G100
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	RCALL __long_delay_G100
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	RCALL __long_delay_G100
    in    r26,__lcd_direction
    andi  r26,0xf                 ;set as input
    out   __lcd_direction,r26
    sbi   __lcd_port,__lcd_rd     ;RD=1
	RCALL _lcd_read_byte0_G100
	CPI  R30,LOW(0x5)
	BREQ _0x200000B
	LDI  R30,LOW(0)
	RJMP _0x20A000A
_0x200000B:
	RCALL __lcd_ready
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
	LDI  R30,LOW(1)
_0x20A000A:
	ADIW R28,1
	RET
; .FEND

	.CSEG
_itoa:
; .FSTART _itoa
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    ld   r30,y+
    ld   r31,y+
    adiw r30,0
    brpl __itoa0
    com  r30
    com  r31
    adiw r30,1
    ldi  r22,'-'
    st   x+,r22
__itoa0:
    clt
    ldi  r24,low(10000)
    ldi  r25,high(10000)
    rcall __itoa1
    ldi  r24,low(1000)
    ldi  r25,high(1000)
    rcall __itoa1
    ldi  r24,100
    clr  r25
    rcall __itoa1
    ldi  r24,10
    rcall __itoa1
    mov  r22,r30
    rcall __itoa5
    clr  r22
    st   x,r22
    ret

__itoa1:
    clr	 r22
__itoa2:
    cp   r30,r24
    cpc  r31,r25
    brlo __itoa3
    inc  r22
    sub  r30,r24
    sbc  r31,r25
    brne __itoa2
__itoa3:
    tst  r22
    brne __itoa4
    brts __itoa5
    ret
__itoa4:
    set
__itoa5:
    subi r22,-0x30
    st   x+,r22
    ret
; .FEND
_ftoa:
; .FSTART _ftoa
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,4
	LDI  R30,LOW(0)
	ST   Y,R30
	STD  Y+1,R30
	STD  Y+2,R30
	LDI  R30,LOW(63)
	STD  Y+3,R30
	ST   -Y,R17
	ST   -Y,R16
	LDD  R30,Y+11
	LDD  R31,Y+11+1
	CPI  R30,LOW(0xFFFF)
	LDI  R26,HIGH(0xFFFF)
	CPC  R31,R26
	BRNE _0x202000D
	RCALL SUBOPT_0x11
	__POINTW2FN _0x2020000,0
	RCALL _strcpyf
	RJMP _0x20A0009
_0x202000D:
	CPI  R30,LOW(0x7FFF)
	LDI  R26,HIGH(0x7FFF)
	CPC  R31,R26
	BRNE _0x202000C
	RCALL SUBOPT_0x11
	__POINTW2FN _0x2020000,1
	RCALL _strcpyf
	RJMP _0x20A0009
_0x202000C:
	LDD  R26,Y+12
	TST  R26
	BRPL _0x202000F
	RCALL SUBOPT_0x12
	RCALL __ANEGF1
	RCALL SUBOPT_0x13
	RCALL SUBOPT_0x14
	LDI  R30,LOW(45)
	ST   X,R30
_0x202000F:
	LDD  R26,Y+8
	CPI  R26,LOW(0x7)
	BRLO _0x2020010
	LDI  R30,LOW(6)
	STD  Y+8,R30
_0x2020010:
	LDD  R17,Y+8
_0x2020011:
	MOV  R30,R17
	SUBI R17,1
	CPI  R30,0
	BREQ _0x2020013
	RCALL SUBOPT_0x15
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x17
	RJMP _0x2020011
_0x2020013:
	RCALL SUBOPT_0x18
	RCALL __ADDF12
	RCALL SUBOPT_0x13
	LDI  R17,LOW(0)
	RCALL SUBOPT_0xB
	RCALL SUBOPT_0x17
_0x2020014:
	RCALL SUBOPT_0x18
	RCALL __CMPF12
	BRLO _0x2020016
	RCALL SUBOPT_0x15
	RCALL SUBOPT_0x5
	RCALL SUBOPT_0x17
	SUBI R17,-LOW(1)
	CPI  R17,39
	BRLO _0x2020017
	RCALL SUBOPT_0x11
	__POINTW2FN _0x2020000,5
	RCALL _strcpyf
	RJMP _0x20A0009
_0x2020017:
	RJMP _0x2020014
_0x2020016:
	CPI  R17,0
	BRNE _0x2020018
	RCALL SUBOPT_0x14
	LDI  R30,LOW(48)
	ST   X,R30
	RJMP _0x2020019
_0x2020018:
_0x202001A:
	MOV  R30,R17
	SUBI R17,1
	CPI  R30,0
	BREQ _0x202001C
	RCALL SUBOPT_0x15
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x19
	RCALL __ADDF12
	MOVW R26,R30
	MOVW R24,R22
	RCALL _floor
	RCALL SUBOPT_0x17
	RCALL SUBOPT_0x18
	RCALL __DIVF21
	RCALL __CFD1U
	MOV  R16,R30
	RCALL SUBOPT_0x14
	RCALL SUBOPT_0x1A
	RCALL SUBOPT_0x15
	RCALL SUBOPT_0x6
	RCALL __MULF12
	RCALL SUBOPT_0x1B
	RCALL __SWAPD12
	RCALL __SUBF12
	RCALL SUBOPT_0x13
	RJMP _0x202001A
_0x202001C:
_0x2020019:
	LDD  R30,Y+8
	CPI  R30,0
	BREQ _0x20A0008
	RCALL SUBOPT_0x14
	LDI  R30,LOW(46)
	ST   X,R30
_0x202001E:
	LDD  R30,Y+8
	SUBI R30,LOW(1)
	STD  Y+8,R30
	SUBI R30,-LOW(1)
	BREQ _0x2020020
	RCALL SUBOPT_0x1B
	RCALL SUBOPT_0x5
	RCALL SUBOPT_0x13
	RCALL SUBOPT_0x12
	RCALL __CFD1U
	MOV  R16,R30
	RCALL SUBOPT_0x14
	RCALL SUBOPT_0x1A
	RCALL SUBOPT_0x1B
	RCALL SUBOPT_0x6
	RCALL __SWAPD12
	RCALL __SUBF12
	RCALL SUBOPT_0x13
	RJMP _0x202001E
_0x2020020:
_0x20A0008:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	ST   X,R30
_0x20A0009:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,13
	RET
; .FEND

	.DSEG

	.CSEG

	.CSEG
_ftrunc:
; .FSTART _ftrunc
	RCALL __PUTPARD2
   ldd  r23,y+3
   ldd  r22,y+2
   ldd  r31,y+1
   ld   r30,y
   bst  r23,7
   lsl  r23
   sbrc r22,7
   sbr  r23,1
   mov  r25,r23
   subi r25,0x7e
   breq __ftrunc0
   brcs __ftrunc0
   cpi  r25,24
   brsh __ftrunc1
   clr  r26
   clr  r27
   clr  r24
__ftrunc2:
   sec
   ror  r24
   ror  r27
   ror  r26
   dec  r25
   brne __ftrunc2
   and  r30,r26
   and  r31,r27
   and  r22,r24
   rjmp __ftrunc1
__ftrunc0:
   clt
   clr  r23
   clr  r30
   clr  r31
   clr  r22
__ftrunc1:
   cbr  r22,0x80
   lsr  r23
   brcc __ftrunc3
   sbr  r22,0x80
__ftrunc3:
   bld  r23,7
   ld   r26,y+
   ld   r27,y+
   ld   r24,y+
   ld   r25,y+
   cp   r30,r26
   cpc  r31,r27
   cpc  r22,r24
   cpc  r23,r25
   bst  r25,7
   ret
; .FEND
_floor:
; .FSTART _floor
	RCALL SUBOPT_0x1C
	RCALL _ftrunc
	RCALL SUBOPT_0x1D
    brne __floor1
__floor0:
	RCALL SUBOPT_0x1E
	RJMP _0x20A0001
__floor1:
    brtc __floor0
	RCALL SUBOPT_0x1E
	RCALL SUBOPT_0xE
	RJMP _0x20A0003
; .FEND
_log:
; .FSTART _log
	RCALL __PUTPARD2
	SBIW R28,4
	ST   -Y,R17
	ST   -Y,R16
	RCALL SUBOPT_0x1F
	RCALL __CPD02
	BRLT _0x204000C
	RCALL SUBOPT_0x20
	RJMP _0x20A0007
_0x204000C:
	RCALL SUBOPT_0x21
	RCALL __PUTPARD1
	IN   R26,SPL
	IN   R27,SPH
	SBIW R26,1
	PUSH R17
	PUSH R16
	RCALL _frexp
	POP  R16
	POP  R17
	RCALL SUBOPT_0x22
	RCALL SUBOPT_0x1F
	RCALL SUBOPT_0x23
	BRSH _0x204000D
	RCALL SUBOPT_0x21
	RCALL SUBOPT_0x1F
	RCALL __ADDF12
	RCALL SUBOPT_0x22
	__SUBWRN 16,17,1
_0x204000D:
	RCALL SUBOPT_0x21
	RCALL SUBOPT_0xE
	RCALL __SUBF12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0x21
	RCALL SUBOPT_0xE
	RCALL __ADDF12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	RCALL __DIVF21
	RCALL SUBOPT_0x22
	RCALL SUBOPT_0x21
	RCALL SUBOPT_0x1F
	RCALL __MULF12
	RCALL SUBOPT_0x17
	RCALL SUBOPT_0x24
	__GETD2N 0x3F654226
	RCALL __MULF12
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x4054114E
	RCALL __SWAPD12
	RCALL __SUBF12
	RCALL SUBOPT_0x1F
	RCALL __MULF12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0x24
	__GETD2N 0x3FD4114D
	RCALL __SUBF12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	RCALL __DIVF21
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	MOVW R30,R16
	RCALL __CWD1
	RCALL __CDF1
	__GETD2N 0x3F317218
	RCALL __MULF12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	RCALL __ADDF12
_0x20A0007:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,10
	RET
; .FEND
_sin:
; .FSTART _sin
	RCALL SUBOPT_0x25
	__GETD1N 0x3E22F983
	RCALL __MULF12
	RCALL SUBOPT_0x26
	RCALL _floor
	RCALL SUBOPT_0x27
	RCALL __SWAPD12
	RCALL __SUBF12
	RCALL SUBOPT_0x26
	RCALL SUBOPT_0x28
	RCALL __CMPF12
	BREQ PC+2
	BRCC PC+2
	RJMP _0x2040017
	RCALL SUBOPT_0x29
	RCALL SUBOPT_0x19
	RCALL SUBOPT_0x2A
	LDI  R17,LOW(1)
_0x2040017:
	RCALL SUBOPT_0x27
	__GETD1N 0x3E800000
	RCALL __CMPF12
	BREQ PC+2
	BRCC PC+2
	RJMP _0x2040018
	RCALL SUBOPT_0x27
	RCALL SUBOPT_0x28
	RCALL SUBOPT_0x2A
_0x2040018:
	CPI  R17,0
	BREQ _0x2040019
	RCALL SUBOPT_0x2B
_0x2040019:
	RCALL SUBOPT_0x29
	RCALL SUBOPT_0x27
	RCALL __MULF12
	RCALL SUBOPT_0x2C
	RCALL SUBOPT_0x2D
	__GETD2N 0x4226C4B1
	RCALL __MULF12
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x422DE51D
	RCALL __SWAPD12
	RCALL __SUBF12
	RCALL SUBOPT_0x2E
	__GETD2N 0x4104534C
	RCALL __ADDF12
	RCALL SUBOPT_0x27
	RCALL __MULF12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0x2D
	__GETD2N 0x3FDEED11
	RCALL __ADDF12
	RCALL SUBOPT_0x2E
	__GETD2N 0x3FA87B5E
	RCALL __ADDF12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	RCALL __DIVF21
	RJMP _0x20A0004
; .FEND
_cos:
; .FSTART _cos
	RCALL SUBOPT_0x1C
	__GETD1N 0x3FC90FDB
	RCALL __SUBF12
	MOVW R26,R30
	MOVW R24,R22
	RCALL _sin
	RJMP _0x20A0001
; .FEND
_tan:
; .FSTART _tan
	RCALL __PUTPARD2
	SBIW R28,4
	RCALL SUBOPT_0x2F
	RCALL _cos
	RCALL SUBOPT_0x1D
	RCALL __CPD10
	BRNE _0x204001A
	RCALL SUBOPT_0x2F
	RCALL __CPD02
	BRGE _0x204001B
	RCALL SUBOPT_0x30
	RJMP _0x20A0006
_0x204001B:
	RCALL SUBOPT_0x20
	RJMP _0x20A0006
_0x204001A:
	RCALL SUBOPT_0x2F
	RCALL _sin
	MOVW R26,R30
	MOVW R24,R22
	RCALL SUBOPT_0x1E
	RJMP _0x20A0005
; .FEND
_xatan:
; .FSTART _xatan
	RCALL __PUTPARD2
	SBIW R28,4
	__GETD1S 4
	RCALL SUBOPT_0x2F
	RCALL __MULF12
	RCALL SUBOPT_0x1D
	RCALL SUBOPT_0x1E
	__GETD2N 0x40CBD065
	RCALL SUBOPT_0x31
	RCALL SUBOPT_0x2F
	RCALL __MULF12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0x1E
	__GETD2N 0x41296D00
	RCALL __ADDF12
	RCALL SUBOPT_0x32
	RCALL SUBOPT_0x31
	POP  R26
	POP  R27
	POP  R24
	POP  R25
_0x20A0005:
	RCALL __DIVF21
_0x20A0006:
	ADIW R28,8
	RET
; .FEND
_yatan:
; .FSTART _yatan
	RCALL SUBOPT_0x1C
	__GETD1N 0x3ED413CD
	RCALL __CMPF12
	BRSH _0x2040020
	RCALL SUBOPT_0x32
	RCALL _xatan
	RJMP _0x20A0001
_0x2040020:
	RCALL SUBOPT_0x32
	__GETD1N 0x401A827A
	RCALL __CMPF12
	BREQ PC+2
	BRCC PC+2
	RJMP _0x2040021
	RCALL SUBOPT_0x1E
	RCALL SUBOPT_0xE
	RCALL SUBOPT_0x33
	RJMP _0x20A0002
_0x2040021:
	RCALL SUBOPT_0x1E
	RCALL SUBOPT_0xE
	RCALL __SUBF12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0x1E
	RCALL SUBOPT_0xE
	RCALL __ADDF12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	RCALL SUBOPT_0x33
	__GETD2N 0x3F490FDB
	RCALL __ADDF12
	RJMP _0x20A0001
; .FEND
_asin:
; .FSTART _asin
	RCALL SUBOPT_0x25
	RCALL SUBOPT_0x34
	BRLO _0x2040023
	RCALL SUBOPT_0x27
	RCALL SUBOPT_0xB
	RCALL __CMPF12
	BREQ PC+3
	BRCS PC+2
	RJMP _0x2040023
	RJMP _0x2040022
_0x2040023:
	RCALL SUBOPT_0x30
	RJMP _0x20A0004
_0x2040022:
	LDD  R26,Y+8
	TST  R26
	BRPL _0x2040025
	RCALL SUBOPT_0x2B
	LDI  R17,LOW(1)
_0x2040025:
	RCALL SUBOPT_0x29
	RCALL SUBOPT_0x27
	RCALL __MULF12
	RCALL SUBOPT_0xE
	RCALL __SWAPD12
	RCALL __SUBF12
	MOVW R26,R30
	MOVW R24,R22
	RCALL _sqrt
	RCALL SUBOPT_0x2C
	RCALL SUBOPT_0x27
	RCALL SUBOPT_0x23
	BREQ PC+2
	BRCC PC+2
	RJMP _0x2040026
	RCALL SUBOPT_0x29
	__GETD2S 1
	RCALL SUBOPT_0x35
	__GETD2N 0x3FC90FDB
	RCALL __SWAPD12
	RCALL __SUBF12
	RJMP _0x2040035
_0x2040026:
	RCALL SUBOPT_0x2D
	RCALL SUBOPT_0x27
	RCALL SUBOPT_0x35
_0x2040035:
	__PUTD1S 1
	CPI  R17,0
	BREQ _0x2040028
	RCALL SUBOPT_0x2D
	RCALL __ANEGF1
	RJMP _0x20A0004
_0x2040028:
	RCALL SUBOPT_0x2D
_0x20A0004:
	LDD  R17,Y+0
	ADIW R28,9
	RET
; .FEND
_acos:
; .FSTART _acos
	RCALL SUBOPT_0x1C
	RCALL SUBOPT_0x34
	BRLO _0x204002A
	RCALL SUBOPT_0x32
	RCALL SUBOPT_0xB
	RCALL __CMPF12
	BREQ PC+3
	BRCS PC+2
	RJMP _0x204002A
	RJMP _0x2040029
_0x204002A:
	RCALL SUBOPT_0x30
	RJMP _0x20A0001
_0x2040029:
	RCALL SUBOPT_0x32
	RCALL _asin
_0x20A0002:
	__GETD2N 0x3FC90FDB
	RCALL __SWAPD12
_0x20A0003:
	RCALL __SUBF12
_0x20A0001:
	ADIW R28,4
	RET
; .FEND

	.CSEG

	.CSEG
_strcpyf:
; .FSTART _strcpyf
	ST   -Y,R27
	ST   -Y,R26
    ld   r30,y+
    ld   r31,y+
    ld   r26,y+
    ld   r27,y+
    movw r24,r26
strcpyf0:
	lpm  r0,z+
    st   x+,r0
    tst  r0
    brne strcpyf0
    movw r30,r24
    ret
; .FEND

	.DSEG
_a:
	.BYTE 0x4
_b:
	.BYTE 0x4
_c:
	.BYTE 0x4
_q:
	.BYTE 0x4
_t:
	.BYTE 0x4
_lcd:
	.BYTE 0x19
__base_y_G100:
	.BYTE 0x4
__seed_G101:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x0:
	RCALL _key
	MOV  R7,R30
	LDI  R30,LOW(15)
	CP   R30,R7
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:79 WORDS
SUBOPT_0x1:
	LDI  R30,LOW(0)
	STS  _a,R30
	STS  _a+1,R30
	STS  _a+2,R30
	STS  _a+3,R30
	STS  _b,R30
	STS  _b+1,R30
	STS  _b+2,R30
	STS  _b+3,R30
	STS  _c,R30
	STS  _c+1,R30
	STS  _c+2,R30
	STS  _c+3,R30
	RJMP _lcd_clear

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:39 WORDS
SUBOPT_0x2:
	LDS  R26,_a
	LDS  R27,_a+1
	LDS  R24,_a+2
	LDS  R25,_a+3
	__GETD1N 0x41200000
	RCALL __MULF12
	MOVW R26,R30
	MOVW R24,R22
	MOV  R30,R7
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __CDF1
	RCALL __ADDF12
	STS  _a,R30
	STS  _a+1,R31
	STS  _a+2,R22
	STS  _a+3,R23
	MOV  R30,R7
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(_lcd)
	LDI  R27,HIGH(_lcd)
	RCALL _itoa
	LDI  R26,LOW(_lcd)
	LDI  R27,HIGH(_lcd)
	RCALL _lcd_puts
	LDI  R26,LOW(50)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x3:
	MOV  R30,R7
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x4:
	LDS  R26,_b
	LDS  R27,_b+1
	LDS  R24,_b+2
	LDS  R25,_b+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x5:
	__GETD1N 0x41200000
	RCALL __MULF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x6:
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __CDF1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:28 WORDS
SUBOPT_0x7:
	LDS  R30,_b
	LDS  R31,_b+1
	LDS  R22,_b+2
	LDS  R23,_b+3
	LDS  R26,_a
	LDS  R27,_a+1
	LDS  R24,_a+2
	LDS  R25,_a+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x8:
	RCALL __DIVF21
	STS  _c,R30
	STS  _c+1,R31
	STS  _c+2,R22
	STS  _c+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:68 WORDS
SUBOPT_0x9:
	STS  _c,R30
	STS  _c+1,R31
	STS  _c+2,R22
	STS  _c+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0xA:
	LDS  R30,_a
	LDS  R31,_a+1
	LDS  R22,_a+2
	LDS  R23,_a+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xB:
	__GETD1N 0x3F800000
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xC:
	STS  _q,R30
	STS  _q+1,R31
	STS  _q+2,R22
	STS  _q+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:33 WORDS
SUBOPT_0xD:
	LDS  R26,_t
	LDS  R27,_t+1
	LDS  R24,_t+2
	LDS  R25,_t+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0xE:
	__GETD2N 0x3F800000
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xF:
	LDS  R26,_a
	LDS  R27,_a+1
	LDS  R24,_a+2
	LDS  R25,_a+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x10:
	LDI  R17,LOW(0)
	LDI  R26,LOW(50)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x11:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x12:
	__GETD1S 9
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x13:
	__PUTD1S 9
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x14:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,1
	STD  Y+6,R26
	STD  Y+6+1,R27
	SBIW R26,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x15:
	__GETD2S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x16:
	__GETD1N 0x3DCCCCCD
	RCALL __MULF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x17:
	__PUTD1S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x18:
	__GETD1S 2
	__GETD2S 9
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x19:
	__GETD2N 0x3F000000
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1A:
	MOV  R30,R16
	SUBI R30,-LOW(48)
	ST   X,R30
	MOV  R30,R16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x1B:
	__GETD2S 9
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x1C:
	RCALL __PUTPARD2
	RCALL __GETD2S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x1D:
	RCALL __PUTD1S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0x1E:
	RCALL __GETD1S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x1F:
	__GETD2S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x20:
	__GETD1N 0xFF7FFFFF
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x21:
	__GETD1S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x22:
	__PUTD1S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x23:
	__GETD1N 0x3F3504F3
	RCALL __CMPF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x24:
	__GETD1S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x25:
	RCALL __PUTPARD2
	SBIW R28,4
	ST   -Y,R17
	LDI  R17,0
	__GETD2S 5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x26:
	__PUTD1S 5
	__GETD2S 5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:22 WORDS
SUBOPT_0x27:
	__GETD2S 5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x28:
	__GETD1N 0x3F000000
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x29:
	__GETD1S 5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2A:
	RCALL __SUBF12
	__PUTD1S 5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2B:
	RCALL SUBOPT_0x29
	RCALL __ANEGF1
	__PUTD1S 5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2C:
	__PUTD1S 1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x2D:
	__GETD1S 1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2E:
	__GETD2S 1
	RCALL __MULF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x2F:
	__GETD2S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x30:
	__GETD1N 0x7F7FFFFF
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x31:
	RCALL __MULF12
	__GETD2N 0x414A8F4E
	RCALL __ADDF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x32:
	RCALL __GETD2S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x33:
	RCALL __DIVF21
	MOVW R26,R30
	MOVW R24,R22
	RJMP _xatan

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x34:
	__GETD1N 0xBF800000
	RCALL __CMPF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x35:
	RCALL __DIVF21
	MOVW R26,R30
	MOVW R24,R22
	RJMP _yatan


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0x3E8
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

_frexp:
	LD   R30,Y+
	LD   R31,Y+
	LD   R22,Y+
	LD   R23,Y+
	BST  R23,7
	LSL  R22
	ROL  R23
	CLR  R24
	SUBI R23,0x7E
	SBC  R24,R24
	ST   X+,R23
	ST   X,R24
	LDI  R23,0x7E
	LSR  R23
	ROR  R22
	BRTS __ANEGF1
	RET

__ANEGF1:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __ANEGF10
	SUBI R23,0x80
__ANEGF10:
	RET

__ROUND_REPACK:
	TST  R21
	BRPL __REPACK
	CPI  R21,0x80
	BRNE __ROUND_REPACK0
	SBRS R30,0
	RJMP __REPACK
__ROUND_REPACK0:
	ADIW R30,1
	ADC  R22,R25
	ADC  R23,R25
	BRVS __REPACK1

__REPACK:
	LDI  R21,0x80
	EOR  R21,R23
	BRNE __REPACK0
	PUSH R21
	RJMP __ZERORES
__REPACK0:
	CPI  R21,0xFF
	BREQ __REPACK1
	LSL  R22
	LSL  R0
	ROR  R21
	ROR  R22
	MOV  R23,R21
	RET
__REPACK1:
	PUSH R21
	TST  R0
	BRMI __REPACK2
	RJMP __MAXRES
__REPACK2:
	RJMP __MINRES

__UNPACK:
	LDI  R21,0x80
	MOV  R1,R25
	AND  R1,R21
	LSL  R24
	ROL  R25
	EOR  R25,R21
	LSL  R21
	ROR  R24

__UNPACK1:
	LDI  R21,0x80
	MOV  R0,R23
	AND  R0,R21
	LSL  R22
	ROL  R23
	EOR  R23,R21
	LSL  R21
	ROR  R22
	RET

__CFD1U:
	SET
	RJMP __CFD1U0
__CFD1:
	CLT
__CFD1U0:
	PUSH R21
	RCALL __UNPACK1
	CPI  R23,0x80
	BRLO __CFD10
	CPI  R23,0xFF
	BRCC __CFD10
	RJMP __ZERORES
__CFD10:
	LDI  R21,22
	SUB  R21,R23
	BRPL __CFD11
	NEG  R21
	CPI  R21,8
	BRTC __CFD19
	CPI  R21,9
__CFD19:
	BRLO __CFD17
	SER  R30
	SER  R31
	SER  R22
	LDI  R23,0x7F
	BLD  R23,7
	RJMP __CFD15
__CFD17:
	CLR  R23
	TST  R21
	BREQ __CFD15
__CFD18:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R21
	BRNE __CFD18
	RJMP __CFD15
__CFD11:
	CLR  R23
__CFD12:
	CPI  R21,8
	BRLO __CFD13
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R23
	SUBI R21,8
	RJMP __CFD12
__CFD13:
	TST  R21
	BREQ __CFD15
__CFD14:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R21
	BRNE __CFD14
__CFD15:
	TST  R0
	BRPL __CFD16
	RCALL __ANEGD1
__CFD16:
	POP  R21
	RET

__CDF1U:
	SET
	RJMP __CDF1U0
__CDF1:
	CLT
__CDF1U0:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __CDF10
	CLR  R0
	BRTS __CDF11
	TST  R23
	BRPL __CDF11
	COM  R0
	RCALL __ANEGD1
__CDF11:
	MOV  R1,R23
	LDI  R23,30
	TST  R1
__CDF12:
	BRMI __CDF13
	DEC  R23
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R1
	RJMP __CDF12
__CDF13:
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R1
	PUSH R21
	RCALL __REPACK
	POP  R21
__CDF10:
	RET

__SWAPACC:
	PUSH R20
	MOVW R20,R30
	MOVW R30,R26
	MOVW R26,R20
	MOVW R20,R22
	MOVW R22,R24
	MOVW R24,R20
	MOV  R20,R0
	MOV  R0,R1
	MOV  R1,R20
	POP  R20
	RET

__UADD12:
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	RET

__NEGMAN1:
	COM  R30
	COM  R31
	COM  R22
	SUBI R30,-1
	SBCI R31,-1
	SBCI R22,-1
	RET

__SUBF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129
	LDI  R21,0x80
	EOR  R1,R21

	RJMP __ADDF120

__ADDF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129

__ADDF120:
	CPI  R23,0x80
	BREQ __ADDF128
__ADDF121:
	MOV  R21,R23
	SUB  R21,R25
	BRVS __ADDF1211
	BRPL __ADDF122
	RCALL __SWAPACC
	RJMP __ADDF121
__ADDF122:
	CPI  R21,24
	BRLO __ADDF123
	CLR  R26
	CLR  R27
	CLR  R24
__ADDF123:
	CPI  R21,8
	BRLO __ADDF124
	MOV  R26,R27
	MOV  R27,R24
	CLR  R24
	SUBI R21,8
	RJMP __ADDF123
__ADDF124:
	TST  R21
	BREQ __ADDF126
__ADDF125:
	LSR  R24
	ROR  R27
	ROR  R26
	DEC  R21
	BRNE __ADDF125
__ADDF126:
	MOV  R21,R0
	EOR  R21,R1
	BRMI __ADDF127
	RCALL __UADD12
	BRCC __ADDF129
	ROR  R22
	ROR  R31
	ROR  R30
	INC  R23
	BRVC __ADDF129
	RJMP __MAXRES
__ADDF128:
	RCALL __SWAPACC
__ADDF129:
	RCALL __REPACK
	POP  R21
	RET
__ADDF1211:
	BRCC __ADDF128
	RJMP __ADDF129
__ADDF127:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	BREQ __ZERORES
	BRCC __ADDF1210
	COM  R0
	RCALL __NEGMAN1
__ADDF1210:
	TST  R22
	BRMI __ADDF129
	LSL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVC __ADDF1210

__ZERORES:
	CLR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	POP  R21
	RET

__MINRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	SER  R23
	POP  R21
	RET

__MAXRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	LDI  R23,0x7F
	POP  R21
	RET

__MULF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BREQ __ZERORES
	CPI  R25,0x80
	BREQ __ZERORES
	EOR  R0,R1
	SEC
	ADC  R23,R25
	BRVC __MULF124
	BRLT __ZERORES
__MULF125:
	TST  R0
	BRMI __MINRES
	RJMP __MAXRES
__MULF124:
	PUSH R0
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R17
	CLR  R18
	CLR  R25
	MUL  R22,R24
	MOVW R20,R0
	MUL  R24,R31
	MOV  R19,R0
	ADD  R20,R1
	ADC  R21,R25
	MUL  R22,R27
	ADD  R19,R0
	ADC  R20,R1
	ADC  R21,R25
	MUL  R24,R30
	RCALL __MULF126
	MUL  R27,R31
	RCALL __MULF126
	MUL  R22,R26
	RCALL __MULF126
	MUL  R27,R30
	RCALL __MULF127
	MUL  R26,R31
	RCALL __MULF127
	MUL  R26,R30
	ADD  R17,R1
	ADC  R18,R25
	ADC  R19,R25
	ADC  R20,R25
	ADC  R21,R25
	MOV  R30,R19
	MOV  R31,R20
	MOV  R22,R21
	MOV  R21,R18
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	POP  R0
	TST  R22
	BRMI __MULF122
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	RJMP __MULF123
__MULF122:
	INC  R23
	BRVS __MULF125
__MULF123:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__MULF127:
	ADD  R17,R0
	ADC  R18,R1
	ADC  R19,R25
	RJMP __MULF128
__MULF126:
	ADD  R18,R0
	ADC  R19,R1
__MULF128:
	ADC  R20,R25
	ADC  R21,R25
	RET

__DIVF21:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BRNE __DIVF210
	TST  R1
__DIVF211:
	BRPL __DIVF219
	RJMP __MINRES
__DIVF219:
	RJMP __MAXRES
__DIVF210:
	CPI  R25,0x80
	BRNE __DIVF218
__DIVF217:
	RJMP __ZERORES
__DIVF218:
	EOR  R0,R1
	SEC
	SBC  R25,R23
	BRVC __DIVF216
	BRLT __DIVF217
	TST  R0
	RJMP __DIVF211
__DIVF216:
	MOV  R23,R25
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R1
	CLR  R17
	CLR  R18
	CLR  R19
	CLR  R20
	CLR  R21
	LDI  R25,32
__DIVF212:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R20,R17
	BRLO __DIVF213
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R20,R17
	SEC
	RJMP __DIVF214
__DIVF213:
	CLC
__DIVF214:
	ROL  R21
	ROL  R18
	ROL  R19
	ROL  R1
	ROL  R26
	ROL  R27
	ROL  R24
	ROL  R20
	DEC  R25
	BRNE __DIVF212
	MOVW R30,R18
	MOV  R22,R1
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	TST  R22
	BRMI __DIVF215
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVS __DIVF217
__DIVF215:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__CMPF12:
	TST  R25
	BRMI __CMPF120
	TST  R23
	BRMI __CMPF121
	CP   R25,R23
	BRLO __CMPF122
	BRNE __CMPF121
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	BRLO __CMPF122
	BREQ __CMPF123
__CMPF121:
	CLZ
	CLC
	RET
__CMPF122:
	CLZ
	SEC
	RET
__CMPF123:
	SEZ
	CLC
	RET
__CMPF120:
	TST  R23
	BRPL __CMPF122
	CP   R25,R23
	BRLO __CMPF121
	BRNE __CMPF122
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	BRLO __CMPF122
	BREQ __CMPF123
	RJMP __CMPF121

_sqrt:
	rcall __PUTPARD2
	sbiw r28,4
	push r21
	ldd  r25,y+7
	tst  r25
	brne __sqrt0
	adiw r28,8
	rjmp __zerores
__sqrt0:
	brpl __sqrt1
	adiw r28,8
	rjmp __maxres
__sqrt1:
	push r20
	ldi  r20,66
	ldd  r24,y+6
	ldd  r27,y+5
	ldd  r26,y+4
__sqrt2:
	st   y,r24
	std  y+1,r25
	std  y+2,r26
	std  y+3,r27
	movw r30,r26
	movw r22,r24
	ldd  r26,y+4
	ldd  r27,y+5
	ldd  r24,y+6
	ldd  r25,y+7
	rcall __divf21
	ld   r24,y
	ldd  r25,y+1
	ldd  r26,y+2
	ldd  r27,y+3
	rcall __addf12
	rcall __unpack1
	dec  r23
	rcall __repack
	ld   r24,y
	ldd  r25,y+1
	ldd  r26,y+2
	ldd  r27,y+3
	eor  r26,r30
	andi r26,0xf8
	brne __sqrt4
	cp   r27,r31
	cpc  r24,r22
	cpc  r25,r23
	breq __sqrt3
__sqrt4:
	dec  r20
	breq __sqrt3
	movw r26,r30
	movw r24,r22
	rjmp __sqrt2
__sqrt3:
	pop  r20
	pop  r21
	adiw r28,8
	ret

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__CBD1:
	MOV  R31,R30
	ADD  R31,R31
	SBC  R31,R31
	MOV  R22,R31
	MOV  R23,R31
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__GETD1S0:
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R22,Y+2
	LDD  R23,Y+3
	RET

__GETD2S0:
	LD   R26,Y
	LDD  R27,Y+1
	LDD  R24,Y+2
	LDD  R25,Y+3
	RET

__PUTD1S0:
	ST   Y,R30
	STD  Y+1,R31
	STD  Y+2,R22
	STD  Y+3,R23
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__PUTPARD2:
	ST   -Y,R25
	ST   -Y,R24
	ST   -Y,R27
	ST   -Y,R26
	RET

__SWAPD12:
	MOV  R1,R24
	MOV  R24,R22
	MOV  R22,R1
	MOV  R1,R25
	MOV  R25,R23
	MOV  R23,R1

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__CPD10:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	RET

__CPD02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	CPC  R0,R24
	CPC  R0,R25
	RET

;END OF CODE MARKER
__END_OF_CODE:
