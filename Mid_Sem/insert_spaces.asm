; insert spaces


.model small
.data
var1 db "Aditya", 13, 10
res db 11 dup<0>
.code
.startup

lea di, var1
lea bx, res
mov cx, 6
loop:
mov al, [di]
mov [bx], al
inc bx
inc di
mov [bx], 20h
inc bx
dec cx
jnz loop
.exit
end
