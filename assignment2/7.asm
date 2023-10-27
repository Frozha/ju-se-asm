.model small
.stack 100h
.data
    str1 db "Hello$" 
    str2 db "World$"
    msg1 db "Strings are equal.$"
    msg2 db "Strings are not equal.$"
.code
main proc
    mov ax, @data
    mov ds, ax

    lea si, str1  
    lea di, str2  

compare_loop:
    mov al, [si]  
    mov bl, [di] 

    cmp al, bl    
    jne strings_not_equal  

    cmp al, '$'     
    je strings_equal

    inc si        
    inc di        
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
