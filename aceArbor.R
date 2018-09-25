

devtools::install_github("arborworkflows/aRbor")
library(aRbor)
library(geiger)

get_char_ratio <- function(ace_arbor){
  trait_ratio = list()
  for(row in 1:(length(ace_arbor[[1]])/2) ){
    max = max(ace_arbor[[1]][row,])
    for (cell in 1:length(ace_arbor[[1]][row,] )){
      val = ace_arbor[[1]][row,cell]
      if (val == max){
        trait_ratio = c(trait_ratio, cell)
      }
    }
  }
  return(table(as.character(trait_ratio)))
}


# Load your data  
tr  <- read.tree("/home/blubb/Documents/Workshops_PD/Ithaca_2018/example_data_ARBOR/Heliconia_all_dated_mod.phy")
trait <- read.csv('/home/blubb/Documents/Workshops_PD/Ithaca_2018/example_data_ARBOR/Heliconia_phylogeny_matrix.csv')


td = treeplyr::make.treedata(tr_ultra, trait)
td

ace_arbor = aRbor::aceArbor( select_(td, "Inflorescence"), charType='discrete', aceType = 'marginal')

chartype = attributes(ace_arbor)$charType
acetype = attributes(ace_arbor)$aceType
numChar = length(attributes(ace_arbor)$charStates[[1]])



# what is what here?

trait.ratio = get_char_ratio(ace_arbor)
tipChar = table(attributes(ace_arbor)$td$dat)



lik =  attributes(ace_arbor[[1]])$fit$lnLik
rate = attributes(ace_arbor[[1]])$fit$par.full
ratematrix = ace_arbor[[1]]


