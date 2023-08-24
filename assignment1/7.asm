.model small
.stack 100h
.data
    string db "hrithvik$"
.code
    main proc
        mov ax, @data
        mov ds, ax

        mov si, offset string

        mov dl, '0'
        eostring:
            mov al, [si]
            cmp al, '$'
            je finish
            add dl, 1
            inc si
            jmp eostring
        
        finish:
            mov ah, 02h
            int 21h

            mov ah, 4ch
            int 21h
    main endp
    end main