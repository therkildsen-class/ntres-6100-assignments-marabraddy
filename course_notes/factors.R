library(tidyverse)


# Intro to Factors --------------------------------------------------------

x1 <- c("Dec", "Apr", "Jan", "Mar")

sort(x1) # default sorted alphabetically

month_levels <- c(
  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
)

y1 <- factor(x1, levels = month_levels)
sort(y1)



