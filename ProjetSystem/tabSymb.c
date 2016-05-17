#include "tabSymb.h"

struct tabSymb * tab;


// Construit une ligne de la table des symboles
struct chmpSymb buildEntry(char * n, int d, int i, int c){
	struct chmpSymb * entry = malloc(sizeof(struct chmpSymb));
	entry->name = malloc(strlen(n)*sizeof(char));
	strcpy(entry->name, n);
	entry->depth = d;
	entry->address = -1;
	entry->init = i;
	entry->cte = c;

	return *entry;
}

// Ajoute la structure elem à la liste tab
int addEntry(struct chmpSymb elem){
	int add = -1;
	int ret = -1;

	if (tab == NULL){
		tab = malloc(sizeof(struct tabSymb));
		tab->head = malloc(sizeof(struct cellTabSymb));
		tab->head->elem = elem;
		tab->head->elem.address = 0;
		tab->head->next = NULL;
		tab->tail = tab->head;
		ret = 0;
	}
	else
	{
		tab->tail->next = malloc(sizeof(struct cellTabSymb));
		add = tab->tail->elem.address+1;
		tab->tail = tab->tail->next;
		tab->tail->elem = elem;
		tab->tail->elem.address = add;
		tab->tail->next = NULL;
		ret = 0;
	}
	return ret;
}

//Supprime le dernier élément de la liste tab
// return : 0 si ok, 1 si la pile était déjà vide
int supprEntry(){
	struct cellTabSymb * next;
	next = tab->head;

	if (tab == NULL){
		return 1;
	}

	while(next->next != tab->tail){
		next = next->next;
	}
	tab->tail = next;
	free(tab->tail->next);
	tab->tail->next = NULL;

	return 0;
}

struct tabSymb * getTab()
{
	return tab;
}
//Trouve une entrée dans la table des symboles par son nom
struct chmpSymb * findEntry(char * n){
	if(tab == NULL)
		return NULL;
	struct cellTabSymb * courant;
	int found = 0;
	courant = tab->head;
	if(courant == NULL){
		printf("Champ %s inexistant dans la table des symboles (vide).\n", n);
		return NULL;
	}
	else
	{
		while(courant != tab->tail && found == 0){
			if(strcmp(courant->elem.name, n) == 0)
			{
				found = 1;
			}
			courant = courant->next;
		}

		if(found == 1)
		{
			return &(courant->elem);
		}
		else
		{
			return NULL;
		}
	}
}

//Supprimer les variables de la profondeur depth
int supprByDepth(int depth)
{
	int ret = 0;
	return ret;
	struct cellTabSymb * courant;
	courant = tab->head;

	while(courant->next != NULL)
	{
		if(courant->elem.depth == depth)
		{	
			ret = supprEntry();
			if (ret == -1){
				printf("Err supprByDepth - supprEntry\n");
				return -1;
			}

		}
		courant = courant->next;
	}

	return 0;
}


