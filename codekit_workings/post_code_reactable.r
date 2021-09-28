rm(list = ls())


library(reactable)

setwd("/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map/codekit_workings")

df_data <- read.csv("postcode.csv")

df_data$postcode <- df_data$postcode %>% as.character()

# this stuff is reusable for all tables ===>>>>>>>>>
int_pc_width <- 120
int_state_width <- 130
int_suburb_width <- 173
int_count_width <- 120
int_total_width <- 165
int_population_width <- 140
int_area_width <- 120

int_pc_width + int_state_width + int_suburb_width + int_count_width +
  int_total_width + int_population_width + int_area_width


rct_cd_pc <-
  reactable::colDef(name = "Postcode", width = int_pc_width)

rct_cd_state <-
  reactable::colDef(name = "State", width = int_state_width)

rct_cd_suburb <-
  reactable::colDef(name = "Suburb", width = int_suburb_width)

rct_cd_rpt_count <-
  reactable::colDef(name = "Count",
                    width = int_count_width,
                    cell = function(value) {
                      label <- prettyNum(value, big.mark = ",")})
rct_cd_total <-
  reactable::colDef(name = "Total",
                    width = int_total_width,
                    cell = function(value) {
                      label <- paste0("$", prettyNum(value, big.mark = ","))})
rct_cd_population <-
  reactable::colDef(name = "Population",
                    width = int_population_width,
                    cell = function(value) {
                      label <- prettyNum(value, big.mark = ",")})
rct_cd_area <-
  reactable::colDef(name = "Area",
                    width = int_area_width,
                    cell = function(value) {
                      label <- paste0(prettyNum(value, big.mark = ","), " km")})

# smash column definitions together
# the list names have to line up with the column names in the data.frame

lst_cols <-
  list(postcode = rct_cd_pc,
       state = rct_cd_state,
       suburb = rct_cd_suburb,
       count = rct_cd_rpt_count,
       total = rct_cd_total,
       population = rct_cd_population,
       area = rct_cd_area)

lst_header_style <-
  list(background = "#023D98", color = "#FFFFFF", fontWeight = "normal")

#### <<<<<<<<<<<<< end of reusable stuff
# ===========================================================================
# All sorted by count

rct_tbl_postcode_ato_by_count_alles <-
  reactable(df_data,
            defaultPageSize = nrow(df_data),
            striped = TRUE,
            highlight = TRUE,
            bordered = FALSE,
            columns = lst_cols,
            defaultColDef = colDef(headerStyle = lst_header_style)
  ) # reactable

rct_tbl_postcode_ato_by_count_alles

f_path <- "rct_tbl_postcode_ato_by_count_alles.rds"

saveRDS(rct_tbl_postcode_ato_by_count_alles, f_path)
