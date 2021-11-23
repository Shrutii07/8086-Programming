;Write an ALP that can check the input key entered by the user and display
;given message on the screen. If “Y” is pressed by the user, “Hello” should be
;displayed and, if “N” is pressed by the user, “Bye” should be displayed on the
;screen. 

.model small
.data
m1 db "Hello$", 13, 10
m2 db "Bye$", 13, 10
.code
.startup
main:
mov dx, 0
mov ah, 01h
int 21h
cmp al, "y"
jnz skip
mov dx, offset m1
mov ah, 09h
int 21h
jmp fin
skip:
cmp al, "n"
mov dx, offset m2
mov ah, 09h
int 21h
fin:
.exit
end
