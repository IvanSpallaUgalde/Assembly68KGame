; ===========================================================================================
; TITLE    : MAP MANAGEMENT
; AUTHOR   : 
; COMMENTS :
; HISTORY  :
; ==========================================================================================


SETCOLOR    MACRO
            MOVE.B  #80,D0
            TRAP    #15
            MOVE.B  #81,D0
            TRAP    #15
            ENDM



;-----------------------------------------------------------
MAPPLOT
; PLOT MAP
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -------------------------------------------------------------------------------------------

    MOVEM.L D0-D7/A0-A2,-(A7)
    
    CLR.L   D0
    CLR.L   D1
    
    LEA     MAP1,A0
    LEA     M1COLORS,A1
    
    MOVE.W  #15,D5
    MOVE.W  #15,D7
    
    CLR.L   D2
    CLR.L   D4
    CLR.L   D6
    
    ADD.W   #16,D4
    
.PAINTY    
    
    CLR.L   D3              ;SETS FIRST TILE OF A ROW
    ADD.W   #16,D3          ;SETS RIGHT X
    CLR.L   D6              ;SETS LEFT X
    
.PAINTX
    
    MOVE.B  (A0)+,D0        ;MOVE TILE TYPE TO D0
    LSL.B   #2,D0           ;2 TIMES D0
    MOVE.L  (A1,D0),D1      ;GET COLOR IN D0 FROM M1COLORS
    
    SETCOLOR    ;SET COLOR MACRO
    
    CLR.L   D1
    MOVE.L  D6,D1           ;LEFT X COORD SAVED ON D6
    
    MOVE.B  #87,D0          ;PAINT RECTANGLE
    TRAP    #15
    
    ADD.W   #16,D3          ;MOVE D3 TO NEXT TILE (RIGHT X)
    ADD.W   #16,D6          ;MOVE D6 TO NEXT TILE (LEFT X)
    
    DBRA    .PAINTX,D5      ;LOOP 16 TIMES (COLUMNS)
    
    ADD.W   #16,D2          ;MOVE UPPER Y 1 ROW DOWN
    ADD.W   #16,D4          ;MOVE LOWER Y 1 ROW DOWN
    
    DBRA    .PAINTY,D7      ;LOOP 16 TIMES (ROWS)
    
    RTS
    
    

;--- MAPS -------------------------------------------

MAP1        DC.L MAP100,MAP101,MAP102,MAP103,MAP104,MAP105,MAP106,MAP107,MAP108,MAP109,MAP110
            DC.L MAP112,MAP113,MAP114,MAP115,M1COLORS
                    ;SAND    ;BUSH
M1COLORS    DC.L $0054DCFF,$0015AC21

MAP100      DC.B 1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1
MAP101      DC.B 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
MAP102      DC.B 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
MAP103      DC.B 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
MAP104      DC.B 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
MAP105      DC.B 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
MAP106      DC.B 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
MAP107      DC.B 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
MAP108      DC.B 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
MAP109      DC.B 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
MAP110      DC.B 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
MAP111      DC.B 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
MAP112      DC.B 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
MAP113      DC.B 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
MAP114      DC.B 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
MAP115      DC.B 1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1
            DS.W 0 



    SIMHALT

    END    START



*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
