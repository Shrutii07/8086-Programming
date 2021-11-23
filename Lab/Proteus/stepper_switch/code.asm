assume cs:code,ds:data
data segment
porta equ 60h
portb equ 62h
portc equ 64h
cwr equ 66h
data ends

code segment
start:
mov dx,cwr
mov al,82h
out dx,al

l1:
mov dx,portb
in al,dx
mov dx,porta
out dx,al
jmp l1
code ends
end start
