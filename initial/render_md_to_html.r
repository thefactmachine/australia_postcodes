

# load necessary packages
library(knitr)
library(markdown)

setwd("/Users/mark/Documents/TEMP_not_on_cloud/australia_postcode_map")






text_0 <- "```"
text_1 <- "```{r frag, echo=FALSE}"
text_2 <- "library(reactable)"
text_3 <- "reactable(iris[1:10,])"
text_4 <- "```"

cc <- cat(paste0(text_0, "\n", text_1, "\n", text_2, "\n", text_3, "\n", text_4))

dd <- c(text_2, text_2, text_3,text_4)


knit(text =  dd) %>% cat()




knit("markdownToHTML Exampl
     e.Rmd") # produces a .md file
#produces clean .html

library(XML)


markdownToHTML("test_md.md", "test.html", fragment.only=TRUE) 


doc = xmlParse("<top><a/><b/><c><d/><e>bob</e></c></top>")
top = xmlRoot(doc)
top
removeNodes(list(top[[1]], top[[3]]))


text <- markdownToHTML("test_md.md",  fragment.only=TRUE) 



xml_text <- XML::xmlParse(text) %>% xmlRoot()



(markdownToHTML(text = "Hello World!", fragment.only = TRUE))
