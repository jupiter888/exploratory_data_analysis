#Exploratory data analysis final project
source('./code/source.R')
summary(runoff_info)
str(runoff_info)
runoff_info[, ]
#1
#Where are the Stations located-
#Countries
#messy version shows all stations and the country
for(country in 1:length(runoff_info[, Country]) ){
  str(runoff_info[country, Country, by=Station])
}
runoff_info$Country
#clean version showing all countries
ro_country_count <- data.table(Country = unique(runoff_info[, Country]))
ro_country_count
#19 different countries
#Continents
station_continents <- runoff_info[, .(Station, Continent) ]
station_continents
for(notEU in 1:length(runoff_info[, Continent]) ){
  if (runoff_info[notEU, Continent] !='EU'){
    str(runoff_info[notEU, Continent, by=Station] ) 
    #returning  nothing since all countries are categorized as 'EU'   
  } 
} 
#All Stations are in 'EU', Russia described as EU...Russia is not Europe technically.

#2 
#How many *stations exist per country?
ro_countries <- data.table(Country = unique(runoff_info[, Country]), Stations=0)
#use for loop to count occurances of stations in ea country
for(a in 1:length(runoff_info[, Station]) ){
  for(b in 1:length(ro_countries[, Country]) ){
    if(runoff_info[a, Country] == ro_countries[b, Country] ){
      ro_countries[b, 2] <- ro_countries[b, 2]+1
    }
  }
}
ro_countries #here we see the count max 78 in Germany
#2 cont'd--How many *rivers exist per country?
ro_rivers <- data.table(Country = unique(runoff_info[, Country]), Rivers=0)
ro_rivers
for(a in 1:length(runoff_info[, River]) ){
  for(b in 1:length(ro_rivers[, Country]) ){
    if(runoff_info[a, Country] == ro_rivers[b, Country] ){
      ro_rivers[b, 2] <- ro_rivers[b, 2]+1
    }
  }
}
ro_rivers #here we see the count max again, 78 in Germany
#when doing the loops for stations/rivers count per country the results were the same

#3 how many stations exist per river? 
ro_stations <- data.table(River = unique(runoff_info[, River]), Stations=0)
ro_stations
for(a in 1:length(runoff_info[, Station]) ){
  for(b in 1:length(ro_stations[, River]) ){
    if(runoff_info[a, River] == ro_stations[b, River] ){
      ro_stations[b, 2] <- ro_stations[b, 2]+1
    }
  }
}
ro_stations ##RStudio major latency noted in console
most_stations_river <- max(ro_stations$Stations)
most_stations_river #danube has 13 stations, max count

#4 Which is the distribution of stations in space (latitude, longitude and altitude)?
#prep a table to find the value distributions
prep <- data.table(Station_prep = runoff_info[, Station], Lat_prep = runoff_info[, Lat], Lon_prep = runoff_info[, Lon], Alt_prep = runoff_info[, Alt])
prep
#consider NA values in next step with na.rm=TRUE
#min
distribution_min <- data.table(Lat_min = min(prep[, Lat_prep]), Lon_min = min(prep[, Lon_prep]), Alt_min = min(prep[, Alt_prep], na.rm = TRUE))
distribution_min
distribution_max <- data.table(Lat_max = max(prep[, Lat_prep]), Lon_max = max(prep[, Lon_prep]), Alt_max = max(prep[, Alt_prep], na.rm=TRUE))
distribution_max
distribution_means <- data.table(Lat_mean = mean(prep[, Lat_prep]), Lon_mean = mean(prep[, Lon_prep]), Alt_mean = round(mean(prep[, Alt_prep], na.rm=TRUE,0)))
distribution_means
#euclidian distributions complete

#5-Which is the distribution of record length?
runoff_info
str(runoff_info)
prept <- data.table(Sname = runoff_info[, Station], Nyears = runoff_info[, N.Years])
prept
distribution_Nyears <- data.table(Min_Years = min(prept[, Nyears]), Max_Years = max(prept[, Nyears]), Mean_Years= round(mean(prept[, Nyears]),0) )
distribution_Nyears
