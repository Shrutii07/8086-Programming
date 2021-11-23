;simplified segment Definition
.model small
.data
arr1 db 13,4,12,18,23,45,19,15,20,77
 ;array
c db 10
 ;length of array
mean dw 0
 ;number to be found
msg1 db 13,10,'Mean is $',13,10 ;0dh,0ah
msg2 db '.$',13,10

.code
.startup
mov ax, data
mov ds,ax
mov bx,0
mov cl,c
mov di,offset arr1
mov ax,0
loop1:
mov bh,0
mov bl,[di]
add ax,bx
inc di
dec cl
jnz loop1
div c
mov mean,ax    

mov bh, ah
mov ah, 0
mov bl, 10
div bl
mov cl, al
mov ch, ah

mov dx,offset msg1
mov ah,9
int 21h 

mov dl,cl
add dl, 48 
mov ah,2
int 21h

mov dl,ch
add dl, 48 
mov ah,2
int 21h 
       
mov dx,offset msg2
mov ah,9
int 21h

     
mov dl,bh
add dl, 48 
mov ah,2
int 21h
.exit
end




;Full segment Definition
assume cs:code ds:data
data segment
arr1 db 13,4,12,18,23,45,19,15,20,77
 ;array
c db 10
 ;length of array
mean dw 0
 ;number to be found
msg1 db 13,10,'Mean is $',13,10 ;0dh,0ah
msg2 db '.$',13,10
data ends
code segment
start:
mov ax, data
mov ds,ax
mov bx,0
mov cl,c
mov di,offset arr1
mov ax,0
loop1:
mov bh,0
mov bl,[di]
add ax,bx
inc di
dec cl
jnz loop1
div c
mov mean,ax    

mov bh, ah
mov ah, 0
mov bl, 10
div bl
mov cl, al
mov ch, ah

mov dx,offset msg1
mov ah,9
int 21h 

mov dl,cl
add dl, 48 
mov ah,2
int 21h
mov dl,ch
add dl, 48 
mov ah,2
int 21h 
mov dx,offset msg2
mov ah,9
int 21h
mov dl,bh
add dl, 48 
mov ah,2
int 21h

code ends
end start
