# INF243 - Patchwork Project in Ada

##Grammaire Projet:

Vocabulaire terminal ={CARRE,TRIANGLE,ROND,ROTATION,EMPILEMENT,NBJR,BLANC,NOIR,ROUGE,BLEU,
                       VERT,JAUNE,PARENTH_OUVRANTE,PARENTH_FERMANTE,IDENTIFICATEUR,
                       AFFCOULEUR,AFFECTATION,POUR_CENT,FIN_LIGNE,FIN_SEQUENCE}

Vocabulaire non terminal = { Description, SeqAff, Aff, Exp, SeqJuxt, SeqEmp, Motif }

Axiome = Description

Règles :
	R01 : Descrition ::= SeqAff POUR_CENT FIN_LIGNE Exp FIN_LIGNE FIN_SEQUENCE
	R02 : SeqAff   	 ::= Aff SeqAff
	R03 : SeqAff  	 ::= epsilon
	R04 : Aff      	 ::= IDENTIFICATEUR AFFECTATION Exp FIN_LIGNE
	R05 : Aff      	 ::= IDENTIFICATEUR AFFCOULEUR (NOIR|BLANC|ROUGE|BLEU|VERT|JAUNE)
			                                       AFFECTATION Exp FIN_LIGNE
	R06 : Exp        ::= Motif SeqJuxt
	R07 : Exp 	 ::= Motif SeqEmp
	R08 : SeqEmp	 ::= emp Motif (SeqJuxt|SeqEmp)
	R09 : SeqEmp     ::= emp NBJR Motif (SeqJuxt|SeqEmp)
	R10 : SeqJuxt	 ::= juxt Motif SeqJuxt
	R11 : SeqJuxt 	 ::= juxt NBJR Motif SeqJuxt
	R12 : SeqEmp	 ::= epsilon
	R13 : Motif      ::= CARRE
	R14 : Motif      ::= TRIANGLE
	R15 : Motif      ::= ROND
	R16 : Motif      ::= IDENTIFICATEUR
	R17 : Motif      ::= rot Motif
	R18 : Motif	 ::= rot NBJR Motif
	R19 : Motif	 ::= PARO Exp PARF
	Dir(R03)  = { POUR_CENT }
	Dir(R04)  = { IDENTIFICATEUR }
	Dir(R05)  = { IDENTIFICATEUR }
	Dir(R08)  = { EMPILEMENT }
	Dir(R09)  = { EMPILEMENT }
	Dir(R10)  = { JUXTAPOSITION }
	Dir(R11)  = { JUXTAPOSITION }
	Dir(R12)  = { FIN_LIGNE, PARENTH_FERMANTE }
	Dir(R13)  = { CARRE }
	Dir(R14)  = { TRIANGLE }
	Dir(R15)  = { ROND }
	Dir(R16)  = { IDENTIFICATEUR }
	Dir(R17)  = { ROTATION }
	Dir(R18)  = { ROTATION }
	Dir(R19)  = { PARENTH_OUVRANTE }

## Tests
1) test du motif "rond"		jerond.txt
2) test des affectations	jeident.txt
3) test des couleurs		jecouleur.txt
4) test de l'empilement		jeemp.txt
5) test de n juxtaposition  jenjuxt.txt
6) test de n rotation		jenrot.txt
7) test de n empilement		jenemp.txt