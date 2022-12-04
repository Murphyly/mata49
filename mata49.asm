%include "io.inc"

section .bss
frase resb 300
concatenada resb 300
substr resb 300
invertido resb 300
frasenova resb 300

section .text
global CMAIN
CMAIN:
    mov ebp, esp
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor esi, esi
    xor edi, edi

    GET_STRING frase, 300
    call part 
    mov al, "a"
    PRINT_STRING "2 -"
    NEWLINE
    PRINT_STRING "Letras a: "
    call contaletra
    mov al, "m"
    PRINT_STRING "Letras m: "
    call contaletra
    call inverte
    call tiraespaco
    call mudamaiusculaminuscula
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
    mov edi, invertido
    mov word [edi],0
    ;add esi, 12
    mov ecx, 300
    ret
    
inverte:
    std     ;seta a direction flag para decrementar
    lodsb   ;le a partir do fim da string
    cld     ;seta a direction flag para incrementar
    stosb   ;armazena a partir do início da string
    dec ecx
    jnz inverte ;jump if not zero
    cld     ;reseta a direction flag
    PRINT_STRING "3 -"
    NEWLINE
    PRINT_STRING invertido
    NEWLINE
    ret
    
contaletra:
    mov ecx, 0
    mov ebx, 0 ;quantidade da letra ficará em ebx
    mov edi, frase ;scasb busca a string que está em edi
repete:    
    scasb ;compara o valor de AL com o de EDI(byte)e incrementa EDI (passa para próxima letra)
    jne nincrementa ;se a letra não for igual a de AL, não incrementa EBX 
    inc ebx
nincrementa:
    inc ecx
    cmp ecx, 300; ecx so pode ir até o máximo reservado para a frase
    jne repete; se ecx não percorreu todo espaço reservado repete a operação
    PRINT_DEC 4,ebx; se ecx ja passou do valor reservado imprime o resultado que está em ebx
    NEWLINE
    ret

tiraespaco:
    PRINT_STRING "4 - "
    NEWLINE
    mov ecx, 0
    mov esi, substr ; a frase concatenada
    mov edi, concatenada
looper:   
    lodsb
    cmp al, " "
    je cortaespaco
    stosb
cortaespaco:
    inc ecx
    cmp ecx, 300
    jne vaivoltar
    PRINT_STRING concatenada
    NEWLINE
    ret
vaivoltar:
    jmp looper
    
    
mudamaiusculaminuscula:
    PRINT_STRING "5 - "
    NEWLINE
    mov ecx, 0
    mov esi, substr
    mov edi, frasenova
novasequencia:
    call transformamaiuscula
    stosb
    call transformamaiuscula
    stosb
    call transformaminuscula
    stosb
    call transformaminuscula
    stosb
    call transformaminuscula
    stosb
    cmp ecx, 300
    jl novasequencia
    PRINT_STRING frasenova
    ret
    
    
transformamaiuscula:
    lodsb
    cmp ecx, 300
    jge volta1
    inc ecx
    cmp al, " "
    je temespaco
    cmp al, "a"
    jl volta1
    sub al, 20h
volta1:
    ret
temespaco:
    stosb
    jmp transformamaiuscula
transformaminuscula:
    lodsb
    cmp ecx, 300
    jge volta2
    inc ecx
    cmp al, " "
    je temespaco2
    cmp al, "a"
    jge volta2
    add al, 20h
volta2:
    ret
temespaco2:
    stosb
    jmp transformaminuscula
    
    
    
