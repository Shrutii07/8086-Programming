;coding using simplified segment style
;it simply adds the numbers in the variable array "num" and it is saved in register
                                                  
.model small ;small model is used
 
.data     ;declaring the variables used here
n db 4h
num db 5h,3h,2h,4h  

; code section starts  
.code 
.startup  
    mov cx,00h
    mov cl,n
    mov bx, offset num ;offset address of the stored variable num is moved in bx
addition:   add al,[bx] ;data stored in the memory location given by bx is added to al
            inc bx
            loop addition		              
.exit 
end ; end of the program