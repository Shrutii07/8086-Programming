.model small  
;for display
.data
msg1 db 13,10,'hello there from proc$',13,10
msg2 db 13,10,'hello there from macro$',13,10

.code
.startup  

;display msg using proc and macro
call proc2
proc2 proc
    mov dx,offset msg1
    mov ah,9
    int 21h
proc2 endp

macro2 macro msg1
    mov dx,offset msg2
    mov ah,9
    int 21h
endm
macro2 msg2
macro2 msg2

.exit
end 

;proc if used 10 times, it will be called
;from the location where its stored 
;ret will return the control to the main program
;but with macro, it is expanded directly
;in the programs code
;10 times=> storing it 10 times making it bigger 