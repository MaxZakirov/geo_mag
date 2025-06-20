package Geo_Mag.Common is
   function Radians_To_Degrees (Radians : Float) return Float;

   function Degrees_To_Radians (Degrees : Float) return Float;

   function Calculate_Coef_Index (Degree : Integer; Order : Integer) return Integer;
end Geo_Mag.Common;