;Full segment Definition
assume cs:code ds:data
data segment
s1 db 13,10,'Hello World using INT 21h$',13,10
s2 db 13,10,'Hello World using INT 10h',13,10
data ends
code segment
start:
       
mov dx,offset s1
mov ah,9
int 21h
          
mov ax,@data
mov es,ax        
   
mov bp, offset s2  
mov ah,13h   
mov al,01h
xor bh,bh
mov bl,5
mov cx, 29
mov dh,0
mov dl,0  
int 10h

code ends
end start
