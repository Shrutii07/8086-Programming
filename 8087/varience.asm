; AMIL - Lab-Exam
; To find hypotenuse of a right triangle

.model 
.data

    num1 dt 2.0     
    num2 dt 11.0
    num3 dt 12.3
    num4 dt 10.2
    num5 dt 20.33
    
    cnt dt 5.0
    
    mean dt ?	;store mean 
    var dt ?        ;store variance
	store dt ?      

	stdev dt ?	;store stdev
        a dw ?          ;temporary variable
    
    ; Temporary variables
    temp dw ?
    b2 dt ?
    h2 dt ?
    
    ; Display messages 
    msg1 db "Mean = $"
    msg db "Nos. are = "
	msg2 db "Variance = $"
	msg3 db "Standard Deviation= $"
	msg4 db 10d,13d,"$"
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

sdcalc macro zz         ;macro to calculate difference & sqr
        fld zz          ;load passed parameter
	fld  store      ;load mean       
	fsubp st[1],st	;subtract first number from mean
	fmul st,st      ;make square of subtracted resulted
endm

.code
    start: 
    mov ax,@data
    mov ds,ax
    finit
    
    ;call given
    ;masmcall calculate_mean
    
    fld num1
    fld num2
    fld num3
    fld num4
    fld num5

    faddp st[1],st      ;Add ST to specified stack element
     ;& increment Stack pointer by 1
    faddp st[1],st
    faddp st[1],st
    faddp st[1],st


    fld cnt
    fdivp st[1],st       ;calculate mean

    fstp mean	     ;Stores Mean

	fstp store           ;mean's dupicate value in store variable

        sdcalc num1          ;macro call to calculate difference and take square
        sdcalc num2
        sdcalc num3
        sdcalc num4
        sdcalc num5
       
	faddp st[1],st	      ;square's addition
	faddp st[1],st
	faddp st[1],st
	faddp st[1],st
;---------------------------find variance and std deviation------------------------
	fld cnt          ;load count
	fdivp st[1],st   ;to calculate variance divide by cnt

	fld st

	fstp var        ;store variance
	fld var         ;load variance on top of stack

	fsqrt		;to find the square root of variance to get std deviation

	fstp stdev      ;Stores Standard Deviation
    
        
    displayreal mean,msg1   ;macro call
	displayreal var,msg2
	displayreal stdev,msg3
   
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
