with Tree; use Tree;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;
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
	word : String (1..10);
	Nb_Word, Length_Word : Integer;
      
begin
   T := Read_Words_File("american-english");
   Reset(G);
   Nb_Word := 1000;
   Length_Word := 10;
   for I in 1..Nb_word loop
      for J in 1..Length_Word loop
	 
	 Word(J):= Random(G);
      end loop;
      Put_Line(Word);
      Search_And_Display(T,Word);
   end loop;
end;

