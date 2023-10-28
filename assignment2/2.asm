tostr macro number, string
    mov si, offset string
    mov ax, number
    mov ch, 10
    mov cl ,0
    
    divloop:
        div ch
        add ah, 48
        cmp al, 0
        mov dl, ah
        mov dh, 0
        push dx
        je unstack
        inc cl
        mov ah, 0
        
    jmp divloop
    unstack:
        mov ch, 0
        add cl, 1
        poploop:
            pop dx
            mov [si], dx
            inc si
        loop poploop
endm

.model small
.stack 100h
.data
    num db 1,3,3,5,10,2,3,4,12,11
    str1 db 5 dup("$")
    msg1 db 'largest element : $'
.code
    main proc
        mov ax, @data
        mov ds, ax
        mov si, offset num
        
        mov cx, 9
        mov dx, 0
        mov dl, [si]
        push dx
        check:
            inc si
            pop ax
            mov dh, 0
            mov dl, [si]
            cmp dx, ax
            jg d
            push ax
            jmp skipd
            d:
                push dx
            skipd:
        loop check

        mov dx, offset msg1
        mov ah, 09h
        int 21h
        pop dx
        tostr dx, str1
        mov dx, offset str1
        mov ah, 9
        int 21h
        mov ah, 4ch
        int 21h
    main endp
end main