
;========================

;   This fonction will clear the \n of a string
;   Prototype : *clear_n(*string)

;========================

_clear_n:
    push rbp
    mov rbp, rsp
    mov rcx, 0
    mov rax, rdi
    jmp _loop_a

_loop_a:
    cmp byte [rax], 0xa
    je _end_a
    inc rax
    jmp _loop_a

_end_a:
    mov byte [rax], 0x0 ; \n
    mov rax, rdi
    jmp _ret

_ret:
    leave ; mov rsp, rbp ; pop rbp
    ret ; pop rip && jmp rip