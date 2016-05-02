%{
#include <stdio.h>
#include <stdlib.h>
#include "tabSymb.h"
#include "varTemp.h"
#include "tabLabel.h"


// ************** TODO *****************
	// Changer asmOFF
	// Ajouter "Fonction" où l'on peut faire des appels de fonctions


int yyerror(char *s);

/*Program Counter - Pour savoir le numéro d'instructions*/ 
int pc = 0;

/*Profondeur du bloc courant*/
int depth = 0;
/*Fichier qui récupère les instructions asm*/
FILE * fasm ; 
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
%token tMAIN tPO tPF tAO tAF 
%token tINT tVOID tERROR tRETURN tPRINT tELSE tSEMI tCOMA tADD tSUB tMULT tDIV tMOD tAFFECT tEQ tINF tINFEG tSUP tSUPEG tOR tAND
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

/*****************************/

// TODO --> Déclaration de fonction avant le main, et corps des fonctions après le tAF
/* Organisation générale  : main () { Corps } */
Input : DeclFonc tMAIN tPO tPF tAO Body tAF CorpsFonc

/*Full Type*/
FType: tVOID | tINT

/* Corps : Déclarations de variable suivit d'une liste d'instructions */ 
Body: PDeclars PInsts 	

/* Déclarations : partie vide ou déclarations de variable */ 
PDeclars: Decl
	|;

/* variables déclarées  : [int id] ou [int id, id2, id3] ou [const int id] ou [int id = exp] ou [int * id] */  
Decl: tINT tID tSEMI { struct chmpSymb nouv = buildEntry($2, depth, 0, 0); addEntry(nouv); }
	|tCONST tINT tID tSEMI
	|tINT tMULT tID tSEMI
	// ATENTION : Exp à vérifier ici
	|tINT tID tAFFECT Exp
	|tINT tID { struct chmpSymb nouv = buildEntry($2, depth, 0, 0); addEntry(nouv); } tCOMA SuiteDecl

SuiteDecl: tID {struct chmpSymb nouv = buildEntry($1, depth, 0, 0); addEntry(nouv);} tCOMA SuiteDecl
	| tID tSEMI {struct chmpSymb nouv = buildEntry($1, depth, 0, 0); addEntry(nouv);}

/* Partie Instructions : liste de Stucture d'instruction ou vide */ 
PInsts: Structure Insts	
	|;
	
/* une structure d'instruction est soit une instruction simple, soit un bloc if soit un bloc while */ 		
Structure: Inst tSepPtVir
	| BlocIF
	| BlocWhile

/* une instruction est soit une expression, soit une affectation soit un printf */ 
Inst: Exp 
	| Affect
	| Printf

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
// pointeurs : 
	| tMULT tID 
			{
			// Creer var tmp.
			int adrTmp = ajoutTable("-",0,1); 
			int adrIde = rechercheSymbole($2); 
			if (adrTmp == -1 ) 
			  { yyerror("ajoutTable\n"); }
			if (adrIde == -1 ) 
		  		{yyerror("rechercheSymbole\n"); }
			
			// Traduction ASM
			printf("COP %d %d\n", adrTmp,adrIde);
			fprintf (a,"COP %d %d\n", adrTmp,adrIde);
			asm_offset++; 
			// Affectation valeur de Exp
			$$ = adrTmp ; 
			}

Val: tNB /*Mettre dans des variables temporaires*/ { int n = lock(); printf("AFC %d %d\n", n, $1); pc++; $$ = n;}
	| tNBE /*{float * nbe = malloc(sizeof(float)); *nbe = $1; $$ = nbe;}*/
	| tID /*Regarder dans la table des symboles*/ { struct chmpSymb * c = findEntry($1); printf("COP \n"); pc++; $$ = c->address;}

/* une affectation est un identifiant = une expression */
Affect: tID tAFFECT Maths tSEMI { struct chmpSymb * c = findEntry($1); 
								printf("COP %d %d\n", c->address, $3); 
								pc++; 
								c->init = 1; 
								unlock($3); }
		|tMULT tID tAFFECT Maths  
		  { // TODO !
		  }

/* affichage : printf ( Exp ) */ 
Printf 
		: tPRINT tPO Maths tPF
		{
			fprintf (fasm,"PRI %d\n", $3);
		 	printf("PRI %d\n", $3); 
		 	asm_offset++; 
		}	
		
/* IF : deux cas : if ou if else */ 	
BlocIF: /* ------------ IF + ELSE -------------- */
		tIF tPO Maths tPF 
		{
			fprintf (fasm, "JMF %d \n", $3); 
		 
			if (ajoutLabel(asm_offset) == -1 ) 
				{ yyerror("ajoutLabel\n"); }
				
			$1 = get_tl_offset()-1; // l'offset a déjà été incrémenté par l'ajout du label
			asm_offset++;
		}
		tAO PInsts tAF
		{
			if (renseigneLabelAdr($1, asm_offset) == -1 )
		     	{ yyerror("renseigneLabelAdr\n"); }	
		     	// saut à la fin du else  => adresse encore inconnue : ajout table symbole

			if (ajoutLabel(asm_offset) == -1 ) 
				{ yyerror("ajoutLabel\n"); }
				
		    	fprintf (a, "JMP \n"); 
		    	asm_offset++;
		}
		tELSE tAO
		{  
		    	if (renseigneLabel(asm_offset) == -1 )
		     	{ yyerror("renseigneLabel\n"); }	
		}
		PInsts tAF 
		|/* ------------ IF -------------- */ 
		tIF tPO Maths tPF 
		{
			fprintf (fasm, "JMF %d \n", $3); 
			 
			if (ajoutLabel(asm_offset) == -1 ) 
				{ yyerror("ajoutLabel\n"); }
				
			$1 = get_tl_offset()-1; // l'offset a déjà été incrémenté par l'ajout du label
			asm_offset++;
		    }
		    tAO PInsts tAF
		    {
		    	if (renseigneLabelAdr($1, asm_offset) == -1 )
		     		{ yyerror("renseigneLabelAdr\n"); }	
		    }
		; 

/* Bloc WHILE : while ( expression ) { instructions } */
BlocWhile: tWHILE tPO 
			{ $1 = asm_offset ; // l'offset a déjà été incrémenté par l'ajout du label
			} 
			Maths tPF
			{
				fprintf (a, "JMF %d \n", $4); 
				 if (ajoutLabel(asm_offset) == -1 ) 
				{ yyerror("ajoutLabel\n"); }
				
				$4 = get_tl_offset()-1; // l'offset a déjà été incrémenté par l'ajout du label
				
				asm_offset++;
			}
			tAO PInsts tAF
			{
				if (renseigneLabelAdr($4, asm_offset+1) == -1 )
		     		{ yyerror("renseigneLabelAdr\n"); }	
		     	
		    	fprintf (a, "JMP %d \n", $1); 
		    	asm_offset++;
		    }

// Partie Fonction : DeclFonc et CorpsFonc et appel de fonction
// Déclaration des fonctions :
DeclFonc: FType tID tPO Args tPF tSEMI

Args: tID SuiteArgs
	| tNB SuiteArgs
	|;

SuiteArgs: tCOMA tID SuiteArgs
	| tCOMA tNB SuiteArgs
	| tCOMA tNB
	| tCOMA tID

// Définition des fonctions :
CorpsFonc: FType tID tPO Args tPF tAO Body tAF

//appel de  fonction f(a); --> table des fonctions
Fonction: tID tPO Args tPF tSEMI



%%
/* Fonction de gestion des erreurs */ 
void yyerror(char *s)
{
     printf("ERREUR COMPILATEUR : ligne %d : %s \n", yylineno, s);
}
/* Fonction Main de Yacc pour lancer le parseur */ 
int main(void) {
	initTableSymbole() ; 
	initTableLabel() ; 
	asm_offset = 0 ;
 	fasm = fopen("asm.txt", "w");
	printf("\n\n");
	yyparse();
	afficheSymboles(); 
	afficheLabels(); 
	fclose(a);
	recopie();
	return 0;
}