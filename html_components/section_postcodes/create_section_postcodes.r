rm(list = ls())

library(xml2)
library(dplyr)
library(fs)

setwd("/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map")

source("html_components/section_postcodes/create_tabs_for_postcodes.r")

# import html template
xml_accordion_skeleton <- 
  xml2::read_xml("html_components/section_postcodes/accordion_skeleton.xml")

xml_map_fragment <-
  xml2::read_html("html_components/section_postcodes/map_fragment.xml", 
                 options = "NOCDATA") %>% 
  xml2::xml_find_first("/html/body") %>% 
  xml_children()

xml_tabs <- 
  xml2::read_xml("html_components/section_postcodes/tabs_postcodes.xml", 
                 options = "NOCDATA")
xml_tabs_two <- 
  xml2::read_xml("html_components/section_postcodes/tabs_postcodes_tab2.xml", 
                 options = "NOCDATA")

# ===========================
# rejig attributes
str_id <- "leaftlet-map"
# the div component
vct_attributes <-  xml_map_fragment[[1]] %>% xml_attrs()

vct_attributes["style"] <- "width:968px;height:600px;" 
xml_set_attrs(xml_map_fragment[[1]], vct_attributes)

# the js component
vct_attrib_js <- xml_map_fragment[[2]] %>% xml_attrs()
xml_set_attrs(xml_map_fragment[[2]], vct_attrib_js)
# ===========================
# add in map

# the div element
xml_node_map_frag_1 <- xml_map_fragment[[1]]
v_mf1 <- xml_attrs(xml_node_map_frag_1)
xml_find_first(xml_accordion_skeleton ,  "//div[@id = 'collapse-one']/div") %>% xml_add_child("div", " ", "id" = v_mf1[1],  "style" = v_mf1[2], "class" = v_mf1[3])

# the map element
xml_node_map_frag_2 <- xml_map_fragment[[2]]
v_mf2 <- xml_attrs(xml_node_map_frag_2)
xml_find_first(xml_accordion_skeleton , "//div[@id = 'collapse-one']/div") %>% xml_add_child(xml_map_fragment[[2]])


# ===========================
# add in tabs
xml_find_first(xml_accordion_skeleton , "//div[@id = 'collapse-two']/div") %>%  xml_add_child(xml_tabs)

xml_find_first(xml_accordion_skeleton , "//div[@id = 'collapse-three']/div") %>% xml_add_child(xml_tabs_two)

# ===========================
# Add my own h2 heading....
xml_find_first(xml_accordion_skeleton, "/div/h2") %>% 
  xml_set_text("Automated XML documents")

pth_base <- "/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map"
pth_file <- "codekit_builder/accordion_postcodes.xml"
pth_full <- fs::path(pth_base, pth_file)

# write it out...
xml2::write_xml(xml_accordion_skeleton, pth_full)

txt_xml <- readr::read_file(pth_full)
txt_pass_1 <- gsub("<!\\[CDATA\\[", "", txt_xml)
txt_pass_2 <- gsub("\\]\\]>", "", txt_pass_1)
readr::write_file(txt_pass_2, pth_full)


