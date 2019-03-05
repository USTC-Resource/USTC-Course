; author: mbinary
; time  : 2018-11-25
; function: factorial


    .model  small
    .data      
    size     equ 20  
    n       equ  19  ; n!
    ans     db  20 dup(0) 

    .code
    .startup    
    mov ans, 1  ; initialize 
    
    
    mov bl,n 
    lea si,ans 
    mov cx,size 
    call factorial

   
    lea si,ans
    mov cx,size 
    call printBigNum
    
    jmp quit 

factorial proc
    ; si : offset  of bigNum    
    ; cx : size 
    ; bl : n!
    push ax
    push dx
    push di  
    
    mov dx,cx
begin: 
    mov al,bl
    mov cx,dx
    mov si,di
    call mulBig
    dec bl  
    test bl,bl
    jnz begin   
    
    pop di
    pop dx
    pop ax   
    ret
factorial endp    
    
        
printBigNum proc
    ; si: offset of arr
    ; cx: size  
    push dx
    push ax                             
    call skipZero        
digit: 
    mov dl,[si]
    dec si  
    add dl,'0' 
    mov ah,2 
    int 21h
    loop digit 
    
    pop ax
    pop dx 
    ret
printBigNum endp       
    
skipZero proc
    ; si : offset arr
    ; cx size 
    ; result in cx , si
    add si,cx
skip:        
    dec si
    cmp [si],0
    loope skip 
    inc cx                
    ret
skipZero endp

mulBig proc
    ; si :offset arr
    ; cx:size
    ; al: x to be multiplied   
    push bx    
    push di
    mov di,si
    call skipZero
    mov si,di
    push cx  
    mov bl,al
times:             
    mov al, bl
    mul [si]
    mov [si], al      
    inc si              
    loop times           
    
    mov si,di
    pop cx
    mov bh,100   
    mov bl,10
carry:     ;carry in 
    xor   ah,ah
    mov   al,[si]   
    div   bh
    add   [si+2], al  ; ษฬ         
    mov   al, ah ; ำเสý
    xor   ah,ah
    div   bl
    add  [si+1],al
    mov  [si],ah 
    inc   si
    loop   carry   
    
    pop di
    pop bx
    ret
mulBig endp

        
quit:
    .exit
    end