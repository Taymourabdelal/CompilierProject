%option yylineno
%{
    #include <stdio.h>
    //#include "defines.h"
    #include <stdlib.h>
    #include <string.h>
    #include "y.tab.h"
   

%}

%%

; return SEMICOLON;
: return COLON;
int return TYPE_INT;
string return TYPE_STRING;
char return TYPE_CHAR;
bool return TYPE_BOOL;
float return TYPE_FLOAT;
while return WHILE;
if return IF;
else return ELSE; 
switch return  SWITCH;
case return CASE;
default return DEFAULT;
break return BREAK;
for return FOR;
do return DO;
const return CONST;
\= return OPERATOR_ASSIGNMENT;
[0-9]+ {yylval.string = strdup(yytext); return VALUE_INT;}
["]([a-zA-Z0-9]|[\\][a-zA-Z])*["] {yylval.string = strdup(yytext) ; return VALUE_STRING;}
[']([a-zA-Z0-9]|[\\][a-zA-Z])['] {yylval.string = strdup(yytext) ; return VALUE_CHAR;}
(true|false) {yylval.string = strdup(yytext) ; return VALUE_BOOL;}
([0-9]*[.][0-9]+|[0-9]+[.][0-9]*) {yylval.string = strdup(yytext) ; return VALUE_FLOAT;}
[a-zA-Z_]([a-zA-Z_]|[0-9])* {yylval.string = strdup(yytext); return IDENTIFIER;}
\+ return OPERATOR_PLUS;
\- return OPERATOR_MINUS;
\* return OPERATOR_MULTIPLY;
\/ return OPERATOR_DIVIDE;
\( return ARGUMENT_OPENBRACKET;
\) return ARGUMENT_CLOSEDBRACKET;
\{ return ARGUMENT_OPENPARA;
\} return ARGUMENT_CLOSEDPARA;
\> return OPERATOR_GREATER;
\< return OPERATOR_LESSTHAN;  
\! return OPERATOR_NOT;  
">=" return OPERATOR_GEQ;
"<=" return OPERATOR_LEQ;
"==" return OPERATOR_EQUAL;
"!=" return OPERATOR_NOTEQUAL;


\n     printf("\n");

[\t ]+ ;
.      printf("Invalid Charactrs at line Number: %d. Characters: %s\n" , yylineno, strdup(yytext));
%%

int yywrap(void){
    return 1;
}