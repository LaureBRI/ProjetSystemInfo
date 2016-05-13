%{
#include <stdio.h>
#include <stdlib.h>
#include "tabSymb.h"
#include "varTemp.h"
#include "tabLabel.h"


// ************** TODO *****************
	// Changer asmOFF
	// Ajouter "Fonction" où l'on peut faire des appels de fonctions


void yyerror(char *s);

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
%token <varnb> tPO
%token <varnb> tPF
//%token <typeWhile> tWHILE
%token <varnb> tWHILE
%token tMAIN tAO tAF 
%token tINT tVOID tERROR tRETURN tPRINT tCONST tELSE tELSEIF tSEMI tCOMA tADD tSUB tMULT tDIV tMOD tAFFECT tEQ tINF tINFEG tSUP tSUPEG tOR tAND
/*Typage des non terminaux */
%type <varnb> Maths
%type <varnb> Val 
%type <varnb> Cond
//%type <varnb> SuiteIF
//%type <varnb> SuiteELSEIF
//%type <varnb> ELSE

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

/* Organisation générale  : déclaration_des_fonctions main () { Corps } */
Input : DefFonc tMAIN tPO tPF tAO Body tAF // TODO : faire main(){}

/*Full Type*/
FType: tVOID | tINT

/* Corps : Déclarations de variable suivit d'une liste d'instructions */ 
Body: PDeclars PInsts 	

/* Déclarations : partie vide ou déclarations de variable */ 
PDeclars: Decl PDeclars
	| ;

/* variables déclarées  : [int id] ou [int id, id2, id3] ou [const int id] ou [int id = exp] ou [int * id] */  
Decl: 
	tINT tID tSEMI 
	{
		struct chmpSymb nouv = buildEntry($2, depth, 0, 0); 
		addEntry(nouv);
	}
	| tCONST tINT tID tAFFECT Maths tSEMI
	{
		struct chmpSymb nouv = buildEntry($3, depth, 0, 1);
		addEntry(nouv);
	}
	| tINT tMULT tID tSEMI
	{
		struct chmpSymb nouv = buildEntry($3, depth, 0, 0);
		addEntry(nouv);
	}
	| tINT tID tAFFECT Maths tSEMI
	{
		struct chmpSymb nouv = buildEntry($2, depth, 1, 0);
		addEntry(nouv);
	}
	| tINT tID 
	{
		struct chmpSymb nouv = buildEntry($2, depth, 0, 0);
		addEntry(nouv); 
	} tCOMA SuiteDecl

SuiteDecl: 
	tID 
	{
		struct chmpSymb nouv = buildEntry($1, depth, 0, 0);
		addEntry(nouv);
	} tCOMA SuiteDecl
	| tID tSEMI 
	{
		struct chmpSymb nouv = buildEntry($1, depth, 0, 0);
		addEntry(nouv);
	}

/* Partie Instructions : liste de Stucture d'instruction ou vide */ 
PInsts: Structure PInsts	
	|;
	
/* une structure d'instruction est soit une instruction simple, soit un bloc if soit un bloc while */ 		
Structure: Inst tSEMI
	| BlocIF
	| BlocWhile

/* une instruction est soit une expression, soit une affectation soit un printf */ 
Inst:  Affect
	| Printf

/* une expression mathématique est TODO*/
Maths: Val
	| tPO Maths tPF
	| Maths tADD Maths 
	{
		fprintf(fasm, "ADD %d %d %d\n", $1, $1, $3);
		pc++; 
		unlock($3); 
		$$ = $1;
	}
	| Maths tSUB Maths 
	{
		fprintf(fasm, "SOU %d %d %d\n", $1, $1, $3); 
		pc++; 
		unlock($3); 
		$$ = $1;
	}
	| Maths tMULT Maths 
	{
		fprintf(fasm, "MUL %d %d %d\n", $1, $1, $3);
		pc++; 
		unlock($3); 
		$$ = $1;
	}
	| Maths tDIV Maths
	{
		fprintf(fasm, "DIV %d %d %d\n", $1, $1, $3); 
		pc++; 
		unlock($3); 
		$$ = $1;
	}
	| Maths tINF Maths 
	{
		fprintf(fasm, "INF %d %d %d\n", $1, $1, $3); 
		pc++; 
		unlock($3); 
		$$ = $1;
	}
	| Maths tSUP Maths 
	{
		fprintf(fasm, "SUP %d %d %d\n", $1, $1, $3); 
		pc++; 
		unlock($3); 
		$$ = $1;
	}
	| Maths tMOD Maths 
	{
		fprintf(fasm, "MOD %d %d %d\n", $1, $1, $3); 
		pc++; 
		unlock($3); 
		$$ = $1;
	}
	// pointeurs
	// Maths retourne add temps, on va déréférencer ce qui est déjà dans une add temp, pas la peine d'en refaire une
	| tMULT Maths 
	{
		int addr = $2;
		fprintf(fasm, "COPA %d %d \n", addr, addr);
		pc++;
		$$ = addr;
	}

Val: 
	tNB /*Mettre dans des variables temporaires*/ 
	{ 
		int n = lock();
		fprintf(fasm, "AFC %d %d\n", n, $1);
		pc++;
		$$ = n;
	}
	// TODO
	/*| tNBE 
	{
		float * nbe = malloc(sizeof(float));
		*nbe = $1;
		$$ = nbe;
	}*/
	| tID /*Regarder dans la table des symboles*/ 
	{
		int n = lock();
		struct chmpSymb * c = findEntry($1);
		fprintf(fasm, "COP %d %d\n", n, c->address);
		pc++;
		$$ = n;
	}

/* une affectation est un identifiant = une expression */
Affect:
	tID tAFFECT Maths
	{
		struct chmpSymb * c = findEntry($1);
		fprintf(fasm, "COP %d %d\n", c->address, $3);
		pc++;
		c->init = 1;
		unlock($3);
	}
	| tMULT tID tAFFECT Maths  
	{
		struct chmpSymb * c = findEntry($2);
		fprintf(fasm, "COPB %d %d \n", c->address, $4);
		pc++;
	}

/* affichage : printf ( Exp ) */ 
Printf: 
	tPRINT tPO Maths tPF
	{
		fprintf (fasm,"PRI %d\n", $3);
	 	pc++; 
	}	

/* IF : if(){}else{}*/		
BlocIF: 
	tIF tPO Cond  
	{
		int l = new_label();
		$1 = l;
		fprintf (fasm, "JMF %d %d\n", $3, l); 
		pc++;
	}
	tPF
	tAO
	{
		depth++;
	}
	Body tAF
	{
		depth--;
		int l1 = new_label();
		$2 = l1;
	   	fprintf (fasm, "JMP %d\n", $2); 
	    pc++;
	}
	tELSE tAO
	{
		depth++;
		set_label($1, pc);
	}
	Body tAF
	{
		depth--;
		set_label($2, pc);
	}

/* Les conditions */
Cond:
	Maths
	| Maths tEQ Maths
	{
		fprintf (fasm, "EQU %d %d %d\n", $1, $1, $3); 
	}
	| ;

/* Bloc WHILE : while ( expression ) { instructions } */
BlocWhile: 
	tWHILE tPO Cond tPF
	{
		int l = new_label();
		$2 = l;
		fprintf (fasm, "JMF %d %d\n", $3, l);				
		pc++;
	}
	tAO Body tAF
	{
    	fprintf (fasm, "JMP %d \n", $1); 
    	set_label($2, pc);
    	pc++;
    }

// Partie Fonction : DeclFonc et CorpsFonc et appel de fonction
// Définition des fonctions :
DefFonc: FType tID tPO Args tPF tAO Body tAF DefFonc
	| ;

Args: tID SuiteArgs
	| tNB SuiteArgs
	| ;

SuiteArgs: tCOMA tID SuiteArgs
	| tCOMA tNB SuiteArgs
	| tCOMA tNB
	| tCOMA tID

//appel de  fonction f(a); --> table des fonctions
//Fonction: tID tPO Args tPF tSEMI



%%
extern int yylineno;
/* Fonction de gestion des erreurs */ 
void yyerror(char *s)
{
	printf("ERREUR COMPILATEUR : ligne %d : %s \n", yylineno, s);
}

/* Fonction Main de Yacc pour lancer le parseur */ 
int main(void) {
	//initTableSymbole() ; 
	init_label();
	pc = 0 ;
 	fasm = fopen("asm.txt", "w");
	printf("\n\n");
	yyparse();
	//afficheSymboles(); 
	//afficheLabels(); 
	fclose(fasm);
	printf("J'ai close !\n");
	//recopie();
	return 0;
}