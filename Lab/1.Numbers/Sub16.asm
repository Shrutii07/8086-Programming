;full segment     

data segment 
    n1 dw 1805h
    n2 dw 0035h
    n3 dw ?
data ends

code segment 
    assume cs:code, ds:data
    begin:
    mov ax,data
    mov ds,ax
    mov ax,n1
    mov bx,n2
    sub ax,bx
    mov n3,ax
code ends
end begin


;simplified segment 

.model small
.data
    n1 dw 1805h
    n2 dw 0035h
    n3 dw ?  
    
    
.code
.startup
    mov ax,n1
    mov bx,n2
    sub ax,bx
    mov n3,ax
.exit
End
