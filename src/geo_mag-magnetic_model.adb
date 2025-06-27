with Geo_Mag.Data; use Geo_Mag.Data;
with Ada.Text_IO;  use Ada.Text_IO;
with Geo_Mag.Common;

package body Geo_Mag.Magnetic_Model is
   function Timely_Adjust_Magnetic_Model
     (Input_Years : Float; Base_Model : Geo_Mag.Data.Magnetic_Model)
      return Geo_Mag.Data.Magnetic_Model
   is
      Adjusted_Model : Geo_Mag.Data.Magnetic_Model (Base_Model.Length);
   begin
      for I in 1 .. Base_Model.Length loop
         Adjusted_Model.Gauss_Coeff_G (I) :=
           Base_Model.Gauss_Coeff_G (I)
           + Nanoteslas
               ((Input_Years - Base_Model.Base_Year)
                * Float (Base_Model.Secular_Var_G (I)));

         Adjusted_Model.Gauss_Coeff_H (I) :=
           Base_Model.Gauss_Coeff_H (I)
           + Nanoteslas
               ((Input_Years - Base_Model.Base_Year)
                * Float (Base_Model.Secular_Var_H (I)));

         Adjusted_Model.Secular_Var_G (I) := Base_Model.Secular_Var_G (I);
         Adjusted_Model.Secular_Var_H (I) := Base_Model.Secular_Var_H (I);

      end loop;

      Adjusted_Model.Base_Year := Base_Model.Base_Year;
      Adjusted_Model.Max_Degree := Base_Model.Max_Degree;

      return Adjusted_Model;
   end Timely_Adjust_Magnetic_Model;

   function Build_Magnetic_Model return Geo_Mag.Data.Magnetic_Model is
      use WMM_Coefficients_Map;
      function Calculate_Index (N : Integer; M : Integer) return Integer 
         renames Geo_Mag.Common.Calculate_Coef_Index;

      WMM_Map : Map := Get_WMM_Ceofficients;

      function Get_Max_Degree return Integer is
      begin
         for I in 1 .. Integer'Last loop
            if not Contains (WMM_Map, (I + 1) * 100) then
               return I;
            end if;
         end loop;
      end Get_Max_Degree;

      Max_Degree : Integer := Get_Max_Degree;
      Model_Base_Year : Float := 2025.0;
      Mag_Model  : Geo_Mag.Data.Magnetic_Model (Calculate_Index (Max_Degree, Max_Degree));
      Map_Cursor : Cursor := First (WMM_Map);
      Model_Row : Coefficients_Values;

      Order, Degree, Index : Integer := 0;
   begin
      Mag_Model.Max_Degree := Max_Degree;
      Mag_Model.Base_Year := Model_Base_Year;

      while Has_Element (Map_Cursor) loop
         Degree := Key (Map_Cursor) / 100;
         Order := Key (Map_Cursor) rem 100;

         Index := Calculate_Index (Degree, Order);
         Model_Row := Element (Map_Cursor);
         Mag_Model.Gauss_Coeff_G (Index) := Nanoteslas (Model_Row (1));
         Mag_Model.Gauss_Coeff_H (Index) := Nanoteslas (Model_Row (2));
         Mag_Model.Secular_Var_G (Index) := Nanoteslas_Per_Year (Model_Row (3));
         Mag_Model.Secular_Var_H (Index) := Nanoteslas_Per_Year (Model_Row (4));

         Next (Map_Cursor);
      end loop;

      return Mag_Model;
   end Build_Magnetic_Model;

   function Hash_Int (Key : Integer) return Ada.Containers.Hash_Type is
   begin
      return Ada.Containers.Hash_Type (Key);
   end Hash_Int;

   function Get_WMM_Ceofficients return WMM_Coefficients_Map.Map is
      use WMM_Coefficients_Map;

      Map : WMM_Coefficients_Map.Map;
   begin
      Map.Reserve_Capacity (Ada.Containers.Count_Type(90));
      Map.Insert (1_00, (-29351.8, 0.0, 12.0, 0.0));
      Map.Insert (1_01, (-1410.8, 4545.4, 19.7, -21.5));
      Map.Insert (2_00, (-2556.6, 0.0, -11.6, 0.0));
      Map.Insert (2_01, (2951.1, -3133.6, -5.2, -27.7));
      Map.Insert (2_02, (1649.3, -815.1, -8.0, -12.1));
      Map.Insert (3_00, (1361.0, 0.0, -1.3, 0.0));
      Map.Insert (3_01, (-2404.1, -56.6, -4.2, 4.0));
      Map.Insert (3_02, (1243.8, 237.5, 0.4, -0.3));
      Map.Insert (3_03, (453.6, -549.5, -15.6, -4.1));
      Map.Insert (4_00, (895.0, 0.0, -1.6, 0.0));
      Map.Insert (4_01, (799.5, 278.6, -2.4, -1.1));
      Map.Insert (4_02, (55.7, -133.9, -6.0, 4.1));
      Map.Insert (4_03, (-281.1, 212.0, 5.6, 1.6));
      Map.Insert (4_04, (12.1, -375.6, -7.0, -4.4));
      Map.Insert (5_00, (-233.2, 0.0, 0.6, 0.0));
      Map.Insert (5_01, (368.9, 45.4, 1.4, -0.5));
      Map.Insert (5_02, (187.2, 220.2, 0.0, 2.2));
      Map.Insert (5_03, (-138.7, -122.9, 0.6, 0.4));
      Map.Insert (5_04, (-142.0, 43.0, 2.2, 1.7));
      Map.Insert (5_05, (20.9, 106.1, 0.9, 1.9));
      Map.Insert (6_00, (64.4, 0.0, -0.2, 0.0));
      Map.Insert (6_01, (63.8, -18.4, -0.4, 0.3));
      Map.Insert (6_02, (76.9, 16.8, 0.9, -1.6));
      Map.Insert (6_03, (-115.7, 48.8, 1.2, -0.4));
      Map.Insert (6_04, (-40.9, -59.8, -0.9, 0.9));
      Map.Insert (6_05, (14.9, 10.9, 0.3, 0.7));
      Map.Insert (6_06, (-60.7, 72.7, 0.9, 0.9));
      Map.Insert (7_00, (79.5, 0.0, -0.0, 0.0));
      Map.Insert (7_01, (-77.0, -48.9, -0.1, 0.6));
      Map.Insert (7_02, (-8.8, -14.4, -0.1, 0.5));
      Map.Insert (7_03, (59.3, -1.0, 0.5, -0.8));
      Map.Insert (7_04, (15.8, 23.4, -0.1, 0.0));
      Map.Insert (7_05, (2.5, -7.4, -0.8, -1.0));
      Map.Insert (7_06, (-11.1, -25.1, -0.8, 0.6));
      Map.Insert (7_07, (14.2, -2.3, 0.8, -0.2));
      Map.Insert (8_00, (23.2, 0.0, -0.1, 0.0));
      Map.Insert (8_01, (10.8, 7.1, 0.2, -0.2));
      Map.Insert (8_02, (-17.5, -12.6, 0.0, 0.5));
      Map.Insert (8_03, (2.0, 11.4, 0.5, -0.4));
      Map.Insert (8_04, (-21.7, -9.7, -0.1, 0.4));
      Map.Insert (8_05, (16.9, 12.7, 0.3, -0.5));
      Map.Insert (8_06, (15.0, 0.7, 0.2, -0.6));
      Map.Insert (8_07, (-16.8, -5.2, -0.0, 0.3));
      Map.Insert (8_08, (0.9, 3.9, 0.2, 0.2));
      Map.Insert (9_00, (4.6, 0.0, -0.0, 0.0));
      Map.Insert (9_01, (7.8, -24.8, -0.1, -0.3));
      Map.Insert (9_02, (3.0, 12.2, 0.1, 0.3));
      Map.Insert (9_03, (-0.2, 8.3, 0.3, -0.3));
      Map.Insert (9_04, (-2.5, -3.3, -0.3, 0.3));
      Map.Insert (9_05, (-13.1, -5.2, 0.0, 0.2));
      Map.Insert (9_06, (2.4, 7.2, 0.3, -0.1));
      Map.Insert (9_07, (8.6, -0.6, -0.1, -0.2));
      Map.Insert (9_08, (-8.7, 0.8, 0.1, 0.4));
      Map.Insert (9_09, (-12.9, 10.0, -0.1, 0.1));
      Map.Insert (10_00, (-1.3, 0.0, 0.1, 0.0));
      Map.Insert (10_01, (-6.4, 3.3, 0.0, 0.0));
      Map.Insert (10_02, (0.2, 0.0, 0.1, -0.0));
      Map.Insert (10_03, (2.0, 2.4, 0.1, -0.2));
      Map.Insert (10_04, (-1.0, 5.3, -0.0, 0.1));
      Map.Insert (10_05, (-0.6, -9.1, -0.3, -0.1));
      Map.Insert (10_06, (-0.9, 0.4, 0.0, 0.1));
      Map.Insert (10_07, (1.5, -4.2, -0.1, 0.0));
      Map.Insert (10_08, (0.9, -3.8, -0.1, -0.1));
      Map.Insert (10_09, (-2.7, 0.9, -0.0, 0.2));
      Map.Insert (10_10, (-3.9, -9.1, -0.0, -0.0));
      Map.Insert (11_00, (2.9, 0.0, 0.0, 0.0));
      Map.Insert (11_01, (-1.5, 0.0, -0.0, -0.0));
      Map.Insert (11_02, (-2.5, 2.9, 0.0, 0.1));
      Map.Insert (11_03, (2.4, -0.6, 0.0, -0.0));
      Map.Insert (11_04, (-0.6, 0.2, 0.0, 0.1));
      Map.Insert (11_05, (-0.1, 0.5, -0.1, -0.0));
      Map.Insert (11_06, (-0.6, -0.3, 0.0, -0.0));
      Map.Insert (11_07, (-0.1, -1.2, -0.0, 0.1));
      Map.Insert (11_08, (1.1, -1.7, -0.1, -0.0));
      Map.Insert (11_09, (-1.0, -2.9, -0.1, 0.0));
      Map.Insert (11_10, (-0.2, -1.8, -0.1, 0.0));
      Map.Insert (11_11, (2.6, -2.3, -0.1, 0.0));
      Map.Insert (12_00, (-2.0, 0.0, 0.0, 0.0));
      Map.Insert (12_01, (-0.2, -1.3, 0.0, -0.0));
      Map.Insert (12_02, (0.3, 0.7, -0.0, 0.0));
      Map.Insert (12_03, (1.2, 1.0, -0.0, -0.1));
      Map.Insert (12_04, (-1.3, -1.4, -0.0, 0.1));
      Map.Insert (12_05, (0.6, -0.0, -0.0, -0.0));
      Map.Insert (12_06, (0.6, 0.6, 0.1, -0.0));
      Map.Insert (12_07, (0.5, -0.1, -0.0, -0.0));
      Map.Insert (12_08, (-0.1, 0.8, 0.0, 0.0));
      Map.Insert (12_09, (-0.4, 0.1, 0.0, -0.0));
      Map.Insert (12_10, (-0.2, -1.0, -0.1, -0.0));
      Map.Insert (12_11, (-1.3, 0.1, -0.0, 0.0));
      Map.Insert (12_12, (-0.7, 0.2, -0.1, -0.1));

      return Map;
   end Get_WMM_Ceofficients;

end Geo_Mag.Magnetic_Model;
