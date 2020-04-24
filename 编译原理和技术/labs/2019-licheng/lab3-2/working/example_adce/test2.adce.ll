; ModuleID = 'test2.ll'
source_filename = "test2.cminus"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

declare i32 @input()

declare void @output(i32)

declare void @neg_idx_except()

define i32 @main() {
entry:
  br label %loopStartBB_1

loopStartBB_1:                                    ; preds = %loopBodyBB_1, %entry
  %.01 = phi i32 [ 1, %entry ], [ %1, %loopBodyBB_1 ]
  %0 = icmp slt i32 %.01, 10
  br i1 %0, label %loopBodyBB_1, label %loopEndBB_1

loopBodyBB_1:                                     ; preds = %loopStartBB_1
  %1 = add i32 %.01, 1
  br label %loopStartBB_1

loopEndBB_1:                                      ; preds = %loopStartBB_1
  br label %returnBB

returnBB:                                         ; preds = %loopEndBB_1
  ret i32 0
}
