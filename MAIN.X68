*-----------------------------------------------------------
* Title      :
* Written by :
            
* Date       :
* Description:
*-----------------------------------------------------------
    
            ORG    $1000

            INCLUDE "CONST.X68"
            INCLUDE "SYSCONST.X68"
            ;INCLUDE "LIB/DMMCONST.X68"
            ;INCLUDE "LIB/UTLCONST.X68"
            ;INCLUDE "LIB/DMMCODE.X68"
            INCLUDE "SYSTEM.X68"
            ;INCLUDE "LIB/AGLCODE.X68"
            ;INCLUDE "LIB/UTLCODE.X68"
            INCLUDE "MAP.X68"
            INCLUDE "SCORE.X68"
            INCLUDE "MPC.X68"
            INCLUDE "ENEMY.X68"
           ;INCLUDE "LIB/AGLCODE.X68"
           ;INCLUDE "LIB/DMMCODE.X68"
           ;INCLUDE "LIB/DMMVARS.X68"
           ;INCLUDE "LIB/UTLVARS.X68"
    
    
START

; --- INITIALIZATION -----------------------------------------------------------

            ORI.W   #$0700,SR
            JSR     SYSINIT
            JSR     MAPINIT
            JSR     SCOINIT
            JSR     MPCINIT
            JSR     ENEMINIT


.LOOP

; --- UPDATE -----------------------------------------------------------

; READ INPUT DEVICES

            ;TRAP    #KBDUPTN
    
; UPDATE GAME LOGIC

        
; --- SYNC -----------------------------------------------------------


            
            
; --- PLOT -----------------------------------------------------------
            JSR     SCOPLOT
            JSR     MAPPLOT
            JSR     MPCPLOT
            JSR     ENEMPLOT
            
            
            
    
            
            ;TRAP    #SCRUPTN
            
            BRA     .LOOP



            SIMHALT
    
            INCLUDE "VARS.X68"
            INCLUDE "SYSVARS.X68"
    
            END    START















*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
