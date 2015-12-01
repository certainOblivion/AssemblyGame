    
GetInput:
    move.l      #KEY_LEFT_INPUT<<24+KEY_RIGHT_INPUT<<16,d1
    move.b      #GET_USER_INPUT_COMMAND,d0
    TRAP        #15
    rts



HandleInput:

    jsr         GetInput
    andi.l      #$FFFFFFFF,d1
    beq         noInput
    
    ;move.b      HAVE_HAD_NO_INPUT,d0
    ;beq         aroundNoInput
    ;move.b      #0,HAVE_HAD_NO_INPUT
    
    cmp.l       #$00FF0000,d1
    beq         RightKeyPressed    
    ;cmp.l       #$0000FF00,d1
    ;beq         UpKeyPressed
    cmp.l       #$FF000000,d1
    beq         LeftKeyPressed
    ;cmp.l       #$000000FF,d1
    ;beq         DownKeyPressed
    
RightKeyPressed: 
    jsr         InValCharacterBackground
    move.l      PLAYER_WINDOW_OFFSET_X,d2
    add.l       PLAYER_END_OFFSET_X,d2
    cmpi.l       #OUTPUT_WIDTH,d2
    bge         PlayerReachedRightLimit
    addi.l       #PlayerWalkSpeed,PLAYER_WINDOW_OFFSET_X   
    jsr         AnimateWalkRight
    jmp         aroundNoInput
PlayerReachedRightLimit:
    jsr         AnimateIdle
    jmp         aroundNoInput
    
LeftKeyPressed:
    jsr         InValCharacterBackground
    move.l      PLAYER_WINDOW_OFFSET_X,d2
    cmpi.l       #0,d2
    ble         PlayerReachedLeftLimit
    subi.l       #PlayerWalkSpeed,PLAYER_WINDOW_OFFSET_X   
    jsr         AnimateWalkLeft
    jmp         aroundNoInput
PlayerReachedLeftLimit:
    jsr         AnimateIdle
    jmp         aroundNoInput
DownKeyPressed:
UpKeyPressed:
    
noInput
        ;move.b  #1,HAVE_HAD_NO_INPUT
        jsr     AnimateIdle
aroundNoInput 
        rts   





*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
