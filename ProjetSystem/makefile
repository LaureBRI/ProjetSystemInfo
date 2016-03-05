all : projetSyst

projetSyst : y.tab.c lex.yy.c
	gcc y.tab.c lex.yy.c -ll -o projetSyst

y.tab.c : projetSyst.y
	yacc -d -v projetSyst.y

lex.yy.c : projetSyst.l
	flex projetSyst.l

/* tabSymb.o : tabSymb.c tabSymb.h
	gcc -c tabSymb.c -o tabSymb.o */