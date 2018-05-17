#include <stdio.h>


extern float romberg(float, float, float, int);
extern float df_dx(float x);

float df_dx(float x){
    return x*x;
}

extern void print_float(float x){
    printf("T: %f\n", x);
}



int main(){
    float x = romberg(0.0, 2.0, 0.0, 1);
    printf("Valor %f\n", x);

    return 0;
}
