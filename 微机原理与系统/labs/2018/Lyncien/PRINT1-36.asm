.MODEL SMALL 

.DATA
    D136 DB 36 DUP (0)   
    
.CODE   

PROC PRINT_N ;打印换行符 
    PUSH AX  
    PUSH DX  
    MOV AH,2
    MOV DL,0Dh
    INT 21h  
    MOV DL,0Ah
    INT 21h   
    POP DX 
    POP AX      
    RET
ENDP
PROC PRINTC ;打印DL的字符
    PUSH AX 
    MOV AH,2
    INT 21h
    POP AX     
    RET
ENDP

.STARTUP  
;初始化数据
    MOV CX,36
    MOV BX,36
INIT_LOOP:
    DEC BX
    MOV D136[BX],CL
    LOOP INIT_LOOP
    
    MOV CX,0 
MAIN:
    MOV AL,6 ;AL=6
    MUL CH   ;AL=6*CH
    ADD AL,CL;AL=AL+CL AL为要打印的数的下标
    MOV BX,AX
    MOV AL,D136[BX] ;AL为要打印的数 
    MOV DL,10
    DIV DL ;AL/10,商在AL,余数在AH
    MOV DL,AL ;十位
    ADD DL,30H ;转为字符
    CALL PRINTC
    MOV DL,AH ;个位
    ADD DL,30H ;转为字符
    CALL PRINTC    
    CMP CH,CL
    JZ NEXTLINE ;行结束，进行判断
    MOV DL,32 ;否则打印空格
    CALL PRINTC
    INC CL
    JMP MAIN
    
NEXTLINE:
    CALL PRINT_N
    MOV CL,0 ;列=0
    INC CH   ;行++
    CMP CH,6 ;CH<6则继续下一行 
    JNZ MAIN

.EXIT 

END


