;-------------------------------------------------------------------------------
; Developed by: Eduardo S. Pereira
; version: 0.0.1
; e-mail: pereira.somoza@gmail.com
; date: 17/05/2018
;
; Copyright 2018 Eduardo S. Pereira
;
; Licensed under the Apache License, Version 2.0 (the "License");
; you may not use this file except in compliance with the License.
; You may obtain a copy of the License at
;
; http://www.apache.org/licenses/LICENSE-2.0
;
; Unless required by applicable law or agreed to in writing, software
; distributed under the License is distributed on an "AS IS" BASIS,
; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
; See the License for the specific language governing permissions and
; limitations under the License.
;-------------------------------------------------------------------------------

%include "pow.asm"

section .text
    global trapezoid:function
    extern df_dx

    trapezoid:
      ;-------------------------------------------------------------------------
      ; trapezoid:
      ;     receive float, float, float and int on xmm0, xmm1, xmm2, rsi
      ;     return the Trapezoidal integration of external function df_dx
      ;     on xmm0;
      ;
      ;     df_dx must be float type (return on xmm0)
      ;     and receive a float type (on xmm0): float df_dx(float);
      ;
      ;
      ; I_k(h) = [(1/2) * I_{k-1}(2h)] + {h*sum[f(x_new)]}
      ; h = H / n
      ; H = b - a
      ;
      ;-------------------------------------------------------------------------

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
            call df_dx
            add rsp,8

            movss xmm1,xmm0

            ;f(b)
            movss xmm0, [b]
            sub rsp,8
            call df_dx
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
                call df_dx
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
