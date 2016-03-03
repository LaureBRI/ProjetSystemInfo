%{
#include <stdio.h>
#include <stdlib.h>

int yyerror(char *s);

%}

%error-verbose
%token tINT tVOID tID tPO tPF tIF tERROR tCOMA tAO tAF tADD tSUB tMULT tDIV tMOD tAFFECT tEQ tSEMI tRETURN tPRINT tWHILE tNB tNBE tINF tINFEG tSUP tSUPEG tOR tAND
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
Maths: Val SuiteMaths

/*REDUCE -> a revoir*/

SuiteMaths: tADD Val SuiteMaths
	|tSUB Val SuiteMaths
 	|tMULT Val SuiteMaths
	|tDIV Val SuiteMaths
	|tMOD Val SuiteMaths
	|tADD Val
	|tSUB Val
	|tMULT Val
	|tDIV Val
	|tMOD Val

Val: tNB
	| tNBE
	| tID

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

Aff: tID tAFFECT ValAffect tSEMI
	| tID tAFFECT Maths tSEMI

/* Rajouter si on décide de prendre en charge d'autres types */
ValAffect: tNB


/* TODO LEX : || && ... */

/* TODO YACC : Revoir Maths(faire priorité des opérateurs) Gerer tPRINT tRETURN */

%%

int yyerror(char *s) {
	printf("%s\n",s);
	return 0;
}

int main(void) {
	yyparse();
}
