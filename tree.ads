with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;
with Ada.Containers.Doubly_Linked_Lists;
package Tree is

  type Tree is private;
  function New_Tree return Tree;
  procedure Insertion(T : in out Tree ; Word : in String);
  procedure Search_And_Display(T : in Tree ; Letters : in String);

  type Letter_Counter is array (0..25) Of Integer;
  function Count_Letters ( Word : String) return Letter_Counter;

  private

     type Forest is array (0..8) of Tree;
   type Node_Nature is ( Is_Node, Is_Leaf);
   -- Correspond au contenu stocké par un noeud s'il est un vrai noeud
   type Tag_Node is record
      Node_Letter: Character; -- caractère correspondant au noeud
      Node_Branch_Array : Forest; -- Tableau des pointeurs vers les arbres fils
   end record;

   package Word_List is new Ada.Containers.Doubly_Linked_Lists(Unbounded_String);

   -- Correspond au contenu stocké par un noeud si c'est une feuille, l'utilisation d'un record est pour  garder plus de cohérence dans le code
   type Tag_Leaf is record
      --Contient une double liste des mots contenus par la feuille
      Words : Word_List.List;
   end record;
   
   type Stem is access Tag_Leaf;
   
   type Node is record
      Node_Type: Node_Nature; --défini si le noeud est un noeud standard ou une feuille
      Node_Tag_Ptr : access Tag_Node; --utilisé si le noeud est standard
      Leaf_Tag_Ptr: Stem ; --utilisé si le noeud est une feuille
   end record;
   type Tree is access Node;
   
   
end Tree;
