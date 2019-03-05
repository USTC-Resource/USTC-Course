;author: mbinary
;time:  2018-11-20
;macros: 
;   filesize filename
;   allocate buffer n
;   open  filename,mode  ; todo
;   close handle   
;   fileio handle,mode,n,buffer
;   strlen   s 
;   strcmp   s1,s2
;   sort  begin, isreverse; 
;   print   ; in emu8086.inc


filesize macro filename
    ; 计算文件大小, 结果存于 dx:ax;  目前存在问题
    local filehi,filelo,handle
    filehi dw ?
    filelo dw ?
    handle dw ?
    push cx
    push bx
    
    ;mov ah,42h
    ;mov bx,handle   
    ;mov al,0;从文件起始处开始计算
    ;mov cx,0
    ;mov dx,0
    ;int 21h
    ;mov filehi,dx
    ;mov filelo,ax
    ;将文件指针移动到文件的末尾处，计算偏移量
    
    open filename 'r' handle
    mov ah,42h
    mov bx,handle
    mov al,2
    mov cx,0
    mov dx,0
    int 21h
    ;计算偏移量，获得文件大小
    ;sub dx,filehi
    ;sub ax,filelo 
    close handle
    pop bx
    pop cx
filesize endm

allocate macro buffer n 
    ;暂时抹去高位
    ;动态申请内存 
    push ax
    mov ah,48h
    mov bx,n
    int 21h
    mov buffer,ax 
    pop ax
allocate endm
      
close macro handle 
    local errcls,finish
    push bx
    push ax
    mov bx,handle
    mov ah,3eh
    int 21h    
    jc errcls    
    jmp finish
errcls:
    print "[error]: close file failed"
finish: 
    pop ax
    pop bx
close endm  
         

open macro filename , mode,handle
    ; file handle in ax 
    ; mode  w(rite),  r(ead), a(ppend)
    local w,r,t,a,rw,finish,erropen,errmod
    push dx
    push cx
    mov al, mode
    cmp al,'r'
    je  r
    cmp al,'w'
    je t
    cmp al,'a'
    je w       
    jmp errmod  
r:
    mov al,0
    jmp rw
t:
	mov cx, 0
	lea dx,  filename
	mov ah, 3ch
	int 21h
	jc erropen
    close ax
w:    
    mov al,1
rw:
    lea dx, filename
    mov ah,3dh
    int 21h  
    jc erropen  
    mov handle,ax
    mov al,mode
    cmp al,'a'
    je  a
    jmp finish 
a:
    mov al, 2
    mov cx,0
    mov dx,0
    mov ah,42h
    int 21h   
    jc erropen  
    jmp finish
erropen: 
    print "[error]: open file failed: "
    jmp finish
errmod:       
    print "[error]: unknown mode"
    jmp finish
finish: 
    pop cx
    pop dx
open endm
          
fileio macro handle, mode, n, buffer  
    ; read/write file, bytes count in ax
    local  err, finish,mod_w ,io
    push cx
    push bx       
    push dx
    push ax 
    mov bx,handle
    lea dx,buffer
    
    mov ax,mode
    cmp ax,'w'
    je mod_w
    mov ah,3fh 
    jmp io
mod_w:
    mov ah,40h
io:    
    mov cx,n
    int 21h
    jc err
    jmp finish
err:
    print "[error]: read/write file"
finish:     
    pop ax
    pop dx
    pop bx
    pop cx 
fileio endm

strlen macro s 
    ; get the length of s and store it in cx
    local   l1,finish
    push di   
    mov cx,0
    lea  di,s
l1:
    cmp [di],0
    je finish
    inc cx
    inc di
    jmp l1
finish:    
strlen endm

        
strcmp macro s1,s2 
    ; result in ax: if s1!=s2 then ax=0 else ax=1
    local noteql, finish
    push si
    
    push di
    push cx                     
    lea si,s1           
    lea di,s2   
    strlen s1
    mov ax,cx                  
    strlen s2        
    cmp cx,ax
    jnz noteql
    cld               
    repe cmpsb      
    jnz noteql                                                                
    mov ax,1             
    jmp finish
noteql:   
    mov ax,0
finish:
    pop si
    pop di
    pop cx
strcmp endm   
  



sort macro  begin,reverse 
    ; bubble sort
    ;sort a null terminated string which is from begin
    ;if reverse is 0:  sort from small to big
    ;else           : sort from big to small   
    local   swap,check , count,turn, finish
    push ax
    push bx
    push cx
    lea bx,begin
    dec bx
  count:   
    inc bx
    cmp [bx], 0
    jne count
    
    mov cx,bx
    mov al,reverse
    neg al    ; good job!(￣、￣)  

  turn: 
    lea bx,begin 
    dec cx
    cmp cx,bx
    je finish  
    
  swap:  
    mov dh,[bx+1]
    mov dl, [bx]
    mov ah,dh   
    ;note that sub takes exactly two args, and if you write 'sub ah,dh,dl'
    ;wrongly take that it reprs  a=b-c,     however
    ;the compiler will ignore dl,   without a notice! shit!!!
    sub ah,dl   
    
    xor ah,al
    jns  check
    
    mov [bx+1], dl
    mov [bx],dh  
    
  check: 
    inc bx 
    cmp bx,cx   
    jl swap
    
    jmp turn 
  finish: 
    pop cx
    pop bx
    pop ax
sort endm