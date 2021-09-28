rm(list = ls())

library(xml2)
library(dplyr)

setwd("/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map")

# import html template
xml_s_overview <- 
  xml2::read_xml("html_components/section_overview/s_overview.xml")

svg_annual <-
  xml2::read_xml("codekit_workings/report_numbers_by_year.svg", 
                 options = "NOCDATA")

# import monthly graph
svg_monthly <-
xml2::read_xml("codekit_workings/monthly_smoothed.svg", 
               options = "NOCDATA")

# add annual
xml_find_first(xml_s_overview , "/div/div/div[1]/p") %>% 
  xml_add_sibling(svg_annual, .where = "after")

# add monthly
xml_find_first(xml_s_overview , "/div/div/div[2]/p") %>% 
  xml_add_sibling(svg_monthly, .where = "after")


xml2::write_xml(xml_s_overview, 
                "codekit_builder/xml_s_overview_fin.xml")
# ============ finished ========================