#EDA final project part 2- exploration
source('./code/Source.R')
str(runoff_day)
runoff_day
#Estimate and present some descriptive statistics including:  mean, coefficient of variance, minimum and maximum runoff with annual data.
runoff_stats <- runoff_day[, .(mean_day = round(mean(value), 0),
                               sd_day = round(sd(value), 0),
                               min_day = round(min(value), 0),
                               max_day = round(max(value), 0)), by = id]
runoff_stats
#looking into runoff_year
runoff_year

runoff_median <- runoff_day[, .(round(median(value),0)), by = id]
runoff_stats$median <- runoff_median$V1
runoff_stats
colset_4 <-  c("MEAN", "MEDIAN", "MIN", "MAX")
shapeset_4 <- c(3, 8, 11, 14)
ggplot(runoff_stats) + 
  geom_point(aes(x= id, y= mean_day, col=colset_4[1]), shape = shapeset_4[1]) +
  geom_point(aes(x= id, y= median, col=colset_4[2]), shape = shapeset_4[2]) +
  geom_point(aes(x= id, y= min_day, col=colset_4[3]), shape = shapeset_4[3]) +
  geom_point(aes(x= id, y= max_day, col=colset_4[4]), shape = shapeset_4[4]) +
  labs(y="Runoff", x = "Station id", color = 'Runoff value type')

##
#coefficient of variance=stdv/mean
runoff_coefficient_variation <- runoff_day[, .(coeff_var_day = sd(value)/mean(value)), by = id]
runoff_coefficient_variation 


