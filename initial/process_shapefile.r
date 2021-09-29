

rm(list = ls())

library(rgdal)
library(sp)

library(sf)
library(dplyr)

library(stringr)

library(leaflet)

# library(geojsonio)
# /Users/mark/Documents/TEMP_not_on_cloud/2016_POA_shape


str_file_path_shape <- 
"/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map/POA_2016_AUST_SIMPLIFY/POA_2016_AUST.shp"

sf_pc <- sf::st_read(str_file_path_shape)

sf_pc_wgs_84 <- sf::st_transform(sf_pc, crs = st_crs("WGS84"))

sf_pc_wgs_84$POA_CODE <- NULL
sf_pc_wgs_84$POA_CODE16 <- NULL

df_pc <- 
  read.csv("/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map/australian_postcodes.csv") %>%
  select(id, postcode, locality)

df_pc$locality <- df_pc$locality %>% stringr::str_to_title()

df_pc$postcode <- 
  ifelse(nchar(df_pc$postcode) == 3,
         paste0("0", df_pc$postcode), df_pc$postcode)

df_pc_de_dup <- df_pc %>% group_by(postcode) %>% slice(1)

df_pc_de_dup$id <- NULL

vct_missing <- 
  sf_pc_wgs_84$POA_NAME[(!sf_pc_wgs_84$POA_NAME %in% df_pc_de_dup$postcode)]

df_missing <- data.frame(postcode = vct_missing, locality = "missing")

df_pc_de_dup <- dplyr::bind_rows(df_missing,df_pc_de_dup)

sf_pc_wgs_84_join <- 
  sf_pc_wgs_84 %>% 
  inner_join(df_pc_de_dup, by = c("POA_NAME" = "postcode"))


sf::st_write(sf_pc_wgs_84_join, "/Users/mark/Documents/TEMP_not_on_cloud/wgs_84/pc_wgs_84.shp")


sf_pc_wgs_84_join$quantile <- 
  sample(1:6, size = nrow(sf_pc_wgs_84_join), replace = TRUE)

vct_farbe <-
  c("#d53e4f", "#fc8d59", "#fee08b", "#e6f598", "#99d594", "#3288bd")


sf_pc_wgs_84_join$col <- 
  sample(vct_farbe, size = nrow(sf_pc_wgs_84_join), replace = TRUE)

names(sf_pc_wgs_84_join) <- 
  c("postcode", "area", "locality", "geometry", "quantile", "col")


object.size(sf_pc_wgs_84_join) %>% print(units = "auto")

sf_pc_wgs_84_join_non_emp <- 
  sf_pc_wgs_84_join[!sf::st_is_empty(sf_pc_wgs_84_join), ]


spdf_pc_wgs_84_join <- sf::as_Spatial(sf_pc_wgs_84_join_non_emp)



m <- leaflet(spdf_pc_wgs_84_join) %>% 
  setView(lng = 151.20, lat = -33.86, zoom = 10) %>%
  addTiles() %>%
  addPolygons(sf_pc_wgs_84_join, weight = 1, color = "#000000", fill = TRUE, 
              fillColor = sf_pc_wgs_84_join$col, fillOpacity = 0.9) 



spdf_pc_wgs_84_join



saveRDS(spdf_pc_wgs_84_join, file = "/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map/spdf_pc_wgs_84_join.rds") 

dd <- readRDS("/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map/spdf_pc_wgs_84_join.rds")

spdf_pc_wgs_84_join

spdf_pc_wgs_84_join_simp <- rmapshaper::ms_simplify(spdf_pc_wgs_84_join)

m <-
leaflet(spdf_pc_wgs_84_join_simp) %>%
  setView(lng = 151.20, lat = -33.86, zoom = 10) %>%
  addTiles() %>%
  addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
              opacity = 1.0, fillOpacity = 0.5,
              fillColor = spdf_pc_wgs_84_join$col,
              highlightOptions = highlightOptions(color = "white", weight = 2,
                                                  bringToFront = TRUE))















