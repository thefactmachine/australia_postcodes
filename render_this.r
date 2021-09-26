library(rmarkdown)

rmarkdown::html_fragment()

str_p <- "/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map/reactable.Rmd" 


ff <- render(str_p, html_fragment())

render(str_p, c("html_fragment"))


library(htmlwidgets)