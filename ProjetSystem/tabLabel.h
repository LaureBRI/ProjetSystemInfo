#ifndef _TABLABEL_H_
#define _TABLABEL_H_

int label = 0;

int tabLab[256][2];

// Retourne le numéro du label
int new_label();

// Affecte la valeur val (adresse du label) du label numLabel
void set_label(int numLabel, int val);


#endif