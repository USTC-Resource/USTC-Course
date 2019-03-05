;name: 
;author: mbinary
;time: 2018-11    
;function: 编程计算任一整数加减运算表达式，
;          表达式长度不超过1024个字节，从键盘输入，可带括号  
;          操作数的范围是8 bits 无符号整数

include 'emu8086.inc'
    .model small 
    .data
    
    stk db 1024 dup(0)

    .code
    .startup
    lea si,stk  
    call readExpr
    dec si
    call calStk 
    printn '' 
    print "result: "
    call print_num 
    jmp quit  
                    
define_print_num                    
DEFINE_PRINT_NUM_UNS  ; unsigned    
calStk proc
    ; si: end(include) of stk 
    ; return ax   
    push bx 
    push cx
    cmp [si],'-'
    je eval
    cmp [si],'+'
    je eval
    xor ah,ah
    mov al,[si]   
    dec si
    jmp calquit
eval:      
    mov cl,[si]    ; op
    dec si
    call calStk  ; second opr
    mov bx,ax    ; second opr in bx
    call calStk  ; first opr in ax
    cmp cl,'+'
    je plus
    sub ax,bx
    jmp calquit
plus:
    add ax,bx 
calquit:  
    pop cx
    pop bx
    ret
calStk endp        
        
        
    
readExpr proc
    ; si: offset stk
    push bx 
    push dx
    xor bx,bx 
    xor dx,dx
read:     
    call getChar
compare:             
    cmp al,13
    je check
    cmp al,')'
    je check
    cmp al,'('    
    je newExpr       
    cmp al,'+'
    je opr  
    cmp al,'-'
    je opr
    cmp al,'0'
    jl unknown  
    cmp al,'9' 
    jg unknown 
    sub al,'0'
    jmp readNum
    
readNum:  ; read num and store it in bl     
    mov cl,al
    mov al,bl
    xor ah,ah 
    mov ch,10
    mul ch
    mov bl,al
    add bl,cl 
    mov dl,1
    call getChar
    jmp compare   
    
opr:     ; latest operator sotred in  bh
    test dl,dl
    jz  noNum
    xor dl,dl          
    mov [si],bl
    inc si   
    xor bl,bl
noNum:    
    test bh,bh
    jz noOpr 
    mov [si],bh
    inc si
noOpr:    
    mov bh,al
    jmp read    
       
newExpr:
    call readExpr
    cmp al,')'
    jne symErr
    test bh,bh
    jz read
    mov [si],bh
    inc si
    xor bx,bx
    jmp read

numErr:   
    printn ''
    print  "[error]: no operand for operator: "
    putc  al
    jmp quit
symErr:      
    printn ''
    print "[error]: unmatched parenthese"
    jmp quit  
oprErr:    
    printn ''
    print "[error]: wrong operator:"
    putc  bl  
    jmp quit
unknown:    
    printn ''
    print "[error]: unknown input: "
    putc al
    jmp quit   

check:
    test dl,dl
    jz  finish
    mov [si],bl
    inc si
    test bh,bh
    jz finish
    mov [si],bh
    inc si
finish: 
    pop dx
    pop bx
    ret
readExpr endp
                     
getChar proc 
    mov ah,1
    int 21h  
    ret
endp 

quit:
    .exit
    end