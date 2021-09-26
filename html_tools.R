library(htmltools)


# Every tag function will treat its arguments in a special way: it will treat 
# named arguments as HTML attributes and unnamed arguments as HTML children.



# ========================================================================
# ========================================================================
# ========================================================================
# ========================================================================

txt_lorem <- 
paste0("Lorem ipsum dolor sit amet, consectetur adipisicing elit,", 
       "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", 
       " Ut enim ad minim veniam,", 
       "quis nostrud exercitation ullamco laboris nisi ut aliquip ex",
       "ea commodo consequat.")

div_panel_body <- tags$div(class = "panel-body", tags$p(txt_lorem))

div_collapse_1 <- tags$div(id = "collapse1", 
                         class = "panel-collapse collapse in", div_panel_body)

div_collapse_2 <- tags$div(id = "collapse2", 
                           class = "panel-collapse collapse", div_panel_body)

div_collapse_3 <- tags$div(id = "collapse3", 
                           class = "panel-collapse collapse", div_panel_body)


h4_1 <- 
  tags$h4(class = "panel-title", 
          tags$a(`data-toggle` = "collapse", 
                 `data-parent` = "#accordion", 
         href = "#collapse1", "Collapsible Group 1"))

h4_2 <- 
  tags$h4(class = "panel-title", 
          tags$a(`data-toggle` = "collapse", 
                 `data-parent` = "#accordion", 
                 href = "#collapse2", "Collapsible Group 2"))


h4_3 <- 
  tags$h4(class = "panel-title", 
          tags$a(`data-toggle` = "collapse", 
                 `data-parent` = "#accordion", 
                 href = "#collapse3", "Collapsible Group 3"))




div_ph1 <- tags$div(class="panel-heading", h4_1)
div_ph2 <- tags$div(class="panel-heading", h4_2)
div_ph3 <- tags$div(class="panel-heading", h4_3)

div_pd1 <- tags$div(class="panel panel-default", div_ph1, div_collapse_1)
div_pd2 <- tags$div(class="panel panel-default", div_ph2, div_collapse_2)
div_pd3 <- tags$div(class="panel panel-default", div_ph3, div_collapse_3)

div_accordion <- 
  tags$div(class = "panel-group", id = "accordion", 
           div_pd1, div_pd2, div_pd3)

txt_p_head <- paste0("The data parent attribute makes sure that all elements", 
                     "under the specified parent will be closed", 
                     "when one of the collapsible item is shown.")

div_accord_complete <-
tags$div(class = "container", 
         tags$h2("Another Accordion Example"), 
         tags$p(txt_p_head), 
         div_accordion)

pth_accord <- 
  "/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map/accordion.rds"

saveRDS(div_accord_complete, pth_accord)

div_accord_complete

