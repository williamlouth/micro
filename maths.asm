#include p18f87k22.inc

    global  eightby16, eight_in, sixteen_in_1,sixteen_in_2,twenty4_out_1,twenty4_out_2,twenty4_out_3
    
acs_ovr access_ovr
eight_in res 1		    ;inputs
sixteen_in_1 res 1
sixteen_in_2 res 1
twenty4_out_1 res 1	    ;outputs
twenty4_out_2 res 1
twenty4_out_3 res 1

L1_1 res 1		    ;line 1 low and high
L1_2 res 1
 
L2_1 res 1		    ;line 2 low and high
L2_2 res 1
   
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
    
    return
    
    
    


    end


