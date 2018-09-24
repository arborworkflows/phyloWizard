## Make the function to write the preliminary information for continuous traits.

## Define functions:
summary_stats <- function(data) {
  ave <- mean(data)
  medi <- median(data)
  stand_dv <- sd(data)
  range_upper <- max(data)
  range_lower <- min(data)
  return(list(ave = ave, 
              medi = medi, 
              stand_dv = stand_dv, 
              range_upper = range_upper,
              range_lower = range_lower))
}

num_obs <- function(data) {
  length(data)
}

data_normal <- function(data) {
  
  shap_test <- shapiro.test(data)
  return(shap_test$p.value)
}

density_plot <- function(data) {
  
  d <- density(data) # returns the density data 
  plot(d, main = "Density Plot of Data")
  polygon(d, col="darkolivegreen3")
}

hist_w_normal <- function(data, char_name = NA) {

  #histogram
  h <- hist(data, col="grey", xlab = char_name, 
            main = paste("Shapiro-Wilk test of normality P-Value:", round(data_normal(data), digits = 3), sep = " "))

  #normal distribution based on mean and sd of data
  xfit <- seq(min(data),max(data),length=40) 
  yfit <- dnorm(xfit,mean=mean(data),sd=sd(data)) 
  yfit <- yfit*diff(h$mids[1:2])*length(data) 
  lines(xfit, yfit, col="black", lwd=2, lty = 2)

  legend("topright", 
    legend = c("Data", "Normal"), 
    col = c("grey", "black"), 
    pch = c(19, 19), 
    bty = "n", 
    pt.cex = 1, 
    cex = 1, 
    text.col = c("black", "black"), 
    horiz = F)
  
}

make_continuous_prelim <- function(data, out_string){

    summary <- summary_stats(data)
    out_string <- c(out_string, "\n## phyloWizard continuous. \n \n Your data has a mean of ")
    out_string <- c(out_string, as.character( round(summary$ave, digits = 2) ) )
    out_string <- c(out_string, ", median of ")
    out_string <- c(out_string, as.character( round(summary$medi, digits = 2) ) )
    out_string <- c(out_string, ", and standard deviation of ")
    out_string <- c(out_string, as.character( round(summary$stand_dv, digits = 2) ) )
    out_string <- c(out_string, ". The data range from")
    out_string <- c(out_string, as.character( round(summary$range_lower, digits = 2) ) )
    out_string <- c(out_string, " to ", as.character( round(summary$range_upper, digits = 2) ) )
    out_string <- c(out_string, ". \n The plot below shows the distribution of your data compared to a normal distribution with the same mean and standard deviation. The Shapiro-Wilk test of normality compares your data to a normal distribution. A significant p-value indicates that your data are significantly different from a normal distribution. \n \n")
    png(tf1 <- tempfile(fileext = ".png")); hist_w_normal(data); dev.off()
    txt <- base64Encode(readBin(tf1, "raw", file.info(tf1)[1, "size"]), "txt")
    out_figure <- paste0("![](data:image/png;base64,", txt, ")", collapse="")
    out_string <- c(out_string, out_figure, "\n \n")
    return( paste0(out_string, collapse = "") )
}
