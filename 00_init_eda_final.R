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
    







station_conts <- runoff_info[, .(Station, Continent) ]
station_conts
station_conts