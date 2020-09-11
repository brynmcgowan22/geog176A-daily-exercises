# Bryn McGowan
# 08/18/2020
# Daily assignment 6

library(tidyverse)

url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'

covid = read_csv(url)

covid %>%
  filter(date == max(date)) %>%
  group_by(state) %>% summarize(cases = sum(cases, na.rm = TRUE)) %>%
  ungroup() %>%
  slice_max(cases, n = 6) %>%
  pull(state)

topstates <- covid %>%
  filter(state %in% c("California","Florida","Texas","New York","Georgia","Illinois"))

gg = ggplot(data = topstates, aes(x = date, y = cases)) +
  geom_line(aes(color = state)) +
  labs(title = "Cumulative Case Counts: COVID-19 Pandemic",
       x = "Date",
       y = "Cases") +
  facet_wrap(~state) +
  theme_minimal()

ggsave(gg, file = "img/statecovid.jpg")

usa <- covid %>%
  group_by(date) %>% summarize(cases = sum(cases, na.rm = TRUE)) %>%
  ungroup()

gg2 = ggplot(data = usa, aes(x = date, y = cases)) +
  geom_col(fill = "darkred") +
  geom_line(color = "darkred", size = 2) +
  labs(title = "National Cumulative Case Counts: COVID-19 Pandemic",
       x = "Date",
       y = "Cases") +
  theme_minimal()

ggsave(gg2, file = "img/nationaltotals.jpg")

