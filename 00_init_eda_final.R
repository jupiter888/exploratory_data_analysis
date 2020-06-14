#Exploratory data analysis final project
source('./code/source.R')
summary(runoff_info)
str(runoff_info)
runoff_info[, ]
#1
#Where are the Stations located-
#Countries
#show all stations and the country
for(country in 1:length(runoff_info[, Country])){
  str(runoff_info[country, Country, by=Station])
}
#clean version
ro_country_count <- data.table(Country = unique(runoff_info[, Country]))
ro_country_count
#19 different countries

#Continents
for(notEU in 1:length(runoff_info[, Continent]) ){
  if (runoff_info[notEU, Continent] !='EU'){
    str(runoff_info[notEU, Continent, by=Station] ) 
    #returning  nothing since all countries are categorized as 'EU'   
  } 
} 
#All Stations are in 'EU', Russia described as EU...Russia is not European.
#2 
#How many stations/rivers exist per country?
station_continents <- runoff_info[, .(Station, Continent) ]
station_continents
ro_countries <- data.table(Country = unique(runoff_info[, Country]), Stations=0)
#use for loop to count occurances of rivers in ea country
for(a in 1:length(runoff_info[, Station]) ){
  for(b in 1:length(ro_countries[, Country]) ){
    if(runoff_info[a, Country] == ro_countries[b, Country] ){
      ro_countries[b, 2] <- ro_countries[b, 2]+1
    }
  }
}
ro_countries
#here we see the count of the rivers in ea country, minimum count 1, max 78(Germany)







