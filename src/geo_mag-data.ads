--  SPDX-FileCopyrightText: 2025 Max Zakirov <ardo25968@gmail.com>
--
--  SPDX-License-Identifier: MIT
----------------------------------------------------------------

private package Geo_Mag.Data is
   type Meters is new Float;
   type Kilometers is new Float;

   EGMS96_Columns : Integer :=
     1441; -- 360 degrees of longitude at 15 minute spacing
   EGMS96_Rows    : Integer :=
     721; -- 180 degrees of latitude  at 15 minute spacing
   Scale_Factor   : Integer := 4; -- 15 minute spacing per degree

   type WGS84_Ellipsoid_Parameters is record
      --  Semi-major axis of the ellipsoid
      A                    : Kilometers;
      --  Semi-minor axis of the ellipsoid
      B                    : Kilometers;
      --  Mean radius of ellipsoid
      R                    : Kilometers;
      Flattening           : Float;
      Eccentricity         : Float;
      Eccentricity_Squared : Float;
   end record;

   type Wgs_Coordinates is record
      Lat          : Float := 0.0;
      Lon          : Float := 0.0;
      Height_Geoid : Kilometers :=
        0.0; -- height WGS84 above ellipsoid calculated with EGMS96-15min model
   end record;

   type Geocentric_Coordinates is record
      Lambda : Float := 0.0; -- longitude
      Phig   : Float := 0.0; -- geocentric latitude
      R      : Kilometers := 0.0; -- distance from the center of the ellipsoid
   end record;

   type Nanoteslas is new Float;
   type Nanoteslas_Per_Year is new Float;

   type Gaus_Coefficients is array (Positive range <>) of Nanoteslas;
   type Seculat_Variation_Coefficients is
     array (Positive range <>) of Nanoteslas_Per_Year;

   Model_Max_Index : constant Integer := 90;

   type Magnetic_Model is record
      Max_Index     : Integer;
      Max_Degree    : Integer;
      Base_Year     : Float;
      Gauss_Coeff_G : Gaus_Coefficients (1 .. Model_Max_Index);
      Gauss_Coeff_H : Gaus_Coefficients (1 .. Model_Max_Index);
      Secular_Var_G : Seculat_Variation_Coefficients (1 .. Model_Max_Index);
      Secular_Var_H : Seculat_Variation_Coefficients (1 .. Model_Max_Index);
   end record;

   type Variables_Array is array (Natural range <>) of Float;

   type Spherical_Harmonic_Variables (Length : Natural) is record
      Relative_Radius_Power : Variables_Array (0 .. Length);
      Cos_M_Labmda          : Variables_Array (0 .. Length);
      Sin_M_Labmda          : Variables_Array (0 .. Length);
   end record;

   type Legendre_Functions_Array is array (Natural range <>) of Float;

   type Associated_Legendre_Functions is record
      Pcup            : Legendre_Functions_Array (0 .. Model_Max_Index);
      Derivative_Pcup : Legendre_Functions_Array (0 .. Model_Max_Index);
   end record;

   type Magnetic_Vector is record
      Bx : Float := 0.0;
      By : Float := 0.0;
      Bz : Float := 0.0;
   end record;
end Geo_Mag.Data;
