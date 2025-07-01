--  SPDX-FileCopyrightText: 2025 Max Zakirov <ardo25968@gmail.com>
--
--  SPDX-License-Identifier: MIT
----------------------------------------------------------------

with Geo_Mag.Data; use Geo_Mag.Data;

private package Geo_Mag.Math is
   --  Computes Spherical variables
   --  Variables computed are (a/r)^(n+2), cos_m(lamda) and sin_m(lambda)
   --  for spherical harmonic summations.(Eq. 10-12 in the WMM Tech Report)
   function Compute_Spherical_Harmonics
     (Ellipsoid_Parameters  : WGS84_Ellipsoid_Parameters;
      Spherical_Coordinates : Geocentric_Coordinates;
      Max_Degree            : Integer) return Spherical_Harmonic_Variables;

   --  Computes Geomagnetic Field Elements X, Y and Z
   --  in Spherical coordinate system using
   --  spherical harmonic summation.
   --  The vector Magnetic field is given by -grad V,
   --  where V is Geomagnetic scalar potential
   --  The gradient in spherical coordinates is given by:

   --                    dV ^     1 dV ^        1     dV ^
   --   grad V = -- r  +  - -- t  +  -------- -- p
   --                    dr       r dt       r sin(t) dp
   function Compute_Field_Elements
     (ALF                   : Associated_Legendre_Functions;
      Mag_Model             : Magnetic_Model;
      Spherical_Harmonics   : Spherical_Harmonic_Variables;
      Spherical_Coordinates : Geocentric_Coordinates) return Magnetic_Vector;
end Geo_Mag.Math;
