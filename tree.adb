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
   function Count_Letters (Word : String) return Letter_counter is
      Nb_Array : Letter_Counter;   
   begin
      -- a = 97    z= 122
      Nb_Array := (others => 0);
      for I in Word'range loop
	 Nb_Array (Character'pos(Word(I))) := Nb_Array (Character'pos( Word(I))) + 1;
      end loop;
      return Nb_Array;
   end Count_Letters;
   
   ----------------------------------------------------------------------
   -- selection le noeud suivant en fonction du nb de lettre du niveau 
   function Select_Forest (Buffer_node : Tree ; J : Integer ; Nb_Array : Letter_counter) return Tree is
      Nb_letter : Integer; --nb de lettre de 'J' ds le mot
   begin
      Nb_Letter := Nb_Array( J + 97); Put(Nb_Letter);
      return Buffer_node.Node_Tag_Ptr.all.Node_Branch_Array(Nb_letter);
   end Select_forest;
   
   --==========================================================================
   -- Ajoute un mot à la feuille passée en argument
   --==========================================================================
   procedure Add_Word_To_Leaf(Word_To_Add : in Unbounded_String; Input_Leaf: in out Tag_Leaf) is
   begin
      Word_List.Append(Input_Leaf.Words, Word_To_Add);
   end Add_Word_To_Leaf; 
   --==========================================================================
   
   
   ----------------------------------------------------------------------
   -- insere un mot dans l'arbre
   procedure Insertion (T : in out Tree ; Word : in String ) is
      Buffer_node : Tree;
      Nb_Array : Letter_Counter;
      Node_Array : Forest;
            
      --creer un nouveau noeud
      procedure Create_Node(Buffer_node : out Tree ; J : integer) is
	 New_Array : Forest;
      begin
	 New_Array:= (others => null);
	 Buffer_node := new Node;
	 Buffer_node.Node_Type := Is_Node;
	 Buffer_node.Node_Tag_Ptr.all.Node_Letter := Character'Val(J + 97) ;
	 Buffer_node.Node_Tag_Ptr.all.Node_Branch_Array := new_Array;
      end Create_Node;
      
   begin
      Nb_Array := Count_Letters(Word);
      Buffer_Node := T;
      for J in 0..26 loop
	 Put(J);
	 if (Buffer_Node = null) then
	    Create_Node (Buffer_Node, J);
	    Buffer_node := Select_Forest(Buffer_node, J, Nb_Array);
	 else 
	    Buffer_node := Select_Forest(Buffer_node, J, Nb_Array);
	 end if;
      end loop;
      
   end Insertion;

   -- recherche les mots 
   procedure Search_And_Display (T : in Tree ; Letters : in String) is
   begin
   null;
   
   
   end Search_And_Display;
   
end ;
