#EDA final project part 2
#exploration of runoff_day
source('./code/Source.R')
str(runoff_day)
runoff_day
#Estimate and present some descriptive statistics including:  mean, coefficient of variance, minimum and maximum runoff with annual data.
runoff_day_stats <- runoff_day[, .(mean_day = round(mean(value), 0),
                               sd_day = round(sd(value), 0),
                               min_day = round(min(value), 0),
                               max_day = round(max(value), 0)), by = id]
runoff_day_stats
runoff_day_median <- runoff_day[, .(round(median(value),0)), by = id]
runoff_day_median
runoff_day_stats$median <- runoff_day_median$V1
runoff_day_stats
colset_4 <-  c("MEAN", "MEDIAN", "MIN", "MAX")
shapeset_4 <- c(3, 8, 11, 14)
ggplot(runoff_day_stats) + 
  geom_point(aes(x= id, y= mean_day, col=colset_4[1]), shape = shapeset_4[1]) +
  geom_point(aes(x= id, y= median, col=colset_4[2]), shape = shapeset_4[2]) +
  geom_point(aes(x= id, y= min_day, col=colset_4[3]), shape = shapeset_4[3]) +
  geom_point(aes(x= id, y= max_day, col=colset_4[4]), shape = shapeset_4[4]) +
  labs(y="Daily Runoff", x = "Station id", color = 'Runoff value type')

##
#coefficient of variance=stdv/mean
runoff_day_coeff <- runoff_day[, .(coeff_var_day = sd(value)/mean(value)), by = id]
runoff_day_coeff 
#need to configure snames instead of id's
runoff_snames <- runoff_info[, .(id = ID, Station)]
runoff_snames
runoff_day_stats$sname <- "name"
for (a in 1:length(runoff_snames$id)) {
  for (b in 1:length(runoff_day_stats$id)){
    if (runoff_snames[a, 1] == runoff_day_stats[b, 1]){
      runoff_day_stats[b, 7] <- runoff_snames[a,2]
    }
  }
} 
runoff_day_stats$day_coeff_var <- runoff_day_coeff[, coeff_var_day]
runoff_day_stats #now with the snames and coefficient variation in one table
ro_mean_days_stations <- runoff_day_stats[, .(mean_day), by=sname]
 ggplot(ro_mean_days_stations, aes(x=sname ,y=mean_day))+
  geom_point()+
   theme_classic()+
   labs(x='Station', y='Mean Daily runoff')
################################################################################
#exploration continued
str(runoff_year)
runoff_year
runoff_info

