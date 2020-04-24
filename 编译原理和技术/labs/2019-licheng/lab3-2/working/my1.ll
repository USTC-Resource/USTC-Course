; ModuleID = 'my1'
source_filename = "my1.ll.real"

define i32 @main() {
entry:
  %0 = alloca i32
  %1 = alloca i32
  %2 = alloca i32
  %3 = add i32 1, 2
  %4 = add i32 1, 2
  %5 = add i32 1, 2
  ret i32 0
}
