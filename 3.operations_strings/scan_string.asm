mov ax,5000h ;segment address of the block where string is stored
mov ds,ax
mov di,1000h ;offset address
mov cx,0ffh
mov ax,'hi' ;search for this string
mov ds:di,'hi'
cld
repne scasw