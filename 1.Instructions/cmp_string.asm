;loading address of the locations where strings are stored in ds and es
mov ax,5000h
mov ds,ax
mov ax,6000h
mov es,ax
mov si,1000h ;offset of first string
mov di,2000h ;offset of second string
mov ds:si,'on'
mov es:di,'on'
mov cx,05
cld
repe cmpsw