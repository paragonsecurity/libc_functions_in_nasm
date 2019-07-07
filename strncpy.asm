BITS 64
%define LEN 0x20

section .bss
	buffer resb LEN

section .data
	__test__ db 'Bytes have been copied with success ! ', 0xa, 0x0
	__test__len equ $-__test__

section .text
	global _start

_start:
	mov rdi, buffer
	mov rsi, __test__
	mov rdx, __test__len
	call _strncpy
	mov rax, 1
	mov rdi, 1
	mov rsi, buffer
	mov rdx, __test__len
	syscall
	jmp exit

;=========================================================

;Réimplémentation des fonctions de la libc en nasm x86-64
;Prototype : char *strncpy(char *dest, const char *src, size_t n);

;=========================================================

_strncpy:
	push rbp
	mov rbp, rsp
	push rdi
	mov rcx, 0
	jmp _loop

_loop:
	cmp rcx, rdx
	je _end
	cmp byte [rsi], 0x0
	je _end
	movzx rax, byte [rsi]
	mov [rdi], rax
	inc rsi
	inc rdi
	inc rcx
	jmp _loop

_end:
	pop rax
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

