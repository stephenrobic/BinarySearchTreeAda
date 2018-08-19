----------RecordTypes.adb----------
with Ada.Text_IO;
use Ada.Text_IO; with Ada.Unchecked_Deallocation;
--with Ada.Characters.Handling; --use Ada.Characters.Handling;

package body RecordTypes is

   function Get_Key(C : Customer) return String10 is
   begin
      return C.Name;
   end;

   function Get_Number(C : Customer) return String10 is
   begin
      return C.Number;
   end;

   function Image(C : Customer) return String is
   begin
      return String(C.Name) & ", " & String(C.Number);
   end;

----------------- print command to output Customer Info----------------------
   procedure Print(C : in Customer) is
   begin
      Put("A customer with name " & String(C.Name) & " and phone# " & String(C.Number));
   end Print;

begin
   null;

end RecordTypes;
