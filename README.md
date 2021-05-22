# epwgen: extraction weather data from PISCO daily files and sun daily data generation for WGEN model.

The goal of epwgen package is to extraction weather data from PISCO (SENAMHI, Peru) daily files,
monthly average values from precipitation, minimum and maximum temperature and sun daily data
generation for WGEN model. 

## Installation

Step 1: Install devtools

``` r
> install.packages("devtools")
```

Step 2: From Github

``` r
> library(devtools)
> install_github("GeomarPerales/epwgen")
```

## Example

This is a basic example which shows you how to solve extract daily values of PISCO files and obtain
monthly average values of precipitation, minimum and maximum temperature:

``` r
#Extraction daily values from PISCO (precipitation and temperature)
library(epwgen)
ppd <- "D:/PISCOd_pp_v1.1.nc"
tmnd <- "D:/PISCOd_tmn_v1.1.nc"
tmxd <- "D:/PISCOd_tmx_v1.1.nc"
lon <- -75.575
lat <- -11.572
nc.files <- c(ppd, tmnd, tmxd)
x <- data.frame(nc = nc.files, lon, lat)
daily.data <- pdwgen(x)
average.data <- pmwgen(daily.data)
```
for generate daily values from short wave radiation by latitude:
``` r
data("blaney.criddle")
data <- swrad( -14.201, blaney.criddle)
```

## Credits

epwgen was developed by Geomar Perales. or any issue or suggestion please write
to: perales.geomar@gmail.com.

