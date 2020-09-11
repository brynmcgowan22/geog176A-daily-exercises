# Bryn McGowan
# Daily Assignment 12
# Sept 11 2020

library(tidyverse)
library(USAboundaries)
library(USAboundariesData)
library(sf)


states = us_states() %>%
  filter(name != "Alaska" & name != "Puerto Rico" & name != "Hawaii")

south_dakota = states %>%
  filter(name == "South Dakota")

touch_sd = st_filter(states, south_dakota, .predicate = st_touches)

sd_map = ggplot() +
  geom_sf(data = states) +
  geom_sf(data = touch_sd, fill = "red", alpha = 0.5) +
  labs(title = "States That Border South Dakota",
       x = "Longitude",
       y = "Latitude") +
  theme_classic()

ggsave(sd_map, file = "~/github/geog176A-daily-exercises/img/bordersouthdakota.png")
