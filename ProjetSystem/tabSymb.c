#include "tabSymb.h"

// Construit une ligne de la table des symboles
struct chmpSymb buildEntry(char * n, int d, int i, int c){
	struct chmpSymb * entry = malloc(sizeof(struct chmpSymb));
	entry->name = malloc(strlen(n)*sizeof(char));
	strcpy(entry->name, n);
	//strncpy(entry->name, n, strlen(n));
	//Pas besoin de faire strNcpy parce qu'on alloue juste la taille de n
	entry->depth = d;
	//-1 = pas encore initialisée
	entry->address = -1;
	entry->init = i;
	entry->cte = c;

	return *entry;
}

// Ajoute la structure elem à la liste tab
void addEntry(struct chmpSymb elem){
	int add = -1;

	if (tab == NULL){
		tab = malloc(sizeof(struct tabSymb));
		tab->head = malloc(sizeof(struct cellTabSymb));
		tab->head->elem = elem;
		tab->head->elem.address = 0;
		tab->head->next = NULL;
		tab->tail = tab->head;
	}
	else
	{
		tab->tail->next = malloc(sizeof(struct cellTabSymb));
		add = tab->tail->elem.address+1;
		tab->tail = tab->tail->next;
		tab->tail->elem = elem;
		tab->tail->elem.address = add;
		tab->tail->next = NULL;
	}
}

// Peut être retourner un int pour savoir si la pile était déjà vide au départ
//Supprime le dernier élément de la liste tab
void supprEntry(){
	struct cellTabSymb * next;
	next = tab->head;

	if (tab == NULL){
		exit(-1);
	}

	while(next->next != tab->tail){
		next = next->next;
	}
	tab->tail = next;
	free(tab->tail->next);
	tab->tail->next = NULL;
}

//Trouve une entrée dans la table des symboles par son nom
struct chmpSymb * findEntry(char * n){
	struct cellTabSymb * courant;
	courant = tab->head;

	if(tab->head == NULL){
		return NULL;
	}
	else
	{
		while(strcmp(courant->elem.name, n) != 0 || courant != tab->tail){
			courant = courant->next;
		}
		return &(courant->elem);
	}
}

//Supprimer les variables de la profondeur depth
void supprByDepth(int depth)
{
	while(tab->tail->elem.depth == depth)
	{
		supprEntry();
	}
}





/*int main(int args, char * argv[]){
	tab = malloc(sizeof(struct tabSymb));
	struct chmpSymb entry = buildEntry("toto", 2, 1, 1);

	struct tabSymb * courant;
	courant = tab;

	addEntry(entry);

	//while(courant->next != NULL){
	//	printf("%s\n", courant->elem.name );
	//	courant = courant->next;
	//}

	return 0;
}*/


