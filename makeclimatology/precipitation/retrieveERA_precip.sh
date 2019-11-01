#!/bin/bash

## Code for climate change, natural disasters and human responses project
## Aiden Jonsson, MISU, July 2018
## Retrieval script for precipitation data (floods, droughts)
## Source: ERA-Interim surface values, via ECMWF API
## Note: one extra year is added to allow accumulated precipitation to be calculated

for YR in {1980..2017}
do
	
	## Run ECMWF api script passing year to python as input
	python retrieveERA_precip.py $YR
	
	## Take daily maxima/minima only
	cdo daysum out.nc precip.nc
	
	## Take only the daily values from that year, sort leap years
	if [ "$YR" = 1984 ] || [ "$YR" = 1988 ] || [ "$YR" = 1992 ] || \
		[ "$YR" = 1996 ] || [ "$YR" = 2000 ]|| [ "$YR" = 2004 ] || \
		[ "$YR" = 2008 ] || [ "$YR" = 2012 ] || [ "$YR" = 2016 ]
	then
		cdo seltimestep,1/366 precip.nc ${YR}_precip.nc
	else
		cdo seltimestep,1/365 precip.nc ${YR}_precip.nc
	fi

	## Remove temporary files
	rm -rf out.nc precip.nc
	
done

## After this, use cdo mergetime to finish the operation, then remove the yearly files
cdo -b F32 mergetime *_precip.nc dailyprecip_total.nc
rm -rf *_precip.nc

## Make annual accumulated precipitation for the modern period
cdo seltimestep,24/36 -yearsum dailyprecip_total.nc annual_accumulated_precip.nc
