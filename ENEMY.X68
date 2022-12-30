; ===========================================================================================
; TITLE    : ENEMY MANAGEMENT
; AUTHOR   : 
; COMMENTS :
; HISTORY  :
; ==========================================================================================


SETENEMCOLOR     MACRO
            MOVE.L D0,-(A7)
            
            MOVE.B  #81,D0
            TRAP    #15
            CLR.L   D1
            MOVE.L  #$00FF0000,D1
            MOVE.B  #80,D0
            TRAP    #15
            
            MOVE.L (A7)+,D0
                ENDM
            
            
;-----------------------------------------------------------
ENEMINIT
; INITIALIZE THE MAIN PLAYABLE CHARACTER
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
;-----------------------------------------------------------
   MOVE.W #232,(ENEMPOSX)
   MOVE.W #10,(ENEMPOSY)         
    
    RTS
    
;-----------------------------------------------------------
ENEMUPD
; UPDATE THE MAIN PLAYABLE CHARACTER
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
;-----------------------------------------------------------
    MOVE.W  (MPCPOSX),D1
    MOVE.W  (MPCPOSY),D0
    ;UPDATE CORDINATE
    BTST.B  #4,(KBDVAL)
    BEQ     .CHKDWN
    SUB.W   #MPCSPEED,D0
.CHKDWN
    BTST.B  #6,(KBDVAL)
    BEQ     .CHKLFT
    ADD.W   #MPCSPEED,D0
.CHKLFT       
    BTST.B  #5,(KBDVAL)
    BEQ     .CHKRGT
    SUB.W   #MPCSPEED,D1
.CHKRGT 
    BTST.B  #7,(KBDVAL)
    BEQ     .CHKRGT
    ADD.W   #MPCSPEED,D1
    
    ;COLLISIONS
    CMP.W #0,D0
    BGE .UP
    ADD.W #MPCSPEED,D0
.UP
    CMP.W #0,D1
    BGE .DOWN
    ADD.W #MPCSPEED,D1
.DOWN
    CMP.W #480,D0
    BLE .RIGHT
    SUB.W #MPCSPEED,D0
.RIGHT
    CMP.W #480,D1
    BLE .MAPA
    SUB.W #MPCSPEED,D1
.MAPA
    CLR.L D2
    CLR.L D3
    ;D3->Y,D2->X
    MOVE.W D0,D3
    MOVE.W D1,D2
    DIVU.W #30,D2   ;X/30
    DIVU.W #30,D3   ;Y/30
    MULU.W #4,D3
    LEA MAP1,A6    
    ADD.W D3,A6
    ADD.W D2,A6
    MOVE.W (A6),D3
    CMP.B #0,D3
    RTS
    
    
;-----------------------------------------------------------
ENEMPLOT
; PLOT MAIN PLAYABLE CHARACTER
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -------------------------------------------------------------------------------------------

    MOVEM.L D0-D7/A0-A3,-(A7)
    
    LEA     ENEM,A3
    LEA     ENEM,A0
    
    MOVE.L  COLORPOS(A3),A1
    MOVE.L  (A1),D1
    
    SETENEMCOLOR
    
    CLR.L   D1
    CLR.L   D2
    CLR.L   D3
    CLR.L   D4
    CLR.L   D0
    MOVE.W  (ENEMPOSX),D1
    MOVE.W  (ENEMPOSY),D2
    MOVE.W  (ENEMPOSX),D3
    ADD.W   #ENEMSIZE,D3
    MOVE.W  (ENEMPOSY),D4
    ADD.W   #ENEMSIZE,D4
    MOVE.B  #87,D0
    TRAP    #15

    
    MOVEM.L (A7)+,D0-D7/A0-A3
    RTS
    
    
; --- MPC BITMAP -----------------------------------------------------------------------------

ENEM        DC.L ENEM00,ENEM01,ENEM02,ENEM03,ENEM04,ENEM05,ENEM06,ENEM07,ENEM08,ENEM09,ENEM10
            DC.L ENEM11,ENEM12,ENEM13,ENEM14,ENEM15,ENEMCOLOR
            
                        ;0        ;1        ;2        ;3        ;4        ;5          ;6      ;7
ENEMCOLOR         DC.L $000000FF,$00271765,$004930DA,$0000B386,$0076288B,$0027734D,$00807584,$00EADFEF

ENEM00            DC.B 0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0
ENEM01            DC.B 0,0,0,0,0,1,1,6,7,7,1,1,0,0,0,0
ENEM02            DC.B 0,0,0,0,1,6,7,7,7,7,7,6,1,0,0,0
ENEM03            DC.B 0,0,0,1,6,6,6,7,7,7,6,6,6,1,0,0
ENEM04            DC.B 0,0,0,1,1,6,6,6,6,6,6,6,1,1,0,0
ENEM05            DC.B 0,0,0,1,6,1,1,1,1,1,1,1,6,1,0,0
ENEM06            DC.B 0,0,0,1,1,6,7,7,7,7,7,6,1,1,0,0
ENEM07            DC.B 0,0,0,1,5,1,1,1,5,1,1,1,5,1,0,0
ENEM08            DC.B 0,0,0,1,5,3,2,5,3,5,2,3,5,1,0,0
ENEM09            DC.B 0,0,1,4,1,5,3,3,3,3,3,5,1,4,1,0
ENEM10            DC.B 0,1,2,2,2,1,1,5,5,5,1,1,2,2,2,1
ENEM11            DC.B 0,1,2,1,2,2,4,1,1,1,4,2,1,3,3,1
ENEM12            DC.B 0,1,3,3,1,4,2,2,2,2,2,4,1,5,3,1
ENEM13            DC.B 0,1,3,5,1,6,6,4,1,4,6,6,6,1,1,0
ENEM14            DC.B 0,0,1,1,0,1,1,1,0,1,6,7,7,1,0,0
ENEM15            DC.B 0,0,0,0,0,0,0,0,0,1,5,3,5,1,0,0





    







*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
