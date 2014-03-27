with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;
with Ada.Containers.Doubly_Linked_Lists;
package Tree is
  
  
  
  type Tree is private;
  function New_Tree return Tree;
  procedure Insertion(T : in out Tree ; Word : in String);
  procedure Search_And_Display(T : in Tree ; Letters : in String);
  
  type Letter_Counter is array (97..122) Of Integer;
  function Count_Letters ( Word : String) return Letter_Counter;
  
  private
     
     type Forest is array (0..8) of Tree;
     type Node_Nature is ( Is_Node, Is_Leaf);
     type Tag_Node is record
	Node_Letter: Character;
      Node_Branch_Array : Forest; 
     end record;
     
     package Word_List is new Ada.Containers.Doubly_Linked_Lists(Unbounded_String);
     
     type Tag_Leaf is record
	--Contient une double liste des mots contenus par la feuille
	Words : Word_List.List;
     end record;
     
     type Node is record
	Node_Type: Node_Nature; --défini si le noeud est un noeud standard ou une feuille
      Node_Tag_Ptr : access Tag_Node; --utilisé si le noeud est standard
      Leaf_Tag_Ptr: access Tag_Leaf; --utilisé si le noeud est une feuille 
     end record;
     type Tree is access Node;
        
end Tree;
