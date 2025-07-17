--  SPDX-FileCopyrightText: 2025 Max Zakirov <ardo25968@gmail.com>
--
--  SPDX-License-Identifier: MIT
----------------------------------------------------------------

with Geo_Mag.Data; use Geo_Mag.Data;
with Geo_Mag.Common;
with Ada.Numerics.Elementary_Functions;

--  Computes  all of the Schmidt-semi normalized associated Legendre
--  functions up to degree nMax.
--  PLEASE NOTE: this function should be used only for nMax <= 16

function Geo_Mag.Math.Compute_ALF
  (Spherical_Coordinates : Geocentric_Coordinates; Max_Degree : Integer)
   return Associated_Legendre_Functions
is
   use Ada.Numerics.Elementary_Functions;
   use Geo_Mag.Common;

   X, Z, K                   : Float;
   Pcup                      : Legendre_Functions_Array (0 .. Model_Max_Index);
   Derivative_Pcup           : Legendre_Functions_Array (0 .. Model_Max_Index);
   Schmidt_Quasi_Norm        : Legendre_Functions_Array (0 .. Model_Max_Index);
   Index_I, Index_J, Index_L : Integer;
begin
   X := Sin (Degrees_To_Radians (Spherical_Coordinates.Phig));
   Z := Sqrt ((1.0 - X) * (1.0 + X));

   Pcup (0) := 1.0;
   Derivative_Pcup (0) := 0.0;
   --  MAXTODO: think about Max_Degree should be < 16

   for Degree in 1 .. Max_Degree loop
      for Order in 0 .. Degree loop
         Index_I := Calculate_Coef_Index (Degree, Order);

         if Degree = Order then
            Index_J := Calculate_Coef_Index (Degree - 1, Order - 1);
            Pcup (Index_I) := Z * Pcup (Index_J);
            Derivative_Pcup (Index_I) :=
              Z * Derivative_Pcup (Index_J) + X * Pcup (Index_J);
         elsif Degree = 1 and then Order = 0 then
            Index_J := Calculate_Coef_Index (Degree - 1, Order);
            Pcup (Index_I) := X * Pcup (Index_J);
            Derivative_Pcup (Index_I) :=
              X * Derivative_Pcup (Index_J) - Z * Pcup (Index_J);
         elsif Degree > 1 and then Degree /= Order then
            Index_J := Calculate_Coef_Index (Degree - 2, Order);
            Index_L := Calculate_Coef_Index (Degree - 1, Order);

            if Order > Degree - 2 then
               Pcup (Index_I) := X * Pcup (Index_L);
               Derivative_Pcup (Index_I) :=
                 X * Derivative_Pcup (Index_L) - Z * Pcup (Index_L);
            else
               K :=
                 Float ((Degree - 1)**2 - Order**2)
                 / Float ((2 * Degree - 1) * (2 * Degree - 3));

               Pcup (Index_I) := X * Pcup (Index_L) - K * Pcup (Index_J);
               Derivative_Pcup (Index_I) :=
                 X
                 * Derivative_Pcup (Index_L)
                 - Z * Pcup (Index_L)
                 - K * Derivative_Pcup (Index_J);
            end if;
         end if;

      end loop;
   end loop;

   --  Compute the ration between the the Schmidt quasi-normalized
   --  associated Legendre functions and the Gauss-normalized version.
   Schmidt_Quasi_Norm (0) := 1.0;

   for Degree in 1 .. Max_Degree loop
      Index_I := Calculate_Coef_Index (Degree, 0);
      Index_J := Calculate_Coef_Index (Degree - 1, 0);

      Schmidt_Quasi_Norm (Index_I) :=
        Schmidt_Quasi_Norm (Index_J) * Float (2 * Degree - 1) / Float (Degree);
      for Order in 1 .. Degree loop
         Index_I := Calculate_Coef_Index (Degree, Order);
         Index_J := Calculate_Coef_Index (Degree, Order - 1);

         K := Float (Degree - Order + 1) / Float (Degree + Order);

         if Order = 1 then
            K := K * 2.0;
         end if;
         K := Sqrt (K);

         Schmidt_Quasi_Norm (Index_I) := Schmidt_Quasi_Norm (Index_J) * K;
      end loop;
   end loop;

   --  Converts the  Gauss-normalized associated Legendre
   --  functions to the Schmidt quasi-normalized version using pre-computed
   --  relation stored in the variable schmidtQuasiNorm
   for Degree in 1 .. Max_Degree loop
      for Order in 0 .. Degree loop
         Index_I := Calculate_Coef_Index (Degree, Order);
         Pcup (Index_I) := Pcup (Index_I) * Schmidt_Quasi_Norm (Index_I);
         Derivative_Pcup (Index_I) :=
           -Derivative_Pcup (Index_I) * Schmidt_Quasi_Norm (Index_I);
         --  The sign is changed since the new WMM routines use derivative
         --  with respect to latitude insted of co-latitude
      end loop;
   end loop;

   return
     (Pcup            => Pcup,
      Derivative_Pcup => Derivative_Pcup);
end Geo_Mag.Math.Compute_ALF;
