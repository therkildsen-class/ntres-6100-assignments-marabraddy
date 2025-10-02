library(tidyverse)
library(nycflights13) # install.packages("nycflights13")


# Row-binding -------------------------------------------------------------

fship <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Fellowship_Of_The_Ring.csv")
ttow <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Two_Towers.csv")
rking <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Return_Of_The_King.csv")

# combine the rows from the objects created above into one object....
lotr <- bind_rows(fship, ttow, rking)

fship_no_female <- fship |> 
  select(-Female) # leave out female
bind_rows(fship_no_female, ttow, rking)

# OR

fship_no_female <- fship |> 
  select(Male, Film, Race) # another way to leave out female
bind_rows(fship_no_female, ttow, rking)



# Join Functions ----------------------------------------------------------

flights
View(flights)

airlines
airports

planes |> 
  count(tailnum) # how many values/observations for each vairable (like tail number)? We can see that there is one value/observation for each plane tail number.

planes |> 
  count(year) |> 
  tail()

planes |> 
  count(tailnum) |> 
  filter(n > 1)




