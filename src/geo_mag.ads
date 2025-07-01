--  SPDX-FileCopyrightText: 2025 Max Zakirov <ardo25968@gmail.com>
--
--  SPDX-License-Identifier: MIT
----------------------------------------------------------------

package Geo_Mag is
   subtype WGS84_Latidude is Float range -90.0 .. 90.0;
   subtype WGS84_Longtitude is Float range -180.0 .. 180.0;
   subtype Years_Float is Float range 1900.0 .. 3000.0;

   function Compute_Magnetic_Declination
     (Latidude                       : WGS84_Latidude;
      Longtitude                     : WGS84_Longtitude;
      Ellispoid_Height_In_Kilometers : Float;
      Years                          : Years_Float) return Float;
end Geo_Mag;
