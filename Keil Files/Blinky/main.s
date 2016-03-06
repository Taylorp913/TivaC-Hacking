  ;THUMB
	;AREA	|.text|, CODE, READONLY, ALIGN=2
	;EXPORT 	Start



;GPIO_CLK 	DCD 0x400FE018 ;address for GPIO Clock
;CLKVAL 		DCD 0x0020 ;value for enabling gpios clock
;UNLOCK 		DCD 0x4C4F434B ; gpio unlock code.
;GPIOF 		DCD 0x40025000 ;base address for one of the GPIOs
;GPIOF_PINS 	DCD 0xE ;value for configuring the gpio
;;LIST the values toggled by the setup value.
;;i.e. gpio enable, pull up register, etc.
	
	;ALIGN
;Start
	;mov32 R0, #0x400FE108 ; Enable GPIO Clock
	;mov R1, #0x20
	;str R1, [R0]
	;mov32 R0, #0x40025000 ;GPIOF address
	;;unlock GPIOF
	;mov32 R1, #0x4C4F434B; GPIO Unlock code.
	;str R1, [R0,#0x520];
	;mov R1, #0x1F
	;str R1, [R0,#0x524];GPIOCR
	;mov R1, #0x11
	;str R1, [R0,#0x510]
	;mov R1, #0x0F
	;str R1, [R0,#0x400] ;GPIODIR
	;mov R1, #0x1F
	;str R1, [R0,#0x51C] ;digital enable
;loop
	;MOV32 R1, #0x02 ;load value for turning on first two LEDs
	;STR R1, [R0,#0x38] ;write the above value to GPIOC DC3 register. see pg 431 in data sheet.
	;MOV R4, #0 ;initial value for iteration loop
	;MOV32 R5, #0xFFFFF ;number of iterations for delay loops
;delay1
	;ADD R4, #2 ;increment by two
	;CMP R4, R5 ;check number of iterations
	;BLE delay1 ;continue if iterated less than 0xFFFFF + 1 times, otherwise repeat delay loop
	;MOV32 R1, #0x04 ;load value for turning on last two LEDs and turning off last two LEDs
	;STR R1, [R0, #0x38] ;write the above value to GPIOC ODR
	;MOV R4, #0 ;initial value for iteration loop
;; ; **** the tm4c123gh6pm has 16 MHz clock.
;;; how long should the loop take with that clock?
;;ans,Loop is essentially counting to FFFFF by twos.
;;the loop under the current state should take 1sec/16MHZ*1048575/2=.0327sec
;delay2
	;ADD R4, #2 ;increment by two
	;CMP R4, R5 ;check number of iterations
	;BLE delay2 ;continue if iterated less than 0xFFFFF + 1 times, otherwise repeat delay loop
	;MOV32 R1, #0x08 ;load value for turning on last two LEDs and turning off last two LEDs
	;STR R1, [R0, #0x38] ;write the above value to GPIOC ODR
	;B loop ;do it all over again, forever
	;ALIGN
	;END
	
	THUMB
       AREA    DATA, ALIGN=2
       ALIGN          
       AREA    |.text|, CODE, READONLY, ALIGN=2
       EXPORT  Start
	   ;unlock 0x4C4F434B
	   
	   ;PF4 is SW1
	   ;PF0 is SW2
	   ;PF1 is RGB Red
	   ;Enable Clock RCGCGPIO p338
	   ;Set direction 1 is out 0 is in. GPIODIR
	   ;DEN 
	   ; 0x3FC
	   
	   ;%FMA>Flash Memory Address	=0x400F.D000
	   ;%FMD>Flash Memory Data		=0x400F.D004
	   ;%FMC>Flash Memory Control	=0x400F.D008
	   ;FCRIS
	   ;FCIM
	   ;FCMISC
	   ;Fsize
	   ;Ssize
	   ;;Flash write buffer
	   ;FMC2
	   ;FWBVAL
	   ;FWBn (32 words)
	   
Start 
	;write to buffer
	mov32 r2, #0x400fd100 ;write FWBn location
	mov32 r1, #0x1008F24E;
	str r1, [r2]
	mov32 r1, #0x000FF2C4 ;
	str r1, [r2, #0x4]
	mov32 r1, #0x0120F04F;
	str r1, [r2, #0x8]
	mov32 r1, #0xF2456001;
	str r1, [r2, #0xC]
	mov32 r1, #0xF2C40000;
	str r1, [r2, #0x10]
	mov32 r1, #0xF2440002;
	str r1, [r2, #0x14]
	mov32 r1, #0xF6C4314B
	str r1, [r2, #0x18]
	mov32 r1, #0xF8C0414F;
	str r1, [r2, #0x1C]
	mov32 r1, #0xF04F1520;
	str r1, [r2, #0x20]
	mov32 r1, #0xF8C0011F;
	str r1, [r2, #0x24]
	mov32 r1, #0xF04F1524;
	str r1, [r2, #0x28]
	mov32 r1, #0xF8C00111;
	str r1, [r2, #0x2C]
	mov32 r1, #0xF04F1510;
	str r1, [r2, #0x30]
	mov32 r1, #0xF8C0010F;
	str r1, [r2, #0x34]
	mov32 r1, #0xF04F1400;
	str r1, [r2, #0x38]
	mov32 r1, #0xF8C0011F;
	str r1, [r2, #0x3C]
	mov32 r1, #0xF240151C
	str r1, [r2, #0x40]
	mov32 r1, #0xF2C00102
	str r1, [r2, #0x44]
	mov32 r1, #0x63810100
	str r1, [r2, #0x48]
	mov32 r1, #0x0400F04F
	str r1, [r2, #0x4C]
	mov32 r1, #0x75FFF64F
	str r1, [r2, #0x50]
	mov32 r1, #0x050FF2C0
	str r1, [r2, #0x54]
	mov32 r1, #0x0402F104
	str r1, [r2, #0x58]
	mov32 r1, #0xDDFB42AC
	str r1, [r2, #0x5C]
	mov32 r1, #0x0104F240
	str r1, [r2, #0x60]
	mov32 r1, #0x0100F2C0
	str r1, [r2, #0x64]
	mov32 r1, #0xF04F6381
	str r1, [r2, #0x68]
	mov32 r1, #0xF1040400
	str r1, [r2, #0x6C]
	mov32 r1, #0x42AC0402
	str r1, [r2, #0x70]
	mov32 r1, #0xF240DDFB
	str r1, [r2, #0x74]
	mov32 r1, #0xF2C00108
	str r1, [r2, #0x78]
	mov32 r1, #0x63810100
	str r1, [r2, #0x7C]
	
	nop;buffer to make sure program is outside of deleting area
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	
	mov32 r0, #0x400fd000 ; flash reg base
	mov32 r1, #0x000 ; addr to erase
	str r1, [r0]
	mov32 r1, #0xA4420002 ; erase 1kb
	str r1, [r0,#0x8];write CMD to control reg
	
	mov32 r1, #0x280 ; addr to write
	str r1, [r0]
	mov32 r1, #0xa4420001 ; write command
	str r1, [r0,#0x20]
	
	mov32 r1, #0x0000E7DF
	str r1, [r2, #0x0]
	mov32 r1, #0x4700483E
	str r1, [r2, #0x4]
	mov32 r1, #0xE7FEE7FE
	str r1, [r2, #0x8]
	mov32 r1, #0xE7FEE7FE
	str r1, [r2, #0xC]
	mov32 r1, #0xE7FEE7FE
	str r1, [r2, #0x10]
	mov32 r1, #0xE7FEE7FE
	str r1, [r2, #0x14]
	
	
	mov32 r1, #0x300 ; addr to write
	str r1, [r0]
	
	mov32 r1, #0xa4420001 ; write command
	str r1, [r0,#0x20]
		
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
		;update PC ans SP
	;mov32 r0, #0x400fd000 ; flash reg base
	;mov32 r1, #0x000 ; addr to erase
	;str r1, [r0]
	;mov32 r1, #0xA4420002 ; erase 1kb
	;str r1, [r0,#0x8];write CMD to control reg


	;mov32 r1, #0x00000801 ; data to write
	;str r1, [r0, #0x4]
	;mov32 r1, #0x004 ;address  
	;str r1, [r0]
	;mov32 r1, #0xa4420001 ; write command
	;str r1, [r0,#0x8]


	mov32 r1, #0x20000208
	str r1, [r2, #0x0]
	mov32 r1, #0x00000281
	str r1, [r2, #0x4]
	mov32 r1, #0x00000309
	str r1, [r2, #0x8]
	mov32 r1, #0x0000030B
	str r1, [r2, #0xC]
	mov32 r1, #0x0000030D
	str r1, [r2, #0x10]
	mov32 r1, #0x0000030F
	str r1, [r2, #0x14]
	mov32 r1, #0x00000311
	str r1, [r2, #0x18]
	mov32 r1, #0x00000000
	str r1, [r2, #0x1C]
	mov32 r1, #0x00000000
	str r1, [r2, #0x20]
	mov32 r1, #0x00000000
	str r1, [r2, #0x24]
	mov32 r1, #0x00000000
	str r1, [r2, #0x28]

	mov32 r1, #0x000 ; addr to write
	str r1, [r0]
	mov32 r1, #0xa4420001 ; write command
	str r1, [r0,#0x20]

	
	;mov32 r1, #0x004 ; addr of PC
	;str r1, [r0]
	;mov32 r1, #0xA4420002 ; erase 1 word
	;str r1, [r0,#0x8];write CMD to control reg




	;time to reset micro
	mov32 r0, #0xe000e000 ; flash reg base
	mov32 r1, #0x05fa0004 ; addr to erase
	str r1, [r0,#0x8]
	
	   ;B   Start

       ALIGN      
       END  