with Ada.Strings;
with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Float_Text_IO;
with Geo_Mag.Data;
with Ada.Strings.Fixed;
with Geo_Mag.Common;

function Geo_Mag.Magnetic_Model.Read return Geo_Mag.Data.Magnetic_Model is
   use Ada.Text_IO;
   use Ada.Integer_Text_IO;
   use Ada.Float_Text_IO;
   use Geo_Mag.Data;
   use Geo_Mag.Common;

   pragma Extensions_Allowed (All_Extensions);
   WMM_File_Content    : constant String
   with External_Initialization => "Embedded_Files/WMM.COF";
   Next_Row_Index   : Natural := WMM_File_Content'First;
   End_Of_File_Pattern : String := "99999999";
   New_Line_String     : constant String := (1 => ASCII.LF);
   Row_Size : Natural :=
     Ada.Strings.Fixed.Index
       (Source  => WMM_File_Content,
        Pattern => New_Line_String,
        From    => Next_Row_Index);
   Current_Row : String (1 .. Row_Size);

   function Is_End_Of_File_Row (Row : String) return Boolean is
      Result : Boolean;
   begin
      return Row (Row'First .. Row'First + End_Of_File_Pattern'Last - 1) = End_Of_File_Pattern;
   end;

   function Read_Next_Row return String is
      End_Of_Row : Natural :=
        Ada.Strings.Fixed.Index
          (Source  => WMM_File_Content,
           Pattern => New_Line_String,
           From    => Next_Row_Index);
      Next_Raw   : String :=
        WMM_File_Content (Next_Row_Index .. End_Of_Row);
   begin
      Next_Row_Index := End_Of_Row + 1;
      return Next_Raw;
   end Read_Next_Row;

   -- MAXTODO: Improve performance?
   function Find_Max_Degree return Integer is
      Max_Degree, Current_Degree, Last_Read : Integer := 0;
      Next_Row                              : String := Read_Next_Row;
   begin
      Next_Row := Read_Next_Row; -- Skip Dates raw
      while not Is_End_Of_File_Row (Next_Row) loop
         Get (From => Next_Row, Last => Last_Read, Item => Current_Degree);

         if Max_Degree < Current_Degree then
            Max_Degree := Current_Degree;
         end if;

         Next_Row := Read_Next_Row; -- Skip Dates raw
      end loop;

      return Max_Degree;
   end Find_Max_Degree;

   procedure Parse_Current_Row
     (Degree, Order                : out Integer;
      Gauss_Coeff_G, Gauss_Coeff_H : out Nanoteslas;
      Secular_Var_G, Secular_Var_H : out Nanoteslas_Per_Year)
   is
      Last_Pos : Integer := Current_Row'First;

      function Get_Next_Float return Float is
         Temp_Float_Value : Float;
      begin
         Get
           (From => Current_Row (Last_Pos + 1 .. Current_Row'Last),
            Last => Last_Pos,
            Item => Temp_Float_Value);
         return Temp_Float_Value;
      end Get_Next_Float;
   begin
      Get (From => Current_Row, Last => Last_Pos, Item => Degree);
      Get
        (From => Current_Row (Last_Pos + 1 .. Current_Row'Last),
         Last => Last_Pos,
         Item => Order);

      --  Put ("N " & Degree'Image & " M " & Order'Image);
      Gauss_Coeff_G := Nanoteslas (Get_Next_Float);
      --  Put (" Gauss_Coeff_G " & Gauss_Coeff_G'Image);
      Gauss_Coeff_H := Nanoteslas (Get_Next_Float);
      -- Put (" Gauss_Coeff_H " & Gauss_Coeff_H'Image);
      Secular_Var_G := Nanoteslas_Per_Year (Get_Next_Float);
      -- Put (" Secular_Var_G " & Secular_Var_G'Image);
      Secular_Var_H := Nanoteslas_Per_Year (Get_Next_Float);
      -- Put_Line (" Secular_Var_H " & Secular_Var_H'Image);
   end Parse_Current_Row;

   function Extract_Base_Year (Years_Row : String) return Float is
      Model_Base_Year : Float;
      Last_Index      : Integer;
   begin
      Get (From => Years_Row, Item => Model_Base_Year, Last => Last_Index);

      return Model_Base_Year;
   end Extract_Base_Year;

   Max_Degree  : Integer := Find_Max_Degree;
   Coef_Amount : Integer := Calculate_Coef_Index (Max_Degree, Max_Degree);
   Read_Model  : Geo_Mag.Data.Magnetic_Model (Coef_Amount);
begin
   Next_Row_Index := WMM_File_Content'First;
   Current_Row := Read_Next_Row;
   Read_Model.Base_Year := Extract_Base_Year (Current_Row);
   Read_Model.Max_Degree := Max_Degree;
   Read_Model.Max_Degree_Sec_Var := Max_Degree;
   Current_Row := Read_Next_Row;

   while not Is_End_Of_File_Row (Current_Row) loop
      declare
         Index      : Integer;
         N          : Integer; -- Degree of the spherical harmonic
         M          : Integer; -- Order of harmonic
         GNM, HMN   : Nanoteslas;
         DGNM, DHNM : Nanoteslas_Per_Year;
      begin
         if Is_End_Of_File_Row (Current_Row) then
            exit;
         end if;

         Parse_Current_Row (N, M, GNM, HMN, DGNM, DHNM);
         Index := Calculate_Coef_Index (N, M);

         Read_Model.Gauss_Coeff_G (Index) := GNM;
         Read_Model.Gauss_Coeff_H (Index) := HMN;
         Read_Model.Secular_Var_G (Index) := DGNM;
         Read_Model.Secular_Var_H (Index) := DHNM;
      end;
      Current_Row := Read_Next_Row;
   end loop;

   return Read_Model;
end Geo_Mag.Magnetic_Model.Read;
