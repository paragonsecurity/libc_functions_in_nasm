BITS 64
%define LEN 0x20


section .bss
    input resb LEN
    input_2 resb LEN

section .data
    first db 'Entrer une string : ', 0x0
    first_len equ $-first

    second db 'Entrer une deuxieme string : ', 0x0
    second_len equ $-second

    equal db 'strings are equals ! ', 0xa, 0x0
    equal_len equ $-equal

section .text
    global _start

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, first
    mov rdx, first_len
    syscall
    mov rax, 0
    mov rdi, 1
    mov rsi, input
    mov rdx, LEN
    syscall
    mov rax, 1
    mov rdi, 1
    mov rsi, second
    mov rdx, second_len
    syscall
    mov rax, 0
    mov rdi, 1
    mov rsi, input_2
    mov rdx, LEN
    syscall
    mov rdi, input
    mov rsi, input_2
    call _strcmp
    cmp rax, 0
    je _equal
    jmp exit

_equal:
    mov rax, 1
    mov rdi, 1
    mov rsi, equal
    mov rdx, equal_len
    syscall
    jmp exit



_strcmp:
	push rbp 
	mov rbp, rsp
	xor rax, rax
	xor rdx, rdx
	mov r11, 0
	jmp _compare

_compare:
	movzx rdx, byte [rdi]
	cmp rdx, 0
	je _end_strcmp
	movzx rax, byte [rsi]
	cmp rax, 0
	je _end_strcmp
	cmp rdx, rax
	jne _inc_return_value
	inc rdi
	inc rsi
	jmp _compare

_inc_return_value:
	inc r11
	inc rdi
	inc rsi
	jmp _compare

_end_strcmp:
	mov rax, r11
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
