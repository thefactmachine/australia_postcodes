rm(list = ls())
library(knitr)
library(dplyr)
library(rmarkdown)

setwd("/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map/html_components/section_postcodes")


str_quote <- intToUtf8(34)
str_yaml_delim <- "---"
str_title <- paste0("title:", " ", str_quote, "nothing", str_quote)
str_output <- "output:"
str_frag <- "  html_fragment:"
str_keep_md <- "    keep_md: true"
str_blank_line <- ""

str_line_1 <- "```{r frag, echo=FALSE}"
str_line_2 <- "rct_object <- readRDS('rct_tbl_postcode_6.rds')"
str_line_3 <- "rct_object"
str_line_4 <- "```"

vct_yaml <- c(str_yaml_delim, str_title, str_output, str_frag, 
              str_keep_md, str_blank_line, str_yaml_delim, str_blank_line)

vct_content <- c(str_line_1, str_line_2, str_line_3, str_line_4)

vct_output <- c(vct_yaml, vct_content)

writeLines(vct_output, "temporary.rmd")

render("temporary.rmd", c("html_fragment"), 
       output_file = "react_postcode_6.html", quiet = TRUE)
