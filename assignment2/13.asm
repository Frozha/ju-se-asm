.model small
.stack 64
.data
    bytes dd 0040004ch
    rows db ?
    cols db ?
    msg1 db 0dh,0ah,'Total no of rows(in hex)=','$'
    msg2 db 0dh,0ah,'Total no of columns(in hex)=','$'
    msg3 db 0dh,0ah,'Press any key to clear screen','$'
    hexcode db '0123456789abcdef'
    
.code
display proc
    push ax
    push bx
    push cx
    push dx

    lea dx, msg1
    mov ah, 09h
    int 21h
    mov al, rows
    mov cl, 10h
    mov ah, 00h
    div cl
    mov bl, al
    mov dl, hexcode[bx]
    push ax
    mov ah, 02h
    int 21h
    pop ax
    mov bl, ah
    mov dl, hexcode[bx]
    mov ah, 02h
    int 21h

    lea dx, msg2
    mov ah, 09h
    int 21h
    mov al, cols
    mov cl, 10h
    mov ah, 00h
    mov bh, 00h
    div cl
    mov bl, al
    mov dl, hexcode[bx]
    push ax
    mov ah, 02h
    int 21h
    pop ax
    mov bl, ah
    mov dl, hexcode[bx]
    mov ah, 02h
    int 21h

    pop dx
    pop cx
    pop bx
    pop ax
    ret
display endp

main:
    mov ax, @data
    mov ds, ax
    mov ah, 0fh
    int 10h
    mov cols, ah
    mov cl, ah
    mov ch, 0
    push ds
    lds si, bytes
    mov ax, [si]
    pop ds
    shr ax, 1
    div cl
    mov rows, al
    call display
    lea dx, msg3
    mov ah, 09h
    int 21h
    mov ah, 01h
    int 21h
    mov dh, 0

again:
    mov bh, 0
    mov dl, 0
    mov ah, 02h
    int 10h
    mov bl, 0
    mov al, 'x'
    mov ah, 09h
    int 10h
    inc dh
    cmp dh, rows
    jb again

    mov ah, 4ch
    int 21h

end main
