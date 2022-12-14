; ==============================================================================
; SYSTEM
; ==============================================================================

; ------------------------------------------------------------------------------
SYSINIT
; INITIALIZE SYSTEM.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
        MOVE.L #SCRPLOT,($80+SCRUPTN*4)
        MOVE.L #KBDUPD,($80+KBDUPTN*4)
           
        JSR         SCRINIT
        JSR         KBDINIT
   
        MOVE.W      SR,-(A7)
        ANDI.W      #$D8FF,(A7)
        RTE
; ------------------------------------------------------------------------------
SCRINIT
; INIT SCREEN. SET SCREEN RESOLUTION, SET WINDOWED MODE, CLEAR SCREEN,
; ENABLE DOUBLE BUFFER
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

        MOVEM.L      D0-D1,-(A7)
        ; SET SCREEN RESOLUTION
        MOVE.B      #33,D0
        MOVE.L      #SCRWIDTH<<16|SCRHEIGH, D1
        TRAP        #15
        
        ; SET WINDOWED MODE
        MOVE.L      #1,D1
        TRAP        #15
        
        ; CLEAR SCREEN
        MOVE.B      #11,D0
        MOVE.W      #$FF00,D1
        TRAP        #15
        
        ; ENABLE DOUBLE BUFFER
        MOVE.B      #92,D0
        MOVE.B      #17,D1
        TRAP        #15
        
        ; CLEAR HIDDEN BUFFER
        MOVE.W      #$FF00,D1
        MOVE.B      #11,D0
        TRAP        #15
        
        
        MOVEM.L     (A7)+,D0-D1
        
        RTS
        
; ------------------------------------------------------------------------------
SCRPLOT
; UPDATES DOUBLE BUFFER
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

        MOVEM.W     D0-D1,-(A7)
        ; SWITCH BUFFERS
        MOVE.B      #94,D0
        TRAP        #15
        
        ; CLEAR HIDDEN BUFFER
        MOVE.B      #11,D0
        MOVE.W      #$FF00,D1
        TRAP        #15
        MOVEM.W     (A7)+,D0-D1
        
        RTE
        
        
; ------------------------------------------------------------------------------
KBDINIT
; INIT KEYBOARD
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

        CLR.B   (KBDVAL)
        CLR.B   (KBDEDGE)
        RTS
        
        
        
; ------------------------------------------------------------------------------
KBDUPD
; UPDATE KEYBOARD INFO.
; 7 -> D
; 6 -> S
; 5 -> A
; 4 -> W
; 3 -> DOWN
; 2 -> RIGTH
; 1 -> UP
; 0 -> LEFT
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

        MOVEM.L     D0-D3,-(A7)
        
        ; READ FIRST PART
        MOVE.B      #19,D0
        MOVE.L      #KBDD<<24|KBDS<<16|KBDA<<8|KBDW,D1
        TRAP        #15
        
        ; CONVERT TO DESIRED FORMAT
        JSR         .PACK
        
        ; READ SECOND PART
        MOVE.L      #KBDDOWN<<24|KBDRIGHT<<16|KBDUP<<8|KBDLEFT,D1
        TRAP        #15
        
        ; CONVERT TO DESIRED FORMAT
        JSR         .PACK
        
        ; COMPUTE KBDEDGE
        MOVE.B      (KBDVAL),D0
        NOT.B       D0
        AND.B       D2,D0
        MOVE.B      D0,(KBDEDGE)
        
        ; STORE KBDVAL
        MOVE.B      D2,(KBDVAL)
        
        MOVEM.L     (A7)+,D0-D3
        
        RTE

.PACK   MOVE.W      #3,D3
.LOOP   LSL.L       #8,D1
        ROXL.B      #1,D2
        DBRA.W      D3,.LOOP
        RTS






        
        




*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
