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

%start program
%token SEMICOLON
%token TYPE_INT TYPE_STRING TYPE_CHAR TYPE_BOOL TYPE_FLOAT
%token OPERATOR_GREATER OPERATOR_LESSTHAN OPERATOR_EQUAL OPERATOR_NOTEQUAL WHILE IF ELSE SWITCH CASE DEFAULT BREAK FOR DO CONST OPERATOR_GEQ OPERATOR_LEQ
%token  OPERATOR_MINUS OPERATOR_MULTIPLY OPERATOR_DIVIDE ARGUMENT_OPENBRACKET ARGUMENT_CLOSEDBRACKET ARGUMENT_OPENPARA ARGUMENT_CLOSEDPARA
%token OPERATOR_ASSIGNMENT OPERATOR_PLUS 
%token <string> VALUE_INT VALUE_FLOAT VALUE_CHAR
%token <string> IDENTIFIER VALUE_STRING VALUE_BOOL
%type <string> exp line value
%type <string> code datatype 

%%

program : code { printf( "\n program:code \n\n");};

code : code line {printf("code : code line -> Line Number (%d)\n" , yylineno);}
        |   {printf("code : Epsilon -> Line Number (%d)\n" , yylineno); $$ = NULL;}
        ;       
line :  IDENTIFIER OPERATOR_ASSIGNMENT exp SEMICOLON
        {printf ("line : IDENTIFIER(%s) OPERATOR_ASSIGNMENT  exp(%s) SEMICOLON -> Line Number (%d)\n", $1 , $3 , yylineno);}
    | datatype IDENTIFIER SEMICOLON
         {printf ("line : datatype(%s) IDENTIFIER (%s) SEMICOLON -> Line Number (%d)\n", $1 , $2 , yylineno);}
         | ARGUMENT_OPENPARA line_list ARGUMENT_CLOSEDPARA
         {printf ("line : ARGUMENT_OPENPARA line_list ARGUMENT_CLOSEDPARA -> Line Number (%d)\n", yylineno);}
          | WHILE ARGUMENT_OPENBRACKET exp ARGUMENT_CLOSEDBRACKET line  {printf ("line : WHILE ARGUMENT_OPENBRACKET exp  ARGUMENT_CLOSEDBRACKET line -> Line Number (%d)\n", yylineno);}
       | error SEMICOLON
         {printf ("Panic Mode : Syntax Error in line (%d)\n",yylineno);$$=NULL;}  
         
         ;
line_list : 
        line            {printf ("line_list : line (%d)\n",yylineno);}  
        |
        line_list line  {printf ("line_list : line_list line (%d)\n",yylineno);}  
        ;

exp:   value   {printf("exp: value (%s) ->Line Number(%d)\n", $1, yylineno);}
        |
         exp OPERATOR_PLUS exp  {printf("exp: exp (%s) OPERATOR_PLUS expr(%s) ->Line Number(%d)\n", $1,$3, yylineno); }
         |
         exp OPERATOR_MINUS exp  {printf("exp: exp (%s) OPERATOR_MINUS expr(%s) ->Line Number(%d)\n", $1,$3, yylineno); }
         |
         exp OPERATOR_DIVIDE exp  {printf("exp: exp (%s) OPERATOR_DIVIDE expr(%s) ->Line Number(%d)\n", $1,$3, yylineno); }
         |
         exp OPERATOR_MULTIPLY exp  {printf("exp: exp (%s) OPERATOR_MULTIPLY expr(%s) ->Line Number(%d)\n", $1,$3, yylineno); }
         |
         exp OPERATOR_GREATER exp  {printf("exp: exp (%s) OPERATOR_GREATER expr(%s) ->Line Number(%d)\n", $1,$3, yylineno); }
         |
         exp OPERATOR_LESSTHAN exp  {printf("exp: exp (%s) OPERATOR_LESSTHAN expr(%s) ->Line Number(%d)\n", $1,$3, yylineno); }
          |
         exp OPERATOR_LEQ exp  {printf("exp: exp (%s) OPERATOR_LEQ expr(%s) ->Line Number(%d)\n", $1,$3, yylineno); }
          |
         exp OPERATOR_GEQ exp  {printf("exp: exp (%s) OPERATOR_GEQ expr(%s) ->Line Number(%d)\n", $1,$3, yylineno); }
          |
         exp OPERATOR_EQUAL exp  {printf("exp: exp (%s) OPERATOR_EQUAL expr(%s) ->Line Number(%d)\n", $1,$3, yylineno); }
          |
         exp OPERATOR_NOTEQUAL exp  {printf("exp: exp (%s) OPERATOR_NOTEQUAL expr(%s) ->Line Number(%d)\n", $1,$3, yylineno); }
         |
         ARGUMENT_OPENBRACKET  exp ARGUMENT_CLOSEDBRACKET {printf("exp: ARGUMENT_OPENBRACKET  expr(%s) ARGUMENT_CLOSEDBRACKET ->Line Number(%d)\n", $2, yylineno); }
        ; 


datatype: TYPE_INT  {printf("datatype: TYPE_INT ->Line Number(%d)\n", yylineno); $$ = "TYPE_INT";}
    |
    TYPE_STRING  {printf("datatype: TYPE_STRING ->Line Number(%d)\n", yylineno); $$ = "TYPE_STRING";}
    |
    TYPE_CHAR  {printf("datatype: TYPE_CHAR ->Line Number(%d)\n", yylineno); $$ = "TYPE_CHAR";}
    |
    TYPE_BOOL  {printf("datatype: TYPE_BOOL ->Line Number(%d)\n", yylineno); $$ = "TYPE_BOOL";}
    |
    TYPE_FLOAT {printf("datatype: TYPE_FLOAT ->Line Number(%d)\n", yylineno); $$ = "TYPE_FLOAT";}
    ;

value : IDENTIFIER   {printf("value : IDENTIFIER(%s) - > Line Number (%d) \n", $1 , yylineno); }
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