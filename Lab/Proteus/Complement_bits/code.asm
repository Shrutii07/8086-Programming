;Calculate the number of one bits in BX and complement an equal number of least significant bits in AX. The data in BX should be taken from the user.
; initialization
assume cs:code, ds:data    
data segment
    porta equ 00H
    portb equ 02H
    portc equ 04H
    cwr   equ 06H
data ends

code segment
    mov ax, data
    mov ds, ax
    org 0000H
    
start:
    ;setting b as input and a as output
    mov al, 82H
    out cwr, al
    mov dl, 00h
    mov dh, 00h
    mov ah, 00h
    l1:
	mov al, 00h
	in al, portb
	mov ah, al
	cmp ah, 00h
	je l1
	mov ch, 00h
	mov cl, 08h
	mov dl, 00h
	loop1:
	shl al, 01h
	jnc loop2
	inc dl
	loop2:
	loop loop1
	

	mov ch, 00h
	mov cl, dl
	mov al, 00h
	
	loop3:
	shl al, 01h
	or al, 01h
	loop loop3
	xor dh, al
	mov al, dh
	out porta, al
	
	mov cl, 0ffh
	delay:
	loop delay
	
	jmp l1 
code ends
end
            
