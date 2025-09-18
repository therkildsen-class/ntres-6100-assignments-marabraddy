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

# Exercise: Subset the data to only show the death counts in three European countries on today’s date in 2021.
filter(coronavirus, country %in% c("United Kingdom", "France", "Spain"), type == "death", date == "2021-09-16")

View(count(coronavirus, country))
select(coronavirus, date, country, type, cases)
select(coronavirus, -province)

select(coronavirus, country, lat, long)
select(coronavirus, date:cases)
select(coronavirus, 1:3)
select(coronavirus, contains('o')) # selects variables with the letter 'o' in the name

select(coronavirus_us, -lat, -long, -province) # when you want to drop a variable from the dataset
coronavirus_us2 <- select(coronavirus_us, -lat, -long, -province) # create a new object called 'coronavirus_us2'


# Pipe Operator ---------------------
|> # pipe operator shortcut: shift-control-m

coronavirus |> # a shortened way to reduce how many arguments we use to create objects, less typing too!
  filter(country == "US") |> 
  select(-lat, -long, -province)

coronavirus |> # creates a list of the indicated variable with the nubmer of data points for each variable. Also good for checking the spelling of variables.
  count(country) |> 
  view()

 # Exercise: Use the |> piping function to subset the coronavirus dataset to only include the daily death counts in the US, Canada, and Mexico and including only the following variables in this order: country, date, cases. Then combine your new data wrangling skills with the ggplot skills we covered last week to visualize how the daily death counts have changed over time in those three countries.
coronavirus |> 
  filter(type == "death", country %in% c("US", "Canada", "Mexico")) |> 
  select(country, date, cases) |> 
  ggplot() + 
    geom_line(mapping = aes(x = date, y = cases, color = country))


  
  # Vaccine data ----------------------
vacc <- read_csv("https://raw.githubusercontent.com/RamiKrispin/coronavirus/main/csv/covid19_vaccine.csv")
View(vacc)

max(vacc$date)

vacc |> 
  filter(date == max(date)) |> 
  select(country_region, continent_name, people_at_least_one_dose, population) |> 
  mutate(vaxxrate = people_at_least_one_dose / population, 2)

 # Exercise: Add a new variable that shows how many doses of vaccine on average have been distributed per person considered fully vaccinated for each country. First look the patterns across all countries, then only show data for countries that have distributed more than 200 million doses. 
vacc |> 
  filter(date == max(date)) |> 
  select(country_region, continent_name, doses_admin, people_at_least_one_dose, population) |>
  mutate(doses_per_vaxxed = doses_admin / people_at_least_one_dose) |> 
  ggplot() +
    geom_histogram(mapping = aes(x = doses_per_vaxxed))

 # Exercise: Add a new variable that shows how many doses of vaccine on average have been distributed per person considered fully vaccinated for each country. First look the patterns across all countries, then only show data for countries that have distributed more than 200 million doses. 
vacc |> 
  filter(date == max(date), doses_admin > 200 * 10^6) |> 
  select(country_region, continent_name, doses_admin, people_at_least_one_dose, population) |>
  mutate(doses_per_vaxxed = doses_admin / people_at_least_one_dose)

vacc |> 
  filter(date == max(date)) |> 
  select(country_region, continent_name, doses_admin, people_at_least_one_dose, population) |>
  mutate(doses_per_vaxxed = doses_admin / people_at_least_one_dose) |> 
  filter(doses_per_vaxxed > 3) |> 
  arrange (-doses_per_vaxxed) # put a minus sign to sort from high to low


 # Exercise: In how many countries do >90% of the population have at least one dose and which five countries have the highest vaccination rates (proportion of their population given at least one dose), according to this dataset?
vacc |> 
  filter(date == max(date)) |> 
  select(country_region, continent_name, doses_admin, people_at_least_one_dose, population) |>
  mutate(vaxxrate = people_at_least_one_dose / population) |> 
  filter(vaxxrate > 0.9) |> 
  arrange(-vaxxrate) |> 
  head()
    