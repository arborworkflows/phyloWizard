## Making a skeleton of a Markdown to be populated by summary statistics.
## This is a general function that will control the production of the output.

## The output format: github_document (RMarkdown)

make_header <- function(title, handle){
cat("--- \n", file = handle)
cat(paste("title: ", title, "\n", collapse = ""), file = handle, append = TRUE)
"output: github_document \n
--- \n
 \n
```{r setup, include=FALSE} \n
knitr::opts_chunk$set(echo = TRUE) \n
``` \n"
    cat(
    }
