------------------------------------------------------------------------
-- paquetage Construction_Motif
--
-- Construction de motifs
--
-- Jonathan de Flaugergues, Galel Koraa
------------------------------------------------------------------------
with Type_Patchwork,graphsimple;

package Construction_Motif is

   use Type_Patchwork,graphsimple;
   
   ---------------------------------------------------------------------
   -- procedure creerPrimitif(nature : in NaturePrimitif; 
   --              motifcouleur : in Couleur; motifCree : out Patchwork)
   --
   -- Initialisation d'un motif primitif
   ---------------------------------------------------------------------  
   procedure creerPrimitif( nature : in NaturePrimitif ;
                   motifcouleur : in Couleur; motifCree : out Patchwork);

   ----------------------------------------------------------------------
   -- procedure creerRotation(motif : in Patchwork ;
   --                                          motifCree : out Patchwork)
   -- Construit la rotation d'un motif
   ----------------------------------------------------------------------
   procedure creerRotation( motif : in Patchwork ;
                                            motifCree : out Patchwork);
   ----------------------------------------------------------------------
   -- procedure creerJuxtaposition(motifG : in Patchwork ;
   --              motifDroit : in Patchwork ; motifCree : out Patchwork)
   --
   -- Construit la Juxtaposition de 2 motifs 
   ----------------------------------------------------------------------
   procedure creerJuxtaposition(motifGauche : in Patchwork ;
                  motifDroit : in Patchwork ; motifCree : out Patchwork);
   ----------------------------------------------------------------------
   -- procedure creerEmpilement(motifGauche : in Patchwork ;
   --              motifDroit : in Patchwork ; motifCree : out Patchwork)
   --
   -- Construit l'empilement de 2 motifs 
   ----------------------------------------------------------------------
   procedure creerEmpilement(motifGauche : in Patchwork ;
                  motifDroit : in Patchwork ; motifCree : out Patchwork);
   
   ERREUR_TAILLE_ROTATION : Exception;
   ERREUR_TAILLE_JUXTAPOSITION : Exception;
   ERREUR_HAUTEUR_JUXTAPOSITION : Exception;

end Construction_Motif;
