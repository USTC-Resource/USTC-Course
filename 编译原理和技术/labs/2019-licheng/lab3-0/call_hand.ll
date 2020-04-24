; int callee(int a){
;   return 2 * a;
; }
; int main(){
;   return callee(10);
; }

; ModuleID = 'call_hand'
source_filename = "call_hand"

define i32 @callee(i32) {
entry:
  ; %0 contains the parameter
  %1 = alloca i32
  store i32 %0, i32* %1
  %2 = load i32, i32* %1
  ; *2
  %3 = mul nsw i32 %2, 2
  ; return
  ret i32 %3
}

define i32 @main() {
entry:
  ; load 10
  %0 = alloca i32
  store i32 10, i32* %0
  %1 = load i32, i32* %0
  ; call with 10
  %2 = call i32 @callee(i32 %1)
  ret i32 %2
}
