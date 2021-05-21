# epwgen: extraction weather data from PISCO daily files and sun data daily generation for WGEN model.

The goal of epwgen package is to extraction weather data from PISCO (SENAMHI, Peru) daily files and
sun data daily generation for WGEN model.

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

This is a basic example which shows you how to solve a common problem:

``` r
library(epwgen)
tmnd <- "D:/PISCOd_tmn_v1.1.nc"
tmxd <- "D:/PISCOd_tmx_v1.1.nc"
lon <- -75.575
lat <- -11.572
nc.files <- c(ppd, tmnd, tmxd)
x <- data.frame(nc = nc.files, lon, lat)
daily.data <- pdwgen(x)
average.data <- pmwgen(daily.data)
```
## Credits

RPisco was developed by Geomar Perales. or any issue or suggestion please write
to: perales.geomar@gmail.com.

