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
"%" {printf("%c\n",'%'); return tMOD;} // !!!!!!!!!!
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
"else" {printf("else\n"); return tELSE;}
"while" {printf("while\n"); return tWHILE;}

[a-zA-Z]+ { yylval.varc = strdup(yytext); printf("id : %s\n", yylval.varc); return tID;}
{NB} { yylval.varnb = atoi(yytext); printf("nb : %d\n", yylval.varnb); return tNB;}
{NB}e[+|-]?{NB} { yylval.varnbe = atof(yytext); printf("nb : %f\n", yylval.varnbe); return tNBE;}

%%

