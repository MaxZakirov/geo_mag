--  SPDX-FileCopyrightText: 2025 Max Zakirov <ardo25968@gmail.com>
--
--  SPDX-License-Identifier: MIT
----------------------------------------------------------------

with Geo_Mag.Data;

private package Geo_Mag.Magnetic_Model is
   --  Time change the Model coefficients from the base year
   --  of the model using secular variation coefficients.
   --  Store the coefficients of the static model with their
   --  values advanced from epoch t0 to epoch t.
   --  Copy the SV coefficients. If input "t�" is the same as "t0",
   --  then this is merely a copy operation.
   function Timely_Adjust_Magnetic_Model
     (Input_Years : Float; Base_Model : Geo_Mag.Data.Magnetic_Model)
      return Geo_Mag.Data.Magnetic_Model;

   function Build_Magnetic_Model return Geo_Mag.Data.Magnetic_Model;

private

   type Coefficient_Record is record
      Degree        : Integer;
      Order         : Integer;
      Gauss_Coeff_G : Geo_Mag.Data.Nanoteslas;
      Gauss_Coeff_H : Geo_Mag.Data.Nanoteslas;
      Secular_Var_G : Geo_Mag.Data.Nanoteslas_Per_Year;
      Secular_Var_H : Geo_Mag.Data.Nanoteslas_Per_Year;
   end record;

   type Coefficient_Record_Array is array (Positive range <>) of
     Coefficient_Record;

   function Get_WMM_Ceofficients return Coefficient_Record_Array;
end Geo_Mag.Magnetic_Model;
