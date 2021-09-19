;Full Segment Definition
data segment
    a db 35h
    b db 02h
    c db ?
data ends
code segment
assume cs:code,ds:data
    start:
    mov ax,data                          
    mov ds,ax
    mov al,a
    mov bl,b
    mul bl
    mov c,al
code ends
end start


;Simplified Segment Definition
.model small
.data
    num1 db 35h
    num2 db 02h
    res db ?
.code
.startup
    mov al,num1
    mov bl,num2
    mul bl
    mov res,al
.exit
end
