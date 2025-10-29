library(tidyverse)

# the basic syntax
function_name <- function(inputs) {
  output_value <- do_something(inputs)
  return(output_value)
  

calc_shrub_vol <- function(length, width, height) {
  area <- length * width
  volume <- area * height
  return(volume)
}

calc_shrub_vol(0.8, 1.6, 2.0)
# OR
calc_shrub_vol(length = 0.8, width = 1.6, height = 2.0)


# exercise 
convert_pounds_to_grams <- function(pounds) {
  grams <- 453.6 * pounds
  return(grams)
}
convert_pounds_to_grams(3.75)

# exercise
est_shrub_mass <- function(volume){
  mass <- 2.65 * volume^0.9
  return(mass)
}

shrub_volume <- calc_shrub_vol(0.8, 1.6, 2.0)
shrub_mass <- est_shrub_mass(shrub_volume)
# this gets a little convoluted...

# so let's use tidyverse piping
calc_shrub_vol(0.8, 1.6, 2.0) |> 
  est_shrub_mass()


est_shrub_mass_from_raw <- funtion(length, width, height){
  volume <- calc_shrub_vol(length, width, height)
  mass <- est_shrub_mass(volume)
  return(mass)
}




  