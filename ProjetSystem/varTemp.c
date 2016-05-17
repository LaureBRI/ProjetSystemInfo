#include "varTemp.h"


/* Cherche une place dans le tableau des variables temporaires
 	et retourne l'addresse de la variable temporaire*/
int lock(){
	int found = 0;
	int i = 0;

	// trouver une place libre dans le tableau
	for(i = 0; i < 256; i++){
		if(tabVarTmp[i].locked == 0){
			found = 1;
			break;
		}
	}

	if(found)
	{
		//affectation
		tabVarTmp[i].locked = 1;
		// adresse du haut de la table des symboles + i + 1
		tabVarTmp[i].address = getTab()->head->elem.address + 1 + i ;
	}
	
	return tabVarTmp[i].address;
}


/* Libère la varibale temporaire à l'indice ind de la table tabVarTmp 
	retourne 0 si réussi -1 sinon*/ 
int unlock(int addr){
	int i = 0;
	int found = 0;

	for(i = 0; i < 256; i++) {
		if(tabVarTmp[i].address == addr) {
			found = 1;
			break;
		}
	}

	if(found)
	{
		tabVarTmp[i].locked = 0;
		return 0;
	}
	return -1;
}
