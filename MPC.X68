; ===========================================================================================
; TITLE    : MPC MANAGEMENT
; AUTHOR   : 
; COMMENTS :
; HISTORY  :
; ==========================================================================================


SETMPCCOLOR     MACRO
                MOVE.L D0,-(A7)
            
                MOVE.B  #80,D0
                TRAP    #15
                MOVE.B  #81,D0
                TRAP    #15
            
                MOVE.L (A7)+,D0
                ENDM
            
            
;-----------------------------------------------------------
MPCINIT
; INITIALIZE THE MAIN PLAYABLE CHARACTER
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
;-----------------------------------------------------------

    
    RTS
    
;-----------------------------------------------------------
MPCUPD
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
    BEQ
.
    RTS
    
    
;-----------------------------------------------------------
MPCPLOT
; PLOT MAIN PLAYABLE CHARACTER
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -------------------------------------------------------------------------------------------

    MOVEM.L D0-D7/A0-A3,-(A7)
    
    LEA     MPC,A3
    LEA     MPC,A0
    
    MOVE.L  COLORPOS(A3),A1
    MOVE.L  (A1),D1
    
    SETMPCCOLOR
    
    CLR.L   D1
    CLR.L   D2
    CLR.L   D3
    CLR.L   D4
    CLR.L   D0
    MOVE.W  #MPCLX,D1
    MOVE.W  #MPCUY,D2
    MOVE.W  #MPCRX,D3
    MOVE.W  #MPCLY,D4
    
    MOVE.B  #87,D0
    TRAP    #15

    
    MOVEM.L (A7)+,D0-D7/A0-A3
    RTS
    
    
; --- MPC BITMAP -----------------------------------------------------------------------------

MPC         DC.L MPC00,MPC01,MPC02,MPC03,MPC04,MPC05,MPC06,MPC07,MPC08,MPC09,MPC10
            DC.L MPC11,MPC12,MPC13,MPC14,MPC15,MPCOLOR
            
                    ;0        ;1        ;2        ;3        ;4        ;5   
MPCOLOR     DC.L $00FF0000,$000A022F,$00482BCD,$0091336B,$005EEBFE,$0040E6FF
 
MPC00       DC.B 0,0,0,0,0,1,1,1,0,1,1,0,0,0,0,0
MPC01       DC.B 0,0,0,0,1,2,4,2,1,2,4,1,0,0,0,0
MPC02       DC.B 0,0,1,1,1,2,2,4,4,4,4,1,1,1,0,0
MPC03       DC.B 0,1,2,3,1,2,2,2,2,2,2,1,2,4,1,0
MPC04       DC.B 0,1,1,2,2,1,1,1,1,1,1,2,4,4,1,0
MPC05       DC.B 0,0,1,1,2,4,4,4,4,4,4,4,2,1,0,0
MPC06       DC.B 0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0
MPC07       DC.B 0,0,0,1,1,1,2,1,2,1,2,1,1,0,0,0
MPC08       DC.B 0,0,0,1,1,1,4,1,4,1,4,1,1,0,0,0
MPC09       DC.B 0,0,0,0,1,2,4,4,4,4,4,1,2,1,0,0
MPC10       DC.B 0,0,0,1,2,3,1,1,1,1,3,2,2,2,1,0
MPC11       DC.B 0,0,0,1,2,5,0,0,0,3,1,2,1,4,4,1
MPC12       DC.B 0,0,0,0,1,2,5,2,1,1,2,1,1,2,4,1
MPC13       DC.B 0,0,0,0,1,3,3,1,1,3,3,1,0,1,1,0
MPC14       DC.B 0,0,0,0,0,1,1,0,1,4,4,1,0,0,0,0
MPC15       DC.B 0,0,0,0,0,0,0,0,1,2,2,1,0,0,0,0





    






*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
