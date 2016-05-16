%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}
%option yylineno
%option noyywrap
chiffre [0-9]

%%
"ADD"     	{ return tADD; }
"MUL"    	{ return tMUL; }
"DIV"     	{ return tDIV; }
"SOU"		{ return tSOU; }
"COP"     	{ return tCOP; }
"PRI"		{ return tPRI; }
"AFC"   	{ return tAFC; }
"JMP" 		{ return tJMP; } 
"JMF"  	  	{ return tJMF; }
"COPA"		{ return tCOPA;}
"COPB"		{ return tCOPB;}
"\n"    	{ }

{chiffre} { yylval.nb = atoi(yytext); 
			return tNb; }
	
