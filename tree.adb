with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

with Ada.Integer_Text_Io;
use Ada.Integer_Text_Io;
package body Tree is
   --type Letter_Counter is array (97..122) of Integer;
   
   -- creer le premier niveau de l'arbre , le noeud racine
   function New_Tree return Tree is
      Root : Tree;
   begin
      Root := new Node;
      return Root ;   
   end;
   
   ----------------------------------------------------------------------
   -- retourne le nombre de lettre dans le mot
   function Nomber_Letter (Word : String) return Letter_counter is
      Nb_Array : Letter_Counter;   
   begin
      -- a = 97    z= 122
      Nb_Array := (others => 0);
      for I in Word'range loop
	 Nb_Array (Character'pos(Word(I))) := Nb_Array (Character'pos( Word(I))) + 1;
      end loop;
      return Nb_Array;
   end Nomber_Letter;
   
   ----------------------------------------------------------------------
   -- selection le noeud suivant en fonction du nb de lettre du niveau 
   function Select_Forest (P : Tree ; J : Integer ; Nb_Array : Letter_counter) return Tree is
      Nb_letter : Integer; --nb de lettre de 'J' ds le mot
   begin
      Nb_Letter := Nb_Array( J + 97);
      return P.Node_Tag_Ptr.all.Node_Branch_Array(Nb_letter);
   end Select_forest;
   
   ----------------------------------------------------------------------
   -- insere un mot dans l'arbre
   procedure Insertion (T : in out Tree ; Word : in String ) is
      P : Tree;
      Nb_Array : Letter_Counter;
      Node_Array : Forest;
            
      --creer un nouveau noeud
      procedure Creat_Node(P : Tree ; J : integer) is
	 --New_Node : Node;
	 New_Array : Forest;
      begin
	 
	 P.Node_Type := Is_Node;
	 --P.all := New_Node;
	 P.Node_Tag_Ptr.all.Node_Letter := Character'Val(J + 97) ;
	 P.Node_Tag_Ptr.all.Node_Branch_Array := new_Array;
      end Creat_Node;
      
   begin
      Nb_Array:=Nomber_Letter(Word);
      
      for J in 0..26 loop
	 Put(J);
	 if (P = null) then
	    Creat_Node (P,J);
	    P := Select_Forest(P, J, Nb_Array);
	 else 
	    P := Select_Forest(P, J, Nb_Array);
	 end if;
      end loop;
      
   end Insertion;

   -- recherche les mots 
   procedure Search_And_Display (T : in Tree ; Letters : in String) is
   begin
   null;
   
   
   end Search_And_Display;
   
end ;
