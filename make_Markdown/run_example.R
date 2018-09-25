## Run example of the pipeline.

install_github("arborworkflows/aRbor")
install.packages( "treeplyr" )

library( ape )
library( RCurl )
library( devtools )
library(aRbor)
library( treeplyr )

## Make some data:
phy  <- read.tree("/home/daniel/Documents/Academicos/Arbor_Hackaton/ots-data/heliconia/Heliconia_all_dated_mod.phy")
trait <- read.csv('/home/daniel/Documents/Academicos/Arbor_Hackaton/ots-data/heliconia/Heliconia_phylogeny_matrix.csv')

## Try to run the make markdown pipeline:
dir_files <- dir(path = "./functions", full.names = TRUE)
out <- lapply(dir_files, source)

string <- make_header(title = "Make test")
string <- make_discrete_prelim(data=trait$Resupination, out_string = string)
trait$heightlow[is.na(trait$heightlow)] <- mean(trait$heightlow, na.rm = TRUE)
string <- make_continuous_prelim(data=trait$heightlow, out_string = string)
string <- make_phylo_prelim(phy=phy, out_string=string)
td <- treeplyr::make.treedata(phy, trait)
ace_arbor <- aRbor::aceArbor( select_(td, "InflorL"), charType='continuous', aceType = 'marginal')
string <- make_phy_and_data(ace_arbor=ace_arbor, out_string=string)
string <- make_summary_continuous_asr(ace_arbor=ace_arbor, out_string=string)
cat(string, file = "test.md")
