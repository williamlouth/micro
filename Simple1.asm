	#include p18f87k22.inc
	
	code
	org 0x0	
goto	start
	
	org 0x100		    ; Main code starts here at address 0x100

start	movlw	0x00
	movwf	TRISD, ACCESS	;Port D all outputs
	movwf   TRISE, ACCESS   ;Port E all outputs
	;movlw   0x2
	;movwf   PORTD, ACCESS
	
	
to_run  movlw  0x45
	movwf  PORTE, ACCESS   ;load data to 45h
	
	movlw  0x1
	movwf  PORTD, ACCESS	;set clock high
	
	movlw  0x0		;set clock low
	movwf  PORTD,ACCESS
	
	movlw  0x0		;load data 0
	movwf  PORTE,ACCESS
	
	movlw  0x1
	movwf  PORTD, ACCESS	;set clock high
	
	movlw  0x0		;set clock low
	movwf  PORTD,ACCESS
		   
	bra    to_run
	goto   0x0		    ; Re-run program from start
	
	end
