# After Instruction Selection:
# Machine code for function gcd: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10 in %0, $x11 in %1

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11
  %1:gpr = COPY $x11
  %0:gpr = COPY $x10
  %3:gpr = COPY %1:gpr
  %2:gpr = COPY %0:gpr
  SW %0:gpr, %stack.1, 0 :: (store 4 into %ir.4)
  SW %1:gpr, %stack.2, 0 :: (store 4 into %ir.5)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  %5:gpr = COPY $x0
  BNE killed %4:gpr, %5:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %12:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %12:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %6:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  %7:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  $x10 = COPY %6:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %8:gpr = COPY $x10
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %9:gpr = COPY $x10
  %10:gpr = SUBW %6:gpr, %9:gpr
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %7:gpr
  $x11 = COPY %10:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %11:gpr = COPY $x10
  SW %11:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  %13:gpr = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
  $x10 = COPY %13:gpr
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Expand ISel Pseudo-instructions:
# Machine code for function gcd: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10 in %0, $x11 in %1

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11
  %1:gpr = COPY $x11
  %0:gpr = COPY $x10
  %3:gpr = COPY %1:gpr
  %2:gpr = COPY %0:gpr
  SW %0:gpr, %stack.1, 0 :: (store 4 into %ir.4)
  SW %1:gpr, %stack.2, 0 :: (store 4 into %ir.5)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  %5:gpr = COPY $x0
  BNE killed %4:gpr, %5:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %12:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %12:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %6:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  %7:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  $x10 = COPY %6:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %8:gpr = COPY $x10
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %9:gpr = COPY $x10
  %10:gpr = SUBW %6:gpr, %9:gpr
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %7:gpr
  $x11 = COPY %10:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %11:gpr = COPY $x10
  SW %11:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  %13:gpr = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
  $x10 = COPY %13:gpr
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Early Tail Duplication:
# Machine code for function gcd: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10 in %0, $x11 in %1

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11
  %1:gpr = COPY $x11
  %0:gpr = COPY $x10
  %3:gpr = COPY %1:gpr
  %2:gpr = COPY %0:gpr
  SW %0:gpr, %stack.1, 0 :: (store 4 into %ir.4)
  SW %1:gpr, %stack.2, 0 :: (store 4 into %ir.5)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  %5:gpr = COPY $x0
  BNE killed %4:gpr, %5:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %12:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %12:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %6:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  %7:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  $x10 = COPY %6:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %8:gpr = COPY $x10
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %9:gpr = COPY $x10
  %10:gpr = SUBW %6:gpr, %9:gpr
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %7:gpr
  $x11 = COPY %10:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %11:gpr = COPY $x10
  SW %11:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  %13:gpr = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
  $x10 = COPY %13:gpr
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Optimize machine instruction PHIs:
# Machine code for function gcd: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10 in %0, $x11 in %1

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11
  %1:gpr = COPY $x11
  %0:gpr = COPY $x10
  %3:gpr = COPY %1:gpr
  %2:gpr = COPY %0:gpr
  SW %0:gpr, %stack.1, 0 :: (store 4 into %ir.4)
  SW %1:gpr, %stack.2, 0 :: (store 4 into %ir.5)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  %5:gpr = COPY $x0
  BNE killed %4:gpr, %5:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %12:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %12:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %6:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  %7:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  $x10 = COPY %6:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %8:gpr = COPY $x10
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %9:gpr = COPY $x10
  %10:gpr = SUBW %6:gpr, %9:gpr
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %7:gpr
  $x11 = COPY %10:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %11:gpr = COPY $x10
  SW %11:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  %13:gpr = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
  $x10 = COPY %13:gpr
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Merge disjoint stack slots:
# Machine code for function gcd: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10 in %0, $x11 in %1

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11
  %1:gpr = COPY $x11
  %0:gpr = COPY $x10
  %3:gpr = COPY %1:gpr
  %2:gpr = COPY %0:gpr
  SW %0:gpr, %stack.1, 0 :: (store 4 into %ir.4)
  SW %1:gpr, %stack.2, 0 :: (store 4 into %ir.5)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  %5:gpr = COPY $x0
  BNE killed %4:gpr, %5:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %12:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %12:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %6:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  %7:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  $x10 = COPY %6:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %8:gpr = COPY $x10
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %9:gpr = COPY $x10
  %10:gpr = SUBW %6:gpr, %9:gpr
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %7:gpr
  $x11 = COPY %10:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %11:gpr = COPY $x10
  SW %11:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  %13:gpr = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
  $x10 = COPY %13:gpr
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Local Stack Slot Allocation:
# Machine code for function gcd: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10 in %0, $x11 in %1

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11
  %1:gpr = COPY $x11
  %0:gpr = COPY $x10
  %3:gpr = COPY %1:gpr
  %2:gpr = COPY %0:gpr
  SW %0:gpr, %stack.1, 0 :: (store 4 into %ir.4)
  SW %1:gpr, %stack.2, 0 :: (store 4 into %ir.5)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  %5:gpr = COPY $x0
  BNE killed %4:gpr, %5:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %12:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %12:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %6:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  %7:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  $x10 = COPY %6:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %8:gpr = COPY $x10
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %9:gpr = COPY $x10
  %10:gpr = SUBW %6:gpr, %9:gpr
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %7:gpr
  $x11 = COPY %10:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %11:gpr = COPY $x10
  SW %11:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  %13:gpr = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
  $x10 = COPY %13:gpr
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Remove dead machine instructions:
# Machine code for function gcd: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10 in %0, $x11 in %1

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11
  %1:gpr = COPY $x11
  %0:gpr = COPY $x10
  %3:gpr = COPY %1:gpr
  %2:gpr = COPY %0:gpr
  SW %0:gpr, %stack.1, 0 :: (store 4 into %ir.4)
  SW %1:gpr, %stack.2, 0 :: (store 4 into %ir.5)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  %5:gpr = COPY $x0
  BNE killed %4:gpr, %5:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %12:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %12:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %6:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  %7:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  $x10 = COPY %6:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %8:gpr = COPY $x10
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %9:gpr = COPY $x10
  %10:gpr = SUBW %6:gpr, %9:gpr
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %7:gpr
  $x11 = COPY %10:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %11:gpr = COPY $x10
  SW %11:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  %13:gpr = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
  $x10 = COPY %13:gpr
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Early Machine Loop Invariant Code Motion:
# Machine code for function gcd: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10 in %0, $x11 in %1

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11
  %1:gpr = COPY $x11
  %0:gpr = COPY $x10
  %3:gpr = COPY %1:gpr
  %2:gpr = COPY %0:gpr
  SW %0:gpr, %stack.1, 0 :: (store 4 into %ir.4)
  SW %1:gpr, %stack.2, 0 :: (store 4 into %ir.5)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  %5:gpr = COPY $x0
  BNE killed %4:gpr, %5:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %12:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %12:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %6:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  %7:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  $x10 = COPY %6:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %8:gpr = COPY $x10
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %9:gpr = COPY $x10
  %10:gpr = SUBW %6:gpr, %9:gpr
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %7:gpr
  $x11 = COPY %10:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %11:gpr = COPY $x10
  SW %11:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  %13:gpr = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
  $x10 = COPY %13:gpr
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Machine Common Subexpression Elimination:
# Machine code for function gcd: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10 in %0, $x11 in %1

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11
  %1:gpr = COPY $x11
  %0:gpr = COPY $x10
  %3:gpr = COPY %1:gpr
  %2:gpr = COPY %0:gpr
  SW %0:gpr, %stack.1, 0 :: (store 4 into %ir.4)
  SW %1:gpr, %stack.2, 0 :: (store 4 into %ir.5)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  %5:gpr = COPY $x0
  BNE killed %4:gpr, %5:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %12:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %12:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %6:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  %7:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  $x10 = COPY %6:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %8:gpr = COPY $x10
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %9:gpr = COPY $x10
  %10:gpr = SUBW %6:gpr, %9:gpr
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %7:gpr
  $x11 = COPY %10:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %11:gpr = COPY $x10
  SW %11:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  %13:gpr = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
  $x10 = COPY %13:gpr
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Machine code sinking:
# Machine code for function gcd: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10 in %0, $x11 in %1

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11
  %1:gpr = COPY $x11
  %0:gpr = COPY $x10
  %3:gpr = COPY %1:gpr
  %2:gpr = COPY %0:gpr
  SW %0:gpr, %stack.1, 0 :: (store 4 into %ir.4)
  SW %1:gpr, %stack.2, 0 :: (store 4 into %ir.5)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  %5:gpr = COPY $x0
  BNE killed %4:gpr, %5:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %12:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %12:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %6:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  %7:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  $x10 = COPY %6:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %8:gpr = COPY $x10
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %9:gpr = COPY $x10
  %10:gpr = SUBW %6:gpr, %9:gpr
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %7:gpr
  $x11 = COPY %10:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %11:gpr = COPY $x10
  SW %11:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  %13:gpr = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
  $x10 = COPY %13:gpr
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Peephole Optimizations:
# Machine code for function gcd: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10 in %0, $x11 in %1

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11
  %1:gpr = COPY $x11
  %0:gpr = COPY $x10
  %3:gpr = COPY %1:gpr
  %2:gpr = COPY %0:gpr
  SW %0:gpr, %stack.1, 0 :: (store 4 into %ir.4)
  SW %1:gpr, %stack.2, 0 :: (store 4 into %ir.5)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  %5:gpr = COPY $x0
  BNE killed %4:gpr, %5:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %12:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %12:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %6:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  %7:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  $x10 = COPY %6:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %8:gpr = COPY $x10
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %9:gpr = COPY $x10
  %10:gpr = SUBW %6:gpr, %9:gpr
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %7:gpr
  $x11 = COPY %10:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %11:gpr = COPY $x10
  SW %11:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  %13:gpr = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
  $x10 = COPY %13:gpr
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Remove dead machine instructions:
# Machine code for function gcd: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10 in %0, $x11 in %1

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11
  %1:gpr = COPY $x11
  %0:gpr = COPY $x10
  %3:gpr = COPY %1:gpr
  %2:gpr = COPY %0:gpr
  SW %0:gpr, %stack.1, 0 :: (store 4 into %ir.4)
  SW %1:gpr, %stack.2, 0 :: (store 4 into %ir.5)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  %5:gpr = COPY $x0
  BNE killed %4:gpr, %5:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %12:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %12:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %6:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  %7:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  $x10 = COPY %6:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %8:gpr = COPY $x10
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %9:gpr = COPY $x10
  %10:gpr = SUBW %6:gpr, %9:gpr
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %7:gpr
  $x11 = COPY %10:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %11:gpr = COPY $x10
  SW %11:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  %13:gpr = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
  $x10 = COPY %13:gpr
  PseudoRET implicit $x10

# End machine code for function gcd.

# After RISCV Merge Base Offset:
# Machine code for function gcd: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10 in %0, $x11 in %1

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11
  %1:gpr = COPY $x11
  %0:gpr = COPY $x10
  %3:gpr = COPY %1:gpr
  %2:gpr = COPY %0:gpr
  SW %0:gpr, %stack.1, 0 :: (store 4 into %ir.4)
  SW %1:gpr, %stack.2, 0 :: (store 4 into %ir.5)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  %5:gpr = COPY $x0
  BNE killed %4:gpr, %5:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %12:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %12:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %6:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  %7:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  $x10 = COPY %6:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %8:gpr = COPY $x10
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %9:gpr = COPY $x10
  %10:gpr = SUBW %6:gpr, %9:gpr
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %7:gpr
  $x11 = COPY %10:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %11:gpr = COPY $x10
  SW %11:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  %13:gpr = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
  $x10 = COPY %13:gpr
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Detect Dead Lanes:
# Machine code for function gcd: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10 in %0, $x11 in %1

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11
  %1:gpr = COPY $x11
  %0:gpr = COPY $x10
  %3:gpr = COPY %1:gpr
  %2:gpr = COPY %0:gpr
  SW %0:gpr, %stack.1, 0 :: (store 4 into %ir.4)
  SW %1:gpr, %stack.2, 0 :: (store 4 into %ir.5)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  %5:gpr = COPY $x0
  BNE killed %4:gpr, %5:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %12:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %12:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %6:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  %7:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  $x10 = COPY %6:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %8:gpr = COPY $x10
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %9:gpr = COPY $x10
  %10:gpr = SUBW %6:gpr, %9:gpr
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %7:gpr
  $x11 = COPY %10:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %11:gpr = COPY $x10
  SW %11:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  %13:gpr = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
  $x10 = COPY %13:gpr
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Process Implicit Definitions:
# Machine code for function gcd: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10 in %0, $x11 in %1

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11
  %1:gpr = COPY $x11
  %0:gpr = COPY $x10
  %3:gpr = COPY %1:gpr
  %2:gpr = COPY %0:gpr
  SW %0:gpr, %stack.1, 0 :: (store 4 into %ir.4)
  SW %1:gpr, %stack.2, 0 :: (store 4 into %ir.5)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  %5:gpr = COPY $x0
  BNE killed %4:gpr, %5:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %12:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %12:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %6:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  %7:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  $x10 = COPY %6:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %8:gpr = COPY $x10
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %9:gpr = COPY $x10
  %10:gpr = SUBW %6:gpr, %9:gpr
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %7:gpr
  $x11 = COPY %10:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %11:gpr = COPY $x10
  SW %11:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  %13:gpr = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
  $x10 = COPY %13:gpr
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Live Variable Analysis:
# Machine code for function gcd: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10 in %0, $x11 in %1

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11
  %1:gpr = COPY killed $x11
  %0:gpr = COPY killed $x10
  dead %3:gpr = COPY %1:gpr
  dead %2:gpr = COPY %0:gpr
  SW killed %0:gpr, %stack.1, 0 :: (store 4 into %ir.4)
  SW killed %1:gpr, %stack.2, 0 :: (store 4 into %ir.5)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  %5:gpr = COPY $x0
  BNE killed %4:gpr, killed %5:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %12:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %12:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %6:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  %7:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  $x10 = COPY %6:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit killed $x10, implicit killed $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %8:gpr = COPY killed $x10
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY killed %8:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit killed $x10, implicit killed $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %9:gpr = COPY killed $x10
  %10:gpr = SUBW killed %6:gpr, killed %9:gpr
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY killed %7:gpr
  $x11 = COPY killed %10:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit killed $x10, implicit killed $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %11:gpr = COPY killed $x10
  SW killed %11:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  %13:gpr = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
  $x10 = COPY killed %13:gpr
  PseudoRET implicit killed $x10

# End machine code for function gcd.

# After Machine Natural Loop Construction:
# Machine code for function gcd: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10 in %0, $x11 in %1

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11
  %1:gpr = COPY killed $x11
  %0:gpr = COPY killed $x10
  dead %3:gpr = COPY %1:gpr
  dead %2:gpr = COPY %0:gpr
  SW killed %0:gpr, %stack.1, 0 :: (store 4 into %ir.4)
  SW killed %1:gpr, %stack.2, 0 :: (store 4 into %ir.5)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  %5:gpr = COPY $x0
  BNE killed %4:gpr, killed %5:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %12:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %12:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %6:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  %7:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  $x10 = COPY %6:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit killed $x10, implicit killed $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %8:gpr = COPY killed $x10
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY killed %8:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit killed $x10, implicit killed $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %9:gpr = COPY killed $x10
  %10:gpr = SUBW killed %6:gpr, killed %9:gpr
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY killed %7:gpr
  $x11 = COPY killed %10:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit killed $x10, implicit killed $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %11:gpr = COPY killed $x10
  SW killed %11:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  %13:gpr = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
  $x10 = COPY killed %13:gpr
  PseudoRET implicit killed $x10

# End machine code for function gcd.

# After Eliminate PHI nodes for register allocation:
# Machine code for function gcd: NoPHIs, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10 in %0, $x11 in %1

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11
  %1:gpr = COPY killed $x11
  %0:gpr = COPY killed $x10
  dead %3:gpr = COPY %1:gpr
  dead %2:gpr = COPY %0:gpr
  SW killed %0:gpr, %stack.1, 0 :: (store 4 into %ir.4)
  SW killed %1:gpr, %stack.2, 0 :: (store 4 into %ir.5)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  %5:gpr = COPY $x0
  BNE killed %4:gpr, killed %5:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %12:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %12:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %6:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  %7:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  $x10 = COPY %6:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit killed $x10, implicit killed $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %8:gpr = COPY killed $x10
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY killed %8:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit killed $x10, implicit killed $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %9:gpr = COPY killed $x10
  %10:gpr = SUBW killed %6:gpr, killed %9:gpr
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY killed %7:gpr
  $x11 = COPY killed %10:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit killed $x10, implicit killed $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %11:gpr = COPY killed $x10
  SW killed %11:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  %13:gpr = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
  $x10 = COPY killed %13:gpr
  PseudoRET implicit killed $x10

# End machine code for function gcd.

# After Two-Address instruction pass:
# Machine code for function gcd: NoPHIs, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10 in %0, $x11 in %1

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11
  %1:gpr = COPY killed $x11
  %0:gpr = COPY killed $x10
  dead %3:gpr = COPY %1:gpr
  dead %2:gpr = COPY %0:gpr
  SW killed %0:gpr, %stack.1, 0 :: (store 4 into %ir.4)
  SW killed %1:gpr, %stack.2, 0 :: (store 4 into %ir.5)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  %5:gpr = COPY $x0
  BNE killed %4:gpr, killed %5:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %12:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %12:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  %6:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  %7:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  $x10 = COPY %6:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit killed $x10, implicit killed $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %8:gpr = COPY killed $x10
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY killed %8:gpr
  $x11 = COPY %7:gpr
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit killed $x10, implicit killed $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %9:gpr = COPY killed $x10
  %10:gpr = SUBW killed %6:gpr, killed %9:gpr
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY killed %7:gpr
  $x11 = COPY killed %10:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit killed $x10, implicit killed $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %11:gpr = COPY killed $x10
  SW killed %11:gpr, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  %13:gpr = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
  $x10 = COPY killed %13:gpr
  PseudoRET implicit killed $x10

# End machine code for function gcd.

# After Simple Register Coalescing:
# Machine code for function gcd: NoPHIs, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10 in %0, $x11 in %1

0B	bb.0 (%ir-block.2):
	  successors: %bb.1, %bb.2
	  liveins: $x10, $x11
16B	  %1:gpr = COPY $x11
32B	  %0:gpr = COPY $x10
80B	  SW %0:gpr, %stack.1, 0 :: (store 4 into %ir.4)
96B	  SW %1:gpr, %stack.2, 0 :: (store 4 into %ir.5)
112B	  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
144B	  BNE %4:gpr, $x0, %bb.2
160B	  PseudoBR %bb.1

176B	bb.1 (%ir-block.8):
	; predecessors: %bb.0
	  successors: %bb.3(0x80000000); %bb.3(100.00%)

192B	  %12:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
208B	  SW %12:gpr, %stack.0, 0 :: (store 4 into %ir.3)
224B	  PseudoBR %bb.3

240B	bb.2 (%ir-block.10):
	; predecessors: %bb.0
	  successors: %bb.3(0x80000000); %bb.3(100.00%)

256B	  %6:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
272B	  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
288B	  %7:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
304B	  $x10 = COPY %6:gpr
320B	  $x11 = COPY %7:gpr
336B	  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
352B	  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
368B	  %8:gpr = COPY $x10
384B	  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
400B	  $x10 = COPY %8:gpr
416B	  $x11 = COPY %7:gpr
432B	  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
448B	  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
464B	  %9:gpr = COPY $x10
480B	  %10:gpr = SUBW %6:gpr, %9:gpr
496B	  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
512B	  $x10 = COPY %7:gpr
528B	  $x11 = COPY %10:gpr
544B	  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
560B	  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
576B	  %11:gpr = COPY $x10
592B	  SW %11:gpr, %stack.0, 0 :: (store 4 into %ir.3)
608B	  PseudoBR %bb.3

624B	bb.3 (%ir-block.20):
	; predecessors: %bb.2, %bb.1

640B	  %13:gpr = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
656B	  $x10 = COPY %13:gpr
672B	  PseudoRET implicit $x10

# End machine code for function gcd.

# After Rename Disconnected Subregister Components:
# Machine code for function gcd: NoPHIs, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10 in %0, $x11 in %1

0B	bb.0 (%ir-block.2):
	  successors: %bb.1, %bb.2
	  liveins: $x10, $x11
16B	  %1:gpr = COPY $x11
32B	  %0:gpr = COPY $x10
80B	  SW %0:gpr, %stack.1, 0 :: (store 4 into %ir.4)
96B	  SW %1:gpr, %stack.2, 0 :: (store 4 into %ir.5)
112B	  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
144B	  BNE %4:gpr, $x0, %bb.2
160B	  PseudoBR %bb.1

176B	bb.1 (%ir-block.8):
	; predecessors: %bb.0
	  successors: %bb.3(0x80000000); %bb.3(100.00%)

192B	  %12:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
208B	  SW %12:gpr, %stack.0, 0 :: (store 4 into %ir.3)
224B	  PseudoBR %bb.3

240B	bb.2 (%ir-block.10):
	; predecessors: %bb.0
	  successors: %bb.3(0x80000000); %bb.3(100.00%)

256B	  %6:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
272B	  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
288B	  %7:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
304B	  $x10 = COPY %6:gpr
320B	  $x11 = COPY %7:gpr
336B	  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
352B	  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
368B	  %8:gpr = COPY $x10
384B	  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
400B	  $x10 = COPY %8:gpr
416B	  $x11 = COPY %7:gpr
432B	  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
448B	  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
464B	  %9:gpr = COPY $x10
480B	  %10:gpr = SUBW %6:gpr, %9:gpr
496B	  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
512B	  $x10 = COPY %7:gpr
528B	  $x11 = COPY %10:gpr
544B	  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
560B	  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
576B	  %11:gpr = COPY $x10
592B	  SW %11:gpr, %stack.0, 0 :: (store 4 into %ir.3)
608B	  PseudoBR %bb.3

624B	bb.3 (%ir-block.20):
	; predecessors: %bb.2, %bb.1

640B	  %13:gpr = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
656B	  $x10 = COPY %13:gpr
672B	  PseudoRET implicit $x10

# End machine code for function gcd.

# After Machine Instruction Scheduler:
# Machine code for function gcd: NoPHIs, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10 in %0, $x11 in %1

0B	bb.0 (%ir-block.2):
	  successors: %bb.1, %bb.2
	  liveins: $x10, $x11
16B	  %1:gpr = COPY $x11
32B	  %0:gpr = COPY $x10
80B	  SW %0:gpr, %stack.1, 0 :: (store 4 into %ir.4)
96B	  SW %1:gpr, %stack.2, 0 :: (store 4 into %ir.5)
112B	  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
144B	  BNE %4:gpr, $x0, %bb.2
160B	  PseudoBR %bb.1

176B	bb.1 (%ir-block.8):
	; predecessors: %bb.0
	  successors: %bb.3(0x80000000); %bb.3(100.00%)

192B	  %12:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
208B	  SW %12:gpr, %stack.0, 0 :: (store 4 into %ir.3)
224B	  PseudoBR %bb.3

240B	bb.2 (%ir-block.10):
	; predecessors: %bb.0
	  successors: %bb.3(0x80000000); %bb.3(100.00%)

256B	  %6:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
272B	  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
288B	  %7:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
304B	  $x10 = COPY %6:gpr
320B	  $x11 = COPY %7:gpr
336B	  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
352B	  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
368B	  %8:gpr = COPY $x10
384B	  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
400B	  $x10 = COPY %8:gpr
416B	  $x11 = COPY %7:gpr
432B	  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
448B	  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
464B	  %9:gpr = COPY $x10
480B	  %10:gpr = SUBW %6:gpr, %9:gpr
496B	  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
512B	  $x10 = COPY %7:gpr
528B	  $x11 = COPY %10:gpr
544B	  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
560B	  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
576B	  %11:gpr = COPY $x10
592B	  SW %11:gpr, %stack.0, 0 :: (store 4 into %ir.3)
608B	  PseudoBR %bb.3

624B	bb.3 (%ir-block.20):
	; predecessors: %bb.2, %bb.1

640B	  %13:gpr = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
656B	  $x10 = COPY %13:gpr
672B	  PseudoRET implicit $x10

# End machine code for function gcd.

# After Greedy Register Allocator:
# Machine code for function gcd: NoPHIs, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10 in %0, $x11 in %1

0B	bb.0 (%ir-block.2):
	  successors: %bb.1, %bb.2
	  liveins: $x10, $x11
16B	  %1:gpr = COPY $x11
32B	  %0:gpr = COPY $x10
80B	  SW %0:gpr, %stack.1, 0 :: (store 4 into %ir.4)
96B	  SW %1:gpr, %stack.2, 0 :: (store 4 into %ir.5)
112B	  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
144B	  BNE %4:gpr, $x0, %bb.2
160B	  PseudoBR %bb.1

176B	bb.1 (%ir-block.8):
	; predecessors: %bb.0
	  successors: %bb.3(0x80000000); %bb.3(100.00%)

192B	  %12:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
208B	  SW %12:gpr, %stack.0, 0 :: (store 4 into %ir.3)
224B	  PseudoBR %bb.3

240B	bb.2 (%ir-block.10):
	; predecessors: %bb.0
	  successors: %bb.3(0x80000000); %bb.3(100.00%)

256B	  %6:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
272B	  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
288B	  %7:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
304B	  $x10 = COPY %6:gpr
320B	  $x11 = COPY %7:gpr
336B	  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
352B	  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
368B	  %8:gpr = COPY $x10
384B	  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
400B	  $x10 = COPY %8:gpr
416B	  $x11 = COPY %7:gpr
432B	  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
448B	  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
464B	  %9:gpr = COPY $x10
480B	  %10:gpr = SUBW %6:gpr, %9:gpr
496B	  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
512B	  $x10 = COPY %7:gpr
528B	  $x11 = COPY %10:gpr
544B	  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
560B	  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
576B	  %11:gpr = COPY $x10
592B	  SW %11:gpr, %stack.0, 0 :: (store 4 into %ir.3)
608B	  PseudoBR %bb.3

624B	bb.3 (%ir-block.20):
	; predecessors: %bb.2, %bb.1

640B	  %13:gpr = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
656B	  $x10 = COPY %13:gpr
672B	  PseudoRET implicit $x10

# End machine code for function gcd.

# After Virtual Register Rewriter:
# Machine code for function gcd: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10, $x11

0B	bb.0 (%ir-block.2):
	  successors: %bb.1, %bb.2
	  liveins: $x10, $x11
80B	  SW killed renamable $x10, %stack.1, 0 :: (store 4 into %ir.4)
96B	  SW killed renamable $x11, %stack.2, 0 :: (store 4 into %ir.5)
112B	  renamable $x10 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
144B	  BNE killed renamable $x10, $x0, %bb.2
160B	  PseudoBR %bb.1

176B	bb.1 (%ir-block.8):
	; predecessors: %bb.0
	  successors: %bb.3(0x80000000); %bb.3(100.00%)

192B	  renamable $x10 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
208B	  SW killed renamable $x10, %stack.0, 0 :: (store 4 into %ir.3)
224B	  PseudoBR %bb.3

240B	bb.2 (%ir-block.10):
	; predecessors: %bb.0
	  successors: %bb.3(0x80000000); %bb.3(100.00%)

256B	  renamable $x18 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
272B	  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
288B	  renamable $x9 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
304B	  $x10 = COPY renamable $x18
320B	  $x11 = COPY renamable $x9
336B	  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
352B	  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
384B	  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
416B	  $x11 = COPY renamable $x9
432B	  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
448B	  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
480B	  renamable $x11 = SUBW killed renamable $x18, killed renamable $x10
496B	  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
512B	  $x10 = COPY killed renamable $x9
544B	  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
560B	  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
592B	  SW killed renamable $x10, %stack.0, 0 :: (store 4 into %ir.3)
608B	  PseudoBR %bb.3

624B	bb.3 (%ir-block.20):
	; predecessors: %bb.2, %bb.1

640B	  renamable $x10 = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
672B	  PseudoRET implicit $x10

# End machine code for function gcd.

# After Stack Slot Coloring:
# Machine code for function gcd: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10, $x11

0B	bb.0 (%ir-block.2):
	  successors: %bb.1, %bb.2
	  liveins: $x10, $x11
80B	  SW killed renamable $x10, %stack.1, 0 :: (store 4 into %ir.4)
96B	  SW killed renamable $x11, %stack.2, 0 :: (store 4 into %ir.5)
112B	  renamable $x10 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
144B	  BNE killed renamable $x10, $x0, %bb.2
160B	  PseudoBR %bb.1

176B	bb.1 (%ir-block.8):
	; predecessors: %bb.0
	  successors: %bb.3(0x80000000); %bb.3(100.00%)

192B	  renamable $x10 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
208B	  SW killed renamable $x10, %stack.0, 0 :: (store 4 into %ir.3)
224B	  PseudoBR %bb.3

240B	bb.2 (%ir-block.10):
	; predecessors: %bb.0
	  successors: %bb.3(0x80000000); %bb.3(100.00%)

256B	  renamable $x18 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
272B	  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
288B	  renamable $x9 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
304B	  $x10 = COPY renamable $x18
320B	  $x11 = COPY renamable $x9
336B	  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
352B	  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
384B	  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
416B	  $x11 = COPY renamable $x9
432B	  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
448B	  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
480B	  renamable $x11 = SUBW killed renamable $x18, killed renamable $x10
496B	  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
512B	  $x10 = COPY killed renamable $x9
544B	  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
560B	  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
592B	  SW killed renamable $x10, %stack.0, 0 :: (store 4 into %ir.3)
608B	  PseudoBR %bb.3

624B	bb.3 (%ir-block.20):
	; predecessors: %bb.2, %bb.1

640B	  renamable $x10 = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
672B	  PseudoRET implicit $x10

# End machine code for function gcd.

# After Machine Copy Propagation Pass:
# Machine code for function gcd: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10, $x11

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11
  SW killed renamable $x10, %stack.1, 0 :: (store 4 into %ir.4)
  SW killed renamable $x11, %stack.2, 0 :: (store 4 into %ir.5)
  renamable $x10 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  BNE killed renamable $x10, $x0, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x10 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x18 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  renamable $x9 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  $x10 = COPY renamable $x18
  $x11 = COPY renamable $x9
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x11 = COPY renamable $x9
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  renamable $x11 = SUBW killed renamable $x18, killed renamable $x10
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY killed renamable $x9
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  SW killed renamable $x10, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  renamable $x10 = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Machine Loop Invariant Code Motion:
# Machine code for function gcd: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10, $x11

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11
  SW killed renamable $x10, %stack.1, 0 :: (store 4 into %ir.4)
  SW killed renamable $x11, %stack.2, 0 :: (store 4 into %ir.5)
  renamable $x10 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  BNE killed renamable $x10, $x0, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x10 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x18 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  renamable $x9 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  $x10 = COPY renamable $x18
  $x11 = COPY renamable $x9
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x11 = COPY renamable $x9
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  renamable $x11 = SUBW killed renamable $x18, killed renamable $x10
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY killed renamable $x9
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  SW killed renamable $x10, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  renamable $x10 = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
  PseudoRET implicit $x10

# End machine code for function gcd.

# After PostRA Machine Sink:
# Machine code for function gcd: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10, $x11

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11
  SW killed renamable $x10, %stack.1, 0 :: (store 4 into %ir.4)
  SW killed renamable $x11, %stack.2, 0 :: (store 4 into %ir.5)
  renamable $x10 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  BNE killed renamable $x10, $x0, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x10 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x18 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  renamable $x9 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  $x10 = COPY renamable $x18
  $x11 = COPY renamable $x9
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x11 = COPY renamable $x9
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  renamable $x11 = SUBW killed renamable $x18, killed renamable $x10
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY killed renamable $x9
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  SW killed renamable $x10, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  renamable $x10 = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Shrink Wrapping analysis:
# Machine code for function gcd: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
Function Live Ins: $x10, $x11

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11
  SW killed renamable $x10, %stack.1, 0 :: (store 4 into %ir.4)
  SW killed renamable $x11, %stack.2, 0 :: (store 4 into %ir.5)
  renamable $x10 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  BNE killed renamable $x10, $x0, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x10 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x18 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.4)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  renamable $x9 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.5)
  $x10 = COPY renamable $x18
  $x11 = COPY renamable $x9
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x11 = COPY renamable $x9
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  renamable $x11 = SUBW killed renamable $x18, killed renamable $x10
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY killed renamable $x9
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  SW killed renamable $x10, %stack.0, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  renamable $x10 = LW %stack.0, 0 :: (dereferenceable load 4 from %ir.3)
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Prologue/Epilogue Insertion & Frame Finalization:
# Machine code for function gcd: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-36]
  fi#1: size=4, align=4, at location [SP-40]
  fi#2: size=4, align=4, at location [SP-44]
  fi#3: size=8, align=8, at location [SP-8]
  fi#4: size=8, align=8, at location [SP-16]
  fi#5: size=8, align=8, at location [SP-24]
  fi#6: size=8, align=8, at location [SP-32]
Function Live Ins: $x10, $x11

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11, $x9, $x18
  $x2 = frame-setup ADDI $x2, -48
  SD killed $x1, $x2, 40
  SD killed $x8, $x2, 32
  SD killed $x9, $x2, 24
  SD killed $x18, $x2, 16
  $x8 = frame-setup ADDI $x2, 48
  SW killed renamable $x10, $x8, -40 :: (store 4 into %ir.4)
  SW killed renamable $x11, $x8, -44 :: (store 4 into %ir.5)
  renamable $x10 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  BNE killed renamable $x10, $x0, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x10 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x18 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  renamable $x9 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  $x10 = COPY renamable $x18
  $x11 = COPY renamable $x9
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x11 = COPY renamable $x9
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  renamable $x11 = SUBW killed renamable $x18, killed renamable $x10
  $x10 = COPY killed renamable $x9
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  renamable $x10 = LW $x8, -36 :: (dereferenceable load 4 from %ir.3)
  $x18 = LD $x2, 16
  $x9 = LD $x2, 24
  $x8 = LD $x2, 32
  $x1 = LD $x2, 40
  $x2 = frame-destroy ADDI $x2, 48
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Control Flow Optimizer:
# Machine code for function gcd: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-36]
  fi#1: size=4, align=4, at location [SP-40]
  fi#2: size=4, align=4, at location [SP-44]
  fi#3: size=8, align=8, at location [SP-8]
  fi#4: size=8, align=8, at location [SP-16]
  fi#5: size=8, align=8, at location [SP-24]
  fi#6: size=8, align=8, at location [SP-32]
Function Live Ins: $x10, $x11

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11, $x9, $x18
  $x2 = frame-setup ADDI $x2, -48
  SD killed $x1, $x2, 40
  SD killed $x8, $x2, 32
  SD killed $x9, $x2, 24
  SD killed $x18, $x2, 16
  $x8 = frame-setup ADDI $x2, 48
  SW killed renamable $x10, $x8, -40 :: (store 4 into %ir.4)
  SW killed renamable $x11, $x8, -44 :: (store 4 into %ir.5)
  renamable $x10 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  BNE killed renamable $x10, $x0, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x10 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x18 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  renamable $x9 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  $x10 = COPY renamable $x18
  $x11 = COPY renamable $x9
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x11 = COPY renamable $x9
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  renamable $x11 = SUBW killed renamable $x18, killed renamable $x10
  $x10 = COPY killed renamable $x9
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  renamable $x10 = LW $x8, -36 :: (dereferenceable load 4 from %ir.3)
  $x18 = LD $x2, 16
  $x9 = LD $x2, 24
  $x8 = LD $x2, 32
  $x1 = LD $x2, 40
  $x2 = frame-destroy ADDI $x2, 48
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Tail Duplication:
# Machine code for function gcd: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-36]
  fi#1: size=4, align=4, at location [SP-40]
  fi#2: size=4, align=4, at location [SP-44]
  fi#3: size=8, align=8, at location [SP-8]
  fi#4: size=8, align=8, at location [SP-16]
  fi#5: size=8, align=8, at location [SP-24]
  fi#6: size=8, align=8, at location [SP-32]
Function Live Ins: $x10, $x11

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11, $x9, $x18
  $x2 = frame-setup ADDI $x2, -48
  SD killed $x1, $x2, 40
  SD killed $x8, $x2, 32
  SD killed $x9, $x2, 24
  SD killed $x18, $x2, 16
  $x8 = frame-setup ADDI $x2, 48
  SW killed renamable $x10, $x8, -40 :: (store 4 into %ir.4)
  SW killed renamable $x11, $x8, -44 :: (store 4 into %ir.5)
  renamable $x10 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  BNE killed renamable $x10, $x0, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x10 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x18 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  renamable $x9 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  $x10 = COPY renamable $x18
  $x11 = COPY renamable $x9
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x11 = COPY renamable $x9
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  renamable $x11 = SUBW killed renamable $x18, killed renamable $x10
  $x10 = COPY killed renamable $x9
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  renamable $x10 = LW $x8, -36 :: (dereferenceable load 4 from %ir.3)
  $x18 = LD $x2, 16
  $x9 = LD $x2, 24
  $x8 = LD $x2, 32
  $x1 = LD $x2, 40
  $x2 = frame-destroy ADDI $x2, 48
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Machine Copy Propagation Pass:
# Machine code for function gcd: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-36]
  fi#1: size=4, align=4, at location [SP-40]
  fi#2: size=4, align=4, at location [SP-44]
  fi#3: size=8, align=8, at location [SP-8]
  fi#4: size=8, align=8, at location [SP-16]
  fi#5: size=8, align=8, at location [SP-24]
  fi#6: size=8, align=8, at location [SP-32]
Function Live Ins: $x10, $x11

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11, $x9, $x18
  $x2 = frame-setup ADDI $x2, -48
  SD killed $x1, $x2, 40
  SD killed $x8, $x2, 32
  SD killed $x9, $x2, 24
  SD killed $x18, $x2, 16
  $x8 = frame-setup ADDI $x2, 48
  SW killed renamable $x10, $x8, -40 :: (store 4 into %ir.4)
  SW killed renamable $x11, $x8, -44 :: (store 4 into %ir.5)
  renamable $x10 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  BNE killed renamable $x10, $x0, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x10 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x18 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  renamable $x9 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  $x10 = COPY renamable $x18
  $x11 = COPY renamable $x9
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x11 = COPY renamable $x9
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  renamable $x11 = SUBW killed renamable $x18, killed renamable $x10
  $x10 = COPY killed renamable $x9
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  renamable $x10 = LW $x8, -36 :: (dereferenceable load 4 from %ir.3)
  $x18 = LD $x2, 16
  $x9 = LD $x2, 24
  $x8 = LD $x2, 32
  $x1 = LD $x2, 40
  $x2 = frame-destroy ADDI $x2, 48
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Post-RA pseudo instruction expansion pass:
# Machine code for function gcd: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-36]
  fi#1: size=4, align=4, at location [SP-40]
  fi#2: size=4, align=4, at location [SP-44]
  fi#3: size=8, align=8, at location [SP-8]
  fi#4: size=8, align=8, at location [SP-16]
  fi#5: size=8, align=8, at location [SP-24]
  fi#6: size=8, align=8, at location [SP-32]
Function Live Ins: $x10, $x11

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11, $x9, $x18
  $x2 = frame-setup ADDI $x2, -48
  SD killed $x1, $x2, 40
  SD killed $x8, $x2, 32
  SD killed $x9, $x2, 24
  SD killed $x18, $x2, 16
  $x8 = frame-setup ADDI $x2, 48
  SW killed renamable $x10, $x8, -40 :: (store 4 into %ir.4)
  SW killed renamable $x11, $x8, -44 :: (store 4 into %ir.5)
  renamable $x10 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  BNE killed renamable $x10, $x0, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x10 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x18 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  renamable $x9 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  $x10 = ADDI $x18, 0
  $x11 = ADDI $x9, 0
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x11 = ADDI $x9, 0
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  renamable $x11 = SUBW killed renamable $x18, killed renamable $x10
  $x10 = ADDI killed $x9, 0
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  renamable $x10 = LW $x8, -36 :: (dereferenceable load 4 from %ir.3)
  $x18 = LD $x2, 16
  $x9 = LD $x2, 24
  $x8 = LD $x2, 32
  $x1 = LD $x2, 40
  $x2 = frame-destroy ADDI $x2, 48
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Post RA top-down list latency scheduler:
# Machine code for function gcd: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-36]
  fi#1: size=4, align=4, at location [SP-40]
  fi#2: size=4, align=4, at location [SP-44]
  fi#3: size=8, align=8, at location [SP-8]
  fi#4: size=8, align=8, at location [SP-16]
  fi#5: size=8, align=8, at location [SP-24]
  fi#6: size=8, align=8, at location [SP-32]
Function Live Ins: $x10, $x11

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11, $x9, $x18
  $x2 = frame-setup ADDI $x2, -48
  SD killed $x1, $x2, 40
  SD killed $x8, $x2, 32
  SD killed $x9, $x2, 24
  SD killed $x18, $x2, 16
  $x8 = frame-setup ADDI $x2, 48
  SW killed renamable $x10, $x8, -40 :: (store 4 into %ir.4)
  SW killed renamable $x11, $x8, -44 :: (store 4 into %ir.5)
  renamable $x10 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  BNE killed renamable $x10, $x0, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x10 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x18 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  renamable $x9 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  $x10 = ADDI $x18, 0
  $x11 = ADDI $x9, 0
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x11 = ADDI $x9, 0
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  renamable $x11 = SUBW killed renamable $x18, killed renamable $x10
  $x10 = ADDI killed $x9, 0
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  renamable $x10 = LW $x8, -36 :: (dereferenceable load 4 from %ir.3)
  $x18 = LD $x2, 16
  $x9 = LD $x2, 24
  $x8 = LD $x2, 32
  $x1 = LD $x2, 40
  $x2 = frame-destroy ADDI $x2, 48
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Analyze Machine Code For Garbage Collection:
# Machine code for function gcd: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-36]
  fi#1: size=4, align=4, at location [SP-40]
  fi#2: size=4, align=4, at location [SP-44]
  fi#3: size=8, align=8, at location [SP-8]
  fi#4: size=8, align=8, at location [SP-16]
  fi#5: size=8, align=8, at location [SP-24]
  fi#6: size=8, align=8, at location [SP-32]
Function Live Ins: $x10, $x11

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11, $x9, $x18
  $x2 = frame-setup ADDI $x2, -48
  SD killed $x1, $x2, 40
  SD killed $x8, $x2, 32
  SD killed $x9, $x2, 24
  SD killed $x18, $x2, 16
  $x8 = frame-setup ADDI $x2, 48
  SW killed renamable $x10, $x8, -40 :: (store 4 into %ir.4)
  SW killed renamable $x11, $x8, -44 :: (store 4 into %ir.5)
  renamable $x10 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  BNE killed renamable $x10, $x0, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x10 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x18 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  renamable $x9 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  $x10 = ADDI $x18, 0
  $x11 = ADDI $x9, 0
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x11 = ADDI $x9, 0
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  renamable $x11 = SUBW killed renamable $x18, killed renamable $x10
  $x10 = ADDI killed $x9, 0
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  renamable $x10 = LW $x8, -36 :: (dereferenceable load 4 from %ir.3)
  $x18 = LD $x2, 16
  $x9 = LD $x2, 24
  $x8 = LD $x2, 32
  $x1 = LD $x2, 40
  $x2 = frame-destroy ADDI $x2, 48
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Branch Probability Basic Block Placement:
# Machine code for function gcd: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-36]
  fi#1: size=4, align=4, at location [SP-40]
  fi#2: size=4, align=4, at location [SP-44]
  fi#3: size=8, align=8, at location [SP-8]
  fi#4: size=8, align=8, at location [SP-16]
  fi#5: size=8, align=8, at location [SP-24]
  fi#6: size=8, align=8, at location [SP-32]
Function Live Ins: $x10, $x11

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11, $x9, $x18
  $x2 = frame-setup ADDI $x2, -48
  SD killed $x1, $x2, 40
  SD killed $x8, $x2, 32
  SD killed $x9, $x2, 24
  SD killed $x18, $x2, 16
  $x8 = frame-setup ADDI $x2, 48
  SW killed renamable $x10, $x8, -40 :: (store 4 into %ir.4)
  SW killed renamable $x11, $x8, -44 :: (store 4 into %ir.5)
  renamable $x10 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  BNE killed renamable $x10, $x0, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x10 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x18 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  renamable $x9 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  $x10 = ADDI $x18, 0
  $x11 = ADDI $x9, 0
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x11 = ADDI $x9, 0
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  renamable $x11 = SUBW killed renamable $x18, killed renamable $x10
  $x10 = ADDI killed $x9, 0
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  renamable $x10 = LW $x8, -36 :: (dereferenceable load 4 from %ir.3)
  $x18 = LD $x2, 16
  $x9 = LD $x2, 24
  $x8 = LD $x2, 32
  $x1 = LD $x2, 40
  $x2 = frame-destroy ADDI $x2, 48
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Branch relaxation pass:
# Machine code for function gcd: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-36]
  fi#1: size=4, align=4, at location [SP-40]
  fi#2: size=4, align=4, at location [SP-44]
  fi#3: size=8, align=8, at location [SP-8]
  fi#4: size=8, align=8, at location [SP-16]
  fi#5: size=8, align=8, at location [SP-24]
  fi#6: size=8, align=8, at location [SP-32]
Function Live Ins: $x10, $x11

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11, $x9, $x18
  $x2 = frame-setup ADDI $x2, -48
  SD killed $x1, $x2, 40
  SD killed $x8, $x2, 32
  SD killed $x9, $x2, 24
  SD killed $x18, $x2, 16
  $x8 = frame-setup ADDI $x2, 48
  SW killed renamable $x10, $x8, -40 :: (store 4 into %ir.4)
  SW killed renamable $x11, $x8, -44 :: (store 4 into %ir.5)
  renamable $x10 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  BNE killed renamable $x10, $x0, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x10 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x18 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  renamable $x9 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  $x10 = ADDI $x18, 0
  $x11 = ADDI $x9, 0
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x11 = ADDI $x9, 0
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  renamable $x11 = SUBW killed renamable $x18, killed renamable $x10
  $x10 = ADDI killed $x9, 0
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  renamable $x10 = LW $x8, -36 :: (dereferenceable load 4 from %ir.3)
  $x18 = LD $x2, 16
  $x9 = LD $x2, 24
  $x8 = LD $x2, 32
  $x1 = LD $x2, 40
  $x2 = frame-destroy ADDI $x2, 48
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Contiguously Lay Out Funclets:
# Machine code for function gcd: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-36]
  fi#1: size=4, align=4, at location [SP-40]
  fi#2: size=4, align=4, at location [SP-44]
  fi#3: size=8, align=8, at location [SP-8]
  fi#4: size=8, align=8, at location [SP-16]
  fi#5: size=8, align=8, at location [SP-24]
  fi#6: size=8, align=8, at location [SP-32]
Function Live Ins: $x10, $x11

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11, $x9, $x18
  $x2 = frame-setup ADDI $x2, -48
  SD killed $x1, $x2, 40
  SD killed $x8, $x2, 32
  SD killed $x9, $x2, 24
  SD killed $x18, $x2, 16
  $x8 = frame-setup ADDI $x2, 48
  SW killed renamable $x10, $x8, -40 :: (store 4 into %ir.4)
  SW killed renamable $x11, $x8, -44 :: (store 4 into %ir.5)
  renamable $x10 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  BNE killed renamable $x10, $x0, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x10 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x18 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  renamable $x9 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  $x10 = ADDI $x18, 0
  $x11 = ADDI $x9, 0
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x11 = ADDI $x9, 0
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  renamable $x11 = SUBW killed renamable $x18, killed renamable $x10
  $x10 = ADDI killed $x9, 0
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  renamable $x10 = LW $x8, -36 :: (dereferenceable load 4 from %ir.3)
  $x18 = LD $x2, 16
  $x9 = LD $x2, 24
  $x8 = LD $x2, 32
  $x1 = LD $x2, 40
  $x2 = frame-destroy ADDI $x2, 48
  PseudoRET implicit $x10

# End machine code for function gcd.

# After StackMap Liveness Analysis:
# Machine code for function gcd: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-36]
  fi#1: size=4, align=4, at location [SP-40]
  fi#2: size=4, align=4, at location [SP-44]
  fi#3: size=8, align=8, at location [SP-8]
  fi#4: size=8, align=8, at location [SP-16]
  fi#5: size=8, align=8, at location [SP-24]
  fi#6: size=8, align=8, at location [SP-32]
Function Live Ins: $x10, $x11

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11, $x9, $x18
  $x2 = frame-setup ADDI $x2, -48
  SD killed $x1, $x2, 40
  SD killed $x8, $x2, 32
  SD killed $x9, $x2, 24
  SD killed $x18, $x2, 16
  $x8 = frame-setup ADDI $x2, 48
  SW killed renamable $x10, $x8, -40 :: (store 4 into %ir.4)
  SW killed renamable $x11, $x8, -44 :: (store 4 into %ir.5)
  renamable $x10 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  BNE killed renamable $x10, $x0, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x10 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x18 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  renamable $x9 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  $x10 = ADDI $x18, 0
  $x11 = ADDI $x9, 0
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x11 = ADDI $x9, 0
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  renamable $x11 = SUBW killed renamable $x18, killed renamable $x10
  $x10 = ADDI killed $x9, 0
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  renamable $x10 = LW $x8, -36 :: (dereferenceable load 4 from %ir.3)
  $x18 = LD $x2, 16
  $x9 = LD $x2, 24
  $x8 = LD $x2, 32
  $x1 = LD $x2, 40
  $x2 = frame-destroy ADDI $x2, 48
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Live DEBUG_VALUE analysis:
# Machine code for function gcd: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-36]
  fi#1: size=4, align=4, at location [SP-40]
  fi#2: size=4, align=4, at location [SP-44]
  fi#3: size=8, align=8, at location [SP-8]
  fi#4: size=8, align=8, at location [SP-16]
  fi#5: size=8, align=8, at location [SP-24]
  fi#6: size=8, align=8, at location [SP-32]
Function Live Ins: $x10, $x11

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11, $x9, $x18
  $x2 = frame-setup ADDI $x2, -48
  SD killed $x1, $x2, 40
  SD killed $x8, $x2, 32
  SD killed $x9, $x2, 24
  SD killed $x18, $x2, 16
  $x8 = frame-setup ADDI $x2, 48
  SW killed renamable $x10, $x8, -40 :: (store 4 into %ir.4)
  SW killed renamable $x11, $x8, -44 :: (store 4 into %ir.5)
  renamable $x10 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  BNE killed renamable $x10, $x0, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x10 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x18 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  renamable $x9 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  $x10 = ADDI $x18, 0
  $x11 = ADDI $x9, 0
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x11 = ADDI $x9, 0
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  renamable $x11 = SUBW killed renamable $x18, killed renamable $x10
  $x10 = ADDI killed $x9, 0
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  renamable $x10 = LW $x8, -36 :: (dereferenceable load 4 from %ir.3)
  $x18 = LD $x2, 16
  $x9 = LD $x2, 24
  $x8 = LD $x2, 32
  $x1 = LD $x2, 40
  $x2 = frame-destroy ADDI $x2, 48
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Insert fentry calls:
# Machine code for function gcd: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-36]
  fi#1: size=4, align=4, at location [SP-40]
  fi#2: size=4, align=4, at location [SP-44]
  fi#3: size=8, align=8, at location [SP-8]
  fi#4: size=8, align=8, at location [SP-16]
  fi#5: size=8, align=8, at location [SP-24]
  fi#6: size=8, align=8, at location [SP-32]
Function Live Ins: $x10, $x11

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11, $x9, $x18
  $x2 = frame-setup ADDI $x2, -48
  SD killed $x1, $x2, 40
  SD killed $x8, $x2, 32
  SD killed $x9, $x2, 24
  SD killed $x18, $x2, 16
  $x8 = frame-setup ADDI $x2, 48
  SW killed renamable $x10, $x8, -40 :: (store 4 into %ir.4)
  SW killed renamable $x11, $x8, -44 :: (store 4 into %ir.5)
  renamable $x10 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  BNE killed renamable $x10, $x0, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x10 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x18 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  renamable $x9 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  $x10 = ADDI $x18, 0
  $x11 = ADDI $x9, 0
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x11 = ADDI $x9, 0
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  renamable $x11 = SUBW killed renamable $x18, killed renamable $x10
  $x10 = ADDI killed $x9, 0
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  renamable $x10 = LW $x8, -36 :: (dereferenceable load 4 from %ir.3)
  $x18 = LD $x2, 16
  $x9 = LD $x2, 24
  $x8 = LD $x2, 32
  $x1 = LD $x2, 40
  $x2 = frame-destroy ADDI $x2, 48
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Insert XRay ops:
# Machine code for function gcd: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-36]
  fi#1: size=4, align=4, at location [SP-40]
  fi#2: size=4, align=4, at location [SP-44]
  fi#3: size=8, align=8, at location [SP-8]
  fi#4: size=8, align=8, at location [SP-16]
  fi#5: size=8, align=8, at location [SP-24]
  fi#6: size=8, align=8, at location [SP-32]
Function Live Ins: $x10, $x11

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11, $x9, $x18
  $x2 = frame-setup ADDI $x2, -48
  SD killed $x1, $x2, 40
  SD killed $x8, $x2, 32
  SD killed $x9, $x2, 24
  SD killed $x18, $x2, 16
  $x8 = frame-setup ADDI $x2, 48
  SW killed renamable $x10, $x8, -40 :: (store 4 into %ir.4)
  SW killed renamable $x11, $x8, -44 :: (store 4 into %ir.5)
  renamable $x10 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  BNE killed renamable $x10, $x0, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x10 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x18 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  renamable $x9 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  $x10 = ADDI $x18, 0
  $x11 = ADDI $x9, 0
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x11 = ADDI $x9, 0
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  renamable $x11 = SUBW killed renamable $x18, killed renamable $x10
  $x10 = ADDI killed $x9, 0
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  renamable $x10 = LW $x8, -36 :: (dereferenceable load 4 from %ir.3)
  $x18 = LD $x2, 16
  $x9 = LD $x2, 24
  $x8 = LD $x2, 32
  $x1 = LD $x2, 40
  $x2 = frame-destroy ADDI $x2, 48
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Implement the 'patchable-function' attribute:
# Machine code for function gcd: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-36]
  fi#1: size=4, align=4, at location [SP-40]
  fi#2: size=4, align=4, at location [SP-44]
  fi#3: size=8, align=8, at location [SP-8]
  fi#4: size=8, align=8, at location [SP-16]
  fi#5: size=8, align=8, at location [SP-24]
  fi#6: size=8, align=8, at location [SP-32]
Function Live Ins: $x10, $x11

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11, $x9, $x18
  $x2 = frame-setup ADDI $x2, -48
  SD killed $x1, $x2, 40
  SD killed $x8, $x2, 32
  SD killed $x9, $x2, 24
  SD killed $x18, $x2, 16
  $x8 = frame-setup ADDI $x2, 48
  SW killed renamable $x10, $x8, -40 :: (store 4 into %ir.4)
  SW killed renamable $x11, $x8, -44 :: (store 4 into %ir.5)
  renamable $x10 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  BNE killed renamable $x10, $x0, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x10 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x18 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  renamable $x9 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  $x10 = ADDI $x18, 0
  $x11 = ADDI $x9, 0
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x11 = ADDI $x9, 0
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  renamable $x11 = SUBW killed renamable $x18, killed renamable $x10
  $x10 = ADDI killed $x9, 0
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  renamable $x10 = LW $x8, -36 :: (dereferenceable load 4 from %ir.3)
  $x18 = LD $x2, 16
  $x9 = LD $x2, 24
  $x8 = LD $x2, 32
  $x1 = LD $x2, 40
  $x2 = frame-destroy ADDI $x2, 48
  PseudoRET implicit $x10

# End machine code for function gcd.

# After RISCV pseudo instruction expansion pass:
# Machine code for function gcd: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-36]
  fi#1: size=4, align=4, at location [SP-40]
  fi#2: size=4, align=4, at location [SP-44]
  fi#3: size=8, align=8, at location [SP-8]
  fi#4: size=8, align=8, at location [SP-16]
  fi#5: size=8, align=8, at location [SP-24]
  fi#6: size=8, align=8, at location [SP-32]
Function Live Ins: $x10, $x11

bb.0 (%ir-block.2):
  successors: %bb.1, %bb.2
  liveins: $x10, $x11, $x9, $x18
  $x2 = frame-setup ADDI $x2, -48
  SD killed $x1, $x2, 40
  SD killed $x8, $x2, 32
  SD killed $x9, $x2, 24
  SD killed $x18, $x2, 16
  $x8 = frame-setup ADDI $x2, 48
  SW killed renamable $x10, $x8, -40 :: (store 4 into %ir.4)
  SW killed renamable $x11, $x8, -44 :: (store 4 into %ir.5)
  renamable $x10 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  BNE killed renamable $x10, $x0, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x10 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.2 (%ir-block.10):
; predecessors: %bb.0
  successors: %bb.3(0x80000000); %bb.3(100.00%)

  renamable $x18 = LW $x8, -40 :: (dereferenceable load 4 from %ir.4)
  renamable $x9 = LW $x8, -44 :: (dereferenceable load 4 from %ir.5)
  $x10 = ADDI $x18, 0
  $x11 = ADDI $x9, 0
  PseudoCALL &__divdi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x11 = ADDI $x9, 0
  PseudoCALL &__muldi3, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  renamable $x11 = SUBW killed renamable $x18, killed renamable $x10
  $x10 = ADDI killed $x9, 0
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  SW killed renamable $x10, $x8, -36 :: (store 4 into %ir.3)
  PseudoBR %bb.3

bb.3 (%ir-block.20):
; predecessors: %bb.2, %bb.1

  renamable $x10 = LW $x8, -36 :: (dereferenceable load 4 from %ir.3)
  $x18 = LD $x2, 16
  $x9 = LD $x2, 24
  $x8 = LD $x2, 32
  $x1 = LD $x2, 40
  $x2 = frame-destroy ADDI $x2, 48
  PseudoRET implicit $x10

# End machine code for function gcd.

# After Instruction Selection:
# Machine code for function main: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  %0:gpr = COPY $x0
  SW %0:gpr, %stack.0, 0 :: (store 4 into %ir.1)
  %1:gpr = ADDI $x0, 72
  SW killed %1:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %2:gpr = ADDI $x0, 18
  SW killed %2:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  %3:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  BGE killed %3:gpr, killed %4:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  %5:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  SW killed %5:gpr, %stack.3, 0 :: (store 4 into %ir.4)
  %6:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  SW killed %6:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %7:gpr = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %7:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  %8:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %9:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %9:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %10:gpr = COPY $x10
  $x10 = COPY %10:gpr
  PseudoRET implicit $x10

# End machine code for function main.

# After Expand ISel Pseudo-instructions:
# Machine code for function main: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  %0:gpr = COPY $x0
  SW %0:gpr, %stack.0, 0 :: (store 4 into %ir.1)
  %1:gpr = ADDI $x0, 72
  SW killed %1:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %2:gpr = ADDI $x0, 18
  SW killed %2:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  %3:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  BGE killed %3:gpr, killed %4:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  %5:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  SW killed %5:gpr, %stack.3, 0 :: (store 4 into %ir.4)
  %6:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  SW killed %6:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %7:gpr = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %7:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  %8:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %9:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %9:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %10:gpr = COPY $x10
  $x10 = COPY %10:gpr
  PseudoRET implicit $x10

# End machine code for function main.

# After Early Tail Duplication:
# Machine code for function main: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  %0:gpr = COPY $x0
  SW %0:gpr, %stack.0, 0 :: (store 4 into %ir.1)
  %1:gpr = ADDI $x0, 72
  SW killed %1:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %2:gpr = ADDI $x0, 18
  SW killed %2:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  %3:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  BGE killed %3:gpr, killed %4:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  %5:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  SW killed %5:gpr, %stack.3, 0 :: (store 4 into %ir.4)
  %6:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  SW killed %6:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %7:gpr = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %7:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  %8:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %9:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %9:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %10:gpr = COPY $x10
  $x10 = COPY %10:gpr
  PseudoRET implicit $x10

# End machine code for function main.

# After Optimize machine instruction PHIs:
# Machine code for function main: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  %0:gpr = COPY $x0
  SW %0:gpr, %stack.0, 0 :: (store 4 into %ir.1)
  %1:gpr = ADDI $x0, 72
  SW killed %1:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %2:gpr = ADDI $x0, 18
  SW killed %2:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  %3:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  BGE killed %3:gpr, killed %4:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  %5:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  SW killed %5:gpr, %stack.3, 0 :: (store 4 into %ir.4)
  %6:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  SW killed %6:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %7:gpr = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %7:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  %8:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %9:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %9:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %10:gpr = COPY $x10
  $x10 = COPY %10:gpr
  PseudoRET implicit $x10

# End machine code for function main.

# After Merge disjoint stack slots:
# Machine code for function main: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  %0:gpr = COPY $x0
  SW %0:gpr, %stack.0, 0 :: (store 4 into %ir.1)
  %1:gpr = ADDI $x0, 72
  SW killed %1:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %2:gpr = ADDI $x0, 18
  SW killed %2:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  %3:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  BGE killed %3:gpr, killed %4:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  %5:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  SW killed %5:gpr, %stack.3, 0 :: (store 4 into %ir.4)
  %6:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  SW killed %6:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %7:gpr = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %7:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  %8:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %9:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %9:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %10:gpr = COPY $x10
  $x10 = COPY %10:gpr
  PseudoRET implicit $x10

# End machine code for function main.

# After Local Stack Slot Allocation:
# Machine code for function main: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  %0:gpr = COPY $x0
  SW %0:gpr, %stack.0, 0 :: (store 4 into %ir.1)
  %1:gpr = ADDI $x0, 72
  SW killed %1:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %2:gpr = ADDI $x0, 18
  SW killed %2:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  %3:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  BGE killed %3:gpr, killed %4:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  %5:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  SW killed %5:gpr, %stack.3, 0 :: (store 4 into %ir.4)
  %6:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  SW killed %6:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %7:gpr = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %7:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  %8:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %9:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %9:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %10:gpr = COPY $x10
  $x10 = COPY %10:gpr
  PseudoRET implicit $x10

# End machine code for function main.

# After Remove dead machine instructions:
# Machine code for function main: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  %0:gpr = COPY $x0
  SW %0:gpr, %stack.0, 0 :: (store 4 into %ir.1)
  %1:gpr = ADDI $x0, 72
  SW killed %1:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %2:gpr = ADDI $x0, 18
  SW killed %2:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  %3:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  BGE killed %3:gpr, killed %4:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  %5:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  SW killed %5:gpr, %stack.3, 0 :: (store 4 into %ir.4)
  %6:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  SW killed %6:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %7:gpr = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %7:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  %8:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %9:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %9:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %10:gpr = COPY $x10
  $x10 = COPY %10:gpr
  PseudoRET implicit $x10

# End machine code for function main.

# After Early Machine Loop Invariant Code Motion:
# Machine code for function main: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  %0:gpr = COPY $x0
  SW %0:gpr, %stack.0, 0 :: (store 4 into %ir.1)
  %1:gpr = ADDI $x0, 72
  SW killed %1:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %2:gpr = ADDI $x0, 18
  SW killed %2:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  %3:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  BGE killed %3:gpr, killed %4:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  %5:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  SW killed %5:gpr, %stack.3, 0 :: (store 4 into %ir.4)
  %6:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  SW killed %6:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %7:gpr = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %7:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  %8:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %9:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %9:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %10:gpr = COPY $x10
  $x10 = COPY %10:gpr
  PseudoRET implicit $x10

# End machine code for function main.

# After Machine Common Subexpression Elimination:
# Machine code for function main: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  %0:gpr = COPY $x0
  SW %0:gpr, %stack.0, 0 :: (store 4 into %ir.1)
  %1:gpr = ADDI $x0, 72
  SW killed %1:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %2:gpr = ADDI $x0, 18
  SW killed %2:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  %3:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  BGE killed %3:gpr, killed %4:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  %5:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  SW killed %5:gpr, %stack.3, 0 :: (store 4 into %ir.4)
  %6:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  SW killed %6:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %7:gpr = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %7:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  %8:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %9:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %9:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %10:gpr = COPY $x10
  $x10 = COPY %10:gpr
  PseudoRET implicit $x10

# End machine code for function main.

# After Machine code sinking:
# Machine code for function main: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  %0:gpr = COPY $x0
  SW %0:gpr, %stack.0, 0 :: (store 4 into %ir.1)
  %1:gpr = ADDI $x0, 72
  SW killed %1:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %2:gpr = ADDI $x0, 18
  SW killed %2:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  %3:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  BGE killed %3:gpr, killed %4:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  %5:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  SW killed %5:gpr, %stack.3, 0 :: (store 4 into %ir.4)
  %6:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  SW killed %6:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %7:gpr = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %7:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  %8:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %9:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %9:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %10:gpr = COPY $x10
  $x10 = COPY %10:gpr
  PseudoRET implicit $x10

# End machine code for function main.

# After Peephole Optimizations:
# Machine code for function main: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  %0:gpr = COPY $x0
  SW %0:gpr, %stack.0, 0 :: (store 4 into %ir.1)
  %1:gpr = ADDI $x0, 72
  SW killed %1:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %2:gpr = ADDI $x0, 18
  SW killed %2:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  %3:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  BGE killed %3:gpr, killed %4:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  %5:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  SW killed %5:gpr, %stack.3, 0 :: (store 4 into %ir.4)
  %6:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  SW killed %6:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %7:gpr = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %7:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  %8:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %9:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %9:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %10:gpr = COPY $x10
  $x10 = COPY %10:gpr
  PseudoRET implicit $x10

# End machine code for function main.

# After Remove dead machine instructions:
# Machine code for function main: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  %0:gpr = COPY $x0
  SW %0:gpr, %stack.0, 0 :: (store 4 into %ir.1)
  %1:gpr = ADDI $x0, 72
  SW killed %1:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %2:gpr = ADDI $x0, 18
  SW killed %2:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  %3:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  BGE killed %3:gpr, killed %4:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  %5:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  SW killed %5:gpr, %stack.3, 0 :: (store 4 into %ir.4)
  %6:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  SW killed %6:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %7:gpr = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %7:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  %8:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %9:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %9:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %10:gpr = COPY $x10
  $x10 = COPY %10:gpr
  PseudoRET implicit $x10

# End machine code for function main.

# After RISCV Merge Base Offset:
# Machine code for function main: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  %0:gpr = COPY $x0
  SW %0:gpr, %stack.0, 0 :: (store 4 into %ir.1)
  %1:gpr = ADDI $x0, 72
  SW killed %1:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %2:gpr = ADDI $x0, 18
  SW killed %2:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  %3:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  BGE killed %3:gpr, killed %4:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  %5:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  SW killed %5:gpr, %stack.3, 0 :: (store 4 into %ir.4)
  %6:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  SW killed %6:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %7:gpr = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %7:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  %8:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %9:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %9:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %10:gpr = COPY $x10
  $x10 = COPY %10:gpr
  PseudoRET implicit $x10

# End machine code for function main.

# After Detect Dead Lanes:
# Machine code for function main: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  %0:gpr = COPY $x0
  SW %0:gpr, %stack.0, 0 :: (store 4 into %ir.1)
  %1:gpr = ADDI $x0, 72
  SW killed %1:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %2:gpr = ADDI $x0, 18
  SW killed %2:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  %3:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  BGE killed %3:gpr, killed %4:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  %5:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  SW killed %5:gpr, %stack.3, 0 :: (store 4 into %ir.4)
  %6:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  SW killed %6:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %7:gpr = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %7:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  %8:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %9:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %9:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %10:gpr = COPY $x10
  $x10 = COPY %10:gpr
  PseudoRET implicit $x10

# End machine code for function main.

# After Process Implicit Definitions:
# Machine code for function main: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  %0:gpr = COPY $x0
  SW %0:gpr, %stack.0, 0 :: (store 4 into %ir.1)
  %1:gpr = ADDI $x0, 72
  SW killed %1:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %2:gpr = ADDI $x0, 18
  SW killed %2:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  %3:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  BGE killed %3:gpr, killed %4:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  %5:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  SW killed %5:gpr, %stack.3, 0 :: (store 4 into %ir.4)
  %6:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  SW killed %6:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %7:gpr = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %7:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  %8:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %9:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY %8:gpr
  $x11 = COPY %9:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %10:gpr = COPY $x10
  $x10 = COPY %10:gpr
  PseudoRET implicit $x10

# End machine code for function main.

# After Live Variable Analysis:
# Machine code for function main: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  %0:gpr = COPY $x0
  SW killed %0:gpr, %stack.0, 0 :: (store 4 into %ir.1)
  %1:gpr = ADDI $x0, 72
  SW killed %1:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %2:gpr = ADDI $x0, 18
  SW killed %2:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  %3:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  BGE killed %3:gpr, killed %4:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  %5:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  SW killed %5:gpr, %stack.3, 0 :: (store 4 into %ir.4)
  %6:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  SW killed %6:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %7:gpr = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %7:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  %8:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %9:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY killed %8:gpr
  $x11 = COPY killed %9:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit killed $x10, implicit killed $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %10:gpr = COPY killed $x10
  $x10 = COPY killed %10:gpr
  PseudoRET implicit killed $x10

# End machine code for function main.

# After Machine Natural Loop Construction:
# Machine code for function main: IsSSA, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  %0:gpr = COPY $x0
  SW killed %0:gpr, %stack.0, 0 :: (store 4 into %ir.1)
  %1:gpr = ADDI $x0, 72
  SW killed %1:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %2:gpr = ADDI $x0, 18
  SW killed %2:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  %3:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  BGE killed %3:gpr, killed %4:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  %5:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  SW killed %5:gpr, %stack.3, 0 :: (store 4 into %ir.4)
  %6:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  SW killed %6:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %7:gpr = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %7:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  %8:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %9:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY killed %8:gpr
  $x11 = COPY killed %9:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit killed $x10, implicit killed $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %10:gpr = COPY killed $x10
  $x10 = COPY killed %10:gpr
  PseudoRET implicit killed $x10

# End machine code for function main.

# After Eliminate PHI nodes for register allocation:
# Machine code for function main: NoPHIs, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  %0:gpr = COPY $x0
  SW killed %0:gpr, %stack.0, 0 :: (store 4 into %ir.1)
  %1:gpr = ADDI $x0, 72
  SW killed %1:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %2:gpr = ADDI $x0, 18
  SW killed %2:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  %3:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  BGE killed %3:gpr, killed %4:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  %5:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  SW killed %5:gpr, %stack.3, 0 :: (store 4 into %ir.4)
  %6:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  SW killed %6:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %7:gpr = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %7:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  %8:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %9:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY killed %8:gpr
  $x11 = COPY killed %9:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit killed $x10, implicit killed $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %10:gpr = COPY killed $x10
  $x10 = COPY killed %10:gpr
  PseudoRET implicit killed $x10

# End machine code for function main.

# After Two-Address instruction pass:
# Machine code for function main: NoPHIs, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  %0:gpr = COPY $x0
  SW killed %0:gpr, %stack.0, 0 :: (store 4 into %ir.1)
  %1:gpr = ADDI $x0, 72
  SW killed %1:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %2:gpr = ADDI $x0, 18
  SW killed %2:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  %3:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  BGE killed %3:gpr, killed %4:gpr, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  %5:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  SW killed %5:gpr, %stack.3, 0 :: (store 4 into %ir.4)
  %6:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  SW killed %6:gpr, %stack.1, 0 :: (store 4 into %ir.2)
  %7:gpr = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed %7:gpr, %stack.2, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  %8:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  %9:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  $x10 = COPY killed %8:gpr
  $x11 = COPY killed %9:gpr
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit killed $x10, implicit killed $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  %10:gpr = COPY killed $x10
  $x10 = COPY killed %10:gpr
  PseudoRET implicit killed $x10

# End machine code for function main.

# After Simple Register Coalescing:
# Machine code for function main: NoPHIs, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

0B	bb.0 (%ir-block.0):
	  successors: %bb.1, %bb.2

32B	  SW $x0, %stack.0, 0 :: (store 4 into %ir.1)
48B	  %1:gpr = ADDI $x0, 72
64B	  SW %1:gpr, %stack.1, 0 :: (store 4 into %ir.2)
80B	  %2:gpr = ADDI $x0, 18
96B	  SW %2:gpr, %stack.2, 0 :: (store 4 into %ir.3)
112B	  %3:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
128B	  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
144B	  BGE %3:gpr, %4:gpr, %bb.2
160B	  PseudoBR %bb.1

176B	bb.1 (%ir-block.8):
	; predecessors: %bb.0
	  successors: %bb.2(0x80000000); %bb.2(100.00%)

192B	  %5:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
208B	  SW %5:gpr, %stack.3, 0 :: (store 4 into %ir.4)
224B	  %6:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
240B	  SW %6:gpr, %stack.1, 0 :: (store 4 into %ir.2)
256B	  %7:gpr = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
272B	  SW %7:gpr, %stack.2, 0 :: (store 4 into %ir.3)
288B	  PseudoBR %bb.2

304B	bb.2 (%ir-block.12):
	; predecessors: %bb.0, %bb.1

320B	  %8:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
336B	  %9:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
352B	  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
368B	  $x10 = COPY %8:gpr
384B	  $x11 = COPY %9:gpr
400B	  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit killed $x10, implicit killed $x11, implicit-def $x2, implicit-def $x10
416B	  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
432B	  %10:gpr = COPY killed $x10
448B	  $x10 = COPY %10:gpr
464B	  PseudoRET implicit killed $x10

# End machine code for function main.

# After Rename Disconnected Subregister Components:
# Machine code for function main: NoPHIs, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

0B	bb.0 (%ir-block.0):
	  successors: %bb.1, %bb.2

32B	  SW $x0, %stack.0, 0 :: (store 4 into %ir.1)
48B	  %1:gpr = ADDI $x0, 72
64B	  SW %1:gpr, %stack.1, 0 :: (store 4 into %ir.2)
80B	  %2:gpr = ADDI $x0, 18
96B	  SW %2:gpr, %stack.2, 0 :: (store 4 into %ir.3)
112B	  %3:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
128B	  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
144B	  BGE %3:gpr, %4:gpr, %bb.2
160B	  PseudoBR %bb.1

176B	bb.1 (%ir-block.8):
	; predecessors: %bb.0
	  successors: %bb.2(0x80000000); %bb.2(100.00%)

192B	  %5:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
208B	  SW %5:gpr, %stack.3, 0 :: (store 4 into %ir.4)
224B	  %6:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
240B	  SW %6:gpr, %stack.1, 0 :: (store 4 into %ir.2)
256B	  %7:gpr = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
272B	  SW %7:gpr, %stack.2, 0 :: (store 4 into %ir.3)
288B	  PseudoBR %bb.2

304B	bb.2 (%ir-block.12):
	; predecessors: %bb.0, %bb.1

320B	  %8:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
336B	  %9:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
352B	  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
368B	  $x10 = COPY %8:gpr
384B	  $x11 = COPY %9:gpr
400B	  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit killed $x10, implicit killed $x11, implicit-def $x2, implicit-def $x10
416B	  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
432B	  %10:gpr = COPY killed $x10
448B	  $x10 = COPY %10:gpr
464B	  PseudoRET implicit killed $x10

# End machine code for function main.

# After Machine Instruction Scheduler:
# Machine code for function main: NoPHIs, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

0B	bb.0 (%ir-block.0):
	  successors: %bb.1, %bb.2

32B	  SW $x0, %stack.0, 0 :: (store 4 into %ir.1)
48B	  %1:gpr = ADDI $x0, 72
64B	  SW %1:gpr, %stack.1, 0 :: (store 4 into %ir.2)
80B	  %2:gpr = ADDI $x0, 18
96B	  SW %2:gpr, %stack.2, 0 :: (store 4 into %ir.3)
112B	  %3:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
128B	  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
144B	  BGE %3:gpr, %4:gpr, %bb.2
160B	  PseudoBR %bb.1

176B	bb.1 (%ir-block.8):
	; predecessors: %bb.0
	  successors: %bb.2(0x80000000); %bb.2(100.00%)

192B	  %5:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
208B	  SW %5:gpr, %stack.3, 0 :: (store 4 into %ir.4)
224B	  %6:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
240B	  SW %6:gpr, %stack.1, 0 :: (store 4 into %ir.2)
256B	  %7:gpr = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
272B	  SW %7:gpr, %stack.2, 0 :: (store 4 into %ir.3)
288B	  PseudoBR %bb.2

304B	bb.2 (%ir-block.12):
	; predecessors: %bb.0, %bb.1

320B	  %8:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
336B	  %9:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
352B	  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
368B	  $x10 = COPY %8:gpr
384B	  $x11 = COPY %9:gpr
400B	  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit killed $x10, implicit killed $x11, implicit-def $x2, implicit-def $x10
416B	  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
432B	  %10:gpr = COPY killed $x10
448B	  $x10 = COPY %10:gpr
464B	  PseudoRET implicit killed $x10

# End machine code for function main.

# After Greedy Register Allocator:
# Machine code for function main: NoPHIs, TracksLiveness
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

0B	bb.0 (%ir-block.0):
	  successors: %bb.1, %bb.2

32B	  SW $x0, %stack.0, 0 :: (store 4 into %ir.1)
48B	  %1:gpr = ADDI $x0, 72
64B	  SW %1:gpr, %stack.1, 0 :: (store 4 into %ir.2)
80B	  %2:gpr = ADDI $x0, 18
96B	  SW %2:gpr, %stack.2, 0 :: (store 4 into %ir.3)
112B	  %3:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
128B	  %4:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
144B	  BGE %3:gpr, %4:gpr, %bb.2
160B	  PseudoBR %bb.1

176B	bb.1 (%ir-block.8):
	; predecessors: %bb.0
	  successors: %bb.2(0x80000000); %bb.2(100.00%)

192B	  %5:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
208B	  SW %5:gpr, %stack.3, 0 :: (store 4 into %ir.4)
224B	  %6:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
240B	  SW %6:gpr, %stack.1, 0 :: (store 4 into %ir.2)
256B	  %7:gpr = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
272B	  SW %7:gpr, %stack.2, 0 :: (store 4 into %ir.3)
288B	  PseudoBR %bb.2

304B	bb.2 (%ir-block.12):
	; predecessors: %bb.0, %bb.1

320B	  %8:gpr = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
336B	  %9:gpr = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
352B	  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
368B	  $x10 = COPY %8:gpr
384B	  $x11 = COPY %9:gpr
400B	  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
416B	  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
432B	  %10:gpr = COPY $x10
448B	  $x10 = COPY %10:gpr
464B	  PseudoRET implicit $x10

# End machine code for function main.

# After Virtual Register Rewriter:
# Machine code for function main: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

0B	bb.0 (%ir-block.0):
	  successors: %bb.1, %bb.2

32B	  SW $x0, %stack.0, 0 :: (store 4 into %ir.1)
48B	  renamable $x10 = ADDI $x0, 72
64B	  SW killed renamable $x10, %stack.1, 0 :: (store 4 into %ir.2)
80B	  renamable $x10 = ADDI $x0, 18
96B	  SW killed renamable $x10, %stack.2, 0 :: (store 4 into %ir.3)
112B	  renamable $x10 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
128B	  renamable $x11 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
144B	  BGE killed renamable $x10, killed renamable $x11, %bb.2
160B	  PseudoBR %bb.1

176B	bb.1 (%ir-block.8):
	; predecessors: %bb.0
	  successors: %bb.2(0x80000000); %bb.2(100.00%)

192B	  renamable $x10 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
208B	  SW killed renamable $x10, %stack.3, 0 :: (store 4 into %ir.4)
224B	  renamable $x10 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
240B	  SW killed renamable $x10, %stack.1, 0 :: (store 4 into %ir.2)
256B	  renamable $x10 = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
272B	  SW killed renamable $x10, %stack.2, 0 :: (store 4 into %ir.3)
288B	  PseudoBR %bb.2

304B	bb.2 (%ir-block.12):
	; predecessors: %bb.0, %bb.1

320B	  renamable $x10 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
336B	  renamable $x11 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
352B	  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
400B	  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
416B	  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
464B	  PseudoRET implicit $x10

# End machine code for function main.

# After Stack Slot Coloring:
# Machine code for function main: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

0B	bb.0 (%ir-block.0):
	  successors: %bb.1, %bb.2

32B	  SW $x0, %stack.0, 0 :: (store 4 into %ir.1)
48B	  renamable $x10 = ADDI $x0, 72
64B	  SW killed renamable $x10, %stack.1, 0 :: (store 4 into %ir.2)
80B	  renamable $x10 = ADDI $x0, 18
96B	  SW killed renamable $x10, %stack.2, 0 :: (store 4 into %ir.3)
112B	  renamable $x10 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
128B	  renamable $x11 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
144B	  BGE killed renamable $x10, killed renamable $x11, %bb.2
160B	  PseudoBR %bb.1

176B	bb.1 (%ir-block.8):
	; predecessors: %bb.0
	  successors: %bb.2(0x80000000); %bb.2(100.00%)

192B	  renamable $x10 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
208B	  SW killed renamable $x10, %stack.3, 0 :: (store 4 into %ir.4)
224B	  renamable $x10 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
240B	  SW killed renamable $x10, %stack.1, 0 :: (store 4 into %ir.2)
256B	  renamable $x10 = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
272B	  SW killed renamable $x10, %stack.2, 0 :: (store 4 into %ir.3)
288B	  PseudoBR %bb.2

304B	bb.2 (%ir-block.12):
	; predecessors: %bb.0, %bb.1

320B	  renamable $x10 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
336B	  renamable $x11 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
352B	  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
400B	  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
416B	  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
464B	  PseudoRET implicit $x10

# End machine code for function main.

# After Machine Copy Propagation Pass:
# Machine code for function main: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  SW $x0, %stack.0, 0 :: (store 4 into %ir.1)
  renamable $x10 = ADDI $x0, 72
  SW killed renamable $x10, %stack.1, 0 :: (store 4 into %ir.2)
  renamable $x10 = ADDI $x0, 18
  SW killed renamable $x10, %stack.2, 0 :: (store 4 into %ir.3)
  renamable $x10 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  BGE killed renamable $x10, killed renamable $x11, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  renamable $x10 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  SW killed renamable $x10, %stack.3, 0 :: (store 4 into %ir.4)
  renamable $x10 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  SW killed renamable $x10, %stack.1, 0 :: (store 4 into %ir.2)
  renamable $x10 = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, %stack.2, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  renamable $x10 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  PseudoRET implicit $x10

# End machine code for function main.

# After Machine Loop Invariant Code Motion:
# Machine code for function main: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  SW $x0, %stack.0, 0 :: (store 4 into %ir.1)
  renamable $x10 = ADDI $x0, 72
  SW killed renamable $x10, %stack.1, 0 :: (store 4 into %ir.2)
  renamable $x10 = ADDI $x0, 18
  SW killed renamable $x10, %stack.2, 0 :: (store 4 into %ir.3)
  renamable $x10 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  BGE killed renamable $x10, killed renamable $x11, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  renamable $x10 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  SW killed renamable $x10, %stack.3, 0 :: (store 4 into %ir.4)
  renamable $x10 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  SW killed renamable $x10, %stack.1, 0 :: (store 4 into %ir.2)
  renamable $x10 = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, %stack.2, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  renamable $x10 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  PseudoRET implicit $x10

# End machine code for function main.

# After PostRA Machine Sink:
# Machine code for function main: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  SW $x0, %stack.0, 0 :: (store 4 into %ir.1)
  renamable $x10 = ADDI $x0, 72
  SW killed renamable $x10, %stack.1, 0 :: (store 4 into %ir.2)
  renamable $x10 = ADDI $x0, 18
  SW killed renamable $x10, %stack.2, 0 :: (store 4 into %ir.3)
  renamable $x10 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  BGE killed renamable $x10, killed renamable $x11, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  renamable $x10 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  SW killed renamable $x10, %stack.3, 0 :: (store 4 into %ir.4)
  renamable $x10 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  SW killed renamable $x10, %stack.1, 0 :: (store 4 into %ir.2)
  renamable $x10 = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, %stack.2, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  renamable $x10 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  PseudoRET implicit $x10

# End machine code for function main.

# After Shrink Wrapping analysis:
# Machine code for function main: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP]
  fi#1: size=4, align=4, at location [SP]
  fi#2: size=4, align=4, at location [SP]
  fi#3: size=4, align=4, at location [SP]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  SW $x0, %stack.0, 0 :: (store 4 into %ir.1)
  renamable $x10 = ADDI $x0, 72
  SW killed renamable $x10, %stack.1, 0 :: (store 4 into %ir.2)
  renamable $x10 = ADDI $x0, 18
  SW killed renamable $x10, %stack.2, 0 :: (store 4 into %ir.3)
  renamable $x10 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  BGE killed renamable $x10, killed renamable $x11, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  renamable $x10 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  SW killed renamable $x10, %stack.3, 0 :: (store 4 into %ir.4)
  renamable $x10 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  SW killed renamable $x10, %stack.1, 0 :: (store 4 into %ir.2)
  renamable $x10 = LW %stack.3, 0 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, %stack.2, 0 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  renamable $x10 = LW %stack.1, 0 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW %stack.2, 0 :: (dereferenceable load 4 from %ir.3)
  ADJCALLSTACKDOWN 0, 0, implicit-def dead $x2, implicit $x2
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  ADJCALLSTACKUP 0, 0, implicit-def dead $x2, implicit $x2
  PseudoRET implicit $x10

# End machine code for function main.

# After Prologue/Epilogue Insertion & Frame Finalization:
# Machine code for function main: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-20]
  fi#1: size=4, align=4, at location [SP-24]
  fi#2: size=4, align=4, at location [SP-28]
  fi#3: size=4, align=4, at location [SP-32]
  fi#4: size=8, align=8, at location [SP-8]
  fi#5: size=8, align=8, at location [SP-16]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  $x2 = frame-setup ADDI $x2, -32
  SD killed $x1, $x2, 24
  SD killed $x8, $x2, 16
  $x8 = frame-setup ADDI $x2, 32
  SW $x0, $x8, -20 :: (store 4 into %ir.1)
  renamable $x10 = ADDI $x0, 72
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = ADDI $x0, 18
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  BGE killed renamable $x10, killed renamable $x11, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  SW killed renamable $x10, $x8, -32 :: (store 4 into %ir.4)
  renamable $x10 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = LW $x8, -32 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x8 = LD $x2, 16
  $x1 = LD $x2, 24
  $x2 = frame-destroy ADDI $x2, 32
  PseudoRET implicit $x10

# End machine code for function main.

# After Control Flow Optimizer:
# Machine code for function main: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-20]
  fi#1: size=4, align=4, at location [SP-24]
  fi#2: size=4, align=4, at location [SP-28]
  fi#3: size=4, align=4, at location [SP-32]
  fi#4: size=8, align=8, at location [SP-8]
  fi#5: size=8, align=8, at location [SP-16]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  $x2 = frame-setup ADDI $x2, -32
  SD killed $x1, $x2, 24
  SD killed $x8, $x2, 16
  $x8 = frame-setup ADDI $x2, 32
  SW $x0, $x8, -20 :: (store 4 into %ir.1)
  renamable $x10 = ADDI $x0, 72
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = ADDI $x0, 18
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  BGE killed renamable $x10, killed renamable $x11, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  SW killed renamable $x10, $x8, -32 :: (store 4 into %ir.4)
  renamable $x10 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = LW $x8, -32 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x8 = LD $x2, 16
  $x1 = LD $x2, 24
  $x2 = frame-destroy ADDI $x2, 32
  PseudoRET implicit $x10

# End machine code for function main.

# After Tail Duplication:
# Machine code for function main: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-20]
  fi#1: size=4, align=4, at location [SP-24]
  fi#2: size=4, align=4, at location [SP-28]
  fi#3: size=4, align=4, at location [SP-32]
  fi#4: size=8, align=8, at location [SP-8]
  fi#5: size=8, align=8, at location [SP-16]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  $x2 = frame-setup ADDI $x2, -32
  SD killed $x1, $x2, 24
  SD killed $x8, $x2, 16
  $x8 = frame-setup ADDI $x2, 32
  SW $x0, $x8, -20 :: (store 4 into %ir.1)
  renamable $x10 = ADDI $x0, 72
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = ADDI $x0, 18
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  BGE killed renamable $x10, killed renamable $x11, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  SW killed renamable $x10, $x8, -32 :: (store 4 into %ir.4)
  renamable $x10 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = LW $x8, -32 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x8 = LD $x2, 16
  $x1 = LD $x2, 24
  $x2 = frame-destroy ADDI $x2, 32
  PseudoRET implicit $x10

# End machine code for function main.

# After Machine Copy Propagation Pass:
# Machine code for function main: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-20]
  fi#1: size=4, align=4, at location [SP-24]
  fi#2: size=4, align=4, at location [SP-28]
  fi#3: size=4, align=4, at location [SP-32]
  fi#4: size=8, align=8, at location [SP-8]
  fi#5: size=8, align=8, at location [SP-16]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  $x2 = frame-setup ADDI $x2, -32
  SD killed $x1, $x2, 24
  SD killed $x8, $x2, 16
  $x8 = frame-setup ADDI $x2, 32
  SW $x0, $x8, -20 :: (store 4 into %ir.1)
  renamable $x10 = ADDI $x0, 72
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = ADDI $x0, 18
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  BGE killed renamable $x10, killed renamable $x11, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  SW killed renamable $x10, $x8, -32 :: (store 4 into %ir.4)
  renamable $x10 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = LW $x8, -32 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x8 = LD $x2, 16
  $x1 = LD $x2, 24
  $x2 = frame-destroy ADDI $x2, 32
  PseudoRET implicit $x10

# End machine code for function main.

# After Post-RA pseudo instruction expansion pass:
# Machine code for function main: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-20]
  fi#1: size=4, align=4, at location [SP-24]
  fi#2: size=4, align=4, at location [SP-28]
  fi#3: size=4, align=4, at location [SP-32]
  fi#4: size=8, align=8, at location [SP-8]
  fi#5: size=8, align=8, at location [SP-16]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  $x2 = frame-setup ADDI $x2, -32
  SD killed $x1, $x2, 24
  SD killed $x8, $x2, 16
  $x8 = frame-setup ADDI $x2, 32
  SW $x0, $x8, -20 :: (store 4 into %ir.1)
  renamable $x10 = ADDI $x0, 72
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = ADDI $x0, 18
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  BGE killed renamable $x10, killed renamable $x11, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  SW killed renamable $x10, $x8, -32 :: (store 4 into %ir.4)
  renamable $x10 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = LW $x8, -32 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x8 = LD $x2, 16
  $x1 = LD $x2, 24
  $x2 = frame-destroy ADDI $x2, 32
  PseudoRET implicit $x10

# End machine code for function main.

# After Post RA top-down list latency scheduler:
# Machine code for function main: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-20]
  fi#1: size=4, align=4, at location [SP-24]
  fi#2: size=4, align=4, at location [SP-28]
  fi#3: size=4, align=4, at location [SP-32]
  fi#4: size=8, align=8, at location [SP-8]
  fi#5: size=8, align=8, at location [SP-16]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  $x2 = frame-setup ADDI $x2, -32
  SD killed $x1, $x2, 24
  SD killed $x8, $x2, 16
  $x8 = frame-setup ADDI $x2, 32
  SW $x0, $x8, -20 :: (store 4 into %ir.1)
  renamable $x10 = ADDI $x0, 72
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = ADDI $x0, 18
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  BGE killed renamable $x10, killed renamable $x11, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  SW killed renamable $x10, $x8, -32 :: (store 4 into %ir.4)
  renamable $x10 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = LW $x8, -32 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x8 = LD $x2, 16
  $x1 = LD $x2, 24
  $x2 = frame-destroy ADDI $x2, 32
  PseudoRET implicit $x10

# End machine code for function main.

# After Analyze Machine Code For Garbage Collection:
# Machine code for function main: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-20]
  fi#1: size=4, align=4, at location [SP-24]
  fi#2: size=4, align=4, at location [SP-28]
  fi#3: size=4, align=4, at location [SP-32]
  fi#4: size=8, align=8, at location [SP-8]
  fi#5: size=8, align=8, at location [SP-16]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  $x2 = frame-setup ADDI $x2, -32
  SD killed $x1, $x2, 24
  SD killed $x8, $x2, 16
  $x8 = frame-setup ADDI $x2, 32
  SW $x0, $x8, -20 :: (store 4 into %ir.1)
  renamable $x10 = ADDI $x0, 72
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = ADDI $x0, 18
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  BGE killed renamable $x10, killed renamable $x11, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  SW killed renamable $x10, $x8, -32 :: (store 4 into %ir.4)
  renamable $x10 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = LW $x8, -32 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x8 = LD $x2, 16
  $x1 = LD $x2, 24
  $x2 = frame-destroy ADDI $x2, 32
  PseudoRET implicit $x10

# End machine code for function main.

# After Branch Probability Basic Block Placement:
# Machine code for function main: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-20]
  fi#1: size=4, align=4, at location [SP-24]
  fi#2: size=4, align=4, at location [SP-28]
  fi#3: size=4, align=4, at location [SP-32]
  fi#4: size=8, align=8, at location [SP-8]
  fi#5: size=8, align=8, at location [SP-16]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  $x2 = frame-setup ADDI $x2, -32
  SD killed $x1, $x2, 24
  SD killed $x8, $x2, 16
  $x8 = frame-setup ADDI $x2, 32
  SW $x0, $x8, -20 :: (store 4 into %ir.1)
  renamable $x10 = ADDI $x0, 72
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = ADDI $x0, 18
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  BGE killed renamable $x10, killed renamable $x11, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  SW killed renamable $x10, $x8, -32 :: (store 4 into %ir.4)
  renamable $x10 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = LW $x8, -32 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x8 = LD $x2, 16
  $x1 = LD $x2, 24
  $x2 = frame-destroy ADDI $x2, 32
  PseudoRET implicit $x10

# End machine code for function main.

# After Branch relaxation pass:
# Machine code for function main: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-20]
  fi#1: size=4, align=4, at location [SP-24]
  fi#2: size=4, align=4, at location [SP-28]
  fi#3: size=4, align=4, at location [SP-32]
  fi#4: size=8, align=8, at location [SP-8]
  fi#5: size=8, align=8, at location [SP-16]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  $x2 = frame-setup ADDI $x2, -32
  SD killed $x1, $x2, 24
  SD killed $x8, $x2, 16
  $x8 = frame-setup ADDI $x2, 32
  SW $x0, $x8, -20 :: (store 4 into %ir.1)
  renamable $x10 = ADDI $x0, 72
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = ADDI $x0, 18
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  BGE killed renamable $x10, killed renamable $x11, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  SW killed renamable $x10, $x8, -32 :: (store 4 into %ir.4)
  renamable $x10 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = LW $x8, -32 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x8 = LD $x2, 16
  $x1 = LD $x2, 24
  $x2 = frame-destroy ADDI $x2, 32
  PseudoRET implicit $x10

# End machine code for function main.

# After Contiguously Lay Out Funclets:
# Machine code for function main: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-20]
  fi#1: size=4, align=4, at location [SP-24]
  fi#2: size=4, align=4, at location [SP-28]
  fi#3: size=4, align=4, at location [SP-32]
  fi#4: size=8, align=8, at location [SP-8]
  fi#5: size=8, align=8, at location [SP-16]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  $x2 = frame-setup ADDI $x2, -32
  SD killed $x1, $x2, 24
  SD killed $x8, $x2, 16
  $x8 = frame-setup ADDI $x2, 32
  SW $x0, $x8, -20 :: (store 4 into %ir.1)
  renamable $x10 = ADDI $x0, 72
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = ADDI $x0, 18
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  BGE killed renamable $x10, killed renamable $x11, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  SW killed renamable $x10, $x8, -32 :: (store 4 into %ir.4)
  renamable $x10 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = LW $x8, -32 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x8 = LD $x2, 16
  $x1 = LD $x2, 24
  $x2 = frame-destroy ADDI $x2, 32
  PseudoRET implicit $x10

# End machine code for function main.

# After StackMap Liveness Analysis:
# Machine code for function main: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-20]
  fi#1: size=4, align=4, at location [SP-24]
  fi#2: size=4, align=4, at location [SP-28]
  fi#3: size=4, align=4, at location [SP-32]
  fi#4: size=8, align=8, at location [SP-8]
  fi#5: size=8, align=8, at location [SP-16]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  $x2 = frame-setup ADDI $x2, -32
  SD killed $x1, $x2, 24
  SD killed $x8, $x2, 16
  $x8 = frame-setup ADDI $x2, 32
  SW $x0, $x8, -20 :: (store 4 into %ir.1)
  renamable $x10 = ADDI $x0, 72
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = ADDI $x0, 18
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  BGE killed renamable $x10, killed renamable $x11, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  SW killed renamable $x10, $x8, -32 :: (store 4 into %ir.4)
  renamable $x10 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = LW $x8, -32 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x8 = LD $x2, 16
  $x1 = LD $x2, 24
  $x2 = frame-destroy ADDI $x2, 32
  PseudoRET implicit $x10

# End machine code for function main.

# After Live DEBUG_VALUE analysis:
# Machine code for function main: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-20]
  fi#1: size=4, align=4, at location [SP-24]
  fi#2: size=4, align=4, at location [SP-28]
  fi#3: size=4, align=4, at location [SP-32]
  fi#4: size=8, align=8, at location [SP-8]
  fi#5: size=8, align=8, at location [SP-16]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  $x2 = frame-setup ADDI $x2, -32
  SD killed $x1, $x2, 24
  SD killed $x8, $x2, 16
  $x8 = frame-setup ADDI $x2, 32
  SW $x0, $x8, -20 :: (store 4 into %ir.1)
  renamable $x10 = ADDI $x0, 72
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = ADDI $x0, 18
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  BGE killed renamable $x10, killed renamable $x11, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  SW killed renamable $x10, $x8, -32 :: (store 4 into %ir.4)
  renamable $x10 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = LW $x8, -32 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x8 = LD $x2, 16
  $x1 = LD $x2, 24
  $x2 = frame-destroy ADDI $x2, 32
  PseudoRET implicit $x10

# End machine code for function main.

# After Insert fentry calls:
# Machine code for function main: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-20]
  fi#1: size=4, align=4, at location [SP-24]
  fi#2: size=4, align=4, at location [SP-28]
  fi#3: size=4, align=4, at location [SP-32]
  fi#4: size=8, align=8, at location [SP-8]
  fi#5: size=8, align=8, at location [SP-16]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  $x2 = frame-setup ADDI $x2, -32
  SD killed $x1, $x2, 24
  SD killed $x8, $x2, 16
  $x8 = frame-setup ADDI $x2, 32
  SW $x0, $x8, -20 :: (store 4 into %ir.1)
  renamable $x10 = ADDI $x0, 72
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = ADDI $x0, 18
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  BGE killed renamable $x10, killed renamable $x11, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  SW killed renamable $x10, $x8, -32 :: (store 4 into %ir.4)
  renamable $x10 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = LW $x8, -32 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x8 = LD $x2, 16
  $x1 = LD $x2, 24
  $x2 = frame-destroy ADDI $x2, 32
  PseudoRET implicit $x10

# End machine code for function main.

# After Insert XRay ops:
# Machine code for function main: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-20]
  fi#1: size=4, align=4, at location [SP-24]
  fi#2: size=4, align=4, at location [SP-28]
  fi#3: size=4, align=4, at location [SP-32]
  fi#4: size=8, align=8, at location [SP-8]
  fi#5: size=8, align=8, at location [SP-16]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  $x2 = frame-setup ADDI $x2, -32
  SD killed $x1, $x2, 24
  SD killed $x8, $x2, 16
  $x8 = frame-setup ADDI $x2, 32
  SW $x0, $x8, -20 :: (store 4 into %ir.1)
  renamable $x10 = ADDI $x0, 72
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = ADDI $x0, 18
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  BGE killed renamable $x10, killed renamable $x11, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  SW killed renamable $x10, $x8, -32 :: (store 4 into %ir.4)
  renamable $x10 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = LW $x8, -32 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x8 = LD $x2, 16
  $x1 = LD $x2, 24
  $x2 = frame-destroy ADDI $x2, 32
  PseudoRET implicit $x10

# End machine code for function main.

# After Implement the 'patchable-function' attribute:
# Machine code for function main: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-20]
  fi#1: size=4, align=4, at location [SP-24]
  fi#2: size=4, align=4, at location [SP-28]
  fi#3: size=4, align=4, at location [SP-32]
  fi#4: size=8, align=8, at location [SP-8]
  fi#5: size=8, align=8, at location [SP-16]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  $x2 = frame-setup ADDI $x2, -32
  SD killed $x1, $x2, 24
  SD killed $x8, $x2, 16
  $x8 = frame-setup ADDI $x2, 32
  SW $x0, $x8, -20 :: (store 4 into %ir.1)
  renamable $x10 = ADDI $x0, 72
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = ADDI $x0, 18
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  BGE killed renamable $x10, killed renamable $x11, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  SW killed renamable $x10, $x8, -32 :: (store 4 into %ir.4)
  renamable $x10 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = LW $x8, -32 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x8 = LD $x2, 16
  $x1 = LD $x2, 24
  $x2 = frame-destroy ADDI $x2, 32
  PseudoRET implicit $x10

# End machine code for function main.

# After RISCV pseudo instruction expansion pass:
# Machine code for function main: NoPHIs, TracksLiveness, NoVRegs
Frame Objects:
  fi#0: size=4, align=4, at location [SP-20]
  fi#1: size=4, align=4, at location [SP-24]
  fi#2: size=4, align=4, at location [SP-28]
  fi#3: size=4, align=4, at location [SP-32]
  fi#4: size=8, align=8, at location [SP-8]
  fi#5: size=8, align=8, at location [SP-16]

bb.0 (%ir-block.0):
  successors: %bb.1, %bb.2

  $x2 = frame-setup ADDI $x2, -32
  SD killed $x1, $x2, 24
  SD killed $x8, $x2, 16
  $x8 = frame-setup ADDI $x2, 32
  SW $x0, $x8, -20 :: (store 4 into %ir.1)
  renamable $x10 = ADDI $x0, 72
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = ADDI $x0, 18
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  BGE killed renamable $x10, killed renamable $x11, %bb.2
  PseudoBR %bb.1

bb.1 (%ir-block.8):
; predecessors: %bb.0
  successors: %bb.2(0x80000000); %bb.2(100.00%)

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  SW killed renamable $x10, $x8, -32 :: (store 4 into %ir.4)
  renamable $x10 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  SW killed renamable $x10, $x8, -24 :: (store 4 into %ir.2)
  renamable $x10 = LW $x8, -32 :: (dereferenceable load 4 from %ir.4)
  SW killed renamable $x10, $x8, -28 :: (store 4 into %ir.3)
  PseudoBR %bb.2

bb.2 (%ir-block.12):
; predecessors: %bb.0, %bb.1

  renamable $x10 = LW $x8, -24 :: (dereferenceable load 4 from %ir.2)
  renamable $x11 = LW $x8, -28 :: (dereferenceable load 4 from %ir.3)
  PseudoCALL @gcd, <regmask $x1 $x3 $x4 $x8 $x9 $x18 $x19 $x20 $x21 $x22 $x23 $x24 $x25 $x26 $x27>, implicit-def dead $x1, implicit $x10, implicit $x11, implicit-def $x2, implicit-def $x10
  $x8 = LD $x2, 16
  $x1 = LD $x2, 24
  $x2 = frame-destroy ADDI $x2, 32
  PseudoRET implicit $x10

# End machine code for function main.

