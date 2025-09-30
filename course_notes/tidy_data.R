library(tidyverse)

# In tidy data...each VARIABLE forms a COLUMN.
# ...each ROW is an OBSERVATION.
# ...each CELL is a VALUE or MEASUREMENT.



table1 # this one is tidy format!
table2
table3
table4a
table4b

table1 |> 
  mutate(rate = cases / population * 1000)

table1 |> # to look at total cases per year
  group_by(year) |> 
  summarize(total = sum(cases))

table1 |> 
  ggplot(mapping = aes(x = year, y = cases)) +
  geom_line()

table_rate <- table1 |> 
  mutate(rate = cases / population * 1000)


# Pivot functions---------------------

 # pivot_longer
table4a |> 
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases")

table4b |> 
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "population")

table4a_tidy <- table4a |> # to store the new table we've created
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases")


 # pivot_wider
table2 |> 
  pivot_wider(names_from = type, values_from = count)

table3 |> 
  separate(rate, into = c("cases", "population"), sep = "/", convert = TRUE)

table3 |> 
  separate(year, into = c("century", "year"), sep = 1)

table5 <- table3 |> 
  separate(year, into = c("century", "year"), sep = 2)

table5 |> 
  unite(fullyear, century, year, sep = "")



coronavirus <- read_csv('https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus.csv')
View(coronavirus)

coronavirus |> 
  filter(country == "US", cases >= 0) |> 
  ggplot() +
  geom_line(aes(x = date, y = cases, color = type))

corona_wide <- coronavirus |> # spreading the vaules under "type" into their own columns?
  pivot_wider(names_from = type, values_from = cases)


coronavirus_ttd <- coronavirus |> 
  group_by(country, type) |>
  summarize(total_cases = sum(cases)) |>
  pivot_wider(names_from = type, values_from = total_cases)

ggplot(coronavirus_ttd) +
  geom_label(mapping = aes(x = confirmed, y = death, label = country))
  
  




