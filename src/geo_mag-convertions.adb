with Ada.Text_IO;
with Geo_Mag.Data.EGMS9615;
with Geo_Mag.Data; use Geo_Mag.Data;
with Geo_Mag.Common;
with Ada.Numerics.Elementary_Functions;
with Ada.Numerics;

package body Geo_Mag.Convertions is
   function Convert_WGS_To_Geocentric
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
      N               : Kilometers;
   begin
      N :=
        Ellipsoid_Parameters.A
        / Kilometers
            (Sqrt
               (1.0 - Ellipsoid_Parameters.Eccentricity_Squared * Lat_Sin**2));

      XP := Float (N + Wgs_Data.Height_Geoid) * Lat_Cos;
      ZP :=
        Float
          (N
           * Kilometers (1.0 - Ellipsoid_Parameters.Eccentricity_Squared)
           + Wgs_Data.Height_Geoid)
        * Lat_Sin;

      Geocentric_Data.R := Kilometers (Sqrt (XP * XP + ZP * ZP));
      Geocentric_Data.Phig :=
        Radians_To_Degrees (Arcsin (ZP / Float (Geocentric_Data.R)));
      Geocentric_Data.Lambda := Wgs_Data.Lon;

      return Geocentric_Data;
   end Convert_WGS_To_Geocentric;

   function Convert_Ortho_To_Ellipsoid_Height
     (Wgs_Data : Wgs_Coordinates) return Kilometers
   is

      function Lerp (A : Float; B : Float; t : Float) return Float is
      begin
         return A + (B - A) * t;
      end Lerp;

      Offset_X, Offset_Y, Delta_X, Delta_Y                   : Float;
      Post_X, Post_Y, Index                                  : Integer;
      Elevation_NW, Elevation_NE, Elevation_SW, Elevation_SE : Float;
      EGMS96_Deviation                                       : Meters;
      EGMS96_Model                                           :
        Geo_Mag.Data.EGMS9615.EGMS_Array
          renames Geo_Mag.Data.EGMS9615.Geo_Heights_Buffer;
   begin
      --   Find Four Nearest Geoid Height Cells for specified Latitude, Longitude;
      if Wgs_Data.Lon < 0.0 then
         Offset_X := Wgs_Data.Lon + 360.0;
      end if;

      Offset_X := Offset_X * Float (Scale_Factor);
      Offset_Y := (90.0 - Wgs_Data.Lat) * Float (Scale_Factor);

      Post_X := Integer (Offset_X);
      if Post_X + 1 = EGMS96_Columns then
         Post_X := Post_X - 1;
      end if;
      Post_Y := Integer (Offset_Y);
      if Post_Y + 1 = EGMS96_Columns then
         Post_Y := Post_Y - 1;
      end if;

      Index := Post_Y * EGMS96_Columns + Post_X;
      Ada.Text_IO.Put_Line ("EGMS model size is" & EGMS96_Model'Length'Image);
      Ada.Text_IO.Put_Line ("EGMS model size is" & EGMS96_Model'Size'Image);
      Elevation_NW := EGMS96_Model (Index);
      Elevation_NE := EGMS96_Model (Index + 1);

      Index := (Post_Y + 1) * EGMS96_Columns + Post_X;
      Elevation_SW := EGMS96_Model (Index);
      Elevation_SE := EGMS96_Model (Index + 1);

      --   Perform Bi-Linear Interpolation to compute Height above Ellipsoid:
      Delta_X := Offset_X - Float (Post_X);
      Delta_Y := Offset_Y - Float (Post_Y);

      EGMS96_Deviation :=
        Meters
          (Lerp
             (Lerp (Elevation_NW, Elevation_NE, Delta_X),
              Lerp (Elevation_SW, Elevation_SE, Delta_X),
              Delta_Y));

      return
        Kilometers (EGMS96_Deviation * 10.0**(-3)) + Wgs_Data.Height_Ortho;
   end Convert_Ortho_To_Ellipsoid_Height;

   function Rotate_Vector_To_Geodetic
     (Magnetic_Vector       : Geo_Mag.Data.Magnetic_Vector;
      Spherical_Coordinates : Geo_Mag.Data.Geocentric_Coordinates;
      Geodetic_Coordinates  : Geo_Mag.Data.Wgs_Coordinates)
      return Geo_Mag.Data.Magnetic_Vector
   is
      use Ada.Numerics.Elementary_Functions;

      Rotated_Vector : Geo_Mag.Data.Magnetic_Vector;
      Psi : Float;
   begin
      Psi := Ada.Numerics.Pi / 180.0 * (Spherical_Coordinates.Phig - Geodetic_Coordinates.Lat);

      Rotated_Vector.Bz := Magnetic_Vector.Bx * Sin (Psi) + Magnetic_Vector.Bz * Cos (Psi);
      Rotated_Vector.Bx := Magnetic_Vector.Bx * Cos (Psi) - Magnetic_Vector.Bz * Sin (Psi);
      Rotated_Vector.By := Magnetic_Vector.By;

      return Rotated_Vector;
   end Rotate_Vector_To_Geodetic;
end Geo_Mag.Convertions;
