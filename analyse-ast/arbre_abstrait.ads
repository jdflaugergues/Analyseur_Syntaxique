------------------------------------------------------------------------
-- paquetage Arbre_Abstrait
--
-- structure d'arbre syntaxique abstrait pour descriptions de motif
-- (patchwork)
--
-- Jonathan de Flaugergues, Galel Koraa
------------------------------------------------------------------------
with Type_Patchwork, Machine_lexemes, graphsimple;

package Arbre_Abstrait is

   use Type_Patchwork, Machine_lexemes, graphsimple;

   type TypeAst is (OPERATION, VALEUR,IDENTIFICATION,AFFECTATION,
                                      DESCRIPTION,SEQUENCE_AFFECTATION);
   
   type TypeOperateur is (JUXTAPOSITION, ROTATION,EMPILEMENT);
  
   type NoeudAst;
   type Ast is access NoeudAst;
   type NoeudAst is record
      ident          : Pointeur_chaine;
      nature         : TypeAst;
      operateur      : TypeOperateur;
      gauche, droite : Ast;
      valeur         : NaturePrimitif;
      mcouleur       : Couleur;
      nbrj           : Integer;
   end record;
        
   type OrdreAst is (PREFIXE, INFIXE, POSTFIXE);

end Arbre_Abstrait;
