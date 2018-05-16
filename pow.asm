%macro pow 2
    movss xmm0, [%1]
    mov rbx, 1
    %%while:
        cmp rbx,[%2]
        je %%end_while
        mulss xmm0, [%1]
        add rbx,1
        jmp %%while
    %%end_while:
%endmacro

%macro powi 2

    mov rbx, 1
    mov rcx, [%1]
    mov rax, [%1]
    %%while:
        cmp rbx,[%2]
        je %%end_while
        mul rcx
        inc rbx
        jmp %%while
    %%end_while:
%endmacro


%macro write 1
    push rax
    push rcx
    mov rdi,msg
    mov rsi,%1
    xor rax,rax
    call printf
    pop rax
    pop rcx
%endmacro
