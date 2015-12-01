PlayBackgroundMusic:
    movem.l ALL_REG,-(sp)
    lea	SOUNDSTRING,a1 
    move.l #0,d1 
    move.l #0,d2 
    move.l #73,d0 
    TRAP #15 
    movem.l (sp)+,ALL_REG
    rts
*    lea OTHERSOUNDSTRING,a1 
*    move.l #0,d1 
*    move.l #0,d2 
*    move.l #73,d0 
*    TRAP #15 
    STOP #$2000 
SOUNDSTRING dc.b 'audio/score.wav',0 
;OTHERSOUNDSTRING dc.b 'audio/score.wav',0 
    END START

*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
