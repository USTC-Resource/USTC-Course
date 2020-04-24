; int main(){
;   int a;
;   a = 1;
;   return a;
; }

; ModuleID = 'assign'
source_filename = "assign"

define i32 @main() {
entry:
	; store the number 1
	%0 = alloca i32
	store i32 1, i32* %0
	; load & prepare for return
	%1 = load i32, i32* %0
	ret i32 %1
}
