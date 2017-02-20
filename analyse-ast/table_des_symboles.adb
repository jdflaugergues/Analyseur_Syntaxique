------------------------------------------------------------------------
-- paquetage Table_des_Symboles
--
-- Structure de la table des Symboles
--
-- De Flaugergues & Koraa 
-- L2 Info Groupe 2
------------------------------------------------------------------------
with Arbre_Abstrait,Ada.Text_IO,graphsimple;

package body Table_des_symboles is

   use Arbre_Abstrait,Ada.Text_IO,graphsimple;
   
   ---------------------------------------------------------------------
   -- Procedure creer_table_symbole ( chaine_affectation : out Chaine)
   --
   -- Cree la table des symboles avec un élément fictif en tete
   ---------------------------------------------------------------------   
   Procedure creer_table_symbole ( chaine_affectation : out Chaine) is
   elem_fictif : Chaine;
   begin
      chaine_affectation:= new NoeudChaine;
      elem_fictif       := new NoeudChaine;
      chaine_affectation.all.Idsuivant:=null;
      elem_fictif.all.Idsuivant:=null;
   end;
   
   ---------------------------------------------------------------------
   -- PROCEDURE Ajouter_Dans_Table_Symbole (motifCouleur : Couleur;
   --                Ident : Pointeur_Chaine ; Sous_Arbre : Ast ; 
   --                         chaine_affectation : in out Chaine)               
   --
   -- Ajoute un identificateur (avec son arbre syntaxique, sa couleur)
   --                                         dans la table des symboles
   ---------------------------------------------------------------------
   PROCEDURE Ajouter_Dans_Table_Symbole (motifCouleur : Couleur;
                   Ident : Pointeur_Chaine ; Sous_Arbre : Ast ; 
                         chaine_affectation : in out Chaine) is
   AC,AD : Chaine;
   SuiteChaine : Chaine;
   begin
      AC:=chaine_affectation;   
      while AC/=null loop
        AD:=AC;
	     AC:=AD.all.IdSuivant;
      end loop;
      SuiteChaine:=new NoeudChaine;
      SuiteChaine.all.Identificateur:=ident;
      SuiteChaine.all.IdArbre:=sous_arbre;
      SuiteChaine.all.mCouleur:=motifCouleur;
      AD.all.Idsuivant:=SuiteChaine;
   end;
   
   ---------------------------------------------------------------------   
   -- function Est_Dans_Table(ident:Pointeur_chaine;
   --                                         chaine_affectation:Chaine) 
   --
   -- Vérifie si un identificateur est présent ou non dans la table des
   --                                                           symboles
   ---------------------------------------------------------------------   
   function Est_Dans_table(ident:Pointeur_chaine;
                            chaine_affectation:Chaine) return Boolean is
   
   L1, L2 : integer;
   T1,T2 : String(1..256);
   AC : Chaine;
   begin
      AC:=chaine_affectation.all.IdSuivant;
      L1 := ident.all'length;
      T1(1..L1) := ident.all(1..L1);
      while AC/=null loop
         L2 := AC.all.identificateur.all'length;
         T2(1..L2) := AC.all.identificateur.all(1..L2);
         if L1 = L2 and then T1(1..L1) = T2(1..L2) then
            return true;
         end if;  
         AC:=AC.all.IdSuivant;
		end loop;
      return false;
   end;

end Table_des_symboles;   
