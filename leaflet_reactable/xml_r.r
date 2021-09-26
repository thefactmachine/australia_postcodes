
rm(list = ls())
library(xml2)
library(fs)
library(dplyr)
library(base64enc)


fn_decode_64 <- function(a_str) {
  gsub("data:application/javascript;base64,", "", a_str) %>% 
    base64enc::base64decode() %>%
    rawToChar() %>% 
    return()
}

fn_add_style <- function(a_int_pos) {
  sn <- xml_nodes_style[[a_int_pos]]
  xml_find_first(xml_doc , "/html/head") %>% 
    xml_add_child(xml_name(sn), 
                  xml_text(sn), 
                  "type" = "text/css")
}

fn_add_link <- function(a_int_q) {
  lnk <- xml_nodes_link[[a_int_q]] 
  xml_find_first(xml_doc , "/html/head") %>%  xml_add_child(lnk)
}


str_pth_base <- "/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map"
str_html <- "leaflet_reactable/map_reactable.html"


xml_html_all <- xml2::read_html(fs::path(str_pth_base, str_html))

# get all the script nodes in the header
xml_nodes_script <- xml_find_all(xml_html_all, "/html/head/script")

xml_nodes_link <- xml_find_all(xml_html_all, "/html/head/link")

# ===========================================================================
# ===========================================================================
# ===========================================================================
# ===========================================================================


xml_nodes_style <- xml_find_all(xml_html_all, "/html/head/style")

root <- xml_new_root(
  xml_dtd("html",
          "-//W3C//DTD XHTML 1.0 Transitional//EN",
          "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd")) 

xml_doc <- 
  root %>% 
  xml_add_child("html") %>%
  xml_add_child("head") %>%
  xml_add_sibling("body", .where = "after") %>%
  xml_root()

xml_find_first(xml_doc , "/html/head") %>% 
  xml_add_child("title", "SMR Insights", .where = 1)

# ======================================
# add in all the styles
seq_along(xml_nodes_link) %>% purrr::map(fn_add_link)
seq_along(xml_nodes_style) %>% purrr::map(fn_add_style)



xml_nodes_script[[1]]
xml_nodes_script[[2]]








# Add some content =====================
xml_find_first(xml_doc , "/html/body") %>% 
  xml_add_child("h1", "will this render", "class" = "soft")

setwd("/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map/leaflet_reactable")
write_html(xml_doc, "test_mark.html")



