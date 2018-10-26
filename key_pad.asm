	#include p18f87k22.inc
	global	start_keypad
	extern delay, table_read_setup,table_u,table_h,table_l,table_address,table_counter
    
	
key_pad_vars    udata_acs	    ; named variables in access ram
raw_numb_row res 1
raw_numb_col res 1
dec_numb_row res 1
dec_numb_col res 1
col_numb res 1
row_numb res 1
numb_final res 1
actual_input res 1
 
decode_numb res 1
;decode


tables udata 
myArray1 res 16
myArray2 res 16
 
key_pad code
 
 
table_keys db  "1","2","3","A","4","5","6","B","7","8","9","C","*","0","#","D"; message, plus carriage return
	constant    myTable_l=.16	; length of data
	
table_power db  '£','0','1','£','2','£','£','£','3'  ;
	constant    myTable_2 = .9
	
	
start_keypad	;setup porte pull ups
	banksel PADCFG1 ; PADCFG1 is not in Access Bank!!
	bsf PADCFG1, REPU, BANKED ; PortE pull-ups on
	movlb 0x00 ; set BSR back to Bank 0
	clrf LATE
	call key_pad_decode_setup
	
setup1	
	movlw b'00001111'    ;set low 4 to inputs, high 4 to outputs 
	movwf TRISE, ACCESS ;on port E
	call delay
	movff PORTE, raw_numb_row


	
setup2	movlw b'11110000'    ;set high 4 to inputs, low 4 to outputs 
	movwf TRISE, ACCESS ;on port E
	call delay
	;movf PORTE,w
	;addwf raw_numb,f
	movff PORTE, raw_numb_col
		
	
 	movlw 0x00
	movwf	TRISD
	movf raw_numb_col,w
	addwf raw_numb_row,w
	movwf PORTD,ACCESS
	call delay
	;goto setup1
	
key_pad_decode_setup
	lfsr	FSR0, myArray1	; Load FSR0 with address in RAM	
	movlw	upper(table_keys)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(table_keys)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(table_keys)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	
	movlw myTable_l
	movwf table_counter
	call table_read_setup
	
	lfsr	FSR0, myArray2	; Load FSR0 with address in RAM	
	movlw	upper(table_power)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(table_power)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(table_power)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	
	movlw myTable_2
	movwf table_counter
	call table_read_setup
	return
	
	;movff raw_numb,decode_numb
key_pad_decode
	movff raw_numb_col, dec_numb_col
	movff raw_numb_row, dec_numb_row
	comf dec_numb_row,f
	comf dec_numb_col,f
	
	lfsr	FSR0, myArray2
	;if inp > 8 call invalid input
	movf dec_numb_row,w
	movff PLUSW0,row_numb
	
	movf dec_numb_col,w
	movff PLUSW0,col_numb
	
	lfsr	FSR0, myArray1
	movlw	 .4
	mulwf	row_numb
	movff	PRODL,numb_final
	movfw	col_numb
	addwf	numb_final, f, a
	movff	PLUSW0, actual_input
	;if either row or col has £ call invalid input
	
	
	
	goto setup1
	
;invalid input
    
    end
    
    
    
    
    
    
    
    
    
    
    


