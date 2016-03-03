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
     tINT = 258,
     tVOID = 259,
     tID = 260,
     tPO = 261,
     tPF = 262,
     tIF = 263,
     tERROR = 264,
     tCOMA = 265,
     tAO = 266,
     tAF = 267,
     tADD = 268,
     tSUB = 269,
     tMULT = 270,
     tDIV = 271,
     tMOD = 272,
     tAFFECT = 273,
     tEQ = 274,
     tSEMI = 275,
     tRETURN = 276,
     tPRINT = 277,
     tWHILE = 278,
     tNB = 279,
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
#define tINT 258
#define tVOID 259
#define tID 260
#define tPO 261
#define tPF 262
#define tIF 263
#define tERROR 264
#define tCOMA 265
#define tAO 266
#define tAF 267
#define tADD 268
#define tSUB 269
#define tMULT 270
#define tDIV 271
#define tMOD 272
#define tAFFECT 273
#define tEQ 274
#define tSEMI 275
#define tRETURN 276
#define tPRINT 277
#define tWHILE 278
#define tNB 279
#define tNBE 280
#define tINF 281
#define tINFEG 282
#define tSUP 283
#define tSUPEG 284
#define tOR 285
#define tAND 286




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

