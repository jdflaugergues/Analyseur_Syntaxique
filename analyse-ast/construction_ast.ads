------------------------------------------------------------------------
-- paquetage Construction_Ast
--
-- creation de l'arbre syntaxique abstrait d'une description de motif
-- arbitraire donnee sous la forme d'une constante de type texte
--
-- Jonathan de Flaugergues, Galel Koraa
------------------------------------------------------------------------
with Arbre_Abstrait,machine_lexemes,graphsimple;
with Type_Patchwork,Table_des_symboles;

package Construction_Ast is

   use Arbre_Abstrait,Table_des_symboles,graphsimple;
   use Type_Patchwork,machine_lexemes;
   ---------------------------------------------------------------------
   -- procedure creer_description ( opde_gauche, opde_droit : Ast;
   --                                              expr : out Ast)
   -- Cree un noeud de type DESCRIPTION
   ---------------------------------------------------------------------
   procedure creer_description( opde_gauche, opde_droit : Ast;
                                               Expr : OUT Ast) ;
   ---------------------------------------------------------------------
   -- procedure creer_affectation ( opde_gauche, opde_droit : Ast;
   --                                              expr : out Ast)
   --
   -- Cree un noeud de type DESCRIPTION
   ---------------------------------------------------------------------
   PROCEDURE Creer_SeqAffectation ( Opde_Gauche, Opde_Droit : Ast;
                                                   Expr : OUT Ast) ;
   ---------------------------------------------------------------------
   -- procedure creer_Affectation(motifG : Ast; motifD : Ast;
   --                                                Expr : OUT Ast)
   --
   -- Cree un noeud de type AFFECTATION
   ---------------------------------------------------------------------
   PROCEDURE Creer_Affectation (motifG : Ast ; motifD : Ast; 
                                                    Expr : OUT Ast);
   ---------------------------------------------------------------------
   -- procedure Creer_Identificateur (motifCouleur : Couleur;
   --                  identificateur : Pointeur_Chaine; expr : out Ast)
   --
   -- Cree un noeud de type IDENTIFICATEUR
   ---------------------------------------------------------------------
   PROCEDURE Creer_Identificateur (motifCouleur : Couleur;
                      identificateur : Pointeur_Chaine; expr : out Ast);
   ---------------------------------------------------------------------
   -- procedure creer_identificateur_avec_Exp(ident:Pointeur_Chaine;
   --		                   chaine_affectation : Chaine; expr : out Ast) 
   --
   -- Cree un noeud de type IDENTIFICATEUR avec son arbre syntaxique
   --                                                      correspondant
   ---------------------------------------------------------------------
   procedure creer_identificateur_avec_Exp(ident:Pointeur_Chaine;
   		             chaine_affectation : Chaine; expr : out Ast);  
   ---------------------------------------------------------------------
   -- procedure creer_operation(opr: TypeOperateur;
   --                     opde_gauche, opde_droit : Ast; expr : out Ast)
   --
   -- cree un noeud de type JUXTAPOSITION ou EMPILEMENT
   ---------------------------------------------------------------------
   procedure creer_operation(opr: TypeOperateur;
                         opde_gauche, opde_droit : Ast; expr : out Ast);

   ---------------------------------------------------------------------
   -- procedure creer_operation(opr: TypeOperateur; opde : Ast; 
   --                                                    expr : out Ast)
   --
   -- cree un noeud de type ROTATION
   ---------------------------------------------------------------------
   procedure creer_operation(opr : TypeOperateur; opde : Ast; 
                                                        expr : out Ast);

   ---------------------------------------------------------------------
   -- procedure creer_nbrotation(opr : TypeOperateur;nb : in out Integer
   --                                        opde : Ast; Expr : out Ast)
   --
   -- Cree un noeud de type ROTATION avec son nombre de rotation 
   --                                                      correspondant
   ---------------------------------------------------------------------
   procedure creer_nbrotation(opr : TypeOperateur; nb : in out Integer;
                                            opde : Ast; Expr : out Ast);
   
   ---------------------------------------------------------------------
   -- procedure creer_njuxtouemp( opr : TypeOperateur; nb in out
   --                                Integer;opdeG :Ast; Expr : Out Ast)  
   --
   -- Cree un noeud de type JUXTAPOSITION ou EMPILEMENT avec son 
   --                nombre de juxtaposition ou empilement correspondant
   ---------------------------------------------------------------------
   procedure creer_njuxtouemp( opr : TypeOperateur; nb : in out
                          Integer;opdeG:Ast; Expr : Out Ast);
   ---------------------------------------------------------------------
   -- procedure creer_valeur(motifcouleur: Couleur ; val : Integer; 
   --                                                   expr : out Ast)
   --
   -- cree une feuille (de type valeur)
   ---------------------------------------------------------------------
   procedure creer_valeur(motifcouleur: Couleur; val : NaturePrimitif; 
                                                        expr : out Ast);

end Construction_Ast;
