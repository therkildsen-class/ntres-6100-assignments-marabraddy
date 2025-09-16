library(tidyverse)
# install.packages("skimr")
library(skimr)

coronavirus <- read_csv('https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus.csv')

summary(coronavirus)
skim(coronavirus)
View(coronavirus)

head(coronavirus) # shows first 6
tail(coronavirus) # shows last 6
head(coronavirus, 10) # shows first X that you indicate
tail(coronavirus, 12) # guess what this does!

coronavirus$cases # very long! hard to make sense of...
head(coronavirus$cases) # can do the same tests we tried before
str(coronavirus$cases) # it is a single numeric vector
summary(coronavirus$cases) # same information, formatted slightly differently


?filter
filter(coronavirus, cases > 0) 
filter(coronavirus, country == "US") 
filter(coronavirus, country != "US") 

coronavirus_us <- filter(coronavirus, country == "US")

filter(coronavirus, country == "US" | country == "Canada") # 'OR' function
filter(coronavirus, country == c("US", "Canada"))
filter(coronavirus, country %in% c("US", "Canada")) # included

filter(coronavirus, country == "US" & type == "death") # ampersand and comma are equivalent
filter(coronavirus, country == "US", type == "death") # ampersand and comma are equivalent

# exercise: Subset the data to only show the death counts in three European countries on today’s date in 2021.
filter(coronavirus, country %in% c("United Kingdom", "France", "Spain"), type == "death", date == "2021-09-16")

View(count(coronavirus, country))
select(coronavirus, date, country, type, cases)
select(coronavirus, -province)

select(coronavirus, country, lat, long)
select(coronavirus, date:cases)

select(coronavirus, 1:3)

