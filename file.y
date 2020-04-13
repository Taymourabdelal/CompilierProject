%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <stdarg.h>
    #include <string.h>
    int yylex(void);
    FILE * yyin;
    int yylineno;
    void yyerror(char *s);
    int symbolVal(char symbol);
%}

%union {
    char* string;
    int iValue;
    float fValue;
};  

%start	program
%token	SEMICOLON
%token	TYPE_INT TYPE_STRING TYPE_CHAR TYPE_BOOL TYPE_FLOAT
%token	OPERATOR_GREATER OPERATOR_LESSTHAN OPERATOR_EQUAL OPERATOR_NOTEQUAL WHILE IF ELSE SWITCH CASE DEFAULT BREAK FOR DO CONST OPERATOR_GEQ OPERATOR_LEQ
%token	OPERATOR_MINUS OPERATOR_MULTIPLY OPERATOR_DIVIDE ARGUMENT_OPENBRACKET ARGUMENT_CLOSEDBRACKET ARGUMENT_OPENPARA ARGUMENT_CLOSEDPARA
%token	OPERATOR_ASSIGNMENT OPERATOR_PLUS COLON OPERATOR_NOT
%token	<string> VALUE_INT VALUE_FLOAT VALUE_CHAR
%token	<string> IDENTIFIER VALUE_STRING VALUE_BOOL
%type	<string> exp stmt value
%type	<string> code datatype 

%%

program : code { printf("\n program:code \n \n" ); } 
        ;

code    : code stmt {printf("code : code stmt -> Line Number (%d)\n" , yylineno);}
        |   {printf("code : Epsilon -> Line Number (%d)\n" , yylineno); $$ = NULL;}
        ;

stmt    : loop {printf("stmt : loop - > Line Number (%d)\n",yylineno);}
        | ifstate {printf("stmt : ifstate  - > Line Number (%d)\n",yylineno);}
        | switch {printf("stmt: switch - > Line Number (%d)\n",yylineno);}
        | decl {printf("stmt : decl -> Line Number (%d)\n" , yylineno);}
        | exp SEMICOLON  {printf ("stmt : exp SEMICOLON  -> Line Number (%d)\n",yylineno);}
        | ARGUMENT_OPENPARA stmt_list ARGUMENT_CLOSEDPARA {printf ("stmt : ARGUMENT_OPENPARA stmt_list ARGUMENT_CLOSEDPARA -> Line Number (%d)\n", yylineno);}
        | BREAK SEMICOLON {printf ("stmt : BREAK SEMICOLON -> Line Number (%d)\n", yylineno);}
        | error SEMICOLON {printf ("Panic Mode : Syntax Error in stmt (%d)\n",yylineno);$$=NULL;}  
        ;


decl	: datatype IDENTIFIER SEMICOLON {printf ("decl : datatype(%s) IDENTIFIER (%s) SEMICOLON -> Line Number (%d)\n", $1 , $2 , yylineno);}
        | datatype IDENTIFIER OPERATOR_ASSIGNMENT exp SEMICOLON {printf ("decl : datatype(%s) IDENTIFIER (%s) OPERATOR_ASSIGNMENT exp SEMICOLON -> Line Number (%d)\n", $1 , $2 , yylineno);}
    	| CONST datatype IDENTIFIER SEMICOLON {printf ("decl: CONST datatype(%s) IDENTIFIER (%s) SEMICOLON -> Line Number (%d)\n", $2 , $3 , yylineno);}
        | CONST datatype IDENTIFIER OPERATOR_ASSIGNMENT exp SEMICOLON {printf ("decl : CONST datatype(%s) IDENTIFIER (%s) OPERATOR_ASSIGNMENT exp SEMICOLON -> Line Number (%d)\n", $2, $3 , yylineno);}
        ;

stmt_list	: {printf ("line_list : Epsilon ->  Line Number (%d)\n",yylineno);}  
        	| stmt_list stmt  {printf ("line_list : line_list stmt - > Line Number(%d)\n",yylineno);}  
			;

exp	: value {printf("exp: value (%s) ->Line Number(%d)\n", $1, yylineno);}
	| OPERATOR_MINUS exp  {printf("exp: OPERATOR_MINUS exp ->Line Number(%d)\n", yylineno); }
    | OPERATOR_NOT exp  {printf("exp: OPERATOR_NOT exp ->Line Number(%d)\n", yylineno); }
    | exp OPERATOR_PLUS exp  {printf("exp: exp (%s) OPERATOR_PLUS exp(%s) ->Line Number(%d)\n", $1,$3, yylineno); }
	| exp OPERATOR_MINUS exp  {printf("exp: exp (%s) OPERATOR_MINUS exp(%s) ->Line Number(%d)\n", $1,$3, yylineno); }
	| exp OPERATOR_DIVIDE exp  {printf("exp: exp (%s) OPERATOR_DIVIDE exp(%s) ->Line Number(%d)\n", $1,$3, yylineno); }
    | exp OPERATOR_MULTIPLY exp  {printf("exp: exp (%s) OPERATOR_MULTIPLY exp(%s) ->Line Number(%d)\n", $1,$3, yylineno); }
	| exp OPERATOR_GREATER exp  {printf("exp: exp (%s) OPERATOR_GREATER exp(%s) ->Line Number(%d)\n", $1,$3, yylineno); }
    | exp OPERATOR_LESSTHAN exp  {printf("exp: exp (%s) OPERATOR_LESSTHAN exp(%s) ->Line Number(%d)\n", $1,$3, yylineno); }
    | exp OPERATOR_LEQ exp  {printf("exp: exp (%s) OPERATOR_LEQ exp(%s) ->Line Number(%d)\n", $1,$3, yylineno); }
    | exp OPERATOR_GEQ exp  {printf("exp: exp (%s) OPERATOR_GEQ exp(%s) ->Line Number(%d)\n", $1,$3, yylineno); }
    | exp OPERATOR_EQUAL exp  {printf("exp: exp (%s) OPERATOR_EQUAL exp(%s) ->Line Number(%d)\n", $1,$3, yylineno); }
    | exp OPERATOR_NOTEQUAL exp  {printf("exp: exp (%s) OPERATOR_NOTEQUAL exp(%s) ->Line Number(%d)\n", $1,$3, yylineno); }
    | ARGUMENT_OPENBRACKET  exp ARGUMENT_CLOSEDBRACKET {printf("exp: ARGUMENT_OPENBRACKET  exp(%s) ARGUMENT_CLOSEDBRACKET ->Line Number(%d)\n", $2,yylineno); }
    | exp OPERATOR_ASSIGNMENT exp {printf("exp: exp (%s) OPERATOR_ASSIGNMENT exp(%s) ->Line Number(%d)\n", $1,$3, yylineno); }
    ; 

ifstate	: IF ARGUMENT_OPENBRACKET exp ARGUMENT_CLOSEDBRACKET stmt {printf(" ifstate:IF ARGUMENT_OPENBRACKET exp(%s) ARGUMENTARGUMENT_CLOSEDBRACKET stmt stmt -> Line Number (%d)\n", $3 , yylineno);} 
        | IF ARGUMENT_OPENBRACKET exp ARGUMENT_CLOSEDBRACKET stmt ELSE stmt {printf(" ifstate:IF ARGUMENT_OPENBRACKET exp(%s) ARGUMENTARGUMENT_CLOSEDBRACKET stmt ELSE stmt -> Line Number (%d)\n", $3 , yylineno);} 
        ;

loop	: WHILE ARGUMENT_OPENBRACKET exp ARGUMENT_CLOSEDBRACKET stmt  {printf ("loop : WHILE ARGUMENT_OPENBRACKET exp  ARGUMENT_CLOSEDBRACKET stmt -> Line Number (%d)\n", yylineno);} 
        | DO  stmt  WHILE ARGUMENT_OPENBRACKET exp ARGUMENT_CLOSEDBRACKET WHILE ARGUMENT_OPENBRACKET exp ARGUMENT_CLOSEDBRACKET SEMICOLON {printf(" loop: DO stmt WHILE ARGUMENT_OPENBRACKET exp ARGUMENT_CLOSEDBRACKET WHILE ARGUMENT_OPENBRACKET exp ARGUMENT_CLOSEDBRACKET SEMICOLON stmt -> Line Number (%d) \n",yylineno); } 
        | FOR ARGUMENT_OPENBRACKET decl exp SEMICOLON exp ARGUMENT_CLOSEDBRACKET stmt {printf(" loop: FOR ARGUMENT_OPENBRACKET decl exp(%s) SEMICOLON exp(%s) ARGUMENT_CLOSEDBRACKET stmt  -> Line Number (%d)\n", $4, $6, yylineno);}
        ;

case_value  : VALUE_CHAR {printf("case_value: VALUE_CHAR(%s) ->Line Number(%d)\n",$1, yylineno); }
            | VALUE_INT  {printf("case_value: VALUE_INT(%d) ->Line Number(%d)\n",$1, yylineno); }
            ;
            
case	: case CASE case_value COLON stmt_list {printf("case CASE case_value COLON stmt ->Line Number(%d)\n", yylineno); }
		|  {printf ("line_list : Epsilon ->  Line Number (%d)\n", yylineno);}
    	;
        
switch	: SWITCH ARGUMENT_OPENBRACKET exp ARGUMENT_CLOSEDBRACKET ARGUMENT_OPENPARA case DEFAULT COLON stmt_list ARGUMENT_CLOSEDPARA {printf("switch : SWITCH ARGUMENT_OPENPARA exp(%s) ARGUMENT_CLOSEDPARA ARGUMENT_OPENPARA cases DEFAULT COLON stmt_list ARGUMENT_OPENPARA -> Line Number (%d)\n", $3, yylineno);}
		;

datatype	: TYPE_INT  {printf("datatype: TYPE_INT ->Line Number(%d)\n", yylineno); $$ = "TYPE_INT";}
			| TYPE_STRING  {printf("datatype: TYPE_STRING ->Line Number(%d)\n", yylineno); $$ = "TYPE_STRING";}
    		| TYPE_CHAR  {printf("datatype: TYPE_CHAR ->Line Number(%d)\n", yylineno); $$ = "TYPE_CHAR";}
    		| TYPE_BOOL  {printf("datatype: TYPE_BOOL ->Line Number(%d)\n", yylineno); $$ = "TYPE_BOOL";}
    		| TYPE_FLOAT {printf("datatype: TYPE_FLOAT ->Line Number(%d)\n", yylineno); $$ = "TYPE_FLOAT";}
    		;

value	: IDENTIFIER   {printf("value : IDENTIFIER(%s) - > Line Number (%d) \n", $1 , yylineno); }
        | VALUE_CHAR  {printf("value : VALUE_CHAR (%s) - > Line Number (%d) \n", $1 , yylineno); $$ = $1;}
        | VALUE_STRING  {printf("value : VALUE_STRING (%s) - > Line Number (%d) \n", $1 , yylineno); $$ = $1;}
        | VALUE_FLOAT  {printf("value : VALUE_FLOAT (%s) - > Line Number (%d) \n", $1 , yylineno); $$ = $1;}
        | VALUE_INT  {printf("value : VALUE_INT (%s) - > Line Number (%d) \n", $1 , yylineno); $$ = $1;}
        | VALUE_BOOL  {printf("value : VALUE_INT (%s) - > Line Number (%d) \n", $1 , yylineno); $$ = $1;}
        ;

%%

void yyerror (char *s) {

    printf("Error: %s\n" , s);
}

int main (void)
{
    yyin = fopen("testfile.txt","r+");
    if (yyin == NULL)
    {
        printf ("File Not Found\n");
    }
    else{
        printf(" >>> Parsing <<<< \n\n");
        yyparse();
    }
    fclose(yyin);
    return 0;

}