#Script for converting annual time period into smaller periods

#Converting year to days
y2d <- function(n_y){
  #n_y is the number of years to convert to days
  365.25*n_y
}

#Converting year to months
y2m <- function(n_y){
  #n_y is the number of years to convert to months
  12*n_y  
}
  
#Converting year to quarters
y2q <- function(n_y){
  #n_y is the number of years to convert to quarters
  4*n_y
}