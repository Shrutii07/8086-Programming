;include emu8086.inc
;org 100h
;print 'hello world'
;gotoxy 10,5
;putc 65
;putc 'b'
;ret 
;end   

include 'emu8086.inc'
org    100h

lea    si, msg1       
call   print_string   

lea    di, buffer    
mov    dx, bufsize    
call   get_string    

lea    si, newln      
call   print_string   

ret           

; data
msg1   db "enter your name: ", 0  
newln  db 13, 10
       db "hello, "
buffer db 20 dup (0)     
bufsize = $-buffer   

define_get_string
define_print_string
end                   