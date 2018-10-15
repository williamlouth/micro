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
	call	write_setup
	call	read_setup
	
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
	
	
read_setup	movlw	0x00
	movwf	TRISD, ACCESS	;Port D all outputs
	movlw   0xff
	movwf	TRISE, ACCESS	;Port E all inputs
	movlw   0xff
	movwf   PORTD, ACCESS	;set both clocks and 0e's high, stable state
	
	
	movlw  0x0
	movwf  0x20
	
	movlw  0x1
	movwf  0x21 , ACCESS
	
	movlw  0x2
	movwf  0x22 , ACCESS
	
	movlw  0x3
	movwf  0x23  , ACCESS
	
	movlw  0x1
	
check_1	cpfseq  0x20
	bra	check_2
	bra	read_0
	
check_2	cpfseq  0x21
	return
	bra	read_1
	
	 
	
	
read_0	bcf     1,PORTD
	movff   PORTE, 0x10
	bsf     1,PORTD
	return 
	
read_1
	bcf     3,PORTD
	movff   PORTE, 0x10
	bsf     3,PORTD
	return 
	
	;return fast
	
write_setup
	movlw	0x00
	movwf	TRISD, ACCESS	;Port D all outputs
	movlw   0x00
	movwf	TRISE, ACCESS	;Port E all output
	movlw   0xff
	movwf   PORTD, ACCESS	;set both clocks and 0e's high, stable state
	
	
	movlw  0x0
	movwf  0x20
	
	movlw  0x1
	movwf  0x21 , ACCESS
	
	movlw  0x2
	movwf  0x22 , ACCESS
	
	movlw  0x3
	movwf  0x23  , ACCESS
	
	movlw  0x1
	
check_1_w	
	cpfseq  0x20
	bra	check_2_w
	bra	write_0
	
check_2_w	
	cpfseq  0x21
	return
	bra	write_1
	
	
write_0
	movlw	0x45
	movwf   PORTE, ACCESS
	bcf	0,PORTD
	bsf	0,PORTD
	call	port_e_pull_up
	return
	
write_1
	movlw	0x69
	movwf   PORTE, ACCESS
	bcf	2,PORTD
	bsf	2,PORTD
	call	port_e_pull_up
	return
	
	end
