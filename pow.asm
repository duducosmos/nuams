pow:
    ;--------------------------------------------------------------------------
    ; Returns base raised to the power exponent for float base
    ; base in xmm0
    ; exponent in rsi
    ; Usage:
    ;      mov rsi, 2
    ;      movss xmm0,[cnt0]
    ;      call pow
    ;--------------------------------------------------------------------------

    movss xmm1, xmm0
    mov rbx, 1
    .while:
        cmp rbx,rsi
        je .end_while
        mulss xmm0, xmm1
        add rbx,1
        jmp .while
    .end_while:
    ret

powi:
    ;--------------------------------------------------------------------------
    ; Returns base raised to the power exponent for integer base
    ; base in rsi
    ; exponent in rdi
    ; return in rax
    ; Usage:
    ;     push rax
    ;     mov rsi,[cnt0]
    ;     mov rdi,[tmp]
    ;     call powi
    ;     mov [n],rax
    ;     pop rax
    ;--------------------------------------------------------------------------

    mov rbx, 1
    mov rcx, rsi
    mov rax, rsi
    .while:
        cmp rbx,rdi
        je .end_while
        mul rcx
        inc rbx
        jmp .while
    .end_while:
    ret
