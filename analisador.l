%{
#include <stdio.h>
#include <stdlib.h>
#define T_INT 10
#define T_REAL 11
#define T_DEC 12
#define T_STRING 13
#define T_BOOL 14
#define T_NULL 15
#define ID 16
#define OP_ASSIGN 17

%}

DECIMAL_SUFIX [dD]
INTEGER_LITERAL [0-9]+
REAL_LITERAL [0-9]+\.[0-9]*([eE][+-]?[0-9]+)?
STRING_LITERAL \"([^"\n\\]|\\.)*\"
CHAR_LITERAL '([^'\n\\]|\\.)'
IDENTIFIER [a-zA-Z][a-zA-Z0-9_]*

%%

[ \t\r\n]            ; // tabulações e quebras de linha
\/\/.* ; // Comentários de linha

    
"begin"             { printf("KEY_BEGIN\n"); }
"end"               { printf("KEY_END\n"); }
"if"                { printf("KEY_IF\n"); }
"then"              { printf("KEY_THEN\n"); }
"else"              { printf("KEY_ELSE\n"); }
"while"             { printf("KEY_WHILE\n"); }
"for"               { printf("KEY_FOR\n"); }
"do"                { printf("KEY_DO\n"); }
"in"                { printf("KEY_IN\n"); }
"var"               { printf("KEY_VAR\n"); }
"const"             { printf("KEY_CONST\n"); }
"function"          { printf("KEY_FUNCTION\n"); }
"return"            { printf("KEY_RETURN\n"); }
"true"              { printf("KEY_TRUE\n"); }
"false"             { printf("KEY_FALSE\n"); }
"input"             { printf("KEY_INPUT\n"); }
"output"            { printf("KEY_OUTPUT\n"); }
"and"               { printf("OP_AND\n"); }
"or"                { printf("OP_OR\n"); }
"not"               { printf("OP_NOT\n"); }
"raise"             { printf("KEY_RAISE\n"); }
"try"               { printf("KEY_TRY\n"); }
"except"            { printf("KEY_EXCEPT\n"); }
"finally"           { printf("KEY_FINALLY\n"); }
"exception"         { printf("KEY_EXCEPTION\n"); }
"break"             { printf("KEY_BREAK\n"); }
"continue"          { printf("KEY_CONTINUE\n"); }
"exit"              { printf("KEY_EXIT\n"); }
"type"              { printf("KEY_TYPE\n"); }
"record"            { printf("KEY_RECORD\n"); }
"alocate"           { printf("KEY_ALOCATE\n"); }
"free"              { printf("KEY_FREE\n"); }
"size"              { printf("KEY_SIZE\n"); }
"assign"            { printf("KEY_ASSIGN\n"); }
"read"              { printf("KEY_READ\n"); }
"write"             { printf("KEY_WRITE\n"); }
"append"            { printf("KEY_APPEND\n"); }
"close"             { printf("KEY_CLOSE\n"); }


{INTEGER_LITERAL}           { printf("LIT_INT(%s)\n", yytext); }
{REAL_LITERAL}              { printf("LIT_REAL(%s)\n", yytext); }
{INTEGER_LITERAL}{DECIMAL_SUFIX} { printf("LIT_DECIMAL(%s)\n", yytext); }
{REAL_LITERAL}{DECIMAL_SUFIX}   { printf("LIT_DECIMAL(%s)\n", yytext); }
{STRING_LITERAL}            { printf("LIT_STRING(%s)\n", yytext); }
{CHAR_LITERAL}              { printf("LIT_CHAR(%s)\n", yytext); }
"null"                      { printf("LIT_NULL\n"); }
"date"'{STRING_LITERAL}      { printf("LIT_DATE(%s)\n", yytext); }
"hour"'{STRING_LITERAL}     { printf("LIT_TIME(%s)\n", yytext); }


"Integer"           { printf("TYPE_INTEGER\n"); }
"Real"              { printf("TYPE_REAL\n"); }
"Decimal"           { printf("TYPE_DECIMAL\n"); }
"Boolean"           { printf("TYPE_BOOLEAN\n"); }
"Caractere"         { printf("TYPE_CHAR\n"); }
"Texto"             { printf("TYPE_STRING\n"); }
"data"              { printf("TYPE_DATE\n"); }
"hora"              { printf("TYPE_TIME\n"); }
"dict"              { printf("TYPE_DICT\n"); }
"set"               { printf("TYPE_SET\n"); }


":="                { printf("OP_ASSIGN\n"); }
"+="                { printf("OP_PLUS_ASSIGN\n"); }
"-="                { printf("OP_MINUS_ASSIGN\n"); }
"*="                { printf("OP_MUL_ASSIGN\n"); }
"/="                { printf("OP_DIV_ASSIGN\n"); }
"%="                { printf("OP_MOD_ASSIGN\n"); }

"="                 { printf("OP_EQ\n"); }
"!>"                { printf("OP_NE\n"); } // Note: Este é um operador não padrão, verifique se a sintaxe pretendida é `<>` ou `!=`
"<="                { printf("OP_LE\n"); }
">="                { printf("OP_GE\n"); }
"<"                 { printf("OP_LT\n"); }
">"                 { printf("OP_GT\n"); }

"+"                 { printf("OP_PLUS\n"); }
"-"                 { printf("OP_MINUS\n"); }
"*"                 { printf("OP_MULTIPLY\n"); }
"/"                 { printf("OP_DIVIDE\n"); }
"%"                 { printf("OP_MOD\n"); }

"("                 { printf("L_PAREN\n"); }
")"                 { printf("R_PAREN\n"); }
"["                 { printf("L_BRACKET\n"); }
"]"                 { printf("R_BRACKET\n"); }
"{"                 { printf("L_BRACE\n"); }
"}"                 { printf("R_BRACE\n"); }
":"                 { printf("COLON\n"); }
";"                 { printf("SEMICOLON\n"); }
","                 { printf("COMMA\n"); }
"."                 { printf("DOT\n"); }


{IDENTIFIER}        { printf("ID(%s)\n", yytext); }


.                   { fprintf(stderr, "Erro Lexico: Caractere invalido '%s' na linha %d\n", yytext, yylineno); }

%%

#ifndef yywrap
    int yywrap (void) {return 1;}
#endif

int main(void)
{
    yylex();
    return 0;
}