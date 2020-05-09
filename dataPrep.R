library(tidyverse)
data.confirmed <-
  read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv") %>%
  rename(Province_State = `Province/State`,
         Country_Region = `Country/Region`) %>%
  gather(key = date, value = num_confirmed, 
         -Lat, -Long, -Province_State, -Country_Region) %>%
  mutate(date = as.Date(date, format = "%m/%d/%y"))

data.deaths <- 
  read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv") %>%
  rename(Province_State = `Province/State`,
         Country_Region = `Country/Region`) %>%
  gather(key = date, value = num_deaths, 
         -Lat, -Long, -Province_State, -Country_Region) %>%
  mutate(date = as.Date(date, format = "%m/%d/%y"))

data.recovered  <-
  read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv") %>%
  rename(Province_State = `Province/State`,
         Country_Region = `Country/Region`) %>%
  gather(key = date, value = num_recovered, 
         -Lat, -Long, -Province_State, -Country_Region) %>%
  mutate(date = as.Date(date, format = "%m/%d/%y"))

data <-
  data.confirmed %>%
  full_join(data.deaths) %>%
  full_join(data.recovered) %>%
  arrange(date, Country_Region, Province_State) %>%
  select(date, Country_Region, Province_State, starts_with("num"))

data2 <-
  data %>%
  group_by(date, Country_Region) %>%
  summarize(num_confirmed_sum = sum(num_confirmed),
            num_recovered_sum = sum(num_recovered),
            num_deaths_sum = sum(num_deaths)) %>%
  ungroup()
