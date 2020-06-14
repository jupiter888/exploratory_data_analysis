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
#2 cont'd--How many rivers* exist per country?
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








