.MODEL SMALL,STDCALL

.DATA
	N DW 0
	TMP DW 1 DUP (0)
    NUMS DW 1024 DUP (0)   
    MSG_ERR DB 0dh,0ah,'THERE ARE SOME ERRORS IN OPERATING THE FILE!','$'  
    MSG_SUCCESS db 0dh,0ah,'SORT RESULT:','$'
    FILEHANDLE DW 0
    FILENAME DB "test2.txt"
    TMPC DB 1 DUP (0)
.CODE   

PRINTC MACRO CHAR;打印字符
    PUSH AX
    PUSH DX 
    MOV AH,2
    MOV DL,CHAR
    INT 21H
    POP DX
    POP AX     
ENDM 

PRINTS MACRO PSTRING ;打印字符串
    PUSH AX
    PUSH DX
    MOV AH,9H
    LEA DX,PSTRING
    INT 21H
    POP DX
    POP AX
ENDM

PRINTN PROC    ;打印一个16位整数,AX
    ;PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    ;----------------
    MOV BX,10
    MOV CX,0
DPUSH:
    MOV DX,0
    DIV BX   ;DX:AX/10,即AX/10 商在AX，余数在DX
    PUSH DX ;余数即最低位，压栈
    INC CX  ;统计位数  
    CMP AX,0
    JZ DPOP  ;商为0，已经是最高位，开始出栈   
    JMP DPUSH    
DPOP:
    POP DX
    ADD DL,30H
    MOV AH,2H            
    INT 21H  ;打印栈顶的位        
    LOOP DPOP
    ;----------------
    POP DX
    POP CX
    POP BX
    ;POP AX
    RET
PRINTN ENDP

FGETN PROC ;从文件读取一个16位整数,结果在AX  
    PUSH BX
    PUSH CX
    PUSH DX    
  
    MOV CX,5 ;数的文本长度，最长5位
    MOV AX,0 ;乘法用的AX,初始化
LOOP1:
	;-------------------READCHAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    MOV AH,3FH
    MOV BX,FILEHANDLE
    MOV CX,1  ;读取长度
    LEA DX,TMPC;用于暂存读取的串
    INT 21H   ;读取后AX存放实际读取出的字符数
    JC R_ERR ;CF=1 出错
    CMP AX,0
    JZ R_QUIT ;AX=0, EOF
	CMP TMPC[0],20H
	JZ R_QUIT ;空格
    POP DX
    POP CX
    POP BX
    POP AX
    ;-------------------
    MOV DX,10 ;DX=10
    MUL DX    ;DX:AX=AX*10 由于读取的是16位无符号整数，最后只会在AX中,DX一直是10 
    SUB TMPC[0],30H ;
    ADD AX,WORD PTR TMPC[0] 
    LOOP LOOP1 
R_QUIT:
    POP DX
    POP CX
    POP BX
    POP AX    
    ;此时AX为读取的数
    JMP R_END
    
R_ERR:
    POP DX
    POP CX
    POP BX
    POP AX
R_END:
    POP DX
    POP CX
    POP BX
	RET
FGETN ENDP

SORT PROC ;冒泡排序
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX    
    
	MOV CX,N 
	DEC CX	;外循环次数为N-1
	SLOOP1:
	PUSH CX  ;把外循环计数器存下来
	;-------------------
		MOV BX,0
		SLOOP2: ;外循环计数器也是内循环次数
		MOV AX,NUMS[BX]
		INC BX
		INC BX
		MOV DX,NUMS[BX]
		CMP AX,DX
		JZ NOEXCHANGE  ;AX=DX 
		JC NOEXCHANGE  ;AX<DX
		EXCHANGE:      ;AX>DX
			MOV NUMS[BX],AX
			DEC BX
			DEC BX
			MOV NUMS[BX],DX
			INC BX
			INC BX
		NOEXCHANGE:
		LOOP SLOOP2
	;-------------------
	POP CX  ;取出外循环计数器
	LOOP SLOOP1
	
    POP DX
    POP CX
    POP BX
    POP AX
	RET
SORT ENDP

.STARTUP
    ;打开文件
    LEA DX,FILENAME ;MOV DX,OFFSET _FILENAME
    MOV AH,3DH 
    MOV AL,2    
    INT 21H
    JC ERROR ;出错
    ;---------
    MOV FILEHANDLE,AX   ;保存句柄
    CALL FGETN ;读取第一个数，表示接下来有几个数据
    MOV N,AX
    CALL PRINTN
	PRINTC 0DH
	PRINTC 0AH
    MOV BX,0
    MOV CX,N
FREAD:
    CALL FGETN
    MOV NUMS[BX],AX
    CALL PRINTN
    PRINTC 20H
    INC BX
    INC BX ;由于是字节，下标每次要加2
 	LOOP FREAD
 	
 	;---------
    CALL SORT
    ;---------
    
	PRINTS MSG_SUCCESS  
    PRINTC 0DH
    PRINTC 0AH
    
    MOV CX,N
    MOV BX,0
PRINTRESULT:
    MOV AX,NUMS[BX]
	CALL PRINTN
	PRINTC 20H
	INC BX
	INC BX
	
	LOOP PRINTRESULT

    JMP TOEND
    ;---------
ERROR:
    PRINTS MSG_ERR
    CALL PRINTN; 打印AX存储的错误码
TOEND:
    MOV	AH, 4CH ;按任意键结束 
	INT	21H

.EXIT 

END


