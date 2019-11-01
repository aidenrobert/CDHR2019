#!/bin/bash
export LD_LIBRARY_PATH=/home/x_aidjo/.conda/envs/python3env/lib:$LD_LIBRARY_PATH

### This script will execute the R files to make yearly measures of extreme events
### Written for Climate, Disasters, and Human Responses project
### Aiden Jönsson, 30 September 2019

## Make yearly magnitude records for the accumulated precipitation extremes: high
Rscript MakeYearlyRecord_spi3_pctl84.r
Rscript MakeYearlyRecord_spi3_pctl93.r
Rscript MakeYearlyRecord_spi3_pctl98.r

## Make yearly magnitude records for the accumulated precipitation extremes: low
Rscript MakeYearlyRecord_spi3_pctl16.r
Rscript MakeYearlyRecord_spi3_pctl07.r
Rscript MakeYearlyRecord_spi3_pctl02.r

## Move finished data to the storage directory
mv CDHR2019* SOME_STORAGE_DIR

