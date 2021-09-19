;8 bit mov instruction
mov cl,55h
mov dl,cl
mov bh,dl
mov ah,bh    

;16 bit mov instruction
mov cx,0a234h
mov ax,cx
mov bx,ax
mov dx,bx
mov di,ax
mov si,di
mov ds,di
mov bp,ds
mov bx,5h    

;push  
push bx
push cx

;pop   
pop bx
pop cx

;pusha 
pusha  ;80286 

;popa 
popa   ;80286

;xchg instruction
xchg cl,ch         

;xlat
xlat

;in   
in al,0abh
in ax,dx
mov dx,0800h

;out

;lea
lea bx,ax
lea si,bx

;lds
mov [5000h],1234h
lds bx,[5000h]

;les     
mov [0abcdh],0abcdh   
les bx,[0abcdh]

;lahf
lahf

;sahf 
sahf

;pushf
pushf

;popf  
popf


