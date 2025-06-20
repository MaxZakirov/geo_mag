with Ada.Numerics;

package body Geo_Mag.Common is
   function Radians_To_Degrees (Radians : Float) return Float is
   begin
      return Radians * 180.0 / Ada.Numerics.Pi;
   end Radians_To_Degrees;

   function Degrees_To_Radians (Degrees : Float) return Float is
   begin
      return Degrees * (Ada.Numerics.Pi / 180.0);
   end Degrees_To_Radians;

   function Calculate_Coef_Index
     (Degree : Integer; Order : Integer) return Integer is
   begin
      return Degree * (Degree + 1) / 2 + Order;
   end;
end Geo_Mag.Common;

