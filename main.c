/*
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
*/

#include <stdio.h>
#include "trapezoidw.h"

float myfunc(float x){
  return x*x;
}

int main(){
  float x = trapezoidw(myfunc, 0.0, 2.0, 0.0, 1);
  x = trapezoidw(myfunc, 0.0, 2.0, x, 2);
  x = trapezoidw(myfunc, 0.0, 2.0, x, 3);
  x = trapezoidw(myfunc, 0.0, 2.0, x, 4);

  printf("Valor w %f\n", trapezoidw(myfunc, 0.0, 2.0, x, 4));

    return 0;
}
