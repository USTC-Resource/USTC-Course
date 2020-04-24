#include <llvm/IR/IRBuilder.h>
//#include <llvm/IR/BasicBlock.h>
//#include <llvm/IR/Constant.h>
//#include <llvm/IR/LLVMContext.h>
//#include <llvm/IR/Type.h>


#include <iostream>
#include <memory>

#ifdef DEBUG
#define DEBUG_OUTPUT std::cout << __LINE__ << std::endl;
#else
#define DEBUG_OUTPUT
#endif

using namespace llvm;
#define CONST(num) \
	ConstantInt::get(context, APInt(32, num))

int main()
{
	LLVMContext context;
	Type *TYPE32 = Type::getInt32Ty(context);
	IRBuilder<> builder(context);
	auto module = new Module("while", context);
	auto mainFunc = Function::Create(
			FunctionType::get(TYPE32, false), 
			GlobalValue::LinkageTypes::ExternalLinkage, 
			"main", module);
	// entry:
	auto bb = BasicBlock::Create(context, "entry", mainFunc);
	builder.SetInsertPoint(bb);
	// a = 10
	auto aAlloca = builder.CreateAlloca(TYPE32);
	builder.CreateStore(CONST(10), aAlloca);
	auto aLoad = builder.CreateLoad(aAlloca);
	// i = 0
	auto iAlloca = builder.CreateAlloca(TYPE32);
	builder.CreateStore(CONST(0), iAlloca);
	auto iLoad = builder.CreateLoad(iAlloca);
	// compare i<10?
	auto icmp = builder.CreateICmpSLT(iLoad, CONST(10));
	// true and end branch
	auto trueBB = BasicBlock::Create(context, "trueBB", mainFunc);
	auto endd = BasicBlock::Create(context, "endd", mainFunc);
	builder.CreateCondBr(icmp, trueBB, endd);
	// trueBB: continue loop
	builder.SetInsertPoint(trueBB);
	// i = i + 1
	iLoad = builder.CreateLoad(iAlloca);
	auto iNew = builder.CreateNSWAdd(iLoad, CONST(1));
	builder.CreateStore(iNew, iAlloca);
	// a = a + i
	aLoad = builder.CreateLoad(aAlloca);
	auto aNew = builder.CreateNSWAdd(aLoad, iNew);
	builder.CreateStore(aNew, aAlloca);
	// compare & branch: repeat or end
	icmp = builder.CreateICmpSLT(iNew, CONST(10));
	builder.CreateCondBr(icmp, trueBB, endd);
	//builder.CreateBr(endd);
	// endd: return a
	builder.SetInsertPoint(endd);
	aLoad = builder.CreateLoad(aAlloca);
	builder.CreateRet(aLoad);
	builder.ClearInsertionPoint();
	// End. 
	module->print(outs(), nullptr);
	delete module;
	return 0;
}
