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
The trapezoid integrate extern function with name `df_dx`.
`df_dx` must be float type and receive a float type
Prototype `df_dx`
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

extern float df_dx(float x){
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

## Wrapper trapezoid

The function `trapezoidw` is a wrapper for function trapezoid in `asm`.
The `trapezoidw` receive a function to be integrated as argument (float f(float x))

To compile de wrapper lib:

```bash
gcc -Wall -g -c trapezoidw.c -o trapezoidw.o
```

Usage the `trapezoidw`:

```c
#include "trapezoidw.h"
float myfunc(float x){
  return x*x;
}

int main(){
  float x = trapezoidw(myfunc, 0.0, 2.0, 0.0, 1);
  printf("Integrated Value: %f\n", x);
  return 0.0
}
```

compile main.c program:

```bash
gcc main.c trapezoidw.o trapezoid.o -o main.out
```

## License:

Copyright 2018 Eduardo S. Pereira

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.



#teste
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
