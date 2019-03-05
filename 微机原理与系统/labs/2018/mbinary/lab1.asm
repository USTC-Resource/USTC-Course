;name: 
;author: mbinary
;time: 2018-11    
;function: 
include 'emu8086.inc'

    .model small 
    .stack 100h
    .data
    
num db 36 dup(0)

    .code
    .startup

store:
    mov bx,36
L1: 
    mov num[bx-1],bl
    dec bx
    jnz L1    
    
    mov bx, 0
display: 
    call newline
    mov al,6    ;note that `mul bl`: mov ax, bl*al
    mul bl
    mov si,ax
    inc bx
    cmp bx,6
    jg quit
    mov cx,0
inner:   
    inc cx
    cmp cx,bx
    jg  display
    call printNum 
    inc si
    jmp inner
    
    
;DIV OPRD
; 除数 OPRD 决定是 8 位除法还是 16 位除法

;OPRD=8 位, 则被除数默认在 AX 中, AX 除以 OPRD 的商保存在 AL 中, 余数保存在 AH 中

;OPRD=16 位, 则被除数默认在 DX 与 AX 中, 结果的商保存在 AX 中, 余数保存到 DX 中
               
; printNum  num[si]               
printNum proc    
    push dx
    push ax
    mov ax,0
    mov al,num[si] 
    mov dh,10d
    div dh 
    mov dh,ah

shang:  
    cmp al,0
    je space  
    mov dl,al
    add dl,'0'
    mov ah,2
    int 21h
    jmp yushu 
space:    
    mov dl,' '
    mov ah,2
    int 21h  
yushu:
    mov dl,dh
    add dl,'0'
    int 21h
    mov dl,' '
    int 21h
    pop ax
    pop dx 
    ret
printNum endp

newline proc
    ;row dh   column  dl  bh page number 
    push ax
    push bx
    push dx
    mov bh,0
    mov ah,3
    int 10h
    inc dh 
    mov dl,0  
    mov ah,2 
    int 10h  
    pop dx
    pop bx
    pop ax
    ret
newline endp

   
quit:
    .exit
    end

