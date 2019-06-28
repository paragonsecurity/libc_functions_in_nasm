BITS 64

;==================================================================

;Réimplémentation de la fonction int puts(const char *s);
;Prototype int puts(const char *s);

;==================================================================

_puts:
	push rbp
	mov rbp, rsp
	mov rsi, rdi
	call _strlen
	mov rdi, 0x1
	mov rdx, rax
	mov rax, 0x1
	syscall
	jmp _ret



;==================================

; Réimplémentation des fonctions de la libc en nasm 64 bits
; Une fonction qui calcule la taille d'une chaine de caractère en octets

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



;==============================================================================

;                   Etiquettes utilisées par toutes les fonctions

exit:
    mov rax, 60
    mov rdi, 0
    syscall

_ret:
    leave ; mov rsp, rbp ; pop rbp
    ret ; pop rip && jmp rip


;==============================================================================
