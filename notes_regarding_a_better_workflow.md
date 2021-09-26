# Better workflow

A file .rhtml works with snippets like this:

<!--begin.rcode warning=FALSE, results = 'asis', echo = FALSE
cat(readLines("reactable_fragment.html"))
end.rcode-->

And the above was constructed using something like this:

---
output:
  html_fragment:
    keep_md: true
---

```{r frag, echo=FALSE}
library(reactable)
reactable(iris[1:10,])
```

But to get the .rhtml to work.  We needed to insert base64 inside the header
filer.  The following was inserted in the <header> block.

<!--begin.rcode warning=FALSE, results = 'asis', echo = FALSE

cat(readLines("include_script.html"))

end.rcode-->

## How to get the base 64...?
I ran the following and then copied relevant parts from the header in the
resultant html document. 

---
title: "Untitled"
output: html_document
---

```{r frag, echo=FALSE}
library(reactable)
reactable(iris[1:10,])
```






## Questions
What base 64 did I use...?
How about inserting the Leaflet image...

