
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
%ifndef POW_S
    %define POW_S
    global powi
    global pow
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
%endif
