## Function to make a Markdown chunk with summary statistics for a single discrete trait.

## Define functions:
type_data <- function(data) {
    if (length(unique(data)) > 2) {
        type <- "is multi state"
    } else if (length(unique(data)) == 2) {
        type <- "is binary"
    } else if (length(unique(data)) == 1) {
        type <- "has no variation"
    } else {
        type <- "uh oh!! unknown error"
    }
    return(type)
}

num_states <- function(data) {
    length(unique(data))
}

num_obs <- function(data) {
    length(data)
}

make_discr_plot <- function(data, char_name = NA) {
    counts <- table(data)
    barplot(counts, main = char_name, 
            xlab = "character states",
            ylab = "number of tips")
}

make_discr_table <- function(data, char_name = NA) {
    library( knitr )
    counts <- table(data)
    kable(counts, col.names = c("Char. States","Num. of Tips"))
}

make_discrete_prelim <- function(data, out_string){
    ## Get the data, do the things, return string.
    out_string <- c(out_string, "\n## phyloWizard discrete. \n Your data ")
    out1 <- type_data(data)
    out_string <- c(out_string, out1, ". You have ")
    out2 <- num_obs(data)
    out_string <- c(out_string, as.character(out2), " observations and ")
    out3 <- num_states(data)
    out_string <- c(out_string, as.character(out3), " character states. \n \n")
    table1 <- as.character( make_discr_table(data) )
    table1 <- paste0(table1, collapse = "\n")
    out_string <- c(out_string, table1, "\n \n")
    png(tf1 <- tempfile(fileext = ".png")); make_discr_plot(data); dev.off()
    txt <- base64Encode(readBin(tf1, "raw", file.info(tf1)[1, "size"]), "txt")
    out_figure <- paste0("![](data:image/png;base64,", txt, ")", collapse="")
    out_string <- c(out_string, out_figure, "\n \n")
    return( paste0(out_string, collapse = "") )
}
