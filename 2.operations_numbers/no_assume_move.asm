;moving array of data
;not using assume directive should be avoided
;if only one data/code segment is there it will work
;multiple data segments will require the assume directive 
;(if full segment style is used)
ds segment
    arr1 db 1,2,3,4,5,6,7,8,9,0ah
ds ends                     
cs segment
    start:
    mov ax,ds
    mov ds,ax
    mov ax,6000h
    mov es,ax
    mov si,offset arr1
    mov di,2000h
    mov cx,0ah  
    cld
    rep movsb    
    mov ah,4ch
    int 21h
cs ends
end start