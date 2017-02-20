------------------------------------------------------------------------
-- paquetage Analyseur_Syntaxique
--
-- analyse syntaxique d'une description de motif et creation de
-- l'arbre syntaxique abstrait correspondant
--
-- P. Habraken : 22 novembre 2006
------------------------------------------------------------------------
WITH Machine_Lexemes, Arbre_Abstrait, Construction_Ast,Graphsimple;
WITH Type_Patchwork,Ada.Text_IO,Convert,Ada.Integer_Text_IO;
with Table_des_symboles;

package body Analyseur_Syntaxique is

   use Machine_Lexemes, Arbre_Abstrait, Construction_Ast,Ada.Text_IO;
   use Table_des_symboles,graphsimple;
   --pragma Warnings (Off, "possible infinite recursion");
   --pragma Warnings (Off, "Storage_Error may be raised at run time");

   ---------------------------------------------------------------------
   -- pre-declaration /specification des sous-programmes
   -- utilises / appeles par la procedure analyser
   ---------------------------------------------------------------------

   procedure rec_Description (motif : out Ast ;suite_chaine : out Chaine );
   procedure rec_SeqAff (motif : out Ast ; suite_chaine : in out Chaine );   
   procedure rec_Aff (motif : out Ast ;suite_chaine : in out Chaine );
   PROCEDURE Rec_Exp (motifCouleur : IN Couleur ;Motif : OUT Ast ; 
                                               suite_chaine : in Chaine );
   PROCEDURE Rec_Seqjuxt ( motifCouleur : Couleur; MotifGauche : IN Ast; 
                              motif : out ast; suite_chaine : in Chaine );
   procedure Rec_SeqEmp (motifCouleur : Couleur; MotifGauche : in Ast;
                              motif : out ast; suite_chaine : in Chaine );
   PROCEDURE Rec_Motif (motifCouleur: Couleur; Motif : OUT Ast;
                                               suite_chaine : in Chaine );
   procedure rec_primitif (motifCouleur : Couleur; motifPrimitif : out Ast);
   procedure rec_lex(lexeme_attendu : Nature_Lexeme);
   procedure traiter_erreur;

   ---------------------------------------------------------------------
   -- procedure analyser
   --
   -- analyse une description de motif saisie au clavier et en cree
   -- l'arbre syntaxique abstrait
   ---------------------------------------------------------------------

   procedure analyser(motif : out Ast;suite_chaine : out Chaine ) is
   begin
      analyser("",motif,suite_chaine);
   end;

   ---------------------------------------------------------------------
   -- procedure analyser(nom_fichier : in String)
   --
   -- analyse une description de motif contenue dans un fichier et en
   -- cree l'arbre syntaxique abstrait
   ---------------------------------------------------------------------

   procedure analyser( nom_fichier : in String ; motif : out Ast;
                                    suite_chaine : out Chaine ) is
   begin
      demarrer(nom_fichier);
      rec_Description(motif,suite_chaine);
   end;

   ---------------------------------------------------------------------
   -- realisation des sous-programmes correspondant aux regles de la
   -- grammaire des descriptions de motif
   ---------------------------------------------------------------------

   ---------------------------------------------------------------------
   -- procedure rec_description
   --
   -- Descrition ::= SeqAff POUR_CENT FIN_LIGNE EXP FIN_LIGNE FIN_SEQUENCE
   ---------------------------------------------------------------------
   PROCEDURE rec_Description (Motif : OUT Ast ; suite_chaine : out Chaine ) IS
   OpdeG,MotifD: Ast;
   BEGIN
      creer_table_symbole(suite_chaine);
      Rec_SeqAff(OpdeG,suite_chaine);
      Rec_lex(POUR_CENT);
      Rec_lex(FIN_LIGNE);
      Rec_Exp(NOIR,MotifD,suite_chaine);
      creer_description(OpdeG,MotifD,Motif);
	   Rec_lex(FIN_LIGNE);
      Rec_Lex(FIN_SEQUENCE);
   END;
   ---------------------------------------------------------------------
   -- procedure rec_SeqAff
   --
   -- SEQAFF0 ::= AFF SEQAFF1
   -- SEQAFF  ::= epsilon
   ---------------------------------------------------------------------
   PROCEDURE Rec_SeqAff (Motif : OUT Ast ; suite_chaine : in out Chaine ) IS
   opdeG,opdeD: Ast;
   BEGIN
      CASE Lexeme_Courant.Nature IS
         when IDENTIFICATEUR => Rec_Aff(opdeG,suite_chaine);
		                          Rec_SeqAff(opdeD,suite_chaine);
                                Creer_SeqAffectation(OpdeG,OpdeD,Motif);
         WHEN POUR_CENT      => null;
         when others         => traiter_erreur;
      end case;
   END;
   ---------------------------------------------------------------------
   -- procedure rec_Aff
   --
   -- Aff      ::=   IDENTIFICATEUR AFFECTATION EXP FINLIGNE
   -- Aff      ::=   IDENTIFICATEUR AFFCOULEUR 
   --                (NOIR|BLANC|ROUGE|BLEU|VERT|JAUNE) AFFECTATION EXP
   --                FINLIGNE
   ---------------------------------------------------------------------      
   PROCEDURE Rec_Aff (Motif : OUT Ast ; suite_chaine : in out Chaine ) IS
    motifD,motifG : Ast;
   ident : Pointeur_chaine;
   BEGIN
      ident:=lexeme_courant.chaine;
      Rec_Lex(IDENTIFICATEUR);
      IF Lexeme_Courant.Nature = AFFCOULEUR THEN
         Rec_Lex(AFFCOULEUR);
         if Lexeme_courant.nature = NOIR then
            creer_identificateur(NOIR,ident,motifG);
	         Rec_Lex(NOIR);
            Rec_Lex(AFFECTATION);
            Rec_Exp(NOIR,MotifD,suite_chaine);
            creer_Affectation(motifG,motifD,motif);
            ajouter_dans_table_symbole(NOIR,ident,motifD,suite_chaine);   
         elsif Lexeme_courant.nature = BLANC then
            creer_Identificateur(BLANC,ident,motifG);
            Rec_Lex(BLANC);
            Rec_Lex(AFFECTATION);
            Rec_Exp(BLANC,MotifD,suite_chaine);
            creer_Affectation(motifG,motifD,motif);
            ajouter_dans_table_symbole(BLANC,ident,motifD,suite_chaine);
         elsif Lexeme_courant.nature = ROUGE then
            creer_identificateur(ROUGE,ident,motifG);        
            Rec_lex(ROUGE);
            Rec_Lex(AFFECTATION);
            Rec_Exp(ROUGE,MotifD,suite_chaine);
            creer_Affectation(motifG,motifD,motif);
            ajouter_dans_table_symbole(ROUGE,ident,motifD,suite_chaine);
         elsif Lexeme_courant.nature = BLEU then
            creer_identificateur(BLEU,ident,motifG); 
            Rec_lex(BLEU);
            Rec_Lex(AFFECTATION);
            Rec_Exp(BLEU,MotifD,suite_chaine);
            creer_Affectation(motifG,motifD,motif);
            ajouter_dans_table_symbole(BLEU,ident,motifD,suite_chaine);
         elsif Lexeme_courant.nature = VERT then
	         creer_identificateur(VERT,ident,motifG); 
            Rec_lex(VERT);
            Rec_Lex(AFFECTATION);
            Rec_Exp(VERT,MotifD,suite_chaine);
            creer_Affectation(motifG,motifD,motif);
            ajouter_dans_table_symbole(VERT,ident,motifD,suite_chaine);
         elsif Lexeme_courant.nature = JAUNE then
		      creer_identificateur(JAUNE,ident,motifG); 
            Rec_lex(JAUNE);
            Rec_Lex(AFFECTATION);
            Rec_Exp(JAUNE,MotifD,suite_chaine);
            creer_Affectation(motifG,motifD,motif);
            ajouter_dans_table_symbole(JAUNE,ident,motifD,suite_chaine);
         end if;
      else    
         creer_identificateur(NOIR,ident,motifG);   
         Rec_Lex(AFFECTATION);
         Rec_Exp(NOIR,MotifD,suite_chaine);
         creer_Affectation(motifG,motifD,motif);
         ajouter_dans_table_symbole(NOIR,ident,motifD,suite_chaine);
      end if;
      Rec_Lex(FIN_LIGNE);
   END;

   ---------------------------------------------------------------------
   -- procedure rec_Exp
   --
   -- E        ::=   Motif (SEQJUXT|SEQEMP)
   ---------------------------------------------------------------------
   PROCEDURE Rec_Exp (motifCouleur : Couleur ; Motif : OUT Ast ; 
                                           suite_chaine : in Chaine ) is
   motifGauche : Ast;
   begin
      rec_Motif (motifCouleur,motifGauche,suite_chaine);
      if lexeme_courant.nature = EMPILEMENT then
         rec_SeqEmp(motifCouleur,motifGauche,motif,suite_chaine);
      else
         rec_SeqJuxt(motifCouleur,motifGauche,motif,suite_chaine);
      end if;
   end;
   ---------------------------------------------------------------------
   -- procedure rec_seqEmp
   --
   -- SEQEMP0  ::=   emp MOTIF SEQEMP1
   -- SEQEMP0  ::=   emp NBJR MOTIF SEQEMP1
   -- SEQEMP   ::=   epsilon
   ---------------------------------------------------------------------
   procedure Rec_SeqEmp (motifCouleur : Couleur; MotifGauche : in Ast;
                          motif : out ast; suite_chaine : in Chaine ) is
   use convert;
   motifDroit,emp,empn : Ast;
   nb : Integer;
   begin
   rec_lex(EMPILEMENT);
   if lexeme_courant.nature = NBJR then
      Convertint(lexeme_courant.chaine.all,nb);
      rec_lex(NBJR);
      rec_motif(motifCouleur,motifDroit,suite_chaine);
      creer_njuxtouemp(EMPILEMENT,nb,motifDroit,empn);
      creer_operation(EMPILEMENT,motifGauche,empn,emp);
      if lexeme_courant.nature /= EMPILEMENT then
         rec_Seqjuxt(motifCouleur,emp,motif,suite_chaine);
      else
         rec_SeqEmp(motifCouleur,emp,motif,suite_chaine);   
      end if;
   else
      rec_motif(motifCouleur,motifDroit,suite_chaine);
      creer_operation(EMPILEMENT,motifGauche,motifDroit,emp);
      if lexeme_courant.nature /= EMPILEMENT then
         rec_Seqjuxt(motifCouleur,emp,motif,suite_chaine);
      else
         rec_SeqEmp(motifCouleur,emp,motif,suite_chaine);
      end if;
   end if;
   end;
   ---------------------------------------------------------------------
   -- procedure rec_seqjuxt
   --
   -- SEQJUXT0  ::=   juxt MOTIF SEQJUXT1
   -- SEQJUXT   ::=   epsilon
   ---------------------------------------------------------------------
   
   PROCEDURE Rec_Seqjuxt (motifCouleur: Couleur; MotifGauche : IN Ast; 
                       motif : out ast ; suite_chaine : in Chaine )is
   use convert;
   motifDroit,juxt,juxtn : Ast;
   nb : Integer;
   begin
      case lexeme_courant.nature is
         when JUXTAPOSITION =>
            rec_lex(JUXTAPOSITION);
            if lexeme_courant.nature = NBJR then
                 Convertint(lexeme_courant.chaine.all,nb);
                 rec_lex(NBJR);
                 rec_motif(motifCouleur,motifDroit,suite_chaine);     
                 creer_njuxtouemp(JUXTAPOSITION,nb,motifDroit,juxtn);
                 creer_operation(JUXTAPOSITION,motifGauche,juxtn,juxt);
                 rec_seqjuxt(motifCouleur,juxt,motif,suite_chaine);
            else
                 rec_motif(motifCouleur,motifDroit,suite_chaine);
                 creer_operation(JUXTAPOSITION,motifGauche,motifDroit,juxt);
                 rec_seqjuxt(motifCouleur,juxt,motif,suite_chaine);
            end if;
            
         when FIN_LIGNE | PARENTH_FERMANTE =>
            motif:=motifGauche;

         when others =>
            traiter_erreur;
      end case;
   end;

   ---------------------------------------------------------------------
   -- procedure rec_motif(motif : out Ast)
   --
   -- Motif        ::=   carre
   -- Motif        ::=   triangle
   -- Motif        ::=   rond
   -- Motif        ::=   IDENTIFICATEUR
   -- Motif        ::=   ROT MOTIF
   -- Motif        ::=   PARO EXP PARF
   ---------------------------------------------------------------------
   
   PROCEDURE Rec_Motif (motifCouleur: Couleur; Motif : OUT Ast ; 
                                          suite_chaine : in Chaine ) is
   use convert,Ada.Integer_Text_IO;
   
   motifDroit,motifapresnb : Ast;
   ident : Pointeur_chaine;
   nb,nbm : Integer;
   begin
      case lexeme_courant.nature is
         when CARRE | TRIANGLE | ROND =>
            rec_primitif(motifCouleur,motif);
         
         when ROTATION =>
            rec_lex(ROTATION);
            if lexeme_courant.nature = NBJR then
               Convertint(lexeme_courant.chaine.all,nb);
               nbm:=nb mod 4;
               rec_lex(NBJR);
               rec_Motif(motifcouleur,motifapresnb,suite_chaine);  
               creer_nbrotation(ROTATION,nbm,motifapresnb,motif);
            else
               rec_Motif(motifcouleur,motifDroit,suite_chaine);
               creer_operation(ROTATION,motifDroit,motif);
            end if;
         
         when PARENTH_OUVRANTE =>
            rec_lex(PARENTH_OUVRANTE);
            rec_Exp(motifCouleur,motif,suite_chaine);
            rec_lex(PARENTH_FERMANTE);
         
         when IDENTIFICATEUR =>
              ident:=lexeme_courant.chaine;
	      if Est_dans_table(ident,suite_chaine) then
              creer_identificateur_avec_Exp(ident,suite_chaine,motif);
              rec_lex(IDENTIFICATEUR);
         else
		        traiter_erreur;
	      end if;
            
    	   when others =>
            traiter_erreur;
      end case;
   end;

   ---------------------------------------------------------------------
   -- procedure rec_primitif
   --
   -- reconnait un lexeme de type motif primitif
   ---------------------------------------------------------------------
   
   procedure rec_primitif (motifcouleur : Couleur; motifPrimitif : out Ast) is
   use Type_Patchwork;
   begin
      case lexeme_courant.nature is
         when CARRE    => creer_valeur(motifcouleur,CARRE,motifPrimitif);
                          avancer;
         when TRIANGLE => creer_valeur(motifcouleur,TRIANGLE,motifPrimitif);
                          avancer;
         when ROND     => creer_valeur(motifcouleur,ROND,motifPrimitif);
                          avancer;
         when others   => traiter_erreur;
      end case;
   end;

   ---------------------------------------------------------------------
   -- procedure rec_lex(lexeme_attendu : Nature_Lexeme)
   --
   -- reconnait un lexeme de type autre que motif primtif
   ---------------------------------------------------------------------

   procedure rec_lex(lexeme_attendu : Nature_Lexeme) is
   begin
      if lexeme_courant.nature = lexeme_attendu then
         avancer;
      else
         traiter_erreur;
      end if;
   end;

   ---------------------------------------------------------------------
   -- procedure traiter_erreur
   --
   -- affiche un message (ou genere une exception) correspondant au type
   -- de l'erreur detectee (lexicale ou syntaxique)
   ---------------------------------------------------------------------
   procedure traiter_erreur is
   begin
      if lexeme_courant.nature = ERREUR then
         raise ERREUR_LEXICALE;
      else
         raise ERREUR_SYNTAXIQUE;
      end if;
   end;

   --pragma Warnings (On, "possible infinite recursion");
   --pragma Warnings (On, "Storage_Error may be raised at run time");

end Analyseur_Syntaxique;
