
;Full Segment Definition
assume cs:code,ds:data
data segment
string1 db 99,12,56,45,36  ;storing unsorted array
data ends

code segment
start: 
    mov ax,data
    mov ds,ax
    mov ch,04h 
    up2: 
    mov cl,04h 
    lea si,string1 
    up1:
    mov al,[si] 
    mov bl,[si+1] 
    cmp al,bl 
    jc down 
    mov dl,[si+1] 
    xchg [si],dl 
    mov [si+1],dl 
    down: 
    inc si 
    dec cl 
    jnz up1 
    dec ch 
    jnz up2 
code ends
end start

;Simplified Segment Definition
.model small
.data
string1 db 99,12,56,45,36 ;storing unsorted array
.code
.startup
    mov ch,04h 
    up2: 
    mov cl,04h 
    lea si,string1 
    up1:
    mov al,[si] 
    mov bl,[si+1] 
    cmp al,bl 
    jc down 
    mov dl,[si+1] 
    xchg [si],dl 
    mov [si+1],dl 
    down: 
    inc si 
    dec cl 
    jnz up1 
    dec ch 
    jnz up2 
.exit
end
