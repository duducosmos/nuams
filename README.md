# Numerical Assembly

Numerical Routines written in Assembly Language

Compilar.

nasm -f elf64 hola.asm
gcc teste.c hola.o

```asm
push rax
push rcx
mov rdi,msg
mov rsi,[n]
xor rax,rax
call printf
pop rax
pop rcx
```
