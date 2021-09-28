library(ggplot2)
library(scales)

options(scipen = 999)
options(stringsAsFactors = FALSE)

str_path_repo <- "/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map/codekit_builder"

setwd(str_path_repo)

df_monthly_filtered <- read.csv("monthly.csv")


# add in factor
df_monthly_filtered$year_month <-
  factor(df_monthly_filtered$year_month,
         levels = sort(df_monthly_filtered$year_month, decreasing = TRUE))

# sort position
df_monthly_filtered$num <- 1: nrow(df_monthly_filtered)

# labels
# vct_labs <- as.character(df_monthly_filtered$year_month)

# df_monthly_filtered$ym <- gsub("-", "", df_monthly_filtered$year_month) %>%  as.numeric()

str_base_font <- "helveticalight"

z <- ggplot(df_monthly_filtered, aes(x = num, y = count))
z <- z + geom_point(colour = "#223F99", size = 2)
z <- z + geom_smooth(level = 0.7, colour = "#0086e0",
        fill = "#e0e0e0", method = 'loess', formula = 'y ~ x')

z <- z + scale_x_continuous(breaks = df_monthly_filtered$num,
          labels = as.character(df_monthly_filtered$year_month))

z <- z + ylab("Montly count - unique report numbers")

z <- z + scale_y_continuous(label = comma)

z <- z + theme_minimal()
z <- z + theme(panel.grid.minor.y = element_blank())
z <- z + theme(panel.grid.major.y = element_blank())
z <- z + theme(panel.grid.minor.x = element_blank())
z <- z + theme(panel.grid.major.x = element_blank())
z <- z + theme(axis.title.x = element_blank())
z <- z + theme(axis.title.y = element_blank())
z <- z + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))
z <- z + theme(aspect.ratio =  7/10)
z

str_path_repo <- "/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map/codekit_builder"
pth <- path(str_path_repo, "monthly_smoothed.svg")
ggplot2::ggsave(pth, z,  width = 10, height = 7)
txt <- readLines(pth)
gsub("Arial", "helveticalight", txt) %>%
  writeLines(pth)



