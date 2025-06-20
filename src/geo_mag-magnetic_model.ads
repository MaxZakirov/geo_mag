with Geo_Mag.Data;

private package Geo_Mag.Magnetic_Model is
   function Timely_Adjust_Magnetic_Model
     (Input_Years : Float; Base_Model : Geo_Mag.Data.Magnetic_Model)
      return Geo_Mag.Data.Magnetic_Model;
end Geo_Mag.Magnetic_Model;
