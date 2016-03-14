#ifndef _VARTEMP_H_
#define _VARTEMP_H_

#include "tabSymb.h"

//1 = Vrai || 0 = Faux

struct varTmp{
	int address;
	int locked;
};

struct varTmp tabVarTmp[256];

/* Cherche une place dans le tableau des variables temporaires
 	et retourne l'indice du tablau  où se trouve la variable temporiare*/
int lock();

/* Libère la varibale temporaire à l'indice ind de la table tabVarTmp 
	retourne 0 si réussi -1 sinon*/ 
int unlock(int addr);


#endif
