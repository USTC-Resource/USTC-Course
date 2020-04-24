; int main(){
;   int a;
;   int i;
;   a = 10;
;   i = 0;
;   while(i < 10){
;     i = i + 1;
;     a = a + i;
;   }
;   return a;
; }

; ModuleID = 'while'
source_filename = "while"

define i32 @main() {
entry:
  ; a
  %0 = alloca i32
  ; i
  %1 = alloca i32
  store i32 10, i32* %0
  store i32 0, i32* %1
  ; a
  %2 = load i32, i32* %0
  ; i
  %3 = load i32, i32* %1
  ; i < 10 ?
  %4 = icmp slt i32 %3, 10
  br i1 %4, label %trueBB, label %endd
trueBB:
  ; i <- i + 1
  %5 = load i32, i32* %1
  %6 = add nsw i32 %5, 1
  store i32 %6, i32* %1
  ; a <- a + i
  %7 = load i32, i32* %0
  %8 = add nsw i32 %7, %6
  store i32 %8, i32* %0
  ; i < 10 ?
  %9 = icmp slt i32 %6, 10
  ; jump to end or repeat
  br i1 %9, label %trueBB, label %endd
endd:
  %10 = load i32, i32* %0
  ret i32 %10
}
