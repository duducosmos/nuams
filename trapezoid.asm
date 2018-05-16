%include "pow.asm"

section .text
    global trapezoid:function
    extern ifunc
    extern printf

    ;---------------------------------------------------------------------------
    ; trapezoid: receive float, float, float, int
    ;                    xmm0, xmm1, xmm2, rsi
    ; ifunc must be float type and receive a float type
    ; float ifunc(float)
    ;
    ; I_k(h) = [(1/2) * I_{k-1}(2h)] + {h*sum[f(x_new)]}
    ; h = H / n
    ; H = b - a
    ;---------------------------------------------------------------------------

    trapezoid:
        mov [k], rdi
        movss [a], xmm0
        movss [b], xmm1
        movss [iold], xmm2

        cmp rdi,1
        je step1
        jmp step2

        step1:
            ;---------------------------------
            ; xmm0 = (f(a) + f(b)) * (b - a) / 2.0
            ;---------------------------------

            ; f(a)
            movss xmm0, [a]
            sub rsp,8
            call ifunc
            add rsp,8

            movss xmm1,xmm0

            ;f(b)
            movss xmm0, [b]
            sub rsp,8
            call ifunc
            add rsp,8

            ;xmm2 = f(a) + f(b)
            addss xmm0,xmm1
            movss xmm2,xmm0

            ; a - b
            movss xmm0,[b]
            movss xmm1,[a]
            subss xmm0,xmm1

            ;xmm0 = (b - a) / 2.0
            movss xmm1,[cnt1]
            divss xmm0,xmm1
            mulss xmm0, xmm2
            jmp theend
        step2:
            ;--------------------
            ; n = 2 ** (k - 2)
            ;--------------------
            mov rax,[k]
            sub rax,2
            cmp rax,0
            je n_one
            mov [tmp],rax; (k -2)

            mov rsi,[cnt0]
            mov rdi,[tmp]
            call powi
            mov [n],rax

            n_one:
                mov rax, 1
                mov [n],rax
            ;--------------------

            ;--------------------
            ; h = (b - a) / n
            ;--------------------
            movss xmm1,[b]
            movss xmm2,[a]
            subss xmm1,xmm2
            cvtsi2ss xmm2,[n]
            divss xmm1, xmm2
            movss [h],xmm1
            ;--------------------

            ;--------------------
            ; h / 2.0
            ;--------------------
            divss xmm1,[cnt1]
            ;--------------------
            ;x = a + h/2
            ;--------------------
            addss xmm1,[a]
            movss [x], xmm1
            movss xmm2, [sum]

            mov rbx,1
            wsum:
                cmp rbx,n
                je endwsum
                ;--------------------
                ;f(x)
                ;--------------------
                movss xmm0, [x]
                sub rsp,8
                call ifunc
                add rsp,8

                ;--------------------
                ;sum = sum + fun(x)
                ;--------------------
                addss xmm2, xmm0
                movss [sum],xmm2

                ;--------------------
                ;x = x + h
                ;--------------------
                movss xmm0,[x]
                addss xmm0,[h]
                movss [x],xmm0

                inc rbx
            endwsum:

            ;--------------------
            ;inew = (iold + h * sum )/ 2.0
            ;--------------------
            movss xmm0,[sum]
            mulss xmm0,[h]

            addss xmm0,[iold]
            divss xmm0,[cnt1]

        theend:

        ret

section .data
    tmp: dd 0.0
    sum: dd 0.0
    n: dd 0
    h: dd 0.0
    x: dd 0.0
    a: dd 0.0
    b: dd 0.0
    iold: dd 0.0
    cnt1: dd 2.0
    cnt0: dd 2
    k: dq 0
    msg: db "Teste %d",10,0
