#!/bin/bash

## Code for climate change, natural disasters and human responses project
## Aiden Jonsson, MISU, July 2018
## Retrieval script for temperature data (heat/cold waves, daily mean)
## Source: ERA-Interim surface values, via ECMWF API

for YR in {1981..2017}
do
	
	## Run ECMWF api script passing year to python as input
	python temperatures/retrieve_wind.py $YR
	
	## Take daily maxima/minima only
	cdo daymean -selvar,2t out.nc t2m.nc
	cdo daymax -selvar,mx2t out.nc maxtemp.nc
	cdo daymin -selvar,mn2t out.nc mintemp.nc
	
	## Take only the daily values from that year, sort leap years
	if [ "$YR" = 1984 ] || [ "$YR" = 1988 ] || [ "$YR" = 1992 ] || \
		[ "$YR" = 1996 ] || [ "$YR" = 2000 ]|| [ "$YR" = 2004 ] || \
		[ "$YR" = 2008 ] || [ "$YR" = 2012 ] || [ "$YR" = 2016 ]
	then
		cdo seltimestep,1/366 t2m.nc ${YR}_t2m.nc
		cdo seltimestep,1/366 maxtemp.nc ${YR}_tmax.nc
		cdo seltimestep,1/366 mintemp.nc ${YR}_tmin.nc
	else
		cdo seltimestep,1/365 t2m.nc ${YR}_t2m.nc
		cdo seltimestep,1/365 maxtemp.nc ${YR}_tmax.nc
		cdo seltimestep,1/365 mintemp.nc ${YR}_tmin.nc
	fi

	## Remove temporary files
	rm -rf out.nc maxtemp.nc mintemp.nc t2m.nc
	
done

## After this, use cdo mergetime to finish the operation, then remove the yearly files
