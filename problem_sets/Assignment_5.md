# Assignment 5


``` r
knitr::opts_chunk$set(warning = FALSE, message = FALSE)
```

First, load all the required packages with the following code. Install
them if they are not installed yet.

``` r
library(tidyverse)
library(knitr)
library(gapminder) # install.packages("gapminder")
```

## Exercise 1. Trends in land value

**This excercise uses a dataset that describes the trends in land value
(`Land.Value`), among other variables, in different states in the US
1975-2013. The states are grouped into four different regions, under the
variable `region`. This dataset was obtained from the Data Science
Services of Harvard University.**

``` r
housing <- read_csv("https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/landdata_states.csv")
housing %>%
  head() %>% 
  kable() 
```

| State | region | Date | Home.Value | Structure.Cost | Land.Value | Land.Share..Pct. | Home.Price.Index | Land.Price.Index | Year | Qrtr |
|:---|:---|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| AK | West | 2010.25 | 224952 | 160599 | 64352 | 28.6 | 1.481 | 1.552 | 2010 | 1 |
| AK | West | 2010.50 | 225511 | 160252 | 65259 | 28.9 | 1.484 | 1.576 | 2010 | 2 |
| AK | West | 2009.75 | 225820 | 163791 | 62029 | 27.5 | 1.486 | 1.494 | 2009 | 3 |
| AK | West | 2010.00 | 224994 | 161787 | 63207 | 28.1 | 1.481 | 1.524 | 2009 | 4 |
| AK | West | 2008.00 | 234590 | 155400 | 79190 | 33.8 | 1.544 | 1.885 | 2007 | 4 |
| AK | West | 2008.25 | 233714 | 157458 | 76256 | 32.6 | 1.538 | 1.817 | 2008 | 1 |

#### 1.1 Washington DC was not assigned to a region in this dataset. According to the United States Census Bureau, however, DC is part of the South region. Here:

``` r
housing |> 
  mutate(region = ifelse(State == "DC", "South", region)) |> 
  select(region, State, Land.Value, Date) |> 
  head() |> 
  kable()
```

| region | State | Land.Value |    Date |
|:-------|:------|-----------:|--------:|
| West   | AK    |      64352 | 2010.25 |
| West   | AK    |      65259 | 2010.50 |
| West   | AK    |      62029 | 2009.75 |
| West   | AK    |      63207 | 2010.00 |
| West   | AK    |      79190 | 2008.00 |
| West   | AK    |      76256 | 2008.25 |

#### 1.2 Generate a tibble/dataframe that summarizes the mean land value of each region at each time point and show its first 6 lines.

``` r
housing |> 
  group_by(region, Date) |> 
  summarize(mean_land_value = mean(Land.Value)) |> 
  head() |> 
  kable()
```

| region  |    Date | mean_land_value |
|:--------|--------:|----------------:|
| Midwest | 1975.25 |        2452.167 |
| Midwest | 1975.50 |        2498.917 |
| Midwest | 1975.75 |        2608.167 |
| Midwest | 1976.00 |        2780.000 |
| Midwest | 1976.25 |        2967.333 |
| Midwest | 1976.50 |        3212.833 |

#### 1.3 Using the tibble/dataframe from 1.2, plot the trend in mean land value of each region through time.

``` r
housing1 <- housing |> 
  mutate(region = ifelse(State == "DC", "South", region)) |> 
  select(region, State, Land.Value, Date)

housing1 |> 
  group_by(region, Date) |> 
  summarize(mean_land_value = mean(Land.Value)) |> 
  ggplot(mapping = aes(x = Date, y = mean_land_value, color = region)) +
    geom_line()
```

![](Assignment_5_files/figure-commonmark/unnamed-chunk-6-1.png)

## Exercise 2. Life expectancy and GDP per capita 1952-2007

This exercise uses the `gapminder` dataset from the `gapminder` package.
It describes the life expectancy (`lifeExp`), GDP per capita
(`gdpPercap`), and population (`pop`) of 142 countries from 1952 to
2007. These countries can be grouped into 5 continents. As a
reminder,**reproduce the following plots exactly as shown**.

``` r
gapminder |> 
  head() |> 
  kable()
```

| country     | continent | year | lifeExp |      pop | gdpPercap |
|:------------|:----------|-----:|--------:|---------:|----------:|
| Afghanistan | Asia      | 1952 |  28.801 |  8425333 |  779.4453 |
| Afghanistan | Asia      | 1957 |  30.332 |  9240934 |  820.8530 |
| Afghanistan | Asia      | 1962 |  31.997 | 10267083 |  853.1007 |
| Afghanistan | Asia      | 1967 |  34.020 | 11537966 |  836.1971 |
| Afghanistan | Asia      | 1972 |  36.088 | 13079460 |  739.9811 |
| Afghanistan | Asia      | 1977 |  38.438 | 14880372 |  786.1134 |

#### 2.1 Use a scatterplot to explore the relationship between per capita GDP (`gdpPercap`) and life expectancy (`lifeExp`) in the year 2007.

``` r
gapminder |> 
  filter(year == "2007") |> 
  ggplot(mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point()
```

![](Assignment_5_files/figure-commonmark/unnamed-chunk-8-1.png)

#### 2.2 Add a smoothing line to the previous plot.

``` r
gapminder |> 
  filter(year == "2007") |> 
  ggplot(mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  geom_smooth()
```

![](Assignment_5_files/figure-commonmark/unnamed-chunk-9-1.png)

#### 2.3 Exclude Oceania from the previous plot, show each continent in a different color, and fit a separate smoothing line to each continent to identify differences in this relationship between continents. Turn off the confidence intervals.

Note: only two Oceanian countries are included in this dataset,
and `geom_smooth()` does not work with two data points, which is why
they are excluded.

``` r
gapminder |> 
  filter(year == "2007", continent != "Oceania") |> 
  ggplot(mapping = aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() +
  geom_smooth(se = FALSE)
```

![](Assignment_5_files/figure-commonmark/unnamed-chunk-10-1.png)

#### 2.4 Use faceting to solve the same problem. Include the confidence intervals in this plot.

``` r
gapminder |> 
  filter(year == "2007", continent != "Oceania") |> 
  ggplot(mapping = aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() +
  geom_smooth() +
  facet_wrap(~continent) 
```

![](Assignment_5_files/figure-commonmark/unnamed-chunk-11-1.png)

#### 2.5 Explore the trend in life expectancy through time in each continent. Color by continent.

``` r
gapminder |> 
  select(lifeExp, year, continent) |> 
  ggplot(mapping = aes(x = year, y = lifeExp, color = continent)) +
  geom_path() +
  facet_wrap(~continent)
```

![](Assignment_5_files/figure-commonmark/unnamed-chunk-12-1.png)

#### 2.6 From the previous plot, we see some abnormal trends in Asia and Africa, where the the life expectancy in some countries sharply dropped at certain time periods. Here, we look into what happened in Asia in more detail. First, create a new dataset by filtering only the Asian countries. Show the first 6 lines of this filtered dataset.

``` r
gapminder_Asia <- gapminder |> 
  filter(continent == "Asia")

head(gapminder_Asia) |> 
  kable()
```

| country     | continent | year | lifeExp |      pop | gdpPercap |
|:------------|:----------|-----:|--------:|---------:|----------:|
| Afghanistan | Asia      | 1952 |  28.801 |  8425333 |  779.4453 |
| Afghanistan | Asia      | 1957 |  30.332 |  9240934 |  820.8530 |
| Afghanistan | Asia      | 1962 |  31.997 | 10267083 |  853.1007 |
| Afghanistan | Asia      | 1967 |  34.020 | 11537966 |  836.1971 |
| Afghanistan | Asia      | 1972 |  36.088 | 13079460 |  739.9811 |
| Afghanistan | Asia      | 1977 |  38.438 | 14880372 |  786.1134 |

#### 2.7 Using the filtered dataset, identify the countries that had abnormal trends in life expectancy **by plotting**, and discuss historical events possibly explaining these trends. (Hint: facet by country)

``` r
gapminder_Asia |> 
  select(lifeExp, year, country) |> 
  ggplot(mapping = aes(x = year, y = lifeExp, color = country)) +
  geom_point() +
  facet_wrap(~country)
```

![](Assignment_5_files/figure-commonmark/unnamed-chunk-14-1.png)

**Answer:** The unusual trends that jump out at me are North Korea and
Iraq which are both places that the US has gone to war with in the past
four decades. The sudden life expectancy dips in Cambodia and China in
the 1950s-1960s could be explained by the rise in the Communist movement
that saw to the deaths of 2 million of their own people during that
period.
