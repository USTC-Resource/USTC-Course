#include "lexical_analyzer.h"

const char * strtoken(Token t)
{
	switch (t) {
		case ERROR      : return "ERROR";
		case ADD        : return "ADD";
		case SUB        : return "SUB";
		case MUL        : return "MUL";
		case DIV        : return "DIV";
		case LT         : return "LT";
		case LTE        : return "LTE";
		case GT         : return "GT";
		case GTE        : return "GTE";
		case EQ         : return "EQ";
		case NEQ        : return "NEQ";
		case ASSIN      : return "ASSIN";
		case SEMICOLON  : return "SEMICOLON";
		case COMMA      : return "COMMA";
		case LPARENTHESE: return "LPARENTHESE";
		case RPARENTHESE: return "RPARENTHESE";
		case LBRACKET   : return "LBRACKET";
		case RBRACKET   : return "RBRACKET";
		case LBRACE     : return "LBRACE";
		case RBRACE     : return "RBRACE";
		case ELSE       : return "ELSE";
		case IF         : return "IF";
		case INT        : return "INT";
		case RETURN     : return "RETURN";
		case VOID       : return "VOID";
		case WHILE      : return "WHILE";
		case IDENTIFIER : return "IDENTIFIER";
		case NUMBER     : return "NUMBER";
		case LETTER     : return "LETTER";
		case ARRAY      : return "ARRAY";
		case EOL        : return "EOL";
		case COMMENT    : return "COMMENT";
		case BLANK      : return "BLANK";
	}
}
