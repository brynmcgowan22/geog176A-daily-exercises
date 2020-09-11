# Bryn McGowan
# Daily Assignment 10
# Sept 11 2020

library(tidyverse)
library(USAboundaries)
library(USAboundariesData)
library(sf)


conus = USAboundaries::us_states(resolution = "low") %>%
  filter(!name %in% c("Alaska", "Hawaii", "District of Columbia", "Puerto Rico"))

conus_mls = conus %>%
  st_combine() %>%
  st_cast("MULTILINESTRING")

plot(conus_mls)

conus_union = conus %>%
  st_union() %>%
  st_cast("MULTILINESTRING")

plot(conus_union)

