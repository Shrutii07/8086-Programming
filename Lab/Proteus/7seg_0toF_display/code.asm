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
    mov al, 10000000b ;80h to set port a as output port
    out dx, al ;sending it to the control register
    
    mov si, 0
    mov di, 0
    
l0: mov cx, 1fffh 
l1: mov al, s1[si]  ;getting out codes for 0-f in al
    mov dx, porta 
    out dx, al ;sending the code out on port a
    loop l1 
    
    inc si ;displaying next 
    cmp si, 16 ;if one is done then re-initializing the count regs
    jl l0

jmp start

;codes for display 0-f    
org 1000h
s1 db 11000000b
   db 11111001b
   db 10100100b
   db 10110000b
   db 10011001b
   db 10010010b
   db 10000010b
   db 11011000b
   db 10000000b
   db 10010000b
   db 10001000b
   db 10000011b
   db 11000110b
   db 10100001b
   db 10000110b
   db 10001110b

code ends
end
