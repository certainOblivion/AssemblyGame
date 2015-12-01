
PrintPartofBitmap:
        
        
        movem.l      ALL_REG,-(sp)
        ;lea          OUTPUT_WINDOW_OFFSET_X,a4
        ;getting Width of the bitmap. it is stored in little endian mode, so have to shift the bytes to the left and read byte by byte   
        move.l      18(a0),d6
        rol.w       #8,d6
        swap        d6
        rol.w       #8,d6
        
        ;getting height of the bitmap. it is stored in little endian mode, so have to shift the bytes to the left and read byte by byte
        move.l      22(a0),d4
        rol.w       #8,d4
        swap        d4
        rol.w       #8,d4
        
        ;fixing the input width and height in case they exceed the image's dimensions
        ;move.l      16(a0),d0
        ;cmp.l       d0,d6
        ;bgt         MaximumWidthNotCrossed
        ;move.l      d6,16(a0)

MaximumWidthNotCrossed:
        ;move.l      20(a0),d0
        ;cmp.l       d0,d4
        ;bgt         MaximumHeightNotCrossed
        ;move.l      d4,20(a0)
        
MaximumHeightNotCrossed:
        ;getting offset of the bitmap data. it is stored in little endian mode, so have to shift the bytes to the left and read byte by byte
        move.l      10(a0),d0
        rol.w       #8,d0
        swap        d0
        rol.w       #8,d0
        
        adda        d0,a0           ;setting the address register to point to the part in memory that contains the RGB bitmap data
        
        ;move.b      #CLEAR_SCREEN_COMMAND,d0
        ;move.l      #$FF00,d1
        ;TRAP        #15
        
        move.l      d6,d5   ;calculate the number of padding bytes
        and         #3,d5
        
        ;calculate the number of bytes to add to address register to move on to the next row when the current address is pointing to the last byte in the previous row
        move.l      d6,d0
        move.l      16(a4),d3    
        sub.l       d3,d0
        move.l      8(a4),d3
        add.l       d3,d0
        move.l      #3,d1
        mulu        d1,d0
        add.l       d5,d0
        lea         NextRowBitmapDataOffset,a2
        move.l      d0,(a2)
        
        move.l      20(a4),d0
        move.l      8(a4),d1
        
        move.l      d4,d3       ;calculating the offset from the first BGR data to the one that is required
        sub.l       d0,d3       ;that is achieved by the formula : ((height-counter of outer loop)* width of row + startX)*3+padding bytes*(height-counter of outer loop)
        
        move.l      d3,d0
        mulu        d6,d3
        add.l       d1,d3
        move.l      d3,d1
        add.l       d1,d3
        add.l       d1,d3
        
        mulu        d5,d0
        add.l       d0,d3       ;d3 now has the desired offset value
        
        move.l      a0,a3       ;a3 will point to the BGR data that is to be printed on screen; calculate that by adding d3 to a0
        add.l       d3,a3
        
        
        move.l      20(a4),d3  ;this acts as the counter in the outerloop; here the counter goes from the max value to the least

        
OuterLoop:
        move.l      8(a4),d4 ; this acts as the counter in the innerloop; here the counter goes from the least value to the max
        
InnerLoop:
        clr         d1
        
        move.b      (a3)+,d1        ;get the color and set pen color
        swap        d1
        move.b      (a3)+,d1
        rol.w       #8,d1
        move.b      (a3)+,d1
        
        lea         COLOR_TO_NOT_DRAW,a5
        move.l      (a5),d5
        cmp.l       d5,d1
        beq         SkipThisPixel
        
        
        move.l      #PEN_COLOR_TRAP_CODE,d0
        trap        #15
        
        move.l      (a4),d1  ;calculate where to draw pixel and then draw pixel at that very position
        add.l       d4,d1
        move.l      4(a4),d2
        add.l       d3,d2
        move.l      #DRAW_PIXEL_TRAP_CODE,d0
        trap        #15
SkipThisPixel:       
        add.l       #1,d4               ;check whether the inner counter is over;we're calculating from the start to end of x
        move.l      16(a4),d0
        cmp         d4,d0
        bgt         InnerLoop
        
        move.l      (a2),d0
        add.l       d0,a3
        
        subi.l      #1,d3           ;time to check the outerloop. we're calculating from the end to the start of y here, so it was easy to calculate the pixel draw positions
        move.l      12(a4),d0
        cmp         d3,d0
        blt         OuterLoop 
        
        movem.l     (sp)+,ALL_REG
        rts
        
OUTPUT_WINDOW_OFFSET_X              DC.L     0
OUTPUT_WINDOW_OFFSET_Y              DC.L     0
IMAGE_START_OFFSET_X                DC.L     0
IMAGE_START_OFFSET_Y                DC.L     0
IMAGE_END_OFFSET_X                  DC.L     65
IMAGE_END_OFFSET_Y                  DC.L     95
COLOR_TO_NOT_DRAW                   DC.L     $00bb8e03 
NextRowBitmapDataOffset             ds.l     1













*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
