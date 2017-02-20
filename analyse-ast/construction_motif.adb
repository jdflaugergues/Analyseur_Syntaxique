------------------------------------------------------------------------
-- paquetage Construction_Motif
--
-- Construction de motifs
--
-- P. Habraken : 25 octobre 2006
------------------------------------------------------------------------
with Ada.Text_IO,graphsimple; 


package body Construction_Motif is

   use Ada.Text_IO,graphsimple;
   ---------------------------------------------------------------------
   -- procedure creerPrimitif(nature : in NaturePrimitif; 
   --          motifcouleur : in Couleur; motifCree : out Patchwork)
   -- Initialisation d'un motif primitif
   ---------------------------------------------------------------------  
   procedure creerPrimitif( nature : in NaturePrimitif ;
       motifcouleur : in Couleur; motifCree : out Patchwork) is
   begin
   motifcree.largeur:= 1;
   motifcree.hauteur:=1;
   motifcree.carres(1,1):= (nature,EST,motifcouleur);
   end;

   ---------------------------------------------------------------------
   -- function rotation(orientation: OrientationCarre) return 
   --                                                   OrientationCarre
   -- change l'orientation du motif
   ---------------------------------------------------------------------
   function rotation(orientation: OrientationCarre) return 
                                                     OrientationCarre is
   begin 
   case orientation is
            when EST => return SUD;
            when SUD => return OUEST;
            when OUEST => return NORD;
            when NORD => return EST;
            end case;
   end;
   ----------------------------------------------------------------------
   -- procedure creerRotation(motif : in Patchwork ;
   --                                          motifCree : out Patchwork)
   -- Construit la rotation d'un motif
   ----------------------------------------------------------------------
   procedure creerRotation( motif : in Patchwork ;
                                            motifCree : out Patchwork) is
   begin
     if motif.hauteur<= MAX_CARRES_PAR_COLONNE and  
                              motif.largeur<= MAX_CARRES_PAR_LIGNE then
         for i in 1 .. motif.hauteur loop
              for j in 1 .. motif.largeur loop
         motifcree.carres(motif.largeur-j+1,i):= motif.carres(i,j);
         motifcree.carres(motif.largeur-j+1,i).orientation:=rotation(motif.carres(i,j).orientation);
              end loop;
         end loop;
         motifcree.hauteur:= motif.largeur;
         motifcree.largeur:= motif.hauteur;
     else 
         RAISE  ERREUR_TAILLE_ROTATION ;
     end if;
   end;
   
   ----------------------------------------------------------------------
   -- procedure creerJuxtaposition(motifG : in Patchwork ;
   --                 motifD : in Patchwork ; motifCree : out Patchwork)
   --
   -- Construit la Juxtaposition de 2 motifs 
   ----------------------------------------------------------------------
   procedure creerJuxtaposition(motifGauche : in Patchwork ;
                  motifDroit : in Patchwork ;motifCree : out Patchwork) is
   begin
     if motifGauche.hauteur=motifDroit.hauteur and motifGauche.largeur+motifDroit.largeur <= MAX_CARRES_PAR_LIGNE then
      
      motifCree.largeur:= MotifGauche.largeur + MotifDroit.largeur;
      motifCree.hauteur:= MotifGauche.hauteur;

      for i in 1..motifGauche.hauteur loop
         for j in 1..motifGauche.largeur loop
            motifCree.carres(i,j):=motifGauche.carres(i,j);
         end loop;
      end loop;
      
      for i in 1..motifDroit.hauteur loop
         for j in 1..motifDroit.largeur loop
     motifCree.carres(i,MotifGauche.largeur+j):=motifDroit.carres(i,j);
         end loop;
      end loop;

     else if motifGauche.hauteur/=motifDroit.hauteur then
             raise ERREUR_HAUTEUR_JUXTAPOSITION; 
          else 
             raise ERREUR_TAILLE_JUXTAPOSITION;
          end if;
     end if;
   end;
   ----------------------------------------------------------------------
   -- procedure creerempilement(motifG : in Patchwork ;
   --                 motifD : in Patchwork ; motifCree : out Patchwork)
   --
   -- Construit l'empilement de 2 motifs 
   ----------------------------------------------------------------------
   procedure creerempilement(motifGauche : in Patchwork ;
                  motifDroit : in Patchwork ;motifCree : out Patchwork) is
   begin
     if motifGauche.largeur=motifDroit.largeur and motifGauche.hauteur+motifDroit.hauteur <= MAX_CARRES_PAR_COLONNE then
      
      motifCree.largeur:= MotifGauche.largeur;
      motifCree.hauteur:= MotifGauche.hauteur + MotifDroit.hauteur;

      for i in 1..motifGauche.hauteur loop
         for j in 1..motifGauche.largeur loop
            motifCree.carres(i,j):=motifGauche.carres(i,j);
         end loop;
      end loop;
      
      for i in 1..motifDroit.hauteur loop
         for j in 1..motifDroit.largeur loop
     motifCree.carres(i+MotifGauche.hauteur,j):=motifDroit.carres(i,j);
         end loop;
      end loop;

     else if motifGauche.hauteur/=motifDroit.hauteur then
             raise ERREUR_HAUTEUR_JUXTAPOSITION; 
          else 
             raise ERREUR_TAILLE_JUXTAPOSITION;
          end if;
     end if;   
   end creerempilement;

end Construction_Motif;
