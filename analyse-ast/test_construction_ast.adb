------------------------------------------------------------------------
-- procedure Test_Construction_Ast
--
-- creation de l'arbre syntaxique abstrait d'une description de motif
-- arbitraire donnee sous la forme d'une constante de type texte
--
-- P. Habraken : 25 octobre 2006
------------------------------------------------------------------------
with Ada.Text_IO;
with Arbre_Abstrait, Parcours_Ast;
with Type_Patchwork;
with Construction_Ast;

use Ada.Text_IO;
use Arbre_Abstrait, Parcours_Ast;
use Type_Patchwork;
use Construction_Ast;

-------------------------------------------------------
-- procedure Test_Construction_Ast
--
-- usage : test_construction_ast
-------------------------------------------------------
procedure Test_Construction_Ast is

   ---------------------------------------------------------------------
   -- function operation(opr: TypeOperateur;
   --                    opde_gauche, opde_droit : Ast) return Ast
   --
   -- operation binaire
   ---------------------------------------------------------------------
   function operation(opr: TypeOperateur;
                      opde_gauche, opde_droit : Ast) return Ast is
   begin
      -- A COMPLETER
      return null;
   end;

   ---------------------------------------------------------------------
   -- function operation(opr : TypeOperateur; opde : Ast) return Ast
   --
   -- operation unaire
   ---------------------------------------------------------------------
   function operation(opr : TypeOperateur; opde : Ast) return Ast is
   begin
      -- A COMPLETER
      return null;
   end;

   ---------------------------------------------------------------------
   -- function valeur(val : NaturePrimitif) return Ast
   --
   -- valeur d'un operande
   ---------------------------------------------------------------------
   function valeur(val : NaturePrimitif) return Ast is
   begin
      -- A COMPLETER
      return null;
   end;

   texte_expression : constant String :=
                            "**(triangle # carre) # carre # **triangle";

   expression : Ast;

begin
   put("texte de l'expression : "); put_line(texte_expression);

   ---------------------------------------------------------------------
   -- creer l'arbre syntaxique abstrait de la description de motif
   -- decrite par texte_expression
   ---------------------------------------------------------------------
   -- A COMPLETER

   ---------------------------------------------------------------------
   -- afficher sous forme prefixee l'arbre syntaxique abstrait de la
   -- description de motif decrite par texte_expression
   ---------------------------------------------------------------------
   put("expression : "); afficher(expression); new_line;

end Test_Construction_Ast;
