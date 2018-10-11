	#include p18f87k22.inc
	
	code
	org 0x0	
goto	start
	
	org 0x100		    ; Main code starts here at address 0x100

start	movlw	0x00
	movwf	TRISC, ACCESS	; Port C all outputs
	
	
	
	bra 	test
loop	movff 	0x06, PORTC
	incf 	0x06, W, ACCESS
	call	delay
test	movwf	0x06, ACCESS	    ; Test for end of loop cnodition
	movlw	0xff
	cpfsgt 	0x06, ACCESS
	bra 	loop		    ; Not yet finished goto start of loop again
	goto 	0x0
	
delay   movlw   0xff
	movwf   0x20, ACCESS
	call delay_loop
		
	return 
	
delay_loop 
	DECFSZ  0x20, F, ACCESS
	movlw   .1
	movwf   0x21, ACCESS
	call delay_loop2
	bra delay_loop
	return
	; Re-run program from start
	
delay_loop2
	DECFSZ  0x21, F, ACCESS
	bra delay_loop2
	return
	end
