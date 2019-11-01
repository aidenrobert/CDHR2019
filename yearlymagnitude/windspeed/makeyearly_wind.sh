#!/bin/bash
export LD_LIBRARY_PATH=/home/x_aidjo/.conda/envs/python3env/lib:$LD_LIBRARY_PATH

### This script will execute the R files to make yearly measures of extreme events
### Written for Climate, Disasters, and Human Responses project
### Aiden Jönsson, 30 September 2019

## Make yearly magnitude records for high wind speeds
Rscript MakeYearlyRecord_wind_pctl84.r
Rscript MakeYearlyRecord_wind_pctl93.r
Rscript MakeYearlyRecord_wind_pctl98.r
Rscript MakeYearlyRecord_windanom.r

## Move finished data to the storage directory
mv CDHR2019* SOME_STORAGE_DIR
