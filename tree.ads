with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

package Tree is

	type Tree is private;
	function New_Tree return Tree;
	procedure Insertion(T : in out Tree ; Word : in String);
	procedure Search_And_Display(T : in Tree ; Letters : in String);

private

	type Node;
	type Tree is access Node;
end Tree;
