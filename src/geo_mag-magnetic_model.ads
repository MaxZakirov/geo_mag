--  SPDX-FileCopyrightText: 2025 Max Zakirov <ardo25968@gmail.com>
--
--  SPDX-License-Identifier: MIT
----------------------------------------------------------------

with Geo_Mag.Data;
with Ada.Containers;
with Ada.Containers.Hashed_Maps;

private package Geo_Mag.Magnetic_Model is
   function Timely_Adjust_Magnetic_Model
     (Input_Years : Float; Base_Model : Geo_Mag.Data.Magnetic_Model)
      return Geo_Mag.Data.Magnetic_Model;

   function Build_Magnetic_Model return Geo_Mag.Data.Magnetic_Model;

private

   type Coefficients_Values is array (1 .. 4) of Float;

   function Hash_Int (Key : Integer) return Ada.Containers.Hash_Type;

   package WMM_Coefficients_Map is new
     Ada.Containers.Hashed_Maps
       (Key_Type        => Integer,
        Element_Type    => Coefficients_Values,
        Hash            => Hash_Int,
        Equivalent_Keys => "=");

   function Get_WMM_Ceofficients return WMM_Coefficients_Map.Map;
end Geo_Mag.Magnetic_Model;
