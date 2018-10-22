	#include p18f87k22.inc

	extern	UART_Setup, UART_Transmit_Message  ; external UART subroutines
	extern  LCD_Setup, LCD_Write_Message, LCD_clear, LCD_2nd_line,LCD_Send_Byte_D    ; external LCD subroutines
	
acs0	udata_acs   ; reserve data space in access ram
counter	    res 1   ; reserve one byte for a counter variable
delay_count res 1   ; reserve one byte for counter in the delay routine

tables	udata	0x400    ; reserve data anywhere in RAM (here at 0x400)
myArray res 0x80    ; reserve 128 bytes for message data

rst	code	0    ; reset vector
	goto	setup

pdata	code    ; a section of programme memory for storing data
	; ******* myTable, data in programme memory, and its length *****
myTable data	    "Hello World!\n"	; message, plus carriage return
	constant    myTable_l=.13	; length of data
myTable2 data	    "Send nudes\n"	; message, plus carriage return
	constant    myTable2_l=.11	; length of data
	
main	code
	; ******* Programme FLASH read Setup Code ***********************
setup	bcf	EECON1, CFGS	; point to Flash program memory  
	bsf	EECON1, EEPGD 	; access Flash program memory
	call	UART_Setup	; setup UART
	call	LCD_Setup	; setup LCD
	call	button_set
	goto	start
	
	; ******* Main programme ****************************************
start	call LCD_clear
	lfsr	FSR0, myArray	; Load FSR0 with address in RAM	
	movlw	upper(myTable)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(myTable)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(myTable)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	movlw	myTable_l	; bytes to read
	movwf 	counter		; our counter registe\r
	decf	counter		;remove the carrige return
	goto	loop
	
start2	call LCD_clear
	lfsr	FSR0, myArray	; Load FSR0 with address in RAM	
	movlw	upper(myTable2)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(myTable2)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(myTable2)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	movlw	myTable2_l	; bytes to read
	movwf 	counter		; our counter registe\r
	decf	counter		;remove the carrige return
	call LCD_2nd_line
	goto	loop
loop 	
	tblrd*+		    ; one byte from PM to TABLAT, increment TBLPRT
	movf	TABLAT, w   ; move data from TABLAT to working
	call	LCD_Send_Byte_D	;write data in working to LCD
	
	decfsz	counter		; count down to zero
	bra	loop		; keep going until finished table
	
	goto	button_pending
	goto	$		; goto current line in code

	; a delay subroutine if you need one, times around loop in delay_count
delay	decfsz	delay_count	; decrement until zero
	bra delay
	return

button_set
	movlw 0xff
	movwf TRISD, ACCESS ;sets Port d to input
	return
	
button_pending
	BTFSC	PORTD, 0x0, A ;if button 1 pressed clears the LCD
	call LCD_clear
	BTFSC	PORTD, 0x1, A ;if button 2 pressed displays what is saved in table 1
	goto start
	BTFSC	PORTD, 0x2, A ;if button 3 pressed displays what is saved in table 2
	goto start2
	;BTFSC	PORTD, 0x3, A
	;call rifkat
	;BTFSC	PORTD, 0x4, A
	
	bra button_pending
	
rifkat 
	call LCD_2nd_line
	call start
	return
	end