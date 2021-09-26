vct_attributes <- xml2::xml_attrs(lnk)


xml_node <- read_xml('<root><link></link></root>') %>% xml_children() %>% .[[1]]

xml_set_attrs(xml_node, vct_attributes)