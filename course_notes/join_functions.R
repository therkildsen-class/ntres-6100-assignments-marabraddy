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

airlines # looking for keys
airports

planes |> 
  count(tailnum) # how many values/observations for each variable (like tail number)? We can see that there is one value/observation for each plane tail number.

planes |> 
  count(tailnum) |> 
  filter(n > 1)

planes |> 
  count(year) |> 
  tail()

View(weather)
weather |>
  count(time_hour, origin)
  filter(n > 1)

planes |> 
  filter(is.na(tailnum)) # a way to check that every single row has a tailnum value for the tailnum variable/column

flights2 <- flights |> 
  select(year:day, hour, origin, dest, tailnum, carrier)
flights2

# combining the carrier column with the airlines dataset? how to make them match??
flights2 |> 
  left_join(airlines)

flights2 |> 
  left_join(weather)

flights2 |> 
  left_join(planes, join_by(tailnum))
# The year variable in 'plane' indicates the year the place was made. The year variable in "flights2" is the year the plane took off. This function helps us join the two sets without that confusion. The set codes year.x and year.y to distinguish the two columns.

# to rename the year.x and year.y columns...
flights2 |> 
  left_join(planes, join_by(tailnum), suffix = c("_flight", "_planes"))

flights2 |> 
  left_join(airports, join_by(origin == faa))

airports2 <- airports |> 
  select(faa, name, lat, lon)

flights2 |> 
  left_join(airports2, join_by(origin == faa)) |> 
  left_join(airports2, join_by(dest == faa), suffix = c("_origin", "_dest"))


airports |> 
  semi_join(flights2, join_by(faa == origin))

flights2 |> 
  anti_join(airports, join_by(dest == faa) |> 
  distinct(dest)


planes_gt100 <- flights2 |> 
  group_by(tailnum) |> 
  summarize(count = n()) |> 
  filter(count > 100)
# OR we can use...
planes_gt100 <- flights2 |> 
  count(tailnum) |> 
  filter(n > 100)

flights |> 
  semi_join(planes_gt100)


            