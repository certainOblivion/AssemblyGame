InValCharacterBackground:
        movem.l      ALL_REG,-(sp)
        lea         PLAYER_WINDOW_OFFSET_X,a1
        lea         OUTPUT_WINDOW_OFFSET_X,a4
        
        

        move.l      WINDOW_OFFSET_X_ADDRESS(a1),d1
        add.l       START_OFFSET_X_ADDRESS(a1),d1
        move.l      d1,START_OFFSET_X_ADDRESS(a4)
        move.l      WINDOW_OFFSET_Y_ADDRESS(a1),d1
        add.l       START_OFFSET_Y_ADDRESS(a1),d1
        move.l      d1,START_OFFSET_Y_ADDRESS(a4)
        move.l      WINDOW_OFFSET_X_ADDRESS(a1),d1
        add.l       END_OFFSET_X_ADDRESS(a1),d1
        move.l      d1,END_OFFSET_X_ADDRESS(a4)
        move.l      WINDOW_OFFSET_Y_ADDRESS(a1),d1
        add.l       END_OFFSET_Y_ADDRESS(a1),d1
        move.l      d1,END_OFFSET_Y_ADDRESS(a4)
        
        lea BACKGROUND_BITMAP,a0
        
        jsr PrintPartofBitmap

        movem.l     (sp)+,ALL_REG
        
        rts
SetPlayerAndEnemyPosition:
    andi.l      #699,RandomNumber
    move.l      RandomNumber,PLAYER_WINDOW_OFFSET_X
    jsr         GetRandomNumber
    andi.l      #299,RandomNumber
    move.l      RandomNumber,ENEMY_WINDOW_OFFSET_X
    rts



AnimateWalkRight: 
        movem.l     ALL_REG,-(sp)   
        move.l      #$00bb8e03,COLOR_TO_NOT_DRAW    
        lea         DelayToDrawNextFrame,a1
        move.l      (a1),d2

        subi.l       #1,d2
        cmp.l       #0,d2
        bne         DrawNextFrame
        addi.l      #1,FrameToDraw
DrawNextFrame:
       	lea         PLAYER_WINDOW_OFFSET_X,a4
        cmp.l       #1,FrameToDraw
        beq         DrawFirstSprite
        cmp.l       #2,FrameToDraw
        beq         DrawSecondSprite
        cmp.l       #3,FrameToDraw
        beq         DrawThirdSprite
        cmp.l       #4,FrameToDraw
        beq         DrawFourthSprite
        cmp.l       #5,FrameToDraw
        beq         DrawFifthSprite
        cmp.l       #6,FrameToDraw
        beq         DrawSixthSprite
        
               
        
DrawFirstSprite: 
       
        lea         WALKRIGHT1_BITMAP, a0
        ;lea         PLAYER_WINDOW_OFFSET_X,a4
        jsr         PrintPartofBitmap   ;jump to the subroutine
        jmp         DoneDrawing

DrawSecondSprite:
      
        lea         WALKRIGHT2_BITMAP, a0
        jsr         PrintPartofBitmap   ;jump to the subroutine
        jmp         DoneDrawing
        
DrawThirdSprite:

        lea         WALKRIGHT3_BITMAP, a0
        jsr         PrintPartofBitmap   ;jump to the subroutine
        jmp         DoneDrawing

DrawFourthSprite:

        lea         WALKRIGHT4_BITMAP, a0
        jsr         PrintPartofBitmap   ;jump to the subroutine
        jmp         DoneDrawing

DrawFifthSprite:

        lea         WALKRIGHT5_BITMAP, a0
        jsr         PrintPartofBitmap   ;jump to the subroutine
        jmp         DoneDrawing

DrawSixthSprite:

        lea         WALKRIGHT6_BITMAP, a0
        jsr         PrintPartofBitmap   ;jump to the subroutine
        jmp         DoneDrawing
        
DoneDrawing:        
        ;add.l       #1,FrameToDraw
        cmp.l       #7,FrameToDraw
        bne         FrameDrawn
        move.l      #1,FrameToDraw
FrameDrawn:       
        cmp.w         #0,d2
        bge           NotEqual
        ;lea         DelayToDrawNextFrame,a2
        move.l      #PlayerAnimateFrameChangeSpeed,d2
NotEqual:
        move.l      d2,DelayToDrawNextFrame
        move.b  #REPAINT_SCREEN_TRAP_CODE,d0
      	TRAP    #15
      	movem.l     (sp)+,ALL_REG
      	rts
        ;jmp         DrawNextFrame

DelayToDrawNextFrame                dc.l    1
FrameToDraw                         dc.l    1

PLAYER_WINDOW_OFFSET_X              dc.l    0
PLAYER_WINDOW_OFFSET_Y              dc.l    450
PLAYER_START_OFFSET_X               dc.l    0
PLAYER_START_OFFSET_Y               dc.l    0
PLAYER_END_OFFSET_X                 dc.l    65
PLAYER_END_OFFSET_Y                 dc.l    95
PLAYER_LIFE                         dc.b    9
WordAlign                           dc.b    0,0,0

PlayerWalkSpeed                     EQU     10
PlayerAnimateFrameChangeSpeed       EQU     1

AnimateIdle:
        movem.l     ALL_REG,-(sp)        
        move.l      #$00bb8e03,COLOR_TO_NOT_DRAW
        jsr         InValCharacterBackground
       
        lea         IDLE_BITMAP, a0
        lea         PLAYER_WINDOW_OFFSET_X,a4
        jsr         PrintPartofBitmap   ;jump to the subroutine
*        move.b      #REPAINT_SCREEN_TRAP_CODE,d0
*      	TRAP        #15
      	movem.l     (sp)+,ALL_REG
        rts


AnimateWalkLeft: 
        movem.l     ALL_REG,-(sp) 
        move.l      #$00bb8e03,COLOR_TO_NOT_DRAW      
        lea         DelayToDrawNextFrame,a1
        move.l      (a1),d2

        subi.l       #1,d2
        cmp.l       #0,d2
        bne         LDrawNextFrame
        addi.l      #1,FrameToDraw
LDrawNextFrame:
       	lea         PLAYER_WINDOW_OFFSET_X,a4
        cmp.l       #1,FrameToDraw
        beq         LDrawFirstSprite
        cmp.l       #2,FrameToDraw
        beq         LDrawSecondSprite
        cmp.l       #3,FrameToDraw
        beq         LDrawThirdSprite
        cmp.l       #4,FrameToDraw
        beq         LDrawFourthSprite
        cmp.l       #5,FrameToDraw
        beq         LDrawFifthSprite
        cmp.l       #6,FrameToDraw
        beq         LDrawSixthSprite
        
               
        
LDrawFirstSprite: 
       
        lea         WALKLEFT1_BITMAP, a0
        ;lea         PLAYER_WINDOW_OFFSET_X,a4
        jsr         PrintPartofBitmap   ;jump to the subroutine
        jmp         LDoneDrawing

LDrawSecondSprite:
      
        lea         WALKLEFT2_BITMAP, a0
        jsr         PrintPartofBitmap   ;jump to the subroutine
        jmp         LDoneDrawing
        
LDrawThirdSprite:

        lea         WALKLEFT3_BITMAP, a0
        jsr         PrintPartofBitmap   ;jump to the subroutine
        jmp         LDoneDrawing

LDrawFourthSprite:

        lea         WALKLEFT4_BITMAP, a0
        jsr         PrintPartofBitmap   ;jump to the subroutine
        jmp         LDoneDrawing

LDrawFifthSprite:

        lea         WALKLEFT5_BITMAP, a0
        jsr         PrintPartofBitmap   ;jump to the subroutine
        jmp         LDoneDrawing

LDrawSixthSprite:

        lea         WALKLEFT6_BITMAP, a0
        jsr         PrintPartofBitmap   ;jump to the subroutine
        jmp         LDoneDrawing
        
LDoneDrawing:        
        ;add.l       #1,FrameToDraw
        cmp.l       #7,FrameToDraw
        bne         LFrameDrawn
        move.l      #1,FrameToDraw
LFrameDrawn:       
        cmp.w         #0,d2
        bge           LNotEqual
        ;lea         DelayToDrawNextFrame,a2
        move.l      #PlayerAnimateFrameChangeSpeed,d2
LNotEqual:
        move.l      d2,DelayToDrawNextFrame
      	movem.l     (sp)+,ALL_REG
      	rts





    






































*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
