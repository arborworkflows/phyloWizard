## Making a skeleton of a Markdown to be populated by summary statistics.
## This is a general function that will control the production of the output.

## The output format: github_document (RMarkdown)

make_header <- function(title, handle){
    cat("--- \n", file = handle)
    cat('title: "', title, '" \n', file = handle, append = TRUE, sep="")
    cat("output: github_document
--- \n
```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = FALSE)
```"
, file = handle, append = TRUE)
}
