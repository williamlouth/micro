	#include p18f87k22.inc
	
	code
	org 0x0	
goto	start
	
	org 0x100		    ; Main code starts here at address 0x100

start	movlw	0x00
	movwf	TRISC, ACCESS	; Port C all outputs
	
	goto	meme_setup
	
	bra 	test
	
loop	call	delay
	movff 	0x06, PORTC
	incf 	0x06, W, ACCESS
	
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
	movlw   0xff 
	movwf   0x21, ACCESS
	call delay_loop2
	DECFSZ  0x20, F, ACCESS
	bra delay_loop
	return
	; Re-run program from start
	
delay_loop2
	DECFSZ  0x21, F, ACCESS
	bra delay_loop2
	return
	

meme_setup
	movlw   0xff
	movwf   0x40, ACCESS    ;counter setup
	lfsr	FSR0, 0x050     ;start location address
	movlw	0x0
	movwf	INDF0           ;begin at zero 
mem_loop
	call	meme_run
	DECFSZ  0x40, F, ACCESS  ;location of counter
	bra	mem_loop
	movlw   0xff
	movwf   0x40, ACCESS
	bra mem_loop2
	
mem_loop2
	call	meme_run
	DECFSZ  0x40, F, ACCESS  ;location of counter
	bra	mem_loop2
	
	
meme_run
	movlw	0x1
	addwf	POSTINC0, w
	movwf	INDF0
	return
	
	
	
	
	end