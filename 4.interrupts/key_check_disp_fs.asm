;full segment style
;reads a key from keyboard and displays it
assume cs: code
code segment 
    start: 
    mov ah,6h ;read key from keyboard
    mov dl,0ffh
    int 21h
    je start ;if no key typed keep on checking
    cmp al,'a' ;if typed check with 'a'
    je main1 ;if a then exit else keep on getting key
    mov ah,06h
    mov dl,al
    int 21h
    jmp start
    main1: mov ah,4ch ;exit to dos
    int 21h
code ends
end start