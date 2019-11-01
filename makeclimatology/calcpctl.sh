#!/bin/bash

### This script will execute the python script to make a record of percentile rankings
### Written for Climate, Disasters, and Human Responses project
### Aiden Jönsson, 30 September 2019

## Run the python script to make an output netCDF file with percentile rankings
python calc_pctl.py

## Take the period of focus for the study: 2006-2017
cdo seltimestep,9132/13514 SOMEPARAMETER_totalpctl.nc SOMEPARAMETER_modernpctl.nc
