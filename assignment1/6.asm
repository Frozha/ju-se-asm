.model small
.stack 100h
.data
    str1 db 100 dup('$')
.code
    main proc
        mov ax, @data
        mov ds, ax

        mov si, offset str1
        
        uinp:
            mov ah, 01h
            int 21h
            mov [si], al
            inc si
            cmp al, 13
        jne uinp

        mov dx, offset str1
        mov ah, 09h
        int 21h

        mov ah, 4ch
        int 21h
    main endp
    end main
