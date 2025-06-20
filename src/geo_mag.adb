pragma Ada_2022;

with Ada.Numerics.Elementary_Functions;
with Geo_Mag;
with Geo_Mag.Convertions;
with Geo_Mag.Data;
with Geo_Mag.Data.Initialization;
with Geo_Mag.Magnetic_Model.Read;
with Geo_Mag.Common;
with Geo_Mag.Math;
with Geo_Mag.Math.Compute_ALF;

package body Geo_Mag is
   function Compute_Magnetic_Declination
     (Latidude             : Float;
      Longtitude           : Float;
      Height_In_Kilometers : Float;
      Years                : Float) return Float
   is
      use Geo_Mag.Data;
      use Geo_Mag.Convertions;

      Base_Magnetic_Model  : constant Geo_Mag.Data.Magnetic_Model :=
        Geo_Mag.Magnetic_Model.Read;
      Wgs_Data             : Geo_Mag.Data.Wgs_Coordinates :=
        (Lat          => Latidude,
         Lon          => Longtitude,
         Height_Ortho => Geo_Mag.Data.Kilometers (Height_In_Kilometers),
         others       => 0.0);
      Geocentric_Coords    : Geo_Mag.Data.Geocentric_Coordinates;
      Ellipsoid_Parameters : Geo_Mag.Data.WGS84_Ellipsoid_Parameters;
   begin
      Geo_Mag.Data.Initialization.Init_WGS84_Ellipsoid_Parameters
        (Ellipsoid_Parameters);

      Wgs_Data :=
        (Lat          => 18.3074397892,
         Lon          => -65.2825150965,
         Height_Ortho => Geo_Mag.Data.Kilometers (14.11 * 10.0**(-3)),
         Height_Geoid => 0.0);
      Wgs_Data.Height_Geoid := Convert_Ortho_To_Ellipsoid_Height (Wgs_Data);
      Geocentric_Coords :=
        Convert_WGS_To_Geocentric (Ellipsoid_Parameters, Wgs_Data);

      declare
         Timely_Adjusted_Model : constant Geo_Mag.Data.Magnetic_Model :=
           Geo_Mag.Magnetic_Model.Timely_Adjust_Magnetic_Model
             (Years, Base_Magnetic_Model);
         Harmonic_Variables    : constant Spherical_Harmonic_Variables :=
           Math.Compute_Spherical_Harmonics
             (Ellipsoid_Parameters,
              Geocentric_Coords,
              Timely_Adjusted_Model.Max_Degree);
         ALF_Values            : constant Associated_Legendre_Functions :=
           Geo_Mag.Math.Compute_ALF
             (Geocentric_Coords, Timely_Adjusted_Model.Max_Degree);
         Field_Vector          : Magnetic_Vector;
         Magnetic_Declination  : Float;
      begin
         Field_Vector :=
           Geo_Mag.Math.Compute_Field_Elements
             (ALF                   => ALF_Values,
              Mag_Model             => Timely_Adjusted_Model,
              Spherical_Harmonics   => Harmonic_Variables,
              Spherical_Coordinates => Geocentric_Coords);

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
