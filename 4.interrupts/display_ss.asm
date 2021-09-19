;simplified style
.model small
.data
msg1 db "8086!!!$", 13,10 ;$ or 24h at the end
.code
.startup
start:
mov dx,offset msg1  
mov ah,9
int 21h
mov ah,0
int 16h
.exit        