%{

#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"

/*
-> pas géré dans le Yacc : nombre à virgule
{NB}e[+|-]?{NB} { yylval.varnbe = atof(yytext); printf("nb : %f\n", yylval.varnbe); return tNBE;} 
*/

%}

NB [0-9]+ 

COM    ("/*"([^*]|\*+[^*/])*\*+"/")|("//".*)

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
"=" {printf("=\n"); return tAFFECT;}
"==" {printf("==\n"); return tEQ;}
"," {printf(",\n"); return tCOMA;}
";" {printf(";\n"); return tSEMI;}
"<" {printf("<\n"); return tINF;}
">" {printf(">\n"); return tSUP;}
"&&" {printf("&&\n"); return tAND;}
"||" {printf("||\n"); return tOR;}

"main" {printf("main\n"); return tMAIN;}

"int" {printf("int\n"); return tINT;}
"const" {printf("const\n"); return tCONST;}

"return" {printf("return\n"); return tRETURN;}

"printf" {printf("printf\n"); return tPRINT;}

"if" {printf("if\n"); return tIF;}
"else" {printf("else\n"); return tELSE;}
"elseif" {printf("elseif\n"); return tELSEIF;}
"while" {printf("while\n"); return tWHILE;}

[a-zA-Z]+ { yylval.varc = strdup(yytext); printf("id : %s\n", yylval.varc); return tID;}
{NB} { yylval.varnb = atoi(yytext); printf("nb : %d\n", yylval.varnb); return tNB;}
{COM} {yylval.varc = strdup(yytext); printf("comm : %s\n", yylval.varc);}
%%

