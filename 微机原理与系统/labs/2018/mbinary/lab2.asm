;name: 
;author: mbinary
;time: 2018-11    
;function: 
include 'emu8086.inc'
include 'mymacro.inc' ; this file should be in .../emu8086/inc/

    .model small 
    .stack 100h
    .data
    ;filename db 256 dup(0)
    filename  db "test.txt",0 
    sortedfile  db "test_sorted.txt",0 
    size dw 10
	handle dw ?
	buffer db 1024 dup(0)

    .code
    .startup                      
    
    DEFINE_PRINT_STRING   ; str in  si    
    open filename 'r'  
    mov handle,ax     
    
    ;filesize handle   
    ;mov size,ax
   
	fileio handle 'r' size buffer
	close handle
	
	print "before sorting: "
	lea si,buffer   
	call print_string
	
	sort buffer, 0
	   
    	                
	open sortedfile 'w'
	mov handle, ax
 
    fileio handle 'w' size buffer
	close handle    
	
	printn ''
	print "after  sorting:"
	call print_string
   
quit:
    .exit
    end
