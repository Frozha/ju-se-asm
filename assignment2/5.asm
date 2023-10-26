.model small
.stack 100h
.data
    uin dw 0
    msg1 db 'enter 16-bit number : $'
    msg2 db '[overflow] number too large'
    newl db 13,10,'$'       
    msg4 db 'is not palindrome$'
    msg3 db 'is palindrome$'
.code
    main proc 
        mov ax, @data
        mov ds, ax
        
        mov si, 0
        mov dx, offset msg1
        mov ah, 09h
        int 21h
        mov bx, 10
        uinput:
            mov ah, 01h
            int 21h
            cmp al, 13
            je palindr
            sub al, '0'
            mov dl, al
            mov dh, 0
            push dx
            mov ax, uin
            mul bx
            jc ovrflw
            pop cx
            add ax, cx
            jc ovrflw
            inc si
            mov uin, ax
        jmp uinput
    ovrflw:   
    mov dx, offset newl
    mov ah, 09h
    int 21h
    mov dx, offset msg2
    int 21h
    jmp trmin
    
    palindr:
        mov ax, si
        mov bh, 0 
        mov bl, 2
        div bx
        mov di, dx
        mov dx, 0
        mov ch,0
        mov cl, al
        mov si, cx
        mov ax, uin
        mov bx, 10
        cmp cx, 0
        je pali
        loop1:
            div bx
            push dx
            mov dx, 0
        loop loop1
        mov cx, si
        cmp di, 0
        je cmploop
        div bx 
        mov dx, 0
        cmploop:
            div bx
            pop di
            cmp di, dx
            jne notpali
            mov dx, 0
        loop cmploop
        pali:
        mov dx, offset newl
        mov ah,09h
        int 21h
        mov dx, offset msg3
        int 21h
        jmp trmin
        
        notpali:
            mov dx, offset newl
            mov ah,09h
            int 21h
            mov dx, offset msg4
            int 21h   
         
             
    trmin:        
    mov ah, 4ch
    int 21h
    main endp
end main