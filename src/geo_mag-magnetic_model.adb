--  SPDX-FileCopyrightText: 2025 Max Zakirov <ardo25968@gmail.com>
--
--  SPDX-License-Identifier: MIT
----------------------------------------------------------------

with Geo_Mag.Data; use Geo_Mag.Data;
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
      function Calculate_Index (N : Integer; M : Integer) return Integer
      renames Geo_Mag.Common.Calculate_Coef_Index;

      WMM_Map : constant Coefficient_Record_Array := Get_WMM_Ceofficients;

      Max_Degree      : constant Integer := WMM_Map (WMM_Map'Last).Degree;
      Model_Base_Year : constant Float := 2025.0;
      Mag_Model       :
        Geo_Mag.Data.Magnetic_Model (Calculate_Index (Max_Degree, Max_Degree));

      Index : Integer := 0;
   begin
      Mag_Model.Max_Degree := Max_Degree;
      Mag_Model.Base_Year := Model_Base_Year;

      for Row of WMM_Map loop
         Index := Calculate_Index (Row.Degree, Row.Order);

         Mag_Model.Gauss_Coeff_G (Index) := Row.Gauss_Coeff_G;
         Mag_Model.Gauss_Coeff_H (Index) := Row.Gauss_Coeff_H;
         Mag_Model.Secular_Var_G (Index) := Row.Secular_Var_G;
         Mag_Model.Secular_Var_H (Index) := Row.Secular_Var_H;
      end loop;

      return Mag_Model;
   end Build_Magnetic_Model;

   function Get_WMM_Ceofficients return Coefficient_Record_Array is
     ((1, 0, -29351.8, 0.0, 12.0, 0.0),
      (1, 1, -1410.8, 4545.4, 19.7, -21.5),
      (2, 0, -2556.6, 0.0, -11.6, 0.0),
      (2, 1, 2951.1, -3133.6, -5.2, -27.7),
      (2, 2, 1649.3, -815.1, -8.0, -12.1),
      (3, 0, 1361.0, 0.0, -1.3, 0.0),
      (3, 1, -2404.1, -56.6, -4.2, 4.0),
      (3, 2, 1243.8, 237.5, 0.4, -0.3),
      (3, 3, 453.6, -549.5, -15.6, -4.1),
      (4, 0, 895.0, 0.0, -1.6, 0.0),
      (4, 1, 799.5, 278.6, -2.4, -1.1),
      (4, 2, 55.7, -133.9, -6.0, 4.1),
      (4, 3, -281.1, 212.0, 5.6, 1.6),
      (4, 4, 12.1, -375.6, -7.0, -4.4),
      (5, 0, -233.2, 0.0, 0.6, 0.0),
      (5, 1, 368.9, 45.4, 1.4, -0.5),
      (5, 2, 187.2, 220.2, 0.0, 2.2),
      (5, 3, -138.7, -122.9, 0.6, 0.4),
      (5, 4, -142.0, 43.0, 2.2, 1.7),
      (5, 5, 20.9, 106.1, 0.9, 1.9),
      (6, 0, 64.4, 0.0, -0.2, 0.0),
      (6, 1, 63.8, -18.4, -0.4, 0.3),
      (6, 2, 76.9, 16.8, 0.9, -1.6),
      (6, 3, -115.7, 48.8, 1.2, -0.4),
      (6, 4, -40.9, -59.8, -0.9, 0.9),
      (6, 5, 14.9, 10.9, 0.3, 0.7),
      (6, 6, -60.7, 72.7, 0.9, 0.9),
      (7, 0, 79.5, 0.0, -0.0, 0.0),
      (7, 1, -77.0, -48.9, -0.1, 0.6),
      (7, 2, -8.8, -14.4, -0.1, 0.5),
      (7, 3, 59.3, -1.0, 0.5, -0.8),
      (7, 4, 15.8, 23.4, -0.1, 0.0),
      (7, 5, 2.5, -7.4, -0.8, -1.0),
      (7, 6, -11.1, -25.1, -0.8, 0.6),
      (7, 7, 14.2, -2.3, 0.8, -0.2),
      (8, 0, 23.2, 0.0, -0.1, 0.0),
      (8, 1, 10.8, 7.1, 0.2, -0.2),
      (8, 2, -17.5, -12.6, 0.0, 0.5),
      (8, 3, 2.0, 11.4, 0.5, -0.4),
      (8, 4, -21.7, -9.7, -0.1, 0.4),
      (8, 5, 16.9, 12.7, 0.3, -0.5),
      (8, 6, 15.0, 0.7, 0.2, -0.6),
      (8, 7, -16.8, -5.2, -0.0, 0.3),
      (8, 8, 0.9, 3.9, 0.2, 0.2),
      (9, 0, 4.6, 0.0, -0.0, 0.0),
      (9, 1, 7.8, -24.8, -0.1, -0.3),
      (9, 2, 3.0, 12.2, 0.1, 0.3),
      (9, 3, -0.2, 8.3, 0.3, -0.3),
      (9, 4, -2.5, -3.3, -0.3, 0.3),
      (9, 5, -13.1, -5.2, 0.0, 0.2),
      (9, 6, 2.4, 7.2, 0.3, -0.1),
      (9, 7, 8.6, -0.6, -0.1, -0.2),
      (9, 8, -8.7, 0.8, 0.1, 0.4),
      (9, 9, -12.9, 10.0, -0.1, 0.1),
      (10, 0, -1.3, 0.0, 0.1, 0.0),
      (10, 1, -6.4, 3.3, 0.0, 0.0),
      (10, 2, 0.2, 0.0, 0.1, -0.0),
      (10, 3, 2.0, 2.4, 0.1, -0.2),
      (10, 4, -1.0, 5.3, -0.0, 0.1),
      (10, 5, -0.6, -9.1, -0.3, -0.1),
      (10, 6, -0.9, 0.4, 0.0, 0.1),
      (10, 7, 1.5, -4.2, -0.1, 0.0),
      (10, 8, 0.9, -3.8, -0.1, -0.1),
      (10, 9, -2.7, 0.9, -0.0, 0.2),
      (10, 10, -3.9, -9.1, -0.0, -0.0),
      (11, 0, 2.9, 0.0, 0.0, 0.0),
      (11, 1, -1.5, 0.0, -0.0, -0.0),
      (11, 2, -2.5, 2.9, 0.0, 0.1),
      (11, 3, 2.4, -0.6, 0.0, -0.0),
      (11, 4, -0.6, 0.2, 0.0, 0.1),
      (11, 5, -0.1, 0.5, -0.1, -0.0),
      (11, 6, -0.6, -0.3, 0.0, -0.0),
      (11, 7, -0.1, -1.2, -0.0, 0.1),
      (11, 8, 1.1, -1.7, -0.1, -0.0),
      (11, 9, -1.0, -2.9, -0.1, 0.0),
      (11, 10, -0.2, -1.8, -0.1, 0.0),
      (11, 11, 2.6, -2.3, -0.1, 0.0),
      (12, 0, -2.0, 0.0, 0.0, 0.0),
      (12, 1, -0.2, -1.3, 0.0, -0.0),
      (12, 2, 0.3, 0.7, -0.0, 0.0),
      (12, 3, 1.2, 1.0, -0.0, -0.1),
      (12, 4, -1.3, -1.4, -0.0, 0.1),
      (12, 5, 0.6, -0.0, -0.0, -0.0),
      (12, 6, 0.6, 0.6, 0.1, -0.0),
      (12, 7, 0.5, -0.1, -0.0, -0.0),
      (12, 8, -0.1, 0.8, 0.0, 0.0),
      (12, 9, -0.4, 0.1, 0.0, -0.0),
      (12, 10, -0.2, -1.0, -0.1, -0.0),
      (12, 11, -1.3, 0.1, -0.0, 0.0),
      (12, 12, -0.7, 0.2, -0.1, -0.1));

end Geo_Mag.Magnetic_Model;
