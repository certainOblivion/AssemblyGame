PrintBackground:
    lea OUTPUT_WINDOW_OFFSET_X,a4
    
    move.l      #0,WINDOW_OFFSET_X_ADDRESS(a4)
    move.l      #0,WINDOW_OFFSET_Y_ADDRESS(a4)
    move.l      #0,START_OFFSET_X_ADDRESS(a4)
    move.l      #0,START_OFFSET_Y_ADDRESS(a4) 
    move.l      #OUTPUT_WIDTH,END_OFFSET_X_ADDRESS(a4)
    move.l      #OUTPUT_HEIGHT,END_OFFSET_Y_ADDRESS(a4)
    
    lea BACKGROUND_BITMAP,a0
    
    jsr PrintPartofBitmap
*    move.b  #REPAINT_SCREEN_TRAP_CODE,d0
*    TRAP    #15

    rts




DrawLoadingScreen:

    lea OUTPUT_WINDOW_OFFSET_X,a4
    move.l      #$00bb8e03,COLOR_TO_NOT_DRAW   
    move.l      #267,WINDOW_OFFSET_X_ADDRESS(a4)
    move.l      #180,WINDOW_OFFSET_Y_ADDRESS(a4)
    move.l      #0,START_OFFSET_X_ADDRESS(a4)
    move.l      #0,START_OFFSET_Y_ADDRESS(a4) 
    move.l      #300,END_OFFSET_X_ADDRESS(a4)
    move.l      #100,END_OFFSET_Y_ADDRESS(a4)
    
    lea LOADING_BITMAP,a0
    
    jsr PrintPartofBitmap
    move.b  #REPAINT_SCREEN_TRAP_CODE,d0
    TRAP    #15
    rts
    
DrawLoseScreen:

    lea OUTPUT_WINDOW_OFFSET_X,a4
    move.l      #$00bb8e03,COLOR_TO_NOT_DRAW   
    move.l      #267,WINDOW_OFFSET_X_ADDRESS(a4)
    move.l      #180,WINDOW_OFFSET_Y_ADDRESS(a4)
    move.l      #0,START_OFFSET_X_ADDRESS(a4)
    move.l      #0,START_OFFSET_Y_ADDRESS(a4) 
    move.l      #300,END_OFFSET_X_ADDRESS(a4)
    move.l      #100,END_OFFSET_Y_ADDRESS(a4)
    
    lea LOSE_BITMAP,a0
    
    jsr PrintPartofBitmap
    move.b  #REPAINT_SCREEN_TRAP_CODE,d0
    TRAP    #15
    rts

DrawWinScreen:

    lea OUTPUT_WINDOW_OFFSET_X,a4
    move.l      #$00bb8e03,COLOR_TO_NOT_DRAW   
    move.l      #267,WINDOW_OFFSET_X_ADDRESS(a4)
    move.l      #180,WINDOW_OFFSET_Y_ADDRESS(a4)
    move.l      #0,START_OFFSET_X_ADDRESS(a4)
    move.l      #0,START_OFFSET_Y_ADDRESS(a4) 
    move.l      #300,END_OFFSET_X_ADDRESS(a4)
    move.l      #100,END_OFFSET_Y_ADDRESS(a4)
    
    lea WIN_BITMAP,a0
    
    jsr PrintPartofBitmap
    move.b  #REPAINT_SCREEN_TRAP_CODE,d0
    TRAP    #15
    rts    
    
    
    SwitchVideoBuffer:    
        move.b  #REPAINT_SCREEN_TRAP_CODE,d0
      	TRAP    #15
      	rts












*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
