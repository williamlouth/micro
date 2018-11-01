#include p18f87k22.inc
    
    global DAC_setup,DAC_start
    extern delay
    
    
    
DAC code
 
DAC_setup
    movlw 0x0
    movwf   TRISD,ACCESS
    
 
DAC_start
    movlw  0x7f
    movwf   PORTD,ACCESS
    call delay
    movlw  0x0
    movwf   PORTD,ACCESS
    call delay
    bra DAC_start
    
    return
    
    
    
    
    
    
    
    
    


end