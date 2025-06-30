--  SPDX-FileCopyrightText: 2025 Max Zakirov <ardo25968@gmail.com>
--
--  SPDX-License-Identifier: MIT
----------------------------------------------------------------

with Geo_Mag.Common;                    use Geo_Mag.Common;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;

package body Geo_Mag.Math is
   function Compute_Field_Elements
     (ALF                   : Associated_Legendre_Functions;
      Mag_Model             : Magnetic_Model;
      Spherical_Harmonics   : Spherical_Harmonic_Variables;
      Spherical_Coordinates : Geocentric_Coordinates) return Magnetic_Vector
   is
      Field_Elements                      : Magnetic_Vector;
      Index                               : Integer;
      Cos_Phi, Coef_G_Float, Coef_H_Float : Float;
   begin
      for Degree in 1 .. Mag_Model.Max_Degree loop
         for Order in 0 .. Degree loop
            Index := Calculate_Coef_Index (Degree, Order);
            Coef_G_Float := Float (Mag_Model.Gauss_Coeff_G (Index));
            Coef_H_Float := Float (Mag_Model.Gauss_Coeff_H (Index));

            Field_Elements.Bz :=
              Field_Elements.Bz
              - ((Spherical_Harmonics.Relative_Radius_Power (Degree)
                  * Coef_G_Float
                  * Spherical_Harmonics.Cos_M_Labmda (Order)
                  + Coef_H_Float * Spherical_Harmonics.Sin_M_Labmda (Order))
                 * Float (Degree + 1)
                 * ALF.Pcup (Index));

            Field_Elements.By :=
              Field_Elements.By
              + (Spherical_Harmonics.Relative_Radius_Power (Degree)
                 * (Coef_G_Float
                    * Spherical_Harmonics.Sin_M_Labmda (Order)
                    - Coef_H_Float * Spherical_Harmonics.Cos_M_Labmda (Order))
                 * Float (Order)
                 * ALF.Pcup (Index));

            Field_Elements.Bx :=
              Field_Elements.Bx
              - (Spherical_Harmonics.Relative_Radius_Power (Degree)
                 * (Coef_G_Float
                    * Spherical_Harmonics.Cos_M_Labmda (Order)
                    + Coef_H_Float * Spherical_Harmonics.Sin_M_Labmda (Order))
                 * ALF.Derivative_Pcup (Index));
         end loop;
      end loop;

      Cos_Phi := Cos (Degrees_To_Radians (Spherical_Coordinates.Phig));
      Field_Elements.By := Field_Elements.By / Cos_Phi;

      return Field_Elements;
   end Compute_Field_Elements;

   function Compute_Spherical_Harmonics
     (Ellipsoid_Parameters  : WGS84_Ellipsoid_Parameters;
      Spherical_Coordinates : Geocentric_Coordinates;
      Max_Degree            : Integer) return Spherical_Harmonic_Variables
   is
      Output_Variables : Spherical_Harmonic_Variables (Max_Degree);
      Cos_Lamda        : constant Float :=
        Cos (Degrees_To_Radians (Spherical_Coordinates.Lambda));
      Sin_Lamda        : constant Float :=
        Sin (Degrees_To_Radians (Spherical_Coordinates.Lambda));
   begin
      Output_Variables.Relative_Radius_Power (0) :=
        Float ((Ellipsoid_Parameters.R / Spherical_Coordinates.R)**2);

      for N in 1 .. Max_Degree loop
         Output_Variables.Relative_Radius_Power (N) :=
           Output_Variables.Relative_Radius_Power (N - 1)
           * Float ((Ellipsoid_Parameters.R / Spherical_Coordinates.R));
      end loop;

      Output_Variables.Cos_M_Labmda (0) := 1.0;
      Output_Variables.Sin_M_Labmda (0) := 0.0;

      if Max_Degree + 1 >= 2 then
         Output_Variables.Cos_M_Labmda (1) := Cos_Lamda;
         Output_Variables.Sin_M_Labmda (1) := Sin_Lamda;
      end if;

      --  Compute cos(m*lambda), sin(m*lambda) for m = 0 ... nMax
      --  cos(a + b) = cos(a)*cos(b) - sin(a)*sin(b)
      --  sin(a + b) = cos(a)*sin(b) + sin(a)*cos(b)

      if Max_Degree + 1 >= 3 then
         for M in 2 .. Max_Degree loop
            Output_Variables.Cos_M_Labmda (M) :=
              Output_Variables.Cos_M_Labmda (M - 1)
              * Cos_Lamda
              - Output_Variables.Sin_M_Labmda (M - 1) * Sin_Lamda;

            Output_Variables.Sin_M_Labmda (M) :=
              Output_Variables.Cos_M_Labmda (M - 1)
              * Sin_Lamda
              + Output_Variables.Sin_M_Labmda (M - 1) * Cos_Lamda;
         end loop;
      end if;

      return Output_Variables;
   end Compute_Spherical_Harmonics;
end Geo_Mag.Math;
