;full segment style is used
;it defines 3 matrices, 2 have data which are added and stored in the 3rd one

data segment    
    matrix1 dw 01h, 02h, 03h
            dw 04h, 05h, 06h
            dw 07h, 08h, 09h    
                   
    matrix2 dw 01h, 02h, 03h
            dw 04h, 05h, 06h
            dw 07h, 08h, 09h 
                       
    result dw 9 dup(?)
    three dw 3     
    six dw 6
data ends
 
 
code segment                

    start:    mov ax, data
              mov ds, ax
    
              mov si,0
              mov ax,0
              mov bx,0
              mov cx,three 
              
    loop1:    mov si,0
              push cx
              mov cx,three
    
    loop2:    mov ax,matrix1[bx][si]
              add ax,matrix2[bx][si]
              mov result[bx][si], ax
              inc si           
              inc si
              loop loop2
    
              add bx,six
              pop cx
              loop loop1
    
code ends 
    end start
