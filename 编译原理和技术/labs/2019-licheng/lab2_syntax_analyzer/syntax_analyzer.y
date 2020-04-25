%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "common/common.h"
#include "syntax_tree/SyntaxTree.h"

#include "lab1_lexical_analyzer/lexical_analyzer.h"

// uncomment this to generate tree-generation python files
/*#define TREE_GEN_GRAPH*/
/*#define TREE_GEN_TEXT*/

// external functions from lex
extern int yylex();
extern int yyparse();
extern int yyrestart();
extern FILE * yyin;

// external variables from lexical_analyzer module
extern myloc* pmyloc;
/*extern int lines;*/
extern char * yytext;

// Global syntax tree.
SyntaxTree * gt;

void yyerror(const char * s);

void callback(int p, void* ptr)
{
#ifdef TREE_GEN_TEXT
	if (p == 1) {
		printSyntaxTreeNode(stdout, (SyntaxTreeNode*)ptr, 0);
	}
#endif
#ifdef TREE_GEN_GRAPH
	static FILE* fout;
	static char* output;
	static int counter;
	if (p == 1) {
		printSyntaxTreeNodeGraphic(fout, (SyntaxTreeNode*)ptr);
		/*fprintf(fout, "treefromsyntaxtree.get_svg().saveas(\"%s_%d.svg\")\n", output, ++counter);*/
	}
	else if (p == 0) {
		printf("[DEBUG TREE] start new file...\n");
		counter = 0;
		char outputpathtree[256] = "./treegraph/";
		output = ptr;
		strcat(outputpathtree, output);
		strcat(outputpathtree, ".py");
		printf("[DEBUG TREE] generate python script %s...\n", outputpathtree);
		fout = fopen(outputpathtree, "w");
		fprintf(fout, "#!/usr/bin/env python3\nfrom IPython.core.interactiveshell import InteractiveShell\nInteractiveShell.ast_node_interactivity = \"all\"\nimport svgling\n");
	}
	else if (p == -1) {
		printf("[DEBUG TREE] done.\n");
		fclose(fout);
	}
#endif
	return;
}
%}

%union {
	SyntaxTreeNode * node;
}

%token <node> ERROR ADD SUB MUL DIV LT LTE GT GTE EQ NEQ ASSIN SEMICOLON COMMA LPARENTHESE RPARENTHESE LBRACKET RBRACKET LBRACE RBRACE ELSE IF INT RETURN VOID WHILE ID NUMBER ARRAY LETTER EOL COMMENT BLANK
%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

/********** TODO: Your token definition here ***********/

/* compulsory starting symbol */
%start program

%%
/*************** TODO: Your rules here *****************/
program : declaration_list {gt->root = newSyntaxTreeNode("program"); SyntaxTreeNode_AddChild(gt->root, $<node>1);callback(1, $<node>$);}
	;
declaration_list : declaration_list declaration {$<node>$ = newSyntaxTreeNode("declaration-list"); SyntaxTreeNode_AddChild($<node>$, $<node>1); SyntaxTreeNode_AddChild($<node>$, $<node>2);callback(1, $<node>$);}
		 | declaration {$<node>$ = newSyntaxTreeNode("declaration-list"); SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
		 ;
declaration : var_declaration {$<node>$ = newSyntaxTreeNode("declaration");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
	    | fun_declaration {$<node>$ = newSyntaxTreeNode("declaration");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
	    ;
var_declaration : type_specifier ID SEMICOLON {$<node>$ = newSyntaxTreeNode("var-declaration"); SyntaxTreeNode_AddChild($<node>$, $<node>1); SyntaxTreeNode_AddChild($<node>$, $<node>2);SyntaxTreeNode_AddChild($<node>$, $<node>3);callback(1, $<node>$);}
		| type_specifier ID LBRACKET NUMBER RBRACKET SEMICOLON {$<node>$ = newSyntaxTreeNode("var-declaration"); SyntaxTreeNode_AddChild($<node>$, $<node>1); SyntaxTreeNode_AddChild($<node>$, $<node>2); SyntaxTreeNode_AddChild($<node>$, $<node>3); SyntaxTreeNode_AddChild($<node>$, $<node>4);SyntaxTreeNode_AddChild($<node>$, $<node>5);SyntaxTreeNode_AddChild($<node>$, $<node>6);callback(1, $<node>$);}
		;
type_specifier : INT {$<node>$ = newSyntaxTreeNode("type-specifier"); SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
	       | VOID {$<node>$ = newSyntaxTreeNode("type-specifier"); SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
	       ;
fun_declaration : type_specifier ID LPARENTHESE params RPARENTHESE compound_stmt {$<node>$ = newSyntaxTreeNode("fun-declaration"); SyntaxTreeNode_AddChild($<node>$, $<node>1); SyntaxTreeNode_AddChild($<node>$, $<node>2); SyntaxTreeNode_AddChild($<node>$, $<node>3); SyntaxTreeNode_AddChild($<node>$, $<node>4); SyntaxTreeNode_AddChild($<node>$, $<node>5); SyntaxTreeNode_AddChild($<node>$, $<node>6);callback(1, $<node>$);}
		;
params : param_list  {$<node>$ = newSyntaxTreeNode("params"); SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
       | VOID {$<node>$ = newSyntaxTreeNode("params"); SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
       ;
param_list : param_list COMMA param {$<node>$ = newSyntaxTreeNode("param-list"); SyntaxTreeNode_AddChild($<node>$, $<node>1);SyntaxTreeNode_AddChild($<node>$, $<node>2);SyntaxTreeNode_AddChild($<node>$, $<node>3);callback(1, $<node>$);}
	   | param {$<node>$ = newSyntaxTreeNode("param-list"); SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
	   ;
param : type_specifier ID {$<node>$ = newSyntaxTreeNode("param");SyntaxTreeNode_AddChild($<node>$, $<node>1);SyntaxTreeNode_AddChild($<node>$, $<node>2);callback(1, $<node>$);}
      | type_specifier ID ARRAY {$<node>$ = newSyntaxTreeNode("param");SyntaxTreeNode_AddChild($<node>$, $<node>1);SyntaxTreeNode_AddChild($<node>$, $<node>2);SyntaxTreeNode_AddChild($<node>$, $<node>3);callback(1, $<node>$);}
      ;
compound_stmt : LBRACE local_declarations statement_list RBRACE {$<node>$ = newSyntaxTreeNode("compound-stmt");SyntaxTreeNode_AddChild($<node>$, $<node>1);SyntaxTreeNode_AddChild($<node>$, $<node>2);SyntaxTreeNode_AddChild($<node>$, $<node>3);SyntaxTreeNode_AddChild($<node>$, $<node>4);callback(1, $<node>$);}
	      ;
local_declarations : local_declarations var_declaration {$<node>$ = newSyntaxTreeNode("local-declarations");SyntaxTreeNode_AddChild($<node>$, $<node>1);SyntaxTreeNode_AddChild($<node>$, $<node>2);callback(1, $<node>$);}
		   | epsilon {$<node>$ = newSyntaxTreeNode("local-declarations");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
		   ;
statement_list : statement_list statement {$<node>$ = newSyntaxTreeNode("statement-list");SyntaxTreeNode_AddChild($<node>$, $<node>1);SyntaxTreeNode_AddChild($<node>$, $<node>2);callback(1, $<node>$);}
	       | epsilon {$<node>$ = newSyntaxTreeNode("statement-list");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
	       ;
statement: expression_stmt {$<node>$ = newSyntaxTreeNode("statement");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
         | compound_stmt {$<node>$ = newSyntaxTreeNode("statement");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
         | selection_stmt {$<node>$ = newSyntaxTreeNode("statement");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
         | iteration_stmt {$<node>$ = newSyntaxTreeNode("statementt");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
         | return_stmt {$<node>$ = newSyntaxTreeNode("statement");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
         ;
expression_stmt : expression SEMICOLON {$<node>$ = newSyntaxTreeNode("expression-stmt");SyntaxTreeNode_AddChild($<node>$, $<node>1);SyntaxTreeNode_AddChild($<node>$, $<node>2);callback(1, $<node>$);}
		| SEMICOLON {$<node>$ = newSyntaxTreeNode("expression-stmt");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
		;
selection_stmt : IF LPARENTHESE expression RPARENTHESE statement %prec LOWER_THAN_ELSE {$<node>$ = newSyntaxTreeNode("selection-stmt");SyntaxTreeNode_AddChild($<node>$, $<node>1);SyntaxTreeNode_AddChild($<node>$, $<node>2);SyntaxTreeNode_AddChild($<node>$, $<node>3);SyntaxTreeNode_AddChild($<node>$, $<node>4);SyntaxTreeNode_AddChild($<node>$, $<node>5);callback(1, $<node>$);}
	       | IF LPARENTHESE expression RPARENTHESE statement ELSE statement {$<node>$ = newSyntaxTreeNode("selection-stmt");SyntaxTreeNode_AddChild($<node>$, $<node>1);SyntaxTreeNode_AddChild($<node>$, $<node>2);SyntaxTreeNode_AddChild($<node>$, $<node>3);SyntaxTreeNode_AddChild($<node>$, $<node>4);SyntaxTreeNode_AddChild($<node>$, $<node>5);SyntaxTreeNode_AddChild($<node>$, $<node>6);SyntaxTreeNode_AddChild($<node>$, $<node>7);callback(1, $<node>$);}
	       ;
iteration_stmt : WHILE LPARENTHESE expression RPARENTHESE statement {$<node>$ = newSyntaxTreeNode("iteration-stmt");SyntaxTreeNode_AddChild($<node>$, $<node>1);SyntaxTreeNode_AddChild($<node>$, $<node>2);SyntaxTreeNode_AddChild($<node>$, $<node>3);SyntaxTreeNode_AddChild($<node>$, $<node>4);SyntaxTreeNode_AddChild($<node>$, $<node>5);callback(1, $<node>$);}
	       ;
return_stmt : RETURN SEMICOLON {$<node>$ = newSyntaxTreeNode("return-stmt");SyntaxTreeNode_AddChild($<node>$, $<node>1);SyntaxTreeNode_AddChild($<node>$, $<node>2);callback(1, $<node>$);}
	    | RETURN expression SEMICOLON {$<node>$ = newSyntaxTreeNode("return-stmt");SyntaxTreeNode_AddChild($<node>$, $<node>1);SyntaxTreeNode_AddChild($<node>$, $<node>2);SyntaxTreeNode_AddChild($<node>$, $<node>3);callback(1, $<node>$);}
	    ;
expression : var ASSIN expression {$<node>$ = newSyntaxTreeNode("expression");SyntaxTreeNode_AddChild($<node>$, $<node>1);SyntaxTreeNode_AddChild($<node>$, $<node>2);SyntaxTreeNode_AddChild($<node>$, $<node>3);callback(1, $<node>$);}
	   | simple_expression {$<node>$ = newSyntaxTreeNode("expression");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
	   ;
var : ID {$<node>$ = newSyntaxTreeNode("var");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
    | ID LBRACKET expression RBRACKET {$<node>$ = newSyntaxTreeNode("var");SyntaxTreeNode_AddChild($<node>$, $<node>1);SyntaxTreeNode_AddChild($<node>$, $<node>2);SyntaxTreeNode_AddChild($<node>$, $<node>3);SyntaxTreeNode_AddChild($<node>$, $<node>4);callback(1, $<node>$);}
    ;
simple_expression : additive_expression relop additive_expression  {$<node>$ = newSyntaxTreeNode("simple-expression");SyntaxTreeNode_AddChild($<node>$, $<node>1);SyntaxTreeNode_AddChild($<node>$, $<node>2);SyntaxTreeNode_AddChild($<node>$, $<node>3);callback(1, $<node>$);}
		  | additive_expression {$<node>$ = newSyntaxTreeNode("simple-expression");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
		  ;
relop : LTE {$<node>$ = newSyntaxTreeNode("relop");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
      | LT {$<node>$ = newSyntaxTreeNode("relop");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
      | GT {$<node>$ = newSyntaxTreeNode("relop");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
      | GTE {$<node>$ = newSyntaxTreeNode("relop");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
      | EQ {$<node>$ = newSyntaxTreeNode("relop");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
      | NEQ {$<node>$ = newSyntaxTreeNode("relop");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
      ;
additive_expression : additive_expression addop term {$<node>$ = newSyntaxTreeNode("additive-expression");SyntaxTreeNode_AddChild($<node>$, $<node>1);SyntaxTreeNode_AddChild($<node>$, $<node>2);SyntaxTreeNode_AddChild($<node>$, $<node>3);callback(1, $<node>$);}
		    | term {$<node>$ = newSyntaxTreeNode("additive-expression");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
		    ;
addop : ADD {$<node>$ = newSyntaxTreeNode("addop");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
      | SUB {$<node>$ = newSyntaxTreeNode("addop");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
      ;
term : term mulop factor {$<node>$ = newSyntaxTreeNode("term");SyntaxTreeNode_AddChild($<node>$, $<node>1);SyntaxTreeNode_AddChild($<node>$, $<node>2);SyntaxTreeNode_AddChild($<node>$, $<node>3);callback(1, $<node>$);}
     | factor {$<node>$ = newSyntaxTreeNode("term");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
     ;
mulop : MUL {$<node>$ = newSyntaxTreeNode("mulop");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
      | DIV {$<node>$ = newSyntaxTreeNode("mulop");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
      ;
factor : LPARENTHESE expression RPARENTHESE {$<node>$ = newSyntaxTreeNode("factor");SyntaxTreeNode_AddChild($<node>$, $<node>1);SyntaxTreeNode_AddChild($<node>$, $<node>2);SyntaxTreeNode_AddChild($<node>$, $<node>3);callback(1, $<node>$);}
       | var {$<node>$ = newSyntaxTreeNode("factor");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
       | call {$<node>$ = newSyntaxTreeNode("factor");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
       | NUMBER {$<node>$ = newSyntaxTreeNode("factor");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
       ;
call : ID LPARENTHESE args RPARENTHESE {$<node>$ = newSyntaxTreeNode("call");SyntaxTreeNode_AddChild($<node>$, $<node>1);SyntaxTreeNode_AddChild($<node>$, $<node>2);SyntaxTreeNode_AddChild($<node>$, $<node>3);SyntaxTreeNode_AddChild($<node>$, $<node>4);callback(1, $<node>$);}
     ;
args : arg_list {$<node>$ = newSyntaxTreeNode("args");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
     | epsilon {$<node>$ = newSyntaxTreeNode("args");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
     ;
arg_list : arg_list COMMA expression {$<node>$ = newSyntaxTreeNode("arg-list");SyntaxTreeNode_AddChild($<node>$, $<node>1);SyntaxTreeNode_AddChild($<node>$, $<node>2);SyntaxTreeNode_AddChild($<node>$, $<node>3);callback(1, $<node>$);}
	 | expression {$<node>$ = newSyntaxTreeNode("arg-list");SyntaxTreeNode_AddChild($<node>$, $<node>1);callback(1, $<node>$);}
	 ;
epsilon : {$<node>$ = newSyntaxTreeNode("epsilon");callback(1, $<node>$);}
	;

%%

void yyerror(const char * s)
{
	fprintf(stderr, "%s:%d syntax error for %s\n", s, pmyloc->first_line, yytext);
}

/// \brief Syntax analysis from input file to output file
///
/// \param input basename of input file
/// \param output basename of output file
void syntax(const char * input, const char * output)
{
	gt = newSyntaxTree();

	char inputpath[256] = "./testcase/";
	char outputpath[256] = "./syntree/";
	strcat(inputpath, input);
	strcat(outputpath, output);

	if (!(yyin = fopen(inputpath, "r"))) {
		fprintf(stderr, "[ERR] Open input file %s failed.", inputpath);
		exit(1);
	}
	yyrestart(yyin);
	printf("[START]: Syntax analysis start for %s\n", input);
	FILE * fp = fopen(outputpath, "w+");
	if (!fp)	return;

	// reinitialize position counter
	pmyloc->first_line = pmyloc->first_column = pmyloc->last_line = pmyloc->last_column = 1;
#ifdef TREE_GEN_GRAPH
	callback(0, output);
#endif

	// yyerror() is invoked when yyparse fail. If you still want to check the return value, it's OK.
	// `while (!feof(yyin))` is not needed here. We only analyze once.
	//
	// If error occurs when parsing, nothing will be printed into output file, but tree data will still
	// availiable in stdout or tree file
	if ( yyparse() != 0 ) {
		printf("[ERR] Error parsing %s. Abort. \n", input);
	}
	else {
		printf("[OUTPUT] Printing tree to output file %s\n", outputpath);
		printSyntaxTree(fp, gt);
		deleteSyntaxTree(gt);
		gt = 0;
		printf("[END] Syntax analysis end for %s\n", input);
	}

#ifdef TREE_GEN_GRAPH
	callback(-1, NULL);
#endif
	fclose(fp);
}

/// \brief starting function for testing syntax module.
///
/// Invoked in test_syntax.c
int syntax_main(int argc, char ** argv)
{
/*#ifdef YYDEBUG*/
	/*extern int yydebug;*/
	/*yydebug = 1;*/
/*#endif*/
	char filename[50][256];
	char output_file_name[256];
	char suffix[] = ".syntax_tree";
	char extension[] = ".cminus";
	int fn = getAllTestcase(filename);
	for (int i = 0; i < fn; i++) {
		strcpy(output_file_name, filename[i]);
		strcpy(output_file_name + strlen(output_file_name) - strlen(extension), suffix);
		syntax(filename[i], output_file_name);
	}
	return 0;
}
