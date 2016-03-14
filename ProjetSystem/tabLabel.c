#include "tabLabel.h"

// Retourne le numéro du label
int new_label()
{
	tabLab[label][0] = label;
	label ++;
	return tabLab[label][0];
}

// Affecte la valeur val (adresse du label) du label numLabel
void set_label(int numLabel, int val)
{
	tabLab[numLabel][1] = val;
}
