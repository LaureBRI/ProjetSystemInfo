%{

#include ".h"

#include <stdlib.h>

%}

%token tINT tID tPO tPF tIF tERROR tVIR

%start Input 
%%

Input: DFonction Input
	| ;

DFonction: FType tID tPO Params tPF Body

If: tIF tPO Cond tPF Body

/* Full Type */
FType: tVOID | Type

Type: tINT, tFLOAT

Params: Type tID SuiteParams
	|;

SuiteParams: tVIR Type tID SuiteParams
	|;

While: tWHILE tPO Cond tPF Boby

Body: tAO Content tAF

Content: If Content
	| While Content
	| Decl
	| Maths Content
	| Aff Content
	| Body
	| Fonction
	|;

Cond: E tINF E
	| E tINFEG E
	| E tSUP E
	| E tSUPEG E
	| Cond tOR Cond
	| Cond tAND Cond
	| tPO Cond tPF


%%

int yyerror(char *s) {
  printf("%s\n",s);
}

int main(void) {
  yyparse();
}
