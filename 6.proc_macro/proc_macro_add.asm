.model small  
;for addition 
.data
num1 dw 1234h
num2 dw 1212h
num3 dw 1212h

.code
.startup  
;add using proc and macro
call proc1 ;call followed by proc name
proc1 proc
    mov ax,num1
    mov bx,num2
    mov cx,num3
    add ax,bx
    add ax,cx 
    ;ret
proc1 endp

macro1 macro num1,num2,num3
    mov ax,num1
    mov bx,num2
    mov cx,num3
    add ax,bx
    add ax,cx
endm  
macro1 1,2,3 ;simply use macro name
macro1 4,5,6

.exit
end 

;proc if used 10 times, it will be called
;from the location where its stored 
;ret will return the control to the main program
;but with macro, it is expanded directly
;in the programs code
;10 times=> storing it 10 times making it bigger 