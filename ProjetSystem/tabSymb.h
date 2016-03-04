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

struct chmpSymb buildEntry(char * n, int d, int a, int i, int c);
void addEntry(struct chmpSymb elem, struct tabSymb * tab);
void supprEntry(struct tabSymb * tab);
struct chmpSymb * findEntry(char * n, struct tabSymb * tab);

#endif