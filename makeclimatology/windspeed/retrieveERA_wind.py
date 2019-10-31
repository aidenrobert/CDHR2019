#!/usr/bin/env python

## Code for climate change, natural disasters and human responses project
## Aiden Jonsson, MISU, July 2018
## Retrieval script for wind speed data from ERA-Interim

from ecmwfapi import ECMWFDataServer
import sys

## Take input value from command line
T = sys.argv[1]

## Call ECMWF data server and retrieve as netCDF file
## 165.128 is the parameter ID for u component of wind speed at 10 m
## 166.128 is the parameter ID for v component of wind speed at 10 m
server = ECMWFDataServer()
server.retrieve({
    "class": "ei",
    "dataset": "interim",
    "date": "%s-01-01/to/%s-12-31" % (T,T),
    "expver": "1",
    "grid": "0.75/0.75",
    "levtype": "sfc",
    "param": "165.128/166.128",
    "step": "3/6/9/12",
    "stream": "oper",
    "time": "00:00:00/12:00:00",
    "format": "netcdf",
    "type": "fc",
    "target": "out.nc",
})
