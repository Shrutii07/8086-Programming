mov ax,5000h 
mov ds,ax
mov ax,6000h
mov es,ax
mov cx,10 
mov si,1000h ;ds:si=5000:1000
mov di,2000h ;es:di=6000:2000
mov ds:si,'he'
mov ds:si+2,'ha'
cld ;clear direction flag (special flag for strings)
rep movsb ;moving from si to di