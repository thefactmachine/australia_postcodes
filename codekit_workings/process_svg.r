
# clear the decks
rm(list = ls())
source("~/smr_report/globals.r")



pth <- path(str_path_repo, "svg", "reconciliation_outlines_b.svg")
pth_fixed <- path(str_path_repo, "svg", "reconciliation_outlines_b_fixed.svg")

txt <- readLines(pth)

vct_0 <- gsub("st0", "sz0", txt)
vct_1 <- gsub("st1", "sz1", vct_0)
vct_2 <- gsub("st2", "sz2", vct_1)

vct_3 <- gsub("st3", "sz3", vct_2)
vct_4 <- gsub("st4", "sz4", vct_3)
vct_5 <- gsub("st5", "sz5", vct_4)
vct_6 <- gsub("st6", "sz6", vct_5)


writeLines(vct_6, pth_fixed)


pth <- path(str_path_repo, "svg", "header_mockup_v006.svg")
pth_fixed <- path(str_path_repo, "svg", "header_mockup_v006_fixed.svg")

setwd("/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map/codekit_builder")



txt <- readLines("header_mockup_v006.svg")

vct_0 <- gsub("st0", "sx0", txt)
vct_1 <- gsub("st1", "sx1", vct_0)
vct_2 <- gsub("st2", "sx2", vct_1)

vct_3 <- gsub("st3", "sx3", vct_2)
vct_4 <- gsub("st4", "sx4", vct_3)
vct_5 <- gsub("st5", "sx5", vct_4)
vct_6 <- gsub("st6", "sx6", vct_5)
vct_7 <- gsub("st7", "sx7", vct_6)
vct_8 <- gsub("st8", "sx8", vct_7)
vct_9 <- gsub("st9", "sx9", vct_8)

writeLines(vct_9, "header_mockup_v006_fixed.svg")


setwd("/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map/codekit_workings")

pth <- path(str_path_repo, "svg", "footer_ul_fin.svg")
pth_fixed <- path(str_path_repo, "svg", "footer_ul_fin_fixed.svg")

txt <- readLines("footer_ul_fin.svg")

vct_0 <- gsub("st0", "zx0", txt)
vct_1 <- gsub("st1", "zx1", vct_0)
vct_2 <- gsub("st2", "zx2", vct_1)

vct_3 <- gsub("st3", "zx3", vct_2)
vct_4 <- gsub("st4", "zx4", vct_3)
vct_5 <- gsub("st5", "zx5", vct_4)
vct_6 <- gsub("st6", "zx6", vct_5)
vct_7 <- gsub("st7", "zx7", vct_6)
vct_8 <- gsub("st8", "zx8", vct_7)
vct_9 <- gsub("st9", "zx9", vct_8)
vct_10 <- gsub("st10", "zx10", vct_8)

writeLines(vct_9, "footer_ul_fin_fixed.svg")