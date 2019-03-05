;思路
;(1)读一个取输入字符(存在CHARS数组)
;(2)读到'('，记下位置，存在POS_LPAREN数组中，同时记下数量NUM_LPAREN，继续读字符
;(3)读到'='，结束读,转(5)
;(4)如果遇到非法字符，报错，退出
;(5)开始一轮计算，从最右的左括号开始计算
;(6)GET_NUM1
;(7)GET_OP,若是')'或'='完成本轮计算，回填结果到CHARS数组，转(5)
;(8)GET_NUM2
;(9)NUM1 = NUM1 OP NUM2,转(7) 
;计算过程中已算过的部分用'$'填充，以后读取到直接跳过
.MODEL SMALL
    .STACK 100H
    .DATA       
    CHARS DB 1024 DUP(0)   ;输入串
    POS_LPAREN DB  512 DUP(0) ;左括号位置数组
    NUM_LPAREN DB 0            ;左括号数量
    NUM_LPAREN_UNMATCH DB 0            ;未配对的左括号数量
    LENGTH DW 0   ;输入串总长度
    OP DB 0
    CHAR DB 0
    TEMP1 DW 0
    TEMP2 DW 0
    ADDR DW 0    ;记录每次运算中左括号在CHARS的位置，便于存储
    ERRMSG1 DB 0DH,0AH,"ILLEGAL CHAR!!!",'$'
    ERRMSG2 DB 0DH,0AH,"UNMATCHED BRACKET!!!",'$'    
    ERRMSG3 DB 0DH,0AH,"OPERATOR ERROR!!!",'$'
    INPUTFLAG DB 0 ;记录上一个输入字符的类型，1为数字，2为+或-
.CODE
.STARTUP  

;=====================================================================
GETCHAR MACRO  ;获取当前输入字符，存在AL
	MOV	AH, 1
	INT	21H
ENDM

PRINTS MACRO _PSTRING ;打印字符串
    PUSH AX
    PUSH DX
    MOV AH,9H
    LEA DX,_PSTRING
    INT 21H
    POP DX
    POP AX
ENDM

PRINTCHAR MACRO CHAR ;打印一个字符
	PUSH AX
	PUSH DX
	MOV	AH, 2
	MOV DL,CHAR
	INT	21H
	POP DX
	POP AX
ENDM

PRINTNUM MACRO NUM	;打印一个16位整数,AX
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	;----------------  
	MOV AX,NUM
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
	POP AX
PRINTN ENDM

;=====================================================================



    LEA BX,CHARS 
    MOV CX,0 
    LEA DI,POS_LPAREN 
    INC DI    ;POS_LPAREN[0]不存储，从POS_LPAREN[1]开始
GETC:
    GETCHAR
    MOV [BX],AL         ;当前字符存进CHARS数组
    INC BX
     
    CMP AL,3DH
    JE  GETC_END        ;是'=',

    CMP AL,'('
    JNE GETC1           ;不是'(',继续判断
    ;----------
    MOV [DI],CL         ;是'(' 存下当前'('的位置
    INC DI 
    INC NUM_LPAREN      ;'('数量++
    INC NUM_LPAREN_UNMATCH
    MOV INPUTFLAG,0 
    JMP GETC_CONTINUE
    ;---------- 
GETC1:  
    CMP AL,')'
    JNE GETC2           ;不是')',继续判断
    ;----------
    DEC NUM_LPAREN_UNMATCH ;是')',减少未配对的'('数
    MOV INPUTFLAG,0
    JMP GETC_CONTINUE
    ;---------- 
GETC2:
    CMP AL,'+'
    JZ GETC_OP_CHECK
    ;---------------    
    CMP AL,'-'
    JZ GETC_OP_CHECK
    ;---------------
    CMP AL,'0'
    JL ERROR1  ;非法字符
    CMP AL,'9'
    JG ERROR1  ;非法字符
    MOV INPUTFLAG,1 ;记录当前输入字符是数字
    JMP GETC_CONTINUE
GETC_OP_CHECK:
    CMP INPUTFLAG,2 
    JZ ERROR3  ;上一个输入字符是+或-,报错
    MOV INPUTFLAG,2 ;记录当前输入字符是+或-     
GETC_CONTINUE:  
    INC CX
    JMP GETC  
GETC_END: 
    INC CX
    MOV LENGTH,CX
    CMP NUM_LPAREN_UNMATCH,0
    JNZ ERROR2
    JMP CAL_PAREN
;----------------------------------------------------------
CAL_PAREN:  ;从当前最右的'('开始计算
    LEA DI,POS_LPAREN 
    MOV BL,NUM_LPAREN  
    MOV BH,0
    ADD DI,BX     
    MOV AL,[DI]    ;读出ARRAY[num] ;AL=最右的即第NUM_LPAREN个'('的位置
    MOV AH,0
    LEA DI,CHARS
    ADD DI,AX      ;DI加上偏移地址，得到左括号位置，即本轮开始读取的位置 
    MOV ADDR,DI    ;记下该位置，本轮结束后从这开始存结果
    ;-----------
    MOV DH,[DI]
    CMP DH,28H 
    JNE START_CAL  
    MOV DH,24H
    MOV [DI],DH
    INC DI
    JMP START_CAL

;-----------------------------------------------------------    
START_CAL:   
    
    PUSH AX 
    PUSH CX
    PUSH DX 
    MOV AX,0
    MOV CX,0
    MOV DX,0
    
GET_NUM1:
    MOV DH,[DI]    
    CMP DH,24H      ;读到$继续读 
    JE L3
    CMP DH,3DH      ;读到=输出
    MOV TEMP1,AX
    JE PRINTRESULT 
    CMP DH,24H
    JNE L2
L3:
    INC DI
    MOV DH,[DI]
    CMP DH,3DH  ;读到=输出 
    JE PRINTRESULT 
    CMP DH,28H  ;读到（就再读一位
    JE L3
    CMP DH,24H   ;读到$再读一位
    JE L3  
    JNE L2

L2: 
    MOV [DI],24H  ; 将$填入 
    INC DI  
    CMP DH,2DH     
    MOV CHAR,DH    ;每个字符存入CHAR，若为算符就跳入存进OP
    JLE RETU1     ;小于'-'，即不是数字，该整数已完成读取
    ;继续该数的读取           
    SUB DH,30H       ;计算第一个数字TEMP1；就每读一个字符（ASCII)，减去30H ，若下一个字符还是数字，就将这个数字乘10再加上下一个字符，依次进行 
    MOV DL,DH
    MOV DH,0 
    PUSH DX
    MOV CX,10
    MUL CX 
    POP DX
    ADD AX,DX 
    JMP GET_NUM1   
    
RETU1:
    MOV TEMP1,AX    ;存入TEMP1 
    JMP GET_OP 
;-----------------------------------        
GET_OP: 
    MOV DH,CHAR      
    CMP DH,3DH       ;若为=则输出，
    JE PRINTRESULT 
    CMP DH,29H        ;若为）则完成本轮计算 
    JE  FINISH_CAL
    MOV OP,DH   
    MOV AX,0
    JMP GET_NUM2
;-----------------------------------  
JUDGE_OP:         ;读到&就再读一个字符，一定为- 
    INC DI
    MOV DH,[DI]
    INC DI
    CMP DH,OP       ;与读取NUM2前的OP进行比较，+-为负，--为正
    JNE L14 
    MOV DH,28H        ;OP更换为+ 
    MOV OP,DH
    JMP GET_NUM2      
L14:
    MOV OP,DH        ;OP更换为- 
    JMP GET_NUM2
;-----------------------------------      
GET_NUM2: ;类似GET_NUM1，一轮中GET_NUM1后，不断GET_OP GET_NUM2
    MOV DH,[DI] 
    MOV CHAR,DH
    CMP DH,3DH   ;'=' 
    JE RETU2
    CMP DH,26H   ;'&'
    JE JUDGE_OP
    CMP DH,24H   ;'$'
    JNE L4
L5:
    INC DI
    MOV DH,[DI] 
    CMP DH,3DH   ;'='
    JE RETU2  
    CMP DH,28H   ;'('
    JE L5
    CMP DH,24H   ;'$'
    JNE L4
    JE L5
L4:
    MOV [DI],24H ; 将$填入
    INC DI
    CMP DH,2DH   ;'-'
    MOV CHAR,DH 
    JLE RETU2    ;小于'-'，即不是数字，该整数已完成读取
    ;继续该整数的读取，-30H，AX*10再加该位 
    SUB DH,30H
    MOV DL,DH
    MOV DH,0
    MOV CX,10 
    PUSH DX
    MUL CX  
    POP DX
    ADD AX,DX 
    JMP GET_NUM2   
    
RETU2:
    MOV TEMP2,AX
    JMP CAL1
;----------------------------------------------------------    
CAL1:
    CMP OP,2DH ;'-' 
    MOV AX,0
    JE TOSUB
    JNE TOADD      
TOSUB:
    MOV DX,TEMP2
    SUB TEMP1,DX 
    MOV TEMP2,0
    JMP GET_OP  
TOADD:
    MOV DX,TEMP2
    ADD TEMP1,DX
    MOV TEMP2,0 
    JMP GET_OP
;--------------------------------------------------------- 

FINISH_CAL: 
    MOV AX,TEMP1  
    MOV DI,ADDR ;本轮开始读取的位置，从这开始存结果 
    CMP AX,0
    JGE SAVETEMP1   ;TEMP1大于0,直接存 
    ;若TEMP1小于0，则先存入&，再存入- 
    MOV [DI],26H
    INC DI
    MOV [DI],2DH
    INC DI
    ;--------取正TEMP1，用0-TEMP1使其变正
    MOV CX,0 
    SUB CX,AX
    MOV AX,CX

SAVETEMP1:;将（取正后的）TEMP1以字符串存进CHARS数组，
	PUSH BX
	PUSH CX
	PUSH DX
	;----------------  
	MOV BX,10
	MOV CX,0
DPUSH1:
	MOV DX,0
	DIV BX   ;DX:AX/10,即AX/10 商在AX，余数在DX
	PUSH DX ;余数即最低位，压栈
	INC CX  ;统计位数  
	CMP AX,0
	JZ DPOP1  ;商为0，已经是最高位，开始出栈   
	JMP DPUSH1	
DPOP1:
	POP DX
	ADD DL,30H
    MOV [DI],DL
    INC DI	
	LOOP DPOP1
	;----------------
	POP DX
	POP CX
	POP BX
    ;---------------- 
       
    DEC NUM_LPAREN  
    POP DX
    POP CX
    POP AX
   
 
  
;-----------------------------------------------------------     
ENDJUDGE:
    CMP NUM_LPAREN,0
    JGE CAL_PAREN ;'('数量>0，开始新的一轮计算
    JMP PRINTRESULT ;结束，打印

;--------------------------------下面是结果输出 
    
PRINTRESULT:
	MOV AX,TEMP1	
	CMP AX,0 
	JGE POSTIVE  ;大于等于0，直接开始打印
	MOV CX,0 
	SUB CX,AX    
	MOV AX,CX	;小于0，取出正数
	PRINTCHAR 2DH ;打印‘-’
POSTIVE:
	PRINTNUM AX

    JMP CEND


ERROR1:
    PRINTS ERRMSG1
    JMP CEND
ERROR2:
    PRINTS ERRMSG2
    JMP CEND   
ERROR3:
    PRINTS ERRMSG3
    JMP CEND 
CEND:

.EXIT
END









