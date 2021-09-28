rm(list = ls())

library(xml2)
library(dplyr)

setwd("/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map")

# import html template
xml_tab_skeleton <- 
  xml2::read_xml("html_components/section_postcodes/four_tab_skeleton.xml")


xml_table_1 <-
  xml2::read_html("html_components/section_postcodes/react_postcode_1.html", 
                  options = "NOCDATA") %>% 
  xml2::xml_find_first("/html/body") %>% 
  xml_children()


xml_table_2 <-
  xml2::read_html("html_components/section_postcodes/react_postcode_2.html", 
                  options = "NOCDATA") %>% 
  xml2::xml_find_first("/html/body") %>% 
  xml_children()


xml_table_3 <-
  xml2::read_html("html_components/section_postcodes/react_postcode_3.html", 
                  options = "NOCDATA") %>% 
  xml2::xml_find_first("/html/body") %>% 
  xml_children()


xml_table_4 <-
  xml2::read_html("html_components/section_postcodes/react_postcode_4.html", 
                  options = "NOCDATA") %>% 
  xml2::xml_find_first("/html/body") %>% 
  xml_children()


# table 1
div1 <- xml_table_1[[1]]
js1 <- xml_table_1[[2]]

div_a <- xml_attrs(div1)
js_a <- xml_attrs(js1)

xml_find_first(xml_tab_skeleton , 
               "/div/div/div[1]") %>% 
  xml_add_child("div", " ", "id" = div_a[1], "class" = div_a[2], "style" = div_a[3])

xml_find_first(xml_tab_skeleton , 
               "/div/div/div[1]") %>% 
  xml_add_child("script", xml_text(js1), "type" = js_a[1], `data-for`= js_a[2])


# table 2
div1 <- xml_table_2[[1]]
js1 <- xml_table_2[[2]]

div_a <- xml_attrs(div1)
js_a <- xml_attrs(js1)

xml_find_first(xml_tab_skeleton , 
               "/div/div/div[2]") %>% 
  xml_add_child("div", " ", "id" = div_a[1], "class" = div_a[2], "style" = div_a[3])

xml_find_first(xml_tab_skeleton , 
               "/div/div/div[2]") %>% 
  xml_add_child("script", xml_text(js1), "type" = js_a[1], `data-for`= js_a[2])


# table 3
div1 <- xml_table_3[[1]]
js1 <- xml_table_3[[2]]

div_a <- xml_attrs(div1)
js_a <- xml_attrs(js1)

xml_find_first(xml_tab_skeleton , 
               "/div/div/div[3]") %>% 
  xml_add_child("div", " ", "id" = div_a[1], "class" = div_a[2], "style" = div_a[3])

xml_find_first(xml_tab_skeleton , 
               "/div/div/div[3]") %>% 
  xml_add_child("script", xml_text(js1), "type" = js_a[1], `data-for`= js_a[2])

# table 4
div1 <- xml_table_4[[1]]
js1 <- xml_table_4[[2]]

div_a <- xml_attrs(div1)
js_a <- xml_attrs(js1)

xml_find_first(xml_tab_skeleton , 
               "/div/div/div[4]") %>% 
  xml_add_child("div", " ", "id" = div_a[1], "class" = div_a[2], "style" = div_a[3])

xml_find_first(xml_tab_skeleton , 
               "/div/div/div[4]") %>% 
xml_add_child("script", xml_text(js1), "type" = js_a[1], `data-for`= js_a[2])


# write it out...
xml2::write_xml(xml_tab_skeleton, 
  "html_components/section_postcodes/tabs_postcodes.xml", 
  options = c("as_xml", "format", "no_empty_tags"))

