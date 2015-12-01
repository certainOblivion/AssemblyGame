SpawnEnemy:
        movem.l     ALL_REG,-(sp)
        move.l      #$00808000,COLOR_TO_NOT_DRAW
        move.l      ENEMY_STATE,d1
        cmp.l       #1,d1
        beq         LoadEnemyIdleAnimation
        cmp.l       #2,d1
        beq         LoadEnemyFlyDownAnimation
        cmp.l       #3,d1
        beq         LoadEnemyFlyUpAnimation
LoadEnemyFlyDownAnimation:
        lea         SUPERMAN_FLY_DOWN,a0
        move.l      #130,ENEMY_END_OFFSET_Y
        jmp         EnemyAnimationLoaded
LoadEnemyFlyUpAnimation:
        lea         SUPERMAN_FLY_UP,a0
        move.l      #130,ENEMY_END_OFFSET_Y
        jmp         EnemyAnimationLoaded
LoadEnemyIdleAnimation:
        move.l      #95,ENEMY_END_OFFSET_Y        
        move.l      ENEMY_MOVEMENT_DIRECTION,d0
        beq         EnemyLoadLeftIdleAnimation
        lea         SUPERMAN_IDLE_RIGHT, a0
        jmp         EnemyAnimationLoaded
EnemyLoadLeftIdleAnimation:
        lea         SUPERMAN_IDLE_LEFT, a0
EnemyAnimationLoaded:
        lea         ENEMY_WINDOW_OFFSET_X,a4
        jsr         PrintPartofBitmap   ;jump to the subroutine

        movem.l     (sp)+,ALL_REG
        rts
        
UpdateEnemy:
        movem.l     ALL_REG,-(sp)
        jsr         InValEnemyBackground
        move.l      ENEMY_STATE,d1
        cmp.l       #1,d1
        beq         EnemyIdleState
        cmp.l       #2,d1
        beq         EnemyFlyingDown
        cmp.l       #3,d1
        beq         EnemyFlyingUp
EnemyFlyingDown:
        jsr         MakeEnemyAttackPlayer  
        jmp         EnemyUpdateComplete
EnemyFlyingUp: 
        jsr         MakeEnemyFlyBackUp  
        jmp         EnemyUpdateComplete  
EnemyIdleState:        
        jsr         CalcDistBetweenPlayerandEnemy
        move.l      DIST_BETWEEN_PLAYER_AND_ENEMY,d1
        cmp.l       #7,d1
        ble         AttackPlayer
EnemyNotAttackingPlayer:        
        move.l      ENEMY_MOVEMENT_SPEED,d1
        move.l      ENEMY_MOVEMENT_DIRECTION,d0
        beq         EnemyMovesLeft
        move.l      ENEMY_WINDOW_OFFSET_X,d2
        add.l       ENEMY_END_OFFSET_X,d2
        cmp.l       #OUTPUT_WIDTH,d2
        bge         EnemyMovesLeft
        add.l       d1,ENEMY_WINDOW_OFFSET_X 
        jmp         EnemyUpdateComplete
          
EnemyMovesLeft:
        move.l      #0,ENEMY_MOVEMENT_DIRECTION
        move.l      ENEMY_WINDOW_OFFSET_X,d2
        cmp.l       #9,d2
        ble         EnemyMovesRight
        sub.l       d1,ENEMY_WINDOW_OFFSET_X
        jmp         EnemyUpdateComplete
EnemyMovesRight:
        move.l      #1,ENEMY_MOVEMENT_DIRECTION
        jmp         EnemyUpdateComplete
AttackPlayer:
        move.l      #2,ENEMY_STATE
        move.l      #40,ENEMY_PREVIOUS_SPEED
        jsr         MakeEnemyAttackPlayer
EnemyUpdateComplete:  
        jsr         SpawnEnemy           
        movem.l     (sp)+,ALL_REG
        rts

InValEnemyBackground:
        movem.l      ALL_REG,-(sp)
        lea         ENEMY_WINDOW_OFFSET_X,a1
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
        
MakeEnemyAttackPlayer:
        jsr         CalculatePositiveDeltaYForEnemy
        move.l      ENEMY_WINDOW_OFFSET_Y,d2
        add.l       ENEMY_DELTA_Y,d2
        cmp.l       ENEMY_DROP_HEIGHT,d2
        bge         EnemyReachedLowerLimit
        move.l      d2,ENEMY_WINDOW_OFFSET_Y
        rts
EnemyReachedLowerLimit:
        jsr         CalcDistBetweenPlayerandEnemy
        move.l      DIST_BETWEEN_PLAYER_AND_ENEMY,d1
        cmp.l       #37,d1
        ble         PlayerTakeDamage
        subi.b       #1,ENEMY_LIFE
        jmp         DamageCalculated
PlayerTakeDamage:  
        subi.b       #1,PLAYER_LIFE   
DamageCalculated:   
        move.l      #3,ENEMY_STATE  
        rts 

MakeEnemyFlyBackUp:
        jsr         CalculatePositiveDeltaYForEnemy
        move.l      ENEMY_WINDOW_OFFSET_Y,d2
        sub.l       ENEMY_DELTA_Y,d2
        cmp.l       ENEMY_FLY_HEIGHT,d2
        ble         EnemyReachedUpperLimit
        asr.l       #FRAC_BITS,d2
        move.l      d2,ENEMY_WINDOW_OFFSET_Y 
        rts 
EnemyReachedUpperLimit:
        move.l      #1,ENEMY_STATE  
        rts      
        
        
CalculateNegativeDeltaYForEnemy:
        movem.l      ALL_REG,-(sp)
        move.l      ENEMY_PREVIOUS_SPEED,d1
        move.l      d1,d2 ;d2 contains previous speed
        sub.l       ENEMY_ACCELERATION,d1 ;d1 contains current speed
        add.l       d1,d2
        asr         #1,d2
        move.l      d2,ENEMY_DELTA_Y
        move.l      d1,ENEMY_PREVIOUS_SPEED
        movem.l     (sp)+,ALL_REG
        rts
        
        
CalculatePositiveDeltaYForEnemy:
        movem.l      ALL_REG,-(sp)
        move.l      ENEMY_PREVIOUS_SPEED,d1
        move.l      d1,d2 ;d2 contains previous speed
        add.l       ENEMY_ACCELERATION,d1 ;d1 contains current speed
        add.l       d1,d2
        asr         #1,d2
        move.l      d2,ENEMY_DELTA_Y
        move.l      d1,ENEMY_PREVIOUS_SPEED
        movem.l     (sp)+,ALL_REG
        rts
        
        
CalcDistBetweenPlayerandEnemy:
        move.l      ENEMY_WINDOW_OFFSET_X,d1
        move.l      PLAYER_WINDOW_OFFSET_X,d2
        cmp.l       d1,d2
        bgt         PlayerLeftOfEnemy
        sub.l       d2,d1
        move.l      d1,DIST_BETWEEN_PLAYER_AND_ENEMY
        rts
PlayerLeftOfEnemy:
        sub.l       d1,d2
        move.l      d2,DIST_BETWEEN_PLAYER_AND_ENEMY
        rts
      
        

ENEMY_WINDOW_OFFSET_X              dc.l    0
ENEMY_WINDOW_OFFSET_Y              dc.l    100
ENEMY_START_OFFSET_X               dc.l    0
ENEMY_START_OFFSET_Y               dc.l    0
ENEMY_END_OFFSET_X                 dc.l    80
ENEMY_END_OFFSET_Y                 dc.l    95
ENEMY_STATE                        dc.l    1
ENEMY_MOVEMENT_SPEED               dc.l    14
ENEMY_MOVEMENT_DIRECTION           dc.l    1
ENEMY_ACCELERATION                 dc.l    20
ENEMY_PREVIOUS_SPEED               dc.l    0
ENEMY_DELTA_Y                      dc.l    0
ENEMY_FLY_HEIGHT                   dc.l    100
ENEMY_DROP_HEIGHT                  dc.l    430
ENEMY_FLY_DIRECTION                dc.l    1
DIST_BETWEEN_PLAYER_AND_ENEMY      dc.l    1
ENEMY_LIFE                         dc.b    9
WORDALIGNE                          dc.b    0,0,0



























*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
