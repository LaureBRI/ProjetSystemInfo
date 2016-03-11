%{
#include <stdio.h>
#include <stdlib.h>
#include <tabSymb.h>
int yyerror(char *s);

struct tabSymb tab;

%}

%error-verbose
%union {int varnb; float varnbe; char * varc;}
%token <varnb> tNB
%token <varc> tID
%token <varnbe> tNBE
%token tINT tVOID tPO tPF tIF tERROR tCOMA tAO tAF tADD tSUB tMULT tDIV tMOD tAFFECT tEQ tSEMI tRETURN tPRINT tWHILE tINF tINFEG tSUP tSUPEG tOR tAND
%left tMULT tDIV tMOD 
%left tADD tSUB 
%left tEQ tINF tINFEG tSUP tSUPEG
%left tAND tOR
%right tAFFECT

%start Input 
%%

Input: DFonction Input
	|;

DFonction: FType tID tPO Params tPF Body

If: tIF tPO Cond tPF Body

/* Full Type */
FType: tVOID | Type

/*A completer si on veut pouvoir traiter d'autres types par la suite*/
Type: tINT

Params: Type tID 
	| Type tID SuiteParams
	|;

SuiteParams: tCOMA Type tID
	|tCOMA Type tID SuiteParams

While: tWHILE tPO Cond tPF Body

Body: tAO Content tAF

Content: If Content
	| While Content
	| Decl Content
	| Aff Content
	| Maths tSEMI Content
	| Body
	| Fonction Content
	|;

/*Ajouter la gestion des parenthèses pour les priorités des calculs*/

Maths: Val
	| tPO Maths tPF
	| Maths tSUB Maths { }
	| Maths tADD Maths
	| Maths tMULT Maths
	| Maths tDIV Maths
	| Maths tMOD Maths

Val: tNB /*Mettre dans des variables temporaires*/ {int * nb = malloc(sizeof(int)); *nb = $1; $$ = nb;}
	| tNBE {float * nbe = malloc(sizeof(float)); *nbe = $1; $$ = nbe;}
	| tID /*Regarder dans la table des symboles*/ { chmpSymb * c = findEntry($1, tab); $$ = c->address}

/*Déclaration sans affectation seulement*/
Decl: Type tID tSEMI
	|Type tID tCOMA SuiteDecl

SuiteDecl: tID tCOMA SuiteDecl
	| tID tSEMI

Cond: Exp tINF Exp
	| Exp tINFEG Exp
	| Exp tSUP Exp
	| Exp tSUPEG Exp
	| Exp tEQ Exp
	| Cond tOR Cond
	| Cond tAND Cond
	| tPO Cond tPF
	| Exp

Exp: tNB | tID

Fonction: tID tPO Args tPF tSEMI

Args: tID SuiteArgs
	| tNB SuiteArgs
	|;

SuiteArgs: tCOMA tID SuiteArgs
	| tCOMA tNB SuiteArgs
	| tCOMA tNB
	| tCOMA tID

Aff: tID tAFFECT Maths tSEMI

/* Rajouter si on décide de prendre en charge d'autres types */

Print: tPRINT

Return: tRETURN


/* TODO LEX : || && ... */

/* TODO YACC : revoir tPRINT tRETURN */

%%

int yyerror(char *s) {
	printf("%s\n",s);
	return 0;
}

int main(void) {
	yyparse();
}
