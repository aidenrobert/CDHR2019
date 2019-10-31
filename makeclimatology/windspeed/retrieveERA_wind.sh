#!/bin/bash

## Code for climate change, natural disasters and human responses project
## Aiden Jonsson, MISU, July 2018
## Retrieval script for wind speed data (storms)
## Source: ERA-Interim surface values, via ECMWF API

for YR in {1981..2017}
do
	
	## Run ECMWF api script passing year to python as input
	python windspeed/retrieveERA_wind.py $YR
	
	## Calculate windspeed from u & v components, take only the wind speed variable
	ncap2 -s "U10=sqrt(u10^2+v10^2)" out.nc wind.nc
	cdo selvar,U10 wind.nc out.nc
	
	## Take only the daily values from that year, sort leap years
	if [ "$YR" = 1984 ] || [ "$YR" = 1988 ] || [ "$YR" = 1992 ] || \
		[ "$YR" = 1996 ] || [ "$YR" = 2000 ]|| [ "$YR" = 2004 ] || \
		[ "$YR" = 2008 ] || [ "$YR" = 2012 ] || [ "$YR" = 2016 ]
	then
		cdo seltimestep,1/366 out.nc ${YR}_wind.nc
	else
		cdo seltimestep,1/365 out.nc ${YR}_wind.nc
	fi

	## Remove temporary files
	rm -rf out.nc wind.nc
	
done

## After this, use cdo mergetime to finish the operation, then remove the yearly files
