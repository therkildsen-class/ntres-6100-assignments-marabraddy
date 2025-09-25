library(tidyverse)

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


 #pivot_wider
table2 |> 
  pivot_wider(names_from = type, values_from = count)








