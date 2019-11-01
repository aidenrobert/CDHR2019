#!/usr/bin/env python

## Code for climate change, natural disasters and human responses project
## MISU and Institution for Economic History and International Relations
## Aiden Jonsson, July 2018
## Calculate percentile of meteorological variable

from netCDF4 import Dataset
import numpy as np
from scipy import stats

ifile1 = 'SOME_RECORD.nc'
fh = Dataset(ifile1,mode='r')
tp = fh.variables['varname'][:,:,:] # e.g. U10 for windspeed, mx2t for maximum temperature
lat = fh.variables['latitude'][:]
lon = fh.variables['longitude'][:]
time = fh.variables['time'][:]
N = len(time)
print(np.shape(tp))
fh.close()


## Calculate pctl
pctl = np.zeros_like(tp)
for ii in range(0,240):
	for jj in range(0,479):
		pctl[:,ii,jj] = 100*stats.rankdata(tp[:,ii,jj])/(N+1)

## Create the new record
newfile = 'PARAMETER_totalpctl.nc'
fh = Dataset(newfile,'w')
fh.createDimension('time', None)
fh.createDimension('latitude', 241)
fh.createDimension('longitude', 480)
time = fh.createVariable('time', float, ('time'), zlib=True)
lats = fh.createVariable('latitude', float, ('latitude'), zlib=True)
lons = fh.createVariable('longitude', float, ('longitude'), zlib=True)
spi = fh.createVariable('pctl','f8',('time','latitude','longitude'),zlib=True)
spi[:] = np.fliplr(pctl)
spi.long_name = 'Percentile ranking of SOME PARAMETER' # describe the parameter in the long name
spi.units = '' # percentile ranking is unitless
spi.standard_name = 'pctl'
time[:] = time
time.standard_name = 'time'
time.units = 'hours since 1900-01-01 00:00:00'
time.calendar = 'standard'
lats[:] = np.flipud(lat)
lats.standard_name = 'latitude'
lats.units = 'degrees_north'
lats.positive = 'up'
lons[:] = lon
lons.standard_name = 'longitude'
lons.positive = 'right'
lons.units = 'degrees_east'
fh.title = 'Record of SOME PARAMETER percentile ranking (1981-2017)' # describe the data file
fh.Conventions = 'CF-1.6'
fh.close()
