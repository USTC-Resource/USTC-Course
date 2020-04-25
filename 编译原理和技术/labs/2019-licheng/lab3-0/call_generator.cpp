#include <llvm/IR/IRBuilder.h>


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
	auto module = new Module("call", context);
	auto mainFunc = Function::Create(
			FunctionType::get(TYPE32, false), 
			GlobalValue::LinkageTypes::ExternalLinkage, 
			"main", module);
	auto calleeFunc = Function::Create(
			FunctionType::get(TYPE32, TYPE32, false),
			GlobalValue::LinkageTypes::ExternalLinkage, 
			"callee", module);
	// calleeFunc
	auto bb = BasicBlock::Create(context, "entry", calleeFunc);
	builder.SetInsertPoint(bb);
	auto aAlloca = builder.CreateAlloca(TYPE32);
	// the first and only arg
	auto arg = calleeFunc->arg_begin();
	builder.CreateStore(arg, aAlloca);
	auto aLoad = builder.CreateLoad(aAlloca);
	// return 2 * A
	auto resultRet = builder.CreateNSWMul(CONST(2), aLoad);
	builder.CreateRet(resultRet);
	builder.SetInsertPoint(bb);
	// mainFunc
	// entry:
	bb = BasicBlock::Create(context, "entry", mainFunc);
	builder.SetInsertPoint(bb);
	// prepare 10 (a)
	aAlloca = builder.CreateAlloca(TYPE32);
	builder.CreateStore(CONST(10), aAlloca);
	// call with 10 & ret
	aLoad = builder.CreateLoad(aAlloca);
	auto call = builder.CreateCall(calleeFunc, aLoad);
	builder.CreateRet(call);
	builder.ClearInsertionPoint();
	module->print(outs(), nullptr);
	delete module;
	return 0;
}
