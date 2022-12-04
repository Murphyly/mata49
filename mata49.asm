%include "io.inc"

section .bss
frase resb 62
substr resb 41
invertido resb 62

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor esi, esi
    xor edi, edi

    GET_STRING frase, 62
    mov esi, frase
    add esi, 7     ;inicio da substring a ser retirada
    mov edi, substr
    mov ecx, 41    ;tamanho da substring a ser retirada
    rep movsb
    
    PRINT_STRING "1 -"
    NEWLINE
    
    PRINT_STRING substr
    NEWLINE
    mov edi, invertido
    mov ecx, 62

    std
    lodsb   ;volta para o último caractere da string retirada
inverte:
    std     ;seta a direction flag para decrementar
    lodsb   ;le a partir do fim da string
    cld     ;seta a direction flag para incrementar
    stosb   ;armazena a partir do início da string
    dec ecx
    jnz inverte
    cld     ;reseta a direction flag
    
    PRINT_STRING invertido
    NEWLINE

    
    
   
    

    
    
