%include "io.inc"

section .bss
frase resb 62
substr resb 41
invertido resb 62

section .text
global CMAIN
CMAIN:
    mov ebp, esp
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor esi, esi
    xor edi, edi

    GET_STRING frase, 62
    call part 
    call inverte
    ret 
    
part:
    mov esi, frase
    add esi, 7     ;inicio da substring a ser retirada
    mov edi, substr
    mov ecx, 41    ;tamanho da substring a ser retirada
    rep movsb
    
    PRINT_STRING "1 -"
    NEWLINE
    
    PRINT_STRING substr
    NEWLINE
    start:
    mov edi, invertido
    mov ecx, 62
    ret
    
inverte:
    std     ;seta a direction flag para decrementar
    lodsb   ;le a partir do fim da string
    cld     ;seta a direction flag para incrementar
    stosb   ;armazena a partir do início da string
    dec ecx
    jnz inverte ;jump if not zero
    mov word [edi],0
    PRINT_STRING "3 -"
    NEWLINE
    PRINT_STRING invertido
    NEWLINE
    ret
end 

    
    
   
    

    
    
