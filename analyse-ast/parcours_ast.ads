------------------------------------------------------------------------
-- paquetage Parcours_Ast
--
-- affichage (sous forme prefixee) et evaluation d'une description de
-- motif a partir de son arbre syntaxique abstrait
--
-- De Flaugergues Jonathan, Koraa Galel
------------------------------------------------------------------------
with Arbre_Abstrait;
with Type_Patchwork;

package Parcours_Ast is

   use Arbre_Abstrait;
   use Type_Patchwork;

   ---------------------------------------------------------------------
   -- procedure afficher(expr : Ast ; notation : OrdreAst := PREFIXE)
   --
   -- affiche l'arbre syntaxique abstrait d'une description de motif
   -- (sous forme prefixee par defaut)
   ---------------------------------------------------------------------
   procedure afficher(expr : Ast ; notation : OrdreAst := PREFIXE);
   
   ---------------------------------------------------------------------
   -- PROCEDURE Evaluer(Expr : Ast ; motif : out Patchwork)
   --
   -- evalue (construit) un motif d'apres son arbre syntaxique abstrait
   ---------------------------------------------------------------------
   PROCEDURE Evaluer(Expr : Ast ; motif : out Patchwork);

end Parcours_Ast;
