
rm(list = ls())

library(reactable)

iris_10 <- iris[1:10,]


obj_test <- reactable(iris_10)

str_file_path_shape <- "/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map/test_react.html"

library(webshot)

save_reactable(obj_test, str_file_path_shape)

library("reactable")
library("htmlwidgets")

table <- reactable(iris_10)
saveWidget(widget = table, file = str_file_path_shape, selfcontained = FALSE)




saveRDS(obj_test, str_file_path_shape)

rds_obj <- readRDS(str_file_path_shape)

library(svglite)

svglite::htmlSVG(plot(rds_obj))