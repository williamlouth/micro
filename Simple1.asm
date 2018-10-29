	#include p18f87k22.inc
	
	
	;extern	sixteenby16, sixteen_in_1,sixteen_in_2,sixteenB_in_1,sixteenB_in_2,thirty2_out_1,thirty2_out_2,thirty2_out_3,thirty2_out_4,thirty2_out_5
	
	extern  sixteenby16, sixteen_in_1,sixteen_in_2,sixteenB_in_1,sixteenB_in_2
	extern  eightby24,twenty4_in_1,twenty4_in_2,twenty4_in_3,eight_in
	extern  thirty2_out_1,thirty2_out_2,thirty2_out_3,thirty2_out_4
	
	code
	org 0x0	
	goto	start
	
	org 0x100		    ; Main code starts here at address 0x100

start
	movlw  0x69
	movwf  eight_in
	
	movlw  0x42
	movwf  twenty4_in_1
	
	movlw  0x45
	movwf  twenty4_in_2
	
	movlw  0x34
	movwf  twenty4_in_3
	
	call eightby24
	
	movf	thirty2_out_1,w
	movf	thirty2_out_2,w
	movf	thirty2_out_3,w
	movf	thirty2_out_4,w

	
	
	goto start
;start	;setup porte pull ups
;	banksel PADCFG1 ; PADCFG1 is not in Access Bank!!
;	bsf PADCFG1, REPU, BANKED ; PortE pull-ups on
;	movlb 0x00 ; set BSR back to Bank 0
	
;setup1	movlw b'00001111'    ;set low 4 to inputs, high 4 to outputs 
;	movwf TRISE, ACCESS ;on port E
;	movff PORTE, 0x20
;

	
;setup2	swapf 0x20 ,f,a     ;move previous read to high 4 bits
;	movlw b'11110000'    ;set high 4 to inputs, low 4 to outputs 
;	movwf TRISE, ACCESS ;on port E
;	movff PORTE, 0x20
;		
	
;	movlw 0x00
;	movwf	TRISD
;	movff 0x20, PORTD
	
;	
;	goto 	start		    ; Re-run program from start
	
	end
