------------------------------------------------------------------------
-- paquetage Analyseur_Syntaxique
--
-- analyse syntaxique d'une description de motif et creation de
-- l'arbre syntaxique abstrait correspondant
--
-- P. Habraken : 25 octobre 2006
------------------------------------------------------------------------
with Arbre_Abstrait,Table_des_symboles;

package Analyseur_Syntaxique is

   use Arbre_Abstrait,Table_des_symboles;

   ---------------------------------------------------------------------
   -- procedure analyser
   --
   -- analyse une description de motif saisie au clavier et en cree
   -- l'arbre syntaxique abstrait
   ---------------------------------------------------------------------
   
   procedure analyser ( motif: out Ast ; suite_chaine : out Chaine );

   ---------------------------------------------------------------------
   -- procedure analyser(nom_fichier : in String)
   --
   -- analyse une description de motif contenue dans un fichier et en
   -- cree l'arbre syntaxique abstrait
   ---------------------------------------------------------------------
  
   procedure analyser( nom_fichier : in String ; motif : out Ast ;
                                               suite_chaine : out Chaine );

   ---------------------------------------------------------------------
   -- exceptions generees en cas d'erreur detectees en cours d'analyse
   ---------------------------------------------------------------------
   ERREUR_SYNTAXIQUE, ERREUR_LEXICALE : Exception;

end Analyseur_Syntaxique;
