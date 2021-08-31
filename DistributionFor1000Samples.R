library(data.table)
library(ggplot2)
#Update file path
sourceData <- fread("dataset.csv")

# Creates 1.000 Samples with 100 observations each.
OneThousandSamplesWith100Obs <- c()
for(i in 1:1000){
  tmp <- sample(sourceData$Income, size = 100)
  tmp <- as.data.table(tmp)
  tmp[, grupo := i] 
  l <- list(OneThousandSamplesWith100Obs, tmp)
  OneThousandSamplesWith100Obs <- rbindlist(l) 
}

# To create a data.table with the means of 1000 samples with 100 observations each
meansOf100samples <- OneThousandSamplesWith100Obs[, mean(tmp), by = grupo]
setnames(meansOf100samples, "V1", "mean")


# To graph the distribution of 1000 means
d <- density(meansOf100samples$mean, adjust = 1.8)
plot(d, main = "Densidad de la variable Income")
polygon(d, col="#ffb01f", border = "white")
lines(d, col ="#c27e00", lwd = 2)

# To graph 100 and 1,000 means
par(mfrow = c(2,1), col.axis = "white", col.lab = "white", tck = 0, mai = c(0.3, 0.3, 0.3, 0.3))
for (i in c(1,10)){
  n <- 100*i
  dgrid <- density(meansOf100samples$mean[1:n], adjust = 1.8)
  plot(dgrid, main = paste0("Sample of ", n, " means of 100 observations each."))
  polygon(dgrid, col="#f8d025", border = "white")
  lines(dgrid, col ="#c27e00", lwd = 3)
}
