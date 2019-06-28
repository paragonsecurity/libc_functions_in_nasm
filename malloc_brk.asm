BITS 64

section .data
	_allocated db 'Bytes allocated with success !', 0xa, 0h
	_allocated_len equ $-_allocated

	error_brk db `Error, brk cannot allocate space\n`, 0h
	error_brk_len equ $-error_brk

section .text
	global _start

_start:
	mov rdi, _allocated_len
	call _mallloc_brk
	push rax
	mov rdi, _allocated
	jmp _initialisation

_initialisation:
	cmp byte [rdi], 0
	je _tab_allocated
	movzx rdx, byte [rdi]
	mov [rax], rdx
	inc rax
	inc rdi
	jmp _initialisation

_tab_allocated:
	mov rax, 0x1
	mov rdi, 0x1
	pop rsi
	mov rdx, _allocated_len
	syscall
    mov rdi, rsi
	call _free
	jmp exit


;==================================

;Réimplémentation des fonctions de la libc en nasm 64 bits
; Une fonction qui réimplémente malloc 
; Prototype : *malloc(size_t size)

;=================================

;Contraintes : 
;               Retourner un ptr vers le début de la zone allouée
;               Allouer la taille passée en argument
;               


_mallloc_brk:
    push rbp
    mov rbp, rsp
    push rdi ; argument utlisateur (taille à allouer)
    mov rax, 12
    mov rdi, 0
    syscall
    push rax ; addr du heap
    mov rax, 12
    pop rcx ; addr du heap
    pop rdi ; argument utlisateur (taille à allouer)
    push rdi
    push rcx
    add rdi, rcx ; addr_du_heap + taille_à_allouer
    syscall ; brk(addr_du_heap + taille_à_allouer)
    cmp byte [rax], 0
    jne _bad_error_brk
    pop rax ; brk base
    jmp _ret

_free:
    push rbp
    mov rbp, rsp
    mov rax, 12
    syscall
    jmp _ret

_bad_error_brk:
    mov rax, 0x1
    mov rdi, 0x1
    mov rsi, error_brk
    mov rdx, error_brk_len
    syscall
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
