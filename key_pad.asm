	#include p18f87k22.inc
	global	start_keypad
	extern delay
    
	
key_pad_vars    udata_acs	    ; named variables in access ram
raw_numb res 1
decode_numb res 1
decode

 
key_pad code
 
myTable db  '1','2','3','A','4','5','6','B','7','8','9','C','*','0','#','D',; message, plus carriage return
	constant    myTable_l=.16	; length of data
 
	
start_keypad	;setup porte pull ups
	banksel PADCFG1 ; PADCFG1 is not in Access Bank!!
	bsf PADCFG1, REPU, BANKED ; PortE pull-ups on
	movlb 0x00 ; set BSR back to Bank 0
	clrf LATE
setup1	
	movlw b'00001111'    ;set low 4 to inputs, high 4 to outputs 
	movwf TRISE, ACCESS ;on port E
	call delay
	movff PORTE, raw_numb


	
setup2	movlw b'11110000'    ;set high 4 to inputs, low 4 to outputs 
	movwf TRISE, ACCESS ;on port E
	call delay
	movf PORTE,w
	addwf raw_numb,f
	
		
	
 	movlw 0x00
	movwf	TRISD
	movff raw_numb, PORTD
	call delay
	goto setup1
	
key_pad_decode
	movff raw_numb,decode_numb
	comf decode_numb,f
	
	
    
    
    end
    
    
    
    
    
    
    
    
    
    
    


