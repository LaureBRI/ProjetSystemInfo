%{
#include <stdio.h>
#include <stdlib.h>
#include "tabSymb.h"
#include "varTemp.h"
#include "tabLabel.h"

int yyerror(char *s);

/*Program Counter - Pour savoir le numéro d'instructions*/ 
int pc = 0;

/*Profondeur du bloc courant*/
int depth = 0;

%}

%error-verbose
%union {int varnb; float varnbe; char * varc; 
		struct typeWhile{int to; int from;} typeWhile;
		}
%token <varnb> tNB
%token <varc> tID
%token <varnbe> tNBE
%token <varnb> tIF 
%token <typeWhile> tWHILE
%token tINT tVOID tPO tPF tELSE tERROR tCOMA tAO tAF tADD tSUB tMULT tDIV tMOD tAFFECT tEQ tSEMI tRETURN tPRINT tINF tINFEG tSUP tSUPEG tOR tAND
/*Typage des non terminaux */
%type <varnb> Maths
%type <varnb> Val 
%type <varnb> Cond
%type <varnb> Exp

/*Spécification de priorité pour les opérateurs arithmétiques*/
%left tMULT tDIV tMOD 
%left tADD tSUB 
%left tEQ tINF tINFEG tSUP tSUPEG
%left tAND tOR
%right tAFFECT

/*Axiome de départ*/
%start Input 

%%

Input: DFonction Input
	|;

/*Déclaration des fonctions*/ 
DFonction: FType tID tPO Params tPF Body
 
If: tIF tPO Cond { int l = new_label(); $1 = l; printf("JMF %d %d\n", $3, l); pc++;} tPF Body { set_label($1,pc); } SuiteIf

SuiteIf : tELSE Body | ;

/*Full Type*/
FType: tVOID | Type

/*A completer si on veut pouvoir traiter d'autres types par la suite*/
Type: tINT

Params: Type tID 
	| Type tID SuiteParams
	|;

SuiteParams: tCOMA Type tID
	|tCOMA Type tID SuiteParams

While: tWHILE /*{$1.to = pc;}*/ tPO Cond { int l = new_label(); $1.from = l; printf("JMF %d %d\n", $3, l); pc++;} tPF Body { set_label($1.from,pc); 
																															printf("JMP %d\n", $1.to );
																															pc++;
																															}

Body: tAO {depth++;} Content tAF { supprByDepth(depth); depth--;}

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
	| Maths tADD Maths { printf("ADD %d %d %d\n", $1, $1, $3); 
						pc++; 
						unlock($3); 
						$$ = $1;}
	| Maths tSUB Maths { printf("SOU %d %d %d\n", $1, $1, $3); 
						pc++; 
						unlock($3); 
						$$ = $1;}
	| Maths tMULT Maths { printf("MUL %d %d %d\n", $1, $1, $3); 
						pc++; 
						unlock($3); 
						$$ = $1;}
	| Maths tDIV Maths { printf("DIV %d %d %d\n", $1, $1, $3); 
						pc++; 
						unlock($3); 
						$$ = $1;}
	| Maths tMOD Maths



Val: tNB /*Mettre dans des variables temporaires*/ { int n = lock(); printf("AFC %d %d\n", n, $1); pc++; $$ = n;}
	| tNBE /*{float * nbe = malloc(sizeof(float)); *nbe = $1; $$ = nbe;}*/
	| tID /*Regarder dans la table des symboles*/ { struct chmpSymb * c = findEntry($1); printf("COP \n"); pc++; $$ = c->address;}


/*Déclaration sans affectation seulement*/
// Action : mettre une nouvelle entrée dans la table des symboles
Decl: Type tID tSEMI { struct chmpSymb nouv = buildEntry($2, depth, 0, 0); addEntry(nouv); }
	|Type tID { struct chmpSymb nouv = buildEntry($2, depth, 0, 0); addEntry(nouv); } tCOMA SuiteDecl

SuiteDecl: tID {struct chmpSymb nouv = buildEntry($1, depth, 0, 0); addEntry(nouv);} tCOMA SuiteDecl
	| tID tSEMI {struct chmpSymb nouv = buildEntry($1, depth, 0, 0); addEntry(nouv);}

Cond: Exp tINF Exp { printf("INF %d %d %d\n", $1, $1, $3); pc++; }
	| Exp tINFEG Exp { 
					}
	| Exp tSUP Exp{ printf("SUP %d %d %d\n", $1, $1, $3); pc++; }
	| Exp tSUPEG Exp { 

					}
	| Exp tEQ Exp { printf("EQU %d %d %d\n", $1, $1, $3); pc++; 
					}
	| Cond tOR Cond
	| Cond tAND Cond
	| tPO Cond tPF
	| Exp

Exp: tNB 
	| tID { struct chmpSymb * c = findEntry($1); $$ = c->address;}

//appel de  fonction f(a); --> table des fonctions
Fonction: tID tPO Args tPF tSEMI



Args: tID SuiteArgs
	| tNB SuiteArgs
	|;

SuiteArgs: tCOMA tID SuiteArgs
	| tCOMA tNB SuiteArgs
	| tCOMA tNB
	| tCOMA tID

Aff: tID tAFFECT Maths tSEMI { struct chmpSymb * c = findEntry($1); 
								printf("COP %d %d\n", c->address, $3); 
								pc++; 
								c->init = 1; 
								unlock($3); }

/* Rajouter si on décide de prendre en charge d'autres types */

//Print: tPRINT

//Return: tRETURN


/* TODO LEX : || && ... */

/* TODO YACC : 
		revoir le While {} avant Condition
		Table des fonctions
		Condition INFEG SUPEG...
		revoir tPRINT tRETURN */

/* TODO : à faire interpréteur */

%%

int yyerror(char *s) {
	printf("%s\n",s);
	return 0;
}

int main(void) {
	yyparse();
}
