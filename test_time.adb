with Tree; use Tree;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;
with Ada.Command_Line; use Ada.Command_Line;

procedure Test_time is
   function Read_Words_File(File_Name: in String) return Tree.Tree is
      File : File_Type;
      T : Tree.Tree := New_Tree;
      
   begin
      Open(File, In_File, File_Name);
      while not End_Of_File(File) loop
	 declare
	    Line : String := Get_Line(File);
	 begin
	    Insertion(T, Line);
	 end;
      end loop;
      Close(File);
      return T;
   end Read_Words_File;
	
   subtype Letters is Character range 'a'..'z'; 
   package Random_Letters is new Ada.Numerics.Discrete_Random(Letters);
   use Random_Letters;
   G: Generator;
   
   T : Tree.Tree;
   
   -- Fichier qui stocke les mots générés aléatoirement
   Random_Word_File : File_Type;
   
   -- Paramètres de génération du dico aléatoire
   Word_Length : Positive := 10;
   Word_Number : Positive := 1000;
   
begin
   T := Read_Words_File("american-english");
   Reset(G);
   
   if Argument_Count = 2 then
      Word_Length := Integer'Value(Argument(1));
      Word_Number := Integer'Value(Argument(2));
   end if;
   
   declare
      Word : String(1..Word_Length);
   begin
      for I in 1..Word_Number loop
	 for J in 1..Word_Length loop
	    Word(J):= Random(G);
	 end loop;
	 Put_Line(Word);
	 Search_And_Display(T,Word);
      end loop;
   end;
   
end;

