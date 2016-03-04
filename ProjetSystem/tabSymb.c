#include "tabSymb.h"

// Construit une ligne de la table des symboles
struct chmpSymb buildEntry(char * n, int d, int a, int i, int c){
	struct chmpSymb * entry = malloc(sizeof(struct chmpSymb));
	entry->name = malloc(strlen(n)*sizeof(char));
	strcpy(entry->name, n);
	//strncpy(entry->name, n, strlen(n));
	//Pas besoin de faire strNcpy parce qu'on alloue juste la taille de n
	entry->depth = d;
	entry->address = a;
	entry->init = i;
	entry->cte = c;

	return *entry;
}

// Ajoute la structure elem à la liste tab
void addEntry(struct chmpSymb elem, struct tabSymb * tab){
	struct tabSymb * courant;
	struct tabSymb * next;
	struct tabSymb * temp;
	next = tab;

	if (tab == NULL){
		tab = malloc(sizeof(struct tabSymb))
		tab->head = malloc(sizeof(struct cellTabSymb));
		tab->head->elem = elem;
		tab->head->next = NULL;
		tab->tail = tab->head;
	}
	else
	{
		while(next != NULL){
			courant = next;
			next = courant->next;
		}
		temp = malloc(sizeof(struct tabSymb));
		temp->elem = elem;
		temp->next = NULL;
		courant->next = temp;
	}
}

// Peut être retourner un int pour savoir si la pile était déjà vide au départ
//Supprime le dernier élément de la liste tab
void supprEntry(struct tabSymb * tab){
	struct tabSymb * courant;
	struct tabSymb * next;
	next = tab;

/*	if (tab == NULL){
		return -1
	}
	else
*/
	while(next->next != NULL){
		courant = next;
		next = courant->next;
	}
	courant->next = NULL;
	free(next);
}

//Trouve une entrée dans la table des symboles par son nom
struct chmpSymb * findEntry(char * n, struct tabSymb * tab){
	struct tabSymb * courant;
	courant = tab;

	if(tab == NULL){
		return NULL;
	}
	else
	{
		while(strcmp(courant->elem.name, n) != 0 || courant->next != NULL){
			courant = courant->next;
		}
		return &(courant->elem);
	}
}


int main(int args, char * argv[]){
	struct tabSymb * tab = malloc(sizeof(struct tabSymb));
	struct chmpSymb entry = buildEntry("toto", 1, 2, 1, 1);

	struct tabSymb * courant;
	courant = tab;

	addEntry(*entry, tab);

/*	while(courant->next != NULL){
		printf("%s\n", courant->elem.name );
		courant = courant->next;
	}*/

	return 0;
}


