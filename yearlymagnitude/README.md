# Compiling yearly measures of magnitude from the meteorological source data

These scripts were used to calculate the measures of extreme meteorological events used in the *Climate, natural disasters, and human responses* project. The R scripts require the `raster`, `GADMTools`, `ncdf4`, `ncdf4.helpers`, `sf`, and `lubridate` R packages to use NetCDF files for meteorological data and the GADM polygon shape files of administrative borders.

The shell scripts in each directory are ready to be run as a bash file and will execute the R scripts to compile files of yearly magnitude records; it is recommended to stay within that directory to run the script.

A PDF describing the variables and their definitions is found in this directory.
