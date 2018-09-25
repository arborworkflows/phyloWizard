## Function to provide information about matching the phylogeny and the data.

library(knitr)

make_phy_and_data <- function(ace_arbor, out_string){
    ## Get the data, do the things, return string.
    
    out_string <- c(out_string, "\n## Some information might have been removed during analysis. \n \nBe aware that the function dropped some tips of your phylogeny: ")
    
    if (length(attributes(ace_arbor)$dropped$dropped_from_data) >=1){
        out_string <- c(out_string, "\n## Some information might have been removed during analysis. \n \nBe aware that the function dropped some tips of your phylogeny:\n \n")
        table1 <- as.character( kable(attributes(ace_arbor)$dropped$dropped_from_data) )
        table1 <- paste0(table1, collapse = "\n")
        out_string <- c(out_string, table1, "\n \n")
    } else{
        out_string <- c(out_string, "No data was dropped.\n \n")
    }

    out_string <- c(out_string, "It might has dropped information from your trait data as well:\n \n")
    if (length(attributes(ace_arbor)$dropped$dropped_from_tree) >=1){
        table2 <- as.character( kable(attributes(ace_arbor)$dropped$dropped_from_tree) )
        table2 <- paste0(table2, collapse = "\n")
        out_string <- c(out_string, table2, "\n \n")
    } else{
        out_string <- c(out_string, "No data was dropped.\n \n")
    }
    return( paste0(out_string, collapse = "") )
}
