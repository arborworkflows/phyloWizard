## Function to append some important information after running some analyses:

make_add_information_ASR <- function(out_string){
    ## Return some information about the analyses. This is to be added after the user run that particular analyses in order to provide further information and help. This should provide more information than the standard help page of R, for example.
    out_string <- c(out_string, "\n## Extended Information. \n \n## ASR \n \nMethod requires a phylogeny and trait information coded as values (no character names).  Method will automatically check if the trait data are discrete or independently and drop tips from the phylogeny which are not part of the trait dataset. Be cautious, missing species in your reconstruction has an influence on your ancestral reconstruction (CITATION). \n \n## Conditions to run ASR \n \nTrait should evolve independently from other non-tested traits. \n \n## Recommended steps before running ASR \n \nAsk Luke Harmon. \n \n## Recommended steps after running ASR \n \nAsk Brian O'Meara or test phylogenetic signal. \n \n## Programs out of ARBOR which do similar analysis \n \n1. Mesquite \n2. ace function in the ape package in R \n \n## Relevant literature \n \n1. Ref 1 \n2. Ref 2")
    return( out_string )
}
