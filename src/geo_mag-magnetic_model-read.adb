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

   Cof_File_Name : String := "./WMM.COF";
   File          : File_Type;
   Current_Row   : String (1 .. 48);

   function Is_End_Of_File_Row (Row : String) return Boolean is
   begin
      return Row (1 .. 6) = "999999";
   end;

   function Find_Max_Degree return Integer is
      Max_Degree     : Integer := 0;
      Current_Degree : Integer := 0;
      Last_Read      : Integer;
   begin
      Open (File => File, Mode => In_File, Name => Cof_File_Name);
      Get (File, Current_Row); -- skip Date row

      while not End_Of_File (File) loop
         Get (File, Current_Row);

         if Is_End_Of_File_Row (Current_Row) then
            exit;
         end if;

         Get
           (From => Current_Row (1 .. 6),
            Last => Last_Read,
            Item => Current_Degree);

         if Max_Degree < Current_Degree then
            Max_Degree := Current_Degree;
         end if;
      end loop;

      Close (File);

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

      Gauss_Coeff_G := Nanoteslas (Get_Next_Float);
      Gauss_Coeff_H := Nanoteslas (Get_Next_Float);
      Secular_Var_G := Nanoteslas_Per_Year (Get_Next_Float);
      Secular_Var_H := Nanoteslas_Per_Year (Get_Next_Float);
   end Parse_Current_Row;

   function Extract_Base_Year (File : File_Type) return Float is
      Date_Row        : String (1 .. 48);
      Model_Base_Year : Float;
      Last_Index      : Integer;
   begin
      Get (File, Date_Row);

      Get (From => Date_Row, Item => Model_Base_Year, Last => Last_Index);

      return Model_Base_Year;
   end Extract_Base_Year;

   Max_Degree  : Integer := Find_Max_Degree;
   Coef_Amount : Integer :=
     Calculate_Coef_Index (Max_Degree, Max_Degree);
   Read_Model  : Geo_Mag.Data.Magnetic_Model (Coef_Amount);
begin
   Open (File => File, Mode => In_File, Name => Cof_File_Name);

   Read_Model.Base_Year := Extract_Base_Year (File);
   Read_Model.Max_Degree := Max_Degree;
   Read_Model.Max_Degree_Sec_Var := Max_Degree;

   while not End_Of_File (File) loop
      Get (File, Current_Row);

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
   end loop;

   Close (File);

   return Read_Model;
end Geo_Mag.Magnetic_Model.Read;
