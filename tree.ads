with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

package Tree is

   type Tree is private;
   function New_Tree return Tree;
   procedure Insertion(T : in out Tree ; Word : in String);
   procedure Search_And_Display(T : in Tree ; Letters : in String);

private
   
  
   type Forest is array (0..8) of Tree;
   type Node_Nature is ( Is_Node, Is_Leaf);
   type Tag_Node is record
      Node_Letter: Character;
      Node_Branch_Array : Forest; 
   end record;
      
   type Tag_Leaf is record
      --Contient une double liste des mots contenus par la feuille
      Truc : Integer;
   end record;
   
   
   
   type Node is record
      Node_Type: Node_Nature;
      Node_Tag_Ptr : access Tag_Node;
      Leaf_Tag_Ptr: access Tag_Leaf;
   end record;
   type Tree is access Node;
   
          

   
end Tree;
