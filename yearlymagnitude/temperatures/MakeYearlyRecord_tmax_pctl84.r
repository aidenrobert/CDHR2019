#!/usr/bin/env Rscript

### Script for counting number of meteorological events over threshold
### Written for Climate, Disasters, and Human Responses project
### Aiden Jönsson, 30 September 2019

library(raster)
library(GADMTools)
library(ncdf4)
library(ncdf4.helpers)
library(sf)
library(lubridate)

## Write a column maxima function
#colMax <- function(data) sapply(data, max, na.rm = TRUE)

## Read in GADM data of country shapes
global_temp <- st_read("GADM/gadm36_0.shp") #read in shapes of countries

## Make a standardized time array to find indexes in the meteorological data
time <- seq(as.Date("2006-01-01"), by="day", length.out = 4383) #make a date array

## Read in meteorological data as a raster brick
metdata <- brick("/proj/bolinc/users/x_aidjo/Disasters/tmax_modernpctl.nc",varname="pctl") #load meteorological data

## Specify the extents of the meteorological data
extent(metdata) <- c(-180.375,180.375,-90.375,90.375) #specify extent of meteorological data

## Start and end dates for the first year
start <- as.Date("2006-01-01")
end <- as.Date("2006-12-31")

## Make column names to save to and initialize in the data frame
years <- as.character(2006:2017)
global_temp[,years] <- 0

## Counter for the column name
t = 1

## Begin looping for each year
while (end < "2018-01-01") {
  
  ## Take index numbers of start and end dates
  index1 = which(time==start)
  index2 = which(time==end)
  
  ## Choose only meteorological data for that year
  now_metdata <- metdata[[index1:index2]]
  
  ##Loop through the countries in the data frame
  print(start)
  for (state in 1:256) {

    ## Get shape of current country
    place <- as(global_temp$geometry[state],"Spatial")
    
    ## Set coordinate format to same as in meteorological data
    place <- spTransform(place,crs(now_metdata))
    
    ## Extract the country's meteorological data
    extr = as.data.frame(raster::extract(now_metdata,place))
    #extr <- colMax(extr)
    
    ## Save the amount of events that exceed the threshold for the year
    global_temp[state,years[t]] <- sum(extr>84.13)/nrow(extr)
    print(global_temp[state,years[t]])
  }
  
  ## Update start and end dates and counter
  start <- start %m+% years(1)
  end <- end %m+% years(1)
  t <- t+1
  
}

## Save the data frame
save(global_temp,file="CDHR2019_tmax_pctl84.rda")
