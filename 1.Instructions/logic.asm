;not
mov ah,12h
not ah

;and
mov al,11h
and al,23h

;or
or al,ah
mov ax,1234h
or ax,4321h

;xor    
xor al,al
xor ah,11h

;test   
test ax,bx

;shl sal 
mov dh,6
mov cl,4
shl dh,cl 

mov al,-10
sal al,2

;shr sar
mov al,9ah
mov cl,3
shr al,cl

mov al,-10
sar al,1

;rol 
mov al,47h
rol al,3

;ror
mov bx,0c7e5h
mov cl,6
ror bx,cl

;rcr
clc
mov al,26h
mov cl,3
rcr al,cl

;rcl
clc
mov ax,191ch
mov cl,5
rcl ax,cl
