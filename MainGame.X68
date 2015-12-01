ALL_REG                             REG     D0-D7/A0-A6
PEN_COLOR_TRAP_CODE                 EQU     80
DRAW_PIXEL_TRAP_CODE                EQU     82
CLEAR_SCREEN_COMMAND                EQU     11
CLEAR_SCREEN_MAGIC_VAL              EQU     $FF00
SET_OUTPUT_RESOLUTION_TRAP_CODE     EQU     33
OUTPUT_WIDTH                        EQU     800
OUTPUT_HEIGHT                       EQU     600

DRAWING_MODE_TRAP_CODE	            EQU	    92
DOUBLE_BUFFERED_MODE	            EQU	    17
REPAINT_SCREEN_TRAP_CODE	        EQU	    94
WINDOW_OFFSET_X_ADDRESS             EQU     0
WINDOW_OFFSET_Y_ADDRESS             EQU     4
START_OFFSET_X_ADDRESS              EQU     8
START_OFFSET_Y_ADDRESS              EQU     12
END_OFFSET_X_ADDRESS                EQU     16
END_OFFSET_Y_ADDRESS                EQU     20
COLOR_TO_NOT_DRAW_ADDRESS           EQU     24

GET_USER_INPUT_COMMAND              EQU     19
KEY_RIGHT_INPUT                     EQU     $27
KEY_LEFT_INPUT                      EQU     $25
KEY_UP_INPUT                        EQU     $26
KEY_DOWN_INPUT                      EQU     $28

FRAC_BITS                           EQU     1




START   ORG    $1000

    jsr         SetupDrawingMode
    jsr         SetupOutputResolution
    jsr         DrawLoadingScreen
    jsr         PrintBackground
    jsr         GetRandomNumber
    jsr         SetPlayerAndEnemyPosition
    jsr         AnimateIdle
    jsr         SpawnEnemy
    jsr         PlayBackGroundMusic
        
gameloop:   
        jsr     SwitchVideoBuffer
        jsr     CheckForGameOver
        jsr     DrawLEDForEnemy
        jsr     DrawLEDForPlayer
        jsr     HandleInput
        jsr     UpdateEnemy
        bra     gameloop
GameOverWin:
    move.l  #CLEAR_SCREEN_COMMAND,d0
    move.l  #CLEAR_SCREEN_MAGIC_VAL,d1
    trap    #15
    jsr     DrawWinScreen
    jmp     QuitGame
    
GameOverLose:
    move.l  #CLEAR_SCREEN_COMMAND,d0
    move.l  #CLEAR_SCREEN_MAGIC_VAL,d1
    trap    #15
    jsr     DrawLoseScreen
    jmp     QuitGame    
    
QuitGame:
    move.b  $9,d0                   
    TRAP #15
    
CheckForGameOver:

        move.b     PLAYER_LIFE,d0
        beq        GameOverLose
        move.b     ENEMY_LIFE,d0
        beq        GameOverWin
        rts
    
     
    INCLUDE     "CharacterAnimation.x68"
    INCLUDE     "EnemyManager.x68"
    INCLUDE     "LED.x68"
    INCLUDE     "drawBMP.x68"
    INCLUDE     "AssetsAndEnvironment.x68"
    INCLUDE     "PrintBackground.x68"
    INCLUDE     "InputManager.x68"
    INCLUDE     "RandomGenerator.x68"
    INCLUDE     "SoundManager.x68"   
    
    
    
HAVE_HAD_NO_INPUT dc.l    1


    
    END START
    

    
    
























*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
