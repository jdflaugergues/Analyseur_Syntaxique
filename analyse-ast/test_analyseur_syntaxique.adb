------------------------------------------------------------------------
-- procedure Test_Analyseur_Syntaxique
--
-- analyse syntaxique d'une description de motif
--
-- De Flaugergues Jonathan, Koraa Galel
------------------------------------------------------------------------
with Ada.Text_IO, Ada.Command_Line,Table_des_symboles;
with Analyseur_Syntaxique, Arbre_Abstrait, Parcours_Ast;
with Type_Patchwork, Affichage_Motif, Graphsimple;

use Ada.Text_IO, Ada.Command_Line,Table_des_symboles;
use Analyseur_Syntaxique, Arbre_Abstrait, Parcours_Ast;
use Type_Patchwork, Affichage_Motif, Graphsimple;

------------------------------------------------------------------------
-- procedure Test_Analyseur_Syntaxique
--
-- usage   : analyse < nom fichier >
-- ou bien : analyse
--           < description de motif > Ctrl-D
------------------------------------------------------------------------
procedure Test_Analyseur_Syntaxique is
   expression : Ast;
   Idsuite : Chaine;
   motif : Patchwork;   
   begin
  
   ---------------------------------------------------------------------
   -- analyser une description de motif et en creer l'arbre
   -- syntaxique abstrait ainsi que sa table de symbole
   ---------------------------------------------------------------------
   if argument_count = 0 then
      put("*************************************************************");
      new_line;
      put("*      TAPER VOTRE FORMULE POUR OBTENIR VOTRE MOTIF         *");
      new_line;
      put("*************************************************************");
      new_line;new_line;     
      analyser(expression,IdSuite);
   else
      analyser(argument(1),expression,IdSuite); 
   end if;
   put("*************************************************************");
   new_line;
   Put("*   Analyse Syntaxique avec construction d'arbre réussie    *");
   new_line;
   
   ---------------------------------------------------------------------
   -- afficher sous forme prefixee la description de motif representee
   -- par son expression
   ---------------------------------------------------------------------
   put("*************************************************************");
   new_line;
   put("*                  EXPRESSION PREFIXEE :                    *");
   new_line;
   put("*************************************************************");
   new_line;
   afficher(expression); new_line;

   ---------------------------------------------------------------------
   -- afficher le motif sous forme graphique
   ---------------------------------------------------------------------
   evaluer(expression.all.droite,motif);
   Initialiser(motif.largeur*TAILLE_CARRE,motif.hauteur*TAILLE_CARRE);
   Afficher(motif);
   AttendreClic;
   
end Test_Analyseur_Syntaxique;
