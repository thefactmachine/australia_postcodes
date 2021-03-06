library(knitr)
library(dplyr)
library(rmarkdown)

setwd("/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map/leaflet_reactable")
title: "Untitled"

str_quote <- intToUtf8(34)

str_yaml_delim <- "---"
str_title <- paste0("title:", " ", str_quote, "nothing", str_quote)
str_output <- "output:"
str_frag <- "  html_fragment:"
str_keep_md <- "    keep_md: true"
str_blank_line <- ""

str_line_1 <- "```{r frag, echo=FALSE}"
str_line_2 <- "library(reactable)"
str_line_3 <- "reactable(iris[1:10,])"
str_line_4 <- "```"

vct_yaml <- c(str_yaml_delim, str_title, str_output, str_frag, 
              str_keep_md, str_blank_line, str_yaml_delim, str_blank_line)

vct_content <- c(str_line_1, str_line_2, str_line_3, str_line_4)

vct_output <- c(vct_yaml, vct_content)
writeLines(vct_output, "test.Rmd")

render("test.Rmd", c("html_fragment"), 
       output_file = "render_test.html", quiet = TRUE)