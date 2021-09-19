;Full Segment Definition
data segment
num1 dw 0035h
num2 dw 1805h
num3 dw ?
data ends

code segment
assume cs:code,ds:data
start:
mov ax,data
mov ds,ax
mov ax,num1
mov bx,num2
add ax,bx
mov num3,ax
code ends
end start


;simplified segment 

.model small
.data
    num1 dw 0035h
    num2 dw 1805h
    num3 dw ?  
    
    
.code
.startup
    mov ax,num1
    mov bx,num2
    add ax,bx
    mov num3,ax
.exit
end
