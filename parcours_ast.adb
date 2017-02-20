------------------------------------------------------------------------
-- paquetage Parcours_Ast
--
-- affichage (sous forme prefixee) et evaluation d'une description de
-- motif a partir de son arbre syntaxique abstrait
--
-- De Flaugergues Jonathan, Koraa Galel
------------------------------------------------------------------------
with Ada.Text_IO;
with Arbre_Abstrait;
with Type_Patchwork, Construction_Motif, machine_lexemes;

use Arbre_Abstrait;
use Type_Patchwork,machine_lexemes;

package body Parcours_Ast is

   ------------------------------------------------------------------------  
   procedure AfficherOperateur(A:typeOperateur) is
      use Ada.Text_IO;
      begin
      case A is
         when EMPILEMENT     => put (" EMPILEMENT");
         when JUXTAPOSITION  => put (" JUXTAPOSITION");
         when ROTATION       => put (" ROTATION");
      end case; 
   end AfficherOperateur;
   ------------------------------------------------------------------------
   procedure AfficherValeur (A:NaturePrimitif) is
      use Ada.Text_IO;
      begin
      case A is
         when CARRE => put (" carre");
         when TRIANGLE => put (" triangle");
         when ROND => put (" rond");
      end case;
   end;
   ------------------------------------------------------------------------     
   PROCEDURE AfficherIdentificateur (ident : Pointeur_Chaine) IS
      USE Ada.Text_IO;
   BEGIN
      put(" ");
      Put(Ident.All);
   end; 
   ---------------------------------------------------------------------
   -- procedure afficher(expr : Ast ; notation : OrdreAst := PREFIXE)
   --
   -- affiche l'arbre syntaxique abstrait d'une description de motif
   -- (sous forme prefixee par defaut)
   ---------------------------------------------------------------------
   procedure afficher(expr : Ast ; notation : OrdreAst := PREFIXE) is
      use Ada.Text_IO;
   begin
      CASE Expr.All.Nature IS
         when VALEUR => AfficherValeur(expr.all.valeur);
         when IDENTIFICATION => AfficherIdentificateur(expr.all.ident);
         WHEN SEQUENCE_AFFECTATION => 
                   Afficher(Expr.All.Gauche);
                   new_line;
                   if Expr.all.droite/=null then
                     Afficher(Expr.all.droite);
                   end if;
         when DESCRIPTION =>
                   if Expr.all.Gauche /= Null then
                     Afficher(Expr.All.Gauche);
                   end if;
                   put_line(" %");
                   Afficher(Expr.all.droite);
         WHEN AFFECTATION => Afficher(Expr.All.Gauche);
                             Put(" :=");
                             Afficher(Expr.all.droite);
         WHEN OPERATION => 
            case notation is
               WHEN PREFIXE => 
                  AfficherOperateur(expr.all.operateur);
                  put("(");
                  Afficher(expr.all.gauche);
                  if expr.all.operateur /= ROTATION then
                         put(", ");
                         Afficher(expr.all.droite);
                  end if;    
                  put(")");
               
               WHEN INFIXE =>
                  if expr.all.operateur = JUXTAPOSITION then
                  put("(");
                  Afficher(expr.all.gauche,INFIXE);
                  AfficherOperateur(expr.all.operateur);
                  Afficher(expr.all.droite,INFIXE);
                  put(")");
                  else
                       AfficherOperateur(expr.all.operateur);
                       Afficher(expr.all.gauche,INFIXE);
                       end if;
                        
               WHEN POSTFIXE =>
                  Afficher(expr.all.gauche,POSTFIXE);
                  if expr.all.operateur/=ROTATION then
                       Afficher(expr.all.droite,POSTFIXE);
                  end if;
                  AfficherOperateur(expr.all.operateur);
               end case;
      end case;
   end;

   ---------------------------------------------------------------------
   -- PROCEDURE Evaluer( Expr : Ast ; motif : out Patchwork)
   --
   -- evalue (construit) un motif d'apres son arbre syntaxique abstrait
   ---------------------------------------------------------------------
   PROCEDURE Evaluer(Expr : Ast ; motif : out Patchwork) is
   use Construction_Motif;
   motifG, motifD : Patchwork;
   begin
   case expr.all.nature is
      when VALEUR =>     
                creerPrimitif(expr.all.valeur,expr.all.mcouleur,motif);
      WHEN IDENTIFICATION => 
                evaluer(expr.all.gauche,motif);
      when OPERATION =>
         case expr.all.operateur is
             when EMPILEMENT =>
                 evaluer(expr.all.gauche,motifG);
                 evaluer(expr.all.droite,motifD);
                 creerempilement(motifG,motifD,motif);
             when JUXTAPOSITION => 
                 evaluer(expr.all.gauche,motifG);
                 evaluer(expr.all.droite,motifD);
                 creerjuxtaposition(motifG,motifD,motif);
             when ROTATION =>
                 evaluer(expr.all.gauche,motifG);
                 creerrotation(motifG,motif);
          end case;
      when others => null;
      end case;
   end;
end Parcours_Ast;
