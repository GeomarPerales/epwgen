#' monthly average values of PISCO daily dataframe
#'
#' function for calculate monthly average values of PISCO daily dataframe from precipitation,
#' minimum and maximum temperature.
#' @param x a dataframe with PISCO daily dataframe from precipitation, minimum
#' and maximum temperature.
#' @export
#' @name pmwgen

pmwgen <- function(x){
  colnames(x) <- c("date", "PP", "TMN", "TMX")

  if(is.null(x)){
    stop("values not recognized")
  }

  date <- strftime(x$date, "%Y-%m")
  values <- list()
  data <- list()
  values[[1]] <- aggregate(as.numeric(as.vector(x[,2])),by = list(date),FUN = sum)

  for (i in 3:4) {
    values[[i-1]] <- aggregate(as.numeric(as.vector(x[,i])),by = list(date),FUN = mean)

  }

  min.yr <- as.numeric(substr(min(x$date),1,4))
  max.yr <- as.numeric(substr(max(x$date),1,4))
  yrs.numbs <- max.yr - min.yr + 1

  data.vector <- matrix(NA, 3, 12)

  for (i in 1:3) {
    data[[i]] <- t(matrix(values[[i]][,2], 12, yrs.numbs))
    data[[i]] <- data.frame(data[[i]])
    colnames(data[[i]]) <- c("values")
    for (j in 1:12) {
      data.vector[i, j] <- mean(data[[i]][, j])
    }
  }
  colnames(data.vector) <- month.abb
  rownames(data.vector) <- c("PP", "TMN", "TMX")
  return(data.vector)

}

#' @rdname pmwgen
