with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

with Ada.Integer_Text_Io;
use Ada.Integer_Text_Io;

package body Tree is
   --type Letter_Counter is array (0..25) of Integer;
   package Tree_Lists is new Ada.Containers.Doubly_Linked_Lists(Tree); -- Listes d'arbres

   --==========================================================================
   -- AUXILIAIRE: Retourne le classement d'une lettre dans l'ordre alphabéthique, avec a à 0
   --==========================================================================
   function Alphabetical_Rank(Letter : Character) return Integer is
   begin
      -- a = 97    z= 122
      return Character'Pos(Letter) - 97;
   end Alphabetical_Rank;
   --==========================================================================

   --==========================================================================
   -- creer le premier niveau de l'arbre , le noeud racine
   --==========================================================================
   function New_Tree return Tree is
      Root : Tree;
   begin
      Root := null; -- new Node;
      return Root ;
   end;
   --==========================================================================


   --==========================================================================
   -- retourne le nombre de lettre dans le mot, stocké dans un tableau
   --==========================================================================
   function Count_Letters (Word : String) return Letter_counter is
      Nb_Array : Letter_Counter;
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
      Nb_Letter := Nb_Array(J);
      return Buffer_node.Node_Tag_Ptr.Node_Branch_Array(Nb_letter);
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

   --==========================================================================
   -- insere un mot dans l'arbre
   --==========================================================================
   procedure Insertion (T : in out Tree ; Word : in String ) is
      Buffer_node : Tree;
      Nb_Array : Letter_Counter;
      Node_Array : Forest;

      -- Crée un nouveau noeud
      procedure Create_Node(Buffer_node : in out Tree ; J : integer) is
	 New_Array : Forest;
      begin
	 New_Array:= (others => null);
	 Buffer_node := new Node;
	 Buffer_node.Node_Type := Is_Node;
	 Buffer_node.Node_Tag_Ptr := new Tag_Node;
	 Buffer_node.Node_Tag_Ptr.Node_Letter := Character'Val(J + 97) ;
	 Buffer_node.Node_Tag_Ptr.Node_Branch_Array := new_Array;
      end Create_Node;

      -- cree une nouvelle feuille
      procedure Create_Leaf (Buffer_Node : in out Tree) is
      begin
	 Buffer_node := new Node;
	 Buffer_node.Node_Type := Is_Leaf;
	 Buffer_node.Leaf_Tag_Ptr := new Tag_Leaf;
      end;

      --insere recursivement un mot
      procedure Insertion_Rec (Current_Node :  in out Tree; Nb_Array : Letter_Counter; Current_depth : Integer)  is
	 Node_Next : Tree;
      begin
	 
	 if Current_Depth = 1 then 
	    for I in 0..8 loop
	       if Current_Node /= null then
		  Put("__________________");
	       end if;	  
	       end loop;
	 end if;
	 
	 if Current_depth < 26 then --parcours de l'arbre
	    
	    if Current_Node = null then 
	      Create_Node (Current_Node, Current_depth);
	    
	    else 
	      Put ("ancien noeud");
	   end if;
	   Put(Current_Node.Node_Tag_Ptr.Node_Letter);
	   
	   
	   Node_Next := Select_Forest(Current_node, Current_depth, Nb_Array);
	   
	   
	   Insertion_Rec(Node_Next,Nb_Array ,Current_Depth + 1);
	   
	 else --arrivée à une feuille
	    if Current_Node = null then
	       Create_Leaf(Current_Node);
	       Put("New leaf");
	    else
	       Put("ok");
	    end if;
	    New_Line;
	    Add_Word_To_Leaf(To_Unbounded_String(Word), Current_Node.Leaf_Tag_Ptr.all);
	 end if;

      end Insertion_Rec;

   begin
      Nb_Array := Count_Letters(Word);
      Buffer_Node := T;
      Insertion_Rec(Buffer_Node, Nb_Array,0);

   end Insertion;
   --==========================================================================


   --==========================================================================
   -- recherche les mots
   --==========================================================================
   procedure Search_And_Display (T : in Tree ; Letters : in String) is

      -- Affiche la liste des mots trouvés
      procedure Display_Leaf_Content(Leaf : Tag_Leaf) is
         Leaf_Word_List : Word_List.List := Leaf.Words;
         Position: Word_List.Cursor;
         procedure Print_Word(Position : in Word_List.Cursor) is
         begin
	    Put_line("Mot trouvé :" & To_String(Word_List.Element(Position)));
         end;

      begin
         -- Parcour de la liste avec la fonction d'itération des listes
        Leaf_Word_List.Iterate(Print_Word'Access);

      end;

      -- Parcours l'abre récursivement
      procedure Recursive_Tree_Browsing(Current_Node : Node ; Letter_Count_Array: Letter_Counter) is
         Buffer_Leaf : Tag_Leaf;
         Buffer_Node : Tag_Node;
      begin
         case Current_Node.Node_Type is
            when Is_Node => -- Si c'est un noeud normal
               Buffer_Node := Current_Node.Node_Tag_Ptr.all; --copie de l'étiquette du noeud dans le buffer
               -- Pour chaque Arbre fisl correspondant au nombre de lettres inférieur ou égal au nombre de lettres demandé
               for i in 0..Letter_Count_Array(Alphabetical_Rank(Buffer_Node.Node_Letter)) loop
                  if Buffer_Node.Node_Branch_Array(i) /= null then
		     Recursive_Tree_Browsing(Buffer_Node.Node_Branch_Array(i).all, Letter_Count_Array); -- On appelle récursivement la fonction
                  end if;
               end loop;
	       
            when Is_Leaf => -- Si c'est une feuille

               Buffer_Leaf := Current_Node.Leaf_Tag_Ptr.all; --copie de l'étiquette de la feuille dans le buffer
               Display_Leaf_Content(Buffer_Leaf); -- on affiche la feuille en question

         end case;

      end Recursive_Tree_Browsing;


      Letter_Count_Array : Letter_Counter := Count_Letters(Letters);

   begin
	-- Fonctionne en récursif, à l'aide de la fonction auxiliaire Recursive_Tree_Browsing

      Recursive_Tree_Browsing(T.all, Letter_Count_Array);


   end Search_And_Display;
   --==========================================================================

end ;
