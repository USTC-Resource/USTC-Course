#ifndef _LEXICAL_ANALYZER_H_
#define _LEXICAL_ANALYZER_H_

#include <stdio.h>

extern int fileno (FILE *__stream) __THROW __wur;

#ifndef YYTOKENTYPE
#define YYTOKENTYPE
typedef enum cminus_token_type {
	ERROR = 258,
	ADD = 259,
	SUB = 260,
	MUL = 261,
	DIV = 262,
	LT = 263,
	LTE = 264,
	GT = 265,
	GTE = 266,
	EQ = 267,
	NEQ = 268,
	ASSIN = 269,
	SEMICOLON = 270,
	COMMA = 271,
	LPARENTHESE = 272,
	RPARENTHESE = 273,
	LBRACKET = 274,
	RBRACKET = 275,
	LBRACE = 276,
	RBRACE = 277,
	ELSE = 278,
	IF = 279,
	INT = 280,
	RETURN = 281,
	VOID = 282,
	WHILE = 283,
	IDENTIFIER = 284,
	NUMBER = 285,
	ARRAY = 286,
	LETTER = 287,
	EOL = 288,
	COMMENT = 289,
	BLANK = 290

} Token;
#endif /* YYTOKENTYPE */

const char * strtoken(Token t);

#endif /* lexical_analyzer.h */
