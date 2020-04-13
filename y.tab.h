/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     SEMICOLON = 258,
     TYPE_INT = 259,
     TYPE_STRING = 260,
     TYPE_CHAR = 261,
     TYPE_BOOL = 262,
     TYPE_FLOAT = 263,
     OPERATOR_GREATER = 264,
     OPERATOR_LESSTHAN = 265,
     OPERATOR_EQUAL = 266,
     OPERATOR_NOTEQUAL = 267,
     WHILE = 268,
     IF = 269,
     ELSE = 270,
     SWITCH = 271,
     CASE = 272,
     DEFAULT = 273,
     BREAK = 274,
     FOR = 275,
     DO = 276,
     CONST = 277,
     OPERATOR_GEQ = 278,
     OPERATOR_LEQ = 279,
     OPERATOR_MINUS = 280,
     OPERATOR_MULTIPLY = 281,
     OPERATOR_DIVIDE = 282,
     ARGUMENT_OPENBRACKET = 283,
     ARGUMENT_CLOSEDBRACKET = 284,
     ARGUMENT_OPENPARA = 285,
     ARGUMENT_CLOSEDPARA = 286,
     OPERATOR_ASSIGNMENT = 287,
     OPERATOR_PLUS = 288,
     COLON = 289,
     OPERATOR_NOT = 290,
     VALUE_INT = 291,
     VALUE_FLOAT = 292,
     VALUE_CHAR = 293,
     IDENTIFIER = 294,
     VALUE_STRING = 295,
     VALUE_BOOL = 296
   };
#endif
/* Tokens.  */
#define SEMICOLON 258
#define TYPE_INT 259
#define TYPE_STRING 260
#define TYPE_CHAR 261
#define TYPE_BOOL 262
#define TYPE_FLOAT 263
#define OPERATOR_GREATER 264
#define OPERATOR_LESSTHAN 265
#define OPERATOR_EQUAL 266
#define OPERATOR_NOTEQUAL 267
#define WHILE 268
#define IF 269
#define ELSE 270
#define SWITCH 271
#define CASE 272
#define DEFAULT 273
#define BREAK 274
#define FOR 275
#define DO 276
#define CONST 277
#define OPERATOR_GEQ 278
#define OPERATOR_LEQ 279
#define OPERATOR_MINUS 280
#define OPERATOR_MULTIPLY 281
#define OPERATOR_DIVIDE 282
#define ARGUMENT_OPENBRACKET 283
#define ARGUMENT_CLOSEDBRACKET 284
#define ARGUMENT_OPENPARA 285
#define ARGUMENT_CLOSEDPARA 286
#define OPERATOR_ASSIGNMENT 287
#define OPERATOR_PLUS 288
#define COLON 289
#define OPERATOR_NOT 290
#define VALUE_INT 291
#define VALUE_FLOAT 292
#define VALUE_CHAR 293
#define IDENTIFIER 294
#define VALUE_STRING 295
#define VALUE_BOOL 296




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 14 "file.y"
{
    char* string;
    int iValue;
    float fValue;
}
/* Line 1529 of yacc.c.  */
#line 137 "y.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

