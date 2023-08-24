.model small
.stack 100h
.data
    var1 db 9
    var2 db 3
.code
    main proc
        mov ax, @data
        mov ds, ax

        mov dl, var1

        sub dl,var2
        add dl, 48

        mov ah, 02h
        int 21h

        mov ah, 4ch
        int 21h
    main endp
    end main