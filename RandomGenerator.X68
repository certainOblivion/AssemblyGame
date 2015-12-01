LARGE_NUMBER            equ     $5678
LARGE_NUMBER1           equ     $1234

GET_TIME_COMMAND        equ     8

GetRandomNumber:
        movem.l ALL_REG,-(sp)
        move.b  #GET_TIME_COMMAND,d0
        TRAP    #15
        move.b  d1,d2
        eor.l   #$AA,d2
        lsl.l   #8,d1
        move.b  d2,d1
        
        move.l  d1,RANDOMVAL
        jsr     seedRandomNumber
        jsr     getRandomByteIntoD6
        jsr     getRandomByteIntoD6
        jsr     getRandomByteIntoD6
        jsr     getRandomByteIntoD6
        jsr     getRandomByteIntoD6
        jsr     getRandomByteIntoD6
        
        move.l  d6,RandomNumber
        movem.l (sp)+,ALL_REG
        ;move.b  #9,d0
        ;TRAP    #15
        rts
        
seedRandomNumber
        movem.l ALL_REG,-(sp)
        clr.l   d6
        move.b  #GET_TIME_COMMAND,d0
        TRAP    #15
        move.l  d1,d6
        mulu    #LARGE_NUMBER,d6
        move.l  d6,RANDOMVAL
        movem.l (sp)+,ALL_REG
        rts

getRandomLongIntoD6
        movem.l d0,-(sp)
        movem.l d1,-(sp)
        move.l  RANDOMVAL,d6
        mulu    #LARGE_NUMBER,d6
        move.l  #31,d0
        TRAP    #15
        mulu    d1,d6
        bcs     nocarry
        add.l   #1,d6
nocarry
        move.l  d6,RANDOMVAL
        movem.l (sp)+,d1
        movem.l (sp)+,d0
        rts


getRandomByteIntoD6
        movem.l ALL_REG,-(sp)
        jsr     getRandomLongIntoD6
        move.b  #GET_TIME_COMMAND,d0
        TRAP    #15
        andi    #7,d1
        lsr     d1,d6
        move.l  d6,TEMPRANDOMLONG
        movem.l (sp)+,ALL_REG
        move.l  TEMPRANDOMLONG,d6
        rts
    


RANDOMVAL       ds.l    1
TEMPRANDOMLONG  ds.l    1
RandomNumber    ds.l    1

      


*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
