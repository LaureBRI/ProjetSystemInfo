int main (){
	int a;
	1+2;
	a=1;
	a=a+b;
	b=1+2;

	func(toto, 345, arg);
	if(1==4)
	{
		toto=543;
	}
	while(1)
	{
		toto=i+1;
	}
}

// CODE DES IF et IF + SUITE :
/* ------------ IF + ELSE -------------- */
BlocIF: 
	tIF tPO Cond  
	{
		int l = new_label();
		$1 = l;
		fprintf (fasm, "JMF %d %d\n", $3, l); 
		pc++;
	}
	tPF
	tAO
	{
		depth++;
	}
	Body tAF
	{
		depth--;
		int l1 = new_label();
		$2 = l1;
	   	fprintf (fasm, "JMP %d\n", $2); 
	    pc++;
	}
	tELSE tAO
	{
		depth++;
		set_label($1, pc);
	}
	Body tAF
	{
		depth--;
		set_label($2, pc);
	}


/* IF : quatre cas : if ou if else ou if elseif ou if elseif else*/ 	
BlocIF: 
	/* ------------ IF + ELSE -------------- */
	tIF tPO Cond  
	{
		int l = new_label();
		$1 = l;
		fprintf (fasm, "JMF %d %d\n", $3, l); 
		pc++;
	}
	tPF
	tAO
	{
		depth++;
	}
	Body tAF
	{
		depth--;
	   	fprintf (fasm, "JMP %d\n", $8); 
	    pc++;
	   	set_label($1, pc);
	}
	SuiteIF {}

SuiteIF:
	tELSEIF tPO Cond  
	{
		int l = new_label();
		$1 = l;
		fprintf (fasm, "JMF %d %d\n", $3, l); 
		pc++;
	}
	tPF
	tAO
	{
		depth++;
	}
	Body tAF
	{
		depth--;
	   	fprintf (fasm, "JMP %d\n", $8); 
	    pc++;
	    set_label($1, pc);
	    $$=pc;
	}
	SuiteELSEIF // TODO 
	| ELSE { $$=$1;}

SuiteELSEIF : 
	ELSE { $$=$1;}
	| { $$=pc;};

ELSE:
	tELSE tAO
	{
		depth++;
	}
	Body tAF
	{
		depth--;
		$$=pc;
	}
