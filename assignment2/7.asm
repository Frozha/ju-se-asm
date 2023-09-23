.model small
.data
    str1 db "Hello$" 
    str2 db "World$"
    msg1 db "Strings are equal.$"
    msg2 db "Strings are not equal.$"
.code
main proc
    mov ax, @data
    mov ds, ax

    lea si, str1  ; Load address of the first string into SI
    lea di, str2  ; Load address of the second string into DI

compare_loop:
    mov al, [si]  ; Load a character from the first string
    mov bl, [di]  ; Load a character from the second string

    cmp al, bl    ; Compare the characters
    jne strings_not_equal  ; Jump if characters are not equal

    cmp al, '$'     ; Check if both strings have reached the null terminator
    je strings_equal

    inc si        ; Move to the next character in the first string
    inc di        ; Move to the next character in the second string
    jmp compare_loop

strings_equal:
    mov dx, offset msg1
    mov ah, 09h
    int 21h

    jmp exit_program

strings_not_equal:
    mov dx, offset msg2
    mov ah, 09h
    int 21h

exit_program:
    mov ah, 4ch
    int 21h

main endp
end main
