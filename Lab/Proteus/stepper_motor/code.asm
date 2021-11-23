;stepper motor clockwise rotation
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
 mov al, 10000000b
 out dx, al

 jmp l1
 
l1:  
 mov al, 03h ; at 0 degree
 mov dx, porta
 out dx,al
 mov cx,0df36h; delay 
delay0:loop delay0

 mov al, 0bh  ; at 45 degree
 mov dx, porta
 out dx,al
 mov cx,0df36h; delay 
delay1:loop delay1 

 mov al, 0ah  ;at 90 degree
 mov dx, porta
 out dx,al
 mov cx,0df36h; delay 
delay2:loop delay2

 mov al, 0eh  ; at 135 degree
 mov dx, porta
 out dx,al
 mov cx,0df36h; delay 
delay3:loop delay3

 mov al, 0ch  ; at 180 degree
 mov dx, porta
 out dx,al
 mov cx,0df36h; delay 
delay4:loop delay4

 mov al, 0dh   ;at 225 degree
 mov dx, porta
 out dx,al
 mov cx,0df36h; delay 
delay5:loop delay5

 mov al, 05h  ;at 270 degree
 mov dx, porta
 out dx,al
 mov cx,0df36h; delay 
delay6:loop delay6   

 mov al, 07h  ;at 315 degree
 mov dx, porta
 out dx,al
 mov cx,0df36h; delay 
delay7:loop delay7

 mov al, 03h  ;at 360 degree
 mov dx, porta
 out dx,al
 mov cx,0df36h; delay 
delay8:loop delay8    


jmp l1

jmp start
code ends
end

;table for rotation
;step	a b c d angle valueinhex
;0	0 0 1 1 0	03	
;1	1 0 1 1 45	0b
;2	1 0 1 0 90	0a
;3	1 1 1 0 135	0e
;4	1 1 0 0 180	0c
;5	1 1 0 1 225	0d
;6	0 1 0 1 270	05
;7	0 1 1 1 315	07
;8	0 0 1 1 360	03
