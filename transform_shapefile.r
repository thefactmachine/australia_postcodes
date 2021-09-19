rm(list = ls())

library(sp)
library(sf)
library(dplyr)
library(geojsonio)


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


sf_pc_wgs_84_join_non_emp <- 
  sf_pc_wgs_84_join[!sf::st_is_empty(sf_pc_wgs_84_join), ]


# may need to convert this to geo_json
sf::st_write(sf_pc_wgs_84_join_non_emp, 
             "/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map/POA_WGS_84/pc_wgs_84.shp")



str_pth_gs <- "/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map/geo_json_wgs84.json"
geojsonio::file_to_geojson(sf_pc_wgs_84_join_non_emp, method = "web", output =  str_pth_gs)





