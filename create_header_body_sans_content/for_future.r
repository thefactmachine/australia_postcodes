# add some content =====================
xml_find_first(xml_doc , "/html/body") %>% 
  xml_add_child("h1", "will this render", "class" = "soft")


str_pth_base <- "/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map"
str_frag <- "leaflet_reactable/render_test.html"

xml_html_frag <- xml2::read_html(fs::path(str_pth_base, str_frag)) %>% 
  xml2::xml_find_first("/html/body") %>% xml_children()

xml_find_first(xml_doc , "/html/body") %>% 
  xml_add_child(xml_html_frag[[1]])

xml_rt_script <- xml_html_frag[[2]]

#xml_name(xml_rt_script)
#xml_text(xml_rt_script)

vct_att <- xml_attrs(xml_rt_script)

xml_find_first(xml_doc , "/html/body") %>% 
  xml_add_child(xml_name(xml_rt_script), xml_text(xml_rt_script), 
                type="application/json", `data-for`= vct_att[2])
