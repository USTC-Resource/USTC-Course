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
	auto module = new Module("if", context);
	auto mainFunc = Function::Create(
			FunctionType::get(TYPE32, false), 
			GlobalValue::LinkageTypes::ExternalLinkage, 
			"main", module);
	// entry:
	auto bb = BasicBlock::Create(context, "entry", mainFunc);
	builder.SetInsertPoint(bb);
	// 2 (b)
	auto bAlloca = builder.CreateAlloca(TYPE32);
	builder.CreateStore(CONST(2), bAlloca);
	auto bLoad = builder.CreateLoad(bAlloca);
	// 1 (a)
	auto aAlloca = builder.CreateAlloca(TYPE32);
	builder.CreateStore(CONST(1), aAlloca);
	auto aLoad = builder.CreateLoad(aAlloca);
	// compare 2>1?
	auto icmp = builder.CreateICmpSGT(bLoad, aLoad);
	// true and false branch
	auto trueBB = BasicBlock::Create(context, "trueBB", mainFunc);
	auto falseBB = BasicBlock::Create(context, "falseBB", mainFunc);
	builder.CreateCondBr(icmp, trueBB, falseBB);
	// true, return 1
	builder.SetInsertPoint(trueBB);
	builder.CreateRet(CONST(1));
	// false, return 0
	builder.SetInsertPoint(falseBB);
	builder.CreateRet(CONST(0));
	builder.ClearInsertionPoint();
	//// ret 
	module->print(outs(), nullptr);
	delete module;
	return 0;
}
