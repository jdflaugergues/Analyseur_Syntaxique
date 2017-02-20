------------------------------------------------------------------------
-- paquetage Affichage_Motif
--
-- Affichage d'un motif
--
-- De Flaugergues Jonathan, Koraa Galel
------------------------------------------------------------------------
with Graphsimple,Ada.Numerics,Ada.Numerics.Elementary_Functions,Ada.Text_IO;
use Graphsimple,Ada.Numerics,Ada.Numerics.Elementary_Functions,Ada.Text_IO;
package body Affichage_Motif is

   procedure afficher(motif : in Patchwork) is
   t : integer;
   begin
   t:=TAILLE_CARRE;
   Effacer;
   for i in 1..motif.hauteur loop
     for j in 1..motif.largeur loop
        ChangerCouleur(motif.carres(i,j).mcouleur);
        case motif.carres(i,j).nature is  
          when TRIANGLE =>  
            case motif.carres(i,j).orientation is
               when EST  =>  
TrianglePlein(t*(j-1),t*(i-1),t+t*(j-1),t*(i-1),t+t*(j-1),t+t*(i-1));  
               when SUD  => 
TrianglePlein (t*(j-1),t*(i-1),t*(j-1),t+t*(i-1),t+t*(j-1),t*(i-1));
               when OUEST => 
TrianglePlein (t*(j-1),t*(i-1),t*(j-1),t+t*(i-1),t+t*(j-1),t+t*(i-1));
               when NORD   => 
TrianglePlein (t+t*(j-1),t*(i-1),t+t*(j-1),t+t*(i-1),t*(j-1),t+t*(i-1)); 
            end case;
           
           when CARRE =>
             case motif.carres(i,j).orientation is
               when EST =>
    RectanglePlein(t*(j-1),t*(i-1),t+t*(j-1),t+t*(i-1));
    ChangerCouleur(blanc);
    RectanglePlein(t/2+t*(j-1),t*(i-1),t+t*(j-1),t/2+t*(i-1));
    ChangerCouleur(noir);
               when SUD =>
    RectanglePlein (t*(j-1),t*(i-1),t+t*(j-1),t+t*(i-1));
    ChangerCouleur(blanc);
    RectanglePlein(t*(j-1),t*(i-1),t/2+t*(j-1),t/2+t*(i-1));
    ChangerCouleur(noir);
               when OUEST => 
    RectanglePlein (t*(j-1),t*(i-1),t+t*(j-1),t+t*(i-1));
    ChangerCouleur(blanc);
    RectanglePlein(t*(j-1),t/2+t*(i-1),t/2+t*(j-1),t+t*(i-1));
    ChangerCouleur(noir);
               when NORD   => 
    RectanglePlein (t*(j-1),t*(i-1),t+t*(j-1),t+t*(i-1));
    ChangerCouleur(blanc);
    RectanglePlein(t/2+t*(j-1),t/2+t*(i-1),t+t*(j-1),t+t*(i-1));
    ChangerCouleur(noir);
               end case;
           when ROND =>  null;
             CASE Motif.Carres(I,J).Orientation IS
               WHEN EST =>
    FOR x IN 0..t LOOP
      Ligne (integer(float(t)-Sqrt(float(t*t)-float(x*x)))+t*(J-1),x+t*(I-1),t+t*(J-1),x+t*(I-1));                              
    end loop;     
               When SUD =>
    FOR X IN 0..t LOOP
      Ligne (t*(J-1),x+t*(I-1),integer(Sqrt(float(t*t)-float(x*x)))+(t*(J-1)),x+t*(I-1));                              
    end loop;           
               WHEN OUEST =>
    FOR X IN 0..t LOOP
      Ligne (t*(J-1),t-x+t*(I-1),integer(Sqrt(float(t*t)-float(x*x)))+t*(J-1),t-x+t*(I-1));
    end loop;           
               WHEN NORD =>
    FOR X IN 0..t LOOP
      Ligne (integer(float(t)-Sqrt(float(t*t)-float(x*x)))+t*(J-1),t-x+t*(I-1),t+t*(J-1),t-x+t*(I-1));                              
    end loop;                               
               end case;
           end case;
      end loop;
   end loop;
   
   end afficher;

end Affichage_Motif;
