
rm(list = ls())
library(xml2)
library(fs)
library(dplyr)
library(base64enc)
library(readr)

# ==============================================================================
# add functions

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

fn_add_script <- function(a_int_q) {
  nde_xml_script <- xml_nodes_script[[a_int_q]] 
  xml_find_first(xml_doc , "/html/head") %>%  xml_add_child(nde_xml_script)
}

fn_add_meta <- function(a_int_q) {
  nde_xml_meta <- xml_nodes_meta[[a_int_q]] 
  xml_find_first(xml_doc , "/html/head") %>%  xml_add_child(nde_xml_meta)
}


str_pth_base <- "/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map"
str_html <- "leaflet_reactable/map_reactable.html"

xml_html_all <- xml2::read_html(fs::path(str_pth_base, str_html))

# the original contained bootstrap
str_fonts <- "leaflet_reactable/fonts_only.xml"
xml_fonts <- xml2::read_xml(fs::path(str_pth_base, str_fonts))
xml_nodes_fonts <- xml_find_all(xml_fonts, "/fonts/style")

str_bootstrap <- "leaflet_reactable/bootstrap.xml"
xml_bootstrap <- xml2::read_xml(fs::path(str_pth_base, str_bootstrap))
xml_nodes_bootstrap <- xml_find_all(xml_bootstrap, "/bootstrap/style")

# get all the various nodes.
xml_nodes_meta <- xml_find_all(xml_html_all, "/html/head/meta")
xml_nodes_script <- xml_find_all(xml_html_all, "/html/head/script")
xml_nodes_link <- xml_find_all(xml_html_all, "/html/head/link")
xml_nodes_style <- xml_find_all(xml_html_all, "/html/head/style")


# get the css
str_css <- "leaflet_reactable/style.css"

txt_css <- readr::read_file(fs::path(str_pth_base, str_css))

# ===========================================================================
# ===========================================================================
# ===========================================================================
# ===========================================================================

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
# add in various nodes to the header...

# add meta elements
c(1, 4, 5) %>% purrr::map(fn_add_meta)

# add in style bits
seq_along(xml_nodes_style) %>% purrr::map(fn_add_style)

# and the fonts.. to a style element
xml_find_first(xml_doc , "/html/head") %>% xml_add_child(xml_nodes_fonts[[1]])

# add in links
seq_along(xml_nodes_link) %>% purrr::map(fn_add_link)

# now we add in the java script components
seq_along(xml_nodes_script) %>% purrr::map(fn_add_script)

# now the bootstrap style
xml_find_first(xml_doc , "/html/head") %>% xml_add_child(xml_nodes_bootstrap[[1]])


# the css
xml_find_first(xml_doc , "/html/head") %>%
  xml_add_child("style", 
                txt_css, 
              "type" = "text/css")


# add some content =====================
xml_find_first(xml_doc , "/html/body") %>% 
  xml_add_child("h1", "will this render", "class" = "soft")


str_pth_base <- "/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map"
str_frag <- "leaflet_reactable/render_test.html"

xml_html_frag <- xml2::read_html(fs::path(str_pth_base, str_frag)) %>% 
  xml2::xml_find_first("/html/body") %>% xml_children()
  
xml_find_first(xml_doc , "/html/body") %>% 
  xml_add_child(xml_html_frag[[1]])

xml_rt_script <- xml_html_frag[[2]]

#xml_name(xml_rt_script)
#xml_text(xml_rt_script)

vct_att <- xml_attrs(xml_rt_script)

xml_find_first(xml_doc , "/html/body") %>% 
  xml_add_child(xml_name(xml_rt_script), xml_text(xml_rt_script), 
                type="application/json", `data-for`= vct_att[2])


# save it out ==============================
setwd("/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map/leaflet_reactable")
write_html(xml_doc, "test_mark.html")

