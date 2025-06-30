--  SPDX-FileCopyrightText: 2025 Max Zakirov <ardo25968@gmail.com>
--
--  SPDX-License-Identifier: MIT
----------------------------------------------------------------

package Geo_Mag is
   function Compute_Magnetic_Declination
     (Latidude                       : Float;
      Longtitude                     : Float;
      Ellispoid_Height_In_Kilometers : Float;
      Years                          : Float) return Float;
end Geo_Mag;
