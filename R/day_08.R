# Bryn McGowan
# Daily Assignment 8
# Sept 2 2020

library (tidyverse)
library (dplyr)
library (ggplot2)
library(ggthemes)
library(zoo)

covid = read.csv('https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv')

state.of.interest = "New York"

newyork_covid <- covid %>%
  filter(state == state.of.interest) %>%
  group_by(date) %>%
  summarize(cases = sum(cases)) %>%
  mutate(newCases = cases - lag(cases)) %>%
  mutate(roll7 = rollmean(newCases, 7, fill = NA, align="right"))

ggplot(data = newyork_covid, aes(x = date)) +
  geom_col(aes(y = newCases), col = NA, fill = "red") +
  geom_line(aes(y = roll7), col = "darkred", size = 1) +
  theme_bw() +
  labs(x = "Date",
       y = "Number of Cases",
       title = "Daily New COVID Cases in New York",
       subtitle = "COVID-19 Data: NY-Times",
       caption = "Daily Exercise 08")

ggsave("img/newyorkcases.png")
