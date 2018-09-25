## Run example of the pipeline.

library( ape )
library( RCurl )

## Make some data:
test_multi <- sample(c(0,1,2), size = 100, replace = TRUE)
test_cont <- rnorm(n = 100, mean = 65, sd = 10)
phy <- rtree(n = 100)

## Try to run the make markdown pipeline:
dir_files <- dir(path = "./functions", full.names = TRUE)
out <- lapply(dir_files, source)

string <- make_header(title = "Make test")
string <- make_discrete_prelim(data=test_multi, out_string = string)
string <- make_continuous_prelim(data=test_cont, out_string = string)
string <- make_phylo_prelim(phy=phy, out_string=string)
cat(string, file = "test.md")
