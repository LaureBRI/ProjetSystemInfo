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
     tNB = 258,
     tID = 259,
     tNBE = 260,
     tIF = 261,
     tWHILE = 262,
     tINT = 263,
     tVOID = 264,
     tPO = 265,
     tPF = 266,
     tELSE = 267,
     tERROR = 268,
     tCOMA = 269,
     tAO = 270,
     tAF = 271,
     tADD = 272,
     tSUB = 273,
     tMULT = 274,
     tDIV = 275,
     tMOD = 276,
     tAFFECT = 277,
     tEQ = 278,
     tSEMI = 279,
     tRETURN = 280,
     tPRINT = 281,
     tINF = 282,
     tINFEG = 283,
     tSUP = 284,
     tSUPEG = 285,
     tOR = 286,
     tAND = 287
   };
#endif
/* Tokens.  */
#define tNB 258
#define tID 259
#define tNBE 260
#define tIF 261
#define tWHILE 262
#define tINT 263
#define tVOID 264
#define tPO 265
#define tPF 266
#define tELSE 267
#define tERROR 268
#define tCOMA 269
#define tAO 270
#define tAF 271
#define tADD 272
#define tSUB 273
#define tMULT 274
#define tDIV 275
#define tMOD 276
#define tAFFECT 277
#define tEQ 278
#define tSEMI 279
#define tRETURN 280
#define tPRINT 281
#define tINF 282
#define tINFEG 283
#define tSUP 284
#define tSUPEG 285
#define tOR 286
#define tAND 287




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 20 "projetSyst.y"
{int varnb; float varnbe; char * varc; 
		struct typeWhile{int to; int from;} typeWhile;
		}
/* Line 1529 of yacc.c.  */
#line 117 "y.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

