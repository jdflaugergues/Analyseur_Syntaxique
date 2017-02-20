------------------------------------------------------------------------
-- paquetage machine_lexemes
--
-- analyse lexicale d'une description de motif (patchwork)
--
-- P. Habraken : 23 octobre 2006
-- d'apres analex_motifs (A. Rasse)
------------------------------------------------------------------------
with machine_caracteres;
with Ada.Text_IO, Ada.Integer_Text_IO;

package body machine_lexemes is

   ---------------------------------------------------------------------

   lexeme_en_cours : Lexeme;

   function est_separateur(c : Character) return Boolean;
   function est_lettre(c : Character) return Boolean;
   function est_chiffre(c : Character) return Boolean;
   function est_symbole(c : Character) return Boolean;
   function est_fin_ligne(c : Character) return Boolean;
   function est_carre(chaine : String) return Boolean;
   FUNCTION Est_Triangle(Chaine : String) RETURN Boolean;
   function est_rond(chaine : String) return Boolean;
   function est_noir(chaine : String) return Boolean;
   function est_blanc(chaine : String) return Boolean;
   function est_rouge(chaine : String) return Boolean;
   function est_bleu(chaine : String) return Boolean;
   FUNCTION Est_vert(Chaine : String) RETURN Boolean;
   function est_jaune(chaine : String) return Boolean;
   procedure reconnaitre_lexeme;

   ---------------------------------------------------------------------

   procedure demarrer is
   begin
      demarrer("");
   end demarrer;

   ---------------------------------------------------------------------

   procedure demarrer(nom_fichier : String) is
   begin
      machine_caracteres.demarrer(nom_fichier);
      avancer;
   end demarrer;

   ---------------------------------------------------------------------

   procedure avancer is
   begin
      reconnaitre_lexeme;
   end avancer;

   ---------------------------------------------------------------------

   function lexeme_courant return Lexeme is
   begin
      return lexeme_en_cours;
   end lexeme_courant;

   ---------------------------------------------------------------------

   function fin_de_sequence return Boolean is
   begin
      return lexeme_en_cours.nature = FIN_SEQUENCE;
   end fin_de_sequence;

   ---------------------------------------------------------------------

   procedure arreter is
   begin
      machine_caracteres.arreter;
   end arreter;

   ---------------------------------------------------------------------

   procedure reconnaitre_lexeme is
      type Etat_Automate is (
         INIT, MOT,NOMBRE, AFFECTATION, ERREUR, FIN
      );
      etat : Etat_Automate := INIT;
      function pos(c : Character) return Natural is
      begin
         return Character'pos(c);
      end;
      use machine_caracteres;
   begin
      loop
         case etat is

            when INIT =>
               if machine_caracteres.fin_de_sequence then
                  lexeme_en_cours.nature := FIN_SEQUENCE;
                  etat := FIN;
               else
                  if est_separateur(caractere_courant) then
                     etat := INIT;

                  elsif est_chiffre(caractere_courant) then
			            lexeme_en_cours.nature := NBJR;
			            lexeme_en_cours.ligne := numero_ligne;
	        	         lexeme_en_cours.colonne := numero_colonne;
			            lexeme_en_cours.chaine :=
				            new String'("" & caractere_courant);
			            etat := NOMBRE;
				  
		            elsif est_lettre(caractere_courant) then
                     lexeme_en_cours.nature := IDENTIFICATEUR;
                     lexeme_en_cours.ligne := numero_ligne;
                     lexeme_en_cours.colonne := numero_colonne;
                     lexeme_en_cours.chaine :=
                        new String'("" & caractere_courant);
                     etat := MOT;

                  elsif est_symbole(caractere_courant) then
                     lexeme_en_cours.ligne := numero_ligne;
                     lexeme_en_cours.colonne := numero_colonne;
                     lexeme_en_cours.chaine :=
                        new String'("" & caractere_courant);
                     case caractere_courant is
                        WHEN '@' =>
                           Lexeme_En_Cours.Nature := EMPILEMENT;
                           Etat := FIN;
                        
                        WHEN ',' =>
                           Lexeme_En_Cours.Nature := AFFCOULEUR;
                           Etat := FIN;
                           
                        when '#' =>
                           lexeme_en_cours.nature := JUXTAPOSITION;
                           etat := FIN;

                        when '*' =>
                           lexeme_en_cours.nature := ROTATION;
                           etat := FIN;

                        when '(' =>
                           lexeme_en_cours.nature := PARENTH_OUVRANTE;
                           etat := FIN;

                        when ')' =>
                           lexeme_en_cours.nature := PARENTH_FERMANTE;
                           etat := FIN;

                        when '%' =>
                           lexeme_en_cours.nature := POUR_CENT;
                           etat := FIN;
                     
                        when ':' =>
                           lexeme_en_cours.nature := AFFECTATION;
                           etat := AFFECTATION;
                     
                        when others =>
                           null;
                     end case;

                  elsif est_fin_ligne(caractere_courant) then
                     lexeme_en_cours.nature := FIN_LIGNE;
                     lexeme_en_cours.ligne := numero_ligne;
                     lexeme_en_cours.colonne := numero_colonne;
                     etat := FIN;

                  else
                     lexeme_en_cours.nature := ERREUR;
                     lexeme_en_cours.ligne := numero_ligne;
                     lexeme_en_cours.colonne := numero_colonne;
                     lexeme_en_cours.chaine :=
                        new String'("" & caractere_courant);
                     etat := ERREUR;
                  end if;
                  machine_caracteres.avancer;
               end if;

            when NOMBRE =>
               if machine_caracteres.fin_de_sequence then
                  lexeme_en_cours.nature := NBJR;
                  etat := FIN;
               
               elsif est_chiffre(caractere_courant) then
                  lexeme_en_cours.chaine :=
                     new String'(lexeme_en_cours.chaine.all
                                 & caractere_courant);
                  etat:=NOMBRE;
                  machine_caracteres.avancer;
               else
                  lexeme_en_cours.nature := NBJR;
                  etat := FIN;
               end if;
           
            when MOT =>
               if machine_caracteres.fin_de_sequence then
                  lexeme_en_cours.nature := IDENTIFICATEUR;
                  etat := FIN;

               elsif est_lettre(caractere_courant)
                  or est_chiffre(caractere_courant) then
                  lexeme_en_cours.chaine :=
                     new String'(lexeme_en_cours.chaine.all
                                 & caractere_courant);
                  etat := MOT;
                  machine_caracteres.avancer;
                  
               else
                  lexeme_en_cours.nature := IDENTIFICATEUR;
                  etat := FIN;
               end if;
               
               if etat = FIN then
                  if est_carre(lexeme_en_cours.chaine.all) then
                     lexeme_en_cours.nature := CARRE;
                  elsif est_triangle(lexeme_en_cours.chaine.all) then
                     lexeme_en_cours.nature := TRIANGLE;
                  elsif est_rond(lexeme_en_cours.chaine.all) then
                     lexeme_en_cours.nature := ROND;
                  elsif est_blanc(lexeme_en_cours.chaine.all) then
                     lexeme_en_cours.nature := BLANC;
                  elsif est_noir(lexeme_en_cours.chaine.all) then
                     lexeme_en_cours.nature := NOIR;
                  elsif est_rouge(lexeme_en_cours.chaine.all) then
                     lexeme_en_cours.nature := ROUGE;
                  elsif est_bleu(lexeme_en_cours.chaine.all) then
                     lexeme_en_cours.nature := BLEU;
                  elsif est_vert(lexeme_en_cours.chaine.all) then
                     lexeme_en_cours.nature := VERT;
                  elsif est_jaune(lexeme_en_cours.chaine.all) then
                     lexeme_en_cours.nature := JAUNE;
                  else
                     null;
                  end if;
               end if;
			
		when AFFECTATION =>
               if not machine_caracteres.fin_de_sequence
                  and then caractere_courant = '=' then
                  lexeme_en_cours.chaine :=
                     new String'(lexeme_en_cours.chaine.all
                                 & caractere_courant);
                  machine_caracteres.avancer;
                  
               else
                  lexeme_en_cours.nature := ERREUR;
                  lexeme_en_cours.chaine :=
                     new String'(lexeme_en_cours.chaine.all
                                 & caractere_courant);
               end if;
               etat := FIN;

            when ERREUR =>
               if machine_caracteres.fin_de_sequence
                  or else (est_separateur(caractere_courant)
                           or est_lettre(caractere_courant)
                           or est_symbole(caractere_courant)
                           or est_fin_ligne(caractere_courant)) then
                  etat := FIN;

               else
                  lexeme_en_cours.chaine :=
                     new String'(lexeme_en_cours.chaine.all
                                 & caractere_courant);
                  etat := ERREUR;
                  machine_caracteres.avancer;
               end if;

            when FIN =>
               null;

         end case;
         exit when etat = FIN;
      end loop;
   end;

   ---------------------------------------------------------------------

   function est_separateur(c : Character) return Boolean is
   begin
      return c = ' ' or c = Ascii.HT;
   end;

   ---------------------------------------------------------------------

   function est_lettre(c : Character) return Boolean is
   begin
      return c in 'a' .. 'z' or c in 'A' .. 'Z' or c = '_';
   end;

   ---------------------------------------------------------------------

   function est_chiffre(c : Character) return Boolean is
   begin
      return c in '0' .. '9';
   end;

   ---------------------------------------------------------------------

   function est_symbole(c : Character) return Boolean is
   begin
      case c is
         when '#' | '*' | '(' | ')' | ':' | '%' | ',' | '@' =>
            return TRUE;

         when others =>
            return FALSE;
      end case;
   end;

   ---------------------------------------------------------------------

   function est_fin_ligne(c : Character) return Boolean is
   begin
      return c = Ascii.LF or c = Ascii.CR;
   end;

   ---------------------------------------------------------------------

   function est_carre(chaine : String) return Boolean is
      carre : constant String := "carre";
   begin
      return chaine'length = carre'length and then chaine = carre;
   end;

   ---------------------------------------------------------------------

   function est_triangle(chaine : String) return Boolean is
      triangle : constant String := "triangle";
   begin
      return chaine'length = triangle'length and then chaine = triangle;
   end;

   ---------------------------------------------------------------------

   function est_rond(chaine : String) return Boolean is
      triangle : constant String := "rond";
   begin
      return chaine'length = triangle'length and then chaine = triangle;
   end;

   ---------------------------------------------------------------------

   function est_noir(chaine : String) return Boolean is
      noir : constant String := "noir";
   begin
      return chaine'length = noir'length and then chaine = noir;
   end;
   ---------------------------------------------------------------------

   function est_blanc(chaine : String) return Boolean is
      blanc : constant String := "blanc";
   begin
      return chaine'length = blanc'length and then chaine = blanc;
   end;
   ---------------------------------------------------------------------

   function est_rouge(chaine : String) return Boolean is
      rouge : constant String := "rouge";
   begin
      return chaine'length = rouge'length and then chaine = rouge;
   end;
   ---------------------------------------------------------------------

   function est_bleu(chaine : String) return Boolean is
      bleu : constant String := "bleu";
   begin
      return chaine'length = bleu'length and then chaine = bleu;
   end;
   ---------------------------------------------------------------------

   function est_vert(chaine : String) return Boolean is
      vert : constant String := "vert";
   begin
      return chaine'length = vert'length and then chaine = vert;
   end;
   ---------------------------------------------------------------------

   function est_jaune(chaine : String) return Boolean is
      jaune : constant String := "jaune";
   begin
      return chaine'length = jaune'length and then chaine = jaune;
   end;

   ---------------------------------------------------------------------

   procedure afficher(l : Lexeme) is
   use Ada.Text_IO, Ada.Integer_Text_IO;
      TAB_NATURE : constant Count := col;
      TAB_LIGNE_COLONNE : constant Count := TAB_NATURE + 17;
      TAB_CHAINE : constant Count := TAB_LIGNE_COLONNE + 10;
      TAB_DESCRIPTION : constant Count := TAB_CHAINE + 10;
   begin
      put(Nature_Lexeme'image(l.nature));
      case l.nature is
         when FIN_SEQUENCE =>
            null;
         when others =>
            if col < TAB_LIGNE_COLONNE then
               set_col(TAB_LIGNE_COLONNE);
            else
               set_col(col + 1);
            end if;
            put(l.ligne, 1);
            put(':');
            put(l.colonne, 1);
            case l.nature is
               when FIN_LIGNE =>
                  null;
               when others =>
                  if col < TAB_CHAINE then
                     set_col(TAB_CHAINE);
                  else
                     set_col(col + 1);
                  end if;
                  put(l.chaine.all);
                  if col < TAB_DESCRIPTION then
                     set_col(TAB_DESCRIPTION);
                  else
                     set_col(col + 1);
                  end if;
            end case;
      end case;
   end afficher;

   ---------------------------------------------------------------------

end machine_lexemes;
