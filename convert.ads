------------------------------------------------------------------------
-- paquetage Convert
--
-- Création d'un nombre a partir d'une chaine de caractere
--
-- Jonathan de Flaugergues, Galel Koraa
------------------------------------------------------------------------

package Convert is
   
   ---------------------------------------------------------------------
   -- FUNCTION Convertchiffre( Caractere : Character ) RETURN Integer
   --
   -- Converti un caractere correspondant a un chiffre en son chiffre
   ---------------------------------------------------------------------   
   FUNCTION Convertchiffre( Caractere : Character ) RETURN Integer;

   ---------------------------------------------------------------------
   -- PROCEDURE Convertint (Nombre1 : String; Nombre2 : OUT Integer)
   --
   -- Converti une chaine de caractere correspondant a un nombre
   --                       en son nombre respectif sous forme d'entier
   ---------------------------------------------------------------------   
   PROCEDURE Convertint (Nombre1 : String; Nombre2 : OUT Integer);

end convert;