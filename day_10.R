library(tidyverse)
library(sf)
library(units)

cities = read_csv("data/uscities.csv")

cities_sf = cities %>%
  st_as_sf(coords = c("lng", "lat"), crs = 4326) %>%
  filter(state_id == "CA", city %in% c("Santa Barbara", "Walnut Creek"))

eqdc = '+proj=eqdc +lat_0=40 +lon_0=-96 +lat_1=20 +lat_2=60 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs'

cities_eqa = cities_sf %>%
  st_transform(crs = 5070)

cities_eqdc = cities_sf %>%
  st_transform(crs = eqdc)

cities_sf %>%
  st_distance
# 438312.8

cities_eqa %>%
  st_distance()
# 440531.2

cities_eqdc %>%
  st_distance()
# 432890.6
