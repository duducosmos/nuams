
%ifndef ROMBERG_S
    %define ROMBERG_S

section .text
    global romberg:function
    extern df_dx
    extern printf
    extern powi
    extern trapezoid

    romberg:
    ret

section .data
   rombg: dd 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
          dd 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0

   msg: db "Teste ",10,0
%endif
