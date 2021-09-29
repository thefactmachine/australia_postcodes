rm(list = ls())

library(xml2)
library(dplyr)
library(fs)

str_stem <- 
  "/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map"

setwd(fs::path(str_stem, "auto_build"))

xml_head_sans_body <-
  xml2::read_html("header_body_sans_content.html",options = "NOCDATA") 

# ==========================================================================
# add css
txt_ext_css <- readr::read_file("external_styles.css")

xml_find_first(xml_head_sans_body , "/html/head") %>%
  xml_add_child("style", txt_ext_css, "type" = "text/css")

# ==========================================================================
# add header 
xml_div_container_header <- read_xml("<div class='container'></div>")
svg_header <- read_xml("header_graphic.svg")

xml_find_first(xml_div_container_header, "/div") %>% 
xml_add_child(svg_header)

xml_find_first(xml_head_sans_body , "/html/body") %>%
  xml_add_child(xml_div_container_header, .where = 1)


# ==========================================================================
# add overview
xml_overview <- read_xml("overview.xml")
xml_find_first(xml_head_sans_body , "/html/body/div[1]") %>%
  xml_add_sibling(xml_overview, .where = "after")

# ==========================================================================
# add postcodes
xml_postcodes <- read_html("accordion_postcodes.xml") %>% 
  xml_find_first("/html/body/div")

xml_find_first(xml_head_sans_body , "/html/body/div[2]") %>%
  xml_add_sibling(xml_postcodes, .where = "after")

# ==========================================================================
# add footer
xml_div_container_footer <- read_xml("<div class='container'></div>")
svg_footer <- read_xml("footer_ul_fin.svg")

xml_find_first(xml_div_container_footer, "/div") %>% 
  xml_add_child(svg_footer)

xml_find_first(xml_head_sans_body , "/html/body/div[3]") %>%
  xml_add_sibling(xml_div_container_footer, .where = "after")

# ==========================================================================
xml2::write_html(xml_head_sans_body, "index.html", options = "format_whitespace")

