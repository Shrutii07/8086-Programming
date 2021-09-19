;Full Segment 

data segment
    n1 dw 0035h
    n2 dw 0007h
    ans dw ? 
    
data ends
code segment
assume cs:code,ds:data
    begin:
    mov ax,data                          
    mov ds,ax
    mov ax,n1
    mov bx,n2
    mul bx
    mov ans,ax
code ends
end begin



;Simplified Segment 
.model small
.data
    n1 dw 0035h
    n2 dw 0007h
    ans dw ?
    
.code
.startup
    mov ax,n1
    mov bx,n2
    mul bx
    mov ans,ax
.exit
end
