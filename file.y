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
%token	TYPE_INT TYPE_STRING TYPE_CHAR TYPE_BOOL TYPE_FLOAT TYPE_VOID
%token	OPERATOR_GREATER OPERATOR_LESSTHAN OPERATOR_EQUAL OPERATOR_NOTEQUAL WHILE IF ELSE SWITCH CASE DEFAULT BREAK FOR DO CONST OPERATOR_GEQ OPERATOR_LEQ
%token	OPERATOR_MINUS OPERATOR_MULTIPLY OPERATOR_DIVIDE ARGUMENT_OPENBRACKET ARGUMENT_CLOSEBRACKET ARGUMENT_OPENPARA ARGUMENT_CLOSEPARA
%token	OPERATOR_ASSIGNMENT OPERATOR_PLUS COLON OPERATOR_NOT
%token	<string> VALUE_INT VALUE_FLOAT VALUE_CHAR COMMA RETURN MAIN 
%token	<string> IDENTIFIER VALUE_STRING VALUE_BOOL
%type	<string> exp stmt value
%type	<string> code datatype 


%left OPERATOR_PLUS OPERATOR_MINUS
%left OPERATOR_MULTIPLY OPERATOR_DIVIDE

%%

program : extstmt_list TYPE_INT MAIN ARGUMENT_OPENBRACKET ARGUMENT_CLOSEBRACKET ARGUMENT_OPENPARA code RETURN VALUE_INT SEMICOLON ARGUMENT_CLOSEPARA extstmt_list {printf("\n TYPE_INT MAIN ARGUMENT_OPENBRACKET ARGUMENT_CLOSEBRACKET ARGUMENT_OPENPARA code RETURN VALUE_INT SEMICOLON ARGUMENT_CLOSEPARA extstmt_list \n \n" ); } 
        ;

code    : code stmt {printf("code : code stmt -> Line No. (%d)\n" , yylineno);}
        | {printf("code : Epsilon -> Line No. (%d)\n" , yylineno); $$ = NULL;}
        ;

extstmt_list	: extstmt_list extstmt {printf("extstmt_list : extstmt_list extstmt Line Number -> (%d)", yylineno);}
				| {printf("extstmt_list : Epsilon -> Line No. (%d)\n", yylineno);}
				;

extstmt	: funcdecl {printf("stmt: funcdecl -> Line No. (%d)\n",yylineno);}
        | funcprot { printf("stmt: funcprot -> Line No. (%d)\n",yylineno);}
        ;

stmt    : loop {printf("stmt : loop - > Line No. (%d)\n",yylineno);}
        | ifstate {printf("stmt : ifstate  - > Line No. (%d)\n",yylineno);}
        | switch {printf("stmt: switch - > Line No. (%d)\n",yylineno);}
        | decl {printf("stmt : decl -> Line No. (%d)\n" , yylineno);}
        | funccall { printf("stmt: funccall- > Line No. (%d)\n",yylineno); }
        | exp SEMICOLON  {printf ("stmt : exp SEMICOLON  -> Line No. (%d)\n",yylineno);}
        | ARGUMENT_OPENPARA stmt_list ARGUMENT_CLOSEPARA {printf ("stmt : ARGUMENT_OPENPARA stmt_list ARGUMENT_CLOSEPARA -> Line No. (%d)\n", yylineno);}
        | BREAK SEMICOLON {printf ("stmt : BREAK SEMICOLON -> Line No. (%d)\n", yylineno);}
        | RETURN exp SEMICOLON {printf("stmt: RETURN exp(%s) SEMICOLON-> Line No. (%d)\n", $2, yylineno);}
        | error SEMICOLON {printf ("Panic Mode : Syntax Error in stmt (%d)\n",yylineno);$$=NULL;}  
        
        ;


decl	: datatype IDENTIFIER SEMICOLON {printf ("decl : datatype(%s) IDENTIFIER (%s) SEMICOLON -> Line No. (%d)\n", $1 , $2 , yylineno);}
        | datatype IDENTIFIER OPERATOR_ASSIGNMENT exp SEMICOLON {printf ("decl : datatype(%s) IDENTIFIER (%s) OPERATOR_ASSIGNMENT exp SEMICOLON -> Line No. (%d)\n", $1 , $2 , yylineno);}
    	| CONST datatype IDENTIFIER SEMICOLON {printf ("decl: CONST datatype(%s) IDENTIFIER (%s) SEMICOLON -> Line No. (%d)\n", $2 , $3 , yylineno);}
        | CONST datatype IDENTIFIER OPERATOR_ASSIGNMENT exp SEMICOLON {printf ("decl : CONST datatype(%s) IDENTIFIER (%s) OPERATOR_ASSIGNMENT exp SEMICOLON -> Line No. (%d)\n", $2, $3 , yylineno);}
        ;

funcdecl	: datatype IDENTIFIER ARGUMENT_OPENBRACKET parameters ARGUMENT_CLOSEBRACKET ARGUMENT_OPENPARA stmt_list ARGUMENT_CLOSEPARA {printf("funcdecl: datatype IDENTIFIER ARGUMENT_OPENBRACKET parameters ARGUMENT_CLOSEBRACKET ARGUMENT_OPENPARA stmt_list ARGUMENT_CLOSEPARA -> Line No. (%d)\n", yylineno);}
			| datatype IDENTIFIER ARGUMENT_OPENBRACKET ARGUMENT_CLOSEBRACKET ARGUMENT_OPENPARA stmt_list ARGUMENT_CLOSEPARA {printf("funcdecl: datatype(%s) IDENTIFIER(%s) ARGUMENT_OPENBRACKET ARGUMENT_CLOSEBRACKET ARGUMENT_OPENPARA stmt_list ARGUMENT_CLOSEPARA -> Line No. (%d)\n", $1, $2, yylineno);}
            ;

funcprot	: datatype IDENTIFIER ARGUMENT_OPENBRACKET parameters ARGUMENT_CLOSEBRACKET SEMICOLON {printf("funcprot: datatype(%s) IDENTIFIER(%s) ARGUMENT_OPENBRACKET parameters ARGUMENT_CLOSEBRACKET -> Line No. (%d)\n", $1, $2, yylineno);}
			| datatype IDENTIFIER ARGUMENT_OPENBRACKET ARGUMENT_CLOSEBRACKET SEMICOLON {printf("funcprot: datatype(%s) IDENTIFIER(%s) ARGUMENT_OPENBRACKET ARGUMENT_CLOSEBRACKET -> Line No. (%d)\n", $1, $2, yylineno);}
            ;

funccall	: IDENTIFIER ARGUMENT_OPENBRACKET arguments ARGUMENT_CLOSEBRACKET SEMICOLON {printf("funccall: IDENTIFIER ARGUMENT_OPENBRACKET arguments ARGUMENT_CLOSEBRACKET -> Line No. (%d)\n", yylineno);}
			| IDENTIFIER ARGUMENT_OPENBRACKET ARGUMENT_CLOSEBRACKET SEMICOLON {printf("funccall: IDENTIFIER(%s) ARGUMENT_OPENBRACKET ARGUMENT_CLOSEBRACKET -> Line No. (%d)\n", $1, yylineno);}
            ;

stmt_list	: {printf ("line_list : Epsilon ->  Line No. (%d)\n",yylineno);}  
        	| stmt_list stmt  {printf ("line_list : line_list stmt - > Line No.(%d)\n",yylineno);}  
			;

exp	: value {printf("exp: value (%s) ->Line No.(%d)\n", $1, yylineno);}
	| OPERATOR_MINUS exp  {printf("exp: OPERATOR_MINUS exp ->Line No.(%d)\n", yylineno); }
    | OPERATOR_NOT exp  {printf("exp: OPERATOR_NOT exp ->Line No.(%d)\n", yylineno); }
    | exp OPERATOR_PLUS exp  {printf("exp: exp (%s) OPERATOR_PLUS exp(%s) ->Line No.(%d)\n", $1,$3, yylineno); }
	| exp OPERATOR_MINUS exp  {printf("exp: exp (%s) OPERATOR_MINUS exp(%s) ->Line No.(%d)\n", $1,$3, yylineno); }
	| exp OPERATOR_DIVIDE exp  {printf("exp: exp (%s) OPERATOR_DIVIDE exp(%s) ->Line No.(%d)\n", $1,$3, yylineno); }
    | exp OPERATOR_MULTIPLY exp  {printf("exp: exp (%s) OPERATOR_MULTIPLY exp(%s) ->Line No.(%d)\n", $1,$3, yylineno); }
	| exp OPERATOR_GREATER exp  {printf("exp: exp (%s) OPERATOR_GREATER exp(%s) ->Line No.(%d)\n", $1,$3, yylineno); }
    | exp OPERATOR_LESSTHAN exp  {printf("exp: exp (%s) OPERATOR_LESSTHAN exp(%s) ->Line No.(%d)\n", $1,$3, yylineno); }
    | exp OPERATOR_LEQ exp  {printf("exp: exp (%s) OPERATOR_LEQ exp(%s) ->Line No.(%d)\n", $1,$3, yylineno); }
    | exp OPERATOR_GEQ exp  {printf("exp: exp (%s) OPERATOR_GEQ exp(%s) ->Line No.(%d)\n", $1,$3, yylineno); }
    | exp OPERATOR_EQUAL exp  {printf("exp: exp (%s) OPERATOR_EQUAL exp(%s) ->Line No.(%d)\n", $1,$3, yylineno); }
    | exp OPERATOR_NOTEQUAL exp  {printf("exp: exp (%s) OPERATOR_NOTEQUAL exp(%s) ->Line No.(%d)\n", $1,$3, yylineno); }
    | ARGUMENT_OPENBRACKET  exp ARGUMENT_CLOSEBRACKET {printf("exp: ARGUMENT_OPENBRACKET  exp(%s) ARGUMENT_CLOSEBRACKET ->Line No.(%d)\n", $2,yylineno); }
    | exp OPERATOR_ASSIGNMENT exp {printf("exp: exp(%s) OPERATOR_ASSIGNMENT exp(%s) ->Line No.(%d)\n", $1, $3, yylineno); }
    ; 

parameters	: datatype IDENTIFIER {printf("parameters : datatype IDENTIFIER(%s) -> Line No.(%d)\n",$2,  yylineno);}
        	| parameters COMMA datatype IDENTIFIER {printf("parameters : parameters COMMA datatype IDENTIFIER -> Line No.(%d)\n",  yylineno);}
			;

arguments	: IDENTIFIER {printf("arguments : arguments IDENTIFIER -> Line No.(%d)\n", yylineno);}
			| arguments COMMA IDENTIFIER {printf("arguments : arguments IDENTIFIER -> Line No.(%d)\n", yylineno);}
			;

ifstate	: IF ARGUMENT_OPENBRACKET exp ARGUMENT_CLOSEBRACKET stmt {printf(" ifstate:IF ARGUMENT_OPENBRACKET exp(%s) ARGUMENTARGUMENT_CLOSEDBRACKET stmt stmt -> Line No. (%d)\n", $3 , yylineno);} 
        | IF ARGUMENT_OPENBRACKET exp ARGUMENT_CLOSEBRACKET stmt ELSE stmt {printf(" ifstate:IF ARGUMENT_OPENBRACKET exp(%s) ARGUMENTARGUMENT_CLOSEDBRACKET stmt ELSE stmt -> Line No. (%d)\n", $3 , yylineno);} 
        ;

loop	: WHILE ARGUMENT_OPENBRACKET exp ARGUMENT_CLOSEBRACKET stmt  {printf ("loop : WHILE ARGUMENT_OPENBRACKET exp  ARGUMENT_CLOSEBRACKET stmt -> Line No. (%d)\n", yylineno);} 
        | DO  stmt  WHILE ARGUMENT_OPENBRACKET exp ARGUMENT_CLOSEBRACKET WHILE ARGUMENT_OPENBRACKET exp ARGUMENT_CLOSEBRACKET SEMICOLON {printf(" loop: DO stmt WHILE ARGUMENT_OPENBRACKET exp ARGUMENT_CLOSEBRACKET WHILE ARGUMENT_OPENBRACKET exp ARGUMENT_CLOSEBRACKET SEMICOLON stmt -> Line No. (%d) \n",yylineno); } 
        | FOR ARGUMENT_OPENBRACKET decl exp SEMICOLON exp ARGUMENT_CLOSEBRACKET stmt {printf(" loop: FOR ARGUMENT_OPENBRACKET decl exp(%s) SEMICOLON exp(%s) ARGUMENT_CLOSEBRACKET stmt  -> Line No. (%d)\n", $4, $6, yylineno);}
        ;

case_value  : VALUE_CHAR {printf("case_value: VALUE_CHAR(%s) ->Line No.(%d)\n",$1, yylineno); }
            | VALUE_INT  {printf("case_value: VALUE_INT(%s) ->Line No.(%d)\n",$1, yylineno); }
            ;
            
case	: case CASE case_value COLON stmt_list {printf("case CASE case_value COLON stmt ->Line No.(%d)\n", yylineno); }
		|  {printf ("line_list : Epsilon ->  Line No. (%d)\n", yylineno);}
    	;
        
switch	: SWITCH ARGUMENT_OPENBRACKET exp ARGUMENT_CLOSEBRACKET ARGUMENT_OPENPARA case DEFAULT COLON stmt_list ARGUMENT_CLOSEPARA {printf("switch : SWITCH ARGUMENT_OPENPARA exp(%s) ARGUMENT_CLOSEPARA ARGUMENT_OPENPARA cases DEFAULT COLON stmt_list ARGUMENT_OPENPARA -> Line No. (%d)\n", $3, yylineno);}
		;

datatype	: TYPE_INT  {printf("datatype: TYPE_INT ->Line No.(%d)\n", yylineno); $$ = "TYPE_INT";}
			| TYPE_STRING  {printf("datatype: TYPE_STRING ->Line No.(%d)\n", yylineno); $$ = "TYPE_STRING";}
    		| TYPE_CHAR  {printf("datatype: TYPE_CHAR ->Line No.(%d)\n", yylineno); $$ = "TYPE_CHAR";}
    		| TYPE_BOOL  {printf("datatype: TYPE_BOOL ->Line No.(%d)\n", yylineno); $$ = "TYPE_BOOL";}
    		| TYPE_FLOAT {printf("datatype: TYPE_FLOAT ->Line No.(%d)\n", yylineno); $$ = "TYPE_FLOAT";}
            | TYPE_VOID {printf("datatype: TYPE_VOID ->Line No.(%d)\n", yylineno); $$ = "TYPE_VOID";}
    		;

value	: IDENTIFIER   {printf("value : IDENTIFIER(%s) - > Line No. (%d) \n", $1 , yylineno);  }
        | VALUE_CHAR  {printf("value : VALUE_CHAR (%s) - > Line No. (%d) \n", $1 , yylineno); $$ = $1;}
        | VALUE_STRING  {printf("value : VALUE_STRING (%s) - > Line No. (%d) \n", $1 , yylineno); $$ = $1;}
        | VALUE_FLOAT  {printf("value : VALUE_FLOAT (%s) - > Line No. (%d) \n", $1 , yylineno); $$ = $1;}
        | VALUE_INT  {printf("value : VALUE_INT (%s) - > Line No. (%d) \n", $1 , yylineno); $$ = $1;}
        | VALUE_BOOL  {printf("value : VALUE_INT (%s) - > Line No. (%d) \n", $1 , yylineno); $$ = $1;}
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