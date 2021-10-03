.model small  

.data
  n db 7
  a db 2
  d db 3
.code  
.startup
main:    

mov di, 6500h
mov cl, n
mov ch, 0
mov al, a
AP:
; mov al, ch
mov [di], al
add al, d
inc di
dec cl
jnz AP

end
