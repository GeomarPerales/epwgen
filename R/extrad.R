#' monthly data from extraterrestrial radiation
#'
#' function for generate monthly data from extraterrestrial radiation by latitude.
#' @param x latitude of study zone
#' @param blaney.criddle a list of 3 dataframes: first list is light hours per day,
#' second list is maximum hours and third list is extraterrestial radiation.
#' @param unit value by default is "Mj", use "mm" for equivalent evaporation.
#' @export
#' @name extrad

extrad <- function(x, blaney.criddle, unit = NULL){

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
    if(is.null(unit)){
      return(rad_ext)
    }else if(unit == "mm"){
      return(rad_ext/0.408)
    }

  }

}

#' @rdname extrad
