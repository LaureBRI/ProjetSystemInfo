struct chmpSymb {
	char * nom;
	int depth;
	int adress;
	int init; // O ou autre : savoir si la variable à été initialisée
	int cte; // O ou autre : savoir si c'est une constante
};

struct tabSymb {
	struct chmpSymb elem;
	struct tabSymb * next;
};
