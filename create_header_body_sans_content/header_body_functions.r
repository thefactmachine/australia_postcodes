fn_decode_64 <- function(a_str) {
  gsub("data:application/javascript;base64,", "", a_str) %>% 
    base64enc::base64decode() %>%
    rawToChar() %>% 
    return()
}

fn_add_style <- function(a_int_pos) {
  sn <- xml_nodes_style[[a_int_pos]]
  xml_find_first(xml_doc , "/html/head") %>% 
    xml_add_child(xml_name(sn), 
                  xml_text(sn), 
                  "type" = "text/css")
}

fn_add_link <- function(a_int_q) {
  lnk <- xml_nodes_link[[a_int_q]] 
  xml_find_first(xml_doc , "/html/head") %>%  xml_add_child(lnk)
}

fn_add_script <- function(a_int_q) {
  nde_xml_script <- xml_nodes_script[[a_int_q]] 
  xml_find_first(xml_doc , "/html/head") %>%  xml_add_child(nde_xml_script)
}

fn_add_meta <- function(a_int_q) {
  nde_xml_meta <- xml_nodes_meta[[a_int_q]] 
  xml_find_first(xml_doc , "/html/head") %>%  xml_add_child(nde_xml_meta)
}
