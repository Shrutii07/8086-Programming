;here no special data or code segment is defined
;Check if number is Odd or Even
;if odd then bx=1 else bx=0
read:
    mov ax,16
start:
    mov bx,ax
    and bx,0001h
    cmp bx,0001h
    je odd
    jmp even
odd:
    hlt
even:
    hlt