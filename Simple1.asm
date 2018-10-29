	#include p18f87k22.inc
	
	
	extern	start_keypad
	
	code
	org 0x0	
	goto	start_keypad
	
	org 0x100		    ; Main code starts here at address 0x100

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
