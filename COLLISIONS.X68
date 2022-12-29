; ===========================================================================================
; TITLE    : COLLISION MANAGEMENT
; AUTHOR   :    
; COMMENTS :
; HISTORY  :
; ===========================================================================================

; -------------------------------------------------------------------------------------------
CHECKCOL
; CHECK IF SOMETHING IS GONNA COLIDE WITH A WALL ON ITS LEFT OR TOP
; INPUT	   - D0.L:= Y1,X1 -->"MENOR"
;		   - D1.L:= Y2,X2 -->"MAJOR"
;		   - D2.L:= YSPEED,XSPEED
; OUTPUT   - D0.L:= NEW_X1,NEW_Y1
; MODIFIES - NONE
; COMMENT  - IF(X1<X2) MENOR; IF(X1==X2 && Y1<Y2)MENOR; ELSE MAJOR;
; -------------------------------------------------------------------------------------------

    MOVEM.L D1-D6/A0,-(A7)
    
    MOVE.L  D2,D4
    MOVE.L  D2,D5
    CLR.L   D3
    LEA     MAP1,A0
    
    
    
.CHECK1     ; GETS THE NEW POSITION OF (Y1,X1)
            ; MODIFIES: D2,D3,A0
            ; SWAPS CONTENT OF (NOT MODIFIED): D0
    
    
    ADD.W   D0,D2
    SWAP    D0
    SAWP    D2
    ADD.W   D0,D2
    
    CMP.W   #0,D2
    
*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
