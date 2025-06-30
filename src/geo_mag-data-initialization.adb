--  SPDX-FileCopyrightText: 2025 Max Zakirov <ardo25968@gmail.com>
--
--  SPDX-License-Identifier: MIT
----------------------------------------------------------------

with Ada.Numerics.Elementary_Functions;

package body Geo_Mag.Data.Initialization is
   procedure Init_WGS84_Ellipsoid_Parameters
     (Default_Parameters : out Geo_Mag.Data.WGS84_Ellipsoid_Parameters)
   is
      use Ada.Numerics.Elementary_Functions;
   begin
      Default_Parameters.A := 6378.137;
      Default_Parameters.B := 6356.7523142;
      Default_Parameters.R := 6371.2;
      Default_Parameters.Flattening := 1.0 / 298.257223563;
      Default_Parameters.Eccentricity :=
        Sqrt
          (Float (1.0 - (Default_Parameters.B**2 / Default_Parameters.A**2)));
      Default_Parameters.Eccentricity_Squared :=
        Default_Parameters.Eccentricity**2;
   end Init_WGS84_Ellipsoid_Parameters;
end Geo_Mag.Data.Initialization;
