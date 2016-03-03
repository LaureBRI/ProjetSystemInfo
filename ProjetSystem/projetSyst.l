%{

#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"

%}

NB [0-9]+ 

%%
[ \t]+ {printf(" \n");}
"(" {printf("(\n"); return tPO;}
")" {printf(")\n"); return tPF;}
"{" {printf("{\n"); return tAO;}
"}" {printf("}\n"); return tAF;}
"+" {printf("+\n"); return tADD;}
"-" {printf("-\n"); return tSUB;}
"*" {printf("*\n"); return tMULT;}
"/" {printf("/\n"); return tDIV;}
"%" {printf("%c\n",'%'); return tMOD;}
"=" {printf("=\n"); return tAFFECT;}
"==" {printf("==\n"); return tEQ;}
"," {printf(",\n"); return tCOMA;}
";" {printf(";\n"); return tSEMI;}
"<" {printf("<\n"); return tINF;}
"<=" {printf("<=\n"); return tINFEG;}
">" {printf(">\n"); return tSUP;}
">=" {printf(">=\n"); return tSUPEG;}
"&&" {printf("&&\n"); return tAND;}
"||" {printf("||\n"); return tOR;}

"int" {printf("int\n"); return tINT;}

"return" {printf("return\n"); return tRETURN;}

"printf" {printf("printf\n"); return tPRINT;}

"if" {printf("if\n"); return tIF;}
"while" {printf("while\n"); return tWHILE;}

[a-zA-Z]+ {printf("id : %s\n", yytext); return tID;}
{NB} {printf("nb : %f\n", atof(yytext)); return tNB;}
{NB}e[+|-]?{NB} {printf("nb : %f\n", atof(yytext)); return tNBE;}

%%

