# Compiling yearly measures of magnitude from the meteorological source data

These scripts were used to calculate the measures of extreme meteorological events used in the *Climate, natural disasters, and human responses* project. The Python scripts require the `ecmwfapi` Python package to access the ECMWF servers. Description of ERA-Interim data can be found on the [ECMWF website](https://www.ecmwf.int/en/forecasts/datasets/reanalysis-datasets/era-interim), and instructions for using the `ecmwfapi` Python package can be found [on pypi.org.](https://pypi.org/project/ecmwf-api-client/)

The shell scripts in each directory are ready to be run as a bash file, and will retrieve all years of data; it is recommended to stay within that directory to run the script. After all years are present, Climate Data Operators (CDO) can be used to merge the entire timespan into a single file, and the yearly files can then be deleted to conserve storage space:

`cdo -b F32 mergetime *.nc VAR_1981-2017_record.nc && mv VAR_1981-2017_record.nc .. && rm -rf *.nc`

A PDF describing the variables and their definitions is found in this directory.
