; ModuleID = 'test1.ll'
source_filename = "test1.cminus"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

declare i32 @input()

declare void @output(i32)

declare void @neg_idx_except()

define i32 @main() {
entry:
  %0 = alloca i32
  %1 = alloca i32
  %2 = alloca i32
  %3 = alloca i32
  %4 = alloca i32
  store i32 1, i32* %1
  store i32 1, i32* %2
  store i32 1, i32* %3
  store i32 1, i32* %4
  %5 = load i32, i32* %1
  %6 = load i32, i32* %1
  %7 = add i32 %5, %6
  store i32 %7, i32* %3
  %8 = load i32, i32* %1
  %9 = load i32, i32* %1
  %10 = add i32 %8, %9
  store i32 %10, i32* %2
  %11 = load i32, i32* %1
  %12 = load i32, i32* %2
  %13 = add i32 %11, %12
  %14 = load i32, i32* %3
  %15 = load i32, i32* %4
  %16 = add i32 %14, %15
  store i32 0, i32* %0
  br label %returnBB

returnBB:                                         ; preds = %entry
  %17 = load i32, i32* %0
  ret i32 %17
}
