	#include p18f87k22.inc
	
	
	;extern	sixteenby16, sixteen_in_1,sixteen_in_2,sixteenB_in_1,sixteenB_in_2,thirty2_out_1,thirty2_out_2,thirty2_out_3,thirty2_out_4,thirty2_out_5
	
	extern  sixteenby16, sixteen_in_1,sixteen_in_2,sixteenB_in_1,sixteenB_in_2
	extern  eightby24,twenty4_in_1,twenty4_in_2,twenty4_in_3,eight_in
	extern  thirty2_out_1,thirty2_out_2,thirty2_out_3,thirty2_out_4
	extern	ADC_Setup, ADC_Read
	extern  LCD_Setup, LCD_Write_Message, LCD_clear, LCD_2nd_line,LCD_Send_Byte_D,LCD_Write_Hex
	extern delay
	
	extern DAC_setup,DAC_start
	
	
acs1    udata_acs   
k_high	res 1
k_low	res 1
dec_out1 res 1
dec_out2 res 1
dec_out3 res 1
dec_out4 res 1 
final_4_low res 1
final_4_high res 1
	
	code
	org 0x0	
	goto	start3
	
	org 0x100		    ; Main code starts here at address 0x100

	
start3
	call DAC_setup
	goto $
start2 
	call ADC_Setup
	call LCD_Setup
	call LCD_clear
	movlw 0x41
	movwf	k_high
	movlw 0x8A
	movwf	k_low
	
	movlw	0xA
	movwf	eight_in
run_adc
	call LCD_clear
	call ADC_Read
	
	
	
	movff ADRESH,sixteen_in_2
	movff ADRESL,sixteen_in_1
	
	movff k_high, sixteenB_in_2
	movff k_low, sixteenB_in_1
	call sixteenby16
	
	movff thirty2_out_4,final_4_high
	swapf	final_4_high
	movf	final_4_high,w
	
	call load_vals
	
	movf	final_4_high,w
	movf	thirty2_out_4,w
	addwf	final_4_high,f
	movf	final_4_high,w
	
	call load_vals
	
	movff thirty2_out_4,final_4_low
	swapf	final_4_low
	
	call load_vals
	
	movf	thirty2_out_4,w
	addwf	final_4_low,f
	
	
	
	movf	final_4_high,w
	call LCD_Write_Hex
	movf	final_4_low,w
	call LCD_Write_Hex
	
	movlw	0x6D
	call	LCD_Send_Byte_D
	movlw	0x56
	call	LCD_Send_Byte_D
	
	call delay
;	goto $
	bra run_adc
	
	
load_vals
	movff	thirty2_out_3,  twenty4_in_3
	movff	thirty2_out_2,  twenty4_in_2
	movff	thirty2_out_1,  twenty4_in_1
	movlw	0xA
	movwf	eight_in
	call	eightby24
	return
start
	movlw  0x69
	movwf  sixteen_in_1
	
	movlw  0x42
	movwf  sixteen_in_2
	
	movlw  0x45
	movwf  sixteenB_in_1
	
	movlw  0x34
	movwf  sixteenB_in_2
	
	call sixteenby16
	
	movf	thirty2_out_1,w
	movf	thirty2_out_2,w
	movf	thirty2_out_3,w
	movf	thirty2_out_4,w

	
	
	goto start
;start	;setup porte pull ups
;	banksel PADCFG1 ; PADCFG1 is not in Access Bank!!
;	bsf PADCFG1, REPU, BANKED ; PortE pull-ups on
;	movlb 0x00 ; set BSR back to Bank 0
	
;setup1	movlw b'00001111'    ;set low 4 to inputs, high 4 to outputs 
;	movwf TRISE, ACCESS ;on port E
;	movff PORTE, 0x20
;

	
;setup2	swapf 0x20 ,f,a     ;move previous read to high 4 bits
;	movlw b'11110000'    ;set high 4 to inputs, low 4 to outputs 
;	movwf TRISE, ACCESS ;on port E
;	movff PORTE, 0x20
;		
	
;	movlw 0x00
;	movwf	TRISD
;	movff 0x20, PORTD
	
;	
;	goto 	start		    ; Re-run program from start
	
	end
