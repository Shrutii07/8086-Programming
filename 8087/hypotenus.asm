; AMIL - Lab-Exam
; To find hypotenuse of a right triangle

.model 
.data

    base dt 3.00
    height dt 4.00
    ans dt ?  
    half dt 0.50
    root1 dt ?
    root2 dt ?
    test1 dt ?
    status dw ?
    
    ; Temporary variables
    temp dd ?
    b2 dt ?
    h2 dt ?
    
    ; Display messages 
    mesb db 13,10,'  Side-1 = $'
    mesh db 13,10,'  Side-2 = $'
    mesa db 13,10,'  Hypotenuse = $'
    mesi db 13,10,'  Lab-Exam: Q- To find hypotenuse of a right triangle $',13,10
    dot db ".$" 
    nwl db 13,10,"$"
    dum db '$'
    mx_100 dt 100.00
    
displayreal macro xx,yy
        fld xx
        scall nwl  
        scall yy
        
        fld mx_100              ;load 100.00
        fmulp st[1],st          ;multiply by 100.00
        fbstp xx                ;convert to bcd
                               
        mov ax,word ptr xx
        call display4digit      ;display ax contents
endm  


scall macro xx       ;macro to display
        lea dx,xx
        mov ah,09h
        int 21h
endm     

.code
    start: 
    mov ax,@data
    mov ds,ax
    
    ;call given
    ;masmcall check_roots_real
    
    finit 
    fld base
    fld base
    fmulp st[1],st
    fld height 
    fld height
    fmulp st[1],st
    faddp st[1],st
    fsqrt
    fstp ans
    
    scall mesi    
    scall nwl
    displayreal base,mesb
    scall nwl
    displayreal height,mesh 
    scall nwl
    displayreal ans,mesa  
    
    mov ah,4ch
    int 21h      
 
    display4digit proc


        mov temp,ax        ;ax has 4 digits to diaplay
        mov dl,ah          ;to display ah first 
        mov ch,02h         ;count of digits
        mov cl,04
        rol dl,cl
        
    loop3:    
        and dl,0fh
        add dl,30h
    
        mov ah,02h
        int 21h
    
        mov ax,temp        ;restore ax
        mov dl,ah
    
        dec ch
        jnz loop3
    
        scall dot          ;display decimal point
    
        mov ax,temp
        mov dl,al          ;to display al
        
        mov ch,02h         ;count of digits
        rol dl,cl        
    
    loop4:             
        and dl,0fh         ;anding to extract last digit
        add dl,30h         ;convert to ascii-hex
    
        mov ah,02h         ;display dl contents
        int 21h
    
        mov ax,temp
        mov dl,al
    
        dec ch
        jnz loop4
    ret
    display4digit endp

end start

