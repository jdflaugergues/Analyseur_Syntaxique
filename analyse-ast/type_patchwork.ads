------------------------------------------------------------------------
-- paquetage Type_Patchwork
--
-- Description d'un motif
--
-- De Flaugergues Jonathan, Koraa Galel
------------------------------------------------------------------------
with graphsimple;
package Type_Patchwork is
   use graphsimple;

   TAILLE_CARRE : constant Integer := 50;
   MAX_CARRES_PAR_LIGNE : constant Integer := 10;
   MAX_CARRES_PAR_COLONNE : constant Integer := 10;

   subtype IndexLigne is Integer range 1 .. MAX_CARRES_PAR_LIGNE;
   subtype IndexColonne is Integer range 1 .. MAX_CARRES_PAR_COLONNE;

   type NaturePrimitif is (CARRE, TRIANGLE, ROND);
   type OrientationCarre is (EST, NORD, OUEST, SUD);

   type CarreElementaire is record
      nature      : NaturePrimitif;
      orientation : OrientationCarre;
      mcouleur    : Couleur;
   end record;

   type MatriceCarresElementaires is
      array (IndexColonne, IndexLigne) of CarreElementaire;

   type Patchwork is record
      carres  : MatriceCarresElementaires;
      largeur : IndexLigne;
      hauteur : IndexColonne;
   end record;

end Type_Patchwork;
