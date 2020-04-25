; int main(){
;   if(2 > 1)
;     return 1;
;   return 0;
; }

; ModuleID = 'if'
source_filename = "if"

define i32 @main() {
entry:
  %0 = alloca i32
  %1 = alloca i32
  store i32 2, i32* %0
  store i32 1, i32* %1
  %2 = load i32, i32* %0
  %3 = load i32, i32* %1
  ; 2 > 1 ?
  %4 = icmp sgt i32 %2, %3
  ; conditional block
  br i1 %4, label %trueBB, label %falseBB

trueBB:
  ; return 1
  %5 = alloca i32
  store i32 1, i32* %5
  %6 = load i32, i32* %5
  ret i32 %6

falseBB:
  ; return 0
  %7 = alloca i32
  store i32 0, i32* %7
  %8 = load i32, i32* %7
  ret i32 %8
}
