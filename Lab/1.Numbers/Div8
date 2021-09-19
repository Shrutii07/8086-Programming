;Full Segment Definition
data segment
    a db 35h
    b db 05h
    quo db ?
    rem db ?
data ends
code segment
assume cs:code,ds:data
    start:
    mov ax,data                          
    mov ds,ax
    mov ah,0h
    mov al,a
    mov bl,b
    div bl
    mov quo,al
    mov rem,ah
code ends
end start



;Simplified Segment Definition
.model small
.data
    num1 db 35h
    num2 db 05h
    quo db ?
    rem db ?
.code
.startup
    mov al,num1
    mov bl,num2
    div bl
    mov quo,al
    mov rem,ah
.exit
end
