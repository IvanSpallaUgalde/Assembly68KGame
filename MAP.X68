; ===========================================================================================
; TITLE    : MAP MANAGEMENT
; AUTHOR   : 
; COMMENTS :
; HISTORY  :
; ==========================================================================================


SETCOLOR    MACRO
            MOVE.L D0,-(A7)
            
            MOVE.B  #81,D0
            TRAP    #15
            CLR.L   D1
            MOVE.B  #80,D0
            TRAP    #15
            
            MOVE.L (A7)+,D0
            ENDM


;-----------------------------------------------------------
MAPINIT
; INITIALIZE THE MAP
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
;-----------------------------------------------------------

    
    RTS


;-----------------------------------------------------------
MAPUPD
; UPDATE THE MAP
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
;-----------------------------------------------------------

    
    RTS


;-----------------------------------------------------------
MAPPLOT
; PLOT MAP
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -------------------------------------------------------------------------------------------

    MOVEM.L D0-D7/A0-A2,-(A7)
    
    LEA     MAP1,A3
    LEA     MAP1,A0
    
    MOVE.L  COLORPOS(A3),A1
    MOVE.L  (A1),D1
    
    SETCOLOR
    
    CLR.W   D1
    CLR.W   D2
    MOVE.W  #SCRHEIGH-1,D3
    MOVE.W  #SCRHEIGH-1,D4
    MOVE.B  #87,D0
    TRAP    #15             ; PAINT THE ENTIRE SCREEN WITH THE BASE COLOR (SAND)
    
    MOVE.W  #15,D6
    
    CLR.L   D4
    
    
.PAINTY
    
    MOVE.W  #15,D5          ; INITI THE X LOOP
    MOVE.L  (A0)+,A1        ; GET THE FIRST ROW
    
    ADD.W   #TILESIZE,D4    ; SETS TILE BOTTOM SIDE
    CLR.L   D3              ; SETS TILE RIGHT SIDE
    ADD.W   #TILESIZE,D3    ; SETS TILE RIGHT SIDE
    
.PAINTX
        
    CLR.L   D0
    MOVE.B  (A1)+,D0
    BEQ     .SKIP           ; SKIPS IF IT IS BACKGROUND COLOR
    LSL.L   #2,D0           
    MOVE.L  COLORPOS(A3),A2
    MOVE.L  (A2,D0),D1
    
    SETCOLOR
    
    ; PAINTING TILES
    
    CLR.L   D1
    CLR.L   D2
    
    MOVE.W  D3,D1           ; MOVE D3 POS TO D1
    MOVE.W  D4,D2           ; MOVE D4 POS TO D2
    
    SUB.W   #TILESIZE,D1    ; SET TILE LEFT SIDE
    SUB.W   #TILESIZE,D2    ; SET TILE UPPER SIDE
    
    MOVE.B  #87,D0
    TRAP    #15
    
    
.SKIP
    
    ADD.W   #TILESIZE,D3    ; SETS NEXT TILE IN ROW
    DBRA    D5,.PAINTX
    DBRA    D6,.PAINTY
    
    RTS
    
    

;--- MAPS -------------------------------------------

MAP1        DC.L MAP100,MAP101,MAP102,MAP103,MAP104,MAP105,MAP106,MAP107,MAP108,MAP109,MAP110
            DC.L MAP112,MAP113,MAP114,MAP115,MAP116,M1COLORS
                    ;SAND    ;BUSH
M1COLORS    DC.L $0054DCFF,$0015AC21

MAP100      DC.B 1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1
MAP101      DC.B 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
MAP102      DC.B 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
MAP103      DC.B 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
MAP104      DC.B 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
MAP105      DC.B 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
MAP106      DC.B 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
MAP107      DC.B 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
MAP108      DC.B 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
MAP109      DC.B 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
MAP110      DC.B 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
MAP111      DC.B 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
MAP112      DC.B 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
MAP113      DC.B 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
MAP114      DC.B 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
MAP115      DC.B 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
MAP116      DC.B 1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1



    



*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
