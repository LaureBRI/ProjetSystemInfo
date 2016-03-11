#include "varTemp.h"

//-1 = non initialisé || 0 = Vrai || 1 = Faux

struct varTmp{
	int address;
	int locked;
};


struct varTmp tabVarTmp[256];

int lock(){
	int found = -1;
	int i = 0;

	while(i<256 || found == 1){
		if(tabVarTmp[i].locked == 1){
			found = 0;
		}
		i++;
	}

	
	return i;
}
