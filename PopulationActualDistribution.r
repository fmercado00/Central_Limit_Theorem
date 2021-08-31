library(data.table)
library(ggplot2)
#Update file path
sourceData <- fread("dataset.csv")

# Density Curve Income Variable
DensityPopIncome <- density(sourceData$Income, adjust = 1.8)
plot(DensityPopIncome, main = "Income Density")
polygon(DensityPopIncome, col="#00dbdb", border = "white")
lines(DensityPopIncome, col ="#006161", lwd = 1)

summary(sourceData)