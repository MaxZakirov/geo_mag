--  SPDX-FileCopyrightText: 2025 Max Zakirov <ardo25968@gmail.com>
--
--  SPDX-License-Identifier: MIT
----------------------------------------------------------------

with Geo_Mag.Data; use Geo_Mag.Data;
with Geo_Mag.Common;
with Ada.Numerics.Elementary_Functions;
with Ada.Numerics;

package body Geo_Mag.Convertions is
   function Convert_Geodetic_To_Spherical
     (Ellipsoid_Parameters : WGS84_Ellipsoid_Parameters;
      Wgs_Data             : Wgs_Coordinates) return Geocentric_Coordinates
   is
      use Ada.Numerics.Elementary_Functions;
      use Geo_Mag.Common;

      Geocentric_Data : Geocentric_Coordinates;
      Lat_Radians     : constant Float := Degrees_To_Radians (Wgs_Data.Lat);
      Lat_Cos         : constant Float := Cos (Lat_Radians);
      Lat_Sin         : constant Float := Sin (Lat_Radians);
      XP, ZP          : Float;
      Local_Radius    : Kilometers;
   begin
      --  Compute the local radius of curvature
      --  on the WGS-84 reference ellipsoid
      Local_Radius :=
        Ellipsoid_Parameters.A
        / Kilometers
            (Sqrt
               (1.0 - Ellipsoid_Parameters.Eccentricity_Squared * Lat_Sin**2));

      --  Compute ECEF Cartesian coordinates
      --  of specified point (for longitude=0)
      XP := Float (Local_Radius + Wgs_Data.Height_Geoid) * Lat_Cos;
      ZP :=
        Float
          (Local_Radius
           * Kilometers (1.0 - Ellipsoid_Parameters.Eccentricity_Squared)
           + Wgs_Data.Height_Geoid)
        * Lat_Sin;

      --  Compute spherical radius and angle lambda and phi of specified point
      Geocentric_Data.R := Kilometers (Sqrt (XP * XP + ZP * ZP));
      Geocentric_Data.Phig :=
        Radians_To_Degrees (Arcsin (ZP / Float (Geocentric_Data.R)));
      Geocentric_Data.Lambda := Wgs_Data.Lon;

      return Geocentric_Data;
   end Convert_Geodetic_To_Spherical;

   function Rotate_Vector_To_Geodetic
     (Magnetic_Vector       : Geo_Mag.Data.Magnetic_Vector;
      Spherical_Coordinates : Geo_Mag.Data.Geocentric_Coordinates;
      Geodetic_Coordinates  : Geo_Mag.Data.Wgs_Coordinates)
      return Geo_Mag.Data.Magnetic_Vector
   is
      use Ada.Numerics.Elementary_Functions;

      Rotated_Vector : Geo_Mag.Data.Magnetic_Vector;
      Psi            : Float;
   begin
      Psi :=
        Ada.Numerics.Pi
        / 180.0
        * (Spherical_Coordinates.Phig - Geodetic_Coordinates.Lat);

      Rotated_Vector.Bz :=
        Magnetic_Vector.Bx * Sin (Psi) + Magnetic_Vector.Bz * Cos (Psi);
      Rotated_Vector.Bx :=
        Magnetic_Vector.Bx * Cos (Psi) - Magnetic_Vector.Bz * Sin (Psi);
      Rotated_Vector.By := Magnetic_Vector.By;

      return Rotated_Vector;
   end Rotate_Vector_To_Geodetic;
end Geo_Mag.Convertions;
