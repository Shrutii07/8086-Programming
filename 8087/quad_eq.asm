
; AMI - Assignment
; To solve quadratic equation

.model 
.data
    ; v Edit the values of the coef. below. v
    coef_a dd 1.0
    coef_b dd -2.0
    coef_c dd -3.0
    zer0 db 0
    
    a db 1
    b db -2
    c db -3
    tp db ?
    ; ^ Edit the values of the above coefficients
    ;------------------------
    
    root_d dd ?
    recipr_2a dd ?
    root1 dt ?
    root2 dt ?
    test1 dt ?
    status dw ?
    
    ; Temporary variables
    temp dd ?
    ac   dd ?
    four_ac dd ?
    b2   dd ?
    b2minus4ac dd ?
\end{minted}
\end{tcolorbox}
\begin{tcolorbox}
\begin{minted}{asm}     
    ; Display messages
    mes00 db 13,10,'  Real Roots of this Equation do exist!$',10,13 
    mesr1 db 13,10,'  Root-1 = $'
    mesr2 db 13,10,'  Root-2 = $'
    
    mesr1n db 13,10,'  Root-1 = -$'
    mesr2n db 13,10,'  Root-2 = -$'
    mest2 db 13,10,'  * Test * = $'
    intro db 13,10,' Given equation is ax^2 + bx + c = 0 .$',10,13
    mesa db 13,10,'  Coef. of x^2 (a)  = $'
    mesan db 13,10,'  Coef. of x^2 (a)  = -$'
    mesb db 13,10,'  Coef. of x (b)    = $'
    mesbn db 13,10,'  Coef. of x (b)    = -$'
    mesc db 13,10,'  Constant term (c) = $'
    mescn db 13,10,'  Constant term (c) = -$'
    msg_cr db 13,10,'  Real roots do not exist. Roots are complex. $'
    dot db ".$" 
    nwl db 13,10,"$"
    dum db '$'
    mx_100 dt 100.00
    four db 4
    
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
\end{minted}
\end{tcolorbox}
\begin{tcolorbox}
\begin{minted}{asm} 
.code
    start: 
    mov ax,@data
    mov ds,ax
    
    ;call given
    call check_roots_real
    
    finit 
    fld coef_a
    fld coef_c
    fmulp st[1],st
    fstp ac     
    fld ac
    fld ac
    fld ac
    fld ac
    faddp st[1],st
    faddp st[1],st
    faddp st[1],st
    fstp four_ac
    
    fld coef_b
    fld coef_b
    fmulp st[1],st
    fstp b2
    
    fld four_ac
    fld b2
    fsub st,st[1]
    fstp b2minus4ac
    
    fld b2minus4ac  
    fsqrt
    fstp root_d
    fld coef_a
    fld coef_a
    faddp st[1],st
    fld1
    fdiv st,st[1] 
    fstp recipr_2a
    fld recipr_2a
    fstp test1
\end{minted}
\end{tcolorbox}
\begin{tcolorbox}
\begin{minted}{asm}     
    ;Caluculating root-1
    fld coef_b
    fld root_d
    fsubrp st[1],st
    fld recipr_2a
    fmulp st[1],st
    fstp root1
                                    
                                    
    ;Calculating root-2
    fld coef_b
    fld root_d
    fchs
    fsubrp st[1],st
    fld recipr_2a
    fmulp st[1],st
    fstp root2    
    
    ; Comparing the roots
    fld root1
    fabs
    fld root2 
    fabs
    fsub st[1],st
    ftst 
    fstsw status
    mov ax,status
    and ah,01h
    cmp ah,1
    jz here
    call dp_1
    
    
    here:
    call dp_2
    
    given proc 
        scall intro, 09h 
        fldz
        fld coef_a 
        fcom
\end{minted}
\end{tcolorbox}
\begin{tcolorbox}
\begin{minted}{asm} 
        jnb n_a
        displayreal coef_a, mesan
        jmp c_a
        n_a:
        displayreal coef_a, mesa
        c_a:
        
        scall nwl, 09h  
        fldz
        fld coef_b 
        fcom
        jnb n_b
        displayreal coef_b, mesbn
        jmp c_b
        n_b:
        displayreal coef_b, mesb
        c_b:
        
        scall nwl, 09h
        fldz
        fld coef_c 
        fcom
        jnb n_c
        displayreal coef_c, mescn
        jmp c_c
        n_c:
        displayreal coef_c, mesc
        c_c: 
        
        scall nwl, 09h
    given endp
    
    
    dp_1 proc
    scall mes00, 09h
        fldz
        fld root1
        ftst 
        fstsw status
        mov ax,status
        and ah,01h
        cmp ah,1
\end{minted}
\end{tcolorbox}
\begin{tcolorbox}
\begin{minted}{asm} 
        jnz n_r1
        displayreal root1,mesr1n
        jmp c_r1
        n_r1:
        displayreal root1, mesr1
        c_r1:
        
        scall nwl, 09h  
        fldz
        fld root2 
        ftst 
        fstsw status
        mov ax,status
        and ah,01h
        cmp ah,1
        jnz n_r2
        displayreal root2, mesr2n
        jmp c_r2
        n_r2:
        displayreal root2, mesr2
        c_r2:
        
        mov ah,4ch
        int 21h   
    dp_1 endp
    
    dp_2 proc
        scall mes00, 09h
        fldz
        fld root1
        ftst 
        fstsw status
        mov ax,status
        and ah,01h
        cmp ah,1
        jnz n_r11
        displayreal root1,mesr1
        jmp c_r11
        n_r11:
        displayreal root1, mesr1n
        c_r11:
\end{minted}
\end{tcolorbox}
\begin{tcolorbox}
\begin{minted}{asm}         
        scall nwl, 09h  
        fldz
        fld root2 
        ftst 
        fstsw status
        mov ax,status
        and ah,01h
        cmp ah,1
        jnz n_r22
        displayreal root2, mesr2
        jmp c_r22
        n_r22:
        displayreal root2, mesr2n
        c_r22:
        
        mov ah,4ch
        int 21h    
        
    dp_2 endp    
    
    
    check_roots_real proc
        mov ax,b
        mul b
        mov bx,ax
        mov ax,a
        mul c
        add ax,ax
        add ax,ax
        
        cmp bx,ax
        jb cr
        ret
        
        cr:
        scall msg_cr
        mov ah,4ch
        int 21h
        
    check_roots_real endp
    
\end{minted}
\end{tcolorbox}
\begin{tcolorbox}
\begin{minted}{asm}     
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

