;8 bit add instruction
mov al,24h
mov dl,11h
add al,dl
mov ch,24h
mov bl,11h
add ch,bl     

;16 bit add instruction 
mov ax,1abh
mov dx,111h
add dx,ax

;flags affected
mov al,0f5h
add al,0bh

;adc
adc ax,200h
adc ax,bx  

;inc
inc ax
inc bx

;aaa
mov al,0ah
aaa

;daa  
mov al, 29h
add al,53h
daa

;sub
mov al,3fh
mov bh,23h
sub al,bh

;sbb
sbb al,1h

;dec
dec al
dec bl

;npg
neg al

;cmp 
cmp bx,bx
cmp bx,200h
cmp bx,0bbbbh

;aas
mov al,0ah 
aas

;das  
mov al,75h
mov bl,46h
sub al,bl
das

;mul
mul bh

;imul 
imul bh

;aam 
mov al,4h
mov bl,9h
mul bl
aam

;div
mov al,95  
sub ah,ah  
mov bl,10
div bl

mov ax,10050
sub dx,dx 
mov bx,100
div bx

;operation on signed numbers
mov dl,-128
mov ch,-2
add dl,ch

mov al,-2
mov cl,-5
add cl,al

;cbw and cwd
mov al,96
cbw
mov al,-2
cbw     

mov ax,260
cwd
mov ax,-32766
cwd