# objective: create spatial data for Indian Railways
# data from https://data.gov.in/catalog/indian-railways-train-time-table-0
# inspiration http://curiousanalytics.blogspot.com.es/2015/04/indian-railways-network-using-r.html
# inspiration: https://timogrossenbacher.ch/2016/12/beautiful-thematic-maps-with-ggplot2-only/

# clean the workspace
rm(list = ls())

# load packages
library("dplyr")
library("readr")
library("lubridate")
# get and transform data
timetable <- read_csv("data/IndianRailway_train_detail.csv")
# change the column names
names(timetable) <- c("trainNo", "trainName",
                      "islno",
                      "stationCode", "stationName",
                      "arrivalTime",
                      "departureTime", "distance",
                      "sourceStationCode", "sourceStationName",
                      "destStationCode", "destStationName"
                      )
train_timetable <- timetable%>%
  # time as time and no "'" in trainNo
  mutate(arrivalTime = hms(arrivalTime),
         departureTime = hms(departureTime)) %>%
  mutate(hourDeparture = hour(departureTime),
         numDeparture = as.character(departureTime),
         trainNo = gsub("'", "", trainNo)) 

train_timetable <- timetable %>% 
  # Remove 'JN', which represents junction, from station names     
  mutate(sourceStationName = gsub(" JN", "", sourceStationName),
         destStationName = gsub(" JN", "", destStationName),
         stationName = gsub(" JN", "", stationName)) %>%
  # Append "railway India" in station name for acquiring correct geocodes
  mutate(sourceStationName = paste0(sourceStationName, " railway India"),
       destStationName = paste0(destStationName, " railway India"),
       stationName = paste0(stationName, " railway India")) 
  
head(train_timetable)
save(timetable, file = "data/train_timetable.Rdata")
