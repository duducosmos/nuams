#include <stdio.h>


extern float trapezoid(float, float, float, int);
extern float df_dx(float x);

float df_dx(float x){
    return x*x;
}

extern void print_float(float x){
    printf("T: %f\n", x);
}



int main(){
    float x = trapezoid(0.0, 2.0, 0.0, 1);
    x = trapezoid(0.0, 2.0, x, 2);
    x = trapezoid(0.0, 2.0, x, 3);
    x = trapezoid(0.0, 2.0, x, 4);

    printf("Valor %f\n", trapezoid(0.0, 2.0, x, 4));

    return 0;
}
