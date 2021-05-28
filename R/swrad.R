#' daily data from short wave radiation
#'
#' function for generate daily values from short wave radiation by latitude.
#' @param x latitude of study zone
#' @param blaney.criddle a list of 3 dataframes: first list is light hours per day,
#' second list is maximum hours and third list is extraterrestial radiation.
#' @param start start year of time serie of radiation, default value is 1981
#' @param end end year of time serie of radiation, default value is 2016
#' @export
#' @name swrad

swrad <- function(x, blaney.criddle, start = NULL, end = NULL){
  r <- x%%5
  n <- floor(x - r)
  idx <- match(n, blaney.criddle$light.hours$latitud)
  v <- rep(NA, 12)

  if(r == 0){
    j <- blaney.criddle$light.hours$latitud[idx]
    k <- j

    for (i in 1:12) {
      v[i] <- blaney.criddle$light.hours[,i+1][idx]
    }
    light.hours <- v * 24

  } else if(r > 0){
    j <- blaney.criddle$light.hours$latitud[idx]
    k <- blaney.criddle$light.hours$latitud[idx-1]
    for (i in 1:12) {
      diff <- blaney.criddle$light.hours[,i+1][idx-1] - blaney.criddle$light.hours[,i+1][idx]
      v[i] <- blaney.criddle$light.hours[,i+1][idx] + diff*(x-j)/(k-j)
    }
    light.hours <- v * 24

  }

  ###############################################################################
  #maximum hours

  r <- x%%5
  n <- floor(x - r)
  idx <- match(n, blaney.criddle$max.hours$latitud)
  v <- rep(NA, 12)

  if(50 >= x & x > 40){
    r <- x%%2
    n <- floor(x - r)
    idx <- match(n, blaney.criddle$max.hours$latitud)
  }

  if(r == 0){
    j <- blaney.criddle$max.hours$latitud[idx]
    k <- j

    for (i in 1:12) {
      v[i] <- blaney.criddle$max.hours[,i+1][idx]
    }
    max.hours <- v

  } else if(r > 0){
    j <- blaney.criddle$max.hours$latitud[idx]
    k <- blaney.criddle$max.hours$latitud[idx-1]
    for (i in 1:12) {
      diff <- blaney.criddle$max.hours[,i+1][idx-1] - blaney.criddle$max.hours[,i+1][idx]
      v[i] <- blaney.criddle$max.hours[,i+1][idx] + diff*(x-j)/(k-j)
    }
    max.hours <- v

  }
  ###############################################################################

  relation <- light.hours/max.hours

  ###############################################################################
  #rad extra

  r <- x%%5
  n <- floor(x - r)
  idx <- match(n, blaney.criddle$radiation$latitud)
  v <- rep(NA, 12)

  if(0 > x & x >= -20){
    r <- x%%2
    n <- floor(x - r)
    idx <- match(n, blaney.criddle$radiation$latitud)
  }

  if(r == 0){
    j <- blaney.criddle$radiation$latitud[idx]
    k <- j

    for (i in 1:12) {
      v[i] <- blaney.criddle$radiation[,i+1][idx]
    }
    rad_ext <- v

  } else if(r > 0){
    j <- blaney.criddle$radiation$latitud[idx]
    k <- blaney.criddle$radiation$latitud[idx-1]
    for (i in 1:12) {
      diff <- blaney.criddle$radiation[,i+1][idx-1] - blaney.criddle$radiation[,i+1][idx]
      v[i] <- blaney.criddle$radiation[,i+1][idx] + diff*(x-j)/(k-j)
    }
    rad_ext <- v

  }

  ###############################################################################
  swrad <- 2.45*(rad_ext*(0.25 + 0.5*relation))

  ###############################################################################
  if(is.null(start)){
    start <- 1981
  }else if(is.numeric(start)){
    start <- round(start)
  }else if(!is.numeric(start)){
    stop("start it's not number")
  }

  if(is.null(end)){
    end <- 2016
  }else if(is.numeric(end)){
    end <- round(end)
  }else if(!is.numeric(end)){
    stop("end it's not number")
  }

  date <- seq( as.Date(paste0(start,"-01-01")), as.Date(paste0(end,"-12-31")), "days")
  df.rad <- data.frame(date = date, value = NA)

  idxm <- c("01", "02", "03","04", "05", "06","07", "08", "09","10", "11", "12")
  for (im in 1:12) {
    df.rad[substr((df.rad$date), 6, 7) == idxm[im],][,2] <- swrad[im]
  }
  return(df.rad)
}

#' @rdname swrad
