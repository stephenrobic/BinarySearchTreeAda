----------RecordTypes.ads----------
with Ada.Text_IO; use Ada.Text_IO;

package RecordTypes is

   --type Records is tagged null record;
   type String10 is new String(1..10);

   type Customer is record
      Name: String10;
      Number: String10;
   end record;

   function Get_Key(C : Customer) return String10;
   function Get_Number(C : Customer) return String10;
   function Image(C : Customer) return String;

   procedure Print(C : in Customer);

end RecordTypes;
