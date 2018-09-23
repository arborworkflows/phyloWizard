## Making a skeleton of a Markdown to be populated by summary statistics.
## This is a general function that will control the production of the output.

## The output format: github_document (RMarkdown)

make_header <- function(title){
    out_string <- vector(mode="character")
    out_string <- c(out_string, "--- \n")
    out_string <- c(out_string, paste0('title: \"', title, '\" \n', sep=""))
    out_string <- c(out_string, "output: github_document \n --- \n ```{r setup, include=FALSE} \n knitr::opts_chunk$set(echo = FALSE) ``` \n")
    return( paste(out_string, collapse=" ") )
}
