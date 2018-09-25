## Make the preliminary summary for the phylogeny.
library(geiger)

## Functions:
ultra <- function(tr){
  if (ape::is.ultrametric(tr) == TRUE){
     return("ultrametric")
  }else{
     return("not ultrametric")
  }
}

make_phylo_prelim <- function(phy, group_name=NULL, out_string){
    ## Get the phy, do the things, return string.
    out_string <- c(out_string, "\n## Phylogenetic information. \n \nLoaded phylogeny:\n \n")
    png(tf1 <- tempfile(fileext = ".png")); plot(phy, cex = 0.5); dev.off()
    txt <- base64Encode(readBin(tf1, "raw", file.info(tf1)[1, "size"]), "txt")
    out_figure <- paste0("![](data:image/png;base64,", txt, ")", collapse="")
    out_string <- c(out_string, out_figure, "\n \n")
    out_string <- c(out_string, paste0("The phylogeny includes ", phy$Nnode, " nodes and is ", ultra(phy), ".", collapse="") )

    ## If a name of a group was given then we can compare with TOL:
    if( !is.null(group_name) ){
        library(rotl)
        library(knitr)
        name <- group_name
        out_string <- c(out_string, paste0("\n \n## Compare lineages to the ", name, " group in OpenTreeOfLife.\n", collapse="") )
        resolved_names <- tnrs_match_names(name)
        id <- ott_id(resolved_names)
        tr_otol <- tol_subtree(ott_id = id[[1]])
        sampling <- (tr$Nnode) / (tr_otol$Nnode)
        hierarchy <- tax_lineage(taxonomy_taxon_info(id, include_lineage = TRUE))
        out_string <- c(out_string, paste0("You are comparing ", resolved_names$unique_name
                                         , " to OpenTree, which has the ott ", id[[1]], ".\n", collapse = TRUE) )
        out_string <- c(out_string, paste0("Here are the corresponding rank information to your group: "))
        table1 <- as.character( kable(hierarchy, format = "markdown", align = "c") )
        table1 <- paste0(table1, collapse = "\n")
        out_string <- c(out_string, table1, "\n \n")
        out_string <- c(out_string, paste0("The phylogeny from OToL looks like this and has "
                                         , tr_otol$Nnode, "nodes:\n \n", collapse = ""))
        png(tf1 <- tempfile(fileext = ".png")); plot(tr_otol); dev.off()
        txt <- base64Encode(readBin(tf1, "raw", file.info(tf1)[1, "size"]), "txt")
        out_figure <- paste0("![](data:image/png;base64,", txt, ")", collapse="")
        out_string <- c(out_string, out_figure, "\n \n")
        out_string <- c(out_string, paste0("Compared to that, your sampling proportion is ", sampling, ".\n", collapse = "") )    
    }
    return( paste0(out_string, collapse = "") )
}
