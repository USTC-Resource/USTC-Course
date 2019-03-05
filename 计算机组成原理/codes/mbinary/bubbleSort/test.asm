;name: 
;author: mbinary
;time: 2018-3    
;function: 
include 'emu8086.inc'

org 100h
mov ah,-34
mov al, 1
cmp al ,ah
jg finish
putc ah
xor ah,al
putc  ah
finish:
ret

end