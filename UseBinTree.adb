----------UseBinTree.adb----------

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Command_Line; use Ada.Command_Line;
with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with Ada.Unchecked_Deallocation;

with BinarySearchTree;
with RecordTypes; use RecordTypes;

procedure UseBinTree is
   PACKAGE IntIO IS NEW Ada.Text_IO.Integer_IO(Integer); USE IntIO;

   type Customer_Ptr is access all Customer;
   procedure Free is new Ada.Unchecked_Deallocation(Customer, Customer_Ptr);
   --deal with hemorrhaging

   package CustomerBinaryTree is new BinarySearchTree(String10, Customer);
   use CustomerBinaryTree;

   Rt: BinarySearchTreePoint; --same as Head
   N: BinarySearchTreePoint; --this is the pointer to node of record searched for if Found
   S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11: BinarySearchTreePoint; --this is the temp pointer to inorder successor node
   G: BinarySearchTreeRecordPoint;
   --GG: access Customer;
   E: access Customer; --to create a new empty customer field for Root comparison
   C: access Customer; --heap allocated, so it must be freed

   --CC: aliased Customer;

begin
   E:= new Customer'("          ", "          ");
   Init_Tree(Rt, BinarySearchTreeRecordPoint(E));
   --Insert the following data in the tree using InsertBinarySearchTree

   --1)	Insert the following data in the tree using InsertBinarySearchTree: Nkwantal, 295-1492;
   ---Idle, 291-1864;  Green, 295-1601;  Realzola, 293-6122;  Easlon, 295-1882;  Bolen,  291-7890;
   --Hedreen, 294-8075; Bell, 584-3622.

   C := new Customer'(Name => "Nkwantal  ",Number => "295-1492  ");
   InsertBinarySearchTree(Rt, BinarySearchTreeRecordPoint(C));
   Print(C.all); Put("has been added to the list."); New_Line(2);

   C := new Customer'(Name => "Idle      ",Number => "291-1864  ");
   InsertBinarySearchTree(Rt, BinarySearchTreeRecordPoint(C));
   Print(C.all); Put("has been added to the list."); New_Line(2);

   C := new Customer'(Name => "Green     ",Number => "295-1601  ");
   InsertBinarySearchTree(Rt,  BinarySearchTreeRecordPoint(C));
   Print(C.all); Put("has been added to the list."); New_Line(2);

   C := new Customer'(Name => "Realzola  ",Number => "293-6122  ");
   InsertBinarySearchTree(Rt, BinarySearchTreeRecordPoint(C));
   Print(C.all); Put("has been added to the list."); New_Line(2);

   C := new Customer'(Name => "Easlon    ",Number => "295-1882  ");
   InsertBinarySearchTree(Rt, BinarySearchTreeRecordPoint(C));
   Print(C.all); Put("has been added to the list."); New_Line(2);

   C := new Customer'(Name => "Bolen     ",Number => "291-7890  ");
   InsertBinarySearchTree(Rt, BinarySearchTreeRecordPoint(C));
   Print(C.all); Put("has been added to the list."); New_Line(2);

   C := new Customer'(Name => "Hedreen   ",Number => "294-8075  ");
   InsertBinarySearchTree(Rt, BinarySearchTreeRecordPoint(C));
   Print(C.all); Put("has been added to the list."); New_Line(2);

   C := new Customer'(Name => "Bell      ",Number => "584-3622  ");
   InsertBinarySearchTree(Rt, BinarySearchTreeRecordPoint(C));
   Print(C.all); Put("has been added to the list."); New_Line(2);

   --2)	Find Bolen and print the phone number using FindCustomerIterative.
   Put_Line("Searching for Bolen iteratively: ");
   FindCustomerIterative(Rt, "Bolen     ",G, N);
   Put(String(Get_Number(G.all))); Put("is the number of the located customer."); New_Line(2);

   --3)Find Bolen and print the phone number using FindCustomerRecursive.
   Put_Line("Searching for Bolen recursively: ");
   FindCustomerRecursive(Rt, "Bolen     ",G);
   Put(String(Get_Number(G.all))); Put("is the number of the located customer."); New_Line(2);

   --4)Find Penton and print the phone number using FindCustomerIterative.
   Put_Line("Searching for Penton iteratively: ");
   FindCustomerIterative(Rt, "Penton    ",G, N);
   --Put(String(Get_Number(G.all))); Put("is the number of the located customer."); New_Line(2);

   Put_Line("Searching for Penton recursively: ");
   --5)Find Penton and print the phone number using FindCustomerRecursive.
   FindCustomerRecursive(Rt, "Penton    ",G);
   --Put(String(Get_Number(G.all))); Put("is the number of the located customer."); New_Line(2);

   --6)Starting with Easlon, traverse the entire tree in inorder back to Easlon printing the name field of each node encountered. (you should be able to do this starting at any node, i.e., find Easlon using a binary search then traverse the tree from this point in inorder).
   New_Line;
   Put_Line("Starting at Easlon, the list inorder reads: ");
   FindCustomerIterative(Rt, "Easlon    ",G, N); put_line(String(Record_of_Node(N).Name));
   InOrderSuccessor(N, S1); put_line(String(Record_of_Node(S1).Name));
   InOrderSuccessor(S1, S2); put_line(String(Record_of_Node(S2).Name));
   InOrderSuccessor(S2, S3); put_line(String(Record_of_Node(S3).Name));
   InOrderSuccessor(S3, S4); put_line(String(Record_of_Node(S4).Name));
   InOrderSuccessor(S4, S5); put_line(String(Record_of_Node(S5).Name));
   InOrderSuccessor(S5, S6); put_line(String(Record_of_Node(S6).Name));
   InOrderSuccessor(S6, S7); put_line(String(Record_of_Node(S7).Name));
   InOrderSuccessor(S7, S8); put_line(String(Record_of_Node(S8).Name));
   InOrderSuccessor(S8, S9); put_line(String(Record_of_Node(S9).Name));
   New_Line;

   --7)Insert Altayyar, 294-1568; Gammons, 294-1882; and Whitehead 295-6622.
   C := new Customer'(Name => "Altayyar  ",Number => "294-1568  ");
   InsertBinarySearchTree(Rt, BinarySearchTreeRecordPoint(C));
   Print(C.all); Put("has been added to the list."); New_Line(2);

   C := new Customer'(Name => "Gammons   ",Number => "294-1882  ");
   InsertBinarySearchTree(Rt, BinarySearchTreeRecordPoint(C));
   Print(C.all); Put("has been added to the list."); New_Line(2);

   C := new Customer'(Name => "Whitehead ",Number => "295-6622  ");
   InsertBinarySearchTree(Rt, BinarySearchTreeRecordPoint(C));
   Print(C.all); Put("has been added to the list."); New_Line(2);

   --8)Traverse the tree in inorder starting at the root using the method InOrderSuccessor.  Print the name and phone number of each node as it is encountered.
   New_Line;
   Put_Line("Starting at Root, the list inorder reads: ");
   --FindCustomerIterative(Rt, "      ",G, N); put_line(String(Record_of_Node(N).Name)); --search for root pointer/empty node
   InOrderSuccessor(Rt, S1); put(String(Record_of_Node(S1).Name)); put(String(Record_of_Node(S1).Number)); New_Line;
   InOrderSuccessor(S1, S2); put(String(Record_of_Node(S2).Name));put(String(Record_of_Node(S2).Number));New_Line;
   InOrderSuccessor(S2, S3); put(String(Record_of_Node(S3).Name));put(String(Record_of_Node(S3).Number));New_Line;
   InOrderSuccessor(S3, S4); put(String(Record_of_Node(S4).Name));put(String(Record_of_Node(S4).Number));New_Line;
   InOrderSuccessor(S4, S5); put(String(Record_of_Node(S5).Name));put(String(Record_of_Node(S5).Number));New_Line;
   InOrderSuccessor(S5, S6); put(String(Record_of_Node(S6).Name));put(String(Record_of_Node(S6).Number));New_Line;
   InOrderSuccessor(S6, S7); put(String(Record_of_Node(S7).Name));put(String(Record_of_Node(S7).Number));New_Line;
   InOrderSuccessor(S7, S8); put(String(Record_of_Node(S8).Name));put(String(Record_of_Node(S8).Number));New_Line;
   InOrderSuccessor(S8, S9); put(String(Record_of_Node(S9).Name));put(String(Record_of_Node(S9).Number));New_Line;
   InOrderSuccessor(S9, S10); put(String(Record_of_Node(S10).Name));put(String(Record_of_Node(S10).Number));New_Line;
   InOrderSuccessor(S10, S11); put(String(Record_of_Node(S11).Name));put(String(Record_of_Node(S11).Number));New_Line;
   New_Line;

   --9)Traverse the tree in pre-order using "procedure PreOrderTraversalIterative(TreePoint: in BinarySearchTreePoint);."
   New_Line;
   Put_Line("Starting at Root, the list in preorder reads: ");
   PreOrderTraversalIterative(Rt);

   --7)	Delete: Bolen, Najar, and Green.   (Note they may not be in the tree.)  Locate the nodes to be deleted using a binary search.
   New_Line;
   Put_Line("Searching to delete Bolen: ");
   DeleteRandomNode(Rt, "Bolen     ");
   Put_Line("Searching to delete Najar: ");
   DeleteRandomNode(Rt, "Najar     ");
   Put_Line("Searching to delete Green: ");
   DeleteRandomNode(Rt, "Green     ");

   --8)	Insert: Novak, 294-1666; and Gonzales, 295-1882.
   C := new Customer'(Name => "Novak     ",Number => "294-1666  ");
   InsertBinarySearchTree(Rt, BinarySearchTreeRecordPoint(C));
   Print(C.all); Put("has been added to the list."); New_Line(2);

   C := new Customer'(Name => "Gonzales  ",Number => "295-1882  ");
   InsertBinarySearchTree(Rt, BinarySearchTreeRecordPoint(C));
   Print(C.all); Put("has been added to the list."); New_Line(2);

   --9)	Traverse the tree in inorder starting at the root using the method InOrderSuccessor.  Print the name and phone number of each node as it is encountered.
   New_Line;
   Put_Line("Starting at Root, the list inorder reads: ");
   --FindCustomerIterative(Rt, "      ",G, N); put_line(String(Record_of_Node(N).Name)); --search for root pointer/empty node
   InOrderSuccessor(Rt, S1); put(String(Record_of_Node(S1).Name)); put(String(Record_of_Node(S1).Number)); New_Line;
   InOrderSuccessor(S1, S2); put(String(Record_of_Node(S2).Name));put(String(Record_of_Node(S2).Number));New_Line;
   InOrderSuccessor(S2, S3); put(String(Record_of_Node(S3).Name));put(String(Record_of_Node(S3).Number));New_Line;
   InOrderSuccessor(S3, S4); put(String(Record_of_Node(S4).Name));put(String(Record_of_Node(S4).Number));New_Line;
   InOrderSuccessor(S4, S5); put(String(Record_of_Node(S5).Name));put(String(Record_of_Node(S5).Number));New_Line;
   InOrderSuccessor(S5, S6); put(String(Record_of_Node(S6).Name));put(String(Record_of_Node(S6).Number));New_Line;
   InOrderSuccessor(S6, S7); put(String(Record_of_Node(S7).Name));put(String(Record_of_Node(S7).Number));New_Line;
   InOrderSuccessor(S7, S8); put(String(Record_of_Node(S8).Name));put(String(Record_of_Node(S8).Number));New_Line;
   InOrderSuccessor(S8, S9); put(String(Record_of_Node(S9).Name));put(String(Record_of_Node(S9).Number));New_Line;
   InOrderSuccessor(S9, S10); put(String(Record_of_Node(S10).Name));put(String(Record_of_Node(S10).Number));New_Line;
   InOrderSuccessor(S10, S11); put(String(Record_of_Node(S11).Name));put(String(Record_of_Node(S11).Number));New_Line;
   New_Line;

   --10)Traverse the tree using ReverseInOrder starting at the root.
     New_Line;
   Put_Line("Starting at Root, the list in reverse inorder reads: ");
   --FindCustomerIterative(Rt, "      ",G, N); put_line(String(Record_of_Node(N).Name)); --search for root pointer/empty node
   ReverseInOrder(Rt, S1); put(String(Record_of_Node(S1).Name)); put(String(Record_of_Node(S1).Number)); New_Line;
   ReverseInOrder(S1, S2); put(String(Record_of_Node(S2).Name));put(String(Record_of_Node(S2).Number));New_Line;
   ReverseInOrder(S2, S3); put(String(Record_of_Node(S3).Name));put(String(Record_of_Node(S3).Number));New_Line;
   ReverseInOrder(S3, S4); put(String(Record_of_Node(S4).Name));put(String(Record_of_Node(S4).Number));New_Line;
   ReverseInOrder(S4, S5); put(String(Record_of_Node(S5).Name));put(String(Record_of_Node(S5).Number));New_Line;
   ReverseInOrder(S5, S6); put(String(Record_of_Node(S6).Name));put(String(Record_of_Node(S6).Number));New_Line;
   ReverseInOrder(S6, S7); put(String(Record_of_Node(S7).Name));put(String(Record_of_Node(S7).Number));New_Line;
   ReverseInOrder(S7, S8); put(String(Record_of_Node(S8).Name));put(String(Record_of_Node(S8).Number));New_Line;
   ReverseInOrder(S8, S9); put(String(Record_of_Node(S9).Name));put(String(Record_of_Node(S9).Number));New_Line;
   ReverseInOrder(S9, S10); put(String(Record_of_Node(S10).Name));put(String(Record_of_Node(S10).Number));New_Line;
   ReverseInOrder(S10, S11); put(String(Record_of_Node(S11).Name));put(String(Record_of_Node(S11).Number));New_Line;
   New_Line;

   --11)Traverse the tree in preorder printing the name field using an iterative routine taking advantage of the threads.
   New_Line;
   Put_Line("Starting at Root, the list in preorder reads: ");
   PreOrderTraversalIterative(Rt);

   --12)Print the name field traversing the tree in PostorderIterative using an iterative procedure taking advantage of the threads.
   New_Line;
   Put_Line("Starting at Root, the list in postorder using PostorderIterative reads: ");
   PostOrderIterative(Rt);

   --13)Print the name field traversing the tree in PostorderRecursive using a recursive procedure.
   New_Line(2);
   Put_Line("Starting at Root, the list in postorder using PostorderRecursive reads: ");
   PostOrderRecursive(Rt);

end;
