

;==================================

; Réimplémentation des fonctions de la libc en nasm 64 bits
; Une fonction qui retourne la taille d'une chaine de caractère en octets

;=================================

_strlen:
    push rbp
    mov rbp, rsp
    mov rcx, 0
    mov rax, rdi
    jmp _loop

_loop:
    cmp byte [rax], 0
    je _end
    inc rax
    inc rcx
    jmp _loop

_end:
    mov rax, rcx
    jmp _ret

_ret:
    leave ; mov rsp, rbp ; pop rbp
    ret ; pop rip && jmp rip
