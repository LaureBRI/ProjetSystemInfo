%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}
%option yylineno
%option noyywrap
chiffre [0-9]

%%
"ADD"     	{ printf("ADD\n");return tADD; }
"MUL"    	{ printf("MUL\n");return tMUL; }
"DIV"     	{ printf("DIV\n");return tDIV; }
"SOU"		{ printf("SOU\n");return tSOU; }
"INF"		{ printf("INF\n");return tINF; }
"SUP"		{ printf("SUP\n");return tSUP; }
"EQU"		{ printf("EQU\n");return tEQU; }
"COP"     	{ printf("COP\n");return tCOP; }
"PRI"		{ printf("PRI\n");return tPRI; }
"AFC"   	{ printf("AFC\n");return tAFC; }
"JMP" 		{ printf("JMP\n");return tJMP; } 
"JMF"  	  	{ printf("JMF\n");return tJMF; }
"COPA"		{ printf("COPA\n");return tCOPA;}
"COPB"		{ printf("COPB\n");return tCOPB;}
"\n"    	{ }
[ \t]+	 	{ }

{chiffre} { yylval.nb = atoi(yytext); 
			return tNB; }
	
