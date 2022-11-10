*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    
            ORG    $1000

            INCLUDE "CONST.X68"
            INCLUDE "SYSCONST.X68"
            INCLUDE "SYSTEM.X68"
            INCLUDE "SYSVARS.X68"
    
    
START

; --- INITIALIZATION -----------------------------------------------------------

            ORI.W   #$0700,SR
            JSR     SYSINIT


.LOOP

; --- UPDATE -----------------------------------------------------------

; READ INPUT DEVICES

            TRAP    #KBDUPTN
    
; UPDATE GAME LOGIC

        
; --- SYNC -----------------------------------------------------------

.WINT       TST.B   (SCRINTCT)
            BEQ     .WINT
            CLR.B   (SCRINTCT)
            
            
; --- PLOT -----------------------------------------------------------
   
           TRAP     #SCRUPTN
           
           BRA      .LOOP



            SIMHALT
    
            INCLUDE "VARS.X68"
            INCLUDE "SYSVARS.X68"
    
            END    START

*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
