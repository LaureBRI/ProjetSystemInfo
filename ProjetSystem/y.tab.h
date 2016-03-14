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
     tINT = 261,
     tVOID = 262,
     tPO = 263,
     tPF = 264,
     tIF = 265,
     tELSE = 266,
     tERROR = 267,
     tCOMA = 268,
     tAO = 269,
     tAF = 270,
     tADD = 271,
     tSUB = 272,
     tMULT = 273,
     tDIV = 274,
     tMOD = 275,
     tAFFECT = 276,
     tEQ = 277,
     tSEMI = 278,
     tRETURN = 279,
     tPRINT = 280,
     tWHILE = 281,
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
#define tINT 261
#define tVOID 262
#define tPO 263
#define tPF 264
#define tIF 265
#define tELSE 266
#define tERROR 267
#define tCOMA 268
#define tAO 269
#define tAF 270
#define tADD 271
#define tSUB 272
#define tMULT 273
#define tDIV 274
#define tMOD 275
#define tAFFECT 276
#define tEQ 277
#define tSEMI 278
#define tRETURN 279
#define tPRINT 280
#define tWHILE 281
#define tINF 282
#define tINFEG 283
#define tSUP 284
#define tSUPEG 285
#define tOR 286
#define tAND 287




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 19 "projetSyst.y"
{int varnb; float varnbe; char * varc;}
/* Line 1529 of yacc.c.  */
#line 115 "y.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

