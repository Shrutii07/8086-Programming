data segment
 porta equ 60h
 portb equ 62h
 portc equ 64h
 cwr equ 66h
data ends

code segment
 mov ax,data
 mov ds,ax
org 0000h
start:
 mov al,80h; port a as output, port b as input: mode 0
 mov dx,cwr
 out dx,al

 l1:
 mov dx,portb
 in al,dx ;read port b
 mov dx,porta
 out dx,al ;out on port a
 
 jmp l1
code ends
end
