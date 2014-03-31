with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

with Ada.Integer_Text_Io;
use Ada.Integer_Text_Io;

package body Tree is
   --type Letter_Counter is array (0..25) of Integer;
   package Tree_List is new Ada.Containers.Doubly_Linked_Lists(Tree); -- Listes d'arbres

   --==========================================================================
   -- creer le premier niveau de l'arbre , le noeud racine
   --==========================================================================
   function New_Tree return Tree is
      Root : Tree;
   begin
      Root := new Node;
      return Root ;
   end;
   --==========================================================================


   --==========================================================================
   -- retourne le nombre de lettre dans le mot, stocké dans un tableau
   --==========================================================================
   function Count_Letters (Word : String) return Letter_counter is
      Nb_Array : Letter_Counter;

      -- Retourne le classement d'une lettre dans l'ordre alphabéthique, avec a à 0
      function Alphabetical_Rank(Letter : Character) return Integer is
      begin
	  -- a = 97    z= 122
	 return Character'Pos(Letter) - 97;
      end;

   begin
      Nb_Array := (others => 0);
      for I in Word'range loop
	 Nb_Array (Alphabetical_Rank(Word(I))) := Nb_Array (Alphabetical_Rank(Word(I))) + 1;
      end loop;
      return Nb_Array;
   end Count_Letters;
   --==========================================================================


   --==========================================================================
   -- selection le noeud suivant en fonction du nb de lettre du niveau
   --==========================================================================
   function Select_Forest (Buffer_node : Tree ; J : Integer ; Nb_Array : Letter_counter) return Tree is
      Nb_letter : Integer; --nb de lettre de 'J' ds le mot
   begin
      Nb_Letter := Nb_Array( J + 97); Put(Nb_Letter);
      return Buffer_node.Node_Tag_Ptr.all.Node_Branch_Array(Nb_letter);
   end Select_forest;
   --==========================================================================


   --==========================================================================
   -- Ajoute un mot à la feuille passée en argument
   --==========================================================================
   procedure Add_Word_To_Leaf(Word_To_Add : in Unbounded_String; Input_Leaf: in out Tag_Leaf) is
   begin
      Word_List.Append(Input_Leaf.Words, Word_To_Add);
   end Add_Word_To_Leaf;
   --==========================================================================


   --==========================================================================
   -- insere un mot dans l'arbre
   --==========================================================================
   procedure Insertion (T : in out Tree ; Word : in String ) is
      Buffer_node : Tree;
      Nb_Array : Letter_Counter;
      Node_Array : Forest;

      -- Crée un nouveau noeud
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

      for J in 0..25 loop

	 Put(J);

	 if (Buffer_Node = null) then
	    Create_Node (Buffer_Node, J);
	    Buffer_node := Select_Forest(Buffer_node, J, Nb_Array);
	 else
	    Buffer_node := Select_Forest(Buffer_node, J, Nb_Array);
	 end if;

      end loop;

   end Insertion;
   --==========================================================================


   --==========================================================================
   -- recherche les mots
   --==========================================================================
   procedure Search_And_Display (T : in Tree ; Letters : in String) is

      -- Affiche la liste des mots trouvés
      procedure Display_Leaf_Content(Leaf : Tag_Leaf) is
         Leaf_Word_List : Word_List.List := Leaf.Words;

         procedure Print_Word(Position : in Word_List.Cursor) is
         begin
            Put_Line(Word_List.Element(Position));
         end;

      begin
         -- Parcour de la liste avec la fonction d'itération des listes
        Leaf_Word_List.Iterate(Print_Word'Access);

      end;

      Tree_Level_Counter : Natural := 1;
      Current_Possible_Trees : Array(1..27) of Tree_List.List;

   begin

      -- Le parcours de l'arbre est effectué de façon itérative, la manière récursivé étant peut-être plus claire mais largement moins optimisée
      -- L'algorithme est le suivant:
      -- 	1) On commence avec le noeud racine
      --	2) On établit une liste des arbres concerné par le choix de lettres actuel
      --	3) Pour chaque arbre de cette liste, on réitère le processus, dans une nouvelle liste
      --	4) On effectue ce processus avec une nouvelle liste par étage de l'arbre
      --	5) Quand on en arrive aux feuilles, on appelle la fonction de lecture de feuille qui va afficher les mots contenus dans celles-ci



   end Search_And_Display;
   --==========================================================================

end ;
