.model small
.stack 100h
.data
    string db "hrithvik$"
.code
    main proc
        mov ax, @data
        mov ds, ax
        mov si, offset string
        mov cx, 8

        tostack:
            push [si]
            inc si
        loop tostack

        mov cx, 8
        mov ah, 02h

        print:
            pop dx
            int 21h
        loop print

        mov ah, 4ch
        int 21h
        
    main endp
    end main