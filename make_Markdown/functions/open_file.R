## Function to open a connection:

open_file <- function(file_name){
    ID <- paste0(sample(1:9, size=5, replace = TRUE), collapse="")
    fnm <- file.path( getwd(), paste0(file_name, ID, ".md") )
    handle <- file(fnm, open="a")
}
