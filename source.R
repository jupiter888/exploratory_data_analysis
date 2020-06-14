#source
library(data.table)
library(ggplot2)
library(leaflet)
library(dplyr)

runoff_info <- readRDS('./data/runoff_eu_info.rds')
runoff_day <- readRDS('./data/runoff_eu_day.rds')
runoff_year <- readRDS('./data/runoff_eu_year.rds')