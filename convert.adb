------------------------------------------------------------------------
-- paquetage Convert
--
-- Création d'un nombre a partir d'une chaine de caractere
--
-- Jonathan de Flaugergues, Galel Koraa
------------------------------------------------------------------------
with Ada.Text_IO,Ada.Integer_Text_IO; 

PACKAGE BODY Convert IS

   use Ada.Text_IO,Ada.Integer_Text_IO;

   ---------------------------------------------------------------------
   -- FUNCTION Convertchiffre( Caractere : Character ) RETURN Integer
   --
   -- Converti un caractere correspondant a un chiffre en son chiffre
   --------------------------------------------------------------------- 
   FUNCTION Convertchiffre( Caractere : Character ) RETURN Integer IS
   BEGIN
      IF Caractere = '1' then RETURN 1;
      ELSIF Caractere = '2' then RETURN 2;
      ELSIF Caractere = '3' then RETURN 3;
      ELSIF Caractere = '4' then RETURN 4;
      ELSIF Caractere = '5' then RETURN 5;
      ELSIF Caractere = '6' then RETURN 6;
      ELSIF Caractere = '7' then RETURN 7;
      ELSIF Caractere = '8' then RETURN 8;
      ELSIF Caractere = '9' then RETURN 9;
      ELSIF Caractere = '0' then RETURN 0;
      END IF;
   end;    

   ---------------------------------------------------------------------
   -- PROCEDURE Convertint (Nombre1 : String; Nombre2 : OUT Integer)
   --
   -- Converti une chaine de caractere correspondant a un nombre
   --                       en son nombre respectif sous forme d'entier
   ---------------------------------------------------------------------   

   PROCEDURE Convertint (Nombre1 : String; Nombre2 : OUT Integer) is
   borne,multiplicateur : integer;
   cara: Character;
   BEGIN
      Nombre2:=0;
      Borne:=Nombre1'Length;
      multiplicateur:=1;
      FOR I IN REVERSE 1..Borne LOOP
         cara:=Nombre1(i);
         Nombre2:=Nombre2+Multiplicateur*Convertchiffre(cara);
         Multiplicateur:=Multiplicateur*10;           
      END LOOP;
   end;

end convert;
