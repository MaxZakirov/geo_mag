--  SPDX-FileCopyrightText: 2025 Max Zakirov <ardo25968@gmail.com>
--
--  SPDX-License-Identifier: MIT
----------------------------------------------------------------

pragma Ada_2022;

with Geo_Mag.Common;

package Geo_Mag.Data.Initialization is
   procedure Init_WGS84_Ellipsoid_Parameters
     (Default_Parameters : out Geo_Mag.Data.WGS84_Ellipsoid_Parameters);

   Base_Model : constant Geo_Mag.Data.Magnetic_Model :=
     (Max_Index     => Model_Max_Index,
      Max_Degree    => 12,
      Base_Year     => 2025.0,
      Gauss_Coeff_G =>
        [Geo_Mag.Common.Calculate_Coef_Index (1, 0)   => -29351.8,
         Geo_Mag.Common.Calculate_Coef_Index (1, 1)   => -1410.8,
         Geo_Mag.Common.Calculate_Coef_Index (2, 0)   => -2556.6,
         Geo_Mag.Common.Calculate_Coef_Index (2, 1)   => 2951.1,
         Geo_Mag.Common.Calculate_Coef_Index (2, 2)   => 1649.3,
         Geo_Mag.Common.Calculate_Coef_Index (3, 0)   => 1361.0,
         Geo_Mag.Common.Calculate_Coef_Index (3, 1)   => -2404.1,
         Geo_Mag.Common.Calculate_Coef_Index (3, 2)   => 1243.8,
         Geo_Mag.Common.Calculate_Coef_Index (3, 3)   => 453.6,
         Geo_Mag.Common.Calculate_Coef_Index (4, 0)   => 895.0,
         Geo_Mag.Common.Calculate_Coef_Index (4, 1)   => 799.5,
         Geo_Mag.Common.Calculate_Coef_Index (4, 2)   => 55.7,
         Geo_Mag.Common.Calculate_Coef_Index (4, 3)   => -281.1,
         Geo_Mag.Common.Calculate_Coef_Index (4, 4)   => 12.1,
         Geo_Mag.Common.Calculate_Coef_Index (5, 0)   => -233.2,
         Geo_Mag.Common.Calculate_Coef_Index (5, 1)   => 368.9,
         Geo_Mag.Common.Calculate_Coef_Index (5, 2)   => 187.2,
         Geo_Mag.Common.Calculate_Coef_Index (5, 3)   => -138.7,
         Geo_Mag.Common.Calculate_Coef_Index (5, 4)   => -142.0,
         Geo_Mag.Common.Calculate_Coef_Index (5, 5)   => 20.9,
         Geo_Mag.Common.Calculate_Coef_Index (6, 0)   => 64.4,
         Geo_Mag.Common.Calculate_Coef_Index (6, 1)   => 63.8,
         Geo_Mag.Common.Calculate_Coef_Index (6, 2)   => 76.9,
         Geo_Mag.Common.Calculate_Coef_Index (6, 3)   => -115.7,
         Geo_Mag.Common.Calculate_Coef_Index (6, 4)   => -40.9,
         Geo_Mag.Common.Calculate_Coef_Index (6, 5)   => 14.9,
         Geo_Mag.Common.Calculate_Coef_Index (6, 6)   => -60.7,
         Geo_Mag.Common.Calculate_Coef_Index (7, 0)   => 79.5,
         Geo_Mag.Common.Calculate_Coef_Index (7, 1)   => -77.0,
         Geo_Mag.Common.Calculate_Coef_Index (7, 2)   => -8.8,
         Geo_Mag.Common.Calculate_Coef_Index (7, 3)   => 59.3,
         Geo_Mag.Common.Calculate_Coef_Index (7, 4)   => 15.8,
         Geo_Mag.Common.Calculate_Coef_Index (7, 5)   => 2.5,
         Geo_Mag.Common.Calculate_Coef_Index (7, 6)   => -11.1,
         Geo_Mag.Common.Calculate_Coef_Index (7, 7)   => 14.2,
         Geo_Mag.Common.Calculate_Coef_Index (8, 0)   => 23.2,
         Geo_Mag.Common.Calculate_Coef_Index (8, 1)   => 10.8,
         Geo_Mag.Common.Calculate_Coef_Index (8, 2)   => -17.5,
         Geo_Mag.Common.Calculate_Coef_Index (8, 3)   => 2.0,
         Geo_Mag.Common.Calculate_Coef_Index (8, 4)   => -21.7,
         Geo_Mag.Common.Calculate_Coef_Index (8, 5)   => 16.9,
         Geo_Mag.Common.Calculate_Coef_Index (8, 6)   => 15.0,
         Geo_Mag.Common.Calculate_Coef_Index (8, 7)   => -16.8,
         Geo_Mag.Common.Calculate_Coef_Index (8, 8)   => 0.9,
         Geo_Mag.Common.Calculate_Coef_Index (9, 0)   => 4.6,
         Geo_Mag.Common.Calculate_Coef_Index (9, 1)   => 7.8,
         Geo_Mag.Common.Calculate_Coef_Index (9, 2)   => 3.0,
         Geo_Mag.Common.Calculate_Coef_Index (9, 3)   => -0.2,
         Geo_Mag.Common.Calculate_Coef_Index (9, 4)   => -2.5,
         Geo_Mag.Common.Calculate_Coef_Index (9, 5)   => -13.1,
         Geo_Mag.Common.Calculate_Coef_Index (9, 6)   => 2.4,
         Geo_Mag.Common.Calculate_Coef_Index (9, 7)   => 8.6,
         Geo_Mag.Common.Calculate_Coef_Index (9, 8)   => -8.7,
         Geo_Mag.Common.Calculate_Coef_Index (9, 9)   => -12.9,
         Geo_Mag.Common.Calculate_Coef_Index (10, 0)  => -1.3,
         Geo_Mag.Common.Calculate_Coef_Index (10, 1)  => -6.4,
         Geo_Mag.Common.Calculate_Coef_Index (10, 2)  => 0.2,
         Geo_Mag.Common.Calculate_Coef_Index (10, 3)  => 2.0,
         Geo_Mag.Common.Calculate_Coef_Index (10, 4)  => -1.0,
         Geo_Mag.Common.Calculate_Coef_Index (10, 5)  => -0.6,
         Geo_Mag.Common.Calculate_Coef_Index (10, 6)  => -0.9,
         Geo_Mag.Common.Calculate_Coef_Index (10, 7)  => 1.5,
         Geo_Mag.Common.Calculate_Coef_Index (10, 8)  => 0.9,
         Geo_Mag.Common.Calculate_Coef_Index (10, 9)  => -2.7,
         Geo_Mag.Common.Calculate_Coef_Index (10, 10) => -3.9,
         Geo_Mag.Common.Calculate_Coef_Index (11, 0)  => 2.9,
         Geo_Mag.Common.Calculate_Coef_Index (11, 1)  => -1.5,
         Geo_Mag.Common.Calculate_Coef_Index (11, 2)  => -2.5,
         Geo_Mag.Common.Calculate_Coef_Index (11, 3)  => 2.4,
         Geo_Mag.Common.Calculate_Coef_Index (11, 4)  => -0.6,
         Geo_Mag.Common.Calculate_Coef_Index (11, 5)  => -0.1,
         Geo_Mag.Common.Calculate_Coef_Index (11, 6)  => -0.6,
         Geo_Mag.Common.Calculate_Coef_Index (11, 7)  => -0.1,
         Geo_Mag.Common.Calculate_Coef_Index (11, 8)  => 1.1,
         Geo_Mag.Common.Calculate_Coef_Index (11, 9)  => -1.0,
         Geo_Mag.Common.Calculate_Coef_Index (11, 10) => -0.2,
         Geo_Mag.Common.Calculate_Coef_Index (11, 11) => 2.6,
         Geo_Mag.Common.Calculate_Coef_Index (12, 0)  => -2.0,
         Geo_Mag.Common.Calculate_Coef_Index (12, 1)  => -0.2,
         Geo_Mag.Common.Calculate_Coef_Index (12, 2)  => 0.3,
         Geo_Mag.Common.Calculate_Coef_Index (12, 3)  => 1.2,
         Geo_Mag.Common.Calculate_Coef_Index (12, 4)  => -1.3,
         Geo_Mag.Common.Calculate_Coef_Index (12, 5)  => 0.6,
         Geo_Mag.Common.Calculate_Coef_Index (12, 6)  => 0.6,
         Geo_Mag.Common.Calculate_Coef_Index (12, 7)  => 0.5,
         Geo_Mag.Common.Calculate_Coef_Index (12, 8)  => -0.1,
         Geo_Mag.Common.Calculate_Coef_Index (12, 9)  => -0.4,
         Geo_Mag.Common.Calculate_Coef_Index (12, 10) => -0.2,
         Geo_Mag.Common.Calculate_Coef_Index (12, 11) => -1.3,
         Geo_Mag.Common.Calculate_Coef_Index (12, 12) => -0.7],
      Gauss_Coeff_H =>
        [Geo_Mag.Common.Calculate_Coef_Index (1, 0)   => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (1, 1)   => 4545.4,
         Geo_Mag.Common.Calculate_Coef_Index (2, 0)   => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (2, 1)   => -3133.6,
         Geo_Mag.Common.Calculate_Coef_Index (2, 2)   => -815.1,
         Geo_Mag.Common.Calculate_Coef_Index (3, 0)   => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (3, 1)   => -56.6,
         Geo_Mag.Common.Calculate_Coef_Index (3, 2)   => 237.5,
         Geo_Mag.Common.Calculate_Coef_Index (3, 3)   => -549.5,
         Geo_Mag.Common.Calculate_Coef_Index (4, 0)   => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (4, 1)   => 278.6,
         Geo_Mag.Common.Calculate_Coef_Index (4, 2)   => -133.9,
         Geo_Mag.Common.Calculate_Coef_Index (4, 3)   => 212.0,
         Geo_Mag.Common.Calculate_Coef_Index (4, 4)   => -375.6,
         Geo_Mag.Common.Calculate_Coef_Index (5, 0)   => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (5, 1)   => 45.4,
         Geo_Mag.Common.Calculate_Coef_Index (5, 2)   => 220.2,
         Geo_Mag.Common.Calculate_Coef_Index (5, 3)   => -122.9,
         Geo_Mag.Common.Calculate_Coef_Index (5, 4)   => 43.0,
         Geo_Mag.Common.Calculate_Coef_Index (5, 5)   => 106.1,
         Geo_Mag.Common.Calculate_Coef_Index (6, 0)   => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (6, 1)   => -18.4,
         Geo_Mag.Common.Calculate_Coef_Index (6, 2)   => 16.8,
         Geo_Mag.Common.Calculate_Coef_Index (6, 3)   => 48.8,
         Geo_Mag.Common.Calculate_Coef_Index (6, 4)   => -59.8,
         Geo_Mag.Common.Calculate_Coef_Index (6, 5)   => 10.9,
         Geo_Mag.Common.Calculate_Coef_Index (6, 6)   => 72.7,
         Geo_Mag.Common.Calculate_Coef_Index (7, 0)   => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (7, 1)   => -48.9,
         Geo_Mag.Common.Calculate_Coef_Index (7, 2)   => -14.4,
         Geo_Mag.Common.Calculate_Coef_Index (7, 3)   => -1.0,
         Geo_Mag.Common.Calculate_Coef_Index (7, 4)   => 23.4,
         Geo_Mag.Common.Calculate_Coef_Index (7, 5)   => -7.4,
         Geo_Mag.Common.Calculate_Coef_Index (7, 6)   => -25.1,
         Geo_Mag.Common.Calculate_Coef_Index (7, 7)   => -2.3,
         Geo_Mag.Common.Calculate_Coef_Index (8, 0)   => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (8, 1)   => 7.1,
         Geo_Mag.Common.Calculate_Coef_Index (8, 2)   => -12.6,
         Geo_Mag.Common.Calculate_Coef_Index (8, 3)   => 11.4,
         Geo_Mag.Common.Calculate_Coef_Index (8, 4)   => -9.7,
         Geo_Mag.Common.Calculate_Coef_Index (8, 5)   => 12.7,
         Geo_Mag.Common.Calculate_Coef_Index (8, 6)   => 0.7,
         Geo_Mag.Common.Calculate_Coef_Index (8, 7)   => -5.2,
         Geo_Mag.Common.Calculate_Coef_Index (8, 8)   => 3.9,
         Geo_Mag.Common.Calculate_Coef_Index (9, 0)   => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (9, 1)   => -24.8,
         Geo_Mag.Common.Calculate_Coef_Index (9, 2)   => 12.2,
         Geo_Mag.Common.Calculate_Coef_Index (9, 3)   => 8.3,
         Geo_Mag.Common.Calculate_Coef_Index (9, 4)   => -3.3,
         Geo_Mag.Common.Calculate_Coef_Index (9, 5)   => -5.2,
         Geo_Mag.Common.Calculate_Coef_Index (9, 6)   => 7.2,
         Geo_Mag.Common.Calculate_Coef_Index (9, 7)   => -0.6,
         Geo_Mag.Common.Calculate_Coef_Index (9, 8)   => 0.8,
         Geo_Mag.Common.Calculate_Coef_Index (9, 9)   => 10.0,
         Geo_Mag.Common.Calculate_Coef_Index (10, 0)  => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (10, 1)  => 3.3,
         Geo_Mag.Common.Calculate_Coef_Index (10, 2)  => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (10, 3)  => 2.4,
         Geo_Mag.Common.Calculate_Coef_Index (10, 4)  => 5.3,
         Geo_Mag.Common.Calculate_Coef_Index (10, 5)  => -9.1,
         Geo_Mag.Common.Calculate_Coef_Index (10, 6)  => 0.4,
         Geo_Mag.Common.Calculate_Coef_Index (10, 7)  => -4.2,
         Geo_Mag.Common.Calculate_Coef_Index (10, 8)  => -3.8,
         Geo_Mag.Common.Calculate_Coef_Index (10, 9)  => 0.9,
         Geo_Mag.Common.Calculate_Coef_Index (10, 10) => -9.1,
         Geo_Mag.Common.Calculate_Coef_Index (11, 0)  => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (11, 1)  => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (11, 2)  => 2.9,
         Geo_Mag.Common.Calculate_Coef_Index (11, 3)  => -0.6,
         Geo_Mag.Common.Calculate_Coef_Index (11, 4)  => 0.2,
         Geo_Mag.Common.Calculate_Coef_Index (11, 5)  => 0.5,
         Geo_Mag.Common.Calculate_Coef_Index (11, 6)  => -0.3,
         Geo_Mag.Common.Calculate_Coef_Index (11, 7)  => -1.2,
         Geo_Mag.Common.Calculate_Coef_Index (11, 8)  => -1.7,
         Geo_Mag.Common.Calculate_Coef_Index (11, 9)  => -2.9,
         Geo_Mag.Common.Calculate_Coef_Index (11, 10) => -1.8,
         Geo_Mag.Common.Calculate_Coef_Index (11, 11) => -2.3,
         Geo_Mag.Common.Calculate_Coef_Index (12, 0)  => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (12, 1)  => -1.3,
         Geo_Mag.Common.Calculate_Coef_Index (12, 2)  => 0.7,
         Geo_Mag.Common.Calculate_Coef_Index (12, 3)  => 1.0,
         Geo_Mag.Common.Calculate_Coef_Index (12, 4)  => -1.4,
         Geo_Mag.Common.Calculate_Coef_Index (12, 5)  => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (12, 6)  => 0.6,
         Geo_Mag.Common.Calculate_Coef_Index (12, 7)  => -0.1,
         Geo_Mag.Common.Calculate_Coef_Index (12, 8)  => 0.8,
         Geo_Mag.Common.Calculate_Coef_Index (12, 9)  => 0.1,
         Geo_Mag.Common.Calculate_Coef_Index (12, 10) => -1.0,
         Geo_Mag.Common.Calculate_Coef_Index (12, 11) => 0.1,
         Geo_Mag.Common.Calculate_Coef_Index (12, 12) => 0.2],
      Secular_Var_G =>
        [Geo_Mag.Common.Calculate_Coef_Index (1, 0)   => 12.0,
         Geo_Mag.Common.Calculate_Coef_Index (1, 1)   => 19.7,
         Geo_Mag.Common.Calculate_Coef_Index (2, 0)   => -11.6,
         Geo_Mag.Common.Calculate_Coef_Index (2, 1)   => -5.2,
         Geo_Mag.Common.Calculate_Coef_Index (2, 2)   => -8.0,
         Geo_Mag.Common.Calculate_Coef_Index (3, 0)   => -1.3,
         Geo_Mag.Common.Calculate_Coef_Index (3, 1)   => -4.2,
         Geo_Mag.Common.Calculate_Coef_Index (3, 2)   => 0.4,
         Geo_Mag.Common.Calculate_Coef_Index (3, 3)   => -15.6,
         Geo_Mag.Common.Calculate_Coef_Index (4, 0)   => -1.6,
         Geo_Mag.Common.Calculate_Coef_Index (4, 1)   => -2.4,
         Geo_Mag.Common.Calculate_Coef_Index (4, 2)   => -6.0,
         Geo_Mag.Common.Calculate_Coef_Index (4, 3)   => 5.6,
         Geo_Mag.Common.Calculate_Coef_Index (4, 4)   => -7.0,
         Geo_Mag.Common.Calculate_Coef_Index (5, 0)   => 0.6,
         Geo_Mag.Common.Calculate_Coef_Index (5, 1)   => 1.4,
         Geo_Mag.Common.Calculate_Coef_Index (5, 2)   => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (5, 3)   => 0.6,
         Geo_Mag.Common.Calculate_Coef_Index (5, 4)   => 2.2,
         Geo_Mag.Common.Calculate_Coef_Index (5, 5)   => 0.9,
         Geo_Mag.Common.Calculate_Coef_Index (6, 0)   => -0.2,
         Geo_Mag.Common.Calculate_Coef_Index (6, 1)   => -0.4,
         Geo_Mag.Common.Calculate_Coef_Index (6, 2)   => 0.9,
         Geo_Mag.Common.Calculate_Coef_Index (6, 3)   => 1.2,
         Geo_Mag.Common.Calculate_Coef_Index (6, 4)   => -0.9,
         Geo_Mag.Common.Calculate_Coef_Index (6, 5)   => 0.3,
         Geo_Mag.Common.Calculate_Coef_Index (6, 6)   => 0.9,
         Geo_Mag.Common.Calculate_Coef_Index (7, 0)   => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (7, 1)   => -0.1,
         Geo_Mag.Common.Calculate_Coef_Index (7, 2)   => -0.1,
         Geo_Mag.Common.Calculate_Coef_Index (7, 3)   => 0.5,
         Geo_Mag.Common.Calculate_Coef_Index (7, 4)   => -0.1,
         Geo_Mag.Common.Calculate_Coef_Index (7, 5)   => -0.8,
         Geo_Mag.Common.Calculate_Coef_Index (7, 6)   => -0.8,
         Geo_Mag.Common.Calculate_Coef_Index (7, 7)   => 0.8,
         Geo_Mag.Common.Calculate_Coef_Index (8, 0)   => -0.1,
         Geo_Mag.Common.Calculate_Coef_Index (8, 1)   => 0.2,
         Geo_Mag.Common.Calculate_Coef_Index (8, 2)   => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (8, 3)   => 0.5,
         Geo_Mag.Common.Calculate_Coef_Index (8, 4)   => -0.1,
         Geo_Mag.Common.Calculate_Coef_Index (8, 5)   => 0.3,
         Geo_Mag.Common.Calculate_Coef_Index (8, 6)   => 0.2,
         Geo_Mag.Common.Calculate_Coef_Index (8, 7)   => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (8, 8)   => 0.2,
         Geo_Mag.Common.Calculate_Coef_Index (9, 0)   => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (9, 1)   => -0.1,
         Geo_Mag.Common.Calculate_Coef_Index (9, 2)   => 0.1,
         Geo_Mag.Common.Calculate_Coef_Index (9, 3)   => 0.3,
         Geo_Mag.Common.Calculate_Coef_Index (9, 4)   => -0.3,
         Geo_Mag.Common.Calculate_Coef_Index (9, 5)   => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (9, 6)   => 0.3,
         Geo_Mag.Common.Calculate_Coef_Index (9, 7)   => -0.1,
         Geo_Mag.Common.Calculate_Coef_Index (9, 8)   => 0.1,
         Geo_Mag.Common.Calculate_Coef_Index (9, 9)   => -0.1,
         Geo_Mag.Common.Calculate_Coef_Index (10, 0)  => 0.1,
         Geo_Mag.Common.Calculate_Coef_Index (10, 1)  => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (10, 2)  => 0.1,
         Geo_Mag.Common.Calculate_Coef_Index (10, 3)  => 0.1,
         Geo_Mag.Common.Calculate_Coef_Index (10, 4)  => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (10, 5)  => -0.3,
         Geo_Mag.Common.Calculate_Coef_Index (10, 6)  => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (10, 7)  => -0.1,
         Geo_Mag.Common.Calculate_Coef_Index (10, 8)  => -0.1,
         Geo_Mag.Common.Calculate_Coef_Index (10, 9)  => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (10, 10) => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (11, 0)  => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (11, 1)  => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (11, 2)  => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (11, 3)  => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (11, 4)  => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (11, 5)  => -0.1,
         Geo_Mag.Common.Calculate_Coef_Index (11, 6)  => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (11, 7)  => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (11, 8)  => -0.1,
         Geo_Mag.Common.Calculate_Coef_Index (11, 9)  => -0.1,
         Geo_Mag.Common.Calculate_Coef_Index (11, 10) => -0.1,
         Geo_Mag.Common.Calculate_Coef_Index (11, 11) => -0.1,
         Geo_Mag.Common.Calculate_Coef_Index (12, 0)  => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (12, 1)  => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (12, 2)  => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (12, 3)  => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (12, 4)  => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (12, 5)  => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (12, 6)  => 0.1,
         Geo_Mag.Common.Calculate_Coef_Index (12, 7)  => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (12, 8)  => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (12, 9)  => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (12, 10) => -0.1,
         Geo_Mag.Common.Calculate_Coef_Index (12, 11) => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (12, 12) => -0.1],
      Secular_Var_H =>
        [Geo_Mag.Common.Calculate_Coef_Index (1, 0)   => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (1, 1)   => -21.5,
         Geo_Mag.Common.Calculate_Coef_Index (2, 0)   => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (2, 1)   => -27.7,
         Geo_Mag.Common.Calculate_Coef_Index (2, 2)   => -12.1,
         Geo_Mag.Common.Calculate_Coef_Index (3, 0)   => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (3, 1)   => 4.0,
         Geo_Mag.Common.Calculate_Coef_Index (3, 2)   => -0.3,
         Geo_Mag.Common.Calculate_Coef_Index (3, 3)   => -4.1,
         Geo_Mag.Common.Calculate_Coef_Index (4, 0)   => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (4, 1)   => -1.1,
         Geo_Mag.Common.Calculate_Coef_Index (4, 2)   => 4.1,
         Geo_Mag.Common.Calculate_Coef_Index (4, 3)   => 1.6,
         Geo_Mag.Common.Calculate_Coef_Index (4, 4)   => -4.4,
         Geo_Mag.Common.Calculate_Coef_Index (5, 0)   => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (5, 1)   => -0.5,
         Geo_Mag.Common.Calculate_Coef_Index (5, 2)   => 2.2,
         Geo_Mag.Common.Calculate_Coef_Index (5, 3)   => 0.4,
         Geo_Mag.Common.Calculate_Coef_Index (5, 4)   => 1.7,
         Geo_Mag.Common.Calculate_Coef_Index (5, 5)   => 1.9,
         Geo_Mag.Common.Calculate_Coef_Index (6, 0)   => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (6, 1)   => 0.3,
         Geo_Mag.Common.Calculate_Coef_Index (6, 2)   => -1.6,
         Geo_Mag.Common.Calculate_Coef_Index (6, 3)   => -0.4,
         Geo_Mag.Common.Calculate_Coef_Index (6, 4)   => 0.9,
         Geo_Mag.Common.Calculate_Coef_Index (6, 5)   => 0.7,
         Geo_Mag.Common.Calculate_Coef_Index (6, 6)   => 0.9,
         Geo_Mag.Common.Calculate_Coef_Index (7, 0)   => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (7, 1)   => 0.6,
         Geo_Mag.Common.Calculate_Coef_Index (7, 2)   => 0.5,
         Geo_Mag.Common.Calculate_Coef_Index (7, 3)   => -0.8,
         Geo_Mag.Common.Calculate_Coef_Index (7, 4)   => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (7, 5)   => -1.0,
         Geo_Mag.Common.Calculate_Coef_Index (7, 6)   => 0.6,
         Geo_Mag.Common.Calculate_Coef_Index (7, 7)   => -0.2,
         Geo_Mag.Common.Calculate_Coef_Index (8, 0)   => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (8, 1)   => -0.2,
         Geo_Mag.Common.Calculate_Coef_Index (8, 2)   => 0.5,
         Geo_Mag.Common.Calculate_Coef_Index (8, 3)   => -0.4,
         Geo_Mag.Common.Calculate_Coef_Index (8, 4)   => 0.4,
         Geo_Mag.Common.Calculate_Coef_Index (8, 5)   => -0.5,
         Geo_Mag.Common.Calculate_Coef_Index (8, 6)   => -0.6,
         Geo_Mag.Common.Calculate_Coef_Index (8, 7)   => 0.3,
         Geo_Mag.Common.Calculate_Coef_Index (8, 8)   => 0.2,
         Geo_Mag.Common.Calculate_Coef_Index (9, 0)   => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (9, 1)   => -0.3,
         Geo_Mag.Common.Calculate_Coef_Index (9, 2)   => 0.3,
         Geo_Mag.Common.Calculate_Coef_Index (9, 3)   => -0.3,
         Geo_Mag.Common.Calculate_Coef_Index (9, 4)   => 0.3,
         Geo_Mag.Common.Calculate_Coef_Index (9, 5)   => 0.2,
         Geo_Mag.Common.Calculate_Coef_Index (9, 6)   => -0.1,
         Geo_Mag.Common.Calculate_Coef_Index (9, 7)   => -0.2,
         Geo_Mag.Common.Calculate_Coef_Index (9, 8)   => 0.4,
         Geo_Mag.Common.Calculate_Coef_Index (9, 9)   => 0.1,
         Geo_Mag.Common.Calculate_Coef_Index (10, 0)  => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (10, 1)  => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (10, 2)  => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (10, 3)  => -0.2,
         Geo_Mag.Common.Calculate_Coef_Index (10, 4)  => 0.1,
         Geo_Mag.Common.Calculate_Coef_Index (10, 5)  => -0.1,
         Geo_Mag.Common.Calculate_Coef_Index (10, 6)  => 0.1,
         Geo_Mag.Common.Calculate_Coef_Index (10, 7)  => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (10, 8)  => -0.1,
         Geo_Mag.Common.Calculate_Coef_Index (10, 9)  => 0.2,
         Geo_Mag.Common.Calculate_Coef_Index (10, 10) => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (11, 0)  => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (11, 1)  => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (11, 2)  => 0.1,
         Geo_Mag.Common.Calculate_Coef_Index (11, 3)  => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (11, 4)  => 0.1,
         Geo_Mag.Common.Calculate_Coef_Index (11, 5)  => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (11, 6)  => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (11, 7)  => 0.1,
         Geo_Mag.Common.Calculate_Coef_Index (11, 8)  => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (11, 9)  => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (11, 10) => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (11, 11) => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (12, 0)  => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (12, 1)  => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (12, 2)  => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (12, 3)  => -0.1,
         Geo_Mag.Common.Calculate_Coef_Index (12, 4)  => 0.1,
         Geo_Mag.Common.Calculate_Coef_Index (12, 5)  => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (12, 6)  => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (12, 7)  => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (12, 8)  => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (12, 9)  => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (12, 10) => -0.0,
         Geo_Mag.Common.Calculate_Coef_Index (12, 11) => 0.0,
         Geo_Mag.Common.Calculate_Coef_Index (12, 12) => -0.1]);
end Geo_Mag.Data.Initialization;
