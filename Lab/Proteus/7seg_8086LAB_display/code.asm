data segment
    porta equ 60h
    portb equ 62h
    portc equ 64h
    cwr equ 66h
data ends


code segment
    mov ax, data
    mov ds, ax
    
    org 0000h
    
start:
    mov dx, cwr
    mov al, 10000000b
    out dx, al 
    
    mov si, 0
    mov di, 0
    
l0: mov cx, 03fffh 
l1: mov al, s1[si] 
    mov dx, porta 
    out dx, al 
    loop l1 
    
    inc si 
    cmp si,8 
    jl l0

jmp start
   
org 1000h
s1 db 10000000b ;.gfedcba 8
db 11000000b ;0
db 10000000b ;8
db 10000010b ;6
db 11000111b ;L
db 10001000b ;A
db 00000011b ;b
db 01111111b ;blank

code ends
end
