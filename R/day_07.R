# Bryn McGowan
# 08/23/2020
# Daily assignment 7

library(tidyverse)

covid = read_csv('https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv')

region = data.frame(state = state.name, region = state.region)

region_covid <- covid %>%
  inner_join(region, by = c("state" = "state" ))

covid_by_region <- region_covid %>%
  group_by(date, region) %>%
  summarise(ncases = sum(cases), ndeaths = sum(deaths), .groups = 'drop') %>%
  pivot_longer(cols = c('ncases', 'ndeaths'))

covidbyregion = ggplot(data = covid_by_region, aes(x = date, y = value)) +
  geom_line(aes(col = region)) +
  facet_grid(name~region, scale = "free_y") +
  theme_linedraw() +
  theme(legend.position = "bottom") +
  theme(legend.position = "NA") +
  labs(title = "Cummulative Cases and Deaths: Region", y = "Daily Cumulative Count", x = "Date",
       caption = "Daily Exercise 07", subtitle = "COVID-19 Data: NY-Times")

ggsave(covidbyregion, file = "img/covidbyregion.png")
