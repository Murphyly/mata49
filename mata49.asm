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
    mov ecx, 300
    ret
    
inverte:
    mov edi, invertido
    mov esi, frase
    mov ecx, 0
    
   pushinverte:
    lodsb
    cmp al, 0
    jz cleaninverte
    push eax 
    inc ecx
    jmp pushinverte
    
   cleaninverte:
    pop eax
    stosb
    loop cleaninverte
    mov al, 0 
    stosb
    
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
    mov esi, substr ; a frase a ser concatenada, vinda da questão 1
    mov edi, concatenada; onde vai ficar a frase concatenada
looper:   
    lodsb ; coloca letra apontada por edi em al e incrementa
    cmp al, " " ; verifica se a letra é um espaço
    je cortaespaco ; se for espaço pula a parte de colocar a letra na nova string
    stosb ; colocar letra na string
cortaespaco:
    inc ecx
    cmp ecx, 300 ; ecx so vai até a quantidade definida para a frase
    jne looper ; se ecx não chegou ao máximo passa para a próxima letra
    PRINT_STRING concatenada ; imprime a nova string
    NEWLINE
    ret
    
    
mudamaiusculaminuscula:
    PRINT_STRING "5 - "
    NEWLINE
    mov ecx, 0
    mov esi, substr ;a nova frase vai ser feita da substring
    mov edi, frasenova ;frase que terá letras maiusculas e minusculas
novasequencia:
    call transformamaiuscula ; segue a sequencia de 2 maiusculas e 3 minusculas, colocando cada uma retornada na funcao para a nova frase
    stosb
    call transformamaiuscula
    stosb
    call transformaminuscula
    stosb
    call transformaminuscula
    stosb
    call transformaminuscula
    stosb
    cmp ecx, 300 ;se ecx ainda estiver contando dentro da string, reinicia a sequencia de maiusculas e minusculas
    jl novasequencia
    PRINT_STRING frasenova ; quando verificar toda a string imprime a frase nova
    ret
    
    
transformamaiuscula:
    lodsb ; coloca a letra de esi em al e depois incrementa
    cmp ecx, 300; precisa ver se ecx ja passou da string para não considerar strings nos próximos endereços
    jge volta1
    inc ecx
    cmp al, " " ; se al for espaço é necessário rodar de novo essa procedure, e colocar o espaço na nova frase, pois o espaço não conta para a sequencia
    je temespaco
    cmp al, "a" ; compara al com a primeira letra minuscula, pois em ASCII as maiúsculas possuem numeros menores, portanto algoritmo so serve para frases contendo apenas letras e espaços
    jl volta1
    sub al, 20h; 20 hexadecimal é a diferença entre uma letra minúscula e sua equivalente maiúscula na tabela ASCII 
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
    jge volta2 ; comparação agora é para maior igual, pois letras maiusculas serão transformadas em minusculas.
    add al, 20h ; adição no lugar de subtração, pois maiúsculas são menores.
volta2:
    ret
temespaco2:
    stosb
    jmp transformaminuscula
    
    
    
