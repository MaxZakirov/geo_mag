--  SPDX-FileCopyrightText: 2025 Max Zakirov <ardo25968@gmail.com>
--
--  SPDX-License-Identifier: MIT
----------------------------------------------------------------

pragma Ada_2022;

private package Geo_Mag.Common is
   function Radians_To_Degrees (Radians : Float) return Float;

   function Degrees_To_Radians (Degrees : Float) return Float;

      function Calculate_Coef_Index
     (Degree : Integer; Order : Integer) return Integer is
       (Degree * (Degree + 1) / 2 + Order)
          with Static;
end Geo_Mag.Common;