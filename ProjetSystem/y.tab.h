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
     tINT = 260,
     tVOID = 261,
     tPO = 262,
     tPF = 263,
     tIF = 264,
     tERROR = 265,
     tCOMA = 266,
     tAO = 267,
     tAF = 268,
     tADD = 269,
     tSUB = 270,
     tMULT = 271,
     tDIV = 272,
     tMOD = 273,
     tAFFECT = 274,
     tEQ = 275,
     tSEMI = 276,
     tRETURN = 277,
     tPRINT = 278,
     tWHILE = 279,
     tNBE = 280,
     tINF = 281,
     tINFEG = 282,
     tSUP = 283,
     tSUPEG = 284,
     tOR = 285,
     tAND = 286
   };
#endif
/* Tokens.  */
#define tNB 258
#define tID 259
#define tINT 260
#define tVOID 261
#define tPO 262
#define tPF 263
#define tIF 264
#define tERROR 265
#define tCOMA 266
#define tAO 267
#define tAF 268
#define tADD 269
#define tSUB 270
#define tMULT 271
#define tDIV 272
#define tMOD 273
#define tAFFECT 274
#define tEQ 275
#define tSEMI 276
#define tRETURN 277
#define tPRINT 278
#define tWHILE 279
#define tNBE 280
#define tINF 281
#define tINFEG 282
#define tSUP 283
#define tSUPEG 284
#define tOR 285
#define tAND 286




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 10 "projetSyst.y"
{int varnb; float varnbe; char * varc;}
/* Line 1529 of yacc.c.  */
#line 113 "y.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

