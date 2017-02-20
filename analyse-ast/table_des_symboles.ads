------------------------------------------------------------------------
-- paquetage Table_des_Symboles
--
-- Structure de la table des Symboles
--
-- De Flaugergues & Koraa 
-- L2 Info Groupe 2
------------------------------------------------------------------------
with Arbre_Abstrait,machine_lexemes;
with Type_Patchwork,graphsimple;

package table_des_symboles is
   
   use Arbre_Abstrait,graphsimple;
   use Type_Patchwork,machine_lexemes;
   
   TYPE NoeudChaine;
   TYPE Chaine IS ACCESS NoeudChaine;
   TYPE NoeudChaine IS RECORD
      Identificateur : Pointeur_Chaine;
	   IdArbre	      : Ast;
	   IdSuivant      : Chaine;
      mcouleur       : Couleur;
   end record; 
   
   ---------------------------------------------------------------------
   -- Procedure creer_table_symbole ( chaine_affectation : out Chaine)
   --
   -- Cree la table des symboles avec un élément fictif en tete
   ---------------------------------------------------------------------    
   Procedure creer_table_symbole ( chaine_affectation : out Chaine);
   
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
                                    chaine_affectation : in out Chaine);
   ---------------------------------------------------------------------   
   -- function Est_Dans_Table(ident:Pointeur_chaine;
   --                                         chaine_affectation:Chaine) 
   --
   -- Vérifie si un identificateur est présent ou non dans la table des
   --                                                           symboles
   ---------------------------------------------------------------------   
   function Est_Dans_Table(ident:Pointeur_chaine;
                              chaine_affectation:Chaine) return Boolean;

end Table_des_symboles;                          
