library(tidyverse)
library(sf)
library(USAboundaries)


counties = USAboundaries::us_counties(resolution = "low") %>%
  filter(!state_name %in% c("Puerto Rico", "Alaska", "Hawaii")) %>%
  st_transform(5070)
cities = read_csv("data/uscities.csv") %>%
  st_as_sf(coords = c("lng", "lat"), crs = 4326) %>%
  st_transform(5070)



point_in_polygon = function(points, polygon, c_name){
  st_join(polygon, points) %>%
    st_drop_geometry() %>%
    count(get(c_name)) %>%
    rename(c("id" = "get(c_name)")) %>%
    left_join(polygon) %>%
    st_as_sf()

pip_plot = function(data){
  ggplot() +
    geom_sf(data = data, aes(fill = log(n)), alpha = .9, size = .2) +
    scale_fill_gradient(low = "white", high = "darkgreen") +
    theme_void() +
    theme(legend.position = 'none',
          plot.title = element_text(face = "bold", color = "darkgreen", hjust = .5, size = 18)) +
    labs(title = "Number of Cities Per US County",
         caption = paste0(sum(data$n), " locations represented"))
}

point_in_polygon(cities, counties, "geoid") %>%
  pip_plot()



