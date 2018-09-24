Untitled
================

`{r setup, include=FALSE} knitr::opts_chunk$set(echo = TRUE)`

## TEST\!\!\!

```{load data} 
tr <- read.tree("/home/blubb/Documents/Workshops_PD/Ithaca_2018/example_data_ARBOR/CostaRicaHeliconia.tre.phy")
trait <- read.csv('/home/blubb/Documents/Workshops_PD/Ithaca_2018/example_data_ARBOR/Heliconia_phylogeny_matrix.csv')
```

## if tree is supplied

tip labels of loaded tree

``` {r}
tr$tip.label
```

## GitHub Documents

This is an R Markdown format used for publishing markdown documents to
GitHub. When you click the **Knit** button all R code chunks are run and
a markdown file (.md) suitable for publishing to GitHub is generated.

## Including Code

You can include R code in the document as follows:

`{r cars} summary(cars)`

## Including Plots

You can also embed plots, for example:

`{r pressure, echo=FALSE} plot(pressure)`

Note that the `echo = FALSE` parameter was added to the code chunk to
prevent printing of the R code that generated the plot.
