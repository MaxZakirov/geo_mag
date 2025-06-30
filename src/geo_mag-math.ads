--  SPDX-FileCopyrightText: 2025 Max Zakirov <ardo25968@gmail.com>
--
--  SPDX-License-Identifier: MIT
----------------------------------------------------------------

with Geo_Mag.Data; use Geo_Mag.Data;

private package Geo_Mag.Math is
   function Compute_Spherical_Harmonics
      (Ellipsoid_Parameters  : WGS84_Ellipsoid_Parameters;
      Spherical_Coordinates : Geocentric_Coordinates;
      Max_Degree            : Integer) return Spherical_Harmonic_Variables;

   function Compute_Field_Elements
     (ALF                   : Associated_Legendre_Functions;
      Mag_Model             : Magnetic_Model;
      Spherical_Harmonics   : Spherical_Harmonic_Variables;
      Spherical_Coordinates : Geocentric_Coordinates) return Magnetic_Vector;
end Geo_Mag.Math;