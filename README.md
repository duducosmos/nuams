# Numerical Assembly

Numerical Routines written in Assembly Language, for Linux


## Trapezoid

Recursive Trapezoidal Rule.

trapezoid: 
   input: a, b, old Integration, n
   output: new integrate
   prototype: 
   ```c
   extern float trapezoid(float, float, float, int);
   ```
The trapezoid integrate extern function with name ifun.
ifunc must be float type and receive a float type
Prototype ifunc
```c
extern void print_float(float x);
```

## Compile Trapezoid

```bash
nasm -f elf64 trapezoid.asm 
```

## Call trapezoid in C

```c
#include <stdio.h>

extern float trapezoid(float, float, float, int);

extern float ifunc(float x){
    return x*x;
}

int main(){
    float x = trapezoid(0.0, 2.0, 0.0, 1);
    x = trapezoid(0.0, 2.0, x, 2);
    x = trapezoid(0.0, 2.0, x, 3);
    x = trapezoid(0.0, 2.0, x, 4);
    printf("Valor %f\n", trapezoid(0.0, 2.0, x, 4));
    return 0;
}
```

### Compile C program

```bash
gcc teste_trapezio.c trapezoid.o -o trapezoid.out
```
