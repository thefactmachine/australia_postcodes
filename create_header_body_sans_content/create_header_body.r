(rm(list = ls(all = TRUE)))
library(xml2)
library(fs)
library(dplyr)
library(base64enc)
library(readr)
unlink(".RData")
gc()
library(rstudioapi)
restartSession()
gc()



pth_base <- "/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map"
pth_created_header_body <- "create_header_body_sans_content"

fs::path(pth_base, pth_created_header_body) %>% setwd()
# add functions
source("header_body_functions.r")

# ==============================================================================


xml_html_all <- xml2::read_html("map_reactable.html")
xml_fonts <- xml2::read_xml("fonts_only.xml")

xml_nodes_fonts <- xml_find_all(xml_fonts, "/fonts/style")

xml_bootstrap <- xml2::read_xml("bootstrap.xml")
xml_nodes_bootstrap <- xml_find_all(xml_bootstrap, "/bootstrap/style")

# get all the various nodes.
xml_nodes_meta <- xml_find_all(xml_html_all, "/html/head/meta")
xml_nodes_script <- xml_find_all(xml_html_all, "/html/head/script")
xml_nodes_link <- xml_find_all(xml_html_all, "/html/head/link")
xml_nodes_style <- xml_find_all(xml_html_all, "/html/head/style")

txt_css <- readr::read_file("embedded_style.css")

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
  xml_add_child("style", txt_css, "type" = "text/css")

# save it out ==============================
write_html(xml_doc, "header_body_sans_content.html")

