;Full Segment 

data segment
    n1 dw 1835h
    n2 dw 0035h
    Q dw ?
    R dw ?
data ends
code segment
assume cs:code,ds:data
    begin: 
    mov ax,data                          
    mov ds,ax
    mov ax,n1
    
    mov bx,n2
    div bx
    mov Q,ax
    mov R,dx
code ends
end begin


;Simplified Segment
.model small
.data
     num1 dw 1835h
     num2 dw 0035h
     Q dw ?
     R dw ?
 
 
.code  
.startup
    mov ax,num1
    mov bx,num2
    div bx
    mov Q,ax
    mov R,dx
.exit
end
