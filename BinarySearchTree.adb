----------BinarySearchTree.adb----------
with Ada.Unchecked_Deallocation;
with Ada.Text_IO; use Ada.Text_IO;

package body BinarySearchTree is

   type String10 is new String(1..10);

   --to free space from heap allocation
   procedure Free_Node is new Ada.Unchecked_Deallocation(Node,BinarySearchTreePoint);
   procedure Free_Record is new Ada.Unchecked_Deallocation(BinarySearchTreeRecord,BinarySearchTreeRecordPoint);

   procedure Print_Record(R: BinarySearchTreeRecord) is --used to print record contents
   begin
      Put_Line(Image(R));
   end;

   function Make_Node(R : in BinarySearchTreeRecordPoint) return BinarySearchTreePoint is
      P : BinarySearchTreePoint := new Node;
   begin
      P.Info := R;
      return P;
   end;

   --This creates the head/root node which points to the tree with its LTAG="-",
   --RTag="+", and RLink and RLink pointing to themselves.
   procedure Init_Tree(Root: in out BinarySearchTreePoint; EmptyRec: BinarySearchTreeRecordPoint) is
   begin
      Root:= new Node;
      Root.Ltag := False;
      Root.Llink := Root;
      Root.Rlink := Root;
      Root.Rtag := True;
      Root.Info := EmptyRec;
   end;

   --TreeRecord is new record to insert
   procedure InsertBinarySearchTree(Root:  in out BinarySearchTreePoint;
                                    TreeRecord: BinarySearchTreeRecordPoint) is
      P: BinarySearchTreePoint := new Node;
      P2: BinarySearchTreePoint := new Node;
      P3: BinarySearchTreePoint;

   begin
      if Root.LTag = False then  --if tree is empty, new node inserted here
         P.Ltag := False;
         P.Llink := Root;
         P.Info := TreeRecord;
         P.RLink := Root;
         P.Rtag := False;
         Root.Ltag := True;
         Root.Llink := P;
      else --tree is not empty. locate a match w/ existing node or position to insert new node
         P := Root.Llink; --let P point to the first node (left link of root/head)
         loop --search left/ right for match or insert if no match
            if Get_Key(TreeRecord.all) < Get_Key(P.Info.all) then --is new name less than current tree name
               if P.LTag = True then --search to left
                  P := P.Llink;
               else
                  P2 := new Node; ----insert node as left subtree
                  P2.Info := TreeRecord;
                  P2.Llink := P.Llink;
                  P2.Ltag := P.LTag;
                  P2.Rlink := P;
                  P2.Rtag := false;
                  P.Llink := P2;
                  P.LTag := True;
                  if P2.Ltag = True then --update the inorder predecessor's RLink to a thread if it's a child(LTag=True)
                     InOrderPredecessor(P2, P3);-- $P2.RLink := P2  (1. get the inorder predecessor of P2 and set its RLink as a thread to P2)
                     P3.Rlink := P2;
                  end if;
                  exit;
               end if; --exit loop since new node inserted
                       --insert node as left subtree
            elsif Get_Key(TreeRecord.all) > Get_Key(P.Info.all) then --search if name to insert is greater than tree node's
               if P.RTag = True then --go right
                  P := P.RLink;
               else -- Insert node as right subtree.
                  P2 := new Node;
                  P2.Info := TreeRecord;
                  P2.Rlink := P.Rlink;
                  P2.Rtag := P.RTag;
                  P.Rlink := P2;
                  P.RTag := True;
                  P2.Llink := P;
                  P2.Ltag := false;
                  if P2.Rtag = True then --update the inorder predecessor's LLink to a thread if it's a child(LTag=True)
                     InOrderSuccessor(P2, P3);                   --1)Find pointer to inorder successor of node(use inorder successor proccedure)
                     P3.LLink := P2;   --TODO: $P2.LLink := P2  (1. get the inorder predecessor of P2 and set its RLink to P2)
                  end if;

                  exit;              -- New node inserted.
               end if;
            else  -- Implies that Akey matches P.Key.
                  --insert new node to the right subtree of subtree pointed to by p;
                  --p2 will point to new node inserted
               P2 := new Node;
               P2.Info := TreeRecord;

               P2.RLink := P.Rlink;
               P2.RTag := P.RTag;
               P2.LTag := False;
               P2.Llink := P;
               P.RLink := P2;
               P.RTag := True;
               If P2.Rtag = True then --if there were were other right subnodes                                     --!!!TODO: set the inorder successors's LLink = P2
                  InOrderSuccessor(P2, P3);                   --1)Find pointer to inorder successor of node(use inorder successor proccedure)
                  P3.LLink := P2;                  --2)change its LLink to point to P2(the new node)
               end if;
               exit;
            end if;
         end loop;
      end if;
   end;

   procedure DeleteRandomNode( Root: in BinarySearchTreePoint;
                               CustomerName:  in Akey) is
      P: BinarySearchTreePoint := new Node;
      P2: BinarySearchTreePoint := new Node;
      P3: BinarySearchTreePoint := new Node;
   begin

      if Root.Llink = Root then  --if tree is empty
         Put_Line("No customer search possible. The tree is empty.");
      else --tree is not empty. locate a match w/ existing node or position to insert new node
         P := Root.Llink; --let P point to the first node (left link of root/head)
         loop --search left/ right for match or insert if no match
            if CustomerName < Get_Key(P.Info.all) then -- is insertion key < then current node
               if P.LTag /= False then --search to left
                  P := P.Llink;
               else
                  Put_Line("That name is not in the tree."); New_Line;--searched all the way to left
                  exit;
               end if; --exit loop since new node inserted
               --insert node as left subtree
            elsif CustomerName > Get_Key(P.Info.all) then --search to the right if search name is larger than name of customer of node pointed to
               if P.RTag /= False then
                  P := P.RLink;
               else
                  Put_Line("That name is not in the tree."); New_Line; --searched all the way to left
                  exit;              -- New node inserted.
               end if;
            else  -- Implies that Akey/CustomerName matches P.Info.all/P.Character.Name
               --print that the node was found and return pointer(CustomerPoint)
               Put_Line("Name has been deleted from the tree."); New_Line;
               InOrderSuccessor(P,P2); --replace the node with its inorder successor
               P2.Ltag := P.Ltag; --update P$.Ltag
               P2.Llink := P.Llink; --update P$.LLink
               if P.RTag = False then --if there are no right children, update them
                  P.Llink.Rlink := P.RLink;
                  P.Llink.RTag := P.RTag;
               end if;
               if P.RTag = True then
                  InOrderSuccessor(P2, P3);
                  P2.RLink := P3;
                  P3.Llink := P2;
                  P.Llink.Rlink.Rlink := P2;
               end if;
               --TODO: add functionability if the node deleted has children
               Free_Record(P.Info);
               Free_Node(P);
               exit;
            end if;
         end loop;
      end if;
   end;

   procedure FindCustomerIterative(Root: in BinarySearchTreePoint;
                                   CustomerName:  in Akey;
                                   CustomerPoint:  out BinarySearchTreeRecordPoint;
                                   NodePoint: out BinarySearchTreePoint) is
      P: BinarySearchTreePoint := new Node;
      P2: BinarySearchTreePoint := new Node;
   begin

      if Root.Llink = Root then  --if tree is empty
         Put_Line("No customer search possible. The tree is empty.");
      else --tree is not empty. locate a match w/ existing node or position to insert new node
         P := Root.Llink; --let P point to the first node (left link of root/head)
         loop --search left/ right for match or insert if no match
            if CustomerName < Get_Key(P.Info.all) then --??wrong way of doing?? is insertion key < then current node
               if P.LTag /= False then --search to left
                  P := P.Llink;
               else
                  Put_Line("That name is not in the tree."); New_Line;--searched all the way to left
                  exit;
               end if; --exit loop since new node inserted
               --insert node as left subtree
            elsif CustomerName > Get_Key(P.Info.all) then --search to the right if search name is larger than name of customer of node pointed to
               if P.RTag /= False then
                  P := P.RLink;
               else
                  Put_Line("That name is not in the tree."); New_Line; --searched all the way to left
                  exit;              -- New node inserted.
               end if;
            else  -- Implies that Akey/CustomerName matches P.Info.all/P.Character.Name
               --print that the node was found and return pointer(CustomerPoint)
               Put_Line("Name has been found in the tree."); New_Line;
               CustomerPoint := P.Info;
               NodePoint := P;
               exit;
            end if;
         end loop;
      end if;
   end;

   procedure FindCustomerRecursive2(Root: in BinarySearchTreePoint; --binary search
                                   CustomerName:  in Akey;
                                   CustomerPoint:  out BinarySearchTreeRecordPoint) is
   begin

      if Root.Llink = Root then  --If Root.Llink points to itself, then the tree is empty
         Put_Line("No customer search possible. The tree is empty.");

      else --tree is not empty. locate a match w/ existing node or position to insert new node
         loop --search left/ right for match or insert if no match
            if CustomerName < Get_Key(Root.Info.all) then --TODO!!??wrong way of doing?? is insertion key < then current node
               if Root.LTag /= False then --search to left
                  FindCustomerRecursive2(Root.Llink, CustomerName, CustomerPoint);
               else
                  Put_Line("That name is not in the tree."); New_Line;--searched all the way to left
                  exit;
               end if; --exit loop since new node inserted
               exit;--redundant--but make sure it's working
               --insert node as left subtree
            elsif CustomerName > Get_Key(Root.Info.all) then --search to the right if search name is larger than name of customer of node pointed to
               if Root.RTag /= False then
                  FindCustomerRecursive2(Root.Rlink, CustomerName, CustomerPoint);
               else
                  Put_Line("That name is not in the tree."); New_Line; --searched all the way to left
                  exit;              -- New node inserted.
               end if;
               exit;
            else  -- Implies that Akey/CustomerName matches P.Info.all/P.Character.Name
                  --print that the node was found and return pointer(CustomerPoint)
               New_Line;
               CustomerPoint := Root.Info;
               exit;
            end if;
         end loop;
      end if;
   end;

   procedure FindCustomerRecursive(Root: in BinarySearchTreePoint;
                                   CustomerName:  in Akey;
                                   CustomerPoint:  out BinarySearchTreeRecordPoint) is
   begin
      if Root.Llink = Root then  --If Root.Llink points to itself, then the tree is empty
         Put_Line("No customer search possible. The tree is empty.");
      else
         FindCustomerRecursive2(Root.Llink, CustomerName, CustomerPoint);
      end if;
   end;

   procedure InOrderSuccessor(TreePoint: in BinarySearchTreePoint; Successor: out BinarySearchTreePoint) is
      P: BinarySearchTreePoint;
   begin
      P := TreePoint.Rlink;--look at right link

      If TreePoint.RTag = False then --is this a threaded link?
         Successor := P; --then P already points to the inorder successor
      else --search to left
         while P.Ltag = True loop --does this node have a left child
            P := P.Llink; --if so traverse to the lowest left child
         end loop;
         Successor := P; --return this child (the inorder successor)
      end if;
   end;

   procedure InOrderPredecessor(TreePoint: in BinarySearchTreePoint; Pred: out BinarySearchTreePoint) is
      P: BinarySearchTreePoint;
   begin
      P := TreePoint.Llink;--look at right link
      Pred := P;
      If TreePoint.LTag = True then --is this a threaded link?
         while P.Rtag = True loop --does this node have a left child
            P := P.Rlink; --if so traverse to the lowest left child
         end loop;
         Pred := P; --return this child (the inorder successor)
      end if;
   end;

   function Record_of_Node(TreePoint: in BinarySearchTreePoint) return BinarySearchTreeRecordPoint is
   begin
      return TreePoint.Info;
   end;

   procedure PreOrder(TreePoint: in out BinarySearchTreePoint) is
      Stack: array(1..20) of BinarySearchTreePoint; --TODO: change/ balance tree requires logbase 2 of N space (N=# of nodes)
      Knt: integer := 0;
      P: BinarySearchTreePoint := TreePoint; --set stack empty/ P to tree point

   begin --VLR(visit/print, left, then right) --TODO: need to account for threaded links
      loop
         if P /= null then
            put("tree sort "); Put_Line(Image(P.Info.all)); New_Line;--put(P.Info.all); new_line;   --TODO: figure how to print name and number
            Knt := Knt + 1;   Stack(Knt) := P;   -- push location in stack.
            if P.Ltag = True then
               P := P.Llink;
            end if;
         else
            exit when Knt = 0;  -- Traveresed whole tree.
            P := Stack(Knt);    Knt := Knt - 1;
            put("tree sort "); Put_Line(Image(P.Info.all)); New_Line;-- put(P.Info.all); new_line; --TODO: figure hot to ptint this
            if P.RTag = True then
               P := P.RLink;
            end if;
         end if;
      end loop;
   end;

   procedure PostOrderIterative(TreePoint: in out BinarySearchTreePoint) is
      Stack: array(0..20) of BinarySearchTreePoint; --TODO: change/ balance tree requires logbase 2 of N space (N=# of nodes)
      StackDirection: array(0..20) of Integer range 0..1; --0 means the node was visited going to the left, and 1 means right
      Knt: integer := 0;
      V: Integer; --direction that is being traversed (0= left, 1=right)
      P: BinarySearchTreePoint := TreePoint.Llink; --set stack empty/ P to tree point

   begin --VLR(visit/print, left, then right)
      for x in 1..30 loop --TODO: take out for loop and have exit condition
         if P /= null then
            Knt := Knt + 1; Stack(Knt) := P; StackDirection(Knt) := 0;
            -- push location in stack.
            if P.LTag = True then
               P := P.Llink;
            else P := null;
            end if;
         else
            exit when Knt = 0;  -- Traveresed whole tree.
            P := Stack(Knt); V := StackDirection(Knt); Knt := Knt - 1;
            if V = 0 then
               Knt := Knt + 1;   Stack(Knt) := P; StackDirection(Knt) := 1;
               if P.RTag = True then
                  P := P.Rlink;
               else P := null;
               end if;
            else
               loop
                  put("tree sort "); Put_Line(Image(P.Info.all));--put(P.Info.all); new_line; --visit node.TODO: figure hot to ptint this
                  exit when Knt = 0;
                  P := Stack(Knt); V := StackDirection(Knt); Knt := Knt - 1;
                  if V = 0 then
                     Knt := Knt + 1;   Stack(Knt) := P; StackDirection(Knt) := 1;
                     if P.RTag = True then
                        P := P.Rlink;
                     else P := null;
                     end if;
                  end if;
                  exit when V=0;
               end loop;
            end if;
         end if;
      end loop;
   end;

  procedure PostOrderRecursive2(TreePoint: in BinarySearchTreePoint) is
   begin
      if TreePoint.Ltag then
         PostOrderRecursive2(TreePoint.Llink);
      end if;

      if TreePoint.Rtag then
         PostOrderRecursive2(TreePoint.Rlink);
      end if;

      Put_Line(Image(TreePoint.Info.all));
   end;

   procedure PostOrderRecursive(Root: in BinarySearchTreePoint) is
   begin
      if Root.Llink = Root then  --If Root.Llink points to itself, then the tree is empty
         Put_Line("No customer search possible. The tree is empty.");
      else
         PostOrderRecursive2(Root.Llink);
      end if;
   end;

   procedure ReverseInOrder(TreePoint: in BinarySearchTreePoint; Suc: out BinarySearchTreePoint) is --
   begin
      InOrderPredecessor(TreePoint, Suc);
   end;

   procedure PreOrderTraversalIterative(TreePoint: in BinarySearchTreePoint) is
      Stack: array(0..20) of BinarySearchTreePoint; --TODO: change/ balance tree requires logbase 2 of N space (N=# of nodes)
      Knt: integer := 0;
      P: BinarySearchTreePoint := TreePoint.Llink; --set stack empty/ P to tree point

   begin --VLR(visit/print, left, then right) --
      loop
         if P /= null then
            Put_Line(Image(P.Info.all));
            Knt := Knt + 1;   Stack(Knt) := P;   -- push location in stack.
            if P.LTag = True then
               P := P.Llink;
            else P := null;
            end if;
         else
            exit when Knt = 0;  -- Traveresed whole tree.
            P := Stack(Knt);    Knt := Knt - 1;
            if P.Rtag = True then
               P := P.RLink;
            else
               P := null;
            end if;
         end if;
      end loop;
      New_Line;
   end;
end;
