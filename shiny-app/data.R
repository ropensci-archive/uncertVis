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

# Construct exceedance thresholds
th <- quantile(unlist(dataLsub), c(0.5, 0.75, 0.8, 0.95, 0.975, 0.99))

dataL.p1 <- lapply(dataLsub, function(x, th) ifelse(x > th[1], 1, 0), th)
dataL.p1 <- sapply(dataL.p1, function(x) apply(x, 2, mean))

dataL.p2 <- lapply(dataLsub, function(x, th) ifelse(x > th[2], 1, 0), th)
dataL.p2 <- sapply(dataL.p2, function(x) apply(x, 2, mean))

dataL.p3 <- lapply(dataLsub, function(x, th) ifelse(x > th[3], 1, 0), th)
dataL.p3 <- sapply(dataL.p3, function(x) apply(x, 2, mean))

dataL.p4 <- lapply(dataLsub, function(x, th) ifelse(x > th[4], 1, 0), th)
dataL.p4 <- sapply(dataL.p4, function(x) apply(x, 2, mean))

dataL.p5 <- lapply(dataLsub, function(x, th) ifelse(x > th[5], 1, 0), th)
dataL.p5 <- sapply(dataL.p5, function(x) apply(x, 2, mean))

dataL.p6 <- lapply(dataLsub, function(x, th) ifelse(x > th[6], 1, 0), th)
dataL.p6 <- sapply(dataL.p6, function(x) apply(x, 2, mean))


