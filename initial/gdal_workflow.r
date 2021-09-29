

rm(list = ls())

library(rgdal)
library(dplyr)
library(stringr)
library(leaflet)

library(leaflet.extras)
library(leaflet.providers)

library(htmltools)

library(Cairo)


str_file_path_geo <- 
  "/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map/pc_wgs_84_geo_fixed.json"


aus_pc_geo <- rgdal::readOGR(str_file_path_geo)


vct_farbe <-
  c("#d53e4f", "#fc8d59", "#fee08b", "#e6f598", "#99d594", "#3288bd")

vct_map_colour <- 
  sample(vct_farbe, size = nrow(aus_pc_geo), replace = TRUE)


vct_vals <- c("one", "two", "three", "four", "five")

lst_lables <- sprintf(
  "<strong>%s</strong><br/>%g people / mi<sup>2</sup>",
  aus_pc_geo$locality, aus_pc_geo$AREA_SQKM
) %>% lapply(htmltools::HTML)

qpal <- colorQuantile("RdYlBu", aus_pc_geo$AREA_SQKM, n = 6)




aus_pc_geo$pc_rpt <- runif(nrow(aus_pc_geo@data))

str_carto_nl <- "CartoDB.DarkMatterNoLabels"
qpal <- colorQuantile("Blues", 1 / aus_pc_geo$pc_rpt, n = 6, na.color = "#999999")

int_opacity_fill <- 0.7

q <-
  leaflet(aus_pc_geo, height = 600, width = 1000)  %>%
  setView(lng = 151.20, lat = -33.86, zoom = 10) %>%
  
  # setup layering...
 addMapPane("base_map", zIndex = 405) %>%
  addMapPane("polygons", zIndex = 410) %>%
  addMapPane("base_map_labels", zIndex = 415) %>%
  addMapPane("popup_labels", zIndex = 430) %>%
  
  
  # base map here without labels
  addProviderTiles("CartoDB.DarkMatterNoLabels"
                   ,options = providerTileOptions(pane = "base_map")
                   
                   )  %>%
  
  # base map with labels only....
  addProviderTiles("CartoDB.DarkMatterOnlyLabels"
                   ,options = providerTileOptions(pane = "base_map_labels")
                   ) %>%
  
  addPolygons(color = "#444444", weight = 0.5, smoothFactor = 0.5,
              opacity = 1.0, fillOpacity = int_opacity_fill,
              fillColor = ~qpal(1 / aus_pc_geo$pc_rpt),
              
             options = pathOptions(pane = "polygons"),
              
              highlightOptions = highlightOptions(color = "white", weight = 2,
                                                  bringToFront = TRUE),
              # and now for the pop ups....
              label = lst_lables,
              labelOptions = labelOptions(
                style = list("font-weight" = "normal", padding = "3px 8px"),
                textsize = "15px",
                pane = "popup_labels",
                direction = "auto")
  ) %>%
  
  addLegend("bottomright", pal = qpal, values = ~1 / aus_pc_geo$pc_rpt,
            title = "Quantiles: CIDs per capita",
            opacity = int_opacity_fill,
            na.label = "No data available")

q


str_fp <- "/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map/leaflet_map.rds"
saveRDS(q, str_fp)
























str_fp <- "/home/ruc9s4/Documents/postcodes/leaflet_map_dark.rds"
saveRDS(q, str_fp)

q

















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
  
  addProviderTiles("CartoDB.DarkMatterNoLabels")   %>%
  
  
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
              
              )  %>%

addProviderTiles("CartoDB.DarkMatterOnlyLabels")  

m


vct_farbe <-
  c("#d53e4f", "#fc8d59", "#fee08b", "#e6f598", "#99d594", "#3288bd")

aus_pc_geo$col <- 
  sample(vct_farbe, size = nrow(aus_pc_geo), replace = TRUE)


vct_map_colour <- aus_pc_geo$col



q <-
  leaflet(aus_pc_geo, height = 600, width = 1000)  %>%
  setView(lng = 151.20, lat = -33.86, zoom = 10) %>%
  
  addProviderTiles("CartoDB.DarkMatterNoLabels",
                   options = providerTileOptions(zIndex = 1)) %>%
  
  addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
              opacity = 1.0, fillOpacity = 0.4,
              fillColor = vct_map_colour,
              options = pathOptions(zIndex = 2),
              highlightOptions = highlightOptions(color = "white", weight = 2,
                                                  bringToFront = FALSE),  
              
              label = labels,
              labelOptions = labelOptions(
                style = list("font-weight" = "normal", padding = "3px 8px"),
                textsize = "15px",
                direction = "auto")
              
  ) %>%
  addProviderTiles("CartoDB.DarkMatterOnlyLabels",
                   options = providerTileOptions(zIndex = 5, opacity = 1))









str_fp <- "/home/ruc9s4/Documents/postcodes/leaflet_map_dark.rds"
saveRDS(q, str_fp)

q








saveRDS(m, "/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map/leaflet_map.rds")




# ==========================================================================
# ==========================================================================
# ==========================================================================
# "Stamen.Toner

leaflet() %>%
  addProviderTiles("Stamen.Watercolor") %>%
  addProviderTiles("Stamen.TonerHybrid")


