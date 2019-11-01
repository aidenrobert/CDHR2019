#!/usr/bin/env python

## Code for climate change, natural disasters and human responses project
## MISU and Institution for Economic History and International Relations
## Aiden Jonsson, July 2018
## Calculate accumulated precipitation sums

from netCDF4 import Dataset
import numpy as np

## Open the daily precipitation values retrieved from ERA-Interim
ifile1 = 'tp_total.nc'
fh = Dataset(ifile1,mode='r')
tp = fh.variables['tp'][:,:,:]
lat = fh.variables['latitude'][:]
lon = fh.variables['longitude'][:]
time = fh.variables['time'][:]
fh.close()

## Calculate the sum for a certain number of days prior days prior
## SPI1 is based on 30 days, SPI3 on 90 days, SPI6 on 180 days
tpnew = np.zeros_like(tp)
for t in range(181,930):
	print('The current time step is #%s out of 929.' % t)
	tpnew[t,:,:] = sum(tp[(t-30):t,:,:]) # the timespan of accumulation in days can be adjusted here

## Create the new record
newfile = 'TP_something.nc'
fh = Dataset(newfile,'w')
fh.createDimension('time', None)
fh.createDimension('latitude', 241)
fh.createDimension('longitude', 480)
time = fh.createVariable('time', float, ('time'), zlib=True)
lats = fh.createVariable('latitude', float, ('latitude'), zlib=True)
lons = fh.createVariable('longitude', float, ('longitude'), zlib=True)
spi = fh.createVariable('tp30','f8',('time','latitude','longitude'),zlib=True)
spi[:] = np.fliplr(tpnew)
spi.long_name = 'Accumulated precipitation (X days prior to current)' # specify timespan of accumulation here
spi.units = 'm'
spi.standard_name = 'tp30' #tp90 for 3 months, tp180 for 6 months
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
fh.title = 'Record of total accumulated precipitation (X months)'
fh.Conventions = 'CF-1.6'
fh.close()
