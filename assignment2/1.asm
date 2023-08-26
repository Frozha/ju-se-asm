tostr macro number, string
    mov si, offset string
    mov bh, cl;storing outer loop cx
    mov cl, 10
    mov ch, 1
    mov bl, 0
    modnumb:
        xor ax,ax
        mov al, number
        div cl
        mov dl, ah
        xor ax,ax
        mov al, dl
        div ch
        cmp ah, dl
        je unloadstack:
        add al, 48
        xor ah, ah
        push ax
        mov ch, cl
        mov al, cl
        mul ten
        mov cl, al
        inc bl
        jmp modnumb
    unloadstack:
        xor cx,cx
        mov cl, bl
        loop1:
            pop dx
            mov [si], dx
            inc si
        loop loop1
    xor cx,cx
    mov cl, bh
endm    
.model small
.stack 100h
.data
    ten db 10
    numofitr db 5
    currnum db ?
    strng db 10 dup("$")
.code
    main proc
        mov ax, @data
        mov ds, ax

        mov dx, 1
        push dx
        mov dx, 0
        push dx
        mov dx, 49
        mov ah, 02h
        int 21h
        xor cx,cx
        mov cl, numofitr
        fibronacci:
            call next
            mov currnum, dl
            tostr currnum strng
            mov dx, offset strng1
            mov ah, 09h
            int21h
        loop fibronacci:
        mov ah, 4ch
        int 21h
    main endp
    next proc
        pop ax
        pop bx
        ;a has latest value b has previous value now
        mov dx, ax
        add dx, bx
        mov bx, ax
        mov ax, dx
        push bx
        push ax
        ;dx contains next value for fibronacci
        ;stack top also contains latest value at top
    next endp
    end main