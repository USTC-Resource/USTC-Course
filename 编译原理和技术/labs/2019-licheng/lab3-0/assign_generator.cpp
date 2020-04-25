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
	auto module = new Module("assign", context);
	auto mainFunc = Function::Create(
			FunctionType::get(TYPE32, false), 
			GlobalValue::LinkageTypes::ExternalLinkage, 
			"main", module);
	// entry:
	auto bb = BasicBlock::Create(context, "entry", mainFunc);
	builder.SetInsertPoint(bb);
	// a = 1
	auto aAlloca = builder.CreateAlloca(TYPE32);
	builder.CreateStore(CONST(1), aAlloca);
	auto aLoad = builder.CreateLoad(aAlloca);
	// ret a
	builder.CreateRet(aLoad);
	module->print(outs(), nullptr);
	delete module;
	return 0;
}
