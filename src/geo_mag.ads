package Geo_Mag is
   function Compute_Magnetic_Declination 
      (Latidude: Float;
      Longtitude: Float;
      Height_In_Kilometers : Float;
      Years : Float)
      return Float;
end Geo_Mag;
