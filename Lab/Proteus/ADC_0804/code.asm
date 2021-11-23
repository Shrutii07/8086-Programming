data segment
porta equ 00h
portb equ 02h
portc equ 04h
cwr equ 06h
data ends
code segment
mov ax,data
mov ds, ax

org 0000h
start:
mov dx, cwr
mov al, 10010000b
out dx, al
mov al,00h  
l1:
mov dx,porta
in al,dx
mov dx, portc
out dx,al
mov dx, portb
mov al, 00000000b
out dx,al

mov cx, 0ffh
d1: 
loop d1
mov dx, portb
mov al, 00000001b
out dx,al
          
mov cx, 0ffh
d2: 
loop d2
jmp l1

code ends
end
