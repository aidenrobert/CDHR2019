#!/bin/bash
export LD_LIBRARY_PATH=/home/x_aidjo/.conda/envs/python3env/lib:$LD_LIBRARY_PATH

### This script will execute the R files to make yearly measures of extreme events
### Written for Climate, Disasters, and Human Responses project
### Aiden Jönsson, 30 September 2019

## Make yearly magnitude records for the daily precipitation extremes: high
Rscript MakeYearlyRecord_daily_pctl84.r
Rscript MakeYearlyRecord_daily_pctl93.r
Rscript MakeYearlyRecord_daily_pctl98.r

## Move finished data to the storage directory
mv CDHR2019* SOME_STORAGE_DIR
