.MODEL SMALL    

.DATA
    D_N DW 4 DUP(0) ;N   (64bit)
    D_N_FAC DW 4 DUP(0) ;N!    (64bit)
    D_TMP DW 4 DUP(0) 
    D_I DW 4 DUP(0) 
    MAP DB "0123456789ABCDEF" 
    Q_TMP DW 0   
    R_TMP DW 0
.CODE

PRINTNEWLINE MACRO _PSTRING ;打印换行符
    PUSH AX
    PUSH DX
    MOV AH,2
    MOV DL,0DH
    INT 21H 
    MOV DL,0AH
    INT 21H
    POP DX
    POP AX
ENDM




PRINTNHEX PROC          ;打印一个64位整数(16进制)
    PUSHA         
    ;---------------- 
    MOV BX,7
    MOV CX,8
PLOOP:
    MOV AL,BYTE PTR D_N_FAC[BX] 
    MOV AH,0
    ;CMP AX,0
    ;JZ PEND:
    MOV DL,10H 
    DIV DL  ;商在AL，余数在AH
    MOV BYTE PTR Q_TMP,AL
    MOV BYTE PTR R_TMP,AH 
    MOV DI,Q_TMP   
    MOV DL,BYTE PTR MAP[DI] 
    MOV AH,2H
    INT 21H  
    MOV DI,R_TMP
    MOV DL,BYTE PTR MAP[DI]
    MOV AH,2H
    INT 21H 
    ;PEND:
    DEC BX             
    LOOP PLOOP       
    ;----------------
    POPA
    RET
ENDP

MOV8 MACRO DATAA,DATAB
    PUSH AX
    MOV AX,DATAB[0]
    MOV DATAA[0],AX
    MOV AX,DATAB[2]
    MOV DATAA[2],AX
    MOV AX,DATAB[4]
    MOV DATAA[4],AX
    MOV AX,DATAB[6]
    MOV DATAA[6],AX 
    POP AX
ENDM

BIGMUL MACRO RES,A,B  
    PUSHA
    ;----------------
    MOV WORD PTR RES[0],0
    MOV WORD PTR RES[2],0
    MOV WORD PTR RES[4],0
    MOV WORD PTR RES[6],0
    MOV CX,4
    MOV BX,0
    LOOP1:
    MOV DI,0
    PUSH CX
    ;------------
        LOOP2:
        MOV AX,B[BX]
        MUL A[DI] ;DX:AX=A[DI]*B[BX]
        MOV SI,BX
        ADD SI,DI ;SI=BX+DI 
        ADD WORD PTR RES[SI],AX
        PUSHF
        CMP SI,6
        JZ AEND
        POPF
        ADC WORD PTR RES[SI+2],DX
        PUSHF  
        CMP SI,4
        JZ AEND
        POPF
        ADC WORD PTR RES[SI+4],0
        PUSHF 
        CMP SI,2
        JZ AEND
        POPF
        ADC WORD PTR RES[SI+6],0  
        JMP AEND2
        AEND:
        POPF
        AEND2:
        ADD DI,2
        LOOP LOOP2  
    ;------------
    POP CX
    ADD BX,2
    LOOP LOOP1
    ;----------------
    POPA 
ENDM 
   

.STARTUP

    MOV WORD PTR D_N[0],19
    MOV CX,WORD PTR D_N[0] ;循环次数
    MOV D_I[0],1 ;当前i
    MOV D_TMP[0],1 ;临时结果
CALC:
    BIGMUL D_N_FAC,D_TMP,D_I
    MOV8 D_TMP,D_N_FAC  
    CALL PRINTNHEX 
    PRINTNEWLINE
    INC D_I[0]  ;I++
    LOOP CALC 

      
.EXIT 

END