#include p18f87k22.inc

    global  eightby16, eight_in, sixteen_in_1,sixteen_in_2,twenty4_out_1,twenty4_out_2,twenty4_out_3
    
acs_ovr access_ovr
eight_in res 1		    ;inputs
sixteen_in_1 res 1
sixteen_in_2 res 1
 
sixteenB_in_1 res 1
sixteenB_in_2 res 1
 
twenty4_out_1 res 1	    ;outputs  1 = lowest bit
twenty4_out_2 res 1
twenty4_out_3 res 1
 
thirty2_out_1 res 1
thirty2_out_2 res 1
thirty2_out_3 res 1
thirty2_out_4 res 1

L1_1 res 1		    ;line 1 low and high
L1_2 res 1
 
L2_1 res 1		    ;line 2 low and high
L2_2 res 1
 
L3_1 res 1		    ;line 3 low and high
L3_2 res 1
 
L4_1 res 1		    ;line 4 low and high
L4_2 res 1
   
maths    code
    
 

eightby16
    bcf STATUS, C	;clear the carry bit

    
    movf    eight_in,w
    mulwf   sixteen_in_1
    movff   PRODL, L1_1
    movff   PRODH, L1_2
    
    movf    eight_in,w
    mulwf   sixteen_in_2
    movff   PRODL, L2_1
    movff   PRODH, L2_2
    
    movff   L1_1 , twenty4_out_1
    
    movf    L1_2,w
    addwf   L2_1,w
    movwf   twenty4_out_2
    
    movff   L2_2,twenty4_out_3
    movlw   0x00		
    addwfc  twenty4_out_3,f
    
    BTFSC   STATUS, C		;check if carry
    call    carried
    
    return
    
sixteenby16
    movff   sixteenB_in_1,eight_in
    call    eightby16
    
    
    ;bcf STATUS, C	;clear the carry bit
   
    ;movf    sixteenB_in_1,w
    ;mulwf   sixteen_in_1
    ;movff   PRODL, L1_1
    ;movff   PRODH, L1_2
    
    ;movf    sixteenB_in_1,w
    ;mulwf   sixteen_in_2
    ;movff   PRODL, L2_1
    ;movff   PRODH, L2_2
   
    ;movf    sixteenB_in_2,w
    ;mulwf   sixteen_in_1
    ;movff   PRODL, L3_1
    ;movff   PRODH, L3_2
    
    ;movf    sixteenB_in_2,w
    ;mulwf   sixteen_in_2
    ;movff   PRODL, L4_1
    ;movff   PRODH, L4_2
    
    ;movff   L1_1, thirty2_out_1
    ;movf    L1_2,w
    ;addwf   L2_1,w
    
    ;BTFSC   STATUS, C     ;check if we have carry
    ;call    carry_clear
    ;addwf   L3_1,w
    ;movwf   thirty2_out_2
    
    return
    
carry_clear
    incf    L2_2
    bcf STATUS, C
    return
    
    
carried
    return
    
    


    end


