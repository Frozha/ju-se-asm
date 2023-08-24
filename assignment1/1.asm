.model small
.stack 100h
.data
    var1 db 02h
    var2 db 06h
.code
    main proc
        mov ax, @data
        mov ds, ax

        mov dl, var1

        add dl, var2
        add dl, 48

        mov ah, 02h
        int 21h

        mov ah, 4ch
        int 21h
    main endp
    end main