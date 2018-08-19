----------BinarySearchTree.ads----------
generic
   type Akey is private;
   type BinarySearchTreeRecord is private;
   with function "<"(K1, K2 : Akey) return Boolean is <>; --is the first key less than the second?
   with function ">"(K1, K2 : Akey) return Boolean is <>; --is the first key greater than the second?
   with function "="(K1, K2 : Akey) return Boolean is <>; --is the first key equal to the second?
   with function Get_Key(R : BinarySearchTreeRecord) return AKey is <>;
   with function Image(R: BinarySearchTreeRecord) return String is <>;

package BinarySearchTree is
   type BinarySearchTreePoint is limited private;

   type BinarySearchTreeRecordPoint is access all BinarySearchTreeRecord;

   procedure Print_Record(R: BinarySearchTreeRecord);

   function Make_Node(R : in BinarySearchTreeRecordPoint) return BinarySearchTreePoint;

   procedure Init_Tree(Root: in out BinarySearchTreePoint; EmptyRec: in BinarySearchTreeRecordPoint);

   procedure InsertBinarySearchTree(Root: in out BinarySearchTreePoint; TreeRecord: BinarySearchTreeRecordPoint);

   procedure DeleteRandomNode(Root: in BinarySearchTreePoint; CustomerName:  in Akey);

   procedure FindCustomerIterative(Root: in BinarySearchTreePoint;
                                   CustomerName:  in Akey;
                                   CustomerPoint:  out BinarySearchTreeRecordPoint;
                                   NodePoint: out BinarySearchTreePoint);

   procedure FindCustomerRecursive(Root: in BinarySearchTreePoint;
                                   CustomerName:  in Akey;
                                   CustomerPoint:  out BinarySearchTreeRecordPoint);
   procedure FindCustomerRecursive2(Root: in BinarySearchTreePoint;
                                   CustomerName:  in Akey;
                                   CustomerPoint:  out BinarySearchTreeRecordPoint);

   procedure InOrderSuccessor(TreePoint: in BinarySearchTreePoint; Successor: out BinarySearchTreePoint);

   procedure InOrderPredecessor(TreePoint: in BinarySearchTreePoint; Pred: out BinarySearchTreePoint);

   -- Access functions to return customer names and phone numbers.
   function Record_of_Node(TreePoint: in BinarySearchTreePoint) return BinarySearchTreeRecordPoint;

   procedure PreOrder(TreePoint: in out BinarySearchTreePoint);

   procedure PostOrderIterative(TreePoint: in out BinarySearchTreePoint);
   procedure PostOrderRecursive(Root: in BinarySearchTreePoint);

   procedure ReverseInOrder(TreePoint: in BinarySearchTreePoint; Suc: out BinarySearchTreePoint);

   procedure PreOrderTraversalIterative(TreePoint: in BinarySearchTreePoint);

private
   type Node;
   type BinarySearchTreePoint is access Node;
   type Node is record
      Llink, Rlink:  BinarySearchTreePoint;
      Ltag, Rtag:  Boolean;  -- True indicates pointer to child/lower level, False a thread.
      Info:  BinarySearchTreeRecordPoint; --same as BinarySearchTreeRecordPoint
   end record;
end BinarySearchTree;
