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
     tPO = 262,
     tPF = 263,
     tWHILE = 264,
     tMAIN = 265,
     tAO = 266,
     tAF = 267,
     tINT = 268,
     tVOID = 269,
     tERROR = 270,
     tRETURN = 271,
     tPRINT = 272,
     tCONST = 273,
     tELSE = 274,
     tELSEIF = 275,
     tSEMI = 276,
     tCOMA = 277,
     tADD = 278,
     tSUB = 279,
     tMULT = 280,
     tDIV = 281,
     tMOD = 282,
     tAFFECT = 283,
     tEQ = 284,
     tINF = 285,
     tINFEG = 286,
     tSUP = 287,
     tSUPEG = 288,
     tOR = 289,
     tAND = 290
   };
#endif
/* Tokens.  */
#define tNB 258
#define tID 259
#define tNBE 260
#define tIF 261
#define tPO 262
#define tPF 263
#define tWHILE 264
#define tMAIN 265
#define tAO 266
#define tAF 267
#define tINT 268
#define tVOID 269
#define tERROR 270
#define tRETURN 271
#define tPRINT 272
#define tCONST 273
#define tELSE 274
#define tELSEIF 275
#define tSEMI 276
#define tCOMA 277
#define tADD 278
#define tSUB 279
#define tMULT 280
#define tDIV 281
#define tMOD 282
#define tAFFECT 283
#define tEQ 284
#define tINF 285
#define tINFEG 286
#define tSUP 287
#define tSUPEG 288
#define tOR 289
#define tAND 290




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 27 "projetSyst.y"
{int varnb; float varnbe; char * varc; 
		struct typeWhile{int to; int from;} typeWhile;
		}
/* Line 1529 of yacc.c.  */
#line 123 "y.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

