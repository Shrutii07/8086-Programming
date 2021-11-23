;blink led
assume cs:code,ds:data
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
 mov al, 10000000b; 80h port a as output and port b as input: mode 0
 out dx, al
 jmp l1
l1:
 mov al, 0000h
 mov dx, porta
 out dx,al
 mov cx,0ddddh ;led off time ;efc7h=58823: 1sec delay
l2:loop l2
 mov al, 00ffh
 mov dx, porta
 out dx,al
 mov cx,0ffffh ;led on time ffffh=65535:1.114sec
l3:loop l3
jmp l1

code ends
end
