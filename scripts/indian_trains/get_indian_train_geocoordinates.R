# load data and packages
load("train_data/train_timetable.RData")
library("stringdist")
library("ggmap")
library("dplyr")

# get unique train station names 
listNames <- unique(c(unique(train_timetable$stationName),
                      unique(train_timetable$sourceStationName),
                      unique(train_timetable$destStationName)))


# create a custom function 
#define a function that will process googles server responses for us.


###########################
# get the input data
infile <- "train_detail"
data <- read.csv(paste0('data/', infile, '.csv'))
getGeoDetails <- function(address){   
  #use the gecode function to query google servers
  geo_reply = geocode(address, output='all', messaging=TRUE, override_limit=TRUE)
  #now extract the bits that we need from the returned list
  answer <- data.frame(lat=NA, long=NA, accuracy=NA, formatted_address=NA, address_type=NA, status=NA)
  answer$status <- geo_reply$status
  
  #if we are over the query limit - want to pause for an hour
  while(geo_reply$status == "OVER_QUERY_LIMIT"){
    print("OVER QUERY LIMIT - Pausing for 1 hour at:") 
    time <- Sys.time()
    print(as.character(time))
    Sys.sleep(60*60)
    geo_reply = geocode(address, output='all', messaging=TRUE, override_limit=TRUE)
    answer$status <- geo_reply$status
  }
  
  #return Na's if we didn't get a match:
  if (geo_reply$status != "OK"){
    return(answer)
  }   
  #else, extract what we need from the Google server reply into a dataframe:
  answer$lat <- geo_reply$results[[1]]$geometry$location$lat
  answer$long <- geo_reply$results[[1]]$geometry$location$lng   
  if (length(geo_reply$results[[1]]$types) > 0){
    answer$accuracy <- geo_reply$results[[1]]$types[[1]]
  }
  answer$address_type <- paste(geo_reply$results[[1]]$types, collapse=',')
  answer$formatted_address <- geo_reply$results[[1]]$formatted_address
  
  return(answer)
}

#initialise a dataframe to hold the results
geocoded <- data.frame()
# find out where to start in the address list (if the script was interrupted before):
startindex <- 1
#if a temp file exists - load it up and count the rows!
tempfilename <- paste0(infile, '_temp_geocoded.rds')
if (file.exists(tempfilename)){
  print("Found temp file - resuming from index:")
  geocoded <- readRDS(tempfilename)
  startindex <- nrow(geocoded)
  print(startindex)
}

# Start the geocoding process - address by address. geocode() function takes care of query speed limit.
for (ii in seq(startindex, length(listNames))){
  print(paste("Working on index", ii, "of", length(listNames)))
  #query the google geocoder - this will pause here if we are over the limit.
  result = getGeoDetails(listNames[ii]) 
  print(result$status)     
  result$index <- ii
  #append the answer to the results file.
  geocoded <- rbind(geocoded, result)
  #save temporary results as we are going along
  saveRDS(geocoded, tempfilename)
}


###########################
# Use ggmap geocode function to get the coordinates for train stations
geocord_list1<- listNames[1:2200]
#geocord_list1<- listNames[1:20]
geocord_list2<- listNames[2201:4337]
save(geocord_list1, file="geocord_list1.RData")
save(geocord_list2, file="geocord_list2.RData")

head(geocord_list1)
geoInfo1 <- geocode(geocord_list1)
geoInfo2 <- geocode(geocord_list2)

# create data frame
geoData1 <- data.frame(name = geocord_list1, lat = geoInfo1$lat,long = geoInfo1$long)
geoData2 <- data.frame(name = geocord_list2, lat = geoInfo2$lat,long = geoInfo2$long)

# create a list of names from geoData1 and geoData2
listNames<- rbind(geoData1,geoData2)
# remove railway India and lowercase the strings
listNames <- tbl_df(listNames) %>%
  mutate(name = gsub(" railway India", "", name)) %>%
  mutate(name = tolower(name))
# count missing data in latitute and longitude
sum(is.na(listNames$lat))
sum(is.na(listNames$lon))
