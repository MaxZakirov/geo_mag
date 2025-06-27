private package Geo_Mag.Data is
   type Meters is new Float;
   type Kilometers is new Float;

   EGMS96_Columns : Integer :=
     1441; -- 360 degrees of longitude at 15 minute spacing
   EGMS96_Rows    : Integer :=
     721; -- 180 degrees of latitude  at 15 minute spacing
   Scale_Factor   : Integer := 4; -- 15 minute spacing per degree

   type WGS84_Ellipsoid_Parameters is record
      A                    : Kilometers; -- semi-major axis of the ellipsoid
      B                    : Kilometers; -- semi-minor axis of the ellipsoid
      R                    : Kilometers; -- mean radius of  ellipsoid
      Flattening           : Float;
      Eccentricity         : Float;
      Eccentricity_Squared : Float;
   end record;

   type Wgs_Coordinates is record
      Lat          : Float := 0.0;
      Lon          : Float := 0.0;
      Height_Ortho : Kilometers := 0.0; -- height above sea level
      Height_Geoid : Kilometers := 0.0; -- height WGS84 above ellipsoid calculated with EGMS96-15min model
   end record;

   type Geocentric_Coordinates is record
      Lambda : Float := 0.0; -- longitude
      Phig   : Float := 0.0; -- geocentric latitude
      R      : Kilometers := 0.0; -- distance from the center of the ellipsoid
   end record;

   type Nanoteslas is new Float;
   type Nanoteslas_Per_Year is new Float;

   type Gaus_Coefficients is array (Positive range <>) of Nanoteslas;
   type Seculat_Variation_Coefficients is
     array (Positive range <>) of Nanoteslas_Per_Year;

   type Magnetic_Model (Length : Positive) is record
      Max_Degree         :
        Integer := 0; -- Maximum degree of spherical harmonic model
      Gauss_Coeff_G      : Gaus_Coefficients (1 .. Length);
      Gauss_Coeff_H      : Gaus_Coefficients (1 .. Length);
      Secular_Var_G      : Seculat_Variation_Coefficients (1 .. Length);
      Secular_Var_H      : Seculat_Variation_Coefficients (1 .. Length);
      Base_Year          : Float; -- Base time of Geomagnetic model(epoch)
   end record;

   type Variables_Array is array (Natural range <>) of Float;

   type Spherical_Harmonic_Variables (Length : Natural) is record
      Relative_Radius_Power : Variables_Array (0 .. Length);
      Cos_M_Labmda          : Variables_Array (0 .. Length);
      Sin_M_Labmda          : Variables_Array (0 .. Length);
   end record;

   type Associated_Legendre_Functions (Length : Natural) is record
      Pcup            : Variables_Array (0 .. Length);
      Derivative_Pcup : Variables_Array (0 .. Length);
   end record;

   type Magnetic_Vector is record
      Bx : Float := 0.0;
      By : Float := 0.0;
      Bz : Float := 0.0;
   end record;

end Geo_Mag.Data;
