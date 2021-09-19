

rm(list = ls())

library(rgdal)
library(dplyr)
library(stringr)
library(leaflet)

library(leaflet.extras)
library(leaflet.providers)

library(htmltools)


str_file_path_geo <- 
  "/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map/pc_wgs_84_geo_fixed.json"


aus_pc_geo <- rgdal::readOGR(str_file_path_geo)


vct_farbe <-
  c("#d53e4f", "#fc8d59", "#fee08b", "#e6f598", "#99d594", "#3288bd")

aus_pc_geo$col <- 
  sample(vct_farbe, size = nrow(aus_pc_geo), replace = TRUE)


saveRDS(aus_pc_geo, file = "/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map/aus_pc_geo.rds") 

dd <- readRDS("/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map/aus_pc_geo.rds")


m <-
  leaflet(aus_pc_geo) %>%
  setView(lng = 151.20, lat = -33.86, zoom = 10) %>%
  addTiles() %>%
  addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
              opacity = 1.0, fillOpacity = 0.5,
              fillColor = aus_pc_geo$col,
              highlightOptions = highlightOptions(color = "white", weight = 2,
                                                  bringToFront = TRUE))


m



MBaccessToken <- "pk.eyJ1IjoibWFya2FsbGFuaGF0Y2hlciIsImEiOiJja3Rxc3B0dmYwenFnMnBwM2YyaTQxMWl6In0.M7rxYpHfS-UksT6OYYU4sA"


m <-
  leaflet(aus_pc_geo) %>%
  setView(lng = 151.20, lat = -33.86, zoom = 10) %>%

  addProviderTiles("MapBox", 
                   options = providerTileOptions(id = "mapbox.light",
                                                 noWrap = FALSE, 
                                                 accessToken = MBaccessToken)) %>%
  
  
   addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
              opacity = 1.0, fillOpacity = 0.5,
              fillColor = aus_pc_geo$col,
              highlightOptions = highlightOptions(color = "white", weight = 2,
                                                  bringToFront = TRUE))





labels <- sprintf(
  "<strong>%s</strong><br/>%g people / mi<sup>2</sup>",
  states$name, states$density
) %>% lapply(htmltools::HTML)


m
# Some of these work and some dont...?
# http://leaflet-extras.github.io/leaflet-providers/preview/



labels <- sprintf(
  "<strong>%s</strong><br/>%g people / mi<sup>2</sup>",
  aus_pc_geo$locality, aus_pc_geo$AREA_SQKM
) %>% lapply(htmltools::HTML)



# ==========================================================================
# ==========================================================================
# ==========================================================================

m <-
  leaflet(aus_pc_geo, height = 700, width = 1000)  %>%
  setView(lng = 151.20, lat = -33.86, zoom = 10) %>%
  
  addProviderTiles("CartoDB.DarkMatter")   %>%
  
  
  addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
              opacity = 1.0, fillOpacity = 0.4,
              fillColor = aus_pc_geo$col,
              highlightOptions = highlightOptions(color = "white", weight = 2,
                                                  bringToFront = TRUE),   
              
              label = labels,
              labelOptions = labelOptions(
                style = list("font-weight" = "normal", padding = "3px 8px"),
                textsize = "15px",
                direction = "auto")
              
              )

m

saveRDS(m, "/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map/leaflet_map.rds")




# ==========================================================================
# ==========================================================================
# ==========================================================================


# "Stamen.Toner

leaflet() %>%
  addProviderTiles("Stamen.Watercolor") %>%
  addProviderTiles("Stamen.TonerHybrid")


