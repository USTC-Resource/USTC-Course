%option noyywrap
%{
/*****************声明和选项设置  begin*****************/
#include <stdio.h>
#include <stdlib.h>

#include "lab1_lexical_analyzer/lexical_analyzer.h"
#include "common/common.h"
#include "syntax_tree/SyntaxTree.h"

#ifndef LAB1_ONLY
#include "syntax_analyzer.h"
#endif

myloc ml;
myloc* pmyloc = &ml;
#define YY_USER_ACTION \
    pmyloc->first_line = pmyloc->last_line; \
    pmyloc->first_column = pmyloc->last_column; \
    for(int i = 0; yytext[i] != '\0'; i++) { \
	if(yytext[i] == '\n') { \
	    pmyloc->last_line++; \
	    pmyloc->last_column = 1; \
	} \
	else { \
	    pmyloc->last_column++; \
	} \
    }
/*****************end*****************/

void action(Token t)
{
#ifndef LAB1_ONLY
	// use actual number instead of just NUM identifier
	/*if (t == NUMBER) {*/
		/*yylval.node = newSyntaxTreeNode("number:");*/
		/*strncat(yylval.node->name, yytext, 20);*/
		/*strncpy(yylval.node->name, yytext, 30);*/
		/*yylval.node->name = */
	/*}*/
	/*else {*/
	/*}*/
	yylval.node = newSyntaxTreeNode(strtoken(t));
	strncpy(yylval.node->name, yytext, 30);
	/*printf("action string for tree: %s\n", yylval.node->name);*/
#endif
}

int lab1_only()
{
#ifndef LAB1_ONLY
	return 0;
#else
	return 1;
#endif
}

// Two patterns provided by TA
// identifierPattern [a-zA-Z][a-zA-Z]*


%}

DIGIT [0-9]
 /*NUM {DIGIT}+*/
NUM (0|[1-9]{DIGIT}*)
LETTERS [a-zA-Z]
ID {LETTERS}+
 /*ID [a-zA-Z_][a-zA-Z0-9_]**/
commentPattern "/*"([^\*]|(\*)*[^\*/])*(\*)*"*/"

%%

 /****请在此补全所有flex的模式与动作  start******/

\n {if(lab1_only()) return EOL;}
 /* comments */
 /* \/\*(\/?([^\*\/]|\n)*\*?([^\*\/]|\n)+\/?)**\*\/ {if(lab1_only()) return COMMENT;} */
{commentPattern} {if(lab1_only()) return COMMENT;} 
 /* special symbols */
\+ {action(ADD); return ADD;}
\- {action(SUB); return SUB;}
\* {action(MUL); return MUL;}
\/ {action(DIV); return DIV;}
\< {action(LT); return LT;}
\<= {action(LTE); return LTE;}
\> {action(GT); return GT;}
\>= {action(GTE); return GTE;}
== {action(EQ); return EQ;}
!= {action(NEQ); return NEQ;}
= {action(ASSIN); return ASSIN;}
; {action(SEMICOLON); return SEMICOLON;}
, {action(COMMA); return COMMA;}
\( {action(LPARENTHESE); return LPARENTHESE;}
\) {action(RPARENTHESE); return RPARENTHESE;}
\[ {action(LBRACKET); return LBRACKET;}
\] {action(RBRACKET); return RBRACKET;}
\{ {action(LBRACE); return LBRACE;}
\} {action(RBRACE); return RBRACE;}
\[\] {action(ARRAY); return ARRAY;}
 /* keywords */
else {action(ELSE); return ELSE;}
if {action(IF); return IF;}
int {action(INT); return INT;}
return {action(RETURN); return RETURN;}
void {action(VOID); return VOID;}
while {action(WHILE); return WHILE;}
 /* identifiers and numbers */
 /*{LETTERS} {action(LETTER); return LETTER;}*/
{ID} {action(IDENTIFIER); return IDENTIFIER;}
 /*{NUM} {yylval.intValue = atoi(yytext); action(NUMBER); return NUMBER;}*/
{NUM} {action(NUMBER); return NUMBER;}
 /* blank, do nothing */
[ \t] {if(lab1_only()) return BLANK;}
. {action(ERROR); return ERROR;}


 /****  end******/
%%

/// \brief analysize a *.cminus file
///
///	\param input_file_name
/// \param output_file_name
/// \todo student should fill this function
void analyzer(char* input_file_name, char* output_file_name){
	char input_path[256] = "./testcase/";
	strcat(input_path, input_file_name);
	char output_path[256] = "./tokens/";
	strcat(output_path, output_file_name);
	// yyin is the input stream pointer
	if(!(yyin = fopen(input_path,"r"))){
		printf("[ERR] No input file\n");
		exit(1);
	}
	// reinitialize position counter
	pmyloc->first_line = pmyloc->first_column = pmyloc->last_line = pmyloc->last_column = 1;
	printf("[START]: Read from: %s\n", input_file_name);
	FILE *fp = fopen(output_path,"w+");
	int token;
	// yylex(): entry point of lex, read yyin, return zero on end 
	while((token = yylex())){
		switch(token){
			case ERROR:
				printf("[ERR]: unable to analysize %s at %d line, from %d to %d\n", yytext, 
						pmyloc->first_line, pmyloc->first_column, pmyloc->last_column);
				fprintf(fp, "[ERR]: unable to analysize %s at %d line, from %d to %d\n", yytext, 
						pmyloc->first_line, pmyloc->first_column, pmyloc->last_column);
				break;
			case COMMENT:
				/*printf("[INFO]: Comment found.\n");*/
			case BLANK:
				/*printf("[INFO]: Blank found.\n");*/
				break;
			case EOL:
				break;
			default :
				/*fprintf(fp, "%s\t%d\t%d\t%d\t%d\n",yytext, token, lines, pos_start, pos_end);*/
				fprintf(fp, "%s\t%d\t%d\t%d\t%d\n",yytext, token, \
						pmyloc->first_line, pmyloc->first_column, pmyloc->last_column);
		}
	}
	fclose(fp);
	printf("[END]: Analysis completed.\n");
}


/// \brief process all *.cminus file
///
/// note that: use relative path for all i/o operations
///	process all *.cminus files under 'testcase' directory,
/// then create *.tokens files under 'tokens' directory
/// \todo student should fill this function
int lex_main(int argc, char **argv){
	char filename[50][256];
	char output_file_name[256];
	char suffix[] = ".tokens";
	char extension[] = ".cminus";
	int files_count = getAllTestcase(filename);
	for(int i = 0; i < files_count; i++){
		// prepare output filename
		strcpy(output_file_name, filename[i]);
		strcpy(output_file_name + strlen(output_file_name) - strlen(extension), suffix);
		analyzer(filename[i], output_file_name);
	}
	return 0;
}
/**************** end*************/
