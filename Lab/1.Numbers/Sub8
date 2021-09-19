;Full Segment Definition
data segment
    a db 35h
    b db 05h
    c db ?
data ends
code segment
assume cs:code,ds:data
    start:
    mov ax,data                          
    mov ds,ax
    mov al,a
    mov bl,b
    sub al,bl
    mov c,al
code ends
end start


;Simplified Segment Definition
.model small
.data
    num1 db 35h
    num2 db 05h
    res db ?
.code
.startup
    mov al,num1
    mov bl,num2
    sub al,bl
    mov res,al
.exit
end
