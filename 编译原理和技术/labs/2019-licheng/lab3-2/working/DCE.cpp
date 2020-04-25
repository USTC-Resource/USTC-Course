//===- DCE.cpp - Code to perform dead code elimination --------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file implements dead inst elimination and dead code elimination.
//
// Dead Inst Elimination performs a single pass over the function removing
// instructions that are obviously dead.  Dead Code Elimination is similar, but
// it rechecks instructions that were used by removed instructions to see if
// they are newly dead.
//
//===----------------------------------------------------------------------===//

#include "llvm/Transforms/Scalar/DCE.h"
#include "llvm/ADT/SetVector.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/Transforms/Utils/Local.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instruction.h"
#include "llvm/Pass.h"
#include "llvm/Support/DebugCounter.h"
#include "llvm/Transforms/Scalar.h"
using namespace llvm;

#define DEBUG_TYPE "dce"

STATISTIC(DIEEliminated, "Number of insts removed by DIE pass");
STATISTIC(DCEEliminated, "Number of insts removed");
DEBUG_COUNTER(DCECounter, "dce-transform",
              "Controls which instructions are eliminated");

namespace {
  //===--------------------------------------------------------------------===//
  // DeadInstElimination pass implementation
  //
  struct DeadInstElimination : public BasicBlockPass {
    static char ID; // Pass identification, replacement for typeid
    DeadInstElimination() : BasicBlockPass(ID) {
      initializeDeadInstEliminationPass(*PassRegistry::getPassRegistry());
    }
    bool runOnBasicBlock(BasicBlock &BB) override {
// judge skip or not. Problem: details about skipBasicBlock??
      if (skipBasicBlock(BB))
        return false;
      auto *TLIP = getAnalysisIfAvailable<TargetLibraryInfoWrapperPass>();
      TargetLibraryInfo *TLI = TLIP ? &TLIP->getTLI() : nullptr;
      bool Changed = false;
// traverse each code in the basic block
      for (BasicBlock::iterator DI = BB.begin(); DI != BB.end(); ) {
        Instruction *Inst = &*DI++;
// if instruction is dead, then remove it (eraseFromParent), set Changed bit, and deal with debug things and update eliminate counter
        if (isInstructionTriviallyDead(Inst, TLI)) {
          if (!DebugCounter::shouldExecute(DCECounter))
            continue;
          salvageDebugInfo(*Inst);
          Inst->eraseFromParent();
          Changed = true;
          ++DIEEliminated;
        }
      }
      return Changed;
    }

    void getAnalysisUsage(AnalysisUsage &AU) const override {
      AU.setPreservesCFG();
    }
  };
}

// seems here is where the DIE pass is registered. 
char DeadInstElimination::ID = 0;
INITIALIZE_PASS(DeadInstElimination, "die",
                "Dead Instruction Elimination", false, false)

Pass *llvm::createDeadInstEliminationPass() {
  return new DeadInstElimination();
}

// ok here starts DCE, a slightly harder one

// this is used to visit every instruction in function
// if any instruction can be eliminated, do something(check all it's operands)
// else just do nothing
static bool DCEInstruction(Instruction *I,
                           SmallSetVector<Instruction *, 16> &WorkList,
                           const TargetLibraryInfo *TLI) {
  if (isInstructionTriviallyDead(I, TLI)) {
    if (!DebugCounter::shouldExecute(DCECounter))
      return false;

    salvageDebugInfo(*I);

    // Null out all of the instruction's operands to see if any operand becomes
    // dead as we go.
    for (unsigned i = 0, e = I->getNumOperands(); i != e; ++i) {
// loop to get operand. I is the dead father
// https://stackoverflow.com/questions/8651829/getting-the-operands-in-an-llvm-instruction
// the operand is actually another instruction
      Value *OpV = I->getOperand(i);
      I->setOperand(i, nullptr);

//TODO:use_empty??? or the operand is the instruction itself???
      if (!OpV->use_empty() || I == OpV)
        continue;

      // If the operand is an instruction that became dead as we nulled out the
      // operand, and if it is 'trivially' dead, delete it in a future loop
      // iteration.
      if (Instruction *OpI = dyn_cast<Instruction>(OpV))
        if (isInstructionTriviallyDead(OpI, TLI))
// found new dead code, insert into eliminate queue
          WorkList.insert(OpI);
    }

    I->eraseFromParent();
    ++DCEEliminated;
    return true;
  }
  return false;
}

// i think this is the main dce function, it calls the core function DCEInstruction
// it's a iteration structure
static bool eliminateDeadCode(Function &F, TargetLibraryInfo *TLI) {
// MadeChange records whether there are any change, easy to understand
  bool MadeChange = false;
  SmallSetVector<Instruction *, 16> WorkList;
  // Iterate over the original function, only adding insts to the worklist
  // if they actually need to be revisited. This avoids having to pre-init
  // the worklist with the entire function's worth of instructions.
// initialize and first pass elimination
  for (inst_iterator FI = inst_begin(F), FE = inst_end(F); FI != FE;) {
    Instruction *I = &*FI;
    ++FI;

    // We're visiting this instruction now, so make sure it's not in the
    // worklist from an earlier visit.
// try to eliminate all instructions in function, 
// TODO: why this if is needed? can a DCEInstruction enqueue instructions after the instruction being analyzed?
    if (!WorkList.count(I))
      MadeChange |= DCEInstruction(I, WorkList, TLI);
  }

// iteration pass, continue until nothing can be annihilated, this is easy to understant
// seems this pass works "reversely", first eliminate an operator, then eliminate previous operands
  while (!WorkList.empty()) {
    Instruction *I = WorkList.pop_back_val();
    MadeChange |= DCEInstruction(I, WorkList, TLI);
  }
  return MadeChange;
}

// run, the interface, as is des//what des??
PreservedAnalyses DCEPass::run(Function &F, FunctionAnalysisManager &AM) {
  if (!eliminateDeadCode(F, AM.getCachedResult<TargetLibraryAnalysis>(F)))
    return PreservedAnalyses::all();

  PreservedAnalyses PA;
  PA.preserveSet<CFGAnalyses>();
  return PA;
}

// this is like a wapper?
namespace {
struct DCELegacyPass : public FunctionPass {
  static char ID; // Pass identification, replacement for typeid
  DCELegacyPass() : FunctionPass(ID) {
    initializeDCELegacyPassPass(*PassRegistry::getPassRegistry());
  }

  bool runOnFunction(Function &F) override {
    if (skipFunction(F))
      return false;

    auto *TLIP = getAnalysisIfAvailable<TargetLibraryInfoWrapperPass>();
    TargetLibraryInfo *TLI = TLIP ? &TLIP->getTLI() : nullptr;

// real call here
    return eliminateDeadCode(F, TLI);
  }

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.setPreservesCFG();
  }
};
}

char DCELegacyPass::ID = 0;
INITIALIZE_PASS(DCELegacyPass, "dce", "Dead Code Elimination", false, false)

FunctionPass *llvm::createDeadCodeEliminationPass() {
  return new DCELegacyPass();
}
