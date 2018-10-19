	#include p18f87k22.inc
	
	code
	
	org 0x0	
	goto	start
	
	
	
	org 0x100		    ; Main code starts here at address 0x100

start	
	call SPI_MasterInit
	
mtest
	movlw 0x45
	call SPI_MasterTransmit
	movlw	0x00
	call SPI_MasterTransmit
	bra mtest
	
	;nop
;	movlw 0x0
	;movwf TRISD, ACCESS
	;movwf PORTD, ACCESS
	
	;movlw 0x40
	;movwf PORTD
	;nop
	;movlw 0x0
	;movwf PORTD
	goto terminate
	
	
	
	
	

SPI_MasterInit ; Set Clock edge to positive
	bcf SSP2STAT, CKE
	; MSSP enable; CKP=1; SPI master, clock=Fosc/64 (1MHz)
	movlw (1<<SSPEN)|(1<<CKP)|(0x02)
	movwf SSP2CON1
	; SDO2 output; SCK2 output
	bcf TRISD, SDO2
	bcf TRISD, SCK2
	return

SPI_MasterTransmit ; Start transmission of data (held in W)
	movwf SSP2BUF
Wait_Transmit ; Wait for transmission to complete
	btfss PIR2, SSP2IF
	bra Wait_Transmit
	bcf PIR2, SSP2IF ; clear interrupt flag
	return
	
	
terminate
	goto $	    ;infinite loop

	end
