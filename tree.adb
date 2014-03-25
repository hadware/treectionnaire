with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;


package body Tree is
   type Letter_Counter is array (1..26) of Integer;
   
   -- creer le premier niveau de l'arbre , le noeud racine
   function New_Tree return Tree is
      Root : Tree;
   begin
      Root := new Node;
      return Root ;   
   end;
   

   -- retourne le nombre de lettre dans le mot
   function Nomber_Letter (Word : String) return Letter_counter is
      Nb_Array : Letter_Counter;   
   begin
      -- a = 97    z= 122
     
      
      null;
      
      return Nb_Array;
   end;

   -- insere un mot dans l'arbre
   procedure Insertion (T : in out Tree ; Word : in String ) is
   
   begin
      
   null;
   end;

   -- recherche les mots 
   procedure Search_And_Display (T : in Tree ; Letters : in String) is
   begin
   null;
   
   
   end;
   
end ;
