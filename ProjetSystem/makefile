all : projetSyst2

projetSyst2 : y.tab.c lex.yy.c
	gcc -g -Wall y.tab.c lex.yy.c tabSymb.c varTemp.c tabLabel.c -ll -o projetSyst

y.tab.c : projetSyst.y 
	yacc -d -v projetSyst.y

lex.yy.c : projetSyst.l
	flex projetSyst.l

 tabSymb.o : tabSymb.c tabSymb.h
	gcc -c -Wall tabSymb.c -o tabSymb.o 

varTemp.o : varTemp.c varTemp.h
	gcc -c -Wall varTemp.c -o varTemp.o

tabLabel.o : tabLabel.c tabLabel.h
	gcc -c -Wall tabLabel.c -o tabLabel.o
