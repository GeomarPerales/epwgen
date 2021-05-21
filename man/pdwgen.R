#' values extraction of PISCO daily files
#'
#' function for extract weather data from PISCO (SENAMHI, Peru) daily files from
#' precipitation, minimum and maximum temperature. PISCO is Peruvian Interpolated
#' Data of the Senamhi’s Climatological and Hydrologycal Observations.
#' @param x a dataframe with PISCO file names (in netCDF format) of precipitation
#' minimum and maximum temperature, longitude and latitude of station.
#' @importFrom raster brick
#' @importFrom raster projection
#' @importFrom raster extract
#' @importFrom sp coordinates
#' @import sp
#' @import raster
#' @export
#' @name pdwgen

pdwgen <- function(x){

  if(is.null(x)){
    stop("values not recognized")
  }

  colnames(x) <- c("nc", "v1", "v2")
  if(x$v1[1] < x$v2[1]){
    colnames(x) <- c("nc", "lon", "lat")
  } else if(x$v1[1] > x$v2[1]){
    colnames(x) <- c("nc", "lat", "lon")
  }

  file.nc <- as.character(x$nc)
  longitude <- as.numeric(x$lon)
  latitude <- as.numeric(x$lat)

  data <- list()
  for (i in 1:nrow(x)) {

    if(is.numeric(longitude[i]) & is.numeric(latitude[i])){
      coord <- data.frame(x = as.numeric(longitude[i]), y = as.numeric(latitude[i]))
    }  else {
      stop("coordinates not defined")
    }

    variable.raster <- raster::brick(file.nc[i])
    sp::coordinates(coord) <- ~ x + y
    raster::projection(coord) <- raster::projection(variable.raster)
    points <- raster::extract(variable.raster[[1]], coord, cellnumbers = T)[,1]
    Pisco.data <- t(variable.raster[points])

    study.range <- data.frame( Date = seq( from = as.Date("1981-01-01"), to = as.Date("2016-12-31"), by = "days"))
    Pisco.data <- cbind( study.range, format(as.vector(Pisco.data), scientific = F, digits = 2))
    row.names(Pisco.data) <- seq(1, nrow(Pisco.data), 1)
    colnames(Pisco.data) <- c("date", "values")
    data[[i]] <- Pisco.data
  }

  clim.data <- data.frame(matrix(NA, 13149, 4))
  colnames(clim.data) <- c("date", "PP", "TMN", "TMX")
  for (i in 1:nrow(x)) {
    clim.data[,1] <- data[[1]][,1]
    clim.data[,2] <- data[[1]][,2]
    clim.data[,3] <- data[[2]][,2]
    clim.data[,4] <- data[[3]][,2]
  }
  return(clim.data)
}

#' @rdname pdwgen
