load("Data/UncertVisS1.Rdata")

site.xy <- data.frame(matrix(site.xy, byrow = TRUE, ncol = 2))
names(site.xy) <- c("Latitude", "Longitude")

# Grab estimates for day 1
site.xy$m <- as.numeric(dataL.m[1,])
site.xy$sd <- as.numeric(dataL.sd[1,])
site.xy$cv <- as.numeric(dataL.cv[1,])
site.xy$p025 <- as.numeric(dataL.p025[1,])
site.xy$p05 <- as.numeric(dataL.p05[1,])
site.xy$p10 <- as.numeric(dataL.p10[1,])
site.xy$p20 <- as.numeric(dataL.p20[1,])
site.xy$p25 <- as.numeric(dataL.p25[1,])
site.xy$p50 <- as.numeric(dataL.p50[1,])
site.xy$p75 <- as.numeric(dataL.p75[1,])
site.xy$p80 <- as.numeric(dataL.p80[1,])
site.xy$p90 <- as.numeric(dataL.p90[1,])
site.xy$p95 <- as.numeric(dataL.p95[1,])
site.xy$p975 <- as.numeric(dataL.p975[1,])

## Construct exceedance thresholds
thLevels<- c(0.5, 0.75, 0.8, 0.95, 0.975, 0.99)
th <- quantile(unlist(dataLsub),thLevels)
#dataL.MK<-list()
#for (i in 1:length(th)){
#  print(paste(i,thLevels[i]))
#  tmp <- lapply(dataLsub, function(x, th) ifelse(x > th[i], 1, 0), th)
#  dataL.MK[[paste(thLevels[i])]] <- sapply(tmp, function(x) apply(x, 2, mean))
#  
#}
#save(dataL.MK, file="dataL.Mr.RData")
load("Data/dataL.MK.RData")

names(dataL.MK) <- round(th, 0)

# The variable names for the UI
# it is possible to specify checkboxes (binary), select (one from many options), or a slider (min & max with selected ranges)

# main data variable is named 'displayData'
displayData <- site.xy

# the property / ellement is named 'displayValue'
#displayData$displayValue <- site.xy$m
timeseriesTh <- dataL.MK


thresholdLabels <- labels(dataL.MK)

