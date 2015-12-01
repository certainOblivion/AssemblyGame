WALKRIGHT1_BITMAP   INCBIN "images\walkright1.bmp"
WALKRIGHT2_BITMAP   INCBIN "images\walkright2.bmp"
WALKRIGHT3_BITMAP   INCBIN "images\walkright3.bmp"
WALKRIGHT4_BITMAP   INCBIN "images\walkright4.bmp"
WALKRIGHT5_BITMAP   INCBIN "images\walkright5.bmp"
WALKRIGHT6_BITMAP   INCBIN "images\walkright6.bmp"
WALKLEFT1_BITMAP    INCBIN "images\walkleft1.bmp"
WALKLEFT2_BITMAP    INCBIN "images\walkleft2.bmp"
WALKLEFT3_BITMAP    INCBIN "images\walkleft3.bmp"
WALKLEFT4_BITMAP    INCBIN "images\walkleft4.bmp"
WALKLEFT5_BITMAP    INCBIN "images\walkleft5.bmp"
WALKLEFT6_BITMAP    INCBIN "images\walkleft6.bmp"
IDLE_BITMAP         INCBIN "images\idle.bmp"
BACKGROUND_BITMAP   INCBIN "images\BackgroundMain.bmp"
LOADING_BITMAP      INCBIN   "images\loadingscreen.bmp"
SUPERMAN_IDLE_RIGHT INCBIN  "images\supermanidleright.bmp"
SUPERMAN_IDLE_LEFT  INCBIN  "images\supermanidleleft.bmp"
SUPERMAN_FLY_DOWN     INCBIN  "images\supermanflydown.bmp" 
SUPERMAN_FLY_UP     INCBIN  "images\supermanflyup.bmp"
LOSE_BITMAP     INCBIN  "images\LoseScreen.bmp"
WIN_BITMAP     INCBIN  "images\WinScreen.bmp"
SetupDrawingMode:
    move.b	    #DRAWING_MODE_TRAP_CODE,d0
    move.b	    #DOUBLE_BUFFERED_MODE,d1
    trap	    #15
    rts
    
    
SetupOutputResolution:
    move.l      #SET_OUTPUT_RESOLUTION_TRAP_CODE,d0
    move.l      #OUTPUT_WIDTH,d1
    swap.w      d1
    move.w      #OUTPUT_HEIGHT,d1
    TRAP        #15
    rts












*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
