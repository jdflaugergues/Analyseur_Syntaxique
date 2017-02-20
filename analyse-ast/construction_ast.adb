------------------------------------------------------------------------
-- paquetage Construction_Ast
--
-- creation de l'arbre syntaxique abstrait d'une description de motif
-- arbitraire donnee sous la forme d'une constante de type texte
--
-- Jonathan de Flaugergues, Galel Koraa
------------------------------------------------------------------------
with Arbre_Abstrait,Ada.Text_IO,graphsimple;

package body Construction_Ast is

   use Arbre_Abstrait,Ada.Text_IO;

   ---------------------------------------------------------------------
   -- procedure creer_description ( opde_gauche, opde_droit : Ast;
   --                               expr : out Ast)
   ---------------------------------------------------------------------
   procedure creer_description( opde_gauche, opde_droit : Ast;
                                Expr : OUT Ast) IS
   BEGIN
      Expr:=NEW NoeudAst;
      Expr.All.Nature:=DESCRIPTION;
      Expr.All.Gauche:=Opde_Gauche;
      Expr.All.Droite:=Opde_Droit;
   end;         
   ---------------------------------------------------------------------
   -- procedure creer_SeqAffectation ( opde_gauche, opde_droit : Ast;
   --                            expr : out Ast)
   --
   ---------------------------------------------------------------------
   PROCEDURE Creer_SeqAffectation ( Opde_Gauche, Opde_Droit : Ast;
                                 Expr : OUT Ast) IS
   BEGIN
      Expr:=NEW NoeudAst;
      Expr.All.Nature:=SEQUENCE_AFFECTATION;
      Expr.All.Gauche:=Opde_Gauche;
      Expr.All.Droite:=Opde_Droit;
   END;
   ---------------------------------------------------------------------
   -- procedure creer_Affectation(motifG : Ast;Expr : OUT Ast)
   --
   ---------------------------------------------------------------------
   PROCEDURE Creer_Affectation (motifG : Ast; motifD :Ast; Expr : OUT Ast) IS
   BEGIN
      Expr:=NEW NoeudAst;
      Expr.All.Nature:=AFFECTATION;
      Expr.All.droite:=MotifD;
      Expr.all.gauche:=MotifG;
   end;
   ---------------------------------------------------------------------
   -- procedure Creer_Identificateur (motifCouleur : Couleur;
   --                  identificateur : Pointeur_Chaine; expr : out Ast)
   ---------------------------------------------------------------------
   PROCEDURE Creer_Identificateur (motifCouleur : Couleur;
                  identificateur : Pointeur_Chaine; expr : out Ast) is
   begin
		expr:=new NoeudAst;
		expr.all.nature:=IDENTIFICATION;
		expr.all.mcouleur:=motifCouleur;
      expr.all.ident:=identificateur;
   end;
   ---------------------------------------------------------------------
   -- procedure creer_identificateur_avec_Exp(ident:Pointeur_Chaine;
   --		                          Suite_chaine:Chaine; motif : out Ast) 
   ---------------------------------------------------------------------
   procedure creer_identificateur_avec_Exp(ident:Pointeur_Chaine;
   		             chaine_affectation:Chaine; expr : out Ast) is
   AC : Chaine;
   L1, L2 : integer;
   T1,T2 : String(1..256);
   begin
   AC:=chaine_affectation.all.IdSuivant;
   L1 := ident.all'length;
   T1(1..L1) := ident.all(1..L1);
   while AC/=null loop
      L2 := AC.all.identificateur.all'length;
      T2(1..L2) := AC.all.identificateur.all(1..L2);
      if L1 = L2 and then T1(1..L1) = T2(1..L2) then
         expr:=new NoeudAst;
			expr.all.ident:=ident;
			expr.all.nature:=IDENTIFICATION;
			expr.all.gauche:=AC.all.Idarbre;
      end if;
      AC:=AC.all.IdSuivant;
	end loop;
   end;
   ---------------------------------------------------------------------   
   -- procedure creer_operation (opr: TypeOperateur;
   --                           opde_gauche, opde_droit : Ast;
   --                           expr : out Ast)
   --
   -- cree un noeud de type operation binaire
   ---------------------------------------------------------------------
   procedure creer_operation(opr: TypeOperateur;
                             opde_gauche, opde_droit : Ast;
                             expr : out Ast) is
   begin
      expr:=new NoeudAst;
      expr.all.operateur:=opr;
      expr.all.nature:=OPERATION;
      expr.all.gauche:=opde_gauche;
      expr.all.droite:=opde_droit;
      
   end;

   ---------------------------------------------------------------------
   -- procedure creer_operation(opr: TypeOperateur;
   --                           opde : Ast; expr : out Ast)
   --
   -- cree un noeud de type operation unaire
   ---------------------------------------------------------------------
   procedure creer_operation(opr : TypeOperateur;
                                         opde : Ast; expr : out Ast) is
   begin
      expr:=new NoeudAst;
      expr.all.operateur:=opr;
      expr.all.nature:=OPERATION;
      expr.all.gauche:=opde;
      
   end;
   ---------------------------------------------------------------------
   -- procedure creer_nbrotation(opr : TypeOperateur;nb : in out Integer
   --                                        opde : Ast; Expr : out Ast)
   --
   -- Cree un noeud de type operation ROTATION avec son nombre de 
   --                                             rotation correspondant
   ---------------------------------------------------------------------
   procedure creer_nbrotation(opr : TypeOperateur; nb : in out Integer;
                                         opde : Ast; Expr : out Ast) is
   expr2 : Ast;
   begin
   if nb/=0 then	
      Nb:= Nb-1;
		if Nb/=0 then
         if Nb=1 then
			   creer_operation(opr,opde,expr2);
		   else
			   creer_nbrotation(opr,nb,opde,expr2);
		   end if;
		   expr:=new NoeudAst;
		   expr.all.operateur:=opr;
		   expr.all.nature:=OPERATION;
		   expr.all.gauche:=expr2;                                         
      else
         creer_operation(opr,opde,expr);
      end if;
   else
      expr:=opde;
   end if;
   end;
   ---------------------------------------------------------------------
   -- procedure creer_njuxtouemp( opr : TypeOperateur; nb in out
   --                               Integer; opdeG :Ast; Expr : Out Ast)  
   ---------------------------------------------------------------------
   procedure creer_njuxtouemp( opr : TypeOperateur; nb :in out
                          Integer; opdeG:Ast; Expr : Out Ast) is
   expr2 : Ast;
   begin
      Nb:=Nb-1;
      if Nb=0 then
         expr:=opdeG;
      else 
         creer_njuxtouemp(opr,nb,opdeG,expr2);
         expr:=new NoeudAst;
         expr.all.operateur:=opr;
         expr.all.nature:=OPERATION;
         expr.all.gauche:=opdeG;
         expr.all.droite:=expr2;
      end if;
   end;
   ---------------------------------------------------------------------
   -- procedure creer_valeur(couleur: Couleur ;val : Integer; 
   --                                                   expr : out Ast)
   --
   -- cree une feuille (de type valeur)
   ---------------------------------------------------------------------
   procedure creer_valeur(motifcouleur: Couleur; val : NaturePrimitif; 
                                                   expr : out Ast) is
   use graphsimple;
   begin
      Expr:=NEW NoeudAst;
      expr.all.valeur:=val;
      expr.all.nature:=VALEUR;
	   expr.all.mcouleur:=motifcouleur;
   end;
end Construction_Ast;
