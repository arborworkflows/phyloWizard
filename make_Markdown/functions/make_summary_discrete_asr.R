## Make the summary of the discrete ASR analysis.

## Define functions:
get_char_ratio <- function(ace_arbor){
  trait_ratio <- list()
  for(row in 1:(length(ace_arbor[[1]])/2) ){
    max <- max(ace_arbor[[1]][row,])
    for (cell in 1:length(ace_arbor[[1]][row,] )){
      val <- ace_arbor[[1]][row,cell]
      if (val == max){
        trait_ratio <- c(trait_ratio, cell)
      }
    }
  }
  return(table(as.character(trait_ratio)))
}

input_table <- function(ace_arbor){
    chartype <- attributes(ace_arbor)$charType
    acetype <- attributes(ace_arbor)$aceType
    numChar <- length(attributes(ace_arbor)$charStates[[1]])
    lik <- attributes(ace_arbor[[1]])$fit$lnLik
    rate <- attributes(ace_arbor[[1]])$fit$par.full

    ace_table <- t(data.frame("type of trait"=chartype, "asr method"=acetype, "number of traits"=numChar
                            , "logLikelihood"=lik, 'transition rate'=rate))[,1]
    
    return(ace_table)
}

output_table <- function(ace_arbor){
    trait.ratio <- get_char_ratio(ace_arbor)
    tipChar <- as.matrix(table(attributes(ace_arbor)[[3]]$dat))
    
    ace_table <- data.frame('trait.ratio'=trait.ratio, "tipChar"=tipChar)
    names(ace_table) <- c("trait", "internal node frequency", 'tip frequency')
    rownames(ace_table) <- c()
    return(ace_table)
}

make_summary_discrete_asr <- function(ace_arbor, out_string){
    ## Load your data and run the method

    out_string <- c(out_string, "## Summaries about your ASR /n /n")
    out_string <- c(out_string, "Besides calculating the ancestral states in the phylogeny, here are some summary information for discrete character. /n /n Table 1 shows you your type of trait, input, reconstruction method, the log Likelihood and the transition rate between the traits. /n /n")
    
    ace_table <- input_table(ace_arbor)
    table1 <- as.character( kable(ace_table) )
    table1 <- paste0(table1, collapse = "\n")
    out_string <- c(out_string, table1, "\n \n")

    out_string <- c(out_string, "Table 2 sums up the result.\n \n")

    ace_output <- output_table(ace_arbor)
    table2 <- as.character( kable(ace_output) )
    table2 <- paste0(table2, collapse = "\n")
    out_string <- c(out_string, table2, "\n \n")

    return( paste0(out_string, collapse = "") )
}

