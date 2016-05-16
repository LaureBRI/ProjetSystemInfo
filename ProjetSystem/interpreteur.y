/* -------------------------- */
/*     Définitions			  */ 
/* -------------------------- */
%{
#include <stdio.h>
#include <stdlib.h>
#define TAILLE_BUF 256
#define TAILLE_INS 256
#define TRUE 	1
#define FALSE	0
int mem[TAILLE_BUF] ; 

struct ins {
  int op;
  int a;
  int b;
  int c;
};

struct ins inss[TAILLE_INS] ; 
int add_ins(int ins, int a, int b, int c); 

int indexI = 0;

void yyerror(char * s); 

enum {
	iADD,
	iMUL,
	iDIV,
	iSOU,
	iCOP,
	iAFC,
	iPRI,
	iJMF,
	iJMP,
	iCOPA,
	iCOPB
	};
	
%}


%union {int nb; }
%token tADD tMUL tDIV tSOU tCOP tAFC tJMP tJMF tPRI tCOPA tCOPB
%token <nb> tNb

	/* Axiome de départ */ 
%start Assembleur
%%

/* -------------------------- */
/* Regles de transformations  */
/* -------------------------- */

Assembleur 
		: Inst Assembleur 
		|
		; 

Inst 	
		: tADD tNb tNb tNb
		{
			add_ins(iADD, $2, $3, $4);
		}
		
		| tMUL tNb tNb tNb
		{
			add_ins(iMUL, $2, $3, $4);
		}
		| tDIV tNb tNb tNb
		{
			add_ins(iDIV, $2, $3, $4);
		}
		| tSOU tNb tNb tNb
		{
			add_ins(iSOU, $2, $3, $4);
		}
		| tCOP tNb tNb 
		{
			add_ins(iCOP, $2, $3, -1);
		}
		| tAFC tNb tNb
		{
			add_ins(iAFC, $2,$3,-1);
		}
		| tPRI tNb
		{
			add_ins(iPRI,$2,-1,-1);
		}
		| tJMF tNb tNb
		{
			add_ins(iJMF,$2,$3,-1);
		}
		| tJMP tNb
		{
			add_ins(iJMP,$2,-1,-1);
		}
		| tCOPA tNB tNB
		{
			add_ins(iCOPA,$2,$3,-1);
		}
		| tCOPB tNB tNB
		{
			add_ins(iCOPB,$2,$3,-1);
		}
			
		
		;
/* -------------------------- */
/*     Programmes       	  */ 
/* -------------------------- */
%%
	/* Fonction de gestion des erreurs */ 
void yyerror(char *s)
{
     printf("ERREUR INTERPRETEUR : %s \n", s);
}
	/* Fonction Main de Yacc pour lancer le parseur */ 
int main(void) {

	// indice de la prochaine instruction à executer dans mem
	int i = 0 ; 

	
	// parse le fichier assembleur
	yyparse();
	printf("\n\n");
	// parcours la mémoire des instructions et execute les instructions
	// dans le bon ordre (sauts pris en compte) 
	while (i < indexI) {
		switch(inss[i].op)
		{
			case iADD : 
				mem[inss[i].a] = mem[inss[i].b] + mem[inss[i].c];
				break ; 
			case iMUL : 
				mem[inss[i].a] = mem[inss[i].b] * mem[inss[i].c];
				break ; 
			case iDIV : 
				mem[inss[i].a] = mem[inss[i].b] / mem[inss[i].c];
				break ; 
			case iSOU : 
				mem[inss[i].a] = mem[inss[i].b] - mem[inss[i].c];
				break ; 
			case iCOP : 
				mem[inss[i].a] = mem[inss[i].b];
				break ; 
			case iAFC : 
				mem[inss[i].a] = inss[i].b;
				break ; 
			case iJMF : 
				if (mem[inss[i].a] != TRUE )
				{
					// saut
					i = inss[i].b; 
					i-- ;
				}
				break ; 
			case iPRI : 
				printf("%d\n", mem[inss[i].a]);
				break ; 
			case iJMP : 
				// saut
				i = inss[i].a; 
				i-- ;
				break ;
			case iCOPA :
				mem[inss[i].a] = mem[inss[i].b] ;
				break;
			case iCOPB :
				mem[inss[i].a] = inss[i].b;
				break;

		}
		i++; 
	}
	
		printf("\n\n");
	return 0;
}

/*
 * Ajout d'une instruction dans la mémoire d'instructions
 * Si l'instruction sontient moins de 3 paramêtres 
 * la valeur -1 sera renseignée
 * retour 	0 si ajout OK,
 * 			-1 si erreur durant l'ajout (table pleine, instruction invalide)
 */
int add_ins(int ins, int a, int b, int c) {
	//printf("add instruction: %d %d %d %d\n", ins, a, b, c);
	if (indexI == TAILLE_INS ) 
	{
		printf("Erreur -- table d'instructions saturée\n"); 
		return -1 ; 
	}
	
	inss[indexI].op = ins;
	inss[indexI].a = a;
	inss[indexI].b = b;
	inss[indexI].c = c;

	indexI++ ; 
	return 0;
}


