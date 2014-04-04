with Tree; use Tree;
with Ada.Command_Line; use Ada.Command_Line;
with Ada.Text_IO; use Ada.Text_IO;
procedure Test_Pire is
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
   T :Tree.Tree;   
   Word : String(1..26*8);
begin
   Word := "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz";
   T := Read_Words_File("american-english");
   Tree.Search_And_Display(T, Word);
   
end;
