--  SPDX-FileCopyrightText: 2025 Max Zakirov <ardo25968@gmail.com>
--
--  SPDX-License-Identifier: MIT
----------------------------------------------------------------

with Geo_Mag.Data;

private package Geo_Mag.Convertions is
   function Convert_WGS_To_Geocentric
     (Ellipsoid_Parameters : Geo_Mag.Data.WGS84_Ellipsoid_Parameters;
      Wgs_Data             : Geo_Mag.Data.Wgs_Coordinates)
      return Geo_Mag.Data.Geocentric_Coordinates;

   function Rotate_Vector_To_Geodetic
     (Magnetic_Vector       : Geo_Mag.Data.Magnetic_Vector;
      Spherical_Coordinates : Geo_Mag.Data.Geocentric_Coordinates;
      Geodetic_Coordinates  : Geo_Mag.Data.Wgs_Coordinates)
      return Geo_Mag.Data.Magnetic_Vector;
end Geo_Mag.Convertions;
