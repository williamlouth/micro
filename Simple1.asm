	#include p18f87k22.inc
	
	code
	
	org 0x0	
goto	start
	;banksel PADCFG1 ; PADCFG1 is not in Access Bank!!
	
	org 0x100		    ; Main code starts here at address 0x100

start	
	
	call port_e_pull_up
	movlw	0x00
	movwf	TRISD, ACCESS	;Port D all outputs
	movwf   TRISE, ACCESS   ;Port E all outputs
	goto	read
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
	
	

port_e_pull_up
	bsf PADCFG1, REPU, BANKED ; PortE pull-ups on
	movlb 0x00 ; set BSR back to Bank 0
	setf TRISE ; Tri-state PortE
	return
	
	
read	movlw	0x00
	movwf	TRISD, ACCESS	;Port D all outputs
	movlw   0xff
	movwf	TRISE, ACCESS	;Port E all inputs
	movlw   0x4
	movwf   PORTD, ACCESS	;set both clocks and 0e's high, stable state
	
	movlw  0x0
	movwf  0x20
	
	movlw  0x1
	movwf  0x21
	
	movlw  0x2
	movwf  0x22
	
	movlw  0x3
	movwf  0x23
	
	movlw  0x1
	
	cpfseq  0x20
	bra	0x1
	bra	read_0
	
	cpfseq  0x21
	bra	0x1
	bra	read_1
	
	return 
	
	
read_0		
	return 
	
read_1
	return 
	
	;return fast
	
	
	
	
	
	
	
	end
