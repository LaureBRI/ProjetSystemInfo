#ifndef _TABSYMB_H_
#define _TABSYMB_H_

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

struct chmpSymb {
	char * name;
	int depth;
	int address;
	int init; // O ou autre : savoir si la variable à été initialisée
	int cte; // O ou autre : savoir si c'est une constante
};

struct cellTabSymb {
	struct chmpSymb elem;
	struct cellTabSymb * next;
};

struct tabSymb
{
	struct cellTabSymb * head;
	struct cellTabSymb * tail;
};

struct tabSymb * tab;

// Construit une ligne de la table des symboles
// avec n le nom de la variable
// 		d la profondeur
//		i si la variable est initialisé ou non 
//		c si varaible est une constante
struct chmpSymb buildEntry(char * n, int d, int i, int c);

// Ajoute la structure elem à la liste tab
void addEntry(struct chmpSymb elem);

// Peut être retourner un int pour savoir si la pile était déjà vide au départ
//Supprime le dernier élément de la liste tab
void supprEntry();

//Trouve une entrée dans la table des symboles par son nom
struct chmpSymb * findEntry(char * n);

//Supprimer les variables de la profondeur depth
void supprByDepth(int depth);





#endif