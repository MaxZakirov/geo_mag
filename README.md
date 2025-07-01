Ada library with implementation of WMM model for magnetic declination angle calculation.

- [Official website](https://www.ncei.noaa.gov/)

## Installation

Use Alire to install and compile the library:

```
alr with raiden --use https://github.com/MaxZakirov/geo_mag
```

## Basic usage

```
procedure Example is
    Height : Float := 14.11 * 10.0**(-3); -- Height above ellipsoid in Kilometers
    Years  : Float := 2028.7; 
    Decl   : Float;
begin
    -- 2028.7 M M14.11 18.3074397892 -65.2825150965
    Decl :=
       Geo_Mag.Compute_Magnetic_Declination
          (Latitude             => 41.980736,  -- WGS 84 latidute
           Longtitude           => -91.790695, -- WGS 84 longtitude
           Ellispoid_Height_In_Kilometers => Height,
           Years                => Years);
    Put_Line (Decl'Image);
end Example;
```

## Restrictions
This library is originally desgined to use in for real time systems and bare-metal environment.
    - Tested accuracy can be different up to 7 minutes comparing to library on C, because float and notdouble is used for calculations.
    - WMM COF file is hardcoded in `geo_mag-magnetic_model.adb`. Currently supported period - 2025.0
    - Current code only supports calculation for Max Degree(nMax) < 16;
    - **NOTE! Latidute on poles(exactly -90 and 90) is not supported, and calculations returned for that case can be not valid**

## Contributing

Contributions are welcome! If you'd like to contribute to the library, please fork the repository and submit a pull request with your changes.