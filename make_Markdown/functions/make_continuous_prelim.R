## Make the function to write the preliminary information for continuous traits.

make_continuous_prelim <- function(data, out_string){
    out_string <- c(out_string, "## Here we go!! \n Your data ")
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
    out_string <- c(out_string, out_figure, "\n")
    return( paste0(out_string, collapse = "") )
}
