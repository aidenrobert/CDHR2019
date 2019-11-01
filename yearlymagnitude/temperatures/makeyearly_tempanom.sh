#!/bin/bash
export LD_LIBRARY_PATH=/home/x_aidjo/.conda/envs/python3env/lib:$LD_LIBRARY_PATH

### This script will execute the R files to make yearly measures of extreme events
### Written for Climate, Disasters, and Human Responses project
### Aiden Jönsson, 30 September 2019

## Make yearly magnitude records for the accumulated anomalies
Rscript MakeYearlyRecord_t2manom.r
Rscript MakeYearlyRecord_tminanom.r
Rscript MakeYearlyRecord_tmaxanom.r

## Move finished data to the storage directory
mv CDHR2019* SOME_STORAGE_DIR
