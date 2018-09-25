## Make the summary for the ASR using continuous data.

make_summary_continuous_asr <- function(ace_arbor, out_string){
    ## ace_arbor is the output from aRbor::aceArbor function.
    trait_name <- attributes(ace_arbor)$names
    orig_mean <- mean(as.matrix(attributes(ace_arbor)$td$dat))
    anc_mean <- mean(ace_arbor$InflorL$estimate)
    orig_range <- c(min(as.matrix(attributes(ace_arbor)$td$dat)),
                    max(as.matrix(attributes(ace_arbor)$td$dat)))
    anc_range <- c(min(ace_arbor[[1]]$estimate),
                   max(ace_arbor[[1]]$estimate))
    anc_range_CI <- c(min(ace_arbor[[1]]$lowerCI95),
                      max(ace_arbor[[1]]$upperCI95))

    ## ordering and binning confidence intervals by age 

    CI_age <- data.frame(age = branching.times(attributes(ace_arbor)$td$phy),
                         CI_width = ace_arbor[[1]]$upperCI95 - ace_arbor[[1]]$lowerCI95)

    out_string <- c(out_string, paste0("##Summary ASR \n \nThe mean value of ", paste(trait_name), " extant values is ", orig_mean,
                                       " the reconstructed nodes have a mean value of ", anc_mean,
                                       ". The original range of your data values is ", orig_range[1],
                                       " to ", orig_range[2], ". The estimated node values range from ",
                                       anc_range[1], " to ", anc_range[2], ".", collapse="") )
    out_string <- c(out_string, paste0(" When we include the 95% confidence invervals for those estimates, the estimates range from "
                                     , anc_range_CI[1], " to ", anc_range_CI[2], ". A portion of those estimates are displayed below.\n \n"
                                     , collapse = "") )

    if (nrow(ace_arbor[[1]]) > 20) {
        rows_to_include <- 20
    } else{
        rows_to_include <- nrow(ace_arbor[[1]])
    }

    table1 <- as.character( kable(ace_arbor[[1]][1:rows_to_include,]) )
    table1 <- paste0(table1, collapse = "\n")
    out_string <- c(out_string, table1, "\n \n")

    out_string <- c(out_string, "The plot below shows the relationship between the width of your 95% confidence intervals and time as indicated by node ages.\n \n")

    png(tf1 <- tempfile(fileext = ".png"))
    plot(CI_width~age, data = CI_age,
         pch = 19,
         main = trait_name,
         xlab = "Node Age",
         ylab = "Width of 95% CI for Estimated Values")
    dev.off()
    txt <- base64Encode(readBin(tf1, "raw", file.info(tf1)[1, "size"]), "txt")
    out_figure <- paste0("![](data:image/png;base64,", txt, ")", collapse="")
    out_string <- c(out_string, out_figure, "\n")
    return( paste0(out_string, collapse = "") )
    
}
