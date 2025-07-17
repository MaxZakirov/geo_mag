--  SPDX-FileCopyrightText: 2025 Max Zakirov <ardo25968@gmail.com>
--
--  SPDX-License-Identifier: MIT
----------------------------------------------------------------

with Ada.Numerics.Elementary_Functions;
with Geo_Mag.Convertions;
with Geo_Mag.Data;
with Geo_Mag.Data.Initialization;
with Geo_Mag.Common;
with Geo_Mag.Math;
with Geo_Mag.Math.Compute_ALF;

package body Geo_Mag is
   function Compute_Magnetic_Declination
     (Latitude                       : WGS84_Latidude;
      Longtitude                     : WGS84_Longtitude;
      Ellispoid_Height_In_Kilometers : Float;
      Years                          : Years_Float) return Float
   is
      use Geo_Mag.Data;
      use Geo_Mag.Convertions;

      Base_Magnetic_Model : Geo_Mag.Data.Magnetic_Model renames Geo_Mag.Data.Base_Model;
      Wgs_Data : constant Geo_Mag.Data.Wgs_Coordinates :=
        (Lat          => Latitude,
         Lon          => Longtitude,
         Height_Geoid => Kilometers (Ellispoid_Height_In_Kilometers));
      Geocentric_Coords    : Geo_Mag.Data.Geocentric_Coordinates;
      Ellipsoid_Parameters : Geo_Mag.Data.WGS84_Ellipsoid_Parameters;
   begin
      Geo_Mag.Data.Initialization.Init_WGS84_Ellipsoid_Parameters
        (Ellipsoid_Parameters);

      Geocentric_Coords :=
        Convert_Geodetic_To_Spherical (Ellipsoid_Parameters, Wgs_Data);

      declare
         Harmonic_Variables    : constant Spherical_Harmonic_Variables :=
           Math.Compute_Spherical_Harmonics
             (Ellipsoid_Parameters,
              Geocentric_Coords,
              Base_Magnetic_Model.Max_Degree);
         ALF_Values            : constant Associated_Legendre_Functions :=
           Geo_Mag.Math.Compute_ALF
             (Geocentric_Coords, Base_Magnetic_Model.Max_Degree);
         Field_Vector          : Magnetic_Vector;
         Magnetic_Declination  : Float;
      begin
         Field_Vector :=
           Geo_Mag.Math.Compute_Field_Elements
             (ALF                   => ALF_Values,
              Mag_Model             => Base_Magnetic_Model,
              Spherical_Harmonics   => Harmonic_Variables,
              Spherical_Coordinates => Geocentric_Coords, 
              Input_Years => Years);

         Field_Vector :=
           Geo_Mag.Convertions.Rotate_Vector_To_Geodetic
             (Field_Vector, Geocentric_Coords, Wgs_Data);

         Magnetic_Declination :=
           Ada.Numerics.Elementary_Functions.Arctan
             (Field_Vector.By, Field_Vector.Bx);

         return Geo_Mag.Common.Radians_To_Degrees (Magnetic_Declination);
      end;
   end Compute_Magnetic_Declination;
end Geo_Mag;
