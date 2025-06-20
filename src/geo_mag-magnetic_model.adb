with Geo_Mag.Data; use Geo_Mag.Data;

package body Geo_Mag.Magnetic_Model is
   function Timely_Adjust_Magnetic_Model
     (Input_Years : Float; Base_Model : Geo_Mag.Data.Magnetic_Model)
      return Geo_Mag.Data.Magnetic_Model
   is
      Adjusted_Model : Geo_Mag.Data.Magnetic_Model (Base_Model.Length);
   begin
      for I in 1 .. Base_Model.Length loop
         Adjusted_Model.Gauss_Coeff_G (I) :=
           Base_Model.Gauss_Coeff_G (I)
           + Nanoteslas
               ((Input_Years - Base_Model.Base_Year)
                * Float (Base_Model.Secular_Var_G (I)));

         Adjusted_Model.Gauss_Coeff_H (I) :=
           Base_Model.Gauss_Coeff_H (I)
           + Nanoteslas
               ((Input_Years - Base_Model.Base_Year)
                * Float (Base_Model.Secular_Var_H (I)));

         Adjusted_Model.Secular_Var_G (I) := Base_Model.Secular_Var_G (I);
         Adjusted_Model.Secular_Var_H (I) := Base_Model.Secular_Var_H (I);

      end loop;

      Adjusted_Model.Base_Year := Base_Model.Base_Year;
      Adjusted_Model.Max_Degree := Base_Model.Max_Degree;

      return Adjusted_Model;
   end Timely_Adjust_Magnetic_Model;
end Geo_Mag.Magnetic_Model;
