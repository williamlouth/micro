	#include p18f87k22.inc
	
	code
	
	org 0x0	
	goto	start
	
	
	
	org 0x100		    ; Main code starts here at address 0x100

start	
	call	port_e_pull_up
	movlw	0x00
	movwf	TRISD, ACCESS	;Port D all outputs
	movwf	TRISC, ACCESS	;Port D all outputs
	movwf	TRISH, ACCESS	;Port D all outputs
	movlw   0x0
	movwf	PORTC
	movwf	PORTH
	
	;movwf   TRISE, ACCESS   ;Port E all outputs
	
	movlw	0x45	    ;0x30 = whats being written
	movwf	0x30
	movlw	0x0	    ;0x31 = chip being written
	movwf	0x31
	
	call	write_setup
	
	movlw	0x69
	movwf	0x30
	movlw	0x1
	movwf	0x31
	
	call	write_setup
	
	
	
	
	movlw	0x0
	movwf	0x41	    ;chip being read from, writes to 0x40
	call	read_setup
	movff	0x40, PORTC
	
	movlw	0x1
	movwf	0x41	    ;chip being read from, writes to 0x40
	call	read_setup
	movff	0x40, PORTH
	
	
	
	goto	terminate
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
	banksel PADCFG1 ; PADCFG1 is not in Access Bank!!
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
	movwf  0x21 
	
	movlw  0x2
	movwf  0x22 , ACCESS
	
	movlw  0x3
	movwf  0x23  , ACCESS
	
	movf  0x41,W
	
check_1	cpfseq  0x20
	bra	check_2
	bra	read_0
	
check_2	cpfseq  0x21
	return
	bra	read_1
	
	 
	
	
read_0	bcf     PORTD,  0x1
	movff   PORTE,  0x40
	bsf     PORTD,  0x1
	setf	TRISE
	return 
	
read_1
	bcf     PORTD , 0x3
	movff   PORTE, 0x40
	bsf     PORTD,  0x3
	setf	TRISE
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
	
	movf  0x31, W
	
check_1_w	
	cpfseq  0x20
	bra	check_2_w
	bra	write_0
	
check_2_w	
	cpfseq  0x21
	return
	bra	write_1
	
	
write_0
	movf	0x30, W
	movwf   PORTE, ACCESS
	bcf	PORTD, 0x0
	bsf	PORTD, 0x0
	setf	TRISE
	return
	
write_1
	movf	0x30, W
	movwf   PORTE, ACCESS
	bcf	PORTD, 0x2, ACCESS
	bsf	PORTD, 0x2, ACCESS
	setf	TRISE
	return

terminate
	end
	
	end
