;simplified style .model
;reads a key from keyboard and displays it
.model tiny
.code
.startup
main: mov ah,6h ;read key from keyboard
mov dl,0ffh
int 21h
je main ;if no key typed keep on checking
cmp al,'a' ;if typed check with 'a'
je main1 ;if a then exit else keep on getting key
mov ah,06h
mov dl,al
int 21h
jmp main
main1:
.exit
end