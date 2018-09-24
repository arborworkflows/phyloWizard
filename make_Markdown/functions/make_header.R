## Making a skeleton of a Markdown to be populated by summary statistics.
## This is a general function that will control the production of the output.

## The output format: github_document (RMarkdown)

make_header <- function(title = "phyloWizard expert report"){
    out_string <- vector(mode="character")
    out_string <- c(out_string, paste0("## ", as.character(title), "\n \n", collapse = "") )
    return( paste(out_string, collapse="") )
}
