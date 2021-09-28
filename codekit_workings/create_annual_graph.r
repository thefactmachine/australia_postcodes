library(ggplot2)

options(scipen = 999)
options(stringsAsFactors = FALSE)

# prepare data
vct_ye <- c(2018, 2019, 2020, 2021)
vct_count <- c(19268, 247258, 270303, 307130)
df_data <- data.frame(ye = vct_ye, count = vct_count)
df_data$count_s <- prettyNum(df_data$count, big.mark = ",", scientific=FALSE) 

df_data

df_data$fact_ye <- 
  factor(df_data$ye, 
         levels = df_data$ye %>% sort(decreasing = TRUE))


str_base_font <- "helvetica"
# graph................
p <- ggplot(data = df_data, aes(x = fact_ye, y = count, width = 0.6))

p <- p + geom_bar(stat = "identity",  fill = "#223F99")

# add in space for labels
p <- p + ylim(0, 350000)
p <- p + coord_flip()
p <- p + geom_text(aes(label =  count_s),
                   vjust = 0.5, hjust = -0.2, lineheight = 2,
                   position = position_dodge(width = 0.3), size = 3.5)


# das thema
p <- p + theme_minimal()
p <- p + theme(axis.text.x = element_blank())
p <- p + theme(axis.title.y = element_blank())
p <- p + theme(axis.title.x = element_blank())
p <- p + theme(panel.grid.minor.y = element_blank())
p <- p + theme(panel.grid.major.y = element_blank())
p <- p + theme(panel.grid.minor.x = element_blank())
p <- p + theme(panel.grid.major.x = element_blank())
# p <- p + theme(aspect.ratio =  1/2)
p

str_path_repo <- "/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map/codekit_builder"

pth <- path(str_path_repo, "report_numbers_by_year.svg")

ggplot2::ggsave(pth, p,  width = 10, height = 5)

txt <- readLines(pth)
gsub("Arial", "helveticalight", txt) %>%
  writeLines(pth)


