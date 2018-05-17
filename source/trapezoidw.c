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

/* Wrapper  fo trapezoid assembly function */

#include "trapezoidw.h"

float df_dx(float x){return (*wfunc)(x);}

float trapezoidw(float (*func)(float x), float a, float b, float iold, int n){
  /*
     Receive a float function, down integration limit a, up integration limit b
     the old integration an the step integration
  */
  wfunc = &(*func);
  return trapezoid(a, b, iold, n);

}
