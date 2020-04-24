#include "cminus_builder.hpp"
#include <iostream>

enum var_op {
  LOAD,
  STORE
};

// You can define global variables here
// to store state
using namespace llvm;  
// seems to need a global variable to record whether the last declaration is main
// this is for array to get basicblock ref. correctly
BasicBlock* curr_block;
// the return basicblock, to make code inside function know where to jump to return
BasicBlock* return_block;
// the return value Alloca
Value* return_alloca;
// for BasicBlock::Create to get function ref. 
Function* curr_func;
// record the expression, to be used in while, if and return statements
Value* expression;
// record whether a return statement is encountered. If return is found, following code should be ignored to avoid IR problem.
bool is_returned = false;
bool is_returned_record = false;
int label_cnt = 0;
// show what to do in syntax_var
var_op curr_op;

//#define _DEBUG_PRINT_N_(N) {\
  //std::cout << std::string(N, '-');\
//}
void CminusBuilder::visit(syntax_program &node) {
	//add_depth();
	//_DEBUG_PRINT_N_(depth);
	//std::cout << "program" << std::endl;
	for (auto decl: node.declarations) {
		decl->accept(*this);
	}
	//remove_depth();
}

void CminusBuilder::visit(syntax_num &node) {
	//add_depth();
	//_DEBUG_PRINT_N_(depth);
	//std::cout << "num" << std::endl;
	expression = ConstantInt::get(context, APInt(32, node.value));
	//remove_depth();
}

void CminusBuilder::visit(syntax_var_declaration &node) {
	//add_depth();
	GlobalVariable* gvar;
	// declaration is variable
	if (node.num == nullptr) {
		//_DEBUG_PRINT_N_(depth);
		//std::cout << "var-declaration: " << node.id;
		ConstantInt* const_int = ConstantInt::get(context, APInt(32, 0));
		gvar = new GlobalVariable(*module, 
				PointerType::getInt32Ty(context), 
				false, 
				GlobalValue::CommonLinkage, 
				const_int, 
				node.id);
		//gvar->setAlignment(4);
	}
	// declaration is array
	else {
		//_DEBUG_PRINT_N_(depth);
		//std::cout << "var-declaration: " << node.id << "[" << node.num->value << "]";
		ArrayType* arrType = ArrayType::get(IntegerType::get(context, 32), node.num->value);
		ConstantAggregateZero* constarr = ConstantAggregateZero::get(arrType);
		gvar = new GlobalVariable(*module, 
				arrType, 
				false, 
				GlobalValue::CommonLinkage, 
				constarr, 
				node.id);
	}
	scope.push(node.id, gvar);
	std::cout << std::endl;
	//remove_depth();
}

void CminusBuilder::visit(syntax_fun_declaration &node) {
	//add_depth();
	//_DEBUG_PRINT_N_(depth);
	//scope.enter();
	//std::cout << "fun-declaration: " << node.id << std::endl;
	std::vector<Type *> Vars;
	for (auto param: node.params) {
		if (param->isarray) {
			Vars.push_back(PointerType::getInt32PtrTy(context));
		}
		else {
			Vars.push_back(Type::getInt32Ty(context));
		}
	}
	auto functype = node.type == TYPE_INT ? Type::getInt32Ty(context) : Type::getVoidTy(context);
	auto function = Function::Create(FunctionType::get(functype, Vars, false), 
			GlobalValue::LinkageTypes::ExternalLinkage, 
			node.id, 
			*module);
	scope.push(node.id,function);
	scope.enter();
	curr_func = function;
	return_block = BasicBlock::Create(context, "returnBB", 0, 0);
	auto entrybb = BasicBlock::Create(context, "entry", function);
	builder.SetInsertPoint(entrybb);
	curr_block = entrybb;
	// allocate space for function params, and add to symbol table(scope)
	auto arg = function->arg_begin();
	for (auto param: node.params) {
		if (arg == function->arg_end()) {
			std::cout << "Fatal error: parameter number different!!" << std::endl;
		}
		if (param->isarray) {
			//auto arrType = ArrayType::get()
			//auto param_arr = builder.Create
			auto param_var = builder.CreateAlloca(PointerType::getInt32PtrTy(context));
			scope.push(param->id, param_var);
			builder.CreateStore(arg, param_var);
		}
		else {
			auto param_var = builder.CreateAlloca(Type::getInt32Ty(context)); 
			scope.push(param->id, param_var);
			builder.CreateStore(arg, param_var);
		}
		arg++;
	}
	// allocate the return register
	if(node.type != TYPE_VOID) {
		return_alloca = builder.CreateAlloca(Type::getInt32Ty(context));
	}
	
	// reset label counter for each new function
	label_cnt = 0;

	node.compound_stmt->accept(*this);

	return_block->insertInto(function);
	builder.SetInsertPoint(return_block);
	if(node.type != TYPE_VOID) {
		auto retLoad = builder.CreateLoad(Type::getInt32Ty(context), return_alloca);
		builder.CreateRet(retLoad);
	}
	else {
		builder.CreateRetVoid();
	}

	scope.exit();
	//remove_depth();
}

void CminusBuilder::visit(syntax_param &node) {
	//node.id
	//node.isarray
	//node.type
}

void CminusBuilder::visit(syntax_compound_stmt &node) {
	//add_depth();
	//_DEBUG_PRINT_N_(depth);
	//std::cout << "compound_stmt" << std::endl;
	// a compound_stmt means a new scope
	scope.enter();
	// process var-declaration
	for (auto var_decl: node.local_declarations) {
		if (var_decl->type == TYPE_VOID) {
			std::cout << "Error: no void type variable or array is allowed!" << std::endl;
		}
		// array declaration
		if (var_decl->num != nullptr) {
			auto arrType = ArrayType::get(IntegerType::get(context, 32), var_decl->num->value);
			auto arrptr = builder.CreateAlloca(arrType);
			scope.push(var_decl->id, arrptr);
		}
		// normal variable declaration
		else {
			auto var = builder.CreateAlloca(Type::getInt32Ty(context));
			scope.push(var_decl->id, var);
		}
	}
	is_returned = false;
	for (auto stmt: node.statement_list) {
		stmt->accept(*this);
		if (is_returned)
			break;
	}
	is_returned_record = is_returned;
	is_returned = false;
	scope.exit();
	//remove_depth();
}

void CminusBuilder::visit(syntax_expresion_stmt &node) {
	//add_depth();
	//_DEBUG_PRINT_N_(depth);
	//std::cout << "expression_stmt" << std::endl;
	node.expression->accept(*this);
	//remove_depth();
}

void CminusBuilder::visit(syntax_selection_stmt &node) {
	//add_depth();
	//_DEBUG_PRINT_N_(depth);
	//std::cout << "selection_stmt" << std::endl;
	curr_op = LOAD;
	node.expression->accept(*this);
	// actually this is not needed, as llvm will automatically generate different label name
	char labelname[100];
	BasicBlock* trueBB;
	BasicBlock* falseBB;
	Value* expr1;
	if (expression->getType() == Type::getInt32Ty(context)) {
		expr1 = builder.CreateICmpNE(expression, ConstantInt::get(expression->getType(), 0, true));
	}
	else {
		expr1 = expression;
	}
	// record the current block, for add the br later
	BasicBlock* orig_block = curr_block;
	// create the conditional jump CondBr
	// if-statement
	label_cnt++;
	int label_now = label_cnt;
	sprintf(labelname, "selTrueBB_%d", label_now);
	trueBB = BasicBlock::Create(context, labelname, curr_func);
	builder.SetInsertPoint(trueBB);
	curr_block = trueBB;
	BasicBlock* trueBB_location;
	BasicBlock* falseBB_location;
	bool trueBB_returned;
	bool falseBB_returned;
	node.if_statement->accept(*this);
	trueBB_location = curr_block;
	trueBB_returned = is_returned_record;
	// optional else-statement
	if (node.else_statement != nullptr) {
		sprintf(labelname, "selFalseBB_%d", label_now);
		falseBB = BasicBlock::Create(context, labelname, curr_func);
	}
	if (node.else_statement != nullptr) {
		builder.SetInsertPoint(falseBB);
		curr_block = falseBB;
		node.else_statement->accept(*this);
		falseBB_location = curr_block;
		falseBB_returned = is_returned_record;
	}
	sprintf(labelname, "selEndBB_%d", label_now);
	auto endBB = BasicBlock::Create(context, labelname, curr_func);
	builder.SetInsertPoint(orig_block);
	if (node.else_statement != nullptr) {
		builder.CreateCondBr(expr1, trueBB, falseBB);
	}
	else {
		builder.CreateCondBr(expr1, trueBB, endBB);
	}
	// unconditional jump to make ends meet
	if (!trueBB_returned) {
		builder.SetInsertPoint(trueBB_location);
		builder.CreateBr(endBB);
	}
	if (node.else_statement != nullptr && !falseBB_returned) {
		builder.SetInsertPoint(falseBB_location);
		builder.CreateBr(endBB);
	}
	builder.SetInsertPoint(endBB);
	curr_block = endBB;
	is_returned = false;
	//remove_depth();
}

void CminusBuilder::visit(syntax_iteration_stmt &node) {
	//add_depth();
	//_DEBUG_PRINT_N_(depth);
	//std::cout << "iteration_stmt" << std::endl;
	// iteration_stmt => 
	//
	// 	goto start
	// start:
	// 	if expression goto body else goto end
	// body:
	// 	statement
	// 	goto start
	// end:
	label_cnt++;
	int label_now = label_cnt;
	char labelname[100];
	sprintf(labelname, "loopStartBB_%d", label_now);
	auto startBB = BasicBlock::Create(context, labelname, curr_func);
	// goto start, end former block
	builder.CreateBr(startBB);
	builder.SetInsertPoint(startBB);
	curr_block = startBB;
	curr_op = LOAD;
	node.expression->accept(*this);
	Value* expr1;
	if (expression->getType() == Type::getInt32Ty(context)) {
		expr1 = builder.CreateICmpNE(expression, ConstantInt::get(expression->getType(), 0, true));
	}
	else {
		expr1 = expression;
	}
	sprintf(labelname, "loopBodyBB_%d", label_now);
	auto bodyBB = BasicBlock::Create(context, labelname, curr_func);
	builder.SetInsertPoint(bodyBB);
	curr_block = bodyBB;
	node.statement->accept(*this);
	if (!is_returned_record) {
		builder.CreateBr(startBB);
	}
	sprintf(labelname, "loopEndBB_%d", label_now);
	auto endBB = BasicBlock::Create(context, labelname, curr_func);
	// go back to create the CondBr in it's right location
	builder.SetInsertPoint(startBB);
	builder.CreateCondBr(expr1, bodyBB, endBB);
	builder.SetInsertPoint(endBB);
	curr_block = endBB;
	is_returned = false;
	//remove_depth();
}

void CminusBuilder::visit(syntax_return_stmt &node) {
	//add_depth();
	//_DEBUG_PRINT_N_(depth);
	//std::cout << "return_stmt" << std::endl;
	if (node.expression != nullptr) {
		curr_op = LOAD;
		node.expression->accept(*this);
		Value* retVal;
		if (expression->getType() == Type::getInt1Ty(context)) {
			// cast i1 boolean true or false result to i32 0 or 1
			auto retCast = builder.CreateIntCast(expression, Type::getInt32Ty(context), false);
			retVal = retCast;
			//builder.CreateRet(retCast);
		}
		else if (expression->getType() == Type::getInt32Ty(context)) {
			retVal = expression;
			//builder.CreateRet(expression);
		}
		else {
			std::cout << "Error: unknown expression return type!" << std::endl;
		}
		//builder.CreateRet(retVal);
		builder.CreateStore(retVal, return_alloca);
	}
	else {
		//builder.CreateRetVoid();
	}
	builder.CreateBr(return_block);
	is_returned = true;
	is_returned_record = true;
	//remove_depth();
}

void CminusBuilder::visit(syntax_var &node) {
	//add_depth();
	//_DEBUG_PRINT_N_(depth);
	//std::cout << "var: " << node.id << " op: " << (curr_op == LOAD ? "LOAD" : "STORE") << std::endl;
	switch (curr_op) {
		case LOAD: {
			if (node.expression == nullptr) {
				auto alloca = scope.find(node.id);
				if (alloca->getType() == PointerType::getInt32PtrTy(context)) {
					// normal variable,
					expression = builder.CreateLoad(Type::getInt32Ty(context), alloca);
				}
				else if (alloca->getType() == PointerType::getInt32PtrTy(context)->getPointerTo()) {
					// array reference(pointer to int) variable, treat differently
					// this is resulted from using array as function paramter, 
					// while the array itself is passed to the caller function by reference
					expression = builder.CreateLoad(PointerType::getInt32PtrTy(context), alloca);
				}
				else {
					// it's an array paramter used in call, do a GEP to change arr type to pointer type
					std::vector<Value *> idx;
					idx.push_back(ConstantInt::get(context, APInt(32, 0)));
					idx.push_back(ConstantInt::get(context, APInt(32, 0)));
					expression = builder.CreateGEP(alloca->getType()->getPointerElementType(), alloca, idx);
				}
			}
			else{
				// array
				auto alloca = scope.find(node.id);
				curr_op = LOAD;
				node.expression->accept(*this);
				Value* expr;
				if(expression->getType() == Type::getInt1Ty(context)) {
					expr = builder.CreateIntCast(expression, Type::getInt32Ty(context), false);
				}
				else {
					expr = expression;
				}

				// check if array index is negative
				auto neg = builder.CreateICmpSLT(expression, ConstantInt::get(context, APInt(32, 0)));
				char labelname[100];
				label_cnt++;
				sprintf(labelname, "arr_neg_%d", label_cnt);
				auto arrnegBB = BasicBlock::Create(context, labelname, curr_func);
				sprintf(labelname, "arr_ok_%d", label_cnt);
				auto arrokBB = BasicBlock::Create(context, labelname, curr_func);
				builder.CreateCondBr(neg, arrnegBB, arrokBB);
				builder.SetInsertPoint(arrnegBB);
				std::vector<Value*> argdum;
				builder.CreateCall(scope.find("neg_idx_except"), argdum);
				// add this just to make llvm happy, actually program will abort in call
				builder.CreateBr(arrokBB);
				builder.SetInsertPoint(arrokBB);
				curr_block = arrokBB;

				if (alloca->getType()->getPointerElementType() == PointerType::getInt32PtrTy(context)) {
					// array reference as pointer
					auto arrptr = builder.CreateLoad(PointerType::getInt32PtrTy(context), alloca);
					std::vector<Value *> idx;
					idx.push_back(expr);
					auto gep = builder.CreateGEP(Type::getInt32Ty(context), arrptr, idx);
					expression = builder.CreateLoad(Type::getInt32Ty(context), gep);
				}
				else {
					// local array
					std::vector<Value *> idx;
					idx.push_back(ConstantInt::get(context, APInt(32, 0)));
					idx.push_back(expression);
					auto gep = builder.CreateGEP(alloca->getType()->getPointerElementType(), alloca, idx);
					expression = builder.CreateLoad(Type::getInt32Ty(context), gep);
				}
			}
			break;
		}
		case STORE: {
			if (node.expression == nullptr) {
				// variable
				auto alloca = scope.find(node.id);
				Value* expr;
				if(expression->getType() == Type::getInt1Ty(context)) {
					expr = builder.CreateIntCast(expression, Type::getInt32Ty(context), false);
				}
				else {
					expr = expression;
				}
				builder.CreateStore(expr, alloca);
				expression = expr;
			}
			else{
				curr_op = LOAD;
				auto rhs = expression;
				node.expression->accept(*this);
				Value* expr;
				if(expression->getType() == Type::getInt1Ty(context)) {
					expr = builder.CreateIntCast(expression, Type::getInt32Ty(context), false);
				}
				else {
					expr = expression;
				}

				// check if array index is negative
				auto neg = builder.CreateICmpSLT(expression, ConstantInt::get(context, APInt(32, 0)));
				char labelname[100];
				label_cnt++;
				sprintf(labelname, "arr_neg_%d", label_cnt);
				auto arrnegBB = BasicBlock::Create(context, labelname, curr_func);
				sprintf(labelname, "arr_ok_%d", label_cnt);
				auto arrokBB = BasicBlock::Create(context, labelname, curr_func);
				builder.CreateCondBr(neg, arrnegBB, arrokBB);
				builder.SetInsertPoint(arrnegBB);
				std::vector<Value*> argdum;
				builder.CreateCall(scope.find("neg_idx_except"), argdum);
				// add this just to make llvm happy, actually program will abort in call
				builder.CreateBr(arrokBB);
				builder.SetInsertPoint(arrokBB);
				curr_block = arrokBB;

				auto alloca = scope.find(node.id);
				if (alloca->getType() == PointerType::getInt32PtrTy(context)->getPointerTo()) {
					// array passed by reference, treat as pointer
					// function parameter makes it pointer of pointer, so load first 
					auto arrptr = builder.CreateLoad(PointerType::getInt32PtrTy(context), alloca);
					std::vector<Value *> idx;
					idx.push_back(expr);
					auto gep = builder.CreateGEP(Type::getInt32Ty(context), arrptr, idx);
					builder.CreateStore(rhs, gep);
					expression = expr;

				}
				else {
					// local array or global array, type of which is [100 x i32]* like
					std::vector<Value *> idx;
					idx.push_back(ConstantInt::get(context, APInt(32, 0)));
					idx.push_back(expr);
					auto gep = builder.CreateGEP(alloca->getType()->getPointerElementType(), alloca, idx);
					builder.CreateStore(rhs, gep);
					expression = expr;
				}
			}
			break;
		}
		default: {
			std::cout << "ERROR: wrong var op!" << std::endl;
		}
	}
	//remove_depth();
}

void CminusBuilder::visit(syntax_assign_expression &node) {
	//add_depth();
	//_DEBUG_PRINT_N_(depth);
	//std::cout << "assign_expression" << std::endl;

	curr_op = LOAD;
	node.expression->accept(*this);

	curr_op = STORE;
	node.var->accept(*this);
	//remove_depth();
}

void CminusBuilder::visit(syntax_simple_expression &node) {
	//add_depth();
	//_DEBUG_PRINT_N_(depth);
	//std::cout << "simple_expression" << std::endl;

	curr_op = LOAD;
	node.additive_expression_l->accept(*this);
	if(node.additive_expression_r != nullptr) {
		Value* lhs = expression;
		curr_op = LOAD;
		node.additive_expression_r->accept(*this);
		Value* rhs = expression;
		switch (node.op) {
			case OP_LE:
				expression = builder.CreateICmpSLE(lhs, rhs);
				break;
			case OP_LT:
				expression = builder.CreateICmpSLT(lhs, rhs);
				break;
			case OP_GT:
				expression = builder.CreateICmpSGT(lhs, rhs);
				break;
			case OP_GE:
				expression = builder.CreateICmpSGE(lhs, rhs);
				break;
			case OP_EQ:
				expression = builder.CreateICmpEQ(lhs, rhs);
				break;
			case OP_NEQ:
				expression = builder.CreateICmpNE(lhs, rhs);
				break;
		}
	}
	//remove_depth();
}

void CminusBuilder::visit(syntax_additive_expression &node) {
	//add_depth();
	//_DEBUG_PRINT_N_(depth);
	//std::cout << "additive_expression" << std::endl;

	if (node.additive_expression == nullptr) {
		curr_op = LOAD;
		node.term->accept(*this);
	}
	else {
		curr_op = LOAD;
		node.additive_expression->accept(*this);
		Value* lhs = expression;
		curr_op = LOAD;
		node.term->accept(*this);
		Value* rhs = expression;
		switch (node.op) {
			case OP_PLUS:
				expression = builder.CreateAdd(lhs, rhs);
				break;
			case OP_MINUS:
				expression = builder.CreateSub(lhs, rhs);
				break;
		}
	}
	//remove_depth();
}

void CminusBuilder::visit(syntax_term &node) {
	//add_depth();
	//_DEBUG_PRINT_N_(depth);
	//std::cout << "term" << std::endl;

	if (node.term == nullptr) {
		curr_op = LOAD;
		node.factor->accept(*this);
	}
	else {
		curr_op = LOAD;
		node.term->accept(*this);
		Value* lhs = expression;
		curr_op = LOAD;
		node.factor->accept(*this);
		Value* rhs = expression;
		switch (node.op) {
			case OP_MUL:
				expression = builder.CreateMul(lhs, rhs);
				break;
			case OP_DIV:
				expression = builder.CreateUDiv(lhs, rhs);
				break;
		}
	}
	//remove_depth();
}

void CminusBuilder::visit(syntax_call &node) {
	//add_depth();
	//_DEBUG_PRINT_N_(depth);
	//std::cout << "call: " << node.id << "()" << std::endl;
	auto func=scope.find(node.id);
	if(func==nullptr){
		std::cout << "ERROR: Unknown function: " << node.id << std::endl;
		exit(1);
	}
	std::vector<Value*> args;
	for (auto arg: node.args) {
		arg->accept(*this);
		args.push_back(expression);
	}
	expression=builder.CreateCall(func,args);
	//remove_depth();
}
