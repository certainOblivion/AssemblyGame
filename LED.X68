
FIRST_DIGIT_A_START_X EQU    169
FIRST_DIGIT_A_END_X   EQU    182
FIRST_DIGIT_A_START_Y EQU    8
FIRST_DIGIT_A_END_Y   EQU    8

FIRST_DIGIT_B_START_X EQU    182
FIRST_DIGIT_B_END_X   EQU    182
FIRST_DIGIT_B_START_Y EQU    8
FIRST_DIGIT_B_END_Y   EQU    24

FIRST_DIGIT_C_START_X EQU    182
FIRST_DIGIT_C_END_X   EQU    182
FIRST_DIGIT_C_START_Y EQU    24
FIRST_DIGIT_C_END_Y   EQU    40

FIRST_DIGIT_D_START_X EQU    169
FIRST_DIGIT_D_END_X   EQU    182
FIRST_DIGIT_D_START_Y EQU    40
FIRST_DIGIT_D_END_Y   EQU    40

FIRST_DIGIT_E_START_X EQU    169
FIRST_DIGIT_E_END_X   EQU    169
FIRST_DIGIT_E_START_Y EQU    24
FIRST_DIGIT_E_END_Y   EQU    40

FIRST_DIGIT_F_START_X EQU    169
FIRST_DIGIT_F_END_X   EQU    169
FIRST_DIGIT_F_START_Y EQU    8
FIRST_DIGIT_F_END_Y   EQU    24

FIRST_DIGIT_G_START_X EQU    169
FIRST_DIGIT_G_END_X   EQU    182
FIRST_DIGIT_G_START_Y EQU    24
FIRST_DIGIT_G_END_Y   EQU    24

SECOND_DIGIT_A_START_X EQU    762
SECOND_DIGIT_A_END_X   EQU    775
SECOND_DIGIT_A_START_Y EQU    8
SECOND_DIGIT_A_END_Y   EQU    8

SECOND_DIGIT_B_START_X EQU    775
SECOND_DIGIT_B_END_X   EQU    775
SECOND_DIGIT_B_START_Y EQU    8
SECOND_DIGIT_B_END_Y   EQU    24

SECOND_DIGIT_C_START_X EQU    775
SECOND_DIGIT_C_END_X   EQU    775
SECOND_DIGIT_C_START_Y EQU    24
SECOND_DIGIT_C_END_Y   EQU    40

SECOND_DIGIT_D_START_X EQU    762
SECOND_DIGIT_D_END_X   EQU    775
SECOND_DIGIT_D_START_Y EQU    40
SECOND_DIGIT_D_END_Y   EQU    40

SECOND_DIGIT_E_START_X EQU    762
SECOND_DIGIT_E_END_X   EQU    762
SECOND_DIGIT_E_START_Y EQU    24
SECOND_DIGIT_E_END_Y   EQU    40

SECOND_DIGIT_F_START_X EQU    762
SECOND_DIGIT_F_END_X   EQU    762
SECOND_DIGIT_F_START_Y EQU    8
SECOND_DIGIT_F_END_Y   EQU    24

SECOND_DIGIT_G_START_X EQU    762
SECOND_DIGIT_G_END_X   EQU    775
SECOND_DIGIT_G_START_Y EQU    24
SECOND_DIGIT_G_END_Y   EQU    24


ON_COLOR    EQU    $00FFFFFF
OFF_COLOR   EQU    $00000020

SET_PEN_COLOR_TRAP_CODE EQU 80
DRAW_LINE_TRAP_CODE     EQU 84


DrawLEDForEnemy:
        movem.l     ALL_REG,-(sp)
        lea         digitTable,a1
        lea         bitmaskTable,a2
        move.b      ENEMY_LIFE,d0

CheckSegmentA:
        jsr         TurnSegmentOff
        move.b      (a1,d0),d1
        move.b      0(a2),d2
        and.l       d1,d2
        beq         AStayOff
        jsr         TurnSegmentOn
        
AStayOff:
        jsr         DrawSegmentA
        
CheckSegmentB:
        jsr         TurnSegmentOff
        move.b      (a1,d0),d1
        move.b      1(a2),d2
        and.l       d1,d2
        beq         BStayOff
        jsr         TurnSegmentOn
        
BStayOff:
        jsr         DrawSegmentB
        
CheckSegmentC:
        jsr         TurnSegmentOff
        move.b      (a1,d0),d1
        move.b      2(a2),d2
        and.l       d1,d2
        beq         CStayOff
        jsr         TurnSegmentOn
        
CStayOff:
        jsr         DrawSegmentC
        
CheckSegmentD:
        jsr         TurnSegmentOff
        move.b      (a1,d0),d1
        move.b      3(a2),d2
        and.l       d1,d2
        beq         DStayOff
        jsr         TurnSegmentOn
        
DStayOff:
        jsr         DrawSegmentD
        
        
CheckSegmentE:
        jsr         TurnSegmentOff
        move.b      (a1,d0),d1
        move.b      4(a2),d2
        and.l       d1,d2
        beq         EStayOff
        jsr         TurnSegmentOn
        
EStayOff:
        jsr         DrawSegmentE
        
CheckSegmentF:
        jsr         TurnSegmentOff
        move.b      (a1,d0),d1
        move.b      5(a2),d2
        and.l       d1,d2
        beq         FStayOff
        jsr         TurnSegmentOn
        
FStayOff:
        jsr         DrawSegmentF
        
        
CheckSegmentG:
        jsr         TurnSegmentOff
        move.b      (a1,d0),d1
        move.b      6(a2),d2
        and.l       d1,d2
        beq         GStayOff
        jsr         TurnSegmentOn
        
GStayOff:
        jsr         DrawSegmentG
        movem.l  (sp)+,ALL_REG
        rts
        

digitTable      dc.b        126,48,109,121,51,91,95,112,127,115
bitmaskTable    dc.b        64,32,16,8,4,2,1,0,0,0





DrawSegmentA:
        movem.l  ALL_REG,-(sp)
        move.l  #DRAW_LINE_TRAP_CODE,d0
        move.l  #FIRST_DIGIT_A_START_X,d1
        move.l  #FIRST_DIGIT_A_END_X,d3
        move.l  #FIRST_DIGIT_A_START_Y,d2
        move.l  #FIRST_DIGIT_A_END_Y,d4
        trap    #15
        movem.l  (sp)+,ALL_REG
        rts
        
        
DrawSegmentB:
        movem.l  ALL_REG,-(sp)
        move.l  #DRAW_LINE_TRAP_CODE,d0
        move.l  #FIRST_DIGIT_B_START_X,d1
        move.l  #FIRST_DIGIT_B_END_X,d3
        move.l  #FIRST_DIGIT_B_START_Y,d2
        move.l  #FIRST_DIGIT_B_END_Y,d4
        trap    #15
        movem.l  (sp)+,ALL_REG
        rts

DrawSegmentC:
        movem.l  ALL_REG,-(sp)
        move.l  #DRAW_LINE_TRAP_CODE,d0
        move.l  #FIRST_DIGIT_C_START_X,d1
        move.l  #FIRST_DIGIT_C_END_X,d3
        move.l  #FIRST_DIGIT_C_START_Y,d2
        move.l  #FIRST_DIGIT_C_END_Y,d4
        trap    #15
        movem.l  (sp)+,ALL_REG
        rts

DrawSegmentD:
        movem.l  ALL_REG,-(sp)
        move.l  #DRAW_LINE_TRAP_CODE,d0
        move.l  #FIRST_DIGIT_D_START_X,d1
        move.l  #FIRST_DIGIT_D_END_X,d3
        move.l  #FIRST_DIGIT_D_START_Y,d2
        move.l  #FIRST_DIGIT_D_END_Y,d4
        trap    #15
        movem.l  (sp)+,ALL_REG
        rts

DrawSegmentE:
        movem.l  ALL_REG,-(sp)
        move.l  #DRAW_LINE_TRAP_CODE,d0
        move.l  #FIRST_DIGIT_E_START_X,d1
        move.l  #FIRST_DIGIT_E_END_X,d3
        move.l  #FIRST_DIGIT_E_START_Y,d2
        move.l  #FIRST_DIGIT_E_END_Y,d4
        trap    #15
        movem.l  (sp)+,ALL_REG
        rts

DrawSegmentF:
        movem.l  ALL_REG,-(sp)
        move.l  #DRAW_LINE_TRAP_CODE,d0
        move.l  #FIRST_DIGIT_F_START_X,d1
        move.l  #FIRST_DIGIT_F_END_X,d3
        move.l  #FIRST_DIGIT_F_START_Y,d2
        move.l  #FIRST_DIGIT_F_END_Y,d4
        trap    #15
        movem.l  (sp)+,ALL_REG
        rts

DrawSegmentG:
        movem.l  ALL_REG,-(sp)
        move.l  #DRAW_LINE_TRAP_CODE,d0
        move.l  #FIRST_DIGIT_G_START_X,d1
        move.l  #FIRST_DIGIT_G_END_X,d3
        move.l  #FIRST_DIGIT_G_START_Y,d2
        move.l  #FIRST_DIGIT_G_END_Y,d4
        trap    #15
        movem.l  (sp)+,ALL_REG
        rts
      

TurnSegmentOn:
        movem.l  ALL_REG,-(sp)
        move.l  #SET_PEN_COLOR_TRAP_CODE,d0
        move.l  #ON_COLOR,d1
        trap    #15
        movem.l  (sp)+,ALL_REG
        rts
        
TurnSegmentOff:
        movem.l  ALL_REG,-(sp)
        move.l  #SET_PEN_COLOR_TRAP_CODE,d0
        move.l  #OFF_COLOR,d1
        trap    #15
        movem.l  (sp)+,ALL_REG
        rts
        
        
DrawLEDForPlayer:
        movem.l     ALL_REG,-(sp)
        lea         digitTable,a1
        lea         bitmaskTable,a2
        move.b      PLAYER_LIFE,d0

PCheckSegmentA:
        jsr         TurnSegmentOff
        move.b      (a1,d0),d1
        move.b      0(a2),d2
        and.l       d1,d2
        beq         PAStayOff
        jsr         TurnSegmentOn
        
PAStayOff:
        jsr         PlayerDrawSegmentA
        
PCheckSegmentB:
        jsr         TurnSegmentOff
        move.b      (a1,d0),d1
        move.b      1(a2),d2
        and.l       d1,d2
        beq         PBStayOff
        jsr         TurnSegmentOn
        
PBStayOff:
        jsr         PlayerDrawSegmentB
        
PCheckSegmentC:
        jsr         TurnSegmentOff
        move.b      (a1,d0),d1
        move.b      2(a2),d2
        and.l       d1,d2
        beq         PCStayOff
        jsr         TurnSegmentOn
        
PCStayOff:
        jsr         PlayerDrawSegmentC
        
PCheckSegmentD:
        jsr         TurnSegmentOff
        move.b      (a1,d0),d1
        move.b      3(a2),d2
        and.l       d1,d2
        beq         PDStayOff
        jsr         TurnSegmentOn
        
PDStayOff:
        jsr         PlayerDrawSegmentD
        
        
PCheckSegmentE:
        jsr         TurnSegmentOff
        move.b      (a1,d0),d1
        move.b      4(a2),d2
        and.l       d1,d2
        beq         PEStayOff
        jsr         TurnSegmentOn
        
PEStayOff:
        jsr         PlayerDrawSegmentE
        
PCheckSegmentF:
        jsr         TurnSegmentOff
        move.b      (a1,d0),d1
        move.b      5(a2),d2
        and.l       d1,d2
        beq         PFStayOff
        jsr         TurnSegmentOn
        
PFStayOff:
        jsr         PlayerDrawSegmentF
        
        
PCheckSegmentG:
        jsr         TurnSegmentOff
        move.b      (a1,d0),d1
        move.b      6(a2),d2
        and.l       d1,d2
        beq         PGStayOff
        jsr         TurnSegmentOn
        
PGStayOff:
        jsr         PlayerDrawSegmentG
        movem.l  (sp)+,ALL_REG
        rts
        

PlayerDrawSegmentA:
        movem.l  ALL_REG,-(sp)
        move.l  #DRAW_LINE_TRAP_CODE,d0
        move.l  #SECOND_DIGIT_A_START_X,d1
        move.l  #SECOND_DIGIT_A_END_X,d3
        move.l  #SECOND_DIGIT_A_START_Y,d2
        move.l  #SECOND_DIGIT_A_END_Y,d4
        trap    #15
        movem.l  (sp)+,ALL_REG
        rts
        
        
PlayerDrawSegmentB:
        movem.l  ALL_REG,-(sp)
        move.l  #DRAW_LINE_TRAP_CODE,d0
        move.l  #SECOND_DIGIT_B_START_X,d1
        move.l  #SECOND_DIGIT_B_END_X,d3
        move.l  #SECOND_DIGIT_B_START_Y,d2
        move.l  #SECOND_DIGIT_B_END_Y,d4
        trap    #15
        movem.l  (sp)+,ALL_REG
        rts

PlayerDrawSegmentC:
        movem.l  ALL_REG,-(sp)
        move.l  #DRAW_LINE_TRAP_CODE,d0
        move.l  #SECOND_DIGIT_C_START_X,d1
        move.l  #SECOND_DIGIT_C_END_X,d3
        move.l  #SECOND_DIGIT_C_START_Y,d2
        move.l  #SECOND_DIGIT_C_END_Y,d4
        trap    #15
        movem.l  (sp)+,ALL_REG
        rts

PlayerDrawSegmentD:
        movem.l  ALL_REG,-(sp)
        move.l  #DRAW_LINE_TRAP_CODE,d0
        move.l  #SECOND_DIGIT_D_START_X,d1
        move.l  #SECOND_DIGIT_D_END_X,d3
        move.l  #SECOND_DIGIT_D_START_Y,d2
        move.l  #SECOND_DIGIT_D_END_Y,d4
        trap    #15
        movem.l  (sp)+,ALL_REG
        rts

PlayerDrawSegmentE:
        movem.l  ALL_REG,-(sp)
        move.l  #DRAW_LINE_TRAP_CODE,d0
        move.l  #SECOND_DIGIT_E_START_X,d1
        move.l  #SECOND_DIGIT_E_END_X,d3
        move.l  #SECOND_DIGIT_E_START_Y,d2
        move.l  #SECOND_DIGIT_E_END_Y,d4
        trap    #15
        movem.l  (sp)+,ALL_REG
        rts

PlayerDrawSegmentF:
        movem.l  ALL_REG,-(sp)
        move.l  #DRAW_LINE_TRAP_CODE,d0
        move.l  #SECOND_DIGIT_F_START_X,d1
        move.l  #SECOND_DIGIT_F_END_X,d3
        move.l  #SECOND_DIGIT_F_START_Y,d2
        move.l  #SECOND_DIGIT_F_END_Y,d4
        trap    #15
        movem.l  (sp)+,ALL_REG
        rts

PlayerDrawSegmentG:
        movem.l  ALL_REG,-(sp)
        move.l  #DRAW_LINE_TRAP_CODE,d0
        move.l  #SECOND_DIGIT_G_START_X,d1
        move.l  #SECOND_DIGIT_G_END_X,d3
        move.l  #SECOND_DIGIT_G_START_Y,d2
        move.l  #SECOND_DIGIT_G_END_Y,d4
        trap    #15
        movem.l  (sp)+,ALL_REG
        rts
        
        
        
        







*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
