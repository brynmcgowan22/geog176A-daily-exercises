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

st_distance(cities_sf)
# 438312.8

st_distance(cities_eqa)
# 440531.2

st_distance(cities_eqdc) %>%
  set_units("km") %>%
  drop_units()
# 432890.6
# 432.8906
