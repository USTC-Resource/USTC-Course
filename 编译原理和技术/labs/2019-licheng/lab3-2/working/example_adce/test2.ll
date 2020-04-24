; ModuleID = 'cminus'
source_filename = "test2.cminus"
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
  br label %loopStartBB_1

loopStartBB_1:                                    ; preds = %loopBodyBB_1, %entry
  %5 = load i32, i32* %1
  %6 = icmp slt i32 %5, 10
  br i1 %6, label %loopBodyBB_1, label %loopEndBB_1

loopBodyBB_1:                                     ; preds = %loopStartBB_1
  %7 = load i32, i32* %1
  %8 = add i32 %7, 1
  store i32 %8, i32* %1
  %9 = load i32, i32* %1
  %10 = load i32, i32* %2
  %11 = add i32 %9, %10
  %12 = load i32, i32* %3
  %13 = add i32 %11, %12
  %14 = load i32, i32* %4
  %15 = add i32 %13, %14
  store i32 %15, i32* %4
  br label %loopStartBB_1

loopEndBB_1:                                      ; preds = %loopStartBB_1
  store i32 0, i32* %0
  br label %returnBB

returnBB:                                         ; preds = %loopEndBB_1
  %16 = load i32, i32* %0
  ret i32 %16
}
